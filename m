Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E23C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AF22064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AF22064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJBTLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:11:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34542 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbeJBTLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:11:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7864F207CC; Tue,  2 Oct 2018 14:28:33 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2189920379;
        Tue,  2 Oct 2018 14:28:33 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:28:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: rawnand: denali: set SPARE_AREA_SKIP_BYTES
 register to 8 if unset
Message-ID: <20181002142833.1e408558@bbrezillon>
In-Reply-To: <1538108161-6174-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538108161-6174-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 13:16:01 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> NAND devices need additional data area (OOB) for error correction,
> but it is also used for Bad Block Marker (BBM).  In many cases, the
> first byte in OOB is used for BBM, but the location actually depends
> on chip vendors.  The NAND controller should preserve the precious
> BBM to keep track of bad blocks.
> 
> In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
> the number of bytes to skip from the start of OOB.  The ECC engine
> will automatically skip the specified number of bytes when it gets
> access to OOB area.
> 
> The same value for SPARE_AREA_SKIP_BYTES should be used between
> firmware and the operating system if you intend to use the NAND
> device across the control hand-off.
> 
> In fact, the current denali.c code expects firmware to have already
> set the SPARE_AREA_SKIP_BYTES register, then reads the value out.
> 
> If no firmware (or bootloader) has initialized the controller, the
> register value is zero, which is the default after power-on-reset.
> In other words, the Linux driver cannot initialize the controller
> by itself.
> 
> Some possible solutions are:
> 
>  [1] Add a DT property to specify the skipped bytes in OOB
>  [2] Associate the preferred value with compatible
>  [3] Hard-code the default value in the driver
> 
> My first attempt was [1], but in the review process, [3] was suggested
> as a counter-implementation.
> (https://lore.kernel.org/patchwork/patch/983055/)
> 
> The default value 8 was chosen to match to the boot ROM of the UniPhier
> platform.  The preferred value may vary by platform.  If so, please
> trade up to a different solution.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> 
> Changes in v2:
>   - Change approach from a DT-property to a hard-coded dafault
> 
>  drivers/mtd/nand/raw/denali.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index aaab121..18bbfc8 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -21,6 +21,7 @@
>  #include "denali.h"
>  
>  #define DENALI_NAND_NAME    "denali-nand"
> +#define DENALI_DEFAULT_OOB_SKIP_BYTES	8
>  
>  /* for Indexed Addressing */
>  #define DENALI_INDEXED_CTRL	0x00
> @@ -1056,12 +1057,17 @@ static void denali_hw_init(struct denali_nand_info *denali)
>  		denali->revision = swab16(ioread32(denali->reg + REVISION));
>  
>  	/*
> -	 * tell driver how many bit controller will skip before
> -	 * writing ECC code in OOB, this register may be already
> -	 * set by firmware. So we read this value out.
> -	 * if this value is 0, just let it be.
> +	 * Set how many bytes should be skipped before writing data in OOB.
> +	 * If a non-zero value has already been set (by firmware or something),
> +	 * just use it.  Otherwise, set the driver default.
>  	 */
>  	denali->oob_skip_bytes = ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
> +	if (!denali->oob_skip_bytes) {
> +		denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
> +		iowrite32(denali->oob_skip_bytes,
> +			  denali->reg + SPARE_AREA_SKIP_BYTES);
> +	}
> +
>  	denali_detect_max_banks(denali);
>  	iowrite32(0x0F, denali->reg + RB_PIN_ENABLED);
>  	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);

