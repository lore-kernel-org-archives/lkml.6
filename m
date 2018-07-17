Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E03ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1996206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1996206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeGQWPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:15:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57741 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbeGQWPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:15:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E190B207AB; Tue, 17 Jul 2018 23:40:23 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id B1131206A6;
        Tue, 17 Jul 2018 23:40:23 +0200 (CEST)
Date:   Tue, 17 Jul 2018 23:40:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/5] spi: dw-mmio: add MSCC Ocelot support
Message-ID: <20180717214024.GD3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-4-alexandre.belloni@bootlin.com>
 <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2018 00:34:37+0300, Andy Shevchenko wrote:
> On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > Because the SPI controller deasserts the chip select when the TX fifo is
> > empty (which may happen in the middle of a transfer), the CS should be
> > handled by linux. Unfortunately, some or all of the first four chip
> > selects are not muxable as GPIOs, depending on the SoC.
> >
> > There is a way to bitbang those pins by using the SPI boot controller so
> > use it to set the chip selects.
> >
> > At init time, it is also necessary to give control of the SPI interface to
> > the Designware IP.
> 
> > +       ret = dw_spi_mscc_init(pdev, dwsmmio);
> > +       if (ret)
> > +               goto out;
> 
> > +       { .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
> 
> Looks like you were thinking about something like
> 
> init_func = device_get_match_data(...);
> if (init_func) {
>  ret = init_func();
>  if (ret)
>    return ret;
> }
> 
> ?
> 

Ah sure, I forgot to do that after testing.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
