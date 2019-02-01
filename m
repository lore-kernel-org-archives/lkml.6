Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299B821872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Urk20sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfBAKES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:04:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=97/9n2CCeAYRmqzj2PHTmcvZtFuC6J6rYX8ZULmEc98=; b=2Urk20sRg0ghbTdcCm3X0+1eH
        XHE1H73s11sgwzDm5viiVGJ0MYZFPqTnuaXTEUVYD79Gq01OnhhDW9ONN4Ou/THf+92iI8fBPLWu6
        CAWRCwRG3woTsPl+RheNQCDpwuPnqPl1028HjhF7ogrfAO3YTgaDH4Ycx9Bl18mljyeFer4QLEn5T
        uUox4O33+17cxAfoy4ZNROmJpNfm1SGLJLt+xcVKsrOxG+J96h/Kq+p6RNAEO74aJz3/wdfOD97sj
        Ztjkb13PQFKBOnIjEOa9PFGmhTxv11ni7cALWi5pIhZChvjmIk69ILEIsBXiYKb1bcJCrDN/zYPwi
        NU9SaTjJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpVg0-0007EU-9I; Fri, 01 Feb 2019 10:04:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBF5D202E51F5; Fri,  1 Feb 2019 11:03:58 +0100 (CET)
Date:   Fri, 1 Feb 2019 11:03:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, luto@amacapital.net,
        Vlastimil Babka <vbabka@suse.cz>, kirill@shutemov.name,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190201100358.GD31552@hirez.programming.kicks-ass.net>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201092240.GB31498@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:22:40AM +0100, Peter Zijlstra wrote:

> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
>  {
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (pgd_none(*pgd))
> +		return 0;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return 0;
> +
> +	if (p4d_large(*p4d));
> +		return 1ULL << P4D_SHIFT;
> +
> +	if (!p4d_present(*p4d))
> +		return 0;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud))
> +		return 0;
> +
> +	if (pud_large(*pud))
> +		return 1ULL << PUD_SHIFT;

Will just mentioned a lovely feature where some archs have multi entry
large pages.

Possible something like:

	if (pud_large(*pud)) {
		struct page *page = pud_page(*pud);
		int order = PUD_SHIFT;

		if (PageHuge(page)) {
			page = compound_head(page);
			order += compound_order(page);
		}

		return 1ULL << order;
	}

works correctly.

> +
> +	if (!pud_present(*pud))
> +		return 0;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		return 0;
> +
> +	if (pmd_large(*pmd))
> +		return 1ULL << PMD_SHIFT;

And same here I suppose..

> +
> +	if (!pmd_present(*pmd))
> +		return 0;
> +
> +	return 1ULL << PAGE_SHIFT;
> +}
