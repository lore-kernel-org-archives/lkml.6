Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F054C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA0D20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA0D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeICMzN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:55:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeICMzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:55:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F0B1220726; Mon,  3 Sep 2018 10:36:06 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id DA5C6215E6;
        Mon,  3 Sep 2018 10:36:03 +0200 (CEST)
Date:   Mon, 3 Sep 2018 10:36:00 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/7] spi: add slave device size in spi_device struct
Message-ID: <20180903103600.3efabbac@bbrezillon>
In-Reply-To: <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180831135807.22255bce@karo-electronics.de>
        <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Mon, 3 Sep 2018 04:47:25 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Lothar,
> 
> > -----Original Message-----
> > From: Lothar Waßmann [mailto:LW@KARO-electronics.de]
> > Sent: Friday, August 31, 2018 5:28 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; mark.rutland@arm.com; robh@kernel.org; linux-
> > kernel@vger.kernel.org; frieder.schrempf@exceet.de;
> > computersforpeace@gmail.com; shawnguo@kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/7] spi: add slave device size in spi_device struct
> > 
> > Hi,
> > 
> > On Fri, 31 Aug 2018 15:59:58 +0530 Yogesh Gaur wrote:  
> > > Add 'size' data variable in spi_device struct.
> > > This is to save the size of the connected slave device.
> > >
> > > After slave device scan, spi_nor_scan, size being assigned to this
> > > from MTD layer.
> > >
> > > SFDP read is being requested before completion of spi_nor_scan()
> > > routine, thus populate device size before making read request to the
> > > SPI controller.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > ---
> > >  drivers/mtd/devices/m25p80.c  | 6 ++++++
> > > drivers/mtd/spi-nor/spi-nor.c | 2 ++
> > >  include/linux/spi/spi.h       | 2 ++
> > >  3 files changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/mtd/devices/m25p80.c
> > > b/drivers/mtd/devices/m25p80.c index fe260cc..6c7ad86 100644
> > > --- a/drivers/mtd/devices/m25p80.c
> > > +++ b/drivers/mtd/devices/m25p80.c
> > > @@ -124,6 +124,10 @@ static ssize_t m25p80_read(struct spi_nor *nor,  
> > loff_t from, size_t len,  
> > >  	/* convert the dummy cycles to the number of bytes */
> > >  	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > >
> > > +	/* for case of SFDP header read commands, populate spi device size */
> > > +	if (flash->spimem->spi->size == 0)
> > > +		flash->spimem->spi->size = nor->mtd.size;
> > > +  
> > If the 'size' is an spimem specific variable it should be added to the spi_mem
> > struct rather than the spi_device struct.  
> 
> Sure, would move 'size' from struct spi_device to the struct spi_mem.

Before you send a new version doing that, I'd like to understand why
you need this information. Can you wait a bit so I have some time to
review the driver?

Thanks,

Boris
