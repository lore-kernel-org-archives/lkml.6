Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeCNFwf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:52:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeCNFwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:52:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3476460592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 05/36] drm/bridge: analogix_dp: add fast link train for
 eDP
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
 <20180309222327.18689-6-enric.balletbo@collabora.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <912773b9-e72b-11d1-e459-bbd765451f3c@codeaurora.org>
Date: Wed, 14 Mar 2018 11:22:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309222327.18689-6-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 10 March 2018 03:52 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> We would meet a short black screen when exit PSR with the full link
> training, In this case, we should use fast link train instead of full
> link training.
> 
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 142 ++++++++++++++++-----
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |   3 +
>   2 files changed, 114 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index ee00d3d920e0..806c3878b3d6 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -10,17 +10,18 @@
>   * option) any later version.
>   */
>   
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/err.h>
>   #include <linux/clk.h>
> -#include <linux/io.h>
> +#include <linux/component.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
>   #include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_gpio.h>
> -#include <linux/gpio.h>
> -#include <linux/component.h>
>   #include <linux/phy/phy.h>
> +#include <linux/platform_device.h>

This re-ordering doesn't seem like it should be a part of this patch,
you can let it stay if it happens to cause conflicts with future
patches. Other than that:

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

>   
>   #include <drm/drmP.h>
>   #include <drm/drm_atomic_helper.h>
> @@ -35,6 +36,8 @@
>   
>   #define to_dp(nm)	container_of(nm, struct analogix_dp_device, nm)
>   
> +static const bool verify_fast_training;
> +
>   struct bridge_init {
>   	struct i2c_client *client;
>   	struct device_node *node;
> @@ -528,7 +531,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
>   {
>   	int lane, lane_count, retval;
>   	u32 reg;
> -	u8 link_align, link_status[2], adjust_request[2];
> +	u8 link_align, link_status[2], adjust_request[2], spread;
>   
>   	usleep_range(400, 401);
>   
> @@ -571,6 +574,20 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
>   		dev_dbg(dp->dev, "final lane count = %.2x\n",
>   			dp->link_train.lane_count);
>   
> +		retval = drm_dp_dpcd_readb(&dp->aux, DP_MAX_DOWNSPREAD,
> +					   &spread);
> +		if (retval != 1) {
> +			dev_err(dp->dev, "failed to read downspread %d\n",
> +				retval);
> +			dp->fast_train_support = false;
> +		} else {
> +			dp->fast_train_support =
> +				(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING) ?
> +					true : false;
> +		}
> +		dev_dbg(dp->dev, "fast link training %s\n",
> +			dp->fast_train_support ? "supported" : "unsupported");
> +
>   		/* set enhanced mode if available */
>   		analogix_dp_set_enhanced_mode(dp);
>   		dp->link_train.lt_state = FINISHED;
> @@ -627,10 +644,12 @@ static void analogix_dp_get_max_rx_lane_count(struct analogix_dp_device *dp,
>   	*lane_count = DPCD_MAX_LANE_COUNT(data);
>   }
>   
> -static void analogix_dp_init_training(struct analogix_dp_device *dp,
> -				      enum link_lane_count_type max_lane,
> -				      int max_rate)
> +static int analogix_dp_full_link_train(struct analogix_dp_device *dp,
> +				       u32 max_lanes, u32 max_rate)
>   {
> +	int retval = 0;
> +	bool training_finished = false;
> +
>   	/*
>   	 * MACRO_RST must be applied after the PLL_LOCK to avoid
>   	 * the DP inter pair skew issue for at least 10 us
> @@ -656,18 +675,13 @@ static void analogix_dp_init_training(struct analogix_dp_device *dp,
>   	}
>   
>   	/* Setup TX lane count & rate */
> -	if (dp->link_train.lane_count > max_lane)
> -		dp->link_train.lane_count = max_lane;
> +	if (dp->link_train.lane_count > max_lanes)
> +		dp->link_train.lane_count = max_lanes;
>   	if (dp->link_train.link_rate > max_rate)
>   		dp->link_train.link_rate = max_rate;
>   
>   	/* All DP analog module power up */
>   	analogix_dp_set_analog_power_down(dp, POWER_ALL, 0);
> -}
> -
> -static int analogix_dp_sw_link_training(struct analogix_dp_device *dp)
> -{
> -	int retval = 0, training_finished = 0;
>   
>   	dp->link_train.lt_state = START;
>   
> @@ -702,22 +716,88 @@ static int analogix_dp_sw_link_training(struct analogix_dp_device *dp)
>   	return retval;
>   }
>   
> -static int analogix_dp_set_link_train(struct analogix_dp_device *dp,
> -				      u32 count, u32 bwtype)
> +static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
>   {
> -	int i;
> -	int retval;
> +	int i, ret;
> +	u8 link_align, link_status[2];
> +	enum pll_status status;
>   
> -	for (i = 0; i < DP_TIMEOUT_LOOP_COUNT; i++) {
> -		analogix_dp_init_training(dp, count, bwtype);
> -		retval = analogix_dp_sw_link_training(dp);
> -		if (retval == 0)
> -			break;
> +	analogix_dp_reset_macro(dp);
> +
> +	analogix_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
> +	analogix_dp_set_lane_count(dp, dp->link_train.lane_count);
>   
> -		usleep_range(100, 110);
> +	for (i = 0; i < dp->link_train.lane_count; i++) {
> +		analogix_dp_set_lane_link_training(dp,
> +			dp->link_train.training_lane[i], i);
>   	}
>   
> -	return retval;
> +	ret = readx_poll_timeout(analogix_dp_get_pll_lock_status, dp, status,
> +				 status != PLL_UNLOCKED, 120,
> +				 120 * DP_TIMEOUT_LOOP_COUNT);
> +	if (ret) {
> +		DRM_DEV_ERROR(dp->dev, "Wait for pll lock failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* source Set training pattern 1 */
> +	analogix_dp_set_training_pattern(dp, TRAINING_PTN1);
> +	/* From DP spec, pattern must be on-screen for a minimum 500us */
> +	usleep_range(500, 600);
> +
> +	analogix_dp_set_training_pattern(dp, TRAINING_PTN2);
> +	/* From DP spec, pattern must be on-screen for a minimum 500us */
> +	usleep_range(500, 600);
> +
> +	/* TODO: enhanced_mode?*/
> +	analogix_dp_set_training_pattern(dp, DP_NONE);
> +
> +	/*
> +	 * Useful for debugging issues with fast link training, disable for more
> +	 * speed
> +	 */
> +	if (verify_fast_training) {
> +		ret = drm_dp_dpcd_readb(&dp->aux, DP_LANE_ALIGN_STATUS_UPDATED,
> +					&link_align);
> +		if (ret < 0) {
> +			DRM_DEV_ERROR(dp->dev, "Read align status failed %d\n",
> +				      ret);
> +			return ret;
> +		}
> +
> +		ret = drm_dp_dpcd_read(&dp->aux, DP_LANE0_1_STATUS, link_status,
> +				       2);
> +		if (ret < 0) {
> +			DRM_DEV_ERROR(dp->dev, "Read link status failed %d\n",
> +				      ret);
> +			return ret;
> +		}
> +
> +		if (analogix_dp_clock_recovery_ok(link_status,
> +						  dp->link_train.lane_count)) {
> +			DRM_DEV_ERROR(dp->dev, "Clock recovery failed\n");
> +			analogix_dp_reduce_link_rate(dp);
> +			return -EIO;
> +		}
> +
> +		if (analogix_dp_channel_eq_ok(link_status, link_align,
> +					      dp->link_train.lane_count)) {
> +			DRM_DEV_ERROR(dp->dev, "Channel EQ failed\n");
> +			analogix_dp_reduce_link_rate(dp);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int analogix_dp_train_link(struct analogix_dp_device *dp)
> +{
> +	if (dp->fast_train_support)
> +		return analogix_dp_fast_link_train(dp);
> +
> +	return analogix_dp_full_link_train(dp, dp->video_info.max_lane_count,
> +					   dp->video_info.max_link_rate);
>   }
>   
>   static int analogix_dp_config_video(struct analogix_dp_device *dp)
> @@ -846,10 +926,10 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>   			DRM_ERROR("failed to disable the panel\n");
>   	}
>   
> -	ret = analogix_dp_set_link_train(dp, dp->video_info.max_lane_count,
> -					 dp->video_info.max_link_rate);
> +	ret = readx_poll_timeout(analogix_dp_train_link, dp, ret, !ret, 100,
> +				 DP_TIMEOUT_TRAINING_US * 5);
>   	if (ret) {
> -		dev_err(dp->dev, "unable to do link train\n");
> +		dev_err(dp->dev, "unable to do link train, ret=%d\n", ret);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index e135a42cb19e..920607d7eb3e 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -20,6 +20,8 @@
>   #define MAX_CR_LOOP 5
>   #define MAX_EQ_LOOP 5
>   
> +/* Training takes 22ms if AUX channel comm fails. Use this as retry interval */
> +#define DP_TIMEOUT_TRAINING_US			22000
>   #define DP_TIMEOUT_PSR_LOOP_MS			300
>   
>   /* DP_MAX_LANE_COUNT */
> @@ -171,6 +173,7 @@ struct analogix_dp_device {
>   	int			hpd_gpio;
>   	bool                    force_hpd;
>   	bool			psr_enable;
> +	bool			fast_train_support;
>   
>   	struct mutex		panel_lock;
>   	bool			panel_is_modeset;
> 
