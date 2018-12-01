Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A5C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4077F206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMuJuL8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4077F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLANcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:32:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46921 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLANcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:32:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so3257617pgp.13;
        Fri, 30 Nov 2018 18:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yhnU2Z5njb1rYvI/MQIrvoG/s15QNOAphdQe97zPFLU=;
        b=AMuJuL8E97/MzQqxoScrAlqrmmF1/NuZ+uKSGwUw67xjGqTnGfKw07899/SnkGJPfj
         p5C2ax8eORFpSQ0W4LuuVLmDRfqbR8Sd9uj/XXfeEOmiX4sPkoH1TskqDTMo74+3dUyl
         tmr5qIAfwL/SI+n7D4usbZzuHPj7mQQHKElvOCWojv+GYAbFfVv99V6xh/wUCEG48xF3
         kN6jdq1Mu8KaaxdRSvgNSldQ1Ti7XPIGWkSJ9E+UjiPBOcwdaPl4FzlErqD2Tm+GXKBK
         XNM0OM2+jlJxgQSKNEBcoCHBDh4WJxRnwN6x6EeBi1mOUn0++txtoCPmDmgulkTwGkLB
         /IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yhnU2Z5njb1rYvI/MQIrvoG/s15QNOAphdQe97zPFLU=;
        b=peNKWM0//bIW3pozPaKhLB80EAI6+Ra0uRxbSrXJY5MDsXhao50IPNOJeufhgYN3nw
         ukd+cMW6bDbzfV4OFX6OEQyYpwvP1VdkoeYLwB5Ro23K9HLoOu5ubGVlTX7kqFWVCJPI
         9dB9mVrEaNX2cdgxNPb9efRTdrwX2j1WjRS/EXt5dhMz+AqpHzFRofca5p6SMPLr9W31
         rxyGtivhBKQPE/dTpzEvTutVrCGUeJ7cy9/89CelUG/bYPcxIFg5zlCceLgGqOZyUBr0
         iZpUrW1xzMS2hb5X4YWxdI7nKVWdCLxYMGQavJENZNfARiADnyqtll24DFkekUKXkF8m
         gnpg==
X-Gm-Message-State: AA+aEWanWzUG5hKA2+U1zTToyT1IuHy4P0bf3jvS8yLc++ASUzwFE0SN
        JAsx0IvNqnEme2kMvR327jSGIzrT8qM=
X-Google-Smtp-Source: AFSGD/VxCbjrEeI0f76rHbBjfoQKTnxyZDvCghkrXH3wphYTF171qfmXCZYG8JcG+Uo0ZuSEW/UpOw==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr6800112pgp.263.1543630855251;
        Fri, 30 Nov 2018 18:20:55 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 202sm12447986pfy.87.2018.11.30.18.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:20:54 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ide: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 21:20:48 -0500
Message-Id: <20181201022048.5106-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ide/ide-proc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 45c997430332..4c8c7a620d08 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -614,18 +614,7 @@ static int ide_drivers_show(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int ide_drivers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, &ide_drivers_show, NULL);
-}
-
-static const struct file_operations ide_drivers_operations = {
-	.owner		= THIS_MODULE,
-	.open		= ide_drivers_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ide_drivers);
 
 void proc_ide_create(void)
 {
@@ -634,7 +623,7 @@ void proc_ide_create(void)
 	if (!proc_ide_root)
 		return;
 
-	proc_create("drivers", 0, proc_ide_root, &ide_drivers_operations);
+	proc_create("drivers", 0, proc_ide_root, &ide_drivers_fops);
 }
 
 void proc_ide_destroy(void)
-- 
2.17.0

