Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeDWIsw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:48:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:48828 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754312AbeDWIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:48:46 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 23 Apr 2018 09:48:39 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: Re: [PATCH 03/18 v2] regulator: arizona-ldo1: Look up a descriptor
 and pass to the core
Message-ID: <20180423084839.hs5vrlgo4gzttuj3@localhost.localdomain>
References: <20180422230742.3729-1-linus.walleij@linaro.org>
 <20180422230742.3729-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180422230742.3729-3-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=554 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804230096
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:07:27AM +0200, Linus Walleij wrote:
> Instead of passing a global GPIO number, pass a descriptor looked
> up with the standard devm_gpiod_get_optional() call.
> 
> We have augmented the GPIO core to look up the regulator special
> GPIO "wlf,ldoena" in commit 6a537d48461d
> "gpio: of: Support regulator nonstandard GPIO properties".
> 
> Cc: patches@opensource.cirrus.com
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  static struct arizona_pdata wm5102_reva_pdata = {
> -	.ldo1 = {
> -		.ldoena = S3C64XX_GPN(7),
> -	},
>  	.gpio_base = CODEC_GPIO_BASE,
>  	.irq_flags = IRQF_TRIGGER_HIGH,
>  	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
> @@ -237,10 +235,16 @@ static struct spi_board_info wm5102_reva_spi_devs[] = {
>  	},
>  };
>  
> -static struct arizona_pdata wm5102_pdata = {
> -	.ldo1 = {
> -		.ldoena = S3C64XX_GPN(7),
> +static struct gpiod_lookup_table wm5102_reva_gpiod_table = {
> +	.dev_id = "spi0.1", /* SPI device name */
> +	.table = {
> +		GPIO_LOOKUP("GPION", 7,
> +			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),

This should be wlf,ldoena.

> +		{ },
>  	},
> +};
> +
> +static struct arizona_pdata wm5102_pdata = {
>  	.gpio_base = CODEC_GPIO_BASE,
>  	.irq_flags = IRQF_TRIGGER_HIGH,
>  	.micd_pol_gpio = CODEC_GPIO_BASE + 2,
> @@ -264,6 +268,15 @@ static struct spi_board_info wm5102_spi_devs[] = {
>  	},
>  };
>  
> +static struct gpiod_lookup_table wm5102_gpiod_table = {
> +	.dev_id = "spi0.1", /* SPI device name */
> +	.table = {
> +		GPIO_LOOKUP("GPION", 7,
> +			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +

Might as well share the same lookup table between the revs since
it is identical.

Thanks,
Charles
