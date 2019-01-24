Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4229BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1875E21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfAXTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:33 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:55561 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733036AbfAXTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:30 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4E00A20065;
        Thu, 24 Jan 2019 20:39:27 +0100 (CET)
Date:   Thu, 24 Jan 2019 20:39:25 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190124193925.GA4783@ravnborg.org>
References: <20190124182844.28961-1-jagan@amarulasolutions.com>
 <20190124182844.28961-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124182844.28961-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8 a=7gkXJVJtAAAA:8
        a=W27XrlIvMiTBEXZCYYgA:9 a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

Thanks for being persistent and keep follow-up on this driver.

On Thu, Jan 24, 2019 at 11:58:44PM +0530, Jagan Teki wrote:
> ST7701 designed for small and medium sizes of TFT LCD display, is
> capable of supporting up to 480RGBX864 in resolution. It provides
> several system interfaces like MIPI/RGB/SPI.
> 
> Currently added support for Techstar TS8550B which is ST7701 based
> 480x854, 2-lane MIPI DSI LCD panel.
> 
> Driver now registering mipi_dsi device, but indeed it can extendable
> for RGB if any requirement trigger in future.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> new file mode 100644
> index 000000000000..499dd8a34a6d
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019, Amarula Solutions.
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drmP.h>
For new drivers please do not use drmP.h.
We are slowly going away from this and in drm-misc.git
the drmP.h file is no longer needed for anything.


> +	st7701->backlight = devm_of_find_backlight(&dsi->dev);
> +	if (IS_ERR(st7701->backlight))
> +		return PTR_ERR(st7701->backlight);

> +static int st7701_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&st7701->panel);
> +
> +	if (st7701->backlight)
> +		put_device(&st7701->backlight->dev);
> +
> +	return 0;
> +}

Please address this comment from Noralf:
"This happens automatically on driver detach if devm_of_find_backlight()
is used"

In other words, no need to do anything with backlight in st7701_dsi_remove()

With these details fixed you can add back my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
