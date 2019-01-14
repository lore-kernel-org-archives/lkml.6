Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E44C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7462205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpFJBDE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfANKxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:53:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50807 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfANKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:53:25 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so12353688iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PuyA1u1/e7dZRU052cjFTRNGgKhojhL2AZTNPERZL5I=;
        b=fpFJBDE39PjXMWkep9AhPsABN0vTdzodyp1zEVZhf+jCAKAzp26ZobH+/R+IOtepgX
         lxqwxo3ZPSsY+SpWbNo6oj2c2+vRdH/Q/b3CFYL2TQQgpcwe17s/OxtTANO53DEa0Nb9
         CU64Dm+dadpc1smGvaiLTB0jXv3R4DeuVdy4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PuyA1u1/e7dZRU052cjFTRNGgKhojhL2AZTNPERZL5I=;
        b=J5a+GvKLPbUZbPBQAjTuKBV8AqUJFeXF2Zhh4oBs0JswlWmEe7ZpKz7iBEL5Njylwa
         l2xct0y5rmhobCioli1P0HnnWXy6rSYEiEoROMguHfuGb6unZr0nq4UiOFEYl8yYFwVD
         28qBQc88PKnLlZHM1kz83L19xTqTF08vdxk+quMyj5SxOdz+xW3xAIMkuWhWUnCe5wXU
         n/0Wz4200hmlGGvREiiflcS0Y7QjgmP530Qnr5vD6IEASM/8cpA8nKy9gW/2o9Bv3v/W
         19TVwJTZYKfaA6ubGp5F9tjXDFMWbvBLv4d9ED8MF73bpvGxzb15QEw0dguXxsNyUd0Y
         GPlA==
X-Gm-Message-State: AJcUukcr43qXMJawbBYE6eN8rTxQDDFnXLDcdiU994B9exitvHlZ3mbD
        7pO0ezVmr95m2qFIJIEyZU4wzREsoWs3bhlPU538yg==
X-Google-Smtp-Source: ALg8bN4raaoENgV3w+bjfpA789pOoeoWVVjhiC2FaGQOzen/K53GNT7+rZ8m4kif+5VR/OzymM0mFWmZ9E7bNlHlyW0=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr16806810jab.2.1547463204348;
 Mon, 14 Jan 2019 02:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org> <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
In-Reply-To: <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Jan 2019 11:53:13 +0100
Message-ID: <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 10:34, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-10 8:28 a.m., Ard Biesheuvel wrote:
> > ARM systems do not permit the use of anything other than cached
> > mappings for system memory, since that memory may be mapped in the
> > linear region as well, and the architecture does not permit aliases
> > with mismatched attributes.
> >
> > So short-circuit the evaluation in ttm_io_prot() if the flags include
> > TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
> > attributes immediately.
> >
> > This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
> > Without this change, amdgpu does not start at all, and radeon only
> > produces corrupt display output.
> >
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/tt=
m_bo_util.c
> > index 046a6dda690a..0c1eef5f7ae3 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgpro=
t_t tmp)
> >       if (caching_flags & TTM_PL_FLAG_CACHED)
> >               return tmp;
> >
> > +#if defined(__arm__) || defined(__aarch64__)
> > +     /* ARM only permits cached mappings of system memory */
> > +     if (caching_flags & TTM_PL_SYSTEM)
> > +             return tmp;
> > +#endif
> >  #if defined(__i386__) || defined(__x86_64__)
> >       if (caching_flags & TTM_PL_FLAG_WC)
> >               tmp =3D pgprot_writecombine(tmp);
> >
>
> Apart from Christian's concerns, I think this is the wrong place for
> this, because other TTM / driver code will still consider the memory
> uncacheable. E.g. the amdgpu driver will program the GPU to treat the
> memory as uncacheable, so it won't participate in cache coherency
> protocol for it, which is unlikely to work as expected in general if the
> CPU treats the memory as cacheable.
>

Will and I have spent some time digging into this, so allow me to
share some preliminary findings while we carry on and try to fix this
properly.

- The patch above is flawed, i.e., it doesn't do what it intends to
since it uses TTM_PL_SYSTEM instead of TTM_PL_FLAG_SYSTEM. Apologies
for that.
- The existence of a linear region mapping with mismatched attributes
is likely not the culprit here. (We do something similar with
non-cache coherent DMA in other places).
- The reason remapping the CPU side as cacheable does work (which I
did test) is because the GPU's uncacheable accesses (which I assume
are made using the NoSnoop PCIe transaction attribute) are actually
emitted as cacheable in some cases.
  . On my AMD Seattle, with or without SMMU (which is stage 2 only), I
must use cacheable accesses from the CPU side or things are broken.
This might be a h/w flaw, though.
  . On systems with stage 1+2 SMMUs, the driver uses stage 1
translations which always override the memory attributes to cacheable
for DMA coherent devices. This is what is affecting the Cavium
ThunderX2 (although it appears the attributes emitted by the RC may be
incorrect as well.)

The latter issue is a shortcoming in the SMMU driver that we have to
fix, i.e., it should take care not to modify the incoming attributes
of DMA coherent PCIe devices for NoSnoop to be able to work.

So in summary, the mismatch appears to be between the CPU accessing
the vmap region with non-cacheable attributes and the GPU accessing
the same memory with cacheable attributes, resulting in a loss of
coherency and lots of visible corruption.

To be able to debug this further, could you elaborate a bit on
- How does the hardware emit those uncached/wc inbound accesses? Do
they rely on NoSnoop?
- Christian pointed out that some accesses must be uncached even when
not using WC. What kind of accesses are those? And do they access
system RAM?
