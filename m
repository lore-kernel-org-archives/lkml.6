Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F01CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C918E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C918E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937349AbeFSGBW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:01:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57847 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937104AbeFSGBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:01:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4459A208B3; Tue, 19 Jun 2018 08:01:20 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id F245C2073D;
        Tue, 19 Jun 2018 08:01:09 +0200 (CEST)
Date:   Tue, 19 Jun 2018 08:01:10 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 2/6] mtd: rawnand: add manufacturer fixup for
 ONFI parameter page
Message-ID: <20180619080110.633b9077@bbrezillon>
In-Reply-To: <20180619053125.16792-3-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
        <20180619053125.16792-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 17:31:21 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> This is called after the ONFI parameter page checksum is verified
> and allows us to override the contents of the parameter page.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes in v2:
> - New
> 
>  drivers/mtd/nand/raw/nand_base.c | 4 ++++
>  include/linux/mtd/rawnand.h      | 1 +
>  2 files changed, 5 insertions(+)
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
> index 3e8ec3b8a39c..6db42091ee5e 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -783,6 +783,7 @@ struct nand_manufacturer_ops {
>  	void (*detect)(struct nand_chip *chip);
>  	int (*init)(struct nand_chip *chip);
>  	void (*cleanup)(struct nand_chip *chip);
> +	void (*fixup_onfi_param_page)(struct nand_chip *chip, struct nand_onfi_params *p);
>  };
>  
>  /**

