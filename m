Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2361ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2652151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2652151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJQPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:24:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41259 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeJQPYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:24:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2E0B2079D; Wed, 17 Oct 2018 09:29:55 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id E964C20DCD;
        Wed, 17 Oct 2018 09:29:40 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:29:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181017092941.3658bd9a@bbrezillon>
In-Reply-To: <20181017091045.124e0266@bbrezillon>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>
        <20181017091045.124e0266@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 09:10:45 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Wed, 17 Oct 2018 09:07:24 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > On Wed, 17 Oct 2018 02:07:43 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > >       
> > > Actually there is no entry of s25fs512s in current spi-nor.c file.
> > > For my connected flash part, jedec ID read points to s25fl512s. I
> > > have asked my board team to confirm the name of exact connected flash
> > > part. When I check the data sheet of s25fs512s, it also points to the
> > > same Jedec ID information. { "s25fl512s",  INFO(0x010220, 0x4d00, 256
> > > * 1024, 256, ....}
> > > 
> > > But as stated earlier, if I skip reading SFDP or read using 1-1-1
> > > protocol then read are always correct. For 1-4-4 protocol read are
> > > wrong and on further debugging found that Read code of 0x6C is being
> > > send as opcode instead of 0xEC.
> > > 
> > > If I revert this patch, reads are working fine.    
> > 
> > Can you try with the following patch?
> >   
> 
> Hm, nevermind. The problem is actually not related to 4B vs non-4B mode
> but 1-1-4 vs 1-4-4 modes.
> 

Can you try with this patch applied?

--->8---
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9407ca5f9443..cf33d834698c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3132,6 +3132,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
                switch (SFDP_PARAM_HEADER_ID(param_header)) {
                case SFDP_SECTOR_MAP_ID:
                        err = spi_nor_parse_smpt(nor, param_header);
+                       if (err) {
+                               dev_warn(dev,
+                                        "failed to parse SMPT (err = %d)\n",
+                                        err);
+                               /*
+                                * SMPT parsing is optional, let's not drop
+                                * all information we extracted so far just
+                                * because it failed.
+                                */
+                               err = 0;
+                       }
                        break;
 
                default:
