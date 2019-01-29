Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3EEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73720881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfA2KIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:08:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40826 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfA2KID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:08:03 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so11592379vsf.7;
        Tue, 29 Jan 2019 02:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmtYN+Y+9/kMBqbcdmfpKbwS13cIhsGC2vop/+2yPps=;
        b=o3whiTU3oTlYLeSM0GBD9lqPFO850z7UcDHKGZDglkaRZvds5SgRteZFb1Y910HZus
         dBK5tf1uTBza0xhUuGJULOCxWxrlBTI4ky/RNmk6CS2+fGG9An7cV3EKT8/BIhGZfsse
         4dT1vYtjgKk+xE4/0EObC16wtGpJkfzxYwe484Ml7Lp4BwoNz9iWwJVtXZgFC+yJYXea
         kbqiOZ/PvZ9ZFmBXLfr1k24HpwqUvDjh1gpA+qdTfhrV/HiKv9T13VKUne5GvbzNZuBa
         K0tNpc8HzY1V0nTsfFkqSsAA7l8a2+Jc7HiLJwVG+cOq3DgwTwKRautRnMGVaLRRjc3E
         soUQ==
X-Gm-Message-State: AJcUukf+2uz5fAt0+4D3gjXoariMHiL72bdiEj5KM2vWwgAs+mpbNI+t
        BsjQz5jXChy6PJhNUpl07wt8IniSM99WTETmtok=
X-Google-Smtp-Source: ALg8bN6CynnqX8TzCTlfkf4c5i5O464utx+fduG4CNzH6sX4rMaPS1kdHt/WuOxMDR2woWIw9SZBOPWWbGaaVIuY6Cc=
X-Received: by 2002:a67:3885:: with SMTP id n5mr9052126vsi.96.1548756482129;
 Tue, 29 Jan 2019 02:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20190126163220.26421-1-jonas@norrbonn.se> <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk> <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
 <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
 <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se> <CAMz4kuLOSx9mQ-RG9qqy9Qbor97Nj5oYdOgLg_dNfxFeT+XK5g@mail.gmail.com>
 <abb0749c-629f-5a81-1dba-0be260b0fb8d@norrbonn.se>
In-Reply-To: <abb0749c-629f-5a81-1dba-0be260b0fb8d@norrbonn.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Jan 2019 11:07:50 +0100
Message-ID: <CAMuHMdXyuWMPUdipwW0oQUdPLDyZhssZ1NHQfMF9hWTtMkTZ1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas, Baolin,

On Tue, Jan 29, 2019 at 10:50 AM Jonas Bonn <jonas@norrbonn.se> wrote:
> On 29/01/2019 10:35, Baolin Wang wrote:
> > On Tue, 29 Jan 2019 at 17:14, Jonas Bonn <jonas@norrbonn.se> wrote:
> >> On 29/01/2019 10:04, Baolin Wang wrote:
> >>> On Tue, 29 Jan 2019 at 05:28, Jonas Bonn <jonas@norrbonn.se> wrote:
> >>>> On 28/01/2019 19:10, Mark Brown wrote:
> >>>>> On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
> >>>>>
> >>>>>> @@ -164,6 +166,7 @@ struct spi_device {
> >>>>>>        char                    modalias[SPI_NAME_SIZE];
> >>>>>>        const char              *driver_override;
> >>>>>>        int                     cs_gpio;        /* chip select gpio */
> >>>>>> +    uint16_t                word_delay;     /* inter-word delay (us) */
> >>>>>
> >>>>> This needs some code in the core joining it up with the per-transfer
> >>>>> word delay similar to what we have for speed_hz and bits_per_word in
> >>>>> __spi_validate().  Then the controller drivers can just look at the
> >>>>> per-transfer value and support both without having to duplicate logic.
> >>>>>
> >>>>
> >>>> So spi_transfer already has a field word_delay and it's defined as
> >>>> _clock cycles_ to delay between words.  I defined word_delay in
> >>>> spi_device as _microseconds_ to delay along the lines of delay_usecs.
> >>>>
> >>>> Given that the inter-word delay is a function of the slave device speed
> >>>> and not of the SPI bus speed, I'm inclined to say that a time-based
> >>>> delay is what we want (to be independent of bus speed).  As such, I want
> >>>> to know if I should add word_delay_usecs to _both_ spi_transfer and
> >>>> spi_device?
> >>>>
> >>>> There's only one user of word_delay from spi_transfer.  Just looking at
> >>>> it quickly, it looks like it wants the word_delay in
> >>>> SPI-controller-clock cycles and not SCK cycles which seems pretty broken
> >>>> to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework
> >>>> that to be microseconds and do the calculation in the driver?
> >>>
> >>> The Spreadtrum SPI controller's word delay unit is clock cycle of the
> >>> SPI clock, since the SPI source clock can be changed, we can not force
> >>> user to know the real microseconds. But can we change it to a union
> >>> structure? not sure if this is a good way.
> >>
> >> OK, so it is the SPI clock.  That's good.  There's a comment in the
> >> driver that makes it look like it should be the source clock.
> >
> > Sorry for my unclear description, what I mean is that it is the SPI
> > source clock cycles.
> >
> >> The problem with a delay in clock cycles is that the faster the clock,
> >> the shorter the delay.  The delay is a property of the slave and the
> >> slave has a fixed internal clock.  This means that if we increase SCK we
> >> also need to increase the word_delay (in cycles) in order to give the
> >> slave the same amount of breathing room.
> >
> > Sorry for my confusing description, our case requires source clock
> > cycles for word delay.
>
> OK.  So the user (perhaps in userspace using spidev) has to know the
> rate of the IO clock that the SPI controller sits behind and then has to
> match this to the required delay of the slave device...  Doesn't sound
> very portable.

I can see the value of having both:
On some slaves, the delay may depend on a fixed internal or
external clock[1] on the SPI slave, so it should be specified in time units.
Some slaves may be clocked by the SPI clock[2], so the delay should be
specified in SPI clock cycles.

[1] For an external clock, the SPI slave driver may need to obtain a clock
    reference from DT, get its rate, and calculate the needed delay.
[2] I've seen hardware designs where the SPI clock had to be kept running all
    the time because of this.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
