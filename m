Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB02086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABB02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbeGILcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:32:14 -0400
Received: from foss.arm.com ([217.140.101.70]:57616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932735AbeGILcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:32:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 654B47A9;
        Mon,  9 Jul 2018 04:32:10 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 376263F318;
        Mon,  9 Jul 2018 04:32:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A54211AE2E1B; Mon,  9 Jul 2018 12:32:51 +0100 (BST)
Date:   Mon, 9 Jul 2018 12:32:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com
Subject: Re: [RESEND PATCH v2 3/9] asm-generic: Move some macros from
 linux/bitops.h to a new bits.h file
Message-ID: <20180709113250.GA26377@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
 <1529412794-17720-4-git-send-email-will.deacon@arm.com>
 <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Jul 06, 2018 at 05:30:49PM -0700, Andrew Morton wrote:
> On Tue, 19 Jun 2018 13:53:08 +0100 Will Deacon <will.deacon@arm.com> wrote:
> 
> > In preparation for implementing the asm-generic atomic bitops in terms
> > of atomic_long_*, we need to prevent asm/atomic.h implementations from
> > pulling in linux/bitops.h. A common reason for this include is for the
> > BITS_PER_BYTE definition, so move this and some other BIT() and masking
> > macros into a new header file, linux/bits.h
> > 
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -2,29 +2,9 @@
> >  #ifndef _LINUX_BITOPS_H
> >  #define _LINUX_BITOPS_H
> >  #include <asm/types.h>
> > +#include <linux/bits.h>
> >  
> > -#ifdef	__KERNEL__
> > -#define BIT(nr)			(1UL << (nr))
> > -#define BIT_ULL(nr)		(1ULL << (nr))
> > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > -#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > -#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > -#define BITS_PER_BYTE		8
> >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> > -#endif
> 
> Why does it leave BITS_TO_LONGS() in place?
> 
> That becomes unfortunate with Chris's patch, so I'm moving
> BITS_TO_LONGS() into bits.h.

The reason I avoided that was because it would pull in the dreaded
kernel.h for DIV_ROUND_UP, and then we're back to circular include hell :(

Will


> From: Chris Wilson <chris@chris-wilson.co.uk>
> Subject: include/linux/bitops.h: introduce BITS_PER_TYPE
> 
> net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
> number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the macro
> to bitops.h, alongside BITS_PER_BYTE, for wider usage.
> 
> Link: http://lkml.kernel.org/r/20180706094458.14116-1-chris@chris-wilson.co.uk
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Gospodarek <gospo@broadcom.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/bitops.h  |    3 ++-
>  include/linux/net_dim.h |    1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN include/linux/bitops.h~bitops-introduce-bits_per_type include/linux/bitops.h
> --- a/include/linux/bitops.h~bitops-introduce-bits_per_type
> +++ a/include/linux/bitops.h
> @@ -11,7 +11,8 @@
>  #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
>  #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
>  #define BITS_PER_BYTE		8
> -#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> +#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
> +#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #endif
>  
>  /*
> diff -puN include/linux/net_dim.h~bitops-introduce-bits_per_type include/linux/net_dim.h
> --- a/include/linux/net_dim.h~bitops-introduce-bits_per_type
> +++ a/include/linux/net_dim.h
> @@ -363,7 +363,6 @@ static inline void net_dim_sample(u16 ev
>  }
>  
>  #define NET_DIM_NEVENTS 64
> -#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>  #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
>  
>  static inline void net_dim_calc_stats(struct net_dim_sample *start,
> _
> 
