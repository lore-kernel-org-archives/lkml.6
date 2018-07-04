Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA90C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180522448
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180522448
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933714AbeGDI5R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:57:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39949 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932376AbeGDI5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:57:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C577220787; Wed,  4 Jul 2018 10:57:10 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96A2920012;
        Wed,  4 Jul 2018 10:57:10 +0200 (CEST)
Date:   Wed, 4 Jul 2018 10:57:11 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, nicolas.ferre@microchip.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
Message-ID: <20180704085711.GI14626@piout.net>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <d2264ba9-78db-a3e8-fe4d-5c04f241468c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2264ba9-78db-a3e8-fe4d-5c04f241468c@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 11:42:25+0300, Tudor Ambarus wrote:
> Hi, Claudiu,
> 
> On 06/04/2018 11:46 AM, Claudiu Beznea wrote:
> > Implement suspend/resume hooks.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> > 
> > Changes in v2:
> > - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP
> > 
> >  drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
> > index 6c5708bacad8..ceaaef47f02e 100644
> > --- a/drivers/mtd/spi-nor/atmel-quadspi.c
> > +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
> > @@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static int __maybe_unused atmel_qspi_suspend(struct device *dev)
> > +{
> > +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(aq->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused atmel_qspi_resume(struct device *dev)
> > +{
> > +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(aq->clk);
> 
> You missed to verify the return value of clk_prepare_enable. Otherwise looks

Which will never fail, there is no point in checking it.

> good. I've also looked over the test with suspending while copying on a ubifs
> mounted on QSPI NOR, looks good too.
> 
> After checking the return value, please add:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
