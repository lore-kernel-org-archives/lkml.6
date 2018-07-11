Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BEFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EF22083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EF22083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbeGKJqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:46:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeGKJqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D2F2ED1;
        Wed, 11 Jul 2018 02:42:45 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D35583F318;
        Wed, 11 Jul 2018 02:42:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DA4CB1AE3828; Wed, 11 Jul 2018 10:43:26 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:43:26 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com
Subject: Re: [RESEND PATCH v2 3/9] asm-generic: Move some macros from
 linux/bitops.h to a new bits.h file
Message-ID: <20180711094326.GB13963@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
 <1529412794-17720-4-git-send-email-will.deacon@arm.com>
 <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
 <20180709113250.GA26377@arm.com>
 <20180709151006.370112d321c8f3df06bf231b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709151006.370112d321c8f3df06bf231b@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Andrew,

On Mon, Jul 09, 2018 at 03:10:06PM -0700, Andrew Morton wrote:
> On Mon, 9 Jul 2018 12:32:51 +0100 Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jul 06, 2018 at 05:30:49PM -0700, Andrew Morton wrote:
> > > On Tue, 19 Jun 2018 13:53:08 +0100 Will Deacon <will.deacon@arm.com> wrote:
> > > 
> > > > In preparation for implementing the asm-generic atomic bitops in terms
> > > > of atomic_long_*, we need to prevent asm/atomic.h implementations from
> > > > pulling in linux/bitops.h. A common reason for this include is for the
> > > > BITS_PER_BYTE definition, so move this and some other BIT() and masking
> > > > macros into a new header file, linux/bits.h
> > > > 
> > > > --- a/include/linux/bitops.h
> > > > +++ b/include/linux/bitops.h
> > > > @@ -2,29 +2,9 @@
> > > >  #ifndef _LINUX_BITOPS_H
> > > >  #define _LINUX_BITOPS_H
> > > >  #include <asm/types.h>
> > > > +#include <linux/bits.h>
> > > >  
> > > > -#ifdef	__KERNEL__
> > > > -#define BIT(nr)			(1UL << (nr))
> > > > -#define BIT_ULL(nr)		(1ULL << (nr))
> > > > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > > > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > > > -#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > > > -#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > > > -#define BITS_PER_BYTE		8
> > > >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> > > > -#endif
> > > 
> > > Why does it leave BITS_TO_LONGS() in place?
> > > 
> > > That becomes unfortunate with Chris's patch, so I'm moving
> > > BITS_TO_LONGS() into bits.h.
> > 
> > The reason I avoided that was because it would pull in the dreaded
> > kernel.h for DIV_ROUND_UP, and then we're back to circular include hell :(
> > 
> 
> Well we should comment that so every reader doesn't wonder what I
> wondered.
> 
> Refactoring works well.  I suppose DIV_ROUND_UP and friends await a new
> <arithmacros.h>.

Yes; pulling apart kernel.h would certainly help solve some of the fragility
here.

> Also, all these macros no longer `#ifdef __KERNEL__' protection, which
> wasn't mentioned in the changelog.  Deliberate?

Yes, these aren't under uapi/ so I dropped the guards now that they're not
needed (my understanding is that they're only there because of the way the
uapi split was originally scripted). I can also confirm that the generated
user headers match exactly with and without my changes.

Will
