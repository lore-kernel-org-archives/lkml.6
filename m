Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB6A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j46GH7ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB6A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeILP6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:58:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38495 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeILP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:58:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so1530741wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dCZ8O9DZ1ONH2hb7eQPstXDLIl/KhTzzbGzZiXh+87s=;
        b=j46GH7ecs5ROEDwzGUsGS1cSaVX4COOycu8YO0aRLZHwF/BXQnga++VqyZ1D4EpiXl
         L+vicJXnY91YMVN8ZzhsMa/2XEMBqhLf/hNs0WtodJWw8oaO4sVtwm12fF+Qi5x0rniy
         0tsLY6rAfzYwX7Aio0BPOslyozczT2rmhLO5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dCZ8O9DZ1ONH2hb7eQPstXDLIl/KhTzzbGzZiXh+87s=;
        b=OoRW2CeNtpFXiFhqzPXIyhARjKV2WYBGE+Tw1siuIfbZGZXFXlf2/lrEC7nOjduofq
         QCEgjwBsEBRABKdwNiPw3k7tkHyjITfmGbu/UoiAdMnW3s2Cr1Efa7LC53zRl7gvqzUQ
         VftvFRV2+jw77R9OX0OmVvnkehzKyvIa3y/kyBfo0zcKpvAPLJ6cU9+ZgXXiFOhMiKcK
         fzKoLZhIWvu0cCgrW5tdgxr+ddf4QGV5BRKQxeTDABLQyvL/PfNBeXLKi5ytUsHoAQTL
         WI8kZ5r+KdmW3VFhcaNFKJXqBEeaZnTXT5/War+e1/+sBYtcyQForameZenrW/VhGWF0
         0bRg==
X-Gm-Message-State: APzg51D+RErcpA7ORCEcuXtTTHgS4l7NdkejbW8veTpRcxZu/+psnble
        BJchMTftbcxGuaGWxgZ0OcuOcA==
X-Google-Smtp-Source: ANB0Vdbi9QA8Cx3M0DEjPpfUzHFBjGMSOKbfgtwBqLjWqB6smekQpHGH62smv3BGJJdwdhTPCbOxXQ==
X-Received: by 2002:adf:d1c1:: with SMTP id m1-v6mr1147526wri.138.1536749649900;
        Wed, 12 Sep 2018 03:54:09 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id w10-v6sm1110095wrp.31.2018.09.12.03.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 03:54:08 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:54:07 +0100
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
Message-ID: <20180912105407.GR4185@dell>
References: <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Geert Uytterhoeven wrote:
> On Wed, Sep 12, 2018 at 10:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > > On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > > >
> > > > > > USART doc starting p572, registers p621.
> > > >
> > > > After looking at the datasheet, I don't see any reason why one of the
> > > > two drivers can't be selected using different compatible strings.
> > >
> > > Because there is only one IP and we don't use the device tree to selecet
> > > linux specific drivers.
> >
> > We do it all the time.  There are loads of MFDs (def: same IP, with
> > different functions) which have separate compatibles for their various
> > functions.  If you wish this IP to operate as an SPI controller, it
> > should have an SPI compatible, if you wish it to operate as a U(S)ART,
> > then it should have a UART compatible.  It's what we do for most of
> > the other MFDs in the kernel.
> 
> There is a big difference: MFD functions are(more or less) independent
> functions, which can be used at the same time. It makes perfect sense for a
> single IP block that has both SPI and UART interfaces, that can be used at
> the same time.
> 
> In this case, there is a single piece of hardware that can perform
> different functions, but not at the same time. Performing a different
> function means configuring the hardware for that function, hence using a
> different driver (from a different subsystem).

Yes, I can see that PoV.

But ... we can't have it both ways.  *Either* it's a true MFD, in
which case it can/should have 2 separate compatible strings which can
be specified directly from the DT.  *Or* it's not an MFD.  In the
latter case, which I think we're all agreeing on (else we'd have 2
compatible strings), MFD is not the place to handle this (my original
point).

So ... this is a USART device which can do SPI, right?

My current thinking is that; as this is a USART device first &
foremost, the USART should be probed in the first instance regardless,
then if SPI mode is specified it (the USART driver) registers the SPI
platform driver (as MFD does currently) and exits gracefully, allowing
the SPI driver to take over.

Spanner in the works: is it physically possible to change the mode at
run-time?  :s

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
