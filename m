Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C927220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfAPAdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:33:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:60218 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfAPAdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:33:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0G0X6xW011333;
        Tue, 15 Jan 2019 18:33:08 -0600
Message-ID: <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
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
Date:   Wed, 16 Jan 2019 11:33:06 +1100
In-Reply-To: <87a7k2yx66.fsf@concordia.ellerman.id.au>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 22:31 +1100, Michael Ellerman wrote:
> > > As far as I know Power doesn't really supports un-cached memory at all, 
> > > except for a very very old and odd configuration with AGP.
> > 
> > Hopefully Michael/Ben can elaborate here, but I was under the (possibly
> > mistaken) impression that mismatched attributes could cause a machine-check
> > on Power.
> 
> That's what I've always been told, but I can't actually find where it's
> documented, I'll keep searching.
> 
> But you're right that mixing cached / uncached is not really supported,
> and probably results in a machine check or worse.

 .. or worse :) It could checkstop.

It's also my understanding that on ARM v7 and above, it's technically
forbidden to map the same physical page with both cached and non-cached 
mappings, since the cached one could prefetch (or speculatively load),
thus creating collisions and inconsistencies. Am I wrong here ?

The old hack of using non-cached mapping to avoid snoop cost in AGP and
others is just that ... an ugly and horrible hacks that should have
never eventuated, when the search for performance pushes HW people into
utter insanity :)

Cheers,
Ben.



