Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DA8C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55CE20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GqqltBA5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GqqltBA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55CE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJCSXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:23:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:23:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C790960C62; Wed,  3 Oct 2018 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566509;
        bh=q8HwYztCvotKOrqEFcstvdFfANwvR5OGFj7Il4/+IVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqqltBA51WMDvB7vknEvRGUsu0nvX0TOEnjHFk+qOx62rP5QsjNOA+rn3IFHBrnss
         h5tVsatsfK7q+a2wJHtHkF0cR6tk5M3D002QgKdSmjTL8sz+KBchspOZAYATfDy1EE
         0NqhAetpU9bs0KxLMrEfYdICQ+gM2jIGBZkIUzos=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8D0460B26;
        Wed,  3 Oct 2018 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566509;
        bh=q8HwYztCvotKOrqEFcstvdFfANwvR5OGFj7Il4/+IVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqqltBA51WMDvB7vknEvRGUsu0nvX0TOEnjHFk+qOx62rP5QsjNOA+rn3IFHBrnss
         h5tVsatsfK7q+a2wJHtHkF0cR6tk5M3D002QgKdSmjTL8sz+KBchspOZAYATfDy1EE
         0NqhAetpU9bs0KxLMrEfYdICQ+gM2jIGBZkIUzos=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8D0460B26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 3/5] rpmsg: Add TIOCMGET/TIOCMSET ioctl support
Date:   Wed,  3 Oct 2018 17:04:21 +0530
Message-Id: <1538566463-24627-4-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
to get/set the low level transport signals.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 54 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 86003d5..c983d6c 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -20,6 +20,7 @@
 #include <linux/rpmsg.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rpmsg.h>
 
@@ -274,15 +275,62 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	return mask;
 }
 
+static int rpmsg_eptdev_tiocmset(struct file *fp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct rpmsg_eptdev *eptdev = fp->private_data;
+	u32 lsigs, rsigs, val;
+	int ret;
+
+	ret = get_user(val, (u32 *)arg);
+	if (ret)
+		return ret;
+
+	ret = rpmsg_get_sigs(eptdev->ept, &lsigs, &rsigs);
+	if (ret < 0)
+		return ret;
+
+	switch (cmd) {
+	case TIOCMBIS:
+		lsigs |= val;
+		break;
+	case TIOCMBIC:
+		lsigs &= ~val;
+		break;
+	case TIOCMSET:
+		lsigs = val;
+		break;
+	}
+
+	ret = rpmsg_set_sigs(eptdev->ept, lsigs);
+	return ret;
+}
+
 static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 			       unsigned long arg)
 {
 	struct rpmsg_eptdev *eptdev = fp->private_data;
+	u32 lsigs, rsigs;
+	int ret;
 
-	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
-		return -EINVAL;
+	switch (cmd) {
+	case TIOCMGET:
+		ret = rpmsg_get_sigs(eptdev->ept, &lsigs, &rsigs);
+		if (!ret)
+			ret = put_user(rsigs, (u32 *)arg);
+		break;
+	case TIOCMSET:
+	case TIOCMBIS:
+	case TIOCMBIC:
+		ret = rpmsg_eptdev_tiocmset(fp, cmd, arg);
+		break;
+	case RPMSG_DESTROY_EPT_IOCTL:
+		ret = rpmsg_eptdev_destroy(&eptdev->dev, NULL);
+	default:
+		ret = -EINVAL;
+	}
 
-	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
+	return ret;
 }
 
 static const struct file_operations rpmsg_eptdev_fops = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

