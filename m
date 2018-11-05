Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15460C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB09B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpWCC7ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB09B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeKFAQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:16:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46685 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:16:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13-v6so4564330plz.13;
        Mon, 05 Nov 2018 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uStxr/h4+fXYF/rBbung/nYBRU8DWM813TTshXUzqsw=;
        b=GpWCC7ZIe3FbGs93qoF7C1GFRSDz3wWhYWm/nOSW8V0N5wKWFq+4g6m+uiArDFxNBi
         QPd3hSJNeV++eOL3mE3NlAavcvKLbyYzoc+cmbCd8L/4606KOx9rRp+bN/pDvMQJbUW1
         F0HCWcZIhJCoZnSnDiEMTiBVTx0ekeVqI66m21C9I0TfF/R3pjs5VjuIbs1qxpF1NnAs
         6nFk0YP93vK3G1MS6Ym5KsMsAs/MuL1gX9yI/SCNPQwOusxUC8OyIywPFzNaxCS3AFaW
         Y3XHBgll0zvmsbs6H3osPfP1UPwqhB0bHWQrz7GySlDkQiE5s+CElOyq+12GlmdHqAgj
         NycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uStxr/h4+fXYF/rBbung/nYBRU8DWM813TTshXUzqsw=;
        b=hWR/nzcETKCk2cc1ai6tgK+YgYfxRuHej8jHgy/0keo6t28MTk67xfZi7FwGRSv5S7
         5VyWAJBeF2Sxpz6UuQ8QI1WpH2m/klgCO7GOy9B/3E+nOcHB8cn9RPravy0fhHZUNL96
         gnwq9elb7xyigiYZaErAS2RyLmhxsxKvCLX5sTBU8bZeuUXM92Ft+fMAWfEJOB6Vwz2r
         FuEKN4M0iX2c+A7TVZoAWt72paHnsnCg7UoWdXSWI61Prf62csIKHuPu4WTcpAKCsg3H
         tXs70tZC1yI3BB4NvwS1FP91yz/SytALBNL9NKy6Fu3F/JQ8Mq5pd2ZJa8z0um26yte2
         +m6w==
X-Gm-Message-State: AGRZ1gLrDc034iSIRm/nE4p8ftYpQK7FMXL3TNfEajrYsuQRwMliWee6
        1cJTXvs8J3HMfSkJujDPw4ZyJ8g6zOc=
X-Google-Smtp-Source: AJdET5c2ggoVYS/rWyNTyk1Y6Um5XjrsO8LUMfh8HsUbknurApRxl2lDhYw08sObBppNK3tQ3vhhsA==
X-Received: by 2002:a17:902:2909:: with SMTP id g9-v6mr22003586plb.223.1541429785465;
        Mon, 05 Nov 2018 06:56:25 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z9-v6sm19320469pfg.174.2018.11.05.06.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:56:24 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        keescook@chromium.org, gustavo@embeddedor.com, dvlasenk@redhat.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net/bluetooth: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:56:19 -0500
Message-Id: <20181105145619.6395-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 net/bluetooth/l2cap_core.c  | 12 +-----------
 net/bluetooth/rfcomm/core.c | 12 +-----------
 net/bluetooth/rfcomm/sock.c | 12 +-----------
 net/bluetooth/sco.c         | 12 +-----------
 4 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d17a4736e47c..38d92ced5fb5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7615,17 +7615,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 	return 0;
 }
 
-static int l2cap_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, l2cap_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations l2cap_debugfs_fops = {
-	.open		= l2cap_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(l2cap_debugfs);
 
 static struct dentry *l2cap_debugfs;
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index b98225d65e87..1a635df80643 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2166,17 +2166,7 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 	return 0;
 }
 
-static int rfcomm_dlc_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rfcomm_dlc_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations rfcomm_dlc_debugfs_fops = {
-	.open		= rfcomm_dlc_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rfcomm_dlc_debugfs);
 
 static struct dentry *rfcomm_dlc_debugfs;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index d606e9212291..aa0db1d1bd9b 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1020,17 +1020,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 	return 0;
 }
 
-static int rfcomm_sock_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rfcomm_sock_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations rfcomm_sock_debugfs_fops = {
-	.open		= rfcomm_sock_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rfcomm_sock_debugfs);
 
 static struct dentry *rfcomm_sock_debugfs;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8f0f9279eac9..529b38996d8b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1173,17 +1173,7 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 	return 0;
 }
 
-static int sco_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sco_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations sco_debugfs_fops = {
-	.open		= sco_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(sco_debugfs);
 
 static struct dentry *sco_debugfs;
 
-- 
2.17.0

