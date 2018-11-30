Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13FC20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fDHHoDVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13FC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeLABPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:15:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeLABPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k5DBNKfj7R4vuRl0uYCsPIspnLkumZndZcevVZZ7rMQ=; b=fDHHoDVyW/igCpZFgJu5mc17tr
        0eCJmmKgWa5w3yIgcXCfe95kANOBUb9DFKmTdPCkEkjP5Hz01FRTlAiQZ4fIxmn6DJXNgxK+aaG1n
        BV+f9MKRSjFaaNDh8nH+ldo7msPm/uY4iejk0Oc3XmuNgfRk5xK2PXLdNhISZ0baeF15PyH0OVLGT
        aAKVQaszbSkkqlkcJQtbr7fWgpCPdBm+aYqXqbYduSky1gqAVs6lFETfVEL3TDoKRAYbFMx83Nn2Q
        HVNE6XIRC4YGTn328l+f87RQgUccFrXNS9U8dii++cVqFbZj9WfoVzIfO82Pu1tq7DFzj7YBbduM4
        Q3UqJQNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSjQv-0003Dr-2M; Fri, 30 Nov 2018 14:06:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 631E52029FD64; Fri, 30 Nov 2018 15:06:14 +0100 (CET)
Message-Id: <20181130140337.547357878@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 14:44:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86/mm/cpa: Fix cpa_flush_array()
References: <20181130134455.490139778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-cpa-fix-flush_array.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit:

  a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")

I misread the cpa array code and incorrectly used
tlb_flush_kernel_range(), resulting in missing TLB flushes and
consequent failures.

Iterate the array and invalidate the individual pages instead.

Fixes: a7295fd53c39 ("x86/mm/cpa: Use flush_tlb_kernel_range()")
Reported-by: "StDenis, Tom" <Tom.StDenis@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/mm_internal.h |    2 +
 arch/x86/mm/pageattr.c    |   62 ++++++++++++++++++++++++++++------------------
 arch/x86/mm/tlb.c         |    4 ++
 3 files changed, 43 insertions(+), 25 deletions(-)

--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -19,4 +19,6 @@ extern int after_bootmem;
 
 void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
+extern unsigned long tlb_single_page_flush_ceiling;
+
 #endif	/* __X86_MM_INTERNAL_H */
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -26,6 +26,8 @@
 #include <asm/pat.h>
 #include <asm/set_memory.h>
 
+#include "mm_internal.h"
+
 /*
  * The current flushing context - we pass it instead of 5 arguments:
  */
@@ -302,20 +304,16 @@ static void cpa_flush_all(unsigned long
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static bool __cpa_flush_range(unsigned long start, int numpages, int cache)
+static bool cpa_check_flush_all(int cache)
 {
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	WARN_ON(PAGE_ALIGN(start) != start);
-
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return true;
 	}
 
-	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
-
-	return !cache;
+	return false;
 }
 
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
@@ -323,7 +321,14 @@ static void cpa_flush_range(unsigned lon
 	unsigned int i, level;
 	unsigned long addr;
 
-	if (__cpa_flush_range(start, numpages, cache))
+	WARN_ON(PAGE_ALIGN(start) != start);
+
+	if (cpa_check_flush_all(cache))
+		return;
+
+	flush_tlb_kernel_range(start, start + PAGE_SIZE * numpages);
+
+	if (!cache)
 		return;
 
 	/*
@@ -343,13 +348,28 @@ static void cpa_flush_range(unsigned lon
 	}
 }
 
-static void cpa_flush_array(unsigned long baddr, unsigned long *start,
-			    int numpages, int cache,
-			    int in_flags, struct page **pages)
+void __cpa_flush_array(void *data)
 {
-	unsigned int i, level;
+	struct cpa_data *cpa = data;
+	unsigned int i;
 
-	if (__cpa_flush_range(baddr, numpages, cache))
+	for (i = 0; i < cpa->numpages; i++)
+		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
+}
+
+static void cpa_flush_array(struct cpa_data *cpa, int cache)
+{
+	unsigned int i;
+
+	if (cpa_check_flush_all(cache))
+		return;
+
+	if (cpa->numpages <= tlb_single_page_flush_ceiling)
+		on_each_cpu(__cpa_flush_array, cpa, 1);
+	else
+		flush_tlb_all();
+
+	if (!cache)
 		return;
 
 	/*
@@ -358,15 +378,11 @@ static void cpa_flush_array(unsigned lon
 	 * will cause all other CPUs to flush the same
 	 * cachelines:
 	 */
-	for (i = 0; i < numpages; i++) {
-		unsigned long addr;
+	for (i = 0; i < cpa->numpages; i++) {
+		unsigned long addr = __cpa_addr(cpa, i);
+		unsigned int level;
 		pte_t *pte;
 
-		if (in_flags & CPA_PAGES_ARRAY)
-			addr = (unsigned long)page_address(pages[i]);
-		else
-			addr = start[i];
-
 		pte = lookup_address(addr, &level);
 
 		/*
@@ -1765,12 +1781,10 @@ static int change_page_attr_set_clr(unsi
 		goto out;
 	}
 
-	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-		cpa_flush_array(baddr, addr, numpages, cache,
-				cpa.flags, pages);
-	} else {
+	if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
+		cpa_flush_array(&cpa, cache);
+	else
 		cpa_flush_range(baddr, numpages, cache);
-	}
 
 out:
 	return ret;
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -16,6 +16,8 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
+#include "mm_internal.h"
+
 /*
  *	TLB flushing, formerly SMP-only
  *		c/o Linus Torvalds.
@@ -664,7 +666,7 @@ void native_flush_tlb_others(const struc
  *
  * This is in units of pages.
  */
-static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,


