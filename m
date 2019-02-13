Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6430C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3212175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392969AbfBMRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:25:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57764 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733301AbfBMRZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:25:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13575A78;
        Wed, 13 Feb 2019 09:25:36 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780243F675;
        Wed, 13 Feb 2019 09:25:34 -0800 (PST)
Date:   Wed, 13 Feb 2019 17:25:30 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.murray@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/2] arm64: io: Hook up __io_par() for inX() ordering
Message-ID: <20190213172528.GI6346@brain-police>
References: <20190211174544.4302-1-will.deacon@arm.com>
 <20190211174544.4302-3-will.deacon@arm.com>
 <CAMuHMdWFOvrZ5JwgWnx9ujg3dS-75PnjGRqn-vzGmFi295Sb=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWFOvrZ5JwgWnx9ujg3dS-75PnjGRqn-vzGmFi295Sb=A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:42:44AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 11, 2019 at 9:34 PM Will Deacon <will.deacon@arm.com> wrote:
> > Ensure that inX() provides the same ordering guarantees as readX()
> > by hooking up __io_par() so that it maps directly to __iormb().
> >
> > Reported-by: Andrew Murray <andrew.murray@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >                      : "memory");                                       \
> >  })
> >
> > +#define __io_par               __iormb
> 
> I think it makes sense to make the parameter passing explicit, for
> documentation purposes:
> 
>     #define __io_par(v)        __iormb(v)

Thanks, I'll make that change for v2.

Will
