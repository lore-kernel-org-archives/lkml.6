Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1652070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tA43GiiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfBRVnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:43:18 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:54768 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfBRVnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:43:17 -0500
Received: by mail-yw1-f73.google.com with SMTP id y133so11821474ywa.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nczg+7QUtes2Fh3C29CPunHu3OPe6LiRWzK630XjV4w=;
        b=tA43GiiSLoJGWxf2igP3CH2mgYlDyKliVemoFw5JVnpvlNYCKg3RdeT7ytpL74DuEG
         GiXHe3kuSFhEeVcRVbpoixWPO7GcDWmD65EZLNyIZkjD7TnOCTUFSL2Mp78Ss5nh5tLk
         W7BpoALQ4YESMpoG5WvyI3J3Rk7pDDlSNutM8Ol1iAtG8XF146LBaKxSld5MRUwIFbcm
         BBCjD91Q09bgWQx60dGwoP1iy4NY0jEXQfpSj5bCgJHnmdCDe7po9xlTTRw4EL2MZLD8
         t5nL/DfUIBY6IExgHOb9UgDUKL/eJVpan3hjx6cVESa5CMM2/I7VQpzz51b3ORAzKe/C
         Ey2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nczg+7QUtes2Fh3C29CPunHu3OPe6LiRWzK630XjV4w=;
        b=sLckI8vS6NJgA+m1hBwsu1seBDEg5Wy2iSYVKZRBbS61HHemOthVUzdd0Kg87L3SK1
         hcMVNATlZDPQHLMxD6Rk3y68gst9r5xPa721GkECpNUuolxEM+dnJUPUCiDboUKk3Bkx
         AsFbe7y3bR+Wa2VTXwk/cBEZxYLuSXcoAkF3D6yJhM81+mdl/4iqGvfDVZJ5Ozvlhqzb
         zSo6GAKMWeIPbPrfqrOKRMI+8Vk+ZCHXZc/nDFpGPypOzhhoqsNnMQv2C6dE/M8FhvK1
         WZpzndffRPnQ6D4Vd2lu2qis0v44JMmkDsRKX5owuCsGB/TMDNiWb+CieZeWHsrMds48
         Ttxg==
X-Gm-Message-State: AHQUAuZnEMfcCx6QsZhdWi07SpVfPyVDCldXvhHga5yWa2MOGxS5YlKl
        PZdrm9Wmi8ybq2+RrCYHm//HZI8jIw==
X-Google-Smtp-Source: AHgI3IbA7cgyVHRbhKFdKSJfO5KKFkvEQERB0U2tMu97Jn4k3vnlX28TAaUiou6zNuly4Ulh0x5EqqZAUg==
X-Received: by 2002:a25:2acd:: with SMTP id q196mr11133435ybq.57.1550526196177;
 Mon, 18 Feb 2019 13:43:16 -0800 (PST)
Date:   Mon, 18 Feb 2019 22:43:09 +0100
Message-Id: <20190218214309.29985-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] firmware: xilinx: fix debugfs write handler
From:   Jann Horn <jannh@google.com>
To:     Michal Simek <michal.simek@xilinx.com>, jannh@google.com
Cc:     Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Userspace wants to write a string with `len` bytes, not counting the
   terminating NULL, so we should allocate `len+1` bytes. It looks like the
   current code relied on having a nullbyte directly behind `kern_buff`,
   which happens to work reliably as long as `len` isn't one of the kmalloc
   size classes.
 - strncpy_from_user() is completely wrong here; userspace is giving us a
   (not necessarily null-terminated) buffer and its length.
   strncpy_from_user() is for cases in which we don't know the length.
 - Don't let broken userspace allocate arbitrarily big kmalloc allocations.

Just use memdup_user_nul(), which is designed precisely for things like
this.

Signed-off-by: Jann Horn <jannh@google.com>
---
WARNING: completely untested patch

drivers/firmware/xilinx/zynqmp-debug.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 2771df6df379..90b66cdbfd58 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -163,21 +163,14 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
 
 	strcpy(debugfs_buf, "");
 
-	if (*off != 0 || len == 0)
+	if (*off != 0 || len <= 1 || len > PAGE_SIZE - 1)
 		return -EINVAL;
 
-	kern_buff = kzalloc(len, GFP_KERNEL);
-	if (!kern_buff)
-		return -ENOMEM;
-
+	kern_buff = memdup_user_nul(ptr, len);
+	if (IS_ERR(kern_buff))
+		return PTR_ERR(kern_buff);
 	tmp_buff = kern_buff;
 
-	ret = strncpy_from_user(kern_buff, ptr, len);
-	if (ret < 0) {
-		ret = -EFAULT;
-		goto err;
-	}
-
 	/* Read the API name from a user request */
 	pm_api_req = strsep(&kern_buff, " ");
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

