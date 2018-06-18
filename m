Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA05C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4367920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4367920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965716AbeFRIXJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:23:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965687AbeFRIXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED271BAD;
        Mon, 18 Jun 2018 08:23:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 168/279] nvme/multipath: Fix multipath disabled naming collisions
Date:   Mon, 18 Jun 2018 10:12:33 +0200
Message-Id: <20180618080615.774751763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit a785dbccd95c37606c720580714f5a7a8b3255f1 ]

When CONFIG_NVME_MULTIPATH is set, but we're not using nvme to multipath,
namespaces with multiple paths were not creating unique names due to
reusing the same instance number from the namespace's head.

This patch fixes this by falling back to the non-multipath naming method
when the parameter disabled using multipath.

Reported-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c      |   26 +-------------------------
 drivers/nvme/host/multipath.c |   22 ++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |   12 ++++++++++++
 3 files changed, 35 insertions(+), 25 deletions(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2979,31 +2979,7 @@ static void nvme_alloc_ns(struct nvme_ct
 	if (nvme_init_ns_head(ns, nsid, id))
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
-	
-#ifdef CONFIG_NVME_MULTIPATH
-	/*
-	 * If multipathing is enabled we need to always use the subsystem
-	 * instance number for numbering our devices to avoid conflicts
-	 * between subsystems that have multiple controllers and thus use
-	 * the multipath-aware subsystem node and those that have a single
-	 * controller and use the controller node directly.
-	 */
-	if (ns->head->disk) {
-		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
-				ctrl->cntlid, ns->head->instance);
-		flags = GENHD_FL_HIDDEN;
-	} else {
-		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-				ns->head->instance);
-	}
-#else
-	/*
-	 * But without the multipath code enabled, multiple controller per
-	 * subsystems are visible as devices and thus we cannot use the
-	 * subsystem instance.
-	 */
-	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
-#endif
+	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -19,6 +19,28 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+/*
+ * If multipathing is enabled we need to always use the subsystem instance
+ * number for numbering our devices to avoid conflicts between subsystems that
+ * have multiple controllers and thus use the multipath-aware subsystem node
+ * and those that have a single controller and use the controller node
+ * directly.
+ */
+void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
+			struct nvme_ctrl *ctrl, int *flags)
+{
+	if (!multipath) {
+		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
+	} else if (ns->head->disk) {
+		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
+				ctrl->cntlid, ns->head->instance);
+		*flags = GENHD_FL_HIDDEN;
+	} else {
+		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
+				ns->head->instance);
+	}
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,8 @@ extern const struct attribute_group nvme
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
+void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
+			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
 bool nvme_req_needs_failover(struct request *req, blk_status_t error);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
@@ -436,6 +438,16 @@ static inline void nvme_mpath_check_last
 }
 
 #else
+/*
+ * Without the multipath code enabled, multiple controller per subsystems are
+ * visible as devices and thus we cannot use the subsystem instance.
+ */
+static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
+				      struct nvme_ctrl *ctrl, int *flags)
+{
+	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
+}
+
 static inline void nvme_failover_req(struct request *req)
 {
 }


