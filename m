Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566FEC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E731208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E731208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934670AbeFRNhG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:37:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37640 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933818AbeFRNhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:37:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CFF7520798; Mon, 18 Jun 2018 15:37:03 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82FED20703;
        Mon, 18 Jun 2018 15:37:03 +0200 (CEST)
Date:   Mon, 18 Jun 2018 15:37:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH 2/2] mtd: rawnand: marvell: Support page size of
 2048 with 8-bit ECC
Message-ID: <20180618153703.77bc01c1@xps13>
In-Reply-To: <20180618045255.8015-3-chris.packham@alliedtelesis.co.nz>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
        <20180618045255.8015-3-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, 18 Jun 2018 16:52:55 +1200, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> The MT29F1G08ABAFAWP-ITE:F chip has 2048 byte pages and requires a
> minimum ECC strength of 8-bits. Allow for this combination of
> requirements using the marvell_nand controller.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> I've tried to follow the recommended AN-379 from Marvell. They do seem
> to have information that covers this particular set of chip requirements
> but I'm not confident I've translated their code correctly into the
> current marvell_nand implementation.
> 
> This is enough to make the nand_scan work but ubi/ubifs fails to initialise
> and/or mount so I may have something completely wrong. This may also be
> because this chip has internal ECC enabled which cannot be disabled. I
> turned up an old thread on this from April last year[1] but I didn't see
> anything resulting from this. Can this combination of ECC
> implementations even co-exist?
> 
> [1] - http://lists.infradead.org/pipermail/linux-mtd/2017-April/073370.html
> 
>  drivers/mtd/nand/raw/marvell_nand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index ebb1d141b900..5712df553a8e 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -217,6 +217,7 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
>  	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
>  	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
>  	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
> +	MARVELL_LAYOUT( 2048,   512,  8,  1,  1, 1024, 0, 30,  1024,  32,  30),

I suppose you should not use HW_ECC for this chip. Hence this line is
useless. However I think it should be:

	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024, 0, 30, 1024, 32,	30),

                                          ^

>  	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
>  	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
>  };

Regards,
Miquèl
