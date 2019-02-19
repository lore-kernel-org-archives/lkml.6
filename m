Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF420818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xMiQs30T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfBSKd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfBSKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IUo7iBIklHrRHP8ftZwwZUgsCS7kaKlA6dnR39QGIyc=; b=xMiQs30TXekYleqbvtIXDNUy7T
        6A7LAb2RgsJ17QxyScnexR01d39zsp9pTEIs4AbdQvkcTYIq8fjaaRFx/O7Jd77Ljz2ml11nuAUpX
        j8UfFPZrbOaAMpNsOp1qAP3bGXSTOhX9gfaS8kdtl4AEybZo01bo93kUAfggflrXVG44He/yu9/sM
        E0QaaPwN7gWHOOHUfxjkNlF6c+0j+ZKmFiV+909+ylcMTaUESjRX9+lrQKTNL+y1r0JaKnAa0Uxgp
        Nz2L25LAIeNF6yGwBufvGc76n5CPuyJoNUBe/+f/zDfxSEZucnoQWl4opbl8Y6xtgGeSahKXdUqq8
        JwnnNsqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hp-0000dy-9K; Tue, 19 Feb 2019 10:32:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7CE76285205A3; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.810881730@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:32:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH v6 16/18] asm-generic/tlb: Remove HAVE_GENERIC_MMU_GATHER
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all architectures are now using it, it is redundant.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    1 -
 mm/mmu_gather.c           |    4 ----
 2 files changed, 5 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -142,7 +142,6 @@
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
  */
-#define HAVE_GENERIC_MMU_GATHER
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 /*
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -11,8 +11,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
-#ifdef HAVE_GENERIC_MMU_GATHER
-
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
@@ -109,8 +107,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb_flush_mmu_free(tlb);
 }
 
-#endif /* HAVE_GENERIC_MMU_GATHER */
-
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 
 /*


