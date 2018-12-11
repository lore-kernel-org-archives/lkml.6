Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8277D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8277D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLKIma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:42:30 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40978 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeLKIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:42:30 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so8381926vsc.8;
        Tue, 11 Dec 2018 00:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOCeScDpJ+HUcMzfhApTNK8g4kv95VN6HJPOAn8Lzy4=;
        b=Z8bREjKYkTitZKdoVyzk6Aw221K/zp3DXRJAg9WWifFAJJ8lQm1f81/n7MOW61MT9l
         bV0ldBEBGkZhzR8PM4hxxKJU++nzeilOQHhrkLRPa/Jf0e/wnBs9owMge7ZZL9/DXUhe
         NEoKlUjwPYyNJJehZHn5hJ9pKVwtmKqgHj0epijUXJ3ld9psTGX7snaDISkLHk7a11lQ
         mt21GEtIZX+dXOgyqvLEJ1bAzJL+S2Tuq/btC+qjTfcVimMNPQxGF7xZqQLT3vaSJ/eA
         GpiPlA/6kbIqEfHKl76XZJrbXkRrQKb8b1s1wDSSKYUnBTGtcZsvGDhdbmrOy3n96IJq
         quyw==
X-Gm-Message-State: AA+aEWYOzAi8r8qZGr86HhL6+5X8OvWBNWxSCm6T36cT9iEWyyhLVg8T
        5K7fTT+SmEYh3L30UsdtIrxp4nP/FcDy/lLi2nc=
X-Google-Smtp-Source: AFSGD/VxnisM+g0tv4kR4ePqy60E12ufWlEyo3Kf/AAeVrCadES59ihg7kYGihpNthCVhEX5HFL9Vnhriw6egvczEIM=
X-Received: by 2002:a67:d119:: with SMTP id u25mr6357416vsi.63.1544517748420;
 Tue, 11 Dec 2018 00:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20181113133520.20889-1-geert+renesas@glider.be> <CAMuHMdX-X6dTJi6WgRKYVs-w+rxO3cJP8kX5AZwOXNO4qpgcqQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX-X6dTJi6WgRKYVs-w+rxO3cJP8kX5AZwOXNO4qpgcqQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Dec 2018 09:42:16 +0100
Message-ID: <CAMuHMdWVFUGPgaChSn2K3schA0uJJVjxs2Z4FB2hb1_UdW3FiA@mail.gmail.com>
Subject: Re: [PATCH v3] reset: Exclusive resets must be dedicated to a single
 hardware block
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Rob, Frank,

On Wed, Nov 28, 2018 at 10:28 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Nov 13, 2018 at 2:35 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > In some SoCs multiple hardware blocks may share a reset control.
> > The reset control API for shared resets will only assert such a reset
> > when the drivers for all hardware blocks agree.
> > The exclusive reset control API still allows to assert such a reset, but
> > that impacts all other hardware blocks sharing the reset.
> >
> > While the kernel doc comments clearly state that the API for shared
> > resets applies to reset controls which are shared between hardware
> > blocks, the exact meaning of exclusive resets is not documented.
> > Fix the semantic ambiguity with respect to exclusive access vs.
> > exclusive reset lines by:
> >   1. Clarifying that exclusive resets really are intended for use with
> >      reset controls which are dedicated to a single hardware block,
> >   2. Ensuring that obtaining an exclusive reset control will fail if the
> >      reset is shared by multiple hardware blocks, for both DT-based and
> >      lookup-based reset controls.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Question from Philipp for the DT maintainers:
> >
> >    "I'd still like to hear the device tree maintainers' opinion on
> >     parsing the whole DT for "resets" phandle properties to find shared
> >     resets like this."
>
> Mark, Rob: Ping?

Do you have any comments about this?
(In case you lost the link to the original patch:
 https://lore.kernel.org/lkml/20181113133520.20889-1-geert+renesas@glider.be/).

This is a safeguard dependency for "[PATCH v5] vfio: platform: Add
generic reset controller support"
(https://lore.kernel.org/lkml/20181113131508.18246-1-geert+renesas@glider.be/).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
