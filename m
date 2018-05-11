Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeEKOln (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:41:43 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37729 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeEKOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:41:42 -0400
X-Google-Smtp-Source: AB8JxZphWLS3ZfAKLw3XQzo6ZgR0RdchT74wvPNzaV3H7dks9pZ68D4saB1jiW307sxBjBv1CATc8w==
Date: Fri, 11 May 2018 10:41:40 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
Subject: Re: [PATCH v2 2/4] phy: rockchip-typec: support variable phy config
 value
Message-ID: <20180511144140.GO33053@art_vandelay>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
 <1525861364-26323-2-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525861364-26323-2-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 06:22:42PM +0800, Lin Huang wrote:
> the phy config values used to fix in dp firmware, but some boards
> need change these values to do training and get the better eye diagram
> result. So support that in phy driver.
> 
FTR, I've previously reviewed this at
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/985573

This patch should come _after_ the dt binding addition.

> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - update patch following Enric suggest
> 
>  drivers/phy/rockchip/phy-rockchip-typec.c | 284 +++++++++++++++++++-----------
>  include/soc/rockchip/rockchip_phy_typec.h |  64 +++++++
>  2 files changed, 250 insertions(+), 98 deletions(-)
>  create mode 100644 include/soc/rockchip/rockchip_phy_typec.h
> 

/snip

> diff --git a/include/soc/rockchip/rockchip_phy_typec.h b/include/soc/rockchip/rockchip_phy_typec.h
> new file mode 100644
> index 0000000..4a328221
> --- /dev/null
> +++ b/include/soc/rockchip/rockchip_phy_typec.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#ifndef __SOC_ROCKCHIP_PHY_TYPEC_H
> +#define __SOC_ROCKCHIP_PHY_TYPEC_H
> +
> +struct usb3phy_reg {
> +	u32 offset;
> +	u32 enable_bit;
> +	u32 write_enable;
> +};
> +
> +/**
> + * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
> + * @reg: the base address for usb3-phy config.
> + * @typec_conn_dir: the register of type-c connector direction.
> + * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
> + * @external_psm: the register of type-c phy external psm clock.
> + * @pipe_status: the register of type-c phy pipe status.
> + * @usb3_host_disable: the register of type-c usb3 host disable.
> + * @usb3_host_port: the register of type-c usb3 host port.
> + * @uphy_dp_sel: the register of type-c phy DP select control.
> + */
> +struct rockchip_usb3phy_port_cfg {
> +	unsigned int reg;
> +	struct usb3phy_reg typec_conn_dir;
> +	struct usb3phy_reg usb3tousb2_en;
> +	struct usb3phy_reg external_psm;
> +	struct usb3phy_reg pipe_status;
> +	struct usb3phy_reg usb3_host_disable;
> +	struct usb3phy_reg usb3_host_port;
> +	struct usb3phy_reg uphy_dp_sel;
> +};
> +
> +struct phy_config {
> +	int swing;
> +	int pe;
> +};
> +
> +struct rockchip_typec_phy {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct extcon_dev *extcon;
> +	struct regmap *grf_regs;
> +	struct clk *clk_core;
> +	struct clk *clk_ref;
> +	struct reset_control *uphy_rst;
> +	struct reset_control *pipe_rst;
> +	struct reset_control *tcphy_rst;
> +	const struct rockchip_usb3phy_port_cfg *port_cfgs;
> +	/* mutex to protect access to individual PHYs */
> +	struct mutex lock;
> +	struct phy_config config[3][4];
> +	u8 need_software_training;

I thought we decided to always do sw training and then fallback to fw training.
If so, we don't need this.

Sean

> +	bool flip;
> +	u8 mode;
> +	int (*typec_phy_config)(struct phy *phy, int link_rate,
> +				int lanes, u8 swing, u8 pre_emp);
> +};
> +
> +#endif
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
