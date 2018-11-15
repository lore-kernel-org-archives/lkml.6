Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57712C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CFA20815
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CFA20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbeKOXUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:20:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40403 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbeKOXUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:20:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 41A5B20752; Thu, 15 Nov 2018 14:12:53 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id DE8DE20510;
        Thu, 15 Nov 2018 14:12:52 +0100 (CET)
Date:   Thu, 15 Nov 2018 14:12:52 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
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
        "Prabhakar Kushwaha" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20181115141252.52a5b32d@bbrezillon>
In-Reply-To: <3e9aa917-cf3a-cf0e-8516-4e73d30eb2a1@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
        <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
        <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
        <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
        <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
        <VI1PR04MB57265222E26C013D5D9C009B99DC0@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <3e9aa917-cf3a-cf0e-8516-4e73d30eb2a1@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 11:43:05 +0000
Schrempf Frieder <frieder.schrempf@kontron.De> wrote:

> On 15.11.18 07:22, Yogesh Narayan Gaur wrote:
> > Hi Frieder,
> > 
> > With below patch on top of your v5, Read/Write/Erase on CS1 is working fine for me.  
> 
> Ok, are you sure, that AHB read is working too with this patch?
> You are removing the memmap_phy offset from SFAR and the SFXXAD register 
> values.
> 
> I can understand that selection of the CS and IP commands will work like 
> this, but I can't understand how AHB read should work without the base 
> address of the mapped memory.
> 
> I'm afraid I still don't fully understand the background of these 
> things,

Same here. Yogesh, can you give us more detail on why you decided to
drop the memmap_phy offset?

> but still thank you for testing.
> 
