Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6219020854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="broy+tdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6219020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeILQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:48:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34339 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeILQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:48:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id j25-v6so10305393wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XLL8onee2BOWp32kdDH5c63QoGJUgQ3tg3yh9g21Nb4=;
        b=broy+tdOejdZuOBoZ7G7aV1Xdy6dUItsSCY3uiLwz5P2xWm2gaLV+iojhEKmoPWDCW
         HipS67EDPVfEzd9UixeWY2uwlfyWf6G4+3bR3Xid7VJopiJ9ShYIoTAU71sCjESV3Vaf
         ucWi0hg8ZpTKoaiffVRDMqadJF6YT7WmADp7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XLL8onee2BOWp32kdDH5c63QoGJUgQ3tg3yh9g21Nb4=;
        b=dDRvpHpWiyAAXYQPsCazlMdWQz66H+ysDESLnVLc2whVjwzmM0D/mUJGiM3lG/6BZb
         Lj+8tvqOmQ5EPrZAWBbCQD9zzS0MA+UekbEFp+kEB+PfDWQfE43mKWKvjK2gR6Fc1hUD
         LITbGDx2rbiqBsKsfKyBo+e4gHCeDdKbWHZngGfosUcIXAiBH/KtNdq3k50I/f46lgU+
         Uvz77lWcXmUefC5BsCN80DREWg7VnaiS+w6VQpyXtPh+ZlqXLRE/3T9+4pQF23+w7jWk
         mATVHkxVAVgqzqSaS/qQ9wCgGEv966ZhOl2VyVAGGefN++8ZCxYr7+Neeq1TuJN8YfOM
         keHA==
X-Gm-Message-State: APzg51CqOg6QkYn3JBTBzOJgl0QP3ewvPhb1BO2jcmnL97s0CQ+sp+kk
        N4xekFbxGYOZgC1BYqztAKhhdg==
X-Google-Smtp-Source: ANB0VdYA2Gn2xt7s6ISLb6vlu+O3BDZ67sfj2xt8hysqOc8B6XqXTrNXUiA9hkYFmLCEoZScpycP2Q==
X-Received: by 2002:a1c:5f85:: with SMTP id t127-v6mr1275779wmb.16.1536752653522;
        Wed, 12 Sep 2018 04:44:13 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id 132-v6sm992648wmd.13.2018.09.12.04.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:44:12 -0700 (PDT)
Date:   Wed, 12 Sep 2018 12:43:52 +0100
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
Message-ID: <20180912114352.GT4185@dell>
References: <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
 <20180912111757.GC2760@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912111757.GC2760@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 12/09/2018 11:54:07+0100, Lee Jones wrote:
> > On Wed, 12 Sep 2018, Geert Uytterhoeven wrote:
> > > On Wed, Sep 12, 2018 at 10:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > > > > On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > > > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > > > > >
> > > > > > > > USART doc starting p572, registers p621.
> > > > > >
> > > > > > After looking at the datasheet, I don't see any reason why one of the
> > > > > > two drivers can't be selected using different compatible strings.
> > > > >
> > > > > Because there is only one IP and we don't use the device tree to selecet
> > > > > linux specific drivers.
> > > >
> > > > We do it all the time.  There are loads of MFDs (def: same IP, with
> > > > different functions) which have separate compatibles for their various
> > > > functions.  If you wish this IP to operate as an SPI controller, it
> > > > should have an SPI compatible, if you wish it to operate as a U(S)ART,
> > > > then it should have a UART compatible.  It's what we do for most of
> > > > the other MFDs in the kernel.
> > > 
> > > There is a big difference: MFD functions are(more or less) independent
> > > functions, which can be used at the same time. It makes perfect sense for a
> > > single IP block that has both SPI and UART interfaces, that can be used at
> > > the same time.
> > > 
> > > In this case, there is a single piece of hardware that can perform
> > > different functions, but not at the same time. Performing a different
> > > function means configuring the hardware for that function, hence using a
> > > different driver (from a different subsystem).
> > 
> > Yes, I can see that PoV.
> > 
> > But ... we can't have it both ways.  *Either* it's a true MFD, in
> > which case it can/should have 2 separate compatible strings which can
> > be specified directly from the DT.  *Or* it's not an MFD.  In the
> > latter case, which I think we're all agreeing on (else we'd have 2
> > compatible strings), MFD is not the place to handle this (my original
> > point).
> > 
> 
> If that is what bothers you, then let's move it out of mfd.

As I've already mentioned.  I don't just want it moved out of MFD and
shoved somewhere else.  My aim is to fix this properly.

> > So ... this is a USART device which can do SPI, right?
> > 
> > My current thinking is that; as this is a USART device first &
> > foremost, the USART should be probed in the first instance regardless,
> > then if SPI mode is specified it (the USART driver) registers the SPI
> > platform driver (as MFD does currently) and exits gracefully, allowing
> > the SPI driver to take over.
> > 
> > Spanner in the works: is it physically possible to change the mode at
> > run-time?  :s
> 
> Yes it is possible but on Linux that will not happen without probing
> the drivers again.

Not sure I understand what you mean.

I'm suggesting that you use the same platform_* interfaces MFD uses to
register the SPI driver if SPI mode has been selected.  Only do so
from the appropriate driver i.e. USART.

> I think DT overlays will be the only possible use
> case because on SPI, you'd still have to provide nodes for the connected
> SPI devices.

Since SPI is a function of the USART you should describe is as such
via a child node.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
