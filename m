Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BEECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FA21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4FA21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJQPBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:01:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40081 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJQPBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:01:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5B930208B5; Wed, 17 Oct 2018 09:07:26 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id EFD4E20794;
        Wed, 17 Oct 2018 09:07:25 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:07:24 +0200
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
Message-ID: <20181017090724.12f2cd79@bbrezillon>
In-Reply-To: <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 02:07:43 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> >   
> Actually there is no entry of s25fs512s in current spi-nor.c file.
> For my connected flash part, jedec ID read points to s25fl512s. I
> have asked my board team to confirm the name of exact connected flash
> part. When I check the data sheet of s25fs512s, it also points to the
> same Jedec ID information. { "s25fl512s",  INFO(0x010220, 0x4d00, 256
> * 1024, 256, ....}
> 
> But as stated earlier, if I skip reading SFDP or read using 1-1-1
> protocol then read are always correct. For 1-4-4 protocol read are
> wrong and on further debugging found that Read code of 0x6C is being
> send as opcode instead of 0xEC.
> 
> If I revert this patch, reads are working fine.

Can you try with the following patch?

Also, can you add a trace to check whether you're reaching this point
[1] or not.

[1]https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/mtd/spi-nor/spi-nor.c#L2227

--->8---
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9407ca5f9443..49278c1491a6 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2643,6 +2643,8 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
                break;
 
        case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
+       case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
+               nor->flags |= SNOR_F_4B_OPCODES;
                nor->addr_width = 4;
                break;
 
@@ -3552,7 +3554,7 @@ static int spi_nor_init(struct spi_nor *nor)
 
        if ((nor->addr_width == 4) &&
            (JEDEC_MFR(nor->info) != SNOR_MFR_SPANSION) &&
-           !(nor->info->flags & SPI_NOR_4B_OPCODES)) {
+           !(nor->flags & SNOR_F_4B_OPCODES)) {
                /*
                 * If the RESET# pin isn't hooked up properly, or the system
                 * otherwise doesn't perform a reset command in the boot
@@ -3586,7 +3588,7 @@ void spi_nor_restore(struct spi_nor *nor)
        /* restore the addressing mode */
        if ((nor->addr_width == 4) &&
            (JEDEC_MFR(nor->info) != SNOR_MFR_SPANSION) &&
-           !(nor->info->flags & SPI_NOR_4B_OPCODES) &&
+           !(nor->flags & SNOR_F_4B_OPCODES) &&
            (nor->flags & SNOR_F_BROKEN_RESET))
                set_4byte(nor, nor->info, 0);
 }
@@ -3724,6 +3726,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
        if (info->flags & SPI_NOR_NO_FR)
                params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
 
+       if (info->flags & SPI_NOR_4B_OPCODES)
+               nor->flags |= SNOR_F_4B_OPCODES;
+
        /*
         * Configure the SPI memory:
         * - select op codes for (Fast) Read, Page Program and Sector Erase.
@@ -3742,13 +3747,16 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
        } else if (mtd->size > 0x1000000) {
                /* enable 4-byte addressing if the device exceeds 16MiB */
                nor->addr_width = 4;
-               if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
-                   info->flags & SPI_NOR_4B_OPCODES)
-                       spi_nor_set_4byte_opcodes(nor, info);
+               if (JEDEC_MFR(info) == SNOR_MFR_SPANSION)
+                       nor->flags |= SNOR_F_4B_OPCODES;
        } else {
                nor->addr_width = 3;
        }
 
+       if (info->addr_width == 4 &&
+           nor->flags & SNOR_F_4B_OPCODES)
+               spi_nor_set_4byte_opcodes(nor, info);
+
        if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
                dev_err(dev, "address width is too large: %u\n",
                        nor->addr_width);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7f0c7303575e..4ffb165f4f85 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -236,6 +236,7 @@ enum spi_nor_option_flags {
        SNOR_F_READY_XSR_RDY    = BIT(4),
        SNOR_F_USE_CLSR         = BIT(5),
        SNOR_F_BROKEN_RESET     = BIT(6),
+       SNOR_F_4B_OPCODES       = BIT(7)
 };
 
 /**
