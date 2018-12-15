Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1245CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB9F2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DULst49i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeLOJBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:01:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36076 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:01:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so3832331plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 01:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Su8n08XRlyKs97RUCXcwmzT3Jsdm0K6ctXziX1UaMAk=;
        b=DULst49iCyZ7xVT7jW9S4FwmOPcFhWnVvVJWAPIr27fnqvvTS5+Pz1/XjKmOSAMaKL
         1lrBQ8It1XtIMTMICJBecC4fbqJ15Pien5jkQSNvXP6PMN7YyxfMxJlDAOKcwQzGNoWA
         5bVmdmNXHlLJc9aiN1mDbflTbUpQmyxxvlAiBIgFvTGlKzohMU/okAJIlZVllFL0HNRZ
         jryLinBSnuG+Mof/iAVVVftagqWNxBTZuXbK1OyRsx4fojV3OkLqE2H/5hvcMhEjQCRT
         GHfp8rdEThQXhSWqNSTMoOH4qB19bN8sI11rk5QLuB52I+GdYrAS/xIUZ7UZ0CiBQsSe
         iSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Su8n08XRlyKs97RUCXcwmzT3Jsdm0K6ctXziX1UaMAk=;
        b=iUNq8xCB/g+EdRIUwT1pTgrHRzgurRuQ0hDovjXW2696FnpzE80JrTROSVRwWqCXCc
         HOy7EGE1xg6I0eixMVlRKRf7uwULAQ6cT5E5gBuu/8H9+G2/MFxJj1TKI8F6P2PKKjFg
         NRGwDGo1/9bpnJEOJJG3d+w+pqNlCrveeOgvrjixrbwOexA3JgeUnQLmu5D8LQvGXo53
         dPwsp4woBmCdRDe3dC7dB8Wb0nDrqkRLDIzHn9u585hZvvaOmhqtbNX510zwXRZB+hzz
         U8ikXrxtUi+H5Mnb07sA5E7Ud+Qo0fGT9Zi41VZxOmsDYav2j1iTnbTxrlJR/Rh8QqJ9
         Jhyw==
X-Gm-Message-State: AA+aEWZe+iHmuPgMiYGk1Afw+qIhBbwz6uSJ2sxDP/iQ/00Ts3QRI4KR
        baNhH92dgBCNgXJMblyY+84=
X-Google-Smtp-Source: AFSGD/XPldE48M9ROqu+va0waBSk1lhcnhZKtKwK3eJIUlRfqw8beYYSbu5EzBQTwU5Giyp7UpkT1g==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr5929460pld.152.1544864475852;
        Sat, 15 Dec 2018 01:01:15 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id r8sm8170734pgr.48.2018.12.15.01.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 01:01:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, colin.king@canonical.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] staging: vc04_services: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 04:01:13 -0500
Message-Id: <20181215090113.27847-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../interface/vchiq_arm/vchiq_debugfs.c            | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 6a9e71a61142..46ba21967820 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -153,19 +153,7 @@ static int debugfs_usecount_show(struct seq_file *f, void *offset)
 
 	return 0;
 }
-
-static int debugfs_usecount_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_usecount_show, inode->i_private);
-}
-
-static const struct file_operations debugfs_usecount_fops = {
-	.owner		= THIS_MODULE,
-	.open		= debugfs_usecount_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debugfs_usecount);
 
 static int debugfs_trace_show(struct seq_file *f, void *offset)
 {
-- 
2.17.0

