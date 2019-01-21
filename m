Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C816C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqJjmLJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfAUPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:33:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33467 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfAUPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:33:39 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so16726920ioi.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uemtn1t3FusGviom3Dh6L2MT7Zfb+f7Orre/lzjRyI=;
        b=dqJjmLJ63qti8gqps928oPHwhz4UXR8Zg7gMXHKCSKejOYWYs6X4HDjuprvOTEipK/
         5IPDgT17lqfkNtm3c+dJFg2V0nw6+IZP5j4Ffbphx2OUzd3ATO2xJXHJKFXTwdHJV7+L
         asvNzX/0MWAOxqrqqdR+onUhXk+LMbMeMHKYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uemtn1t3FusGviom3Dh6L2MT7Zfb+f7Orre/lzjRyI=;
        b=i5ayOrYVSk2s3lEVflXK/dHdBz3Xq2y0X85OZqRKyQ7CxZ+Llbl29f5q3oKNeGtD+g
         pxWaRVKiUExuT/HhtmqdFqLi57FlesztIWamEwmh7xn2QhqdmKcjyoVVz1MpG1uUO+2O
         OHX7sCdk3J0haC9wCrJBm6BuDjmCy7lsB3PqcrU9ftyPxBia4vA7xqNq9hUSRAPhMS9z
         HL8lA+C5O+CdPD6exQA8ZJkJgT7EqbVcTY39tAKl7PnSR+K6l9Cyerhk2c2xQRUFsiNd
         JSqpeCJxKM4FvDHNu2sWD6LfQ9Vy6Dj47SLHQZb/FNVgRx3YDRS5Zd94+ZV4LpEFy5M2
         v2aQ==
X-Gm-Message-State: AJcUukd7kCuNLH5vXnglJHD40NMKQ49lcZF0w1lhMDAIFt4iU4OwOxx8
        eSNH+Vskq+5Ea3EaWi+0UX5eGao/pz+Jy8VhjIcBaw==
X-Google-Smtp-Source: ALg8bN6BOPBRpx5nfX8X+9cnontZPfCFuOoGD6HJnF+engMVzQRJWhho9dF3UZZ40q1C+vTzDrNH/r9mg90NxiQjops=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr17704386iop.60.1548084818958;
 Mon, 21 Jan 2019 07:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org> <20190121150734.GA30582@infradead.org>
In-Reply-To: <20190121150734.GA30582@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 16:33:27 +0100
Message-ID: <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
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

On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#include <linux/dma-noncoherent.h>
>
> This header is not for usage in device drivers, but purely for
> dma-mapping implementations!
>

Is that documented anywhere?

> > +static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
> >  {
> > +     if (IS_ENABLED(CONFIG_PPC))
> > +             return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
> > +     else if (IS_ENABLED(CONFIG_MIPS))
> > +             return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
> > +     else if (IS_ENABLED(CONFIG_X86))
> > +             return true;
> > +
> > +     return !dev_is_dma_coherent(ddev->dev);
>
> And even if something like this was valid to do, it would have to be
> a core function with an arch hook, and not hidden in a random driver.

Why would it not be valid to do? Is it wrong for a driver to be aware
of whether a device is cache coherent or not?

And in case it isn't, do you have an alternative suggestion on how to
fix this mess?
