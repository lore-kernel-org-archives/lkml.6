Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B5C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61747208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61747208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeFTI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:28:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43523 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbeFTI21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8FE7120A33; Wed, 20 Jun 2018 09:49:16 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F910207D4;
        Wed, 20 Jun 2018 09:49:06 +0200 (CEST)
Date:   Wed, 20 Jun 2018 09:49:06 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 2/4] mtd: rawnand: add manufacturer fixup for ONFI
 parameter page
Message-ID: <20180620094906.261b04f5@bbrezillon>
In-Reply-To: <20180620050544.31549-3-chris.packham@alliedtelesis.co.nz>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
        <20180620050544.31549-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 17:05:42 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> This is called after the ONFI parameter page checksum is verified
> and allows us to override the contents of the parameter page.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

Ditto.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - New
> Changes in v3:
> - Add doc comment and review from Boris
> 
>  drivers/mtd/nand/raw/nand_base.c | 4 ++++
>  include/linux/mtd/rawnand.h      | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 0cd3e216b95c..65250308c82d 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5172,6 +5172,10 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  		}
>  	}
>  
> +	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
> +	    chip->manufacturer.desc->ops->fixup_onfi_param_page)
> +		chip->manufacturer.desc->ops->fixup_onfi_param_page(chip, p);
> +
>  	/* Check version */
>  	val = le16_to_cpu(p->revision);
>  	if (val & (1 << 5))
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 3e8ec3b8a39c..ef7e3b4e91ea 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -778,11 +778,14 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
>   *	  implementation) if any.
>   * @cleanup: the ->init() function may have allocated resources, ->cleanup()
>   *	     is here to let vendor specific code release those resources.
> + * @fixup_onfi_param_page: apply vendor specific fixups to the ONFI
> + *	parameter page. This is called after the checksum is verified.

Can you align the second line on the colon?

>   */
>  struct nand_manufacturer_ops {
>  	void (*detect)(struct nand_chip *chip);
>  	int (*init)(struct nand_chip *chip);
>  	void (*cleanup)(struct nand_chip *chip);
> +	void (*fixup_onfi_param_page)(struct nand_chip *chip, struct nand_onfi_params *p);
>  };
>  
>  /**

