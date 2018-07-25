Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B100C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF88220852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF88220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeGYRSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:18:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41508 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbeGYRSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:18:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB1C80D;
        Wed, 25 Jul 2018 09:06:11 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EED13F575;
        Wed, 25 Jul 2018 09:06:11 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0E19F1AE1110; Wed, 25 Jul 2018 17:06:10 +0100 (BST)
Date:   Wed, 25 Jul 2018 17:06:10 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Galbraith <efault@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Linux-MM <linux-mm@kvack.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/10] mm: workingset: tell cache transitions from
 workingset thrashing
Message-ID: <20180725160610.GD6866@arm.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-3-hannes@cmpxchg.org>
 <CAK8P3a3Nsmt54-ed_gWNev3CBS6_Sv5QGOw4G0sY4ZXOi1R4_Q@mail.gmail.com>
 <20180723152323.GA3699@cmpxchg.org>
 <CAK8P3a15K-TXYuFX-ZsJiroqA1GWX2XS4ioZSjcjJYgh1b_xSA@mail.gmail.com>
 <20180723162735.GA5980@cmpxchg.org>
 <20180724150448.GA25412@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724150448.GA25412@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 04:04:48PM +0100, Will Deacon wrote:
> On Mon, Jul 23, 2018 at 12:27:35PM -0400, Johannes Weiner wrote:
> > On Mon, Jul 23, 2018 at 05:35:35PM +0200, Arnd Bergmann wrote:
> > > On Mon, Jul 23, 2018 at 5:23 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > index 1b18b4722420..72c9b6778b0a 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -611,11 +611,13 @@ void __init mem_init(void)
> > > >         BUILD_BUG_ON(TASK_SIZE_32                       > TASK_SIZE_64);
> > > >  #endif
> > > >
> > > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > >         /*
> > > 
> > > I tested it on two broken configurations, and found that you have
> > > a typo here, it should be 'ifdef', not 'ifndef'. With that change, it
> > > seems to build fine.
> > > 
> > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Thanks for testing it, I don't have a cross-compile toolchain set up.
> > 
> > ---
> 
> Thanks Arnd, Johannes. I can pick this up for -rc7 via the arm64 tree,
> unless it's already queued elsewhere?

I've pushed this to the arm64 for-next/fixes branch heading for -rc7.

Will
