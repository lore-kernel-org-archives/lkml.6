Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83921C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFED2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeML6GAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBUEBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:01:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38535 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBUEBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:01:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id n125so5786669pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fmc0FktNOAYy91ZtfGNCQgBWKC58zFVetvBTsAojWus=;
        b=XeML6GAJzog9qr8l+qyE21xzSXTnC3ABj0HGTs0BvRp2jNaC+L2wshdZFJfvRSfvdZ
         2tzJt1jYa/bqPbm/FW5eCKxH9xpkGxpEgTrkEBzHLlFNakDKDL6lTImYamzUP3npmxXB
         ItzzpsQ4j4AznRF5je0jiNGgOMEOyez/PMBWN6BhKTBh9HMzhs9IUD4tk8ZIc7oXuA0v
         0umyqRiByQNb4GuJ90SmpzztsGCJYYBteeynuoyRuFH8qIbfsiiGH/0aoosqUntC+fxN
         /nsTBcAIJz6ZnMHgi3L4/1ffCT/ZNC1hDGJla0p+zNQfHxbt4RbLy74pTU/jVDYapOK2
         MSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fmc0FktNOAYy91ZtfGNCQgBWKC58zFVetvBTsAojWus=;
        b=F5I8bWbiqNWTB/2PRB+/XW0Qe+GsGW2IfFEiZnO9Qjc3AdkmCkGljCx/3VVQUcCV3h
         25zMWzUHT68eEHE0zv8+ZTvuSGGG/NA82wQOa6oDaMa7L2mXhjKQEfRcpMHn7DC4qyoX
         vdnFieTeRPrzbKtAv38Z6PtmCJVvGAtI7+DcXL62+UHyPTLEA94VjKJhzDhjuwjAgQCt
         iuYe9sPFTmhLBAQa2/35JRDadBxJhGIkuisrTfFCidy8Zh4F1qv94nZl0lndX6VM2Nxa
         F28AX0DYZnKEsfSKx4+Q6EGJn/NK1rW0Hle7F4/pjxl6yrTpdJ7DmrW93HE/wUNfcCra
         EYYQ==
X-Gm-Message-State: AHQUAubOdymidNClSvKWQV7oWS454W7Vcu2eQEB8FYx0VEEkik8FLnc/
        OmtWXH0noW/k0HC0R6yCpKA=
X-Google-Smtp-Source: AHgI3Iag5XZ3eeaB6/H/+Pi3iZDnLFwCUQRneiOqChDNIzBsDsTWSkGivzLDNQ9Q3dpB3AQaZi4Yug==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr32477993pge.100.1550721711275;
        Wed, 20 Feb 2019 20:01:51 -0800 (PST)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id e9sm48836730pfb.52.2019.02.20.20.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 20:01:50 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] mm/cma_debug: Avoid to use global cma_debugfs_root
Date:   Thu, 21 Feb 2019 12:01:29 +0800
Message-Id: <20190221040130.8940-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently cma_debugfs_root is at global space. That is unnecessary
since it will be only used by next cma_debugfs_add_one(). We can
just pass it to following calling, it will save global space. Also
remove useless idx parameter.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 mm/cma_debug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index f234672..2c2c869 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -21,8 +21,6 @@ struct cma_mem {
 	unsigned long n;
 };
 
-static struct dentry *cma_debugfs_root;
-
 static int cma_debugfs_get(void *data, u64 *val)
 {
 	unsigned long *p = data;
@@ -162,7 +160,7 @@ static int cma_alloc_write(void *data, u64 val)
 }
 DEFINE_SIMPLE_ATTRIBUTE(cma_alloc_fops, NULL, cma_alloc_write, "%llu\n");
 
-static void cma_debugfs_add_one(struct cma *cma, int idx)
+static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 {
 	struct dentry *tmp;
 	char name[16];
@@ -170,7 +168,7 @@ static void cma_debugfs_add_one(struct cma *cma, int idx)
 
 	scnprintf(name, sizeof(name), "cma-%s", cma->name);
 
-	tmp = debugfs_create_dir(name, cma_debugfs_root);
+	tmp = debugfs_create_dir(name, root_dentry);
 
 	debugfs_create_file("alloc", 0200, tmp, cma, &cma_alloc_fops);
 	debugfs_create_file("free", 0200, tmp, cma, &cma_free_fops);
@@ -188,6 +186,7 @@ static void cma_debugfs_add_one(struct cma *cma, int idx)
 
 static int __init cma_debugfs_init(void)
 {
+	struct dentry *cma_debugfs_root;
 	int i;
 
 	cma_debugfs_root = debugfs_create_dir("cma", NULL);
@@ -195,7 +194,7 @@ static int __init cma_debugfs_init(void)
 		return -ENOMEM;
 
 	for (i = 0; i < cma_area_count; i++)
-		cma_debugfs_add_one(&cma_areas[i], i);
+		cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
 
 	return 0;
 }
-- 
1.9.1

