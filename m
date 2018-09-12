Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE262087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE262087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeILMeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:34:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41799 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbeILMeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:34:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B69D720795; Wed, 12 Sep 2018 09:30:57 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89B7420720;
        Wed, 12 Sep 2018 09:30:57 +0200 (CEST)
Date:   Wed, 12 Sep 2018 09:30:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20180912073056.GA2557@piout.net>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <CAMuHMdUMt=HJGCDZvJF99=45mecn5AjnTr-tA_LioxWrNKM2ag@mail.gmail.com>
 <20180911224302.GJ4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911224302.GJ4185@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 23:43:02+0100, Lee Jones wrote:
> > I haven't read it, but I believe it's not unlike Renesas SCIF, which is
> > served by both drivers/tty/serial/sh-sci.c and drivers/spi/spi-sh-sci.c.
> > But the latter is not used from DT, so we haven't experienced (and solved)
> > the similar issue yet.
> > 
> > Would it work if the UART driver and SPI driver would match against the
> > same compatible value, but the UART driver would do in its probe()
> > function:
> > 
> >     device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> >     if (opmode != AT91_USART_MODE_SERIAL)
> >         return ENODEV;
> > 
> > while the SPI driver would do:
> > 
> >     device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> >     if (opmode != AT91_USART_MODE_SPI)
> >         return ENODEV;
> > 
> > ? No MFD driver involved.
> 
> I haven't looked at the code in a while, but if memory serves I
> believe platform code gives up once it has found its first match, so
> by doing this, one of the drivers will never be matched/probed.
> 
> It's midnight here, so cracking out the datasheet isn't going to
> happen just now, but it's my current belief that if the IP serves 2
> very different modes of operation, even if the registers are in a
> shared space, they could have their own compatible strings in DT.
> 
> That is what the MFD driver provides after all.  Why would it be okay
> to allocate different compatible strings from the MFD, but not in the
> Device Tree?
> 
> It would be the easiest solution.
> 
> Has Rob commented on this yet?
> 

V4 of the bindings were acked by Rob and you:
https://patchwork.kernel.org/patch/10428087/


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
