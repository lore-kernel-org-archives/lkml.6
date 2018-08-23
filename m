Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A88C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0121557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC0121557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeHXDDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:03:45 -0400
Received: from foss.arm.com ([217.140.101.70]:52010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeHXDDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:03:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD5727A9;
        Thu, 23 Aug 2018 16:31:46 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417213F2EA;
        Thu, 23 Aug 2018 16:31:45 -0700 (PDT)
Date:   Fri, 24 Aug 2018 00:31:43 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180823233142.GB4487@brain-police>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822155527.GF24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 05:55:27PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 22, 2018 at 05:30:15PM +0200, Peter Zijlstra wrote:
> > ARM
> > which later used this put an explicit TLB invalidate in their
> > __p*_free_tlb() functions, and PowerPC-radix followed that example.
> 
> > +/*
> > + * If we want tlb_remove_table() to imply TLB invalidates.
> > + */
> > +static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> > +{
> > +#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
> > +	/*
> > +	 * Invalidate page-table caches used by hardware walkers. Then we still
> > +	 * need to RCU-sched wait while freeing the pages because software
> > +	 * walkers can still be in-flight.
> > +	 */
> > +	__tlb_flush_mmu_tlbonly(tlb);
> > +#endif
> > +}
> 
> 
> Nick, Will is already looking at using this to remove the synchronous
> invalidation from __p*_free_tlb() for ARM, could you have a look to see
> if PowerPC-radix could benefit from that too?
> 
> Basically, using a patch like the below, would give your tlb_flush()
> information on if tables were removed or not.

Just to say that I have something up and running for arm64 based on this.
I'll post it once it's seen a bit more testing (either tomorrow or Monday).

Will
