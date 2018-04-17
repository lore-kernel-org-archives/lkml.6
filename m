Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeDQOJs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:09:48 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:24414 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDQOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:09:29 -0400
Subject: Re: [RESEND PATCH v2 3/4] ARM: davinci: add aemif & nand support to
 da850-lcdk in legacy mode
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <20180417102917.7794-4-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <df39067d-a941-4099-2cfe-7602d4047c6f@ti.com>
Date: Tue, 17 Apr 2018 19:39:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417102917.7794-4-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now have support for aemif & nand from board files. As an example
> add support for nand to da850-lcdk in legacy mode.

Hawkboard is a separate board of its own, although closely related to
LCDK. Lets refer to it as hawkboard itself, instead of "LCDK in legacy
mode". So:

ARM: davinci: omapl138-hawk: ...

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 6c997c59a3cd..9c3de56b54e4 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -16,6 +16,11 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/platform_data/ti-aemif.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/platform_data/mtd-davinci.h>
> +#include <linux/platform_data/mtd-davinci-aemif.h>
>  #include <linux/regulator/machine.h>
>  
>  #include <asm/mach-types.h>
> @@ -162,6 +167,129 @@ static __init void omapl138_hawk_mmc_init(void)
>  	gpiod_remove_lookup_table(&mmc_gpios_table);
>  }
>  
> +static struct mtd_partition omapl138_hawk_nandflash_partition[] = {
> +	{
> +		.name		= "u-boot env",
> +		.offset		= 0,
> +		.size		= SZ_128K,
> +		.mask_flags	= MTD_WRITEABLE,
> +	 },
> +	{
> +		.name		= "u-boot",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= SZ_128K,

Can you make it 512K as it is in da850-lcdk.dts ?

> +		.mask_flags	= MTD_WRITEABLE,
> +	},
> +	{
> +		.name		= "free space",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= MTDPART_SIZ_FULL,
> +		.mask_flags	= 0,
> +	},
> +};

> +static struct aemif_abus_data omapl138_hawk_aemif_abus_data[] = {
> +	{
> +		.cs	= 3,
> +	}
> +};
> +
> +static struct platform_device omapl138_hawk_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

Is there a reason for .id to be set to 1 here? Ideally it should be -1,
I think since there is a single NAND on the board.

Note that I sent a patch dropping AEMIF clock acquisition from DaVinci
NAND driver.

> +		.dev		= {
> +			.platform_data	= &omapl138_hawk_nandflash_data,
> +		},
> +		.resource	= omapl138_hawk_nandflash_resource,
> +		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
> +		.id		= 0,

This should have resulted in a double init warning?

Thanks,
Sekhar
