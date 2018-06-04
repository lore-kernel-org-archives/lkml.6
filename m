Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeFDFo5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:44:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38242 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeFDFo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:44:56 -0400
X-Google-Smtp-Source: ADUXVKLVZyg4hqxvN5nP6fvyl2oeSJo4Mnt9do9E08ofJlQlqnKrVcVZn34DRO+xZNFNIiTSR2KhRQ==
Date: Mon, 4 Jun 2018 06:44:52 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: arizona: Don't use regmap_read_poll_timeout
Message-ID: <20180604054452.GD17993@dell>
References: <20180511135030.14590-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180511135030.14590-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018, Charles Keepax wrote:

> Some Arizona CODECs have a small timing window where they will
> NAK an I2C transaction if it happens before the boot done bit is
> set. This can cause the read of the register containing the boot
> done bit to fail until it is set. Since regmap_read_poll_timeout
> will abort polling if a read fails it can't be reliably used to
> poll the boot done bit over I2C.
> 
> Do a partial revert of ef84f885e037 ("mfd: arizona: Refactor
> arizona_poll_reg"), removing the regmap_read_poll_timeout but
> leaving the refactoring to make the arizona_poll_reg take more
> sensible arguments.
> 
> Fixes: ef84f885e037 ("mfd: arizona: Refactor arizona_poll_reg")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/arizona-core.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 83f1c5a516d9..2ed29ce08dac 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -240,18 +240,31 @@ static int arizona_poll_reg(struct arizona *arizona,
>  			    int timeout_ms, unsigned int reg,
>  			    unsigned int mask, unsigned int target)
>  {
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_ms * 1000);

USEC_PER_MSEC ?

>  	unsigned int val = 0;
>  	int ret;
>  
> -	ret = regmap_read_poll_timeout(arizona->regmap,
> -				       reg, val, ((val & mask) == target),
> -				       ARIZONA_REG_POLL_DELAY_US,
> -				       timeout_ms * 1000);
> -	if (ret)
> -		dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n",
> -			reg, val);
> +	while (true) {
> +		ret = regmap_read(arizona->regmap, reg, &val);
>  
> -	return ret;
> +		if ((val & mask) == target)
> +			return 0;
> +
> +		if (ktime_compare(ktime_get(), timeout) > 0)
> +			break;
> +
> +		usleep_range(ARIZONA_REG_POLL_DELAY_US / 2,
> +			     ARIZONA_REG_POLL_DELAY_US);
> +	}
> +
> +	if (ret) {
> +		dev_err(arizona->dev, "Failed polling reg 0x%x: %d\n",
> +			reg, ret);
> +		return ret;
> +	}
> +
> +	dev_err(arizona->dev, "Polling reg 0x%x timed out: %x\n", reg, val);
> +	return -ETIMEDOUT;
>  }
>  
>  static int arizona_wait_for_boot(struct arizona *arizona)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
