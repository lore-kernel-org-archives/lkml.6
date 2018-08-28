Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E91C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D19E20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D19E20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeH1Qyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:54:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1Qyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:54:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB88C80D;
        Tue, 28 Aug 2018 06:03:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC4F43F721;
        Tue, 28 Aug 2018 06:03:15 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 42FB21AE31F5; Tue, 28 Aug 2018 14:03:27 +0100 (BST)
Date:   Tue, 28 Aug 2018 14:03:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 02/11] arm64: tlb: Add DSB ISHST prior to TLBI in
 __flush_tlb_[kernel_]pgtable()
Message-ID: <20180828130326.GB26727@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-3-git-send-email-will.deacon@arm.com>
 <20180824175609.GR24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824175609.GR24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 07:56:09PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 24, 2018 at 04:52:37PM +0100, Will Deacon wrote:
> > __flush_tlb_[kernel_]pgtable() rely on set_pXd() having a DSB after
> > writing the new table entry and therefore avoid the barrier prior to the
> > TLBI instruction.
> > 
> > In preparation for delaying our walk-cache invalidation on the unmap()
> > path, move the DSB into the TLB invalidation routines.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/tlbflush.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> > index 7e2a35424ca4..e257f8655b84 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -213,6 +213,7 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
> >  {
> >  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
> >  
> > +	dsb(ishst);
> >  	__tlbi(vae1is, addr);
> >  	__tlbi_user(vae1is, addr);
> >  	dsb(ish);
> > @@ -222,6 +223,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
> >  {
> >  	unsigned long addr = __TLBI_VADDR(kaddr, 0);
> >  
> > +	dsb(ishst);
> >  	__tlbi(vaae1is, addr);
> >  	dsb(ish);
> >  }
> 
> I would suggest these barrier -- like any other barriers, carry a
> comment that explain the required ordering.
> 
> I think this here reads like:
> 
> 	STORE: unhook page
> 
> 	DSB-ishst: wait for all stores to complete
> 	TLBI: invalidate broadcast
> 	DSB-ish: wait for TLBI to complete
> 
> And the 'newly' placed DSB-ishst ensures the page is observed unlinked
> before we issue the invalidate.

Yeah, not a bad idea. We already have a big block comment in this file but
it's desperately out of date, so lemme rewrite that and justify the barriers
at the same time.

Will
