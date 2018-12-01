Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D310DC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A32081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUQZCjS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2A32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLAV0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:26:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39235 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLAV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:26:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4044192pld.6;
        Sat, 01 Dec 2018 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pwgu7dcKj7+zgdlZGBX3dza+UCOo14XguqWZEE9rV+M=;
        b=RUQZCjS4RfROItWHDbjDGHgp3p1FNiY6PXOAmhZlrDsHH5CLzu7Jaa2TVzU/8hCpdg
         UH6SAYSK9Yc2jJU/HM10ba/GfDbzQ7QTFHEytte43vRTfjkJLUigUpGaTtY7OM6VZgYd
         yIru3oVHFzMDdIKICUPbq8oU3vDQSreI6Zj4hqtW1KeuGn/Y0trqpH+B8xNGSgAuZ3+H
         NiETnhLRTkvusL3ckoTu7CkQd7VQ51kwXu0yS3csto2+j398QIgxJqtfDHCc7IIc/hI8
         Bb5aeMDvzbARKdgZH+VSit24uqJpjWhVY7TE33zVekAwrXVc9aQVAENjEHFWWOWmg6oV
         iN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pwgu7dcKj7+zgdlZGBX3dza+UCOo14XguqWZEE9rV+M=;
        b=mZ3l8zZa9KEvWgIklcTThCQfM8PhhsS20Mz8TuCE/zGQlNweZUACLlmJTNg4wcu8+3
         sXFWSvp8d4frlALT3scsjwHcCG2iBFm1kmPMRAeHm7oJ2TTizDwkYnO+ux6/wnkD5iSF
         JBgWJfuJ0WXg6IZXEL0Ou09/3wUwadyKZOz3lfQqM7vYap/cty8E/iOFP2exT2UeUT1R
         1EZIEsZwyABtEWGrH9vXJLfLx+Tcr5fWvqKnnvGJ/WB49FgArUjYMt3rIzt1hcGEV12g
         A2ikywJSSSyP2BxPMNrameKqxCHs9frTgPJA/Ln1cgi7jQlzpQdx2GNWAipIubM73rof
         oD0Q==
X-Gm-Message-State: AA+aEWbZHBosH7tPHpseE+EJ4nh5r3hkrkMPpZEk8Y03vkNRQHpAoX9D
        w3IhoDX/GrZPS0BDf7swjV4=
X-Google-Smtp-Source: AFSGD/VcdM6hxHC9ridHAe8gHWem9NhkOY/c1eHIwAV4v8IBNvT5EnSY2z1DOnoBudkyc5UfTNub0Q==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr8765205plo.133.1543659260479;
        Sat, 01 Dec 2018 02:14:20 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e9sm9716389pff.5.2018.12.01.02.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 02:14:19 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 05:14:17 -0500
Message-Id: <20181201101417.6368-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
 drivers/watchdog/ie6xx_wdt.c    | 16 +++-------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 1462be9e6fc5..4249b47902bd 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -90,7 +90,7 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
 
 #ifdef CONFIG_BCM_KONA_WDT_DEBUG
 
-static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
+static int bcm_kona_show(struct seq_file *s, void *data)
 {
 	int ctl_val, cur_val;
 	unsigned long flags;
@@ -130,17 +130,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bcm_kona_wdt_dbg_show, inode->i_private);
-}
-
-static const struct file_operations bcm_kona_dbg_operations = {
-	.open		= bcm_kona_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bcm_kona);
 
 static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 {
@@ -157,7 +147,7 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 		return;
 
 	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
-				&bcm_kona_dbg_operations))
+				&bcm_kona_fops))
 		wdt->debugfs = dir;
 	else
 		debugfs_remove_recursive(dir);
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 78c2541f5d52..8de9fb1ed371 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -193,7 +193,7 @@ static struct watchdog_device ie6xx_wdt_dev = {
 
 #ifdef CONFIG_DEBUG_FS
 
-static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
+static int ie6xx_wdt_show(struct seq_file *s, void *unused)
 {
 	seq_printf(s, "PV1   = 0x%08x\n",
 		inl(ie6xx_wdt_data.sch_wdtba + PV1));
@@ -212,23 +212,13 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int ie6xx_wdt_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ie6xx_wdt_dbg_show, NULL);
-}
-
-static const struct file_operations ie6xx_wdt_dbg_operations = {
-	.open		= ie6xx_wdt_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ie6xx_wdt);
 
 static void ie6xx_wdt_debugfs_init(void)
 {
 	/* /sys/kernel/debug/ie6xx_wdt */
 	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
-		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_dbg_operations);
+		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_fops);
 }
 
 static void ie6xx_wdt_debugfs_exit(void)
-- 
2.17.0

