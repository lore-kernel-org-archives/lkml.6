Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B406C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43320881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YgPy9nnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbfAaM7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:59:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbfAaM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nPNRmiBKYb6UYf+Hk1h1jBGsUvZUpBOEamndy2Vn+1Y=; b=YgPy9nnDyWKlWZMe3z0Rk7vRQ
        3m36oRDeZ6r+/RlkMIy7GCCGvjUYH+gqWhJgNiu9sCaX+IoGGUeouUW+cLqiclAH2nzdzIPtBZJdV
        vCC65+bSDfCng96XiVi7uM1p2LaSJVJwuuKVnQT90G1WcvIjJQ4Hju7+GULyElwHWQGFm5Y90Dr1m
        caMha01g8lsifmNcDLt7N0xDyyVIKWkYrpaUtIyqvXtA0MYUThgg1t1m28LeDw5KF6bOyRZWfIe+Q
        vVrT9U+bQxmq0GVr7SrTgAIMO9P+Fl1nBR5l8L8aMPWQiKCgV6mhTgZm/Tv75KE2D3xD6auAEOiRH
        +buiMWRzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpBvy-0002GB-Ax; Thu, 31 Jan 2019 12:59:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE960202E5207; Thu, 31 Jan 2019 13:59:08 +0100 (CET)
Date:   Thu, 31 Jan 2019 13:59:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190131125908.GB31552@hirez.programming.kicks-ass.net>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
 <20190131123725.GB31516@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131123725.GB31516@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:37:25PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 30, 2019 at 06:23:42AM -0800, kan.liang@linux.intel.com wrote:
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 374a197..03bf45d 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2578,3 +2578,45 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
> >  	cap->events_mask_len	= x86_pmu.events_mask_len;
> >  }
> >  EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
> > +
> > +/*
> > + * map x86 page levels to perf page sizes
> > + */
> > +static const enum perf_page_size perf_page_size_map[PG_LEVEL_NUM] = {
> > +	[PG_LEVEL_NONE] = PERF_PAGE_SIZE_NONE,
> > +	[PG_LEVEL_4K]   = PERF_PAGE_SIZE_4K,
> > +	[PG_LEVEL_2M]   = PERF_PAGE_SIZE_2M,
> > +	[PG_LEVEL_1G]   = PERF_PAGE_SIZE_1G,
> > +	[PG_LEVEL_512G] = PERF_PAGE_SIZE_512G,
> > +};
> > +
> > +u64 perf_get_page_size(u64 virt)
> > +{
> > +	unsigned long flags;
> > +	unsigned int level;
> > +	pte_t *pte;
> > +
> > +	if (!virt)
> > +		return 0;
> > +
> > +	/*
> > +	 * Interrupts are disabled, so it prevents any tear down
> > +	 * of the page tables.
> > +	 * See the comment near struct mmu_table_batch.
> > +	 */
> > +	local_irq_save(flags);
> > +	if (virt >= TASK_SIZE)
> > +		pte = lookup_address(virt, &level);
> > +	else {
> > +		if (current->mm)
> > +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> > +						    virt, &level);
> 
> Aside from all the missin {}, I'm fairly sure this is broken since this
> happens from NMI context. This can interrupt switch_mm() and things like
> use_temporary_mm().

Ah, I'm confused again. This is a software page-table walk and is not
affected by the current CR3 state, which is much safer.

The rest of the comment still apply of course.
