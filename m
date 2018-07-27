Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B45C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A372089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A372089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeG0QtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:49:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40500 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbeG0QtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:49:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34A1B20730; Fri, 27 Jul 2018 17:26:55 +0200 (CEST)
Received: from localhost (unknown [88.128.80.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id E94B320618;
        Fri, 27 Jul 2018 17:26:54 +0200 (CEST)
Date:   Fri, 27 Jul 2018 17:26:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v2 2/4] spi: dw-mmio: add MSCC Ocelot support
Message-ID: <20180727152655.GD7701@piout.net>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
 <20180727120535.16504-3-alexandre.belloni@bootlin.com>
 <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2018 16:07:54+0300, Andy Shevchenko wrote:
> On Fri, Jul 27, 2018 at 3:05 PM, Alexandre Belloni
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
> Thanks for an update! My comments below (most of them just about style).
> 
> First of all, can we use 'controller' over the 'master' in the code?
> 
> >  .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
> 
> >  Required properties:
> > -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> > -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> > -  register set is required (named ICPU_CFG:SPI_MST)
> > +- compatible : "snps,dw-apb-ssi"
> > +- reg : The register base for the controller.
> 
> This hunk is odd.
> 

Indeed, I'm not exactly sure what happened. I'll make sure it is
removed.

> >  struct dw_spi_mmio {
> >         struct dw_spi  dws;
> >         struct clk     *clk;
> > +       void           *priv;
> >  };
> 
> > +#define MSCC_SPI_MST_SW_MODE                   0x14
> > +#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE  BIT(13)
> > +#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)      (x << 5)
> 
> + blank line ?
> 
> > +struct dw_spi_mscc {
> > +       struct regmap       *syscon;
> 
> > +       void __iomem        *spi_mst;
> 
> A nit: do we need to repeat "spi" here?
> 

The register set is named SPI_MST in the datasheet so I would prefer
keeping it that way. I don't think this is an issue as it is MSCC
specific anyway.
The SI interface can be controlled by three different IPs, their name in
the datasheet are SPI boot, SPI slave and SPI master. The DW IP in what
is referred to as SPI master. The two other IPs can't be used under
linux.

So I'd like to keep spi_mst in the defines and variable but I can
probably tweak the comment to avoid the confusion.

> > +};
> 
> > +       if (!enable)
> > +               dw_writel(dws, DW_SPI_SER, BIT(cs));
> 
> This sounds like
> 
> dw_set_cs(spi, enable);
> 

That's right, I can probably use dw_spi_set_cs here

> > +       dwsmscc = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mscc),
> > +                              GFP_KERNEL);
> 
> sizeof(*dwsmcc)  and one line in the result?
> 
> > +       /* Deassert all CS */
> > +       writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
> 
> Hmm... Don't we need to call dw_set_cs() for all of them as well?
> If yes, perhaps better to call custom set_cs() in a loop?
> 

Most likely not, for the same reason why the common code is not doing
it. The FIFO is definitively empty so the CS will be unset.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
