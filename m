Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35043ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EE421477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MDs33Dw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EE421477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJRGbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35682 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJRGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id y19-v6so26409537edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szX5fOJwvrTdOkI09MAw122Wg0mz2i7sdUAeS8MC6qM=;
        b=MDs33Dw+1uWNroo+bxWYK/Q+Tj7yDAurNsHFmsAlv8cCZuk8hq+FLNVVFeDbKLA5m0
         c4sl6re8UG39cDCCBvm3K1TWcKynMFWUbR9MufQmEbIVl1BavNt50U4Ts/mBja0COISk
         wIsqpc4k39IgE8jkLgp27CKOyLAqIaiqlzWHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szX5fOJwvrTdOkI09MAw122Wg0mz2i7sdUAeS8MC6qM=;
        b=nL0Ux+O4WtzAxTtAg420Efe0VoRb5PJ7pDnVpZw9Zg3PrplWE7bSUdO0TSGbwkH735
         6+M625cY79gFf7UoOaykg5pZS/H2/Ql0KXM271KPwUtNfYyMjBoBCs62/ALECRGLCZbE
         xTKdRQgEW8HLcBwIeBIgZd/snaHxRoiPcFSXr8HrFmtlZN/OI3Isl7jP3I5ej8gdYQNl
         H0AhEk9x+2P19lmlVoSy7yqjijrTQQMcc1tL8mPGBV7eYL5vPX9krv9BtnHzqoc1mUe7
         hQwY+dUomvBk3ArUhqCGv/A/UfZmrKnowUInt0i8DxsY4lNFQ+r1ZcmCTkZjCdnE68VC
         8Pfw==
X-Gm-Message-State: ABuFfogKpD76Pn0+RvBOt5zJbj4llt3OYY+Q6pJxk4Ms0oMzbb6CnWst
        1pMO93CPycJigGRpKyq+3Ni1v63cDYY=
X-Google-Smtp-Source: ACcGV61MyLFe1TcozPLbmI9SJBurKwYrg0Lxh6VPhBglhU4arL7FYcUygs7Rr8x1f0b8wyHDhyNlfQ==
X-Received: by 2002:a50:a844:: with SMTP id j62-v6mr1733693edc.132.1539815626671;
        Wed, 17 Oct 2018 15:33:46 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 08/12] fs/dcache.c: access dentry_cache via rai_load
Date:   Thu, 18 Oct 2018 00:33:28 +0200
Message-Id: <20181017223332.11964-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a cacheline access to get the value of the dentry_cache
pointer in the places that do a kmem_cache_*(dentry_cache, ...);

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/dcache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2e7e8d85e9b4..1d54dfb38c9d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -30,6 +30,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/rai.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -76,7 +77,8 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
-static struct kmem_cache *dentry_cache __read_mostly;
+static struct kmem_cache *__dentry_cache __read_mostly;
+#define dentry_cache rai_load(__dentry_cache)
 
 const struct qstr empty_name = QSTR_INIT("", 0);
 EXPORT_SYMBOL(empty_name);
@@ -3088,7 +3090,7 @@ static void __init dcache_init(void)
 	 * but it is probably not worth it because of the cache nature
 	 * of the dcache.
 	 */
-	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
+	__dentry_cache = KMEM_CACHE_USERCOPY(dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
 		d_iname);
 
-- 
2.19.1.6.gbde171bbf5

