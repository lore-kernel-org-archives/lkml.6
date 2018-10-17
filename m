Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEAECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213B721470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z2oShzKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213B721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJRGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:32:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33743 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeJRGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id l14-v6so17437135edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCzkjxkDgCbRsUV+WAonA400YQUFr0B3q80VTyFoER8=;
        b=Z2oShzKpdYb8DaOpT7Iv7F+CjaNyLqH81ofNDukjoogLK1smSZWOIRnfwZg/PbqKqa
         jxiQ32R6z4ueYsnr03iySlks17dag0+jcHI5+E+7SmE7YFSXOrSkTJI6E0uMHRzeYKWH
         BJyT/6M3yA1QvyiDWckA9yCKBgUi6u3kJiFeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCzkjxkDgCbRsUV+WAonA400YQUFr0B3q80VTyFoER8=;
        b=YdjWOWGMHXgnfBvyvJrlq7KZfbxdXDJs0YQ58JanLwlMGgWRH52D8b0FlY7eFv1P3M
         nxzDC9tQmJRMDppfwqa8Bjc5LonyO6F0pSowH9csu0MzBDNe4ePZmO5Q1Nmt/x9V7OZd
         zjsFyoqeZevYbeZS2Q8rSs7KhMxvggYjh3jZQ1QqnXQmloij376rc7/DFrJswWsCiGjL
         aD/lOCxBM5Z2WImEyGThmD0XVGYjob1U6ItIgBuxK1DK580Xy477VNhnjrwYjITKtofj
         HtSVoARN2XT/KV74uniKI/jicPYb/zvrga6+N3AcV7h70M+uWmw58gdRNqktljiVmxiX
         4MRQ==
X-Gm-Message-State: ABuFfoi5n9NzwlpdG9nMlEr+VO/H0K3KbIExhBm2fUa2Fo67jzrmD2vB
        68ouzUEIf0KU/T1aKuEZQvrI+CeamIA=
X-Google-Smtp-Source: ACcGV61QteUbpBVAx656vLn+flcScmp0oa+/+IayuiYpCR5yJNSGbrr/U6oGODEM/iKCr5gJwUnVtw==
X-Received: by 2002:a50:ae21:: with SMTP id c30-v6mr1721128edd.20.1539815627644;
        Wed, 17 Oct 2018 15:33:47 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:47 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 09/12] fs/inode.c: access inode_cachep via rai_load
Date:   Thu, 18 Oct 2018 00:33:29 +0200
Message-Id: <20181017223332.11964-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a cacheline access to get the value of the inode_cachep
pointer in the places that do a kmem_cache_*(inode_cachep, ...);

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 42f6d25f32a5..f1e9f548494e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -19,6 +19,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/rai.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
@@ -74,7 +75,8 @@ struct inodes_stat_t inodes_stat;
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
 
-static struct kmem_cache *inode_cachep __read_mostly;
+static struct kmem_cache *__inode_cachep __read_mostly;
+#define inode_cachep rai_load(__inode_cachep)
 
 static long get_nr_inodes(void)
 {
@@ -1951,7 +1953,7 @@ void __init inode_init_early(void)
 void __init inode_init(void)
 {
 	/* inode slab cache */
-	inode_cachep = kmem_cache_create("inode_cache",
+	__inode_cachep = kmem_cache_create("inode_cache",
 					 sizeof(struct inode),
 					 0,
 					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
-- 
2.19.1.6.gbde171bbf5

