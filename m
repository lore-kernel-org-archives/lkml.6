Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B258020859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hb7GBJZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfAPCeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:34:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40256 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfAPCeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:34:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so4123597lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GFQOZ7n26hJwTe+SbE/kil5VqtCXnuqCM7ZGqr2mBo=;
        b=Hb7GBJZL4fR/QbQLBKElHgx8/xv4vVFyNha9GmsCMiHigpT0J5Yie7qAtoCfEnHEVg
         t0o/uOwxzeZ7yIUhj6SR52SynSKmY7cA4p+u/uFugMPHbQ1KQgUI/SBMv7A1Hmjnsg4Z
         oquklbKJ5oSbP+Lr6Uyospy/f9YBLbc7Qlocw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GFQOZ7n26hJwTe+SbE/kil5VqtCXnuqCM7ZGqr2mBo=;
        b=U16ME+P7FvKat1v7sCeoapXp2BWTf2Ld/xGqUQb/O97tAxKUUYgzTI7/gFqxHsAion
         BDwb3p9xP4KvHvlixKgrw1kmEp1rGtaQQji4uiWlKLFSUe6NQnxPaYwt0gRV3vK5vMPQ
         z10oplg7GQNrxo6nsAb7av16eUV6Ysclb6s1ab6WXR41913xKZqLRlN1wsi1ycrIfg/a
         Qxl1EQKiglZLz/zH4HoHJwA+HBC3uPxF1wdkPz//OFWRf/ZGHpN7JStB4yjYQ9W83kok
         mHOlnhMD6wDLMhEMk6XUxkkBKh3Fu5HsJCwNKQp4Mn+UbxngqfoLunod/DtyGIqp1ObV
         kECQ==
X-Gm-Message-State: AJcUuke1c60RRq1GvtRNco7K/ExRREN6bXUe+dt1rAC4WizD6On08ZzX
        Ti3i3IFgeU8NezAVt8+obVRScV4HlDN+2AONZvNPlUitlQboFA==
X-Google-Smtp-Source: ALg8bN7sgfkIMS5UKhFAeCNZfLXbLpHHg9kExJEgoXJ8g+z62XB0QN1gGej16SQfMapGKF2gj2GHa8AUskXDNbEqI4o=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr5106444ljb.52.1547606058443;
 Tue, 15 Jan 2019 18:34:18 -0800 (PST)
MIME-Version: 1.0
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <324f3106dbff2f28baae098b05219f1384fda97a.1547559542.git.baolin.wang@linaro.org>
 <20190115143042.GB5522@sirena.org.uk>
In-Reply-To: <20190115143042.GB5522@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 16 Jan 2019 10:34:05 +0800
Message-ID: <CAMz4kuKOceVJ9vjq6Z3pZUXSg28RLXHhguJKSvyZPYFLYj_hWw@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: sprd: Add DMA mode support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 15 Jan 2019 at 22:30, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 15, 2019 at 09:46:53PM +0800, Baolin Wang wrote:
> > From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> >
> > Add DMA mode support for the Spreadtrum SPI controller, and we will enable
> > SPI interrupt to help to complete the SPI transfer work in DMA mode.
>
> Again this looks good, one thing to check though:
>
> > +static bool sprd_spi_can_dma(struct spi_controller *sctlr,
> > +                          struct spi_device *spi, struct spi_transfer *t)
> > +{
> > +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
> > +
> > +     return ss->dma.enable;
> > +}
>
> Is it always a benefit to use DMA?  One reason this is a function rather
> than just a property is that even if the device can DMA any size of
> transfer often for short transfers the performance is better if you use
> PIO since the overhead of setting up the DMA controller, waiting and
> then taking the interrupt when it finishes ends up being more than the
> cost of just reading and writing directly to the FIFOs for PIO.

Firstly we want to simplify the transfer, once we enable the DMA, we
always want to use DMA mode. But I think you are reasonable, we will
optimize the can_dma() ops for short transfers to improve the
performance. Thanks for your comments.

-- 
Baolin Wang
Best Regards
