Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BABC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0311220834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gAg7J+zK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0311220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeLABPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:15:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeLABPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ptRxRLRS1iuFJ0Vz16U22+rhxyheUZJ7tOs4y69GeSE=; b=gAg7J+zKCSSkaAwkZ1zlTR7O9l
        NmCIK9p2yMeISsea/dfCv24Rb4OVE0lZCPX8iOzPt8ZbG4tiXAZxT7HltKLZAyDD7ubv3Z5UZLeAg
        xfP1akWXOm6hg1hBHh+CZps5zio4nkMXa9gHqyifCmfzdQ8jl/L9Izn5tZyvLn8kE32pzZaPhWLiX
        zLuaKu2P69fdVuVhFPrm0DRiR+xgWZdRYR9McEK9f0brx3SBEvKT5e7VgS/gSyo+seJn+21IaIBYD
        r5SwaYAvMXK+CNh6sqR22DzHB9Gl2SLBllgQjOlPkJamLxnR1VoJ78YJ6NNRgP+9LK1mBY8Uh09nn
        U05WalTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSjQv-0003vC-Ud; Fri, 30 Nov 2018 14:06:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 68E2E2029FD74; Fri, 30 Nov 2018 15:06:14 +0100 (CET)
Message-Id: <20181130140337.605067461@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 14:44:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array()
References: <20181130134455.490139778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-cpa-fold-cpa_flush.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the cache flush loop in cpa_flush_*() is identical when we
use __cpa_addr(); this then means the two functions are virtually
identical except for the TLB flushing.

Fold these two functions into a single cpa_flush() call.

One pesky detail is that __change_page_attr_set_clr() modifies @cpa,
so we have to save and restore part of that to ensure we flush the
original range.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   96 ++++++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 67 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -244,7 +244,7 @@ static unsigned long __cpa_addr(struct c
 	if (cpa->flags & CPA_ARRAY)
 		return cpa->vaddr[idx];
 
-	return *cpa->vaddr;
+	return *cpa->vaddr + idx * PAGE_SIZE;
 }
 
 /*
@@ -304,50 +304,6 @@ static void cpa_flush_all(unsigned long
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool cpa_check_flush_all(int cache)
-{
-	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
-
-	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
-		cpa_flush_all(cache);
-		return true;
-	}
-
-	return false;
-}
-
-static void cpa_flush_range(unsigned long start, int numpages, int cache)
-{
-	unsigned int i, level;
-	unsigned long addr;
-
-	WARN_ON(PAGE_ALIGN(start) != start);
-
-	if (cpa_check_flush_all(cache))
-		return;
-
-	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
-
-	if (!cache)
-		return;
-
-	/*
-	 * We only need to flush on one CPU,
-	 * clflush is a MESI-coherent instruction that
-	 * will cause all other CPUs to flush the same
-	 * cachelines:
-	 */
-	for (i = 0, addr = start; i < numpages; i++, addr += PAGE_SIZE) {
-		pte_t *pte = lookup_address(addr, &level);
-
-		/*
-		 * Only flush present addresses:
-		 */
-		if (pte && (pte_val(*pte) & _PAGE_PRESENT))
-			clflush_cache_range((void *) addr, PAGE_SIZE);
-	}
-}
-
 void __cpa_flush_array(void *data)
 {
 	struct cpa_data *cpa = data;
@@ -357,33 +313,37 @@ void __cpa_flush_array(void *data)
 		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
 }
 
-static void cpa_flush_array(struct cpa_data *cpa, int cache)
+static void cpa_flush(struct cpa_data *data, int cache)
 {
+	struct cpa_data *cpa = data;
 	unsigned int i;
 
-	if (cpa_check_flush_all(cache))
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
+
+	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
 		return;
+	}
 
-	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_array, cpa, 1);
-	else
-		flush_tlb_all();
+	if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
+		if (cpa->numpages <= tlb_single_page_flush_ceiling)
+			on_each_cpu(__cpa_flush_array, cpa, 1);
+		else
+			flush_tlb_all();
+	} else {
+		unsigned long start = __cpa_addr(cpa, 0);
+
+		flush_tlb_kernel_range(start, start + PAGE_SIZE * cpa->numpages);
+	}
 
 	if (!cache)
 		return;
 
-	/*
-	 * We only need to flush on one CPU,
-	 * clflush is a MESI-coherent instruction that
-	 * will cause all other CPUs to flush the same
-	 * cachelines:
-	 */
 	for (i = 0; i < cpa->numpages; i++) {
 		unsigned long addr = __cpa_addr(cpa, i);
 		unsigned int level;
-		pte_t *pte;
 
-		pte = lookup_address(addr, &level);
+		pte_t *pte = lookup_address(addr, &level);
 
 		/*
 		 * Only flush present addresses:
@@ -1695,7 +1655,7 @@ static int change_page_attr_set_clr(unsi
 {
 	struct cpa_data cpa;
 	int ret, cache, checkalias;
-	unsigned long baddr = 0;
+	unsigned long baddr = *addr;
 
 	memset(&cpa, 0, sizeof(cpa));
 
@@ -1781,11 +1741,11 @@ static int change_page_attr_set_clr(unsi
 		goto out;
 	}
 
-	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
-		cpa_flush_array(&cpa, cache);
-	else
-		cpa_flush_range(baddr, numpages, cache);
+	/* Reset @cpa so that we flush the original range. */
+	cpa.vaddr = &baddr;
+	cpa.numpages = numpages;
 
+	cpa_flush(&cpa, cache);
 out:
 	return ret;
 }
@@ -2071,8 +2031,8 @@ int set_memory_global(unsigned long addr
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
+	unsigned long start = addr;
 	struct cpa_data cpa;
-	unsigned long start;
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
@@ -2099,7 +2059,7 @@ static int __set_memory_enc_dec(unsigned
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush_range(start, numpages, 1);
+	cpa_flush(&cpa, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2110,7 +2070,9 @@ static int __set_memory_enc_dec(unsigned
 	 * in case TLB flushing gets optimized in the cpa_flush_range()
 	 * path use the same logic as above.
 	 */
-	cpa_flush_range(start, numpages, 0);
+	cpa.vaddr = &start;
+	cpa.numpages = numpages;
+	cpa_flush(&cpa, 0);
 
 	return ret;
 }


