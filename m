Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F10C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED73B208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KdQGJHmw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fmpxbXKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED73B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeJEN5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:57:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbeJEN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:57:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E02C60C7B; Fri,  5 Oct 2018 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538722803;
        bh=QJbIGu+kmKIm+du8PqoXdJzj7PcyaPmUQ8G86Qvqv34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdQGJHmwtI5Z4KATVbGTbOEwdX2skfUy7/K2l1tipyf482j+T2lcvhL9/7tGNWPbk
         niJiQEuXw1d37fQtC4ZhDOJWbdMbkEGqFVddrTyZLsjfX6n75UMOBgIXpjYx1qUrNs
         c2Juh/ublul9h0nJUPd883Ze/GmZXPEk4qH+KTco=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAF5C60B0D;
        Fri,  5 Oct 2018 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538722802;
        bh=QJbIGu+kmKIm+du8PqoXdJzj7PcyaPmUQ8G86Qvqv34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmpxbXKmxdLe9J0T8wc5kJVjS4bef9Iiz/uIUPaZDthC6GrSMCF3oGG3GG6YG6I9a
         2qfHzYz2D4pQL7EsrjriPL4SfW83LxlBaio50PUVQDQDL0+QWZbpvOn2Z/wubn9ZBJ
         F1XiCibXC30ppdFP4A4r520csna55UIg/aEZRF8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAF5C60B0D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V3 4/4] rpmsg: char: Add signal callback and POLLPRI support
Date:   Fri,  5 Oct 2018 12:29:36 +0530
Message-Id: <1538722776-13648-5-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538722776-13648-1-git-send-email-aneela@codeaurora.org>
References: <1538722776-13648-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a callback to get the signal notifications from rpmsg and
send POLLPRI mask to indicate the signal change in POLL system call.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 16978f7b..a5855f7 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -64,6 +64,7 @@ struct rpmsg_ctrldev {
  * @queue_lock:	synchronization of @queue operations
  * @queue:	incoming message queue
  * @readq:	wait object for incoming queue
+ * @sig_pending:state of signal notification
  */
 struct rpmsg_eptdev {
 	struct device dev;
@@ -78,6 +79,8 @@ struct rpmsg_eptdev {
 	spinlock_t queue_lock;
 	struct sk_buff_head queue;
 	wait_queue_head_t readq;
+
+	bool sig_pending;
 };
 
 static int rpmsg_eptdev_destroy(struct device *dev, void *data)
@@ -122,6 +125,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	return 0;
 }
 
+static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
+			 u32 old, u32 new)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+
+	eptdev->sig_pending = true;
+
+	/* wake up any blocking processes, waiting for signal notification */
+	wake_up_interruptible(&eptdev->readq);
+	return 0;
+}
+
 static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
@@ -138,6 +153,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->sig_cb = rpmsg_sigs_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 
@@ -157,6 +173,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	eptdev->sig_pending = false;
 
 	/* Discard all SKBs */
 	while (!skb_queue_empty(&eptdev->queue)) {
@@ -263,6 +280,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (eptdev->sig_pending)
+		mask |= POLLPRI;
+
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 
 	return mask;
@@ -306,6 +326,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 
 	switch (cmd) {
 	case TIOCMGET:
+		eptdev->sig_pending = false;
 		ret = rpmsg_get_signals(eptdev->ept);
 		if (!ret)
 			ret = put_user(ret, (int __user *)arg);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

