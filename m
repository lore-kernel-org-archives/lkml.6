Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FE9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E1920880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOBSjyEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E1920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeILD4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:56:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53040 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeILD4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:56:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so308189wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7ejCgxl5rHwWC9txaQzPthbyxNcqjkzBxogfONpxEOc=;
        b=OOBSjyEPhUpt3QmNTbPlHCs5zQl8umiQg7JLwpIoeQvS0TFbwHh7yb4UlDHC0ONQwT
         0Ocb/fkPzJhlWjhk828lK29wfMIJiVeN5DjJ1phHSuxtJ6RrRAXFDcbaaAuuou6ERLkA
         GOzBCWGEkf9iXm+rxP76zPscDCcgpODNwmAGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7ejCgxl5rHwWC9txaQzPthbyxNcqjkzBxogfONpxEOc=;
        b=kLCS7ABec+/PX8dqvsKkHX0jRHk/NIFuQbU+CIZ9naa6F0opyISkJtv2/iO4PXHXNh
         5/UMBvKmtcPCrvtLgfiDhKdlh3cDMvb3tIQJfN+VULyMbCV5hoU0Gz2EvB65NigRRYP9
         V658kSIVd7aek5IHqWQT1h1tEsV97sxIZzY7AgZi5tjJzeftHk7JxjhnLygsEj+pn4Xr
         +wHORFd7tFCggAMXqg741sxbIyx5vQvLh/eTleS7jOU1IMVoQHEbsCUyhTdlBi0qOjPz
         6yRys+iySR/zktCj3ZmKMzAkR6qYr2F3FyOtESQ1xqw1TRwop8PxuaYnHSIR+hj1dOyT
         Q2tA==
X-Gm-Message-State: APzg51AxHzGspZGsSFkAlUTEypSO5Z7fFmdTyF8UPnemlGZQWahjDsQG
        +0+UqKo6mQJPLhnBpGOyJgKxIw==
X-Google-Smtp-Source: ANB0Vdbm8JIZHAYsKNYUX/P0aiyaxoZTCej3OeQb9vv9DRdS6zj4TOZoWpwaJsg+4LpnRE3au5W/gw==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr2838676wmg.82.1536706484407;
        Tue, 11 Sep 2018 15:54:44 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id b124-v6sm2311430wmg.47.2018.09.11.15.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 15:54:43 -0700 (PDT)
Date:   Tue, 11 Sep 2018 23:54:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <20180911225440.GL4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911224418.GK4185@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Lee Jones wrote:

> On Tue, 11 Sep 2018, Alexandre Belloni wrote:
> 
> > On 11/09/2018 19:39:30+0100, Lee Jones wrote:
> > > On Tue, 11 Sep 2018, Geert Uytterhoeven wrote:
> > > 
> > > > On Tue, Sep 11, 2018 at 5:36 PM Alexandre Belloni
> > > > <alexandre.belloni@bootlin.com> wrote:
> > > > > On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> > > > > > On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> > > > > > <alexandre.belloni@bootlin.com> wrote:
> > > > > > > On 11/09/2018 10:33:56+0100, Lee Jones wrote:
> > > > > > > > On Tue, 04 Sep 2018, Radu Pirea wrote:
> > > > > > > > > Radu Pirea (6):
> > > > > > > > >   MAINTAINERS: add at91 usart mfd driver
> > > > > > > > >   dt-bindings: add binding for atmel-usart in SPI mode
> > > > > > > > >   mfd: at91-usart: added mfd driver for usart
> > > > > > > > >   MAINTAINERS: add at91 usart spi driver
> > > > > > > > >   spi: at91-usart: add driver for at91-usart as spi
> > > > > > > > >   tty/serial: atmel: change the driver to work under at91-usart mfd
> > > > > > > > >
> > > > > > > > >  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
> > > > > > > > >  MAINTAINERS                                   |  16 +
> > > > > > > > >  drivers/mfd/Kconfig                           |   9 +
> > > > > > > > >  drivers/mfd/Makefile                          |   1 +
> > > > > > > > >  drivers/mfd/at91-usart.c                      |  71 +++
> > > > > > > > >  drivers/spi/Kconfig                           |   8 +
> > > > > > > > >  drivers/spi/Makefile                          |   1 +
> > > > > > > > >  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
> > > > > > > > >  drivers/tty/serial/Kconfig                    |   1 +
> > > > > > > > >  drivers/tty/serial/atmel_serial.c             |  42 +-
> > > > > > > > >  include/dt-bindings/mfd/at91-usart.h          |  17 +
> > > > > > > > >  11 files changed, 606 insertions(+), 17 deletions(-)
> > > > > > > > >  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
> > > > > > > > >  create mode 100644 drivers/mfd/at91-usart.c
> > > > > > > > >  create mode 100644 drivers/spi/spi-at91-usart.c
> > > > > > > > >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > > > > > > >
> > > > > > > > Seeing as this patch-set has caused some issues this morning, I took
> > > > > > > > the liberty to peruse back into its history to figure out where things
> > > > > > > > started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
> > > > > > > > I did!
> > > > > > > >
> > > > > > > > My Acked-by has been attached to the MFD portion since v5, which is
> > > > > > > > why the code hasn't caught my eye before today.  I reviewed the
> > > > > > > > relocation of the *binding document* (serial => mfd with no changes)
> > > > > > > > in v4 and nothing else.  It appears as though you mistakenly added it
> > > > > > > > to the *MFD driver* instead.  This explains my confusion in v10 when I
> > > > > > > > told you I'd already reviewed the binding document.
> > > > > > > >
> > > > > > > > As I said, I have re-reviewed the MFD driver and I'm afraid to say
> > > > > > > > that I do not like what I see.  Besides the missing header file and
> > > > > > > > the whitespace tabbing errors, I do not agree with the implementation.
> > > > > > > > Using MFD as a shim to hack around driver selection is not a valid
> > > > > > > > use-case.
> > > > > > > >
> > > > > > > > What's stopping you from just using the compatible string directly to
> > > > > > > > select which driver you need to probe?
> > > > > > > >
> > > > > > >
> > > > > > > Then you'd have multiple compatible strings for the same IP which is a
> > > > > > > big no-no.
> > > > > >
> > > > > > It's still the same hardware device, isn't?
> > > > > > What if the SPI or UART slave is not on-board, but on an expansion board?
> > > > > > Then the SoC-specific .dtsi has no idea what mode should be used.
> > > > > >
> > > > > > Hence shouldn't the software derive the hardware mode from the full
> > > > > > hardware description in DT? If that's impossible (I didn't look into detail
> > > > > > whether an SPI bus can easily be distinguished from a UART bus), perhaps
> > > > > > a mode property should be added?
> > > > >
> > > > > Yes, this is exactly what is done:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/drivers/mfd/at91-usart.c?h=ib-mfd-spi-tty-4.20-1#n33
> > > > 
> > > > OK.
> > > > 
> > > > I guess the main "hackish" part is that the mfd_cell uses of_compatible,
> > > > which thus requires having additional compatible values?
> > > > 
> > > > I think those can just be removed. AFAICS, the SPI and serial drivers already
> > > > match against the "at91_usart_spi" resp. "atmel_usart_serial" platform device
> > > > names?
> > > 
> > > The hackish part of this driver is that it's using MFD for something
> > > which is clearly not an MFD.  It's a USART device.  Nothing more,
> > > nothing less.
> > > 
> > > Does anyone have the datasheet to hand?
> > > 
> > 
> > It is not a simple usart, it is either a usart or a full blown SPI
> > controller with registers changing layout depending on the selected
> > mode. Otherwise, I'm not sure how you would get a USART to do SPI.
> 
> Make up your mind.  Either the IP is different, or it's not. ;)
> 
> > Datasheet here:
> 
> Great.  Thank you.
> 
> > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > 
> > USART doc starting p572, registers p621.

After looking at the datasheet, I don't see any reason why one of the
two drivers can't be selected using different compatible strings.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
