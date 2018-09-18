Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A3420867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u5dZzaHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A3420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeIRNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:50:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeIRNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/kKOLehS8oAMN1+T6/Guv3X8aetkiDj5ZVXInILuZmw=; b=u5dZzaHxsGVn5XsfNDeIBKMqw
        SyRkS/lSTtK3dzdUyh7j6e5+RpLtf64BGsIr4NhmPzwm9q+VnvBYxqnflcrRteZG3dOfv7mbZGTB0
        Pm/O4nMpuO7zX/A1ojxdWUcxS+RKS0/pkZJdl5i1l+NTAgkP+YN8tf1iHB0keR0iQfTdHKAvT5ZRt
        eFWnfIbkCFkCy7A99yHPKkSfB4NF0i/1jhOVCCw2FokCAoPADl7SFqvGbvcutY9+oz5GCg20oN+58
        hBlybqaq97Sr6UCgQLRoj5dQAs1MSi+k/Ub0/GqZq1vphve6sHXLGWf/Lp6C2XVvR+uezdG9PkeGA
        p6H3DdlLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2BDz-00029h-Jq; Tue, 18 Sep 2018 08:19:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C49B202C1A36; Tue, 18 Sep 2018 10:19:09 +0200 (CEST)
Date:   Tue, 18 Sep 2018 10:19:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: Re: [patch V3 02/11] x86/mm/cpa: Split, rename and clean up
 try_preserve_large_page()
Message-ID: <20180918081909.GI24106@hirez.programming.kicks-ass.net>
References: <20180917142906.384767038@linutronix.de>
 <20180917143545.830507216@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917143545.830507216@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:29:08PM +0200, Thomas Gleixner wrote:
> @@ -1288,23 +1287,23 @@ static int __change_page_attr(struct cpa
>  	err = split_large_page(cpa, kpte, address);
>  	if (!err) {
>  		/*
> +		 * Do a global flush tlb after splitting the large page
> +		 * and before we do the actual change page attribute in the PTE.
> +		 *
> +		 * With out this, we violate the TLB application note, that says
> +		 * "The TLBs may contain both ordinary and large-page
>  		 *  translations for a 4-KByte range of linear addresses. This
>  		 *  may occur if software modifies the paging structures so that
>  		 *  the page size used for the address range changes. If the two
>  		 *  translations differ with respect to page frame or attributes
>  		 *  (e.g., permissions), processor behavior is undefined and may
>  		 *  be implementation-specific."
> +		 *
> +		 * We do this global tlb flush inside the cpa_lock, so that we
>  		 * don't allow any other cpu, with stale tlb entries change the
>  		 * page attribute in parallel, that also falls into the
>  		 * just split large page entry.
> +		 */
>  		flush_tlb_all();
>  		goto repeat;
>  	}

this made me look at the tlb invalidation of that thing again; do we
want something like the below?

---

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -285,16 +285,6 @@ static void cpa_flush_all(unsigned long
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
 	unsigned int i, level;
@@ -303,7 +293,7 @@ static void cpa_flush_range(unsigned lon
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 	WARN_ON(PAGE_ALIGN(start) != start);
 
-	on_each_cpu(__cpa_flush_range, NULL, 1);
+	flush_tlb_all();
 
 	if (!cache)
 		return;
@@ -1006,14 +996,24 @@ __split_large_page(struct cpa_data *cpa,
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
@@ -1538,28 +1538,8 @@ static int __change_page_attr(struct cpa
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
