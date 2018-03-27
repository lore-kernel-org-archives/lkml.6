Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC0GYh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:24:37 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:37687 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeC0GYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:24:35 -0400
Subject: Re: [PATCH v6 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, <architt@codeaurora.org>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <airlied@linux.ie>, <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <geert@linux-m68k.org>, <niklas.soderlund@ragnatech.se>,
        <sergei.shtylyov@cogentembedded.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-3-git-send-email-jacopo+renesas@jmondi.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <30381869-9bc8-b6aa-a37a-598d9c8f280d@mentor.com>
Date: Tue, 27 Mar 2018 09:24:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <1521213399-31947-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 03/16/2018 05:16 PM, Jacopo Mondi wrote:
> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> output converter.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/gpu/drm/bridge/Kconfig        |   6 +
>  drivers/gpu/drm/bridge/Makefile       |   1 +
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 255 ++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3b99d5a..5815a20 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -92,6 +92,12 @@ config DRM_SII9234
>  	  It is an I2C driver, that detects connection of MHL bridge
>  	  and starts encapsulation of HDMI signal.
>  
> +config DRM_THINE_THC63LVD1024
> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> +	depends on OF
> +	---help---
> +	  Thine THC63LVD1024 LVDS/parallel converter driver.
> +
>  config DRM_TOSHIBA_TC358767
>  	tristate "Toshiba TC358767 eDP bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 373eb28..fd90b16 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> new file mode 100644
> index 0000000..02a54c2
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
> + *
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_panel.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>
> +
> +enum {
> +	THC63_LVDS_IN0,
> +	THC63_LVDS_IN1,
> +	THC63_DIGITAL_OUT0,
> +	THC63_DIGITAL_OUT1,
> +};
> +
> +static const char * const thc63_reg_names[] = {
> +	"vcc", "lvcc", "pvcc", "cvcc",
> +};
> +
> +struct thc63_dev {
> +	struct device *dev;
> +
> +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
> +
> +	struct gpio_desc *pdwn;
> +	struct gpio_desc *oe;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next;
> +};
> +
> +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct thc63_dev, bridge);
> +}
> +
> +static int thc63_attach(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +
> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
> +}
> +
> +static void thc63_enable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	struct regulator *vcc;
> +	int i;

unsigned int i;

> +
> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> +		vcc = thc63->vccs[i];
> +		if (!vcc)
> +			continue;
> +
> +		if (regulator_enable(vcc))
> +			goto error_vcc_enable;
> +	}
> +
> +	if (thc63->pdwn)
> +		gpiod_set_value(thc63->pdwn, 0);
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 1);
> +
> +	return;
> +
> +error_vcc_enable:
> +	dev_err(thc63->dev, "Failed to enable regulator %s\n",
> +		thc63_reg_names[i]);
> +
> +	for (i = i - 1; i >= 0; i--) {
> +		vcc = thc63->vccs[i];
> +		if (!vcc)
> +			continue;
> +
> +		regulator_disable(vcc);
> +	}
> +}
> +
> +static void thc63_disable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	struct regulator *vcc;
> +	int i;
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 0);
> +
> +	if (thc63->pdwn)
> +		gpiod_set_value(thc63->pdwn, 1);
> +
> +	for (i = ARRAY_SIZE(thc63->vccs) - 1; i >= 0; i--) {
> +		vcc = thc63->vccs[i];
> +		if (!vcc)
> +			continue;
> +
> +		if (regulator_disable(vcc))
> +			dev_dbg(thc63->dev,
> +				"Failed to disable regulator %s\n",
> +				thc63_reg_names[i]);
> +	}
> +}
> +
> +struct drm_bridge_funcs thc63_bridge_func = {

Apparently you missed all my comments from v2 review.

If you like to avoid non-NULL function pointers to the void, please 
use static const storage qualifier.

--
With best wishes,
Vladimir
