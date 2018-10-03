Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0618C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEB120835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o4VnAVzS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o4VnAVzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEB120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJCSXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:23:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:23:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E5A5760C61; Wed,  3 Oct 2018 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566513;
        bh=gC2IG0VxUhyqhWUNmxbBuPP2lrAm8HvI5UbCxrYTbZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4VnAVzS5WVlr7IblzxjL3/jdOK8RFoF5M5dMCmsO+Z9Aqzb/rhoWx3LjzlK2acY8
         +Hw0h0D5yJ7IHA69W1mMihJhpE4WD0nBLGWds8BlMoci/lJ+AXrhcv4x5uw5/iMWiT
         9UEcOLy7OK8yrfwzq8F16l1F12O0f0y6c7TBv7VE=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64562607BD;
        Wed,  3 Oct 2018 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566513;
        bh=gC2IG0VxUhyqhWUNmxbBuPP2lrAm8HvI5UbCxrYTbZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4VnAVzS5WVlr7IblzxjL3/jdOK8RFoF5M5dMCmsO+Z9Aqzb/rhoWx3LjzlK2acY8
         +Hw0h0D5yJ7IHA69W1mMihJhpE4WD0nBLGWds8BlMoci/lJ+AXrhcv4x5uw5/iMWiT
         9UEcOLy7OK8yrfwzq8F16l1F12O0f0y6c7TBv7VE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64562607BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 4/5] rpmsg: wakeup poll to notify signal update
Date:   Wed,  3 Oct 2018 17:04:22 +0530
Message-Id: <1538566463-24627-5-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to wait on poll to get signal notifications.
Send POLLPRI mask to indicate the signal change.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index c983d6c..aee5561 100644
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
+	atomic_t sig_pending;
 };
 
 static int rpmsg_eptdev_destroy(struct device *dev, void *data)
@@ -125,6 +128,12 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
 			 u32 old, u32 new)
 {
+	struct rpmsg_eptdev *eptdev = priv;
+
+	atomic_set(&eptdev->sig_pending, 1);
+
+	/* wake up any blocking processes, waiting for signal notification */
+	wake_up_interruptible(&eptdev->readq);
 	return 0;
 }
 
@@ -164,6 +173,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	atomic_set(&eptdev->sig_pending, 0);
 
 	/* Discard all SKBs */
 	while (!skb_queue_empty(&eptdev->queue)) {
@@ -270,6 +280,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (atomic_read(&eptdev->sig_pending))
+		mask |= POLLPRI;
+
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 
 	return mask;
@@ -318,6 +331,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 		ret = rpmsg_get_sigs(eptdev->ept, &lsigs, &rsigs);
 		if (!ret)
 			ret = put_user(rsigs, (u32 *)arg);
+		atomic_set(&eptdev->sig_pending, 0);
 		break;
 	case TIOCMSET:
 	case TIOCMBIS:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

