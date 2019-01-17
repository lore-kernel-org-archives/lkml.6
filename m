Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7429CC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6FE20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfAQGH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:07:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:47316 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfAQGHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:07:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0H67KwY024177;
        Thu, 17 Jan 2019 00:07:22 -0600
Message-ID: <9d706807c93f88bc850153ae20ea28e6502e0aac.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bernhard =?ISO-8859-1?Q?Rosenkr=E4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>
Date:   Thu, 17 Jan 2019 17:07:20 +1100
In-Reply-To: <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
         <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
         <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
         <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
         <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
         <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
         <20190114191350.GA29600@fuggles.cambridge.arm.com>
         <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
         <20190114193548.GB29600@fuggles.cambridge.arm.com>
         <87a7k2yx66.fsf@concordia.ellerman.id.au>
         <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
         <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
         <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 08:47 +0100, Ard Biesheuvel wrote:
> > As far as I know on x86 it doesn't, so when you have an un-cached page
> > you can still access it with a snooping DMA read/write operation and
> > don't cause trouble.
> > 
> 
> I think it is the other way around. The question is, on an otherwise
> cache coherent device, whether the NoSnoop attribute set by the GPU
> propagates all the way to the bus so that it bypasses the caches.

On powerpc it's ignored, all DMA accesses will be snooped. But that's
fine regardless of whether the memory was mapped cachable or not, the
snooper will simply not find anything if not. I *think* we only do
cache inject if the line already exists in one of the caches.

> On x86, we can tolerate if this is not the case, since uncached memory
> accesses by the CPU snoop the caches as well.
> 
> On other architectures, uncached accesses go straight to main memory,
> so if the device wrote anything to the caches we won't see it.

Well, on all powerpc implementations that I am aware of at least (dunno
about ARM), they do, but we don't have a problem because I don't think
the devices can/will write to the caches directly unless a
corresponding line already exists (but I might be wrong, we need to
double check all implementations which is tricky).

I am not aware of any powerpc chip implementing NoSnoop.

> So to use this optimization, you have to either be 100% sure that
> NoSnoop is implemented correctly, or have a x86 CPU.
> 
> > > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > > others is just that ... an ugly and horrible hacks that should have
> > > never eventuated, when the search for performance pushes HW people into
> > > utter insanity :)
> > 
> > Well I agree that un-cached system memory makes things much more
> > complicated for a questionable gain.
> > 
> > But fact is we now have to deal with the mess, so no point in
> > complaining about it to much :)
> > 
> 
> Indeed. I wonder if we should just disable it altogether unless CONFIG_X86=y

The question is whether DMA from a device can instanciate cache lines
in your system. This a system specific rather than architecture
specific question I suspect...
 
Cheers,
Ben.


