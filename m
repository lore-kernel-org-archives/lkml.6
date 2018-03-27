Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeC0MMh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:12:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50907 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeC0MMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:12:36 -0400
X-Google-Smtp-Source: AG47ELve5UkStpVcY8Elml9ugT9I+laP0MI/DQK9dliXY1Zo805y17PgsToE5/oW5xuAkWC9VkFLXQ==
Date: Tue, 27 Mar 2018 13:12:32 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mfd: rk808: Refactor shutdown functions
Message-ID: <20180327121232.laqiqcai3o6qndh4@dell>
References: <1521218891-26616-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521218891-26616-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Daniel Schultz wrote:

> Since all three shutdown functions have almost the same code, all logic
> from the shutdown functions can be refactored to a new function
> "rk808_update_bits", which can update a register by a given address and
> bitmask.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
> 	v2: Re-submit with recipients from Rockchip.
> 	v3: - Added devicetree property to enable the PMIC reset seperate from 
> 	      "rockchip,system-power-controller".
> 	    - Dropped the first patch of this serie.
> 	v4: Splitted refactoring and the new reset feature.
> 
>  drivers/mfd/rk808.c | 47 ++++++++++++++---------------------------------
>  1 file changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 216fbf6..ae014ee 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -369,58 +369,39 @@ static const struct regmap_irq_chip rk818_irq_chip = {
>  
>  static struct i2c_client *rk808_i2c_client;
>  
> -static void rk805_device_shutdown(void)
> +static void rk808_update_bits(unsigned int reg, unsigned int bit_mask)
>  {
>  	int ret;
>  	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk805, so do nothing here\n");
> +			 "have no %s, so do nothing here\n",
> +			 rk808->regmap_irq_chip->name);

Julia is right, you can't do this.

If !rk808 you will not be able to deference it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
