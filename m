Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeBFJfo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:35:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56201 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeBFJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:35:35 -0500
Message-ID: <1517909728.3346.2.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/7] drm/panel: simple: add support for Ampire
 AM-800480AYTZQW-00H
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jagan Teki <jagannadh.teki@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
Date: Tue, 06 Feb 2018 10:35:28 +0100
In-Reply-To: <1517766571-409-2-git-send-email-jagan@amarulasolutions.com>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
         <1517766571-409-2-git-send-email-jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Sun, 2018-02-04 at 23:19 +0530, Jagan Teki wrote:
> This adds support for the Ampire AM-800480AYTZQW-00H 7.0" WGA LCD,
> which can be supported by the simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v3:
> - collect Rob reiew tag 
> Changes for v2:
> - Updated binding info about optional properties, node and example
> 
>  .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 ++++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
> new file mode 100644
> index 0000000..abb5eee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
> @@ -0,0 +1,25 @@
> +Ampire AM-800480AYTZQW-00H 7.0" WVGA TFT LCD panel
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> +
> +Required properties:
> +- compatible: should be "ampire,am-800480aytzqw-00h"
> +
> +Optional properties:
> +- backlight: phandle of the backlight device attached to the panel
> +
> +Optional nodes:
> +- Video port for LVDS panel input.
> +
> +Example:
> +	panel {
> +		compatible = "ampire,am-800480aytzqw-00h";
> +		backlight = <&backlight_lvds>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 5591984..2ecc14b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -412,6 +412,30 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
>  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>  };
>  
> +static const struct display_timing ampire_am_800480aytzqw_00h_timing = {
> +	.pixelclock = { 27700000, 29200000, 39600000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 12, 40, 212 },
> +	.hback_porch = { 88, 88, 88 },
> +	.hsync_len = { 1, 2, 40 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 1, 13, 88 },
> +	.vback_porch = { 32, 32, 32 },
> +	.vsync_len = { 1, 2, 3 },
> +	.flags = DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc ampire_am_800480aytzqw_00h = {
> +	.timings = &ampire_am_800480aytzqw_00h_timing,
> +	.num_timings = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 154,
> +		.height = 86,
> +	},

If the panel datasheet specifies minimal prepare, enable, disable, and
unprepare delays, it would be good to add them to the panel descriptor.

> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> +};
> +
>  static const struct drm_display_mode ampire_am800480r3tmqwa1h_mode = {
>  	.clock = 33333,
>  	.hdisplay = 800,
> @@ -2028,6 +2052,9 @@ static const struct of_device_id platform_of_match[] = {
>  		.compatible = "ampire,am-480272h3tmqw-t01h",
>  		.data = &ampire_am_480272h3tmqw_t01h,
>  	}, {
> +		.compatible = "ampire,am-800480aytzqw-00h",
> +		.data = &ampire_am_800480aytzqw_00h,
> +	}, {
>  		.compatible = "ampire,am800480r3tmqwa1h",
>  		.data = &ampire_am800480r3tmqwa1h,
>  	}, {

regards
Philipp
