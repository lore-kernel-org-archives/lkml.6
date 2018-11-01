Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C53C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE1C20866
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE1C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKBIfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:35:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59385 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeKBIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:35:33 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gIMPy-00053v-91; Thu, 01 Nov 2018 23:30:26 +0000
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
Subject: [PATCH v2] nvme: create 'paths' entries for hidden controllers
Date:   Thu,  1 Nov 2018 20:29:55 -0300
Message-Id: <20181101232955.19329-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 Documentation/ABI/testing/sysfs-block-nvme | 10 ++++++++
 drivers/nvme/host/core.c                   |  2 ++
 drivers/nvme/host/multipath.c              | 29 ++++++++++++++++++++--
 drivers/nvme/host/nvme.h                   |  9 +++++++
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-block-nvme

diff --git a/Documentation/ABI/testing/sysfs-block-nvme b/Documentation/ABI/testing/sysfs-block-nvme
new file mode 100644
index 000000000000..3fe51b7be1e1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-nvme
@@ -0,0 +1,10 @@
+What:		/sys/block/nvme*/paths
+Date:		Oct, 2019
+KernelVersion:	v4.21
+Contact:	Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
+Description:
+		This is a directory containing symlinks to other block
+		devices, when the block device is a nvme multipath
+		device.
+Users:		initramfs-tools
+
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e4a30b05bd2..06be47e878f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3115,6 +3115,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
 
 	nvme_mpath_add_disk(ns, id);
+	nvme_mpath_add_disk_links(ns);
 	nvme_fault_inject_init(ns);
 	kfree(id);
 
@@ -3138,6 +3139,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+		nvme_mpath_remove_disk_links(ns);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5e3cc8c59a39..65dabe7d6d7c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -317,9 +317,12 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	if (!head->disk)
 		return;
 
-	if (!(head->disk->flags & GENHD_FL_UP))
+	if (!(head->disk->flags & GENHD_FL_UP)) {
+		struct kobject *hd_kobj = &disk_to_dev(head->disk)->kobj;
 		device_add_disk(&head->subsys->dev, head->disk,
 				nvme_ns_id_attr_groups);
+		head->path_dir = kobject_create_and_add("paths", hd_kobj);
+	}
 
 	if (nvme_path_is_optimized(ns)) {
 		int node, srcu_idx;
@@ -530,6 +533,19 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	}
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
@@ -541,9 +557,19 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
+	kobject_put(head->path_dir);
 	put_disk(head->disk);
 }
 
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	sysfs_remove_link(ns->head->path_dir,
+			kobject_name(&disk_to_dev(ns->disk)->kobj));
+}
+
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
@@ -593,4 +619,3 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
 }
-
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fefba039d1e..6093649d4696 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -287,6 +287,7 @@ struct nvme_ns_head {
 	int			instance;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
+	struct kobject		*path_dir;
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
@@ -471,6 +472,8 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk_links(struct nvme_ns *ns);
+void nvme_mpath_remove_disk_links(struct nvme_ns *ns);
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
@@ -521,6 +524,12 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
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
2.19.1

