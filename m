Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968759AbeE3JFW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:05:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33162 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964851AbeE3JFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:05:03 -0400
Date: Wed, 30 May 2018 11:05:00 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 5/6 v2] mtd: rawnand: ams-delta: use GPIO lookup table
Message-ID: <20180530110500.185b5b7b@bbrezillon>
In-Reply-To: <20180525222046.11200-1-jmkrzyszt@gmail.com>
References: <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
        <20180525222046.11200-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Sat, 26 May 2018 00:20:45 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as the Amstrad Delta board provides GPIO lookup tables, switch from
> GPIO numbers to GPIO descriptors and use the table to locate required
> GPIO pins.
> 
> Declare static variables for storing GPIO descriptors and replace
> gpio_ functions with their gpiod_ equivalents. Return -EPROBE_DEFER
> if the GPIO pins are not yet available so device initialization is
> postponed instead of aborted.
> 
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
> 
> Created and tested against linux-4.17-rc3, on top of patch 1/6 "ARM:
> OMAP1: ams-delta: add GPIO lookup tables" (already applied to
> omap-for-v4.18/soc tree).
> 
> Changes since v1:
> - fix handling of devm_gpiod_get_optional() return values - thanks to
>   Andy Shevchenko.

Can you put the changelog after the "---" separator so that it does not
appear in the final commit message?

> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 120 +++++++++++++++++++++------------------
>  1 file changed, 64 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 37a3cc21c7bc..524ceaf12de0 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -20,23 +20,28 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/gpio.h>
>  #include <linux/platform_data/gpio-omap.h>
>  
>  #include <asm/io.h>
>  #include <asm/sizes.h>
>  
> -#include <mach/board-ams-delta.h>
> -
>  #include <mach/hardware.h>
>  
>  /*
>   * MTD structure for E3 (Delta)
>   */
>  static struct mtd_info *ams_delta_mtd = NULL;
> +static struct gpio_desc *gpiod_rdy;
> +static struct gpio_desc *gpiod_nce;
> +static struct gpio_desc *gpiod_nre;
> +static struct gpio_desc *gpiod_nwp;
> +static struct gpio_desc *gpiod_nwe;
> +static struct gpio_desc *gpiod_ale;
> +static struct gpio_desc *gpiod_cle;
>  
>  /*
>   * Define partitions for flash devices
> @@ -70,9 +75,9 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  
>  	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
>  	writew(byte, this->IO_ADDR_W);
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 0);
> +	gpiod_set_value(gpiod_nwe, 0);
>  	ndelay(40);
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
> +	gpiod_set_value(gpiod_nwe, 1);
>  }
>  
>  static u_char ams_delta_read_byte(struct mtd_info *mtd)
> @@ -81,11 +86,11 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
>  	struct nand_chip *this = mtd_to_nand(mtd);
>  	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
>  
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
> +	gpiod_set_value(gpiod_nre, 0);
>  	ndelay(40);
>  	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
>  	res = readw(this->IO_ADDR_R);
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 1);
> +	gpiod_set_value(gpiod_nre, 1);
>  
>  	return res;
>  }
> @@ -120,12 +125,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
>  {
>  
>  	if (ctrl & NAND_CTRL_CHANGE) {
> -		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NCE,
> -				(ctrl & NAND_NCE) == 0);
> -		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_CLE,
> -				(ctrl & NAND_CLE) != 0);
> -		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_ALE,
> -				(ctrl & NAND_ALE) != 0);
> +		gpiod_set_value(gpiod_nce, !(ctrl & NAND_NCE));
> +		gpiod_set_value(gpiod_cle, !!(ctrl & NAND_CLE));
> +		gpiod_set_value(gpiod_ale, !!(ctrl & NAND_ALE));
>  	}
>  
>  	if (cmd != NAND_CMD_NONE)
> @@ -134,41 +136,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
>  
>  static int ams_delta_nand_ready(struct mtd_info *mtd)
>  {
> -	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
> +	return gpiod_get_value(gpiod_rdy);
>  }
>  
> -static const struct gpio _mandatory_gpio[] = {
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NCE,
> -		.flags	= GPIOF_OUT_INIT_HIGH,
> -		.label	= "nand_nce",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NRE,
> -		.flags	= GPIOF_OUT_INIT_HIGH,
> -		.label	= "nand_nre",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWP,
> -		.flags	= GPIOF_OUT_INIT_HIGH,
> -		.label	= "nand_nwp",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWE,
> -		.flags	= GPIOF_OUT_INIT_HIGH,
> -		.label	= "nand_nwe",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_NAND_ALE,
> -		.flags	= GPIOF_OUT_INIT_LOW,
> -		.label	= "nand_ale",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_NAND_CLE,
> -		.flags	= GPIOF_OUT_INIT_LOW,
> -		.label	= "nand_cle",
> -	},
> -};
>  
>  /*
>   * Main initialization routine
> @@ -216,12 +186,17 @@ static int ams_delta_init(struct platform_device *pdev)
>  	this->write_buf = ams_delta_write_buf;
>  	this->read_buf = ams_delta_read_buf;
>  	this->cmd_ctrl = ams_delta_hwcontrol;
> -	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
> -		this->dev_ready = ams_delta_nand_ready;
> -	} else {
> -		this->dev_ready = NULL;
> -		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
> +
> +	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
> +	if (IS_ERR(gpiod_rdy)) {
> +		err = PTR_ERR(gpiod_rdy);
> +		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
> +		goto err_gpiod;
>  	}
> +
> +	if (gpiod_rdy)
> +		this->dev_ready = ams_delta_nand_ready;
> +
>  	/* 25 us command delay time */
>  	this->chip_delay = 30;
>  	this->ecc.mode = NAND_ECC_SOFT;
> @@ -230,7 +205,44 @@ static int ams_delta_init(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, io_base);
>  
>  	/* Set chip enabled, but  */
> -	err = gpio_request_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
> +	gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nwp)) {
> +		err = PTR_ERR(gpiod_nwp);
> +		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
> +		goto err_gpiod;
> +	}
> +	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nce)) {
> +		err = PTR_ERR(gpiod_nce);
> +		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
> +		goto err_gpiod;
> +	}
> +	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nre)) {
> +		err = PTR_ERR(gpiod_nre);
> +		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
> +		goto err_gpiod;
> +	}
> +	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nwe)) {
> +		err = PTR_ERR(gpiod_nwe);
> +		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
> +		goto err_gpiod;
> +	}
> +	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod_ale)) {
> +		err = PTR_ERR(gpiod_ale);
> +		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
> +		goto err_gpiod;
> +	}
> +	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod_cle)) {
> +		err = PTR_ERR(gpiod_cle);
> +		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
> +	}
> +err_gpiod:
> +	if (err == -ENODEV || err == -ENOENT)
> +		err = -EPROBE_DEFER;

Hm, isn't it better to make gpiod_find() return ERR_PTR(-EPROBE_DEFER)
here [1]? At least, ENOENT should not be turned into EPROBE_DEFER,
because it's returned when there's no entry matching the requested gpio
in the lookup table, and deferring the probe won't solve this problem.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v4.17-rc7/source/drivers/gpio/gpiolib.c#L3525
