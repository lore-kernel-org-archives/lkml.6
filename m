Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABDC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3CMnAsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA1C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeILNkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:40:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40153 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeILNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:40:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so1375400wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nkhl90VBzPRE+Sa/D/TLUPmqsk6jLZ4Z0SH8oazVW58=;
        b=I3CMnAsQvlu1zX2MO+1liUXvmtBA5ELrDeEFTwfYb+XJkRBFUtVMpqbo0uxOuEaoOl
         nnPq0gfZwTovV1RCOs1i7ru+V7Qp/WarK6S8byxrlG+JkHP7gBjNimt9UBdpRCjnWv7l
         LQ1okXRCMQYR/zrAGH4HVYqlYhXgGa8mT9YWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nkhl90VBzPRE+Sa/D/TLUPmqsk6jLZ4Z0SH8oazVW58=;
        b=ob3b10eUao6qd8/HVyTGCfzzJK5KUbpZ/vQ4LQBFemb0VPtXUjOKWpe7C+L09O/09Y
         pkYieQihRqHE94fKWLo+mVTEFpkXrhmkiAH8v52uDn+/6bvOTFxYh/2orjqtVyfDA/fy
         AvR6Ws/jo2beX8KS6/YKoQvacHEa4yrma2mKuKjqZqHuHbaEimycM2vGc2s5zyh6LpZG
         sYl7RLuH2LzPbiVuuSFQXdf6xG2zGEFAQkoSmwsdTU7HAZN/rDNngUMd1ktdeb7gnZHe
         ED5yy5FHdkcBvAdKwSLYZIN+rxIpCu5MtXQ27ETn8hpaHIir8hboUy5alvnOyxlJ4cxw
         u+Hg==
X-Gm-Message-State: APzg51AGJyw6L4VQVZgBVRjFhthQKwrgJTIJtoH/73AP56mZ0kkZYYqg
        cnlMMz7suObjGe25xDavBmrRVX6FXs1GSBos
X-Google-Smtp-Source: ANB0VdbXdGOAdJ5SppFdQZrMHTG50vIge2s9bWL+JFYQjcJs0gCX2YZIXxvvwquMt6wP7oofB1InnA==
X-Received: by 2002:a1c:168a:: with SMTP id 132-v6mr866877wmw.13.1536741404880;
        Wed, 12 Sep 2018 01:36:44 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id 60-v6sm233718wre.82.2018.09.12.01.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 01:36:43 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:36:40 +0100
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
Message-ID: <20180912083640.GM4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <CAMuHMdUMt=HJGCDZvJF99=45mecn5AjnTr-tA_LioxWrNKM2ag@mail.gmail.com>
 <20180911224302.GJ4185@dell>
 <20180912073056.GA2557@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912073056.GA2557@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 11/09/2018 23:43:02+0100, Lee Jones wrote:
> > > I haven't read it, but I believe it's not unlike Renesas SCIF, which is
> > > served by both drivers/tty/serial/sh-sci.c and drivers/spi/spi-sh-sci.c.
> > > But the latter is not used from DT, so we haven't experienced (and solved)
> > > the similar issue yet.
> > > 
> > > Would it work if the UART driver and SPI driver would match against the
> > > same compatible value, but the UART driver would do in its probe()
> > > function:
> > > 
> > >     device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > >     if (opmode != AT91_USART_MODE_SERIAL)
> > >         return ENODEV;
> > > 
> > > while the SPI driver would do:
> > > 
> > >     device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > >     if (opmode != AT91_USART_MODE_SPI)
> > >         return ENODEV;
> > > 
> > > ? No MFD driver involved.
> > 
> > I haven't looked at the code in a while, but if memory serves I
> > believe platform code gives up once it has found its first match, so
> > by doing this, one of the drivers will never be matched/probed.
> > 
> > It's midnight here, so cracking out the datasheet isn't going to
> > happen just now, but it's my current belief that if the IP serves 2
> > very different modes of operation, even if the registers are in a
> > shared space, they could have their own compatible strings in DT.
> > 
> > That is what the MFD driver provides after all.  Why would it be okay
> > to allocate different compatible strings from the MFD, but not in the
> > Device Tree?
> > 
> > It would be the easiest solution.
> > 
> > Has Rob commented on this yet?
> 
> V4 of the bindings were acked by Rob and you:
> https://patchwork.kernel.org/patch/10428087/

We didn't Ack the bindings.  We Acked the location change.

I mean, has Rob specifically spoken out about using a compatible
string for each function.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
