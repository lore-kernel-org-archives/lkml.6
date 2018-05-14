Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeENPSj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:18:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:39898 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753222AbeENPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:18:37 -0400
X-Google-Smtp-Source: AB8JxZqixybZAqF9qlfHFqvEZzTlzvZM90l1eBe1Gyjj7n4S1A1+0oy9yXqTGJU/GaTbMy6NSJ/AXg==
Date: Mon, 14 May 2018 11:18:35 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] drm/rockchip: support dp training outside dp
 firmware
Message-ID: <20180514151835.GC3373@art_vandelay>
References: <1526291635-31122-1-git-send-email-hl@rock-chips.com>
 <1526291635-31122-4-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526291635-31122-4-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:53:55PM +0800, Lin Huang wrote:
> DP firmware uses fixed phy config values to do training, but some
> boards need to adjust these values to fit for their unique hardware
> design. So if the phy is using custom config values, do software
> link training instead of relying on firmware, if software training
> fail, keep firmware training as a fallback if sw training fails.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - update patch following Enric suggest
> Changes in v3:
> - use variable fw_training instead sw_training_success
> - base on DP SPCE, if training fail use lower link rate to retry training
> 
>  drivers/gpu/drm/rockchip/Makefile               |   3 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
>  drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 416 ++++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  31 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
>  6 files changed, 501 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> 
> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> index a314e21..b932f62 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -9,7 +9,8 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
>  rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
>  
>  rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
> -rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o \
> +					cdn-dp-link-training.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index cce64c1..d9d0d4d 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -629,11 +629,13 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
>  			goto out;
>  		}
>  	}
> -
> -	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
> -	if (ret) {
> -		DRM_DEV_ERROR(dp->dev, "Failed to idle video %d\n", ret);
> -		goto out;
> +	if (dp->use_fw_training == true) {
> +		ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
> +		if (ret) {
> +			DRM_DEV_ERROR(dp->dev,
> +				      "Failed to idle video %d\n", ret);
> +			goto out;
> +		}
>  	}
>  
>  	ret = cdn_dp_config_video(dp);
> @@ -642,11 +644,15 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
>  		goto out;
>  	}
>  
> -	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
> -	if (ret) {
> -		DRM_DEV_ERROR(dp->dev, "Failed to valid video %d\n", ret);
> -		goto out;
> +	if (dp->use_fw_training == true) {
> +		ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
> +		if (ret) {
> +			DRM_DEV_ERROR(dp->dev,
> +				"Failed to valid video %d\n", ret);
> +			goto out;
> +		}
>  	}
> +
>  out:
>  	mutex_unlock(&dp->lock);
>  }
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> index 46159b2..77a9793 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> @@ -84,6 +84,7 @@ struct cdn_dp_device {
>  	bool connected;
>  	bool active;
>  	bool suspended;
> +	bool use_fw_training;
>  
>  	const struct firmware *fw;	/* cdn dp firmware */
>  	unsigned int fw_version;	/* cdn fw version */
> @@ -106,6 +107,7 @@ struct cdn_dp_device {
>  	u8 ports;
>  	u8 lanes;
>  	int active_port;
> +	u8 train_set[4];
>  
>  	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>  	bool sink_has_audio;
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-link-training.c b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> new file mode 100644
> index 0000000..b8fd5bc
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c

/snip

> +static int cdn_dp_get_lower_link_rate(struct cdn_dp_device *dp)
> +{
> +	if (dp->link.rate == DP_LINK_BW_1_62)
> +		return -EINVAL;
> +	else if (dp->link.rate == DP_LINK_BW_2_7)
> +			dp->link.rate = DP_LINK_BW_1_62;

Extra indent

> +	else
> +		dp->link.rate = DP_LINK_BW_2_7;


This is better expressed as a switch statement:


        switch (dp->link.rate) {
        case DP_LINK_BW_1_62:
                return -EINVAL;
        case DP_LINK_BW_2_7:
                dp->link.rate = DP_LINK_BW_1_62:
                break;
        default:
                dp->link.rate = DP_LINK_BW_2_7:
                break;
        }

You might also consider adding an additional case since there are rates higher
than 5.4GHz. ie:
        case DP_LINK_BW_5_4:
                dp->link.rate = DP_LINK_BW_2_7:
                break;
        default:
                dp->link.rate = DP_LINK_BW_5_4:
                break;


> +
> +	return 0;
> +}
> +
> +int cdn_dp_software_train_link(struct cdn_dp_device *dp)
> +{
> +	int ret, stop_err;
> +	u8 link_config[2];
> +	u32 rate, sink_max, source_max;
> +
> +	ret = drm_dp_dpcd_read(&dp->aux, DP_DPCD_REV, dp->dpcd,
> +			       sizeof(dp->dpcd));
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
> +		return ret;
> +	}
> +
> +	source_max = dp->lanes;
> +	sink_max = drm_dp_max_lane_count(dp->dpcd);
> +	dp->link.num_lanes = min(source_max, sink_max);
> +
> +	source_max = drm_dp_bw_code_to_link_rate(CDN_DP_MAX_LINK_RATE);
> +	sink_max = drm_dp_max_link_rate(dp->dpcd);
> +	rate = min(source_max, sink_max);
> +	dp->link.rate = drm_dp_link_rate_to_bw_code(rate);
> +
> +retry:
> +	/* Write the link configuration data */
> +	link_config[0] = dp->link.rate;
> +	link_config[1] = dp->link.num_lanes;
> +	if (drm_dp_enhanced_frame_cap(dp->dpcd))
> +		link_config[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
> +	drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, link_config, 2);
> +
> +	link_config[0] = 0;
> +	link_config[1] = 0;
> +	if (dp->dpcd[DP_MAIN_LINK_CHANNEL_CODING] & 0x01)
> +		link_config[1] = DP_SET_ANSI_8B10B;
> +	drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, link_config, 2);
> +
> +	ret = cdn_dp_link_training_clock_recovery(dp);
> +	if (ret) {
> +		if (cdn_dp_get_lower_link_rate(dp)) {
> +			DRM_ERROR("training clock recovery fail, err: %d\n",
> +				  ret);
> +			goto stop_training;
> +		}
> +
> +		/* use lower link rate to retraining */
> +		goto retry;
> +	}
> +
> +	ret = cdn_dp_link_training_channel_equalization(dp);
> +	if (ret) {
> +		if (cdn_dp_get_lower_link_rate(dp)) {
> +			DRM_ERROR("training channel equalization fail, err: %d\n",
> +				  ret);
> +			goto stop_training;
> +		}
> +
> +		/* use lower link rate to retraining */
> +		goto retry;
> +	}
> +
> +stop_training:
> +	stop_err = cdn_dp_stop_link_train(dp);
> +	if (stop_err) {
> +		DRM_ERROR("stop training fail, error: %d\n", stop_err);
> +		return stop_err;
> +	}
> +
> +	return ret;

Using labels to do loops reduces readability, it seems like you can also pull
out the downspread control write.

        link_config[0] = 0;
        link_config[1] = 0;
        if (dp->dpcd[DP_MAIN_LINK_CHANNEL_CODING] & 0x01)
                link_config[1] = DP_SET_ANSI_8B10B;
        drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, link_config, 2);

        while (true) {
                /* Write the link configuration data */
                link_config[0] = dp->link.rate;
                link_config[1] = dp->link.num_lanes;
                if (drm_dp_enhanced_frame_cap(dp->dpcd))
                        link_config[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
                drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, link_config, 2);

                ret = cdn_dp_link_training_clock_recovery(dp);
                if (ret) {
                        if (!cdn_dp_get_lower_link_rate(dp))
                                continue;

                        DRM_ERROR("training clock recovery failed: %d\n", ret);
                        break;
                }

                ret = cdn_dp_link_training_channel_equalization(dp);
                if (ret) {
                        if (!cdn_dp_get_lower_link_rate(dp))
                                continue;

                        DRM_ERROR("training channel eq failed: %d\n", ret);
                        break;
                }

                return 0;
        }

        stop_err = cdn_dp_stop_link_train(dp);
        if (stop_err) {
                DRM_ERROR("stop training fail, error: %d\n", stop_err);
                return stop_err;
        }

        return ret;

> +
> +stop_training:
> +	stop_err = cdn_dp_stop_link_train(dp);
> +	if (stop_err) {
> +		DRM_ERROR("stop training fail, error: %d\n", stop_err);
> +		return stop_err;
> +	}
> +
> +	return ret;

> +}
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> index 979355d..e1273e6 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> @@ -17,7 +17,9 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/phy/phy.h>
>  #include <linux/reset.h>
> +#include <soc/rockchip/rockchip_phy_typec.h>
>  
>  #include "cdn-dp-core.h"
>  #include "cdn-dp-reg.h"
> @@ -189,7 +191,7 @@ static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
>  	return 0;
>  }
>  
> -static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
> +int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
>  {
>  	u8 msg[6];
>  
> @@ -609,6 +611,31 @@ int cdn_dp_train_link(struct cdn_dp_device *dp)
>  {
>  	int ret;
>  
> +	/*
> +	 * DP firmware uses fixed phy config values to do training, but some
> +	 * boards need to adjust these values to fit for their unique hardware
> +	 * design. So if the phy is using custom config values, do software
> +	 * link training instead of relying on firmware, if software training

This comment is no longer accurate.

> +	 * fail, keep firmware training as a fallback if sw training fails.
> +	 */
> +	ret = cdn_dp_software_train_link(dp);
> +	if (ret) {
> +		DRM_DEV_ERROR(dp->dev,
> +			"Failed to do software training %d\n", ret);
> +		goto do_fw_training;
> +	}
> +	ret = cdn_dp_reg_write(dp, SOURCE_HDTX_CAR, 0xf);
> +	if (ret) {
> +		DRM_DEV_ERROR(dp->dev,
> +		"Failed to write SOURCE_HDTX_CAR register %d\n", ret);
> +		goto do_fw_training;
> +	}
> +	dp->use_fw_training = false;
> +	return 0;
> +
> +do_fw_training:
> +	dp->use_fw_training = true;
> +	DRM_DEV_DEBUG_KMS(dp->dev, "use fw training\n");
>  	ret = cdn_dp_training_start(dp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dp->dev, "Failed to start training %d\n", ret);
> @@ -623,7 +650,7 @@ int cdn_dp_train_link(struct cdn_dp_device *dp)
>  
>  	DRM_DEV_DEBUG_KMS(dp->dev, "rate:0x%x, lanes:%d\n", dp->link.rate,
>  			  dp->link.num_lanes);
> -	return ret;
> +	return 0;
>  }
>  
>  int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
> 

/snip

-- 
Sean Paul, Software Engineer, Google / Chromium OS
