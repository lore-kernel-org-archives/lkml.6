Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AA420652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jlq5Eoho";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WXfjZpLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AA420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJDUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:34:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:34:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B72960C87; Thu,  4 Oct 2018 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538660448;
        bh=Z/w2FwMWEx6h/lpCzvRLbqrpyG+YBx6cri+tPB+026w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jlq5EohoC9atxlZbqNq/tj236rnmpUv3PZ1xnOb3qRPQqCMRmpk5VvfWlEu9sClpB
         3a1Cvg2QIT7ZOf0uZHTAAXnpJdPCXgYax31vP1cmblsBVE+Frig102Wt63uguqSVFz
         mWapnjN5zYGk/5VI/px70Zj+3eysgOSevu6htgTA=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2358860C8C;
        Thu,  4 Oct 2018 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538660447;
        bh=Z/w2FwMWEx6h/lpCzvRLbqrpyG+YBx6cri+tPB+026w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXfjZpLgCrPyO3CKw/TnKL0tLuS99jTHke0+L3bUSR0Jw0/nqH//ac9CwqFykeD/l
         1V3yZQ1wRxarEPsbn+KW2O19Ws5ueb0h3qUOI5S4fYVyy4POoqQfqku4wfhzyphFap
         yIdzj40GSMVP9hhxevJuYe71c07Q8nuFcYvGZUNU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2358860C8C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V2 4/4] rpmsg: char: Add signal callback and POLLPRI support
Date:   Thu,  4 Oct 2018 19:10:20 +0530
Message-Id: <1538660420-27797-5-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538660420-27797-1-git-send-email-aneela@codeaurora.org>
References: <1538660420-27797-1-git-send-email-aneela@codeaurora.org>
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
index 9380c6e..194d54a 100644
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
@@ -307,6 +327,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 
 	switch (cmd) {
 	case TIOCMGET:
+		eptdev->sig_pending = false;
 		ret = rpmsg_get_signals(eptdev->ept, &lsigs, &rsigs);
 		if (!ret)
 			ret = put_user(rsigs, (int __user *)arg);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

