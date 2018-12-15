Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D04C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D823206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/oZsmzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeLOIlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:41:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46314 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLOIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:41:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so3797928ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dm2bXgbmpX/ceQ6mZiQfmrP/eexd+tGYTDLvO3GOZ3c=;
        b=d/oZsmzoVQBQZ4IflpuYocEhOxlqSkvX8hwvjTlW90UZS+hhRTDc7AnuvoGLfuPEB2
         s+nmSUTFF9CrAhQKpjetePv+zswcnwtJRAi8yLYHAJBdWOlMFPBocbhzr50WQ6qp/bG5
         UavfN89vnhog8F659O+pviGHl8E0G7MJkAhqGH+/eUhMYyC8pnMWOGocpuwpWLXXJKoh
         IOA94crRrQVsN3WMifSdJCSZRZDz+WxK6W03anljGyd5KJ1afSFPNmEa1dKbS2PxFMvR
         O0sf0DbRxtRnijd1FUNZzMrCE8fTREoOa121cnzOOznVVbKahy5XBikBeNyLYUJD2phQ
         yBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dm2bXgbmpX/ceQ6mZiQfmrP/eexd+tGYTDLvO3GOZ3c=;
        b=Xu6r7qWGVLFMxbWyRb+Zv+g0jxhz+SjurW+VCCrt6rxgtjmFCq0zhGSX5t20UCapMZ
         u//n2gRBWLwV3S/W7xMb/6P78xpzyG3C218IiujpW6irfKxSE3w1J9l4yfs7mqQ2dh5a
         D7gcsJCOL0tb8U9NrIFsl/v6SiJiCsAf8/YiY8scf9U7IfqFOnzyA9BY3mJnwBkx3+23
         Mb4P8sgcTU8cMw22Qx5MPVu9orZCz8JsP2zkU4C8oTgyWjsWVD+qg8WlNOSJMe+/+HZL
         bCfJHJ4Zd0XOiVkAtkL3L2YYFF9gb/qLkAkrrLFAx7ZzuKzngag984k+9HBFu2cdUw7K
         aNhg==
X-Gm-Message-State: AA+aEWaL7Iq2xfTvTmBT51ho6Jr6ADW1Bx0wElfiESh4zw4ngQBmSq4T
        D/dbJL8caqCgkUDmU1RwUhqc1Y4vAeA=
X-Google-Smtp-Source: AFSGD/ViaOylThGAaCy2iNVDeV3GSkjDHjLvDtwaVQLXFcm7AwtfS12K2s6Glv5kjBkHYBFRfYG2Ag==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr5747514plz.110.1544863282311;
        Sat, 15 Dec 2018 00:41:22 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l19sm15462489pfi.71.2018.12.15.00.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:41:21 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] regmap: debugfs: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:41:19 -0500
Message-Id: <20181215084119.27058-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/regmap/regmap-debugfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 87b562e49a43..19eb454f26c3 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -435,17 +435,7 @@ static int regmap_access_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int access_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, regmap_access_show, inode->i_private);
-}
-
-static const struct file_operations regmap_access_fops = {
-	.open		= access_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(regmap_access);
 
 static ssize_t regmap_cache_only_write_file(struct file *file,
 					    const char __user *user_buf,
-- 
2.17.0

