Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DCC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A79E20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kj4FebBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfAUQOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:14:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33294 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfAUQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:14:50 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so16836123ioi.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJK1BCKSyDL+6Bnumrmgz0aFAHbUsIf0r+wdJw+CqMA=;
        b=Kj4FebBWF3IgYE59zzK25BcvMYseHgw2U55GKDu80LoJc/1no88VfZWlimZA92sHU/
         6z4nya+rz29tQfRHc4u4Wt+pAECUdo5iUyr2hhxn2hAkDZBP6J2HKgJfnHLekJzK1vIJ
         tlERyFoqq1KbB5gtnwr8uQra/yhMCIJnZ+jZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJK1BCKSyDL+6Bnumrmgz0aFAHbUsIf0r+wdJw+CqMA=;
        b=rTnqKSZOkzefKw2EHtWVOIWq6t2MvzkmJzdo2HUpEFyIgVoXE1qovIm/rwi6fh14Yz
         yZj451/N1tXXk4OexU9lhcXez7a1N/lDKX8nSc5zgQvdkgAeLMBHJddqNzxIgSWWSTIn
         NklED2yVWsyLWuVyLJ+A0fAKMcgIc46Y75gsl3tGH/hh+ES2CuqcmViaNmS8JxAAzbcL
         A+ETduWpJt3SSug75j8U2RrmdndgzJmriYxGfldjeiK68BI/eqxpdT3SIsmaAh+auoIq
         8kkQNgk6pX/wWgvLXoGrx+QU8gl6JnImEg5S/nWmVMwhZH/MXYMildUpX2LnojQmCcsH
         QG4g==
X-Gm-Message-State: AJcUukeMOmMC1osGgBdGUbL5c/LNqYWREqP9YdXZGKDs745UqxA5RCCs
        I713XdtNRnn/eLeqX9B8ZbM1KEHEZBOSv+YxoIubIQ==
X-Google-Smtp-Source: ALg8bN4kiLIcOotuv3Eol9fGHrSR9csRaV14VqHmTkDO6pNF4iUibro4vd5Dh/nvdiiHg+VbxvGt1HqX22lk+oQCMOk=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr17797491iop.60.1548087289131;
 Mon, 21 Jan 2019 08:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
In-Reply-To: <20190121155908.GA8084@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 17:14:37 +0100
Message-ID: <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 16:59, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 04:33:27PM +0100, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > > +#include <linux/dma-noncoherent.h>
> > >
> > > This header is not for usage in device drivers, but purely for
> > > dma-mapping implementations!
> > >
> >
> > Is that documented anywhere?
>
> I'll add big fat comments.  But the fact that nothing is exported
> there should be a fairly big hint.
>

I don't follow. How do other header files 'export' things in a way
that this header doesn't?

> > > And even if something like this was valid to do, it would have to be
> > > a core function with an arch hook, and not hidden in a random driver.
> >
> > Why would it not be valid to do? Is it wrong for a driver to be aware
> > of whether a device is cache coherent or not?
> >
> > And in case it isn't, do you have an alternative suggestion on how to
> > fix this mess?
>
> For the write combine mappings we need a proper core API how instances
> can advertise the support.  One thing I want to do fairly soon is
> error checking of the attrs argument to dma_alloc_attrs - so if you
> pass in something unsupported it will give you back an error.
>

That sounds useful.

> It seems that isn't quite enough for the drm use case, so we might
> also need a way to query these features, but that really has to go
> through the usual dma layer abstraction as well and not hacked together
> in a driver based on an eduacted guestimate.

As far as I can tell, these drivers allocate DMA'able memory [in
ttm_tt_populate()] and subsequently create their own CPU mappings for
it, assuming that
a) the default is cache coherent, so vmap()ing those pages with
cacheable attributes works, and
b) telling the GPU to use NoSnoop attributes makes the accesses it
performs coherent with non-cacheable CPU mappings of those physical
pages

Since the latter is not true for many arm64 systems, I need this patch
to get a working system.

So how do you propose we proceed to get this fixed? Does it have to
wait for this proper core API plus followup changes for DRM?
