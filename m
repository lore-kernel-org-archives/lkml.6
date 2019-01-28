Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A570CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB9D2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA1HlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:41:19 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44472 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA1HlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:41:19 -0500
Received: by mail-vs1-f66.google.com with SMTP id u11so9174148vsp.11;
        Sun, 27 Jan 2019 23:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3hMp/k6lyJ2mMVPABphaPNzEClKY7IR08jEaMktiXI=;
        b=FLp/dTtqy3s5xEWOlzRoVoMBD+rwBWig/mIAB3qJYln0RUxOrprzUMmDXm9teD2Iuk
         nyew3ldQGXfzneJfMssxnUOU0B1QhO/Y/zLcwa0BIbqL3zXaaUddsPxekMfT9Tao+54x
         W60DEwVXUkMroCVIPwXPw3I7uA6s7WZdAUC3CPmCdwdDCOPyrUTTPi0SXnL1QWuM5AKm
         aAO3evitFjk34GlEo0W78biVnQdDnJawUNhW0MkkObKYETCZ1LQPc3LGaq+Mp1/JtPr1
         zHMtlcj9eTrry7IURk5kbB4T0BxutCuBgGKDVqmhKQhZjGiBvpaLRV96mbDAP83LMHqw
         KAOQ==
X-Gm-Message-State: AJcUukdO2y3mnvGTCdrrFqLKCL/ynVEnT3ncgupePolODOd+wVf6qOY9
        k/vsMBqkel5nxnLYD+fcUndrO1Go3sm6Ml2W0fY=
X-Google-Smtp-Source: ALg8bN5z90acNY+H5tfMXyUwetZb5pQapgq9wX9E2aSVqHN8r9gRIQWoHI5rVRCD/sKSeeoC1XZOi69i8haFmvH4XZs=
X-Received: by 2002:a67:c202:: with SMTP id i2mr8117148vsj.11.1548661277503;
 Sun, 27 Jan 2019 23:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20190125114429.20066-1-jonas@norrbonn.se> <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se> <20190125174713.GA6939@sirena.org.uk>
 <20190125175031.GA25898@sirena.org.uk> <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com> <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
In-Reply-To: <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jan 2019 08:41:05 +0100
Message-ID: <CAMuHMdXQONq1UFuFHwny_xfAtxY7sOv2K3yi2i9T22OovMqFhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Sat, Jan 26, 2019 at 4:40 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> On 26/01/2019 11:25, Geert Uytterhoeven wrote:
> > On Sat, Jan 26, 2019 at 8:53 AM Jonas Bonn <jonas@norrbonn.se> wrote:
> >> On 25/01/2019 18:50, Mark Brown wrote:
> >>> On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
> >>>> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
> >>>>> Having this as device property rather than a transfer property allows this
> >>>>> to be configured one time in setup() rather than having to fiddle with the
> >>>>> configuration register for every transfer.
> >>>
> >>>> That doesn't mean that the coniguration should be done in DT though, and
> >>>> given that this presumably is a property of the device there seems to be
> >>>> no reason why we'd have it in DT - if every instance of the device is
> >>>> going to need to set the property we should just figure it out from the
> >>>> compatble string instead.
> >>>
> >>> To be clear here: the suggestion is to add a parameter the slave device
> >>> can set in spi_device which sets the default word_delay similarly to how
> >>> max_speed_hz works.
> >>
> >> I'm confused... isn't that exactly what this patch does?  It adds a
> >> field word_delay to spi_device in the same manner as max_speed_hz.
> >>
> >> I also added the ability to set it via DT, which I can break out into a
> >> separate patch if that's an issue.  Or is the problem that it's set via
> >> DT, at all?  Documentation/devicetree/bindings/spi-bus.txt documents 10
> >> other slave-node properties related to transfer characteristics;
> >> word_delay is just another such characteristic.
> >>
> >> But again, I'm having trouble parsing your response  Is the patch wrong,
> >> should be broken up, or you just misunderstood it?
> >
> > IIUIC, Mark means that it may be a non-configurable property of the slave
> > device, and thus should be handled (fixed setting) in the SPI slave driver.
>
> OK, so given that the "compatible" property identifies the hardware and
> there is no other _hardware_ configuration detail that affects the
> required inter-word delay, then setting the property in the device tree
> is not allowed as the driver has enough info to set it properly.  Fair
> enough!
>
> >
> > Compare this to CPHA/CPOL, which are properties of the SPI slave device,
> > but which may be configurable. E.g. many SPI FLASHes support multiple
> > configurations. See e.g. commit 9c5becce21af35e5 ("ARM: shmobile: koelsch:
> > Fix QSPI mode of SPI-Flash into mode3").
>
> There is nothing about the hardware referenced in that patch that
> enforces either mode.  Why does the driver get to defer to DT here?

The default is non-cpol and non-pha.
The device supports both (perhaps even all four modes, didn't check).

> Looking at Documentation/devicetree/bindings/spi/spi-bus.txt:
>
> spi-lsb-first:  used only by MAXIM DS-1302 which is always LSB first;
> driver should set this

For DS1302, this is probable true.
For e.g. a generic shift register (e.g. hc595), the driver cannot know.

> spi-3wire: again, only set by MAXIM DS-1302 which always needs this
> setting; driver could set this

For DS1302, this is probable true.
Some devices may support both 4-wire or 3-wire mode?

> spi-tx-delay-us:
> spi-rx-delay-us:  only parsed by RMI4 driver... no DTS files in kernel
> set these.  I hardly see how these are "hardware" settings rather than
> message settings, but the driver can set these in any case.
>
> Anyway, the point is, looking at the current documentation, it's pretty
> difficult to understand whether devicetree is restricted to describing
> hardware or is also for configuring drivers...

True.

> > Again, max_speed_hz is something different: while both the SPI master and
> > slave may support high speeds, board wiring (capacitance/inductance) may
> > need to force a slower speed than supported by the devices, so it makes
> > sense to make that configurable from DT.
>
> Yeah, that one make sense.  But if the DT is only overriding the maximum
> device frequency that the driver should otherwise be setting, why is
> spi-max-frequency a _required_ property?

That's a good question. Legacy?

> Thanks for taking the time to provide the additional explanation.  I had
> to ruminate on it for a bit, but I think it's starting to sink in now!

You're welcome!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
