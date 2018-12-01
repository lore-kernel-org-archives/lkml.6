Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44787C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ECD20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmBwRhK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ECD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeLBAz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:55:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:55:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so4205897pfg.1;
        Sat, 01 Dec 2018 05:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dAoqvlCwqXhOdSEBgugD4eaDSHjVf8Xh/TPDYLBseLg=;
        b=PmBwRhK/SQvcULqltvEaUN/aqax9smpP4AtiNIBNT7sFLOmQ6SBibeDfxLROOHRYkk
         letU+MU0T3hxqpflBFM7W9tqj0EMEZfF0DBW97x7oTS65NoD96QtoHT8/xjbDU6XUG6i
         dJKHq25VHdTPIP79vAgYjnDPWAKKpoaOTL5m+8LgTLcDPwTx3gFB6c8sv0FEwUDc9pAJ
         vDifOeykQN8MzUfFVX07mtGFA/pnRCgYMVB0UEh/6i98kKiFl1y/cgCMJ6Q+s23UPT/Y
         d+oe5JBr6Zn93y2IkAdKOhaUd17D7AEN+RT/UKqVtpYKmhgOeJzB1tZ1nXG5xKwtVohE
         Pm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dAoqvlCwqXhOdSEBgugD4eaDSHjVf8Xh/TPDYLBseLg=;
        b=UnVfeOatmH9GLU1G3Zt0rk8NmVBOvFtTzWSuHg9ncQC4PgTHSZlLdDpYGlBB/moJ64
         VqT2Dx8SB/uUohFOGdlkWs2Z03nCniZ4gAjL4Ikz9devNRxmUgnpifdLeQmVY56QBj1y
         C/eXjR9wOrnWStqhYGf0+wKQkF4Jm95ZVIz/z2u7hwk5Vpuxp57HNY33XwHZVp6hlYUK
         kg6WPHcZjVuBbq2euRwxebmKXALPkk79CUJvTBUpr0lHUaPeL9DMc9pcuDDrBQLxwG0y
         LurqJ481mjxjFz28jnq/U2kmu5KFn361sNa1MnJcSIKQx5kd/6J42CFiRJUgjZKJXQ6y
         fizA==
X-Gm-Message-State: AA+aEWYgc0YM80mVdozr93TvOegAEvKFIriMdT2J4IxjuEQfKprH1X29
        k+SyI7Al2soDrpMt8+Dsa23YbWwu0T8=
X-Google-Smtp-Source: AFSGD/UtFmXX+H5q/NaIkRHT3/6DJ7Rs4W/hWb48n25RkD66ZStwnXiC9tyRWoCubp08TYx3SjcrmA==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr6547358pgh.206.1543671803206;
        Sat, 01 Dec 2018 05:43:23 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l3sm12504872pga.92.2018.12.01.05.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 05:43:22 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] sh: intc: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 08:43:20 -0500
Message-Id: <20181201134320.7351-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/sh/intc/virq-debugfs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugfs.c
index 9e62ba9311f0..939915a07d99 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -16,7 +16,7 @@
 #include <linux/debugfs.h>
 #include "internals.h"
 
-static int intc_irq_xlate_debug(struct seq_file *m, void *priv)
+static int intc_irq_xlate_show(struct seq_file *m, void *priv)
 {
 	int i;
 
@@ -37,17 +37,7 @@ static int intc_irq_xlate_debug(struct seq_file *m, void *priv)
 	return 0;
 }
 
-static int intc_irq_xlate_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, intc_irq_xlate_debug, inode->i_private);
-}
-
-static const struct file_operations intc_irq_xlate_fops = {
-	.open = intc_irq_xlate_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(intc_irq_xlate);
 
 static int __init intc_irq_xlate_init(void)
 {
-- 
2.17.0

