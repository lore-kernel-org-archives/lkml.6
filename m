Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbeEKPBu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:01:50 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45929 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeEKPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:01:49 -0400
X-Google-Smtp-Source: AB8JxZqDgJsUjKEcJLYlFEBMoSDMcgZcdI3Y+ZrTnIatAZiPnZxv/DNLIZYBdIa2DDAyH5Dc6En+9g==
Date: Fri, 11 May 2018 11:01:47 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
Subject: Re: [PATCH v2 4/4] drm/rockchip: support dp training outside dp
 firmware
Message-ID: <20180511150147.GQ33053@art_vandelay>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
 <1525861364-26323-4-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525861364-26323-4-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 06:22:44PM +0800, Lin Huang wrote:
> DP firmware uses fixed phy config values to do training, but some
> boards need to adjust these values to fit for their unique hardware
> design. So if the phy is using custom config values, do software
> link training instead of relying on firmware, if software training
> fail, keep firmware training as a fallback if sw training fails.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

FTR, I've previously reviewed this patch at
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/985573

> ---
> Changes in v2:
> - update patch following Enric suggest
> 
>  drivers/gpu/drm/rockchip/Makefile               |   3 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
>  drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 391 ++++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  34 ++-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
>  6 files changed, 479 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> 

/snip

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> index 46159b2..c6050ab 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> @@ -84,6 +84,7 @@ struct cdn_dp_device {
>  	bool connected;
>  	bool active;
>  	bool suspended;
> +	bool sw_training_success;

Can you change this to use_fw_training instead? So it will be false if sw
training succeeds, and true if sw training fails and needs to fallback to fw.

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

/snip

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> index afdfda0..bd0aed5 100644
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
> @@ -606,7 +608,35 @@ static int cdn_dp_get_training_status(struct cdn_dp_device *dp)
>  int cdn_dp_train_link(struct cdn_dp_device *dp)
>  {
>  	int ret;
> +	struct cdn_dp_port *port = dp->port[dp->active_port];
> +	struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);
>  
> +	/*
> +	 * DP firmware uses fixed phy config values to do training, but some
> +	 * boards need to adjust these values to fit for their unique hardware
> +	 * design. So if the phy is using custom config values, do software
> +	 * link training instead of relying on firmware, if software training
> +	 * fail, keep firmware training as a fallback if sw training fails.
> +	 */
> +	if (tcphy->need_software_training) {

As discussed in the downstream review, I'd rather default to sw training and
fallback to fw training if we must.

> +		ret = cdn_dp_software_train_link(dp);
> +		if (ret) {
> +			DRM_DEV_ERROR(dp->dev,
> +				"Failed to do software training %d\n", ret);
> +			goto do_fw_training;
> +		}
> +		ret = cdn_dp_reg_write(dp, SOURCE_HDTX_CAR, 0xf);
> +		if (ret) {
> +			DRM_DEV_ERROR(dp->dev,
> +			"Failed to write SOURCE_HDTX_CAR register %d\n", ret);
> +			goto do_fw_training;
> +		}
> +		dp->sw_training_success = true;
> +		return 0;
> +	}
> +
> +do_fw_training:
> +	dp->sw_training_success = false;

Can you please add a DRM_DEBUG_KMS log message here?

>  	ret = cdn_dp_training_start(dp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dp->dev, "Failed to start training %d\n", ret);
> @@ -621,7 +651,7 @@ int cdn_dp_train_link(struct cdn_dp_device *dp)
>  
>  	DRM_DEV_DEBUG_KMS(dp->dev, "rate:0x%x, lanes:%d\n", dp->link.rate,
>  			  dp->link.num_lanes);
> -	return ret;
> +	return 0;
>  }
>  
>  int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> index 6580b11..3420771 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> @@ -137,7 +137,7 @@
>  #define HPD_EVENT_MASK			0x211c
>  #define HPD_EVENT_DET			0x2120
>  
> -/* dpyx framer addr */
> +/* dptx framer addr */
>  #define DP_FRAMER_GLOBAL_CONFIG		0x2200
>  #define DP_SW_RESET			0x2204
>  #define DP_FRAMER_TU			0x2208
> @@ -431,6 +431,40 @@
>  /* Reference cycles when using lane clock as reference */
>  #define LANE_REF_CYC				0x8000
>  
> +/* register CM_VID_CTRL */
> +#define LANE_VID_REF_CYC(x)                    (((x) & (BIT(24) - 1)) << 0)
> +#define NMVID_MEAS_TOLERANCE(x)                        (((x) & 0xf) << 24)
> +
> +/* register DP_TX_PHY_CONFIG_REG */
> +#define DP_TX_PHY_TRAINING_ENABLE(x)           ((x) & 1)
> +#define DP_TX_PHY_TRAINING_TYPE_PRBS7          (0 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_TPS1           (1 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_TPS2           (2 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_TPS3           (3 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_TPS4           (4 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_PLTPAT         (5 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_D10_2          (6 << 1)
> +#define DP_TX_PHY_TRAINING_TYPE_HBR2CPAT       (8 << 1)
> +#define DP_TX_PHY_TRAINING_PATTERN(x)          ((x) << 1)
> +#define DP_TX_PHY_SCRAMBLER_BYPASS(x)          (((x) & 1) << 5)
> +#define DP_TX_PHY_ENCODER_BYPASS(x)            (((x) & 1) << 6)
> +#define DP_TX_PHY_SKEW_BYPASS(x)               (((x) & 1) << 7)
> +#define DP_TX_PHY_DISPARITY_RST(x)             (((x) & 1) << 8)
> +#define DP_TX_PHY_LANE0_SKEW(x)                (((x) & 7) << 9)
> +#define DP_TX_PHY_LANE1_SKEW(x)                (((x) & 7) << 12)
> +#define DP_TX_PHY_LANE2_SKEW(x)                (((x) & 7) << 15)
> +#define DP_TX_PHY_LANE3_SKEW(x)                (((x) & 7) << 18)
> +#define DP_TX_PHY_10BIT_ENABLE(x)              (((x) & 1) << 21)
> +
> +/* register DP_FRAMER_GLOBAL_CONFIG */
> +#define NUM_LANES(x)           ((x) & 3)
> +#define SST_MODE               (0 << 2)
> +#define RG_EN                  (0 << 4)
> +#define GLOBAL_EN              BIT(3)
> +#define NO_VIDEO               BIT(5)
> +#define ENC_RST_DIS            BIT(6)
> +#define WR_VHSYNC_FALL         BIT(7)
> +
>  enum voltage_swing_level {
>  	VOLTAGE_LEVEL_0,
>  	VOLTAGE_LEVEL_1,
> @@ -476,6 +510,7 @@ int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
>  int cdn_dp_event_config(struct cdn_dp_device *dp);
>  u32 cdn_dp_get_event(struct cdn_dp_device *dp);
>  int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
> +int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val);
>  ssize_t cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr,
>  			  u8 *data, u16 len);
>  ssize_t cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr,
> @@ -489,4 +524,5 @@ int cdn_dp_config_video(struct cdn_dp_device *dp);
>  int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
>  int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
>  int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
> +int cdn_dp_software_train_link(struct cdn_dp_device *dp);
>  #endif /* _CDN_DP_REG_H */
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
