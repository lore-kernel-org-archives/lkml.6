Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE0C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F19A20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFLpc0gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F19A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIKXkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:40:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41217 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:40:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so27105944wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gureRstNY7VTac+7CHIf9Hm4XHEshoHo5g8X48ZBOOM=;
        b=YFLpc0gD4fRUHLoAT8GnlNWJwaXueHmJJtTe3oifmhr3JBVeR7wXF0Z01FL31YKN23
         4He6+zL/KcdVVFiuzeQWBu/pvRgjM5JG0sprCyAAqQ84drhHW86lXDutka8LaYMRIE3B
         5deRFIv5U4R59eyGTRv9Ye1sRVu9OqpXQj2B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gureRstNY7VTac+7CHIf9Hm4XHEshoHo5g8X48ZBOOM=;
        b=dmzRQOmOe9tNQzVlCC+zGn7/rq2eclAXA9qHwDiJp41fuPqfjOO3SCShyT7APwsWcg
         3z6FnDa2jDnrkNotEZr9zqS65wehu1YMUjDucl4rQbJ3RnpnLpnRJ/QIhyOGmNzqade2
         lyyDeIXpRPJi2p/9BHokW0V8gqdCA2CbjSywGDsL220s7MHVQQNOF2z3AUbIwmONQsRY
         4TtfniDGiN9FijsuI+HVJT6x1kKik5QYNyGoaUB5cM5ePoykcsD28aZQ6I/dk8c+wJX8
         2F3LswJfOVVFFufeq5Dor9rAvrCCecjU2FWsPD89x9nmGD7fmrgoe78iWbWtxpROjQRg
         qF5A==
X-Gm-Message-State: APzg51Dbm9RjqrduW4vmbMY/j2I70A/q9ThuUhcNJ2PkgsVeUGLass4j
        wUyLegkOfa2TKHwH69YGeMhU7w==
X-Google-Smtp-Source: ANB0VdZB/hmGfKpwrNIkRxysicOh5DsWUQWNdxzd+9ueCISLNPhQdlsItxpwnmq9u3hyr+zTz1Akmw==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr19515318wrj.3.1536691204574;
        Tue, 11 Sep 2018 11:40:04 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id z4-v6sm15707550wrt.89.2018.09.11.11.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:40:03 -0700 (PDT)
Date:   Tue, 11 Sep 2018 19:39:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180911181838.GI4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Geert Uytterhoeven wrote:

> On Tue, Sep 11, 2018 at 5:36 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> > > On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > > On 11/09/2018 10:33:56+0100, Lee Jones wrote:
> > > > > On Tue, 04 Sep 2018, Radu Pirea wrote:
> > > > > > Radu Pirea (6):
> > > > > >   MAINTAINERS: add at91 usart mfd driver
> > > > > >   dt-bindings: add binding for atmel-usart in SPI mode
> > > > > >   mfd: at91-usart: added mfd driver for usart
> > > > > >   MAINTAINERS: add at91 usart spi driver
> > > > > >   spi: at91-usart: add driver for at91-usart as spi
> > > > > >   tty/serial: atmel: change the driver to work under at91-usart mfd
> > > > > >
> > > > > >  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
> > > > > >  MAINTAINERS                                   |  16 +
> > > > > >  drivers/mfd/Kconfig                           |   9 +
> > > > > >  drivers/mfd/Makefile                          |   1 +
> > > > > >  drivers/mfd/at91-usart.c                      |  71 +++
> > > > > >  drivers/spi/Kconfig                           |   8 +
> > > > > >  drivers/spi/Makefile                          |   1 +
> > > > > >  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
> > > > > >  drivers/tty/serial/Kconfig                    |   1 +
> > > > > >  drivers/tty/serial/atmel_serial.c             |  42 +-
> > > > > >  include/dt-bindings/mfd/at91-usart.h          |  17 +
> > > > > >  11 files changed, 606 insertions(+), 17 deletions(-)
> > > > > >  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
> > > > > >  create mode 100644 drivers/mfd/at91-usart.c
> > > > > >  create mode 100644 drivers/spi/spi-at91-usart.c
> > > > > >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > > > >
> > > > > Seeing as this patch-set has caused some issues this morning, I took
> > > > > the liberty to peruse back into its history to figure out where things
> > > > > started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
> > > > > I did!
> > > > >
> > > > > My Acked-by has been attached to the MFD portion since v5, which is
> > > > > why the code hasn't caught my eye before today.  I reviewed the
> > > > > relocation of the *binding document* (serial => mfd with no changes)
> > > > > in v4 and nothing else.  It appears as though you mistakenly added it
> > > > > to the *MFD driver* instead.  This explains my confusion in v10 when I
> > > > > told you I'd already reviewed the binding document.
> > > > >
> > > > > As I said, I have re-reviewed the MFD driver and I'm afraid to say
> > > > > that I do not like what I see.  Besides the missing header file and
> > > > > the whitespace tabbing errors, I do not agree with the implementation.
> > > > > Using MFD as a shim to hack around driver selection is not a valid
> > > > > use-case.
> > > > >
> > > > > What's stopping you from just using the compatible string directly to
> > > > > select which driver you need to probe?
> > > > >
> > > >
> > > > Then you'd have multiple compatible strings for the same IP which is a
> > > > big no-no.
> > >
> > > It's still the same hardware device, isn't?
> > > What if the SPI or UART slave is not on-board, but on an expansion board?
> > > Then the SoC-specific .dtsi has no idea what mode should be used.
> > >
> > > Hence shouldn't the software derive the hardware mode from the full
> > > hardware description in DT? If that's impossible (I didn't look into detail
> > > whether an SPI bus can easily be distinguished from a UART bus), perhaps
> > > a mode property should be added?
> >
> > Yes, this is exactly what is done:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/drivers/mfd/at91-usart.c?h=ib-mfd-spi-tty-4.20-1#n33
> 
> OK.
> 
> I guess the main "hackish" part is that the mfd_cell uses of_compatible,
> which thus requires having additional compatible values?
> 
> I think those can just be removed. AFAICS, the SPI and serial drivers already
> match against the "at91_usart_spi" resp. "atmel_usart_serial" platform device
> names?

The hackish part of this driver is that it's using MFD for something
which is clearly not an MFD.  It's a USART device.  Nothing more,
nothing less.

Does anyone have the datasheet to hand?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
