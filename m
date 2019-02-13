Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F86C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QcSjRneJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfBMM47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:56:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBMM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+NT5Rcwx9cDhCxGk/cu6DPM2aO1BZQkjAz/mnvLz4pA=; b=QcSjRneJKUsjFWLeAl4bn8W72
        2KI+/U5CQBokktqfCnYbaj2dIXr0npywZhC/nH4UdslJbS2LQzf652eT+aiwq//kG/388rqRZ0hxv
        2VeJ8Yh0mY6vqydP1QZxoe8KIyM+vDLgFi3SA5UuDzcrDH8kcKD159bq9w0pF9/OA/X9NVGCf6uEc
        L+pex8HC0IFsDhn5iWgMWkKQsg7y5TjMyjvFn+jtjmNgWnUyq0sPFWzjAUJJigi8jTh+Zqqxwpvmc
        KfOBINYLfBP4RHL6WrkJGlYZyoukN7DVAMG8ptYC7D7j9h7xJJD+EiEU1TbOfiYOuzFlOj1qgpjkJ
        qJ+BAVOjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtu5t-0007JR-IK; Wed, 13 Feb 2019 12:56:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A9BE20D0C1DB; Wed, 13 Feb 2019 13:56:51 +0100 (CET)
Date:   Wed, 13 Feb 2019 13:56:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Message-ID: <20190213125651.GP32494@hirez.programming.kicks-ass.net>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:45:53AM -0800, Vineet Gupta wrote:
> +CC some folks interested in alignment stuff in the past.
> 
> On 2/12/19 9:30 AM, David Laight wrote:
> > From:  Vineet Gupta
> >> Sent: 12 February 2019 17:17
> >>
> >> On 2/8/19 2:55 AM, Alexey Brodkin wrote:
> >>> By default ARCH_SLAB_MINALIGN is defined in "include/linux/slab.h" as
> >>> "__alignof__(unsigned long long)" which looks fine but not for ARC.
> >>
> >> Just for the record, the issue happens because a LLOCKD (exclusive 64-bit load)
> >> was trying to use a 32-bit aligned effective address (for atomic64_t), not allowed
> >> by ISA (LLOCKD can only take 64-bit aligned address, even when the CPU has
> >> unaligned access enabled).
> >>
> >> This in turn was happening because this word is embedded in some other struct and
> >> happens to be 4 byte aligned
> >>
> >>
> >>> ARC tools ABI sets align of "long long" the same as for "long" = 4
> >>> instead of 8 one may think of.
> > 
> > Right, but __alignof__() doesn't have to return the alignment that would
> > be used for a data item of the specified type.
> > (Read the gcc 'bug' info for gory details.)
> > 
> > On i386 __alignof__(long long) is 8, but structure members of type 'long long'
> > are 4 byte aligned and the alignment of a structure with a 'long long' member
> > is only 4.
> > (Although the microsoft compiler returns 4.)
> 
> Exactly my point that this fudging of outer alignment is no magic bullet.

IMO (and yes I knew about that i386 thing) this is just plain wrong. Of
course we'll have to live with that crap, but that doesn't make it less
crap.

> >> Right, this was indeed unexpected and not like most other arches. ARCv2 ISA allows
> >> regular 64-bit loads/stores (LDD/STD) to take 32-bit aligned addresses. Thus ABI
> >> relaxing the alignment for 64-bit data potentially causes more packing and less
> >> space waste. But on the flip side we need to waste space at arbitrary places liek
> >> this.
> >>
> >> So this is all good and theory, but I'm not 100% sure how slab alignment helps
> >> here (and is future proof). So the outer struct with embedded atomic64_t was
> >> allocated via slab and your patch ensures that outer struct is 64-bit aligned ?
> > 
> > Presumable 'atomic64_t' has an alignment attribute to force 8 byte alignment.
> 
> It does for ARC
> 
> typedef struct {
>         aligned_u64 counter;
> } atomic64_t;

Note that atomic*_t is signed; also note that it doesn't matter in
practise because -fno-strict-overflow.

Personally I think u64 and company should already force natural
alignment; but alas. I though that was part of the reason we have __u64
and co., so that ABI is invariant to kernel alignment changes.

> >> But how does that guarantee that all embedded atomic64_t in there will be 64-bit
> >> aligned (in future say) in the light of ARC ABI and the gcc bug/feature which
> >> Peter alluded to
> >>
> >>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54188
> >>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10360

I strongly agree with all those that say __alignof__ is broken and argue
for the C11 _Alignof/alignof semantics.

In particular I think that:

T x;

struct foo {
	T x;
};

alignof(x) == alignof(foo::x)

And:

    Aggregates (structures and arrays) and unions assume the alignment
    of their most strictly aligned component.

Otherwise none of this is remotely usable.

> >>> Thus slab allocator may easily allocate a buffer which is 32-bit aligned.
> >>> And most of the time it's OK until we start dealing with 64-bit atomics
> >>> with special LLOCKD/SCONDD instructions which (as opposed to their 32-bit
> >>> counterparts LLOCK/SCOND) operate with full 64-bit words but those words
> >>> must be 64-bit aligned.
> >>
> >> Some of this text needed to go above to give more context.
> > 
> > I suspect the slab allocator should be returning 8 byte aligned addresses
> > on all systems.... 
> 
> why ? As I understand it is still not fool proof against the expected alignment of
> inner members. There ought to be a better way to enforce all this.

I agree that for ARC ARCH_SLAB_MINALIGN should be at least 8.

In the past I've proposed a GCC plugin / checker that would verify the
alignment requirements against the various allocators.

For instance:

struct foo {
	spinlock_t a;
	int b;
} __cacheline_aligned;

struct foo *my_foo = kmalloc(sizeof(struct foo), GFP_KERNEL);

would result in a warning; because obviously kmalloc (as per
ARCH_SLAB_MINALIGN) doesn't respect the cacheline alignment of the type.

Of course; it appears our kmalloc() function definition doesn't even
have a __malloc attribute, so there's plenty work to be done here.

