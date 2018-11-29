Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCBD21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omlg7Nu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCBD21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeK2RCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeK2RCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:18 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A6121019;
        Thu, 29 Nov 2018 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471087;
        bh=tBMs69/cmdld//vtpjocH8W0R5bg8WAP6Sx1/f0ANV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Omlg7Nu9ocs+qUlWc/V04Y4NkdMj74IpRmI++TV+ukqWz6F+51TQm7z0yjLye4g5x
         K7QPsJ8MpiXWkQdhfpWNs1q+WoizdboibHeE+3gc2pjiPJtmC8NlNyIftpTXN9917A
         StpNyED1mWaecfaSkaJlr0sxz9LJmPBDVWWfmEDY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 25/68] nvme-fc: resolve io failures during connect
Date:   Thu, 29 Nov 2018 00:55:16 -0500
Message-Id: <20181129055559.159228-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 4cff280a5fccf6513ed9e895bb3a4e7ad8b0cedc ]

If an io error occurs on an io issued while connecting, recovery
of the io falls flat as the state checking ends up nooping the error
handler.

Create an err_work work item that is scheduled upon an io error while
connecting. The work thread terminates all io on all queues and marks
the queues as not connected.  The termination of the io will return
back to the callee, which will then back out of the connection attempt
and will reschedule, if possible, the connection attempt.

The changes:
- in case there are several commands hitting the error handler, a
  state flag is kept so that the error work is only scheduled once,
  on the first error. The subsequent errors can be ignored.
- The calling sequence to stop keep alive and terminate the queues
  and their io is lifted from the reset routine. Made a small
  service routine used by both reset and err_work.
- During debugging, found that the teardown path can reference
  an uninitialized pointer, resulting in a NULL pointer oops.
  The aen_ops weren't initialized yet. Add validation on their
  initialization before calling the teardown routine.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 73 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 611e70cae754..9375fa705d82 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -144,6 +144,7 @@ struct nvme_fc_ctrl {
 
 	bool			ioq_live;
 	bool			assoc_active;
+	atomic_t		err_work_active;
 	u64			association_id;
 
 	struct list_head	ctrl_list;	/* rport->ctrl_list */
@@ -152,6 +153,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct delayed_work	connect_work;
+	struct work_struct	err_work;
 
 	struct kref		ref;
 	u32			flags;
@@ -1523,6 +1525,10 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
 	struct nvme_fc_fcp_op *aen_op = ctrl->aen_ops;
 	int i;
 
+	/* ensure we've initialized the ops once */
+	if (!(aen_op->flags & FCOP_FLAGS_AEN))
+		return;
+
 	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++)
 		__nvme_fc_abort_op(ctrl, aen_op);
 }
@@ -2036,7 +2042,25 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
 static void
 nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
-	/* only proceed if in LIVE state - e.g. on first error */
+	int active;
+
+	/*
+	 * if an error (io timeout, etc) while (re)connecting,
+	 * it's an error on creating the new association.
+	 * Start the error recovery thread if it hasn't already
+	 * been started. It is expected there could be multiple
+	 * ios hitting this path before things are cleaned up.
+	 */
+	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
+		active = atomic_xchg(&ctrl->err_work_active, 1);
+		if (!active && !schedule_work(&ctrl->err_work)) {
+			atomic_set(&ctrl->err_work_active, 0);
+			WARN_ON(1);
+		}
+		return;
+	}
+
+	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
 	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
 		return;
 
@@ -2802,6 +2826,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -2854,23 +2879,30 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 }
 
 static void
-nvme_fc_reset_ctrl_work(struct work_struct *work)
+__nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
 {
-	struct nvme_fc_ctrl *ctrl =
-		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
-	int ret;
-
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_keep_alive(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
+	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
 			"to CONNECTING\n", ctrl->cnum);
-		return;
-	}
+}
+
+static void
+nvme_fc_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *ctrl =
+		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
+	int ret;
+
+	__nvme_fc_terminate_io(ctrl);
+
+	nvme_stop_ctrl(&ctrl->ctrl);
 
 	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
 		ret = nvme_fc_create_association(ctrl);
@@ -2885,6 +2917,24 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 			ctrl->cnum);
 }
 
+static void
+nvme_fc_connect_err_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *ctrl =
+			container_of(work, struct nvme_fc_ctrl, err_work);
+
+	__nvme_fc_terminate_io(ctrl);
+
+	atomic_set(&ctrl->err_work_active, 0);
+
+	/*
+	 * Rescheduling the connection after recovering
+	 * from the io error is left to the reconnect work
+	 * item, which is what should have stalled waiting on
+	 * the io that had the error that scheduled this work.
+	 */
+}
+
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
 	.module			= THIS_MODULE,
@@ -2995,6 +3045,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->cnum = idx;
 	ctrl->ioq_live = false;
 	ctrl->assoc_active = false;
+	atomic_set(&ctrl->err_work_active, 0);
 	init_waitqueue_head(&ctrl->ioabort_wait);
 
 	get_device(ctrl->dev);
@@ -3002,6 +3053,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_WORK(&ctrl->err_work, nvme_fc_connect_err_work);
 	spin_lock_init(&ctrl->lock);
 
 	/* io queue count */
@@ -3092,6 +3144,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 fail_ctrl:
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
+	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
 	ctrl->ctrl.opts = NULL;
-- 
2.17.1

