Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10426C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58BA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfBAVgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:36:14 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38923 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfBAVgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:36:14 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A7EA980478;
        Fri,  1 Feb 2019 22:36:08 +0100 (CET)
Date:   Fri, 1 Feb 2019 22:36:07 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Message-ID: <20190201213607.GA27951@ravnborg.org>
References: <20190201172852.4944-1-pawel.mikolaj.chmiel@gmail.com>
 <20190201172852.4944-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190201172852.4944-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
        a=L5PT5Dt8MpijkRvZmKwA:9 a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł

Looks good, thanks for addressing all the review feedback.

On Fri, Feb 01, 2019 at 06:28:52PM +0100, Paweł Chmiel wrote:
> This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> spi. It's based on already removed, non dt s6e63m0 driver and
> panel-samsung-ld9040. It can be found for example in some of Samsung
> Aries based phones.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
If you consider (do not change unless you think it better) the
following nits than you can add my:

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 3f3537719beb..be05ed5218eb 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -158,6 +158,13 @@ config DRM_PANEL_SAMSUNG_S6E63J0X03
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	select VIDEOMODE_HELPERS
>  
> +config DRM_PANEL_SAMSUNG_S6E63M0
> +	tristate "Samsung S6E63M0 RGB/SPI panel"
> +	depends on OF
> +	depends on SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select VIDEOMODE_HELPERS
With the use of display_mode the above "select VIDEOMODE_HELPERS"
is likely no longer required. Please check.

A help text would be nice.

> +
>  config DRM_PANEL_SAMSUNG_S6E8AA0
>  	tristate "Samsung S6E8AA0 DSI video mode panel"
>  	depends on OF


> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
Please check if these two files are required.

> +struct s6e63m0 {
> +	struct device *dev;
> +	struct drm_panel panel;
> +	struct backlight_device *bl_dev;
> +
> +	struct regulator_bulk_data supplies[2];
> +	struct gpio_desc *reset_gpio;
> +	struct videomode vm;
vm is no longer used - delete it.

> +
> +	bool prepared;
> +	bool enabled;
> +
> +	/*
> +	 * This field is tested by functions directly accessing bus before
> +	 * transfer, transfer is skipped if it is set. In case of transfer
> +	 * failure or unexpected response the field is set to error value.
> +	 * Such construct allows to eliminate many checks in higher level
> +	 * functions.
> +	 */
> +	int error;
> +};
> +

> +static int s6e63m0_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		DRM_ERROR("failed to add mode %ux%ux@%u\n",
> +			  default_mode.hdisplay, default_mode.vdisplay,
> +			  default_mode.vrefresh);
I recall I have seen a generic way to print the above,
but I have failed to find it.
Maybe it is just my memory that fools me.

The above is fine.

> +
> +	s6e63m0_backlight_register(ctx);

Is it correct that we continue even if we fail to register backlight?


> +
> +	return 0;
> +}
> +
> +
> +static const struct of_device_id s6e63m0_of_match[] = {
> +	{ .compatible = "samsung,s6e63m0" },
> +	{ }

Add /* sentinel */ comment?

> +};

