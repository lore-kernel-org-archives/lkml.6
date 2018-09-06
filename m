Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D80C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFA52083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFA52083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIGB3f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:29:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41739 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeIGB3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:29:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6948F2072F; Thu,  6 Sep 2018 22:52:21 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 70924207B0;
        Thu,  6 Sep 2018 22:52:00 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:51:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] mtd: nand: esmt: retrieve ecc requirements from 5th
 id byte
Message-ID: <20180906225158.1a209c56@xps13>
In-Reply-To: <20180906224422.4be710c8@bbrezillon>
References: <20180906084922.14845-1-marcel@ziswiler.com>
        <20180906084922.14845-2-marcel@ziswiler.com>
        <20180906224422.4be710c8@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Thu, 6 Sep 2018
22:44:22 +0200:

> On Thu,  6 Sep 2018 10:49:22 +0200
> Marcel Ziswiler <marcel@ziswiler.com> wrote:
> 
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > This patch enables support to read the ECC level from the NAND flash
> > using ESMT SLC NAND ID byte 5 information as documented e.g. in the
> > following data sheet:
> > 
> > https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F59L1G81LA(2Y).pdf
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > ---
> > 
> >  drivers/mtd/nand/raw/nand_esmt.c | 46 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 drivers/mtd/nand/raw/nand_esmt.c
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
> > new file mode 100644
> > index 000000000000..360d351ac043
> > --- /dev/null
> > +++ b/drivers/mtd/nand/raw/nand_esmt.c
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 Toradex AG
> > + *
> > + * Author: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > + */
> > +
> > +#include <linux/mtd/rawnand.h>
> > +
> > +static void esmt_nand_decode_id(struct nand_chip *chip)
> > +{
> > +	nand_decode_ext_id(chip);
> > +
> > +	/* Extract ECC requirements from 5th id byte. */
> > +	if (chip->id.len >= 5 && nand_is_slc(chip)) {
> > +		chip->ecc_step_ds = 512;
> > +		switch (chip->id.data[4] & 0x3) {
> > +		case 0x0:
> > +			chip->ecc_strength_ds = 4;
> > +			break;
> > +		case 0x1:
> > +			chip->ecc_strength_ds = 2;
> > +			break;
> > +		case 0x2:
> > +			chip->ecc_strength_ds = 1;
> > +			break;
> > +		default:
> > +			WARN(1, "Could not get ECC info");
> > +			chip->ecc_step_ds = 0;
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static int esmt_nand_init(struct nand_chip *chip)
> > +{
> > +	if (nand_is_slc(chip))
> > +		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> > +
> > +	return 0;
> > +}
> > +
> > +const struct nand_manufacturer_ops esmt_nand_manuf_ops = {
> > +	.detect = esmt_nand_decode_id,
> > +	.init = esmt_nand_init,
> > +};  
> 
> Looks like you forgot to hook the new esmt_nand_manuf_ops to the ESMT
> entry (in the nand_manufacturer table), so as is, the patch is not
> exactly adding support for ECC req parsing ;-).

I missed that.

Will drop both patches from nand/next, waiting for a v2 (please also
reorder the macros in patch 1 as suggested).

Thanks,
Miquèl
