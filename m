Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6157E208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6157E208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbeHWMcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:32:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732985AbeHWMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2B04C83;
        Thu, 23 Aug 2018 09:03:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 275/324] nvme: ensure forward progress during Admin passthru
Date:   Thu, 23 Aug 2018 09:55:41 +0200
Message-Id: <20180823075009.706876642@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Bauer <scott.bauer@intel.com>

[ Upstream commit cf39a6bc342b980f10f344d88035829638a89a48 ]

If the controller supports effects and goes down during the passthru admin
command we will deadlock during namespace revalidation.

[  363.488275] INFO: task kworker/u16:5:231 blocked for more than 120 seconds.
[  363.488290]       Not tainted 4.17.0+ #2
[  363.488296] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  363.488303] kworker/u16:5   D    0   231      2 0x80000000
[  363.488331] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[  363.488338] Call Trace:
[  363.488385]  schedule+0x75/0x190
[  363.488396]  rwsem_down_read_failed+0x1c3/0x2f0
[  363.488481]  call_rwsem_down_read_failed+0x14/0x30
[  363.488504]  down_read+0x1d/0x80
[  363.488523]  nvme_stop_queues+0x1e/0xa0 [nvme_core]
[  363.488536]  nvme_dev_disable+0xae4/0x1620 [nvme]
[  363.488614]  nvme_reset_work+0xd1e/0x49d9 [nvme]
[  363.488911]  process_one_work+0x81a/0x1400
[  363.488934]  worker_thread+0x87/0xe80
[  363.488955]  kthread+0x2db/0x390
[  363.488977]  ret_from_fork+0x35/0x40

Fixes: 84fef62d135b6 ("nvme: check admin passthru command effects")
Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Reviewed-by: Keith Busch <keith.busch@linux.intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |   50 ++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -100,6 +100,22 @@ static struct class *nvme_subsys_class;
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
+static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
+					   unsigned nsid);
+
+static void nvme_set_queue_dying(struct nvme_ns *ns)
+{
+	/*
+	 * Revalidating a dead namespace sets capacity to 0. This will end
+	 * buffered writers dirtying pages that can't be synced.
+	 */
+	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+		return;
+	revalidate_disk(ns->disk);
+	blk_set_queue_dying(ns->queue);
+	/* Forcibly unquiesce queues to avoid blocking dispatch */
+	blk_mq_unquiesce_queue(ns->queue);
+}
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1130,19 +1146,15 @@ static u32 nvme_passthru_start(struct nv
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(rm_list);
+	struct nvme_ns *ns;
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
-			list_move_tail(&ns->list, &rm_list);
-		}
-	}
-	up_write(&ctrl->namespaces_rwsem);
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		if (ns->disk && nvme_revalidate_disk(ns->disk))
+			nvme_set_queue_dying(ns);
+	up_read(&ctrl->namespaces_rwsem);
 
-	list_for_each_entry_safe(ns, next, &rm_list, list)
-		nvme_ns_remove(ns);
+	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -3110,7 +3122,7 @@ static void nvme_remove_invalid_namespac
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
+		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
@@ -3488,19 +3500,9 @@ void nvme_kill_queues(struct nvme_ctrl *
 	if (ctrl->admin_q)
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		/*
-		 * Revalidating a dead namespace sets capacity to 0. This will
-		 * end buffered writers dirtying pages that can't be synced.
-		 */
-		if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-			continue;
-		revalidate_disk(ns->disk);
-		blk_set_queue_dying(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_set_queue_dying(ns);
 
-		/* Forcibly unquiesce queues to avoid blocking dispatch */
-		blk_mq_unquiesce_queue(ns->queue);
-	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);


