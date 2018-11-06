Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092DFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B0F2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udRw1Cif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B0F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbeKGAGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:06:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46706 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbeKGAGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:06:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so6184923pfb.13;
        Tue, 06 Nov 2018 06:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HVzdZebaKbRoghaWt1x7uf/1sEkZN5psraICj9zOI5g=;
        b=udRw1CifNM/6ut/aUYxcH5/XjdUmnxoDnAfWO6gnBY4vxn/cLjor7A3+I4x/AJcS7m
         BdzBlb78A4A0LllWHdEcQjTlJCZEL5OWqm8LZNzJUrGIdNVC+aK4wMRGXZ9NQKGNRP3B
         Nwjd13bGgFxr018SSrrDtXVIl/iQmhQl6E12pnwQ9K7Bg5aB/YDI3RjWFQP/OqDlYiiB
         Us0ss71oXjxfIYfCipM9GgwILEbukqq+aM767JonPRMI0kxrHQ7BgfXp1fYOdXJsSaJv
         nFhj7OOXId+lWkLLaoenLKMtg3oVbbqzh8ngDRAC83/U8ror5ye2C+9QK/JAtojYxi7X
         WF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HVzdZebaKbRoghaWt1x7uf/1sEkZN5psraICj9zOI5g=;
        b=GSkOq/0SDWkhTSfWISVNbHoXAowfDkKym6gK7LJqBr0ncsKqGdiDzT0yHj2snZnbdx
         XE9XEb+QSguirw7Ths3Xp/hxT2C3a6HE8LBxVTbx4f95hblCVIaEvxR57nX3cqoocfyP
         RR6iCj4Z7U3XwdwV3DjoS5E0G48cdVyaRvPDXoZ72esbBj5avXg221uq5T/+hu+HEc7B
         Cj6HAQ0pRKQZuj4/CryEn94wbair0d0INO4UCGvepJYX3qFrLqEEJzCGpXOs3lUhJgc2
         Z9rJRjnovNNxfqChnyT89ExgXiZA+bP/f1wx8tUrSTTPMtOLbApRgXWvYKwxs25/vxO8
         1OpA==
X-Gm-Message-State: AGRZ1gLOwMhHE0MyIH8NRCgMzO905p5XKCkHI7tLgmvI2yftFMDddo0U
        fENZ/orUA0A+q+PXlal7A0PKrOjvcpI=
X-Google-Smtp-Source: AJdET5flhjaAEq3BShrzwmtYyn/gIeIFNZB5yt+hhsk2nEDxtQ1O3fkLlgzpf3XWYkwXbJwtqAyHtg==
X-Received: by 2002:a62:f599:: with SMTP id b25-v6mr26879274pfm.253.1541515232681;
        Tue, 06 Nov 2018 06:40:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id r1-v6sm64020646pfb.41.2018.11.06.06.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:40:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] sh: mm: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:40:30 -0500
Message-Id: <20181106144030.8663-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/sh/mm/asids-debugfs.c | 15 ++-------------
 arch/sh/mm/cache-debugfs.c | 15 ++-------------
 arch/sh/mm/tlb-debugfs.c   | 15 ++-------------
 3 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index e5539e0f8e3b..a3cfa04543e4 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -26,7 +26,7 @@
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 
-static int asids_seq_show(struct seq_file *file, void *iter)
+static int asids_debugfs_show(struct seq_file *file, void *iter)
 {
 	struct task_struct *p;
 
@@ -48,18 +48,7 @@ static int asids_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int asids_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, asids_seq_show, inode->i_private);
-}
-
-static const struct file_operations asids_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= asids_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(asids_debugfs);
 
 static int __init asids_debugfs_init(void)
 {
diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 4eb9d43578b4..08420371af97 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -22,7 +22,7 @@ enum cache_type {
 	CACHE_TYPE_UNIFIED,
 };
 
-static int cache_seq_show(struct seq_file *file, void *iter)
+static int cache_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int cache_type = (unsigned int)file->private;
 	struct cache_info *cache;
@@ -94,18 +94,7 @@ static int cache_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int cache_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cache_seq_show, inode->i_private);
-}
-
-static const struct file_operations cache_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= cache_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(cache_debugfs);
 
 static int __init cache_debugfs_init(void)
 {
diff --git a/arch/sh/mm/tlb-debugfs.c b/arch/sh/mm/tlb-debugfs.c
index dea637a09246..74c252ed35fc 100644
--- a/arch/sh/mm/tlb-debugfs.c
+++ b/arch/sh/mm/tlb-debugfs.c
@@ -36,7 +36,7 @@ static struct {
 	{ 0xc, " 64MB" },
 };
 
-static int tlb_seq_show(struct seq_file *file, void *iter)
+static int tlb_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int tlb_type = (unsigned int)file->private;
 	unsigned long addr1, addr2, data1, data2;
@@ -134,18 +134,7 @@ static int tlb_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int tlb_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tlb_seq_show, inode->i_private);
-}
-
-static const struct file_operations tlb_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= tlb_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tlb_debugfs);
 
 static int __init tlb_debugfs_init(void)
 {
-- 
2.17.0

