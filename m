Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB282083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBEInK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:43:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33935 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:43:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so2192878ede.1;
        Tue, 05 Feb 2019 00:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxF7sxTcTVOmIXTNns+MzsXu9a/eBw2fG/LtQgY51Y4=;
        b=XRRrpwLkm7cv2LjPDIZSz1zT5qFzw/eC/N5Kvw5UmYl2cH0BeZ24mNPs1dQrB6XasK
         /QwaBhUgWTZZI7zmz32mfUPk4PJ72eocrte/l0po40YRHiY3S/QFQFXoyAn0fPLXOziz
         hJa8SiSoGoRw88QRvdMhY8TZKCkp0TiJypGHUZkcEy9MiQejmqpJaPcz0IOfQE2A3y1j
         jQDVtmals+gQiSMkMz+FZBedWxsp9d3lr2KZFtfFM7TUEaB6YNaTM50WYSBHKTeQbk7B
         ZLy1d5pMT0G6FpXu2ZNwaXykvGyVXw+4LL9bMg1och25L1L5Pr2tpuoIGNyqpDarOZfr
         YPrg==
X-Gm-Message-State: AHQUAuYeAwnQT9qNXVuaOHMhoG83j677PLK+krDrJKd4fTXZsd24l71/
        YlAMe8usII6lla/Yn11IxYXqi8D7224=
X-Google-Smtp-Source: AHgI3IYpknGpRRqA0WwPFkUDNOqAl1yorko3178Xj/dLydzFSFRU/HNrYHTkGMnr/vbvJPv+9pH9VQ==
X-Received: by 2002:a50:9f64:: with SMTP id b91mr2911942edf.235.1549356187598;
        Tue, 05 Feb 2019 00:43:07 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s58sm182655edb.64.2019.02.05.00.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 00:43:07 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id d15so2614987wmb.3;
        Tue, 05 Feb 2019 00:43:07 -0800 (PST)
X-Received: by 2002:a1c:23cc:: with SMTP id j195mr2600594wmj.124.1549356186727;
 Tue, 05 Feb 2019 00:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20190203155628.16767-1-wens@csie.org> <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea> <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
 <20190204134110.dvo3qvnhiksqig2l@flea>
In-Reply-To: <20190204134110.dvo3qvnhiksqig2l@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 5 Feb 2019 16:42:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
Message-ID: <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Chris Blake <chrisrblake93@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Feb 04, 2019 at 06:16:24PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > > > The MMC device tree bindings include properties used to signal various
> > > > signalling speed modes. Until now the sunxi driver was accepting them
> > > > without any further filtering, while the sunxi device trees were not
> > > > actually using them.
> > > >
> > > > Since some of the H5 boards can not run at higher speed modes stably,
> > > > we are resorting to declaring the higher speed modes per-board.
> > > >
> > > > Regardless, having boards declare modes and blindly following them,
> > > > even without proper support in the driver, is generally a bad thing.
> > > >
> > > > Filter out all unsupported modes from the capabilities mask after
> > > > the device tree properties have been parsed.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > ---
> > > >
> > > > This should be backported to stable kernels in case people try to run
> > > > new device trees (that declare newly supported modes) with old kernels.
> > > > ---
> > > >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > > > index 7415af8c8ff6..a01433012db0 100644
> > > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> > > >       if (ret)
> > > >               goto error_free_dma;
> > > >
> > > > +     /*
> > > > +      * If we don't support delay chains in the SoC, we can't use any
> > > > +      * of the DDR speed modes. Mask them out in case the device
> > > > +      * tree specifies the properties for them, which gets added to
> > > > +      * the caps by mmc_of_parse() above.
> > > > +      */
> > > > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > > > +             mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> > > > +                            MMC_CAP_1_2V_DDR);
> > > > +
> > > > +     /* TODO: UHS modes untested due to lack of supporting boards */
> > > > +     mmc->caps &= ~MMC_CAP_UHS;
> > >
> > > I've tested up to SDR104 and it works on the A64 at least
> >
> > That's good to know. What board was this on? I had given up hope waiting
> > for a vendor to produce a board that could do proper voltage switching for
> > SD cards.
>
> On a Sootech SoM, that had an HS400 eMMC and an SDR104 Marvell WiFi
> chip. I don't have that board anymore, and the website seems down now
> though :/

Bummer. So no commercially available board still. :/

> > > > +     /* TODO: This driver doesn't support HS200 and HS400 modes yet */
> > > > +     mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> > >
> > > And HS200 works too.
> >
> > OK. I thought there was some special magic required in the driver. Maybe
> > that was for HS400 only? Again, what board was this on?
>
> Yeah, that was for HS400 only

OK. So would unblocking UHS and HS200, but not enabling them by default,
which is essentially the original behavior, work for you?

If so, I'll respin a version tonight.

ChenYu
