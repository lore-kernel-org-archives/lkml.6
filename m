Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62848C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113C82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtsm5lJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113C82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeIRRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:46:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeIRRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MwGxE4reZ1TgcLMCQWlbFi8bSb3k8Y9fLFBXmDbcvtQ=; b=gtsm5lJqJvRPegYwkeFOSNz+g
        BR+fOnLPMyh8RLwoowq3ZGPPGtt+Or/pRxx89PzX1bIh8PuuZg3QAq3NpbMCnnd6ZxLeD/nQ68Z5o
        dJHobRh6MpMrSWl6qflSf4aZoUK5WvOL/2ZZdh9q1TrTVqK3ncRhRteK18XsqVTJ8omar/sRheRYd
        o/W3cLfEWl0MHLosOHJCMfbS//Wol+10DxvKZAWdnuK+ANGIfyUDWaP01Pu3gMufFr2PRZA0CLT0w
        ip+74sW076h0QNS3r7gIL2FhNGLJ50xfb7veFfEV4v8d6O3UtCAf+fJPCupvSsM2SZc8MKQ3POsii
        fVKDMrYJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2EtX-0006cT-3I; Tue, 18 Sep 2018 12:14:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFFDF202C1A35; Tue, 18 Sep 2018 14:14:16 +0200 (CEST)
Date:   Tue, 18 Sep 2018 14:14:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [patch V3 02/11] x86/mm/cpa: Split, rename and clean up
 try_preserve_large_page()
Message-ID: <20180918121416.GO24142@hirez.programming.kicks-ass.net>
References: <20180917142906.384767038@linutronix.de>
 <20180917143545.830507216@linutronix.de>
 <20180918081909.GI24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918081909.GI24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:19:09AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 17, 2018 at 04:29:08PM +0200, Thomas Gleixner wrote:
> > @@ -1288,23 +1287,23 @@ static int __change_page_attr(struct cpa
> >  	err = split_large_page(cpa, kpte, address);
> >  	if (!err) {
> >  		/*
> > +		 * Do a global flush tlb after splitting the large page
> > +		 * and before we do the actual change page attribute in the PTE.
> > +		 *
> > +		 * With out this, we violate the TLB application note, that says
> > +		 * "The TLBs may contain both ordinary and large-page
> >  		 *  translations for a 4-KByte range of linear addresses. This
> >  		 *  may occur if software modifies the paging structures so that
> >  		 *  the page size used for the address range changes. If the two
> >  		 *  translations differ with respect to page frame or attributes
> >  		 *  (e.g., permissions), processor behavior is undefined and may
> >  		 *  be implementation-specific."
> > +		 *
> > +		 * We do this global tlb flush inside the cpa_lock, so that we
> >  		 * don't allow any other cpu, with stale tlb entries change the
> >  		 * page attribute in parallel, that also falls into the
> >  		 * just split large page entry.
> > +		 */
> >  		flush_tlb_all();
> >  		goto repeat;
> >  	}
> 
> this made me look at the tlb invalidation of that thing again; do we
> want something like the below?
> 

Further cleanups are possible...

---
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,25 +285,20 @@ static void cpa_flush_all(unsigned long
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-static void __cpa_flush_range(void *arg)
-{
-	/*
-	 * We could optimize that further and do individual per page
-	 * tlb invalidates for a low number of pages. Caveat: we must
-	 * flush the high aliases on 64bit as well.
-	 */
-	__flush_tlb_all();
-}
-
 static void cpa_flush_range(unsigned long start, int numpages, int cache)
 {
-	unsigned int i, level;
-	unsigned long addr;
+	unsigned long addr, end = start + PAGE_SIZE * numpages;
+	unsigned int level;
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	on_each_cpu(__cpa_flush_range, NULL, 1);
+	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
+	flush_tlb_kernel_range(start, end);
 
 	if (!cache)
 		return;
@@ -314,7 +309,7 @@ static void cpa_flush_range(unsigned lon
 	 * will cause all other CPUs to flush the same
 	 * cachelines:
 	 */
-	for (i = 0, addr = start; i < numpages; i++, addr += PAGE_SIZE) {
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
 		pte_t *pte = lookup_address(addr, &level);
 
 		/*
@@ -325,30 +320,22 @@ static void cpa_flush_range(unsigned lon
 	}
 }
 
-static void cpa_flush_array(unsigned long *start, int numpages, int cache,
+static void cpa_flush_array(unsigned long baddr, unsigned long *start, 
+			    int numpages, int cache,
 			    int in_flags, struct page **pages)
 {
 	unsigned int i, level;
-#ifdef CONFIG_PREEMPT
-	/*
-	 * Avoid wbinvd() because it causes latencies on all CPUs,
-	 * regardless of any CPU isolation that may be in effect.
-	 *
-	 * This should be extended for CAT enabled systems independent of
-	 * PREEMPT because wbinvd() does not respect the CAT partitions and
-	 * this is exposed to unpriviledged users through the graphics
-	 * subsystem.
-	 */
-	unsigned long do_wbinvd = 0;
-#else
-	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
-#endif
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
+	if (!static_cpu_has(X86_FEATURE_CLFLUSH)) {
+		cpa_flush_all(cache);
+		return;
+	}
+
+	flush_tlb_kernel_range(baddr, baddr + PAGE_SIZE * numpages);
 
-	if (!cache || do_wbinvd)
+	if (!cache)
 		return;
 
 	/*
@@ -1006,14 +993,24 @@ __split_large_page(struct cpa_data *cpa,
 	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
 
 	/*
-	 * Intel Atom errata AAH41 workaround.
+	 * Do a global flush tlb after splitting the large page
+	 * and before we do the actual change page attribute in the PTE.
 	 *
-	 * The real fix should be in hw or in a microcode update, but
-	 * we also probabilistically try to reduce the window of having
-	 * a large TLB mixed with 4K TLBs while instruction fetches are
-	 * going on.
+	 * Without this, we violate the TLB application note, that says
+	 * "The TLBs may contain both ordinary and large-page
+	 *  translations for a 4-KByte range of linear addresses. This
+	 *  may occur if software modifies the paging structures so that
+	 *  the page size used for the address range changes. If the two
+	 *  translations differ with respect to page frame or attributes
+	 *  (e.g., permissions), processor behavior is undefined and may
+	 *  be implementation-specific."
+	 *
+	 * We do this global tlb flush inside the cpa_lock, so that we
+	 * don't allow any other cpu, with stale tlb entries change the
+	 * page attribute in parallel, that also falls into the
+	 * just split large page entry.
 	 */
-	__flush_tlb_all();
+	flush_tlb_all();
 	spin_unlock(&pgd_lock);
 
 	return 0;
@@ -1538,28 +1535,8 @@ static int __change_page_attr(struct cpa
 	 * We have to split the large page:
 	 */
 	err = split_large_page(cpa, kpte, address);
-	if (!err) {
-		/*
-		 * Do a global flush tlb after splitting the large page
-		 * and before we do the actual change page attribute in the PTE.
-		 *
-		 * With out this, we violate the TLB application note, that says
-		 * "The TLBs may contain both ordinary and large-page
-		 *  translations for a 4-KByte range of linear addresses. This
-		 *  may occur if software modifies the paging structures so that
-		 *  the page size used for the address range changes. If the two
-		 *  translations differ with respect to page frame or attributes
-		 *  (e.g., permissions), processor behavior is undefined and may
-		 *  be implementation-specific."
-		 *
-		 * We do this global tlb flush inside the cpa_lock, so that we
-		 * don't allow any other cpu, with stale tlb entries change the
-		 * page attribute in parallel, that also falls into the
-		 * just split large page entry.
-		 */
-		flush_tlb_all();
+	if (!err)
 		goto repeat;
-	}
 
 	return err;
 }
@@ -1786,9 +1763,9 @@ static int change_page_attr_set_clr(unsi
 	 * error case we fall back to cpa_flush_all (which uses
 	 * WBINVD):
 	 */
-	if (!ret && boot_cpu_has(X86_FEATURE_CLFLUSH)) {
+	if (!ret) {
 		if (cpa.flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
-			cpa_flush_array(addr, numpages, cache,
+			cpa_flush_array(baddr, addr, numpages, cache,
 					cpa.flags, pages);
 		} else
 			cpa_flush_range(baddr, numpages, cache);
@@ -2108,10 +2085,7 @@ static int __set_memory_enc_dec(unsigned
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	if (static_cpu_has(X86_FEATURE_CLFLUSH))
-		cpa_flush_range(start, numpages, 1);
-	else
-		cpa_flush_all(1);
+	cpa_flush_range(start, numpages, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2122,10 +2096,7 @@ static int __set_memory_enc_dec(unsigned
 	 * in case TLB flushing gets optimized in the cpa_flush_range()
 	 * path use the same logic as above.
 	 */
-	if (static_cpu_has(X86_FEATURE_CLFLUSH))
-		cpa_flush_range(start, numpages, 0);
-	else
-		cpa_flush_all(0);
+	cpa_flush_range(start, numpages, 0);
 
 	return ret;
 }
