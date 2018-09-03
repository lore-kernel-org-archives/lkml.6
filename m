Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B454C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1EA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1EA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeICRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:11:54 -0400
Received: from foss.arm.com ([217.140.101.70]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeICRLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E32EE18A;
        Mon,  3 Sep 2018 05:51:52 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3F3A3F5BC;
        Mon,  3 Sep 2018 05:51:52 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 647BD1AE3030; Mon,  3 Sep 2018 13:52:06 +0100 (BST)
Date:   Mon, 3 Sep 2018 13:52:06 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180903125205.GA12642@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
 <20180831095417.GF13166@arm.com>
 <20180831101014.GG24124@hirez.programming.kicks-ass.net>
 <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:32:34PM +1000, Nicholas Piggin wrote:
> On Fri, 31 Aug 2018 12:10:14 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Aug 31, 2018 at 10:54:18AM +0100, Will Deacon wrote:
> > 
> > > Proposal below (omitted Linus because that seems to be the pattern elsewhere
> > > in the file and he's not going to shout at himself when things break :)
> > > Anybody I've missed?
> > > 
> > > Will
> > >   
> > > --->8  
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a5b256b25905..7224b5618883 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9681,6 +9681,15 @@ S:	Maintained
> > >  F:	arch/arm/boot/dts/mmp*
> > >  F:	arch/arm/mach-mmp/
> > >  
> > > +MMU GATHER AND TLB INVALIDATION
> > > +M:	Will Deacon <will.deacon@arm.com>
> > > +M:	Nick Piggin <npiggin@gmail.com>
> 
> Oh gee, I suppose. powerpc hash is kind of interesting because it's
> crazy, Aneesh knows that code a lot better than I do. radix modulo
> some minor details of exact instructions is fairly like x86 (he 
> wrote a lot of that code too AFAIK).

Sure, as long as we have Power represented here. Would you rather add Aneesh
instead of yourself, or shall we just add you both?

> 
> > > +M:	Peter Zijlstra <peterz@infradead.org>
> > > +L:	linux-arch@vger.kernel.org
> 
> Maybe put linux-mm as well? Or should there just be one list?

If we do the landgrab on mmu_gather (which I think makes sense), then adding
both lists makes sense to me. I'll spin this as a proper patch, along with
Peter's code move.

> > > +S:	Maintained
> > > +F:	include/asm-generic/tlb.h
> > > +F:	arch/*/include/asm/tlb.h
> > > +
> > >  MN88472 MEDIA DRIVER
> > >  M:	Antti Palosaari <crope@iki.fi>
> > >  L:	linux-media@vger.kernel.org  
> > 
> > If we're going to do that (and I'm not opposed); it might make sense to
> > do something like the below and add:
> > 
> >  F:  mm/mmu_gather.c
> 
> I think that is a good idea regardless. How do feel about calling it
> tlb.c? Easier to type and autocompletes sooner.

No strong opinion on name, but I slightly prefer mmu_gather.c so that it
avoids any remote possibility of confusion with tlb.c vs hugetlb.c

Will
