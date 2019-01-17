Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5972C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE6520657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfAQGAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:00:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:57491 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfAQGAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:00:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0H5xrlO023594;
        Wed, 16 Jan 2019 23:59:54 -0600
Message-ID: <db8cd68b82cda0ee0d352fdb709a76151798f9f5.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Date:   Thu, 17 Jan 2019 16:59:53 +1100
In-Reply-To: <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 07:35 +0000, Koenig, Christian wrote:
> No, but you answer the wrong question.
> 
> See we don't want to have different mappings of cached and non-cached on 
> the CPU, but rather want to know if a snooped DMA from the PCIe counts 
> as cached access as well.
> 
> As far as I know on x86 it doesn't, so when you have an un-cached page 
> you can still access it with a snooping DMA read/write operation and 
> don't cause trouble.

Hrm... well, if you map it uncached on the CPU on powerpc, a snoop DMA
will work fine too, it won't hit any cache. The only problem I'm aware
of is a core (or CAPI device) emiting non-cached load/stores colliding
with a cache snooper.

> > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > others is just that ... an ugly and horrible hacks that should have
> > never eventuated, when the search for performance pushes HW people into
> > utter insanity :)
> 
> Well I agree that un-cached system memory makes things much more 
> complicated for a questionable gain.
> 
> But fact is we now have to deal with the mess, so no point in 
> complaining about it to much :)

I wish we could just sent the HW designers home and tell them we won't
support that crap... oh well.

Ben.

> Cheers,
> Christian.
> 
> > Cheers,
> > Ben.
> > 
> > 

