Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC9C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80899218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBGKQM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:16:12 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38949 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:16:10 -0500
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 261A360009;
        Thu,  7 Feb 2019 10:16:06 +0000 (UTC)
Date:   Thu, 7 Feb 2019 11:16:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: call onfi_fill_data_interface() once
 again after nand_detect
Message-ID: <20190207111606.6b72dc34@xps13>
In-Reply-To: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu,  7 Feb
2019 18:57:56 +0900:

> nand_scan_ident() calls onfi_fill_data_interface() at its entry
> to set up the initial timing parameters.
> 
> The timing parameters are needed not only for ->setup_data_interface(),
> but also for giving the correct delay to NAND_OP_WAIT_RDY, for example.
> 
> If the driver sets the NAND_KEEP_TIMINGS flag, or does not support
> ->setup_data_interface() hook, those parameters will never updated. 

                                                            ^ be 

> 
> Before nand_detect(), we never know whether the chip is ONFi or not.
> So, onfi_fill_data_interface() has to assume the worst case, i.e.
> non-ONFi.

s/ONFi/ONFI/?

> 
> After nand_detect(), if the chip turns out to be ONFi-compliant,
> we can optimize tPROG_max, tBERS_max, etc.
> 
> Call onfi_fill_data_interface() once again.

Sorry but I don't get why this is needed as there is the same call at
the top of this function. Can you be more specific on where/when the
missing call produces a failure?

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 9b3d7ff..35e543c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5040,6 +5040,9 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
>  
>  	nand_deselect_target(chip);
>  
> +	/* If the chip turns out ONFi, we can optimize timing parameters. */
> +	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
> +
>  	/* Check for a chip array */
>  	for (i = 1; i < maxchips; i++) {
>  		u8 id[2];


Thanks,
Miquèl
