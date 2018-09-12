Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5EBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D68620882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D68620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeILRSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:18:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51303 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeILRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:18:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F4E320720; Wed, 12 Sep 2018 14:14:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D8364203DA;
        Wed, 12 Sep 2018 14:14:20 +0200 (CEST)
Date:   Wed, 12 Sep 2018 14:14:20 +0200
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
Message-ID: <20180912121420.GE2760@piout.net>
References: <20180911181838.GI4185@dell>
 <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
 <20180912111757.GC2760@piout.net>
 <20180912114352.GT4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912114352.GT4185@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 12:43:52+0100, Lee Jones wrote:
> > > But ... we can't have it both ways.  *Either* it's a true MFD, in
> > > which case it can/should have 2 separate compatible strings which can
> > > be specified directly from the DT.  *Or* it's not an MFD.  In the
> > > latter case, which I think we're all agreeing on (else we'd have 2
> > > compatible strings), MFD is not the place to handle this (my original
> > > point).
> > > 
> > 
> > If that is what bothers you, then let's move it out of mfd.
> 
> As I've already mentioned.  I don't just want it moved out of MFD and
> shoved somewhere else.  My aim is to fix this properly.
> 

If it is out of MFD, then I'm not sure why you would care too much about
it as you won't be maintaining that code. And I still this what was done
was correct but I'm open to test what you suggest.

> > > So ... this is a USART device which can do SPI, right?
> > > 
> > > My current thinking is that; as this is a USART device first &
> > > foremost, the USART should be probed in the first instance regardless,
> > > then if SPI mode is specified it (the USART driver) registers the SPI
> > > platform driver (as MFD does currently) and exits gracefully, allowing
> > > the SPI driver to take over.
> > > 
> > > Spanner in the works: is it physically possible to change the mode at
> > > run-time?  :s
> > 
> > Yes it is possible but on Linux that will not happen without probing
> > the drivers again.
> 
> Not sure I understand what you mean.
> 

I was just commenting on changing the mode at runtime.

> I'm suggesting that you use the same platform_* interfaces MFD uses to
> register the SPI driver if SPI mode has been selected.  Only do so
> from the appropriate driver i.e. USART.
> 

Yeah, I understood that but I didn't comment because I'm not sure this
will work yet.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
