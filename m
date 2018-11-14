Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6AD208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6AD208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbeKNUth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:49:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59866 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbeKNUth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:49:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B0FFC20731; Wed, 14 Nov 2018 11:46:52 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53181206A1;
        Wed, 14 Nov 2018 11:46:52 +0100 (CET)
Date:   Wed, 14 Nov 2018 11:46:51 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.De>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20181114114651.6f995fc8@bbrezillon>
In-Reply-To: <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
        <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
        <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
        <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
        <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 10:43:00 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Frieder,
> 
> [..]
> > >
> > > Ok, I will have a look at what could make the chip selection fail in
> > > case of AHB read.  
> > 
> > Could you try with this change applied:
> > 
> > @@ -503,7 +503,7 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct
> > spi_device *spi)
> >                          map_addr = q->memmap_phy;
> >                  else
> >                          map_addr = q->memmap_phy +
> > -                                  2 * q->devtype_data->ahb_buf_size;
> > +                                  q->devtype_data->ahb_buf_size;
> > 
> >                  qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD +
> > (i * 4));
> >          }
> >   
> 
> I have tried above change and also have done few more changes but still AHB read for CS1 is falling.

Have plugged a scope on the CS1 line, to make sure it's properly
asserted when the memory is accessed?

> 
> I guess we need to implement dynamic memory mapping [1] for AHB Read as was being done in previous driver implementation.
> Would try this and update you.

Sorry but I don't see why it would solve the problem we have here, but
if it does, I'd like to have a clear explanation ;-).
