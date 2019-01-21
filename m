Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ADBC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E15521019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgcA+zu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfAUQaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:30:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39956 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfAUQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:30:12 -0500
Received: by mail-io1-f65.google.com with SMTP id k2so16828089iog.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eADEIz0iwznb0TSre1LvJOXMgvWd8rOdZ80eJVALlOs=;
        b=IgcA+zu/3zhC1gBAyy/mGl+AwjUvef+boE7Zb66yOFc2qibmGG0Jh5Z74HkztTdSgB
         jZasnWUu68LFhIBBQvxmkQgpvppzuKDU+u7crf4NfP1kjSK+PUB1MInPaxsqCRBF7MYP
         SCLHk/2buYs5nhGNikNiUQcrczAJtZqnnKZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eADEIz0iwznb0TSre1LvJOXMgvWd8rOdZ80eJVALlOs=;
        b=N2JKhJgAWPUIs4pZkRrG9l2E7nYQXuzJwtfaimRziIdqqqc5Bbkb37KZIMRktAVZ3X
         wPU7DIf6gnqNRRhOqFOKmWGNG9zsetnJNz7nfRigxWH9XN8CrUWye7uiC1xDmyVX3IOt
         KIUrmoh6MkndAYCJyCzmjNWxd/bHYe372QegMUWru79TQHZHydM4A+YG2sU8jEdUmKn7
         sGuWnLgyFNwg+Ss/1kkP6/pzkhK6faDOrVOHVxWoBnKXrpp2VgCefPjdrHCcLUow468H
         2qcC0IHTsPOAAnHl65fl1tOE3NWYjDMTJtpo5GkNqpHXdLjTSyscCQh0SO9a6k+SYOH9
         BX0Q==
X-Gm-Message-State: AJcUukeHAZ6H4VqJRJ6NoGaWyIsVUOPk7Og/bUC/p2YCsZVdp0PYcbkb
        7jkzsG3VGOf/8DzEyg9qp5NGBlA3TtkPIi3eXNP9pQ==
X-Google-Smtp-Source: ALg8bN6Rwa3oE2P3hjVFSiGUF+4UztXQttKfRRYjOU/YoQyoCIqQxA/Gv1+ltfJOi0INVe0/3LG6Rsu6cJl+GSieOmc=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr16148051iob.170.1548088211443;
 Mon, 21 Jan 2019 08:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
In-Reply-To: <20190121162238.GA17651@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 17:30:00 +0100
Message-ID: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
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

On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:14:37PM +0100, Ard Biesheuvel wrote:
> > > I'll add big fat comments.  But the fact that nothing is exported
> > > there should be a fairly big hint.
> > >
> >
> > I don't follow. How do other header files 'export' things in a way
> > that this header doesn't?
>
> Well, I'll add comments to make it more obvious..
>
> > As far as I can tell, these drivers allocate DMA'able memory [in
> > ttm_tt_populate()] and subsequently create their own CPU mappings for
> > it, assuming that
> > a) the default is cache coherent, so vmap()ing those pages with
> > cacheable attributes works, and
>
> Yikes.  vmaping with different attributes is generally prone to
> create problems on a lot of architectures.
>

Indeed. But if your starting point is the assumption that DMA is
always cache coherent, those vmap() attributes are never different.

> > b) telling the GPU to use NoSnoop attributes makes the accesses it
> > performs coherent with non-cacheable CPU mappings of those physical
> > pages
> >
> > Since the latter is not true for many arm64 systems, I need this patch
> > to get a working system.
>
> Do we know that this actually works anywhere but x86?
>

In theory, it could work on arm64 systems with stage2-only SMMUs and
correctly configured PCIe RCs that set the right AMBA attributes for
inbound transactions with the NoSnoop attributes set.

Unfortunately, it seems that the current SMMU ARM code will clobber
those AMBA attributes when it uses stage1 mappings, since it forces
the memory attributes to WBWA for cache coherent devices.

So, as I pointed out in the commit log, the main difference between
x86 and other arches it that it can easily tolerate when NoSnoop is
non-functional.

> In general I would call these above sequence rather bogus and would
> prefer we could get rid of such antipatterns in the kernel and just use
> dma_alloc_attrs with DMA_ATTR_WRITECOMBINE if we want writecombine
> semantics.
>

Agreed.

> Until that happens we should just change the driver ifdefs to default
> the hacks to off and only enable them on setups where we 100%
> positively know that they actually work.  And document that fact
> in big fat comments.

Well, as I mentioned in my commit log as well, if we default to off
unless CONFIG_X86, we may break working setups on MIPS and Power where
the device is in fact non-cache coherent, and relies on this
'optimization' to get things working. The same could be true for
non-coherent ARM systems, hence my approach to disable this hack for
cache coherent devices on non-X86 only.
