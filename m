Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E3820873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnPGUvLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfAPCV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:21:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32839 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAPCV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:21:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so4144345ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 18:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BlBnLja76Yd8rV6sbMxyl08TUqH/aWtlQ1PRU4pYhM=;
        b=bnPGUvLDgLMPFM+fRUeMP2pKiBOsrB1lzLFEkLed6MVfC0TS7hopsreBjYNzWam6Ui
         cMq9Rmsj+p3CEQRcBgTNs+iEAhUYz3xbAORdGq/rE9GcZ84eBgF8h0wu6S6ZVUBNYD9b
         +tQyoUfjeX1SnxT+t32kGpK0LRBvpqzbNqono=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BlBnLja76Yd8rV6sbMxyl08TUqH/aWtlQ1PRU4pYhM=;
        b=E51EleJTunuoxFsBjg/5uS59LtscQo6n/KQ0phG0ggT7Z4QPA0kLpRKpFLjdEXowq3
         Zk6hymER5Vo4MvDAKNbaSA81LXla3VDtDt28Ubk71M3B6mpB8XDWOeCW3hd0CNPzZ927
         z0aVmUa01I+Zk3Hf8lF61MjpBYiUksmtZ3xhrM1iQpWXeq1K02csL7bZWAmGhTBBtaWL
         a4RBpJH9skWtBu3mvYwVoeD/EfEgvpqJZ8DcBvFnpVuM0kF8HDaA6HEOV1Wjg5WbCY+P
         3drT4iKJGmTA3IFjEUgKtoqgDVk7O06Yw3JDigtlVHOuNJl36mnU1iKV/5CbZ6vwGpYs
         wV7g==
X-Gm-Message-State: AJcUukdIH8cgrPjMNJ7+Tfm8oH9ZlyqEn4z4yrRB0fF0HJHokhbCdE56
        y794t/aploYfik4F8PaYSFOW6be6g1R/TG1XWzAntw==
X-Google-Smtp-Source: ALg8bN6t0XWOADkwcYvfbuQvB4iD52Ro8JGqB5Iui0c7bXVzNXkM1lCrRof+SIWcWXFRPaVSRRuFyjvbGsdRbIMosSU=
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr5200782lje.78.1547605314038;
 Tue, 15 Jan 2019 18:21:54 -0800 (PST)
MIME-Version: 1.0
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
 <20190115142452.GA5522@sirena.org.uk>
In-Reply-To: <20190115142452.GA5522@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 16 Jan 2019 10:21:42 +0800
Message-ID: <CAMz4ku+nky4YSFjjQ5BGJRCFQHCnXysh+_C7FmFF5YpdpDbZuA@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: sprd: Add the SPI irq function for the SPI DMA mode
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

On Tue, 15 Jan 2019 at 22:25, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 15, 2019 at 09:46:51PM +0800, Baolin Wang wrote:
>
> This looks good, just one small issue and a thing to check:
>
> > +static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
> > +{
> > +     struct sprd_spi *ss = (struct sprd_spi *)data;
> > +     u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
> > +
> > +     if (val & SPRD_SPI_MASK_TX_END) {
> > +             writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> > +             if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
> > +                     complete(&ss->xfer_completion);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     if (val & SPRD_SPI_MASK_RX_END) {
> > +             writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> > +             complete(&ss->xfer_completion);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
>
> This will return IRQ_HANDLED no matter if there was an interrupt
> actually handled.  That means that if something goes wrong due to some
> bug or a hardware change (eg, a new version of the IP) and there's
> another interrupt fired we won't clear it and the interrupt core won't
> be able to detect that it's a spurious interrupt and use its own error
> handling.  It's better to return IRQ_NONE in that case.

Yes, you are correct and will fix in next version.

> > +     ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
> > +                             0, pdev->name, ss);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
> > +                     ss->irq, ret);
>
> Are you sure it's safe to use devm_request_irq(), especially when
> unloading the driver?  Using it means that we will only disable the
> interrupt after the driver's remove function has finished so there's a
> danger of an interrupt firing when some of the resources the hander has
> used are still in use.  I didn't spot any issues, just something to
> check especially with the later patches building on top of this.

Yes, we missed this issue, thanks for pointing out this. After some
discussion with Lanqing, we think we need call the
spi_controller_suspend() manually in remove function to avoid this
issue.

Thanks for your comments.

-- 
Baolin Wang
Best Regards
