Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A47DC282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E082087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfA3IPY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:15:24 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37227 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3IPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:15:23 -0500
Received: by mail-vk1-f195.google.com with SMTP id 197so5156418vkf.4;
        Wed, 30 Jan 2019 00:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+N6Rk2K1jL2HQ9JBwCNGKAfYi7+JofDy8avnGdCOpyU=;
        b=K3joMNalQpHtQ/DyJ9c+CFEfVw40UKFPnAdly+XsVErYAwXhvss68oUJyyzgT3Exib
         7wN1tKEjx5GFjMmolxZ0fnxpOSS8XhnMtoUjO4Z8MQVbDMNZtEDP+V+MSxo7v9+qi7Oh
         EWsS+RCR8ceNBizJdfUWwilqLtFokQrpD9T5tsJBw+gGjbwyssIjFYT6T6sZ7KPCR26g
         GqT0dNxQ10dRD9Of1rEI+d6wV11F6rA4Qn2bW+ws8BgaJD7kUS3OFq1DlQS8XYyz0F7x
         RWvmvRaNwkVaY4ufRvDUAW8MpkBfrKm/KEu0f3VkXhG4BPEWWKdyZhUkpc7SUTKQqUOI
         xqGg==
X-Gm-Message-State: AJcUukeiBLUScr65IosAGv2r4l+ic0LaO33vibjqp/naSHwhOnRVLN6b
        52wBt7TZyRc9KeUkhbu1gzq/87Bj6I/d9TBq/FU=
X-Google-Smtp-Source: ALg8bN5Hhv42eB8Yb3QL4LpTCYzYkQ5gbZF888AsS5iKBkmqyxn4ImSuHQsE7IpR7T69kVbenS+rBRsSecSV57svt2k=
X-Received: by 2002:a1f:a414:: with SMTP id n20mr12133690vke.83.1548836121686;
 Wed, 30 Jan 2019 00:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20190129205502.7741-1-jonas@norrbonn.se> <20190129205502.7741-2-jonas@norrbonn.se>
 <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com> <d9c495ac-825e-6dd0-5455-817c3f27b840@norrbonn.se>
In-Reply-To: <d9c495ac-825e-6dd0-5455-817c3f27b840@norrbonn.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jan 2019 09:15:09 +0100
Message-ID: <CAMuHMdXAjLBpQ6OXLwRsCzt5ydjuGFK6M6dKuFU4EL+6o0NB6Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Wed, Jan 30, 2019 at 9:10 AM Jonas Bonn <jonas@norrbonn.se> wrote:
> On 30/01/2019 08:35, Geert Uytterhoeven wrote:
> > On Tue, Jan 29, 2019 at 9:55 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> >> Some devices are slow and cannot keep up with the SPI bus and therefore
> >> require a short delay between words of the SPI transfer.
> >>
> >> The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
> >> clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
> >> bytes on the bus fast enough to keep up with the SoC's SPI controller
> >> even at the lowest bus speed.
> >>
> >> This patch introduces the ability to specify a required inter-word
> >> delay for SPI devices.  It is up to the controller driver to configure
> >> itself accordingly in order to introduce the requested delay.
> >>
> >> Note that, for spi_transfer, there is already a field word_delay that
> >> provides similar functionality.  This field, however, is specified in
> >> clock cycles (and worse, SPI controller cycles, not SCK cycles); that
> >> makes this value dependent on the master clock instead of the device
> >> clock for which the delay is intended to provide some relief.  This
> >> patch leaves this old word_delay in place and provides a time-based
> >> word_delay_us alongside it; the new field fits in the struct padding
> >> so struct size is constant.  There is only one in-kernel user of the
> >> word_delay field and presumably that driver could be reworked to use
> >> the time-based value instead.
> >
> > Thanks for your patch!
> >
> >> The time-based delay is limited to 8 bits as these delays are intended
> >> to be short.  The SAMA5D2 that I've tested this on limits delays to a
> >> maximum of ~100us, which is already many word-transfer periods even at
> >> the minimum transfer speed supported by the controller.
> >
> > Still, the similar delay_usecs uses a u16.
>
> The delays are not comparable.  delay_usecs is the "end of transfer"
> delay and represents the processing time to handle a command or a bundle
> of data.  The inter-word delay is just a stutter to give the slave time
> to get the next word set up.
>
> On the Microchip (Atmel... these name changes take a year or two to sink
> in!) board that I'm using (SAMA5D2), the inter-word delay is limited to
> 8192 SPI-controller-clock cycles (not SPI bus clock, input clock).  At
> 83Mhz, that's about 100us, and it only gets shorter as you clock up.
> The Spreadtrum board has an upper limit of 130 SPI-controller-clock
> cycles which is just a few microseconds.
>
> Aside from that limitation, consider what's reasonable in terms of
> delay.  More than 5x the word-transfer time and things are pretty
> questionable.  A 250us delay with a word transfer time of 50us gives an
> SPI-bus clock 160kHz.  That's already pretty slow in SPI terms and well
> below what the SAMA5D2 is capable of driving with it's 83MHz input clock
> (max divider is 255 which gives roughtly 400kHz minimum SPI bus clock).
>
> So with that, setting an inter-word delay larger than 255us is barely
> reasonable.  If somebody finds a concrete use for such a setting, then
> the size of the field can be expanded at that time.
>
> Just for info, the inter-word delay that I need to communicate with an
> Atmega MCU running at 500kHz is ~20us which is on the order of the word
> transfer time itself.  This chip is a poor example of how to design an
> SPI slave so I suspect it can only get better from here! :)
>
> And with that said, if you insist having a u16 for this, I'll change it.
>   Just let me know.

I'll defer that to the maintainer (Mark).

> >> --- a/include/linux/spi/spi.h
> >> +++ b/include/linux/spi/spi.h
> >
> >> @@ -803,6 +808,7 @@ struct spi_transfer {
> >>   #define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
> >>   #define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */
> >>          u8              bits_per_word;
> >> +       u8              word_delay_us;
> >
> > us for µs
> >
> >>          u16             delay_usecs;
> >
> > usecs for µs
> >
> > Can we please try to be consistent?
>
> I can change it to usecs if you want.  Is this a serious request to do
> so?  _usecs and _us are used pretty interchangeably across the kernel
> with a slight advantage to _us.

Personally, I prefer "us", too. Unfortunately not everyone has been
converted to metric, SI, and EURO yet ;-)

However, it looks really odd if the next line uses "usecs".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
