Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609D32089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEIldDwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609D32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJIQUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:20:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:20:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so916965wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ot5zc1R+sPFFVe2sfdiN8KDEDkPou51WqHjsXqZI7PM=;
        b=YEIldDwJ/Vni3dDmS0/pVTtFJl3ggX6cxFZKYw/vlxWKlUQpG67X/I+eCKXHSA8vwU
         M4V0cWDuAJThf8WbjL2Pfu2qMTd4fAW+rlwUhmy2HIQBYpXEOEEhkB4VFukks08nadev
         qqstFc2dnq0EAQ/J+8NuUgGDJh76Sxj0fk2BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ot5zc1R+sPFFVe2sfdiN8KDEDkPou51WqHjsXqZI7PM=;
        b=JIDlUPTOMASeybzmu/KZQ+bd961Utk3dTLbxLcVbdk2FwyVQPRp1OK7MZ53Vih2HMZ
         OiKAhsR5OrlY0BJ+AFmBQGTRDbMKn5fIVhpMtOU85Sapbxpqp5W1QGQSr6uzvs0i8kue
         p5j8nCwX8XMh2Q/0n4CrqKM8wHlM78e/OwR2w4DIjNt4on77C3bL2SGF+JW0W5ZKRQGA
         jb/0HSpTByorohxo2zni+69Kva0oKlPqkmbQn7W/MeBO5MlTJDK2dYdcFxpw11pAenng
         NvNSVWJpsExeq4BWxRgMmZXbtY/QJdo4kl1s87ZtQE2OuPYn4Ds3ZLyy+FPVRCVp9c/A
         Znpw==
X-Gm-Message-State: ABuFfohtFx6L3Pxu9fWlKcZ52YIxN8O6HD7au2CJ2aQxNejq8Utc03xF
        096bvBhY+PJpI2zp+cNdp58AAQ==
X-Google-Smtp-Source: ACcGV603i3EUpioYVgEwQF/hksNhFP3nskxRnabkd2VJG/YsO3+CQiiOsLlQILXpyLV4KZhmpuT+eQ==
X-Received: by 2002:adf:d082:: with SMTP id y2-v6mr12782329wrh.314.1539075898053;
        Tue, 09 Oct 2018 02:04:58 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id m136-v6sm5134242wmb.4.2018.10.09.02.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:04:56 -0700 (PDT)
Date:   Tue, 9 Oct 2018 02:04:54 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20181009090454.GD4939@dell>
References: <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
 <20180912111757.GC2760@piout.net>
 <20180912114352.GT4185@dell>
 <20180912121420.GE2760@piout.net>
 <20180912131248.GA21544@dell>
 <a143edd3c0de2ba98b64e642b4384edf4323be2b.camel@upb.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a143edd3c0de2ba98b64e642b4384edf4323be2b.camel@upb.ro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Radu Pirea wrote:

> On Wed, 2018-09-12 at 14:12 +0100, Lee Jones wrote:
> > On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > 
> > > On 12/09/2018 12:43:52+0100, Lee Jones wrote:
> > > > > > But ... we can't have it both ways.  *Either* it's a true
> > > > > > MFD, in
> > > > > > which case it can/should have 2 separate compatible strings
> > > > > > which can
> > > > > > be specified directly from the DT.  *Or* it's not an MFD.  In
> > > > > > the
> > > > > > latter case, which I think we're all agreeing on (else we'd
> > > > > > have 2
> > > > > > compatible strings), MFD is not the place to handle this (my
> > > > > > original
> > > > > > point).
> > > > > > 
> > > > > 
> > > > > If that is what bothers you, then let's move it out of mfd.
> > > > 
> > > > As I've already mentioned.  I don't just want it moved out of MFD
> > > > and
> > > > shoved somewhere else.  My aim is to fix this properly.
> > > > 
> > > 
> > > If it is out of MFD, then I'm not sure why you would care too much
> > > about
> > > it as you won't be maintaining that code. And I still this what was
> > > done
> > > was correct but I'm open to test what you suggest.
> > 
> > I care for the kernel in general, not just the areas I'm responsible
> > for.  I guess I'm just that kinda guy! ;)
> 
> Well, Lee, like you, I think this driver should not be a MFD driver,
> but Alex has a good point of view. 
> 
> > 
> > > > > > So ... this is a USART device which can do SPI, right?
> > > > > > 
> > > > > > My current thinking is that; as this is a USART device first
> > > > > > &
> > > > > > foremost, the USART should be probed in the first instance
> > > > > > regardless,
> > > > > > then if SPI mode is specified it (the USART driver) registers
> > > > > > the SPI
> > > > > > platform driver (as MFD does currently) and exits gracefully,
> > > > > > allowing
> > > > > > the SPI driver to take over.
> > > > > > 
> > > > > > Spanner in the works: is it physically possible to change the
> > > > > > mode at
> > > > > > run-time?  :s
> > > > > 
> > > > > Yes it is possible but on Linux that will not happen without
> > > > > probing
> > > > > the drivers again.
> > > > 
> > > > Not sure I understand what you mean.
> > > 
> > > I was just commenting on changing the mode at runtime.
> > 
> > Oh I see.  My question was relating to whether the H/W is physically
> > capable of changing modes on-the-fly, rather than how Linux would
> > handle that.  If this is something we'd wish to support, then it
> > would
> > have to be a single driver, which is why I was asking.  By separating
> > the drivers this way, we are blocking that as a
> > possibility.  Although
> > I guess the OP has already thought about that and made the decision
> > not to support it.
> 
> Is possible to change modes on-the-fly, but you have no reason to do
> that. On the PCB you will have a SPI slave or a serial console :)
> Anyway, the current form of the driver, and through this I want to say
> "this ugly hack", allows the user to switch from serial to SPI mode by
> adding only one property to the device tree node of USART. If the
> driver were in his first form, a simple SPI driver, how you will make a
> dtsi file for an IP like this? You will add two nodes for the same IP
> in dtsi and will take care to enable correct node in dts?
> I think this driver is only a tradeoff between having an ugly hack in
> kernel or having an messy device tree.
> 
> > 
> > > > I'm suggesting that you use the same platform_* interfaces MFD
> > > > uses to
> > > > register the SPI driver if SPI mode has been selected.  Only do
> > > > so
> > > > from the appropriate driver i.e. USART.
> > > 
> > > Yeah, I understood that but I didn't comment because I'm not sure
> > > this
> > > will work yet.
> > 
> > Other drivers already do this.
> 
> Can you give me an example please?

Sorry for the delay, I have been on vacation.

Grep for 'platform_device_add' in drivers/

> I am open to suggestions.
> 
> Sorry for that acked-by. There was a lot of "reviewed-by", "acked-by",
> etc in a single version and I messed up :).
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
