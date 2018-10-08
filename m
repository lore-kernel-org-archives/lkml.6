Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A53C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17AD2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lb65FHMT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l/yfrlEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJHNto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:49:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeJHNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:49:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 923FB60C84; Mon,  8 Oct 2018 06:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538980774;
        bh=PTVOuTrf2bkNZanM8+mAvafmGFCAPey4uDCYikEK2lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lb65FHMTgWbLSPG8fjTVFs7N2Co9/XHOwYDd+JdtHkHyFk+VXafo9li11AijnjrHU
         0PgXTW0CnsTN9olDcsvBQblqcfZqjakNICTPPvvZVOxidU4ZDTkRFqDf5Qi4sRv77J
         I4hiYRmuEw/wK36LaTwgWw7+4OBdZkzk6mwwfJEw=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBC8E60C84;
        Mon,  8 Oct 2018 06:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538980773;
        bh=PTVOuTrf2bkNZanM8+mAvafmGFCAPey4uDCYikEK2lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/yfrlEaAYoPvfTvYVXBTwRYHu+BNWuBREZ3CQZexPdUWYSqJkjHmx0sKAYKcCP1m
         p/j8VRfjQtvvGM71bR2YeX9XJlz7CkfAK4gxozH5ObUEQHyRKdg6TvKo73l3BgFbHO
         OrQZdQeSEmAloq7Kmw7Y4Br+whiuw8anZjMzv8sg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBC8E60C84
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 3/4] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Date:   Mon,  8 Oct 2018 12:08:17 +0530
Message-Id: <1538980699-21516-4-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
References: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
to get/set the low level transport signals.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 53 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index a76b963..b136684 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2018, The Linux Foundation.
  * Copyright (c) 2016, Linaro Ltd.
  * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
  * Copyright (c) 2012, PetaLogix
@@ -19,6 +20,7 @@
 #include <linux/rpmsg.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rpmsg.h>
 
@@ -266,15 +268,60 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	return mask;
 }
 
+static int rpmsg_eptdev_tiocmset(struct file *fp, unsigned int cmd,
+				 int __user *arg)
+{
+	struct rpmsg_eptdev *eptdev = fp->private_data;
+	u32 set, clear, val;
+	int ret;
+
+	ret = get_user(val, arg);
+	if (ret)
+		return ret;
+	set = clear = 0;
+	switch (cmd) {
+	case TIOCMBIS:
+		set = val;
+		break;
+	case TIOCMBIC:
+		clear = val;
+		break;
+	case TIOCMSET:
+		set = val;
+		clear = ~val;
+		break;
+	}
+
+	set &= TIOCM_DTR | TIOCM_RTS | TIOCM_CD | TIOCM_RI;
+	clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_CD | TIOCM_RI;
+
+	return rpmsg_set_signals(eptdev->ept, set, clear);
+}
+
 static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 			       unsigned long arg)
 {
 	struct rpmsg_eptdev *eptdev = fp->private_data;
+	int ret;
 
-	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
-		return -EINVAL;
+	switch (cmd) {
+	case TIOCMGET:
+		ret = rpmsg_get_signals(eptdev->ept);
+		if (ret >= 0)
+			ret = put_user(ret, (int __user *)arg);
+		break;
+	case TIOCMSET:
+	case TIOCMBIS:
+	case TIOCMBIC:
+		ret = rpmsg_eptdev_tiocmset(fp, cmd, (int __user *)arg);
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

