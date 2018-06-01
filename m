Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeFAH05 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:26:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42745 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeFAH0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:26:54 -0400
Date: Fri, 1 Jun 2018 09:26:52 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org,
        krzk@kernel.org, jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org,
        digetx@gmail.com
Subject: Re: [PATCH v3 2/6] mtd: rawnand: add an option to specify NAND chip
 as a boot device
Message-ID: <20180601092652.2e9716ac@bbrezillon>
In-Reply-To: <20180531221637.6017-3-stefan@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-3-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 00:16:33 +0200
Stefan Agner <stefan@agner.ch> wrote:

> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  Documentation/devicetree/bindings/mtd/nand.txt | 4 ++++
>  drivers/mtd/nand/raw/nand_base.c               | 3 +++
>  include/linux/mtd/rawnand.h                    | 6 ++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
> index 8bb11d809429..8daf81b9748c 100644
> --- a/Documentation/devicetree/bindings/mtd/nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/nand.txt
> @@ -43,6 +43,10 @@ Optional NAND chip properties:
>  		     This is particularly useful when only the in-band area is
>  		     used by the upper layers, and you want to make your NAND
>  		     as reliable as possible.
> +- nand-is-boot-medium: Whether the NAND chip is a boot medium. Drivers might use
> +		       this information to select ECC algorithms supported by
> +		       the boot ROM or similar restrictions.
> +
>  - nand-rb: shall contain the native Ready/Busy ids.
>  
>  The ECC strength and ECC step size properties define the correction capability
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 9eb5678dd6d0..c8fb7c9855e2 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5826,6 +5826,9 @@ static int nand_dt_init(struct nand_chip *chip)
>  	if (of_get_nand_bus_width(dn) == 16)
>  		chip->options |= NAND_BUSWIDTH_16;
>  
> +	if (of_property_read_bool(dn, "nand-is-boot-medium"))
> +		chip->options |= NAND_IS_BOOT_MEDIUM;
> +
>  	if (of_get_nand_on_flash_bbt(dn))
>  		chip->bbt_options |= NAND_BBT_USE_FLASH;
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 6a82da8c44ce..8e54fcf2fa94 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -212,6 +212,12 @@ enum nand_ecc_algo {
>   */
>  #define NAND_WAIT_TCCS		0x00200000
>  
> +/*
> + * Whether the NAND chip is a boot medium. Drivers might use this information
> + * to select ECC algorithms supported by the boot ROM or similar restrictions.
> + */
> +#define NAND_IS_BOOT_MEDIUM	0x00400000
> +
>  /* Options set by nand scan */
>  /* Nand scan has allocated controller struct */
>  #define NAND_CONTROLLER_ALLOC	0x80000000
