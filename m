Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78212C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B902172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B902172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeI1HOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:14:51 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57518 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728742AbeI1HNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08640236|-1;CH=blue;FP=1691684883534943193|1|1|12|0|-1|-1|-1;HT=e01e01546;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CwkXlEv_1538095950;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkXlEv_1538095950)
          by smtp.aliyun-inc.com(10.147.41.143);
          Fri, 28 Sep 2018 08:52:30 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 32/33] csky: fix flush_cache_range and tlb_start_vma
Date:   Fri, 28 Sep 2018 08:51:29 +0800
Message-Id: <33f94d1b44080b4dd39759443a8c4704c70cab01.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In flush_cache_range(vma, ...) cache_wbinv_range() couldn't deal with
vma->mm's asid for cache_flush_line. So we use cache_wbinv_all() first
and we'll improve with cache_flush(vma, start, end) in future.

For tlb_start_vma, we make it the same as other arch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/cacheflush.h | 6 +++++-
 arch/csky/abiv1/inc/abi/tlb.h        | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index f0de49c..4ae81b0 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -15,7 +15,11 @@ extern void flush_dcache_page(struct page *);
 #define flush_cache_page(vma,page,pfn)	cache_wbinv_all()
 #define flush_cache_dup_mm(mm)		cache_wbinv_all()
 
-#define flush_cache_range(mm,start,end)	cache_wbinv_range(start, end)
+/*
+ * if (current_mm != vma->mm) cache_wbinv_range(start, end) will be broken.
+ * Use cache_wbinv_all() here and need to be improved in future.
+ */
+#define flush_cache_range(vma,start,end)	cache_wbinv_all()
 #define flush_cache_vmap(start, end)	cache_wbinv_range(start, end)
 #define flush_cache_vunmap(start, end)  cache_wbinv_range(start, end)
 
diff --git a/arch/csky/abiv1/inc/abi/tlb.h b/arch/csky/abiv1/inc/abi/tlb.h
index 6d461f3..3b9d6d9 100644
--- a/arch/csky/abiv1/inc/abi/tlb.h
+++ b/arch/csky/abiv1/inc/abi/tlb.h
@@ -7,6 +7,6 @@
 #define tlb_start_vma(tlb, vma) \
 	do { \
 		if (!tlb->fullmm) \
-			cache_wbinv_all(); \
+			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
 	}  while (0)
 #endif /* __ABI_CSKY_TLB_H */
-- 
2.7.4

