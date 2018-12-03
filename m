Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8630820881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o22thSot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8630820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLCRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:15:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeLCROr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86ctNEwtySJGrtRpJrRdK01iee/o4tYWrfB/fsmXXwY=; b=o22thSot/94TmQK6F1abfJ80zH
        wchA/biJuN+o4aX0dhHd17mPRDQlTjSHq0Nl0j79EAB8+NqcikrWJcd21PK4MdXrE/68UGw7EzhcI
        g1SahObI3zkrTm/tpG/ogFNlM5ic1k6gj9rvaumd2fqh62LxvAHgyYqIUpHA7cCNCWzpQjTgJ06Z5
        5yhwuC+iIWGmIN/X/ZUfEtftqsoqB3iR8K6rXN+ol4ABReUmjQQZX2IPu9prLsouNU1eebKLFuaJ8
        kEEXq/ToyFI3bacriwgwpD8bpK9hSPQUvitsEzraJHhG+svfHXRkF+RsjLcS3MTIf2zzQ/RmlYE/A
        cleDWxdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrni-0001H8-1F; Mon, 03 Dec 2018 17:14:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2FCD92029F4CB; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.559855600@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 08/10] x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array()
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the cache flush loop in cpa_flush_*() is identical when we
use __cpa_addr(); further observe that flush_tlb_kernel_range() is a
special case of to the cpa_flush_array() TLB invalidation code.

This then means the two functions are virtually identical. Fold these
two functions into a single cpa_flush() call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   92 +++++++++----------------------------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -304,51 +304,7 @@ static void cpa_flush_all(unsigned long
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool __inv_flush_all(int cache)
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
-	if (__inv_flush_all(cache))
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
-void __cpa_flush_array(void *data)
+void __cpa_flush_tlb(void *data)
 {
 	struct cpa_data *cpa = data;
 	unsigned int i;
@@ -357,33 +313,31 @@ void __cpa_flush_array(void *data)
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
 
 	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_array, cpa, 1);
+		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 	else
 		flush_tlb_all();
 
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
@@ -1698,7 +1652,6 @@ static int change_page_attr_set_clr(unsi
 {
 	struct cpa_data cpa;
 	int ret, cache, checkalias;
-	unsigned long baddr = 0;
 
 	memset(&cpa, 0, sizeof(cpa));
 
@@ -1732,11 +1685,6 @@ static int change_page_attr_set_clr(unsi
 			 */
 			WARN_ON_ONCE(1);
 		}
-		/*
-		 * Save address for cache flush. *addr is modified in the call
-		 * to __change_page_attr_set_clr() below.
-		 */
-		baddr = make_addr_canonical_again(*addr);
 	}
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -1784,11 +1732,7 @@ static int change_page_attr_set_clr(unsi
 		goto out;
 	}
 
-	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
-		cpa_flush_array(&cpa, cache);
-	else
-		cpa_flush_range(baddr, numpages, cache);
-
+	cpa_flush(&cpa, cache);
 out:
 	return ret;
 }
@@ -2097,18 +2041,18 @@ static int __set_memory_enc_dec(unsigned
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush_range(addr, numpages, 1);
+	cpa_flush(&cpa, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
 	/*
-	 * After changing the encryption attribute, we need to flush TLBs
-	 * again in case any speculative TLB caching occurred (but no need
-	 * to flush caches again).  We could just use cpa_flush_all(), but
-	 * in case TLB flushing gets optimized in the cpa_flush_range()
-	 * path use the same logic as above.
+	 * After changing the encryption attribute, we need to flush TLBs again
+	 * in case any speculative TLB caching occurred (but no need to flush
+	 * caches again).  We could just use cpa_flush_all(), but in case TLB
+	 * flushing gets optimized in the cpa_flush() path use the same logic
+	 * as above.
 	 */
-	cpa_flush_range(addr, numpages, 0);
+	cpa_flush(&cpa, 0);
 
 	return ret;
 }


