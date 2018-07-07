Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E47C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504FA21EA2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504FA21EA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeGGKIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:08:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51842 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbeGGKIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:08:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF9D0207AB; Sat,  7 Jul 2018 12:08:18 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6F7C920741;
        Sat,  7 Jul 2018 12:08:18 +0200 (CEST)
Date:   Sat, 7 Jul 2018 12:08:19 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at,
        nicolas.ferre@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
Message-ID: <20180707120819.5b1f412f@bbrezillon>
In-Reply-To: <20180704085711.GI14626@piout.net>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
        <d2264ba9-78db-a3e8-fe4d-5c04f241468c@microchip.com>
        <20180704085711.GI14626@piout.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 10:57:11 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 04/07/2018 11:42:25+0300, Tudor Ambarus wrote:
> > Hi, Claudiu,
> > 
> > On 06/04/2018 11:46 AM, Claudiu Beznea wrote:  
> > > Implement suspend/resume hooks.
> > > 
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied.

Thanks,

Boris

> > > ---
> > > 
> > > Changes in v2:
> > > - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP
> > > 
> > >  drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
> > > index 6c5708bacad8..ceaaef47f02e 100644
> > > --- a/drivers/mtd/spi-nor/atmel-quadspi.c
> > > +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
> > > @@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
> > >  	return 0;
> > >  }
> > >  
> > > +static int __maybe_unused atmel_qspi_suspend(struct device *dev)
> > > +{
> > > +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> > > +
> > > +	clk_disable_unprepare(aq->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused atmel_qspi_resume(struct device *dev)
> > > +{
> > > +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> > > +
> > > +	clk_prepare_enable(aq->clk);  
> > 
> > You missed to verify the return value of clk_prepare_enable. Otherwise looks  
> 
> Which will never fail, there is no point in checking it.
> 
> > good. I've also looked over the test with suspending while copying on a ubifs
> > mounted on QSPI NOR, looks good too.
> > 
> > After checking the return value, please add:
> > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >   
> 

