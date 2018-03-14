Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeCNGbK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:31:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49978 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeCNGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:31:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43D1060314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 18/36] drm/bridge: analogix_dp: Reset aux channel if an
 error occurred
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com,
        seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org,
        heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com,
        m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
        jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-19-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <f878c57e-5a72-5d09-6935-db255502e006@codeaurora.org>
Date: Wed, 14 Mar 2018 12:00:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-19-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> AUX errors are caused by many different reasons. We may not know what
> happened in aux channel on failure, so let's reset aux channel if some
> errors occurred.
> 
> Cc: 征增 王 <wzz@rock-chips.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index dee1ba109b5f..7b7fd227e1f9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -466,6 +466,10 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
>   	reg = RPLY_RECEIV | AUX_ERR;
>   	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA);
>   
> +	analogix_dp_set_analog_power_down(dp, AUX_BLOCK, true);
> +	usleep_range(10, 11);
> +	analogix_dp_set_analog_power_down(dp, AUX_BLOCK, false);
> +

Is this additional power on/off the analog power to the AUX block
required to reset it correctly? If so, could you mention that in the
commit message?

>   	analogix_dp_reset_aux(dp);
>   
>   	/* Disable AUX transaction H/W retry */
> @@ -1159,7 +1163,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   				 reg, !(reg & AUX_EN), 25, 500 * 1000);
>   	if (ret) {
>   		dev_err(dp->dev, "AUX CH enable timeout!\n");
> -		return -ETIMEDOUT;
> +		goto aux_error;
>   	}
>   
>   	/* TODO: Wait for an interrupt instead of looping? */
> @@ -1168,7 +1172,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   				 reg, reg & RPLY_RECEIV, 10, 20 * 1000);
>   	if (ret) {
>   		dev_err(dp->dev, "AUX CH cmd reply timeout!\n");
> -		return -ETIMEDOUT;
> +		goto aux_error;
>   	}
>   
>   	/* Clear interrupt source for AUX CH command reply */
> @@ -1178,7 +1182,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
>   	if (reg & AUX_ERR) {
>   		writel(AUX_ERR, dp->reg_base + ANALOGIX_DP_INT_STA);
> -		return -EREMOTEIO;
> +		goto aux_error;
>   	}
>   
>   	/* Check AUX CH error access status */
> @@ -1186,7 +1190,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   	if ((reg & AUX_STATUS_MASK)) {
>   		dev_err(dp->dev, "AUX CH error happened: %d\n\n",
>   			reg & AUX_STATUS_MASK);
> -		return -EREMOTEIO;
> +		goto aux_error;
>   	}
>   
>   	if (msg->request & DP_AUX_I2C_READ) {
> @@ -1212,4 +1216,10 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>   		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
>   
>   	return num_transferred > 0 ? num_transferred : -EBUSY;
> +
> +aux_error:
> +	/* if aux err happen, reset aux */
> +	analogix_dp_init_aux(dp);
> +
> +	return -EREMOTEIO;

A couple of ETIMEDOUTs have been replaced with EREMOTEIOs after this
change. Maybe we set it the error no in ret and return ret?

With those changes,

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

>   }
> 
