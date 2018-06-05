Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeFEULH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:11:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37458 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeFEULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:11:05 -0400
X-Google-Smtp-Source: ADUXVKI3qPPcRaOGuxjxckvQFcmgg48o40+2HpMHIQT7nYCmhxAw7zz6DmxPIViURMMlMsMK9Eg9nQ==
Date: Tue, 5 Jun 2018 14:11:02 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mtd: rawnand: add an option to specify NAND chip
 as a boot device
Message-ID: <20180605201102.GA22487@rob-hp-laptop>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-3-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531221637.6017-3-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:16:33AM +0200, Stefan Agner wrote:
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
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

Shouldn't this be a partition level option? You could conceivably do one 
ECC type for boot area and something else for the rest of the NAND.


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
> -- 
> 2.17.0
> 
