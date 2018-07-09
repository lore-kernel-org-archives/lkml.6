Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC050C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A555920881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A555920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeGIWKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:10:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbeGIWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:10:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 622BEE78;
        Mon,  9 Jul 2018 22:10:07 +0000 (UTC)
Date:   Mon, 9 Jul 2018 15:10:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com
Subject: Re: [RESEND PATCH v2 3/9] asm-generic: Move some macros from
 linux/bitops.h to a new bits.h file
Message-Id: <20180709151006.370112d321c8f3df06bf231b@linux-foundation.org>
In-Reply-To: <20180709113250.GA26377@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
        <1529412794-17720-4-git-send-email-will.deacon@arm.com>
        <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
        <20180709113250.GA26377@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 12:32:51 +0100 Will Deacon <will.deacon@arm.com> wrote:

> Hi Andrew,
> 
> On Fri, Jul 06, 2018 at 05:30:49PM -0700, Andrew Morton wrote:
> > On Tue, 19 Jun 2018 13:53:08 +0100 Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > In preparation for implementing the asm-generic atomic bitops in terms
> > > of atomic_long_*, we need to prevent asm/atomic.h implementations from
> > > pulling in linux/bitops.h. A common reason for this include is for the
> > > BITS_PER_BYTE definition, so move this and some other BIT() and masking
> > > macros into a new header file, linux/bits.h
> > > 
> > > --- a/include/linux/bitops.h
> > > +++ b/include/linux/bitops.h
> > > @@ -2,29 +2,9 @@
> > >  #ifndef _LINUX_BITOPS_H
> > >  #define _LINUX_BITOPS_H
> > >  #include <asm/types.h>
> > > +#include <linux/bits.h>
> > >  
> > > -#ifdef	__KERNEL__
> > > -#define BIT(nr)			(1UL << (nr))
> > > -#define BIT_ULL(nr)		(1ULL << (nr))
> > > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > > -#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > > -#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > > -#define BITS_PER_BYTE		8
> > >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> > > -#endif
> > 
> > Why does it leave BITS_TO_LONGS() in place?
> > 
> > That becomes unfortunate with Chris's patch, so I'm moving
> > BITS_TO_LONGS() into bits.h.
> 
> The reason I avoided that was because it would pull in the dreaded
> kernel.h for DIV_ROUND_UP, and then we're back to circular include hell :(
> 

Well we should comment that so every reader doesn't wonder what I
wondered.

Refactoring works well.  I suppose DIV_ROUND_UP and friends await a new
<arithmacros.h>.

Also, all these macros no longer `#ifdef __KERNEL__' protection, which
wasn't mentioned in the changelog.  Deliberate?

