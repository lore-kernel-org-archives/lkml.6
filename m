Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF42120877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF42120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJDSVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:21:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34189 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbeJDSU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:20:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 226492090A; Thu,  4 Oct 2018 13:28:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id BF00320890;
        Thu,  4 Oct 2018 13:27:56 +0200 (CEST)
Date:   Thu, 4 Oct 2018 13:27:57 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
 mt35xu512aba
Message-ID: <20181004132757.16107d10@bbrezillon>
In-Reply-To: <904391ba-5a12-aee9-966a-17346dded080@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <20181003165603.2579-2-vigneshr@ti.com>
        <20181004114535.3a5dba05@bbrezillon>
        <904391ba-5a12-aee9-966a-17346dded080@ti.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 16:42:22 +0530
Vignesh R <vigneshr@ti.com> wrote:

> On Thursday 04 October 2018 03:15 PM, Boris Brezillon wrote:
> > On Wed, 3 Oct 2018 22:26:01 +0530
> > Vignesh R <vigneshr@ti.com> wrote:
> >   
> >> Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines. It
> >> supports read/write over 8 IO lines simulatenously. Add support for
> >> Octal read mode for Micron mt35xu512aba.
> >> Unfortunately, this flash is only complaint to SFDP JESD216B and does not
> >> seem to support newer JESD216C standard that provides auto detection of
> >> Octal mode capabilities and opcodes. Therefore, this capability is
> >> manually added using new SPI_NOR_OCTAL_READ flag.
> >>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> ---
> >>  drivers/mtd/spi-nor/spi-nor.c | 11 ++++++++++-
> >>  include/linux/mtd/spi-nor.h   |  2 ++
> >>  2 files changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> >> index aff5e6ff0b2c..4926e805a8cb 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -90,6 +90,7 @@ struct flash_info {
> >>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
> >>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
> >>  #define USE_CLSR		BIT(14)	/* use CLSR command */
> >> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */  
> > 
> > Hm, we'll need to clarify what OCTAL means. I see at least 3 different
> > modes using 8 IO lines (1-1-8, 1-8-8 and 8-8-8) and all of them could
> > be qualified as "octal" modes.
> > So how about renaming this macro SPI_NOR_1_1_8_READ.
> >   
> 
> My understanding is that, if a flash is Octal IO capable, then it
> supports all mode of Octal IO (1-1-8, 1-8-8 and 8-8-8). At least in the
> current code, I see SPI_NOR_QUAD_READ seems to imply 1-1-4, 1-4-4 and
> 4-4-4 modes.

I already have one NOR which is not following this rule (mx25uw51245g)
and is only supporting 1-1-1 and 8-8-8, nothing in between.

> Moreover, these capabilities should be auto discoverable once flash
> start populating SFDP JESD216C tables (IIRC, JESD216B already takes care
> of QUAD IO modes). So, I don't think we need different flags for 1-1-8,
> 1-8-8 and 8-8-8. Please let me if that's not the case.

Except we already have NORs out there that do not have a valid SFDP
table but still support a subset of the octal modes (mx25uw51245g is in
this case, but I'm pretty sure there are others).

> 
> For this patch, I wanted to start small and support only 1-1-8 mode
> which is the easiest.

Which is fine, just wanted to know what SPI_NOR_OCTAL_READ meant.

> 
> 
> > Also, I fear we'll soon run out of bits in ->flags if we keep adding
> > one flag per mode which is why I proposed a solution to let flash
> > chips tweak the flash parameters as they wish [1][2]. I'm not saying we
> > should do it now, but we should definitely plan for something like that.
> > 
> > [1]https://github.com/bbrezillon/linux/commit/9c672e4c85a91f1b0803c9c6e4b8f3aae5d79ffb
> > [2]https://github.com/bbrezillon/linux/commit/3a5515c8821314c06a3d84f9861aefe476bb711e
> >   
> 
> Hmm, it almost seems like Macronix flash warrants its own driver now.
> 

Actually, we already have quite a bit of code that is vendor (and even
chip) specific in spi-nor.c, and I indeed think it would be beneficial
to have one driver per manufacturer so that the core is not polluted by
those chip/manufacturer specific hacks. The thing is, the spi_nor
interface (and the way hwcaps selection works) is not ready for that.
