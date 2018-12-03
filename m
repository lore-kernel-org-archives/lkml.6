Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C153C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6560B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+5X5rao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6560B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeLCROs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeLCROr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HhiNqhb3jOvMbUh/hlKKnhM5bKaiR4erfCl/Ys4ZeUs=; b=g+5X5raoUqcvNfcTkh/dWAtP4O
        y8Tf0i5NXkik2toqLLGO5g7cwZtzyKZ9jhtfNTbK2pBuQVksiz3xWgFjLkjf4B1+GduMDTfoL5MRn
        zHx+yoMWfM4qEvbPc1cqhOvzOa5289y4j+9BErzhf6KkHASL9cHoCZp0fayeBrIvap5EepIG4E1Li
        krIxQTJIiQVwqdz9pTyfDYWEC29r0/3bYqPeCvmS362EoA79dJdP9ggGU1BJsUlRXaS/5shr3csel
        NMrIh6RT54g+HBb7zk0B1mivPPQCUoIv49VIoCoRdiqfP5+vsc517TY+bLyLTzuLbb0XdGTeUYmAn
        3jLMLzAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrni-0001H7-10; Mon, 03 Dec 2018 17:14:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 266DA2029F4C7; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.430001980@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 06/10] x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of punting and doing tlb_flush_all(), do the same as
flush_tlb_kernel_range() does and use single page invalidations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/mm_internal.h |    2 ++
 arch/x86/mm/pageattr.c    |   42 ++++++++++++++++++++++++------------------
 arch/x86/mm/tlb.c         |    4 +++-
 3 files changed, 29 insertions(+), 19 deletions(-)

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
@@ -346,16 +348,26 @@ static void cpa_flush_range(unsigned lon
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
 
-	if (__inv_flush_all(cache))
+	for (i = 0; i < cpa->numpages; i++)
+		__flush_tlb_one_kernel(__cpa_addr(cpa, i));
+}
+
+static void cpa_flush_array(struct cpa_data *cpa, int cache)
+{
+	unsigned int i;
+
+	if (cpa_check_flush_all(cache))
 		return;
 
-	flush_tlb_all();
+	if (cpa->numpages <= tlb_single_page_flush_ceiling)
+		on_each_cpu(__cpa_flush_array, cpa, 1);
+	else
+		flush_tlb_all();
 
 	if (!cache)
 		return;
@@ -366,15 +378,11 @@ static void cpa_flush_array(unsigned lon
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
@@ -1771,12 +1779,10 @@ static int change_page_attr_set_clr(unsi
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
@@ -15,6 +15,8 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
+#include "mm_internal.h"
+
 /*
  *	TLB flushing, formerly SMP-only
  *		c/o Linus Torvalds.
@@ -721,7 +723,7 @@ void native_flush_tlb_others(const struc
  *
  * This is in units of pages.
  */
-static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,


