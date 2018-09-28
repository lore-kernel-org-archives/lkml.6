Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FABC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67188206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67188206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeI2BnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:43:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55058 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2BnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:43:17 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1g5yH3-00005G-W3; Fri, 28 Sep 2018 19:18:02 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] nvme: create 'paths' entries for hidden controllers
Date:   Fri, 28 Sep 2018 16:17:20 -0300
Message-Id: <20180928191720.3461-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using initramfs-tools with only the necessary dependencies to mount
the root filesystem, it will fail to include nvme drivers for a root on a
multipath nvme. That happens because the slaves relationship is not
present.

As discussed in [1], using slaves will break lsblk, because the slaves are
hidden from userspace, that is, they have no real block device, just an
entry under sysfs.

Introducing the paths subdir and using that on initramfs-tools makes it
possible to now boot a system with nvme multipath as root.

[1] https://www.spinics.net/lists/stable/msg222779.html

Cc: Christoph Hellwig <hch@lst.de>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 28 ++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  9 +++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 456d37a02ea3..6958e8cab92c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3056,6 +3056,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 			ns->disk->disk_name);
 
 	nvme_mpath_add_disk(ns->head);
+	nvme_mpath_add_disk_links(ns);
 	nvme_fault_inject_init(ns);
 	return;
  out_unlink_ns:
@@ -3077,6 +3078,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
 		if (ns->ndev)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 348aa405b641..70a4a0611550 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,15 +220,29 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 
 	mutex_lock(&head->subsys->lock);
 	if (!(head->disk->flags & GENHD_FL_UP)) {
+		struct kobject *hd_kobj = &disk_to_dev(head->disk)->kobj;
 		device_add_disk(&head->subsys->dev, head->disk);
-		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-				&nvme_ns_id_attr_group))
+		head->path_dir = kobject_create_and_add("paths", hd_kobj);
+		if (sysfs_create_group(hd_kobj, &nvme_ns_id_attr_group))
 			pr_warn("%s: failed to create sysfs group for identification\n",
 				head->disk->disk_name);
 	}
 	mutex_unlock(&head->subsys->lock);
 }
 
+void nvme_mpath_add_disk_links(struct nvme_ns *ns)
+{
+	struct kobject *path_disk_kobj;
+
+	if (!ns->head->disk)
+		return;
+
+	path_disk_kobj = &disk_to_dev(ns->disk)->kobj;
+	if (sysfs_create_link(ns->head->path_dir, path_disk_kobj,
+			kobject_name(path_disk_kobj)))
+		return;
+}
+
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
@@ -241,5 +255,15 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
+	kobject_put(head->path_dir);
 	put_disk(head->disk);
 }
+
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	sysfs_remove_link(ns->head->path_dir,
+			kobject_name(&disk_to_dev(ns->disk)->kobj));
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07452adef110..8371f98b657e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -265,6 +265,7 @@ struct nvme_ns_ids {
 struct nvme_ns_head {
 #ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
+	struct kobject		*path_dir;
 	struct nvme_ns __rcu	*current_path;
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
@@ -456,7 +457,9 @@ void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk_links(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
@@ -503,6 +506,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_add_disk_links(struct nvme_ns *ns)
+{
+}
+static inline void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+}
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 }
-- 
2.17.1

