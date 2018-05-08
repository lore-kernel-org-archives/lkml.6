Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755319AbeEHNwL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:52:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35458 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755277AbeEHNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:51:56 -0400
X-Google-Smtp-Source: AB8JxZrCHDoxEjDtgQDBxDMECPTzC4ysUK/T7Bic9E+tmJ5k6kJtczcOWN6Acq8Q3DyClGvPUx+Igg==
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
To: Lei YU <mine260309@gmail.com>, Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
Date: Tue, 8 May 2018 06:51:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 02:39 AM, Lei YU wrote:
> The clock source for aspeed pwm is set to 24MHz, so use the hard-coded
> clock frequency instead of the one in device tree.
> 
> Otherwise, in case of the clock specified in device tree is not 24MHz,
> the fan speed will be incorrect.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---
>   drivers/hwmon/aspeed-pwm-tacho.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 693a3d5..e83b8df 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -922,7 +922,6 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
>   	void __iomem *regs;
>   	struct resource *res;
>   	struct device *hwmon;
> -	struct clk *clk;
>   	int ret;
>   
>   	np = dev->of_node;
> @@ -956,12 +955,10 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
>   	regmap_write(priv->regmap, ASPEED_PTCR_TACH_SOURCE, 0);
>   	regmap_write(priv->regmap, ASPEED_PTCR_TACH_SOURCE_EXT, 0);
>   
> -	clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(clk))
> -		return -ENODEV;
> -	priv->clk_freq = clk_get_rate(clk);
>   	aspeed_set_clock_enable(priv->regmap, true);
> +	// The clock source is set to 24MHz

No mixed C/C++ comments in hwmon drivers.

>   	aspeed_set_clock_source(priv->regmap, 0);
> +	priv->clk_freq = 24000000;
>   

Are you saying that clk_get_rate() is wrong ? Anyway, if the DT is bad, it should be fixed.
I am not a friend of hacking drivers to fix up bad DTs, and much less so without explanation.
Plus, how do we know that the next chip supported by the driver doesn't have a 32MHz clock ?
Really, please fix the DT.

Guenter

>   	aspeed_create_type(priv);
>   
> 
