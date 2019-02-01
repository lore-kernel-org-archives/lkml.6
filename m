Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37B0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BF421872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZix2kBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfBAMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:47:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZQS872tGIvtSHtIbazsbs5BptwvJQYhmeaWsue215Ts=; b=KZix2kBy4hZP1eHhY0rfooq3v
        OP7JKzLISd9hAq5tf1SfEZxa2HV0Xiq//QFiPKmsPWGZ6grTLRF0NoDt/oeh/KELbtf+A5sVkPbC6
        azvvVtS+K9bp3sPKSuwdvll/5BzqQW7ADpj+fB20U9j3lBTmu3h8ZU6PAaEInLoBT/Ec8WXDE5bIS
        vdjbhfE8MBouFIsvxOyw/ln16wdyvZlWq1YQ1+/IvNq+ywSWtPefLq/FQ27BEGrlEzkBdACx+8vRy
        0PPd4hSG67COcf4v1gYtpm62CuOy2pCf/0TAz10WLg9L5BqQhDDOFqpTPRf1KUjSfCTKeSs9vrnUV
        M3zXGMMcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpYES-0008Iu-Bh; Fri, 01 Feb 2019 12:47:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E3F7213E24E5; Fri,  1 Feb 2019 13:47:41 +0100 (CET)
Date:   Fri, 1 Feb 2019 13:47:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        luto@amacapital.net, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190201124741.GE31552@hirez.programming.kicks-ass.net>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
 <20190201100358.GD31552@hirez.programming.kicks-ass.net>
 <20190201103600.uflrwzgwj2tadhey@kshutemo-mobl1>
 <20190201124348.GC31534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201124348.GC31534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:43:48PM +0100, Peter Zijlstra wrote:

> static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> {
> 	pgd_t *pgd;
> 	p4d_t *p4d;
> 	pud_t *pud;
> 	pmd_t *pmd;
> 	pte_t *pte;
> 
> 	pgd = pgd_offset(mm, addr);
> 	if (pgd_none(*pgd))
> 		return 0;
> 
> 	p4d = p4d_offset(pgd, addr);
> 	if (!p4d_present(*p4d))
> 		return 0;
> 
> 	if (p4d_large(*p4d)) {
> 		struct page *page = p4d_page(*p4d);
> 		int shift = P4D_SHIFT;
> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			shift = PAGE_SHIFT + compound_order(page);
> 		}
> 
> 		return 1ULL << shift;
> 	}
> 
> 	if (!p4d_present(*p4d))
> 		return 0;
> 
> 	pud = pud_offset(p4d, addr);
> 	if (!pud_present(*pud))
> 		return 0;
> 
> 	if (pud_large(*pud)) {
> 		struct page *page = pud_page(*pud);
> 		int shift = P4D_SHIFT;

PUD_SHIFT

> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			shift = PAGE_SHIFT + compound_order(page);
> 		}
> 
> 		return 1ULL << shift;
> 	}
> 
> 	pmd = pmd_offset(pud, addr);
> 	if (!pmd_present(*pmd))
> 		return 0;
> 
> 	if (pmd_large(*pmd)) {
> 		struct page *page = pud_page(*pud);
> 		int shift = P4D_SHIFT;

PMD_SHIFT

> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			shift = PAGE_SHIFT + compound_order(page);
> 		}
> 
> 		return 1ULL << shift;
> 	}
> 
> 	pte = pte_offset_map(pmd, addr);
> 	if (!pte_present(*pte)) {
> 		pte_unmap(pte);
> 		return 0;
> 	}
> 
> 	pte_unmap(pte);
> 	return PAGE_SIZE;
> }
