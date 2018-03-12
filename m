Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeCLHji (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:39:38 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37099 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCLHjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:39:37 -0400
X-Google-Smtp-Source: AG47ELsBJH6UBiuAJlnkdqwLvbDPVzqiQ8s1wQiz6MhssW8OPizpj3JfHyTIwIeTnZQq5CvkfBrDUQ==
Date: Mon, 12 Mar 2018 08:39:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 5/7] drm/panel: Add Ilitek ILI9881c panel driver
Message-ID: <20180312073933.GD23060@ulmo>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <4ebd47038b1ee1cc6b7d9738313f43f985268463.1520344489.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <4ebd47038b1ee1cc6b7d9738313f43f985268463.1520344489.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 02:56:02PM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic, and =
is
> based on the Ilitek ILI9881c Controller. Add a driver for it, modelled
> after the other Ilitek controller drivers.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +-
>  drivers/gpu/drm/panel/Makefile                |   1 +-
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 506 +++++++++++++++++++-
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
[...]
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
[...]
> +static int ili9881c_prepare(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +	int i, ret;

i can be unsigned.

> +
> +	/* Power the panel */
> +	gpiod_set_value(ctx->power, 1);
> +	mdelay(5);
> +
> +	/* And reset it */
> +	gpiod_set_value(ctx->reset, 1);
> +	mdelay(20);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	mdelay(20);

5 and 20 milliseconds are much too long to busy loop. Use usleep_range()
and msleep() instead. It's probably fine to use msleep(5) in this case
regardless of the advice in Documentation/timers/timers-howto.txt since
a few milliseconds more aren't going to matter here.

> +
> +	for (i =3D 0; i < ARRAY_SIZE(ili9881c_init); i++) {
> +		struct ili9881c_instr *instr =3D &ili9881c_init[i];
> +
> +		if (instr->op =3D=3D ILI9881C_SWITCH_PAGE)
> +			ret =3D ili9881c_switch_page(ctx, instr->arg.page);
> +		else if (instr->op =3D=3D ILI9881C_COMMAND)
> +			ret =3D ili9881c_send_cmd_data(ctx, instr->arg.cmd.cmd,
> +						      instr->arg.cmd.data);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D ili9881c_switch_page(ctx, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mipi_dsi_dcs_set_tear_on(ctx->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLAN=
K);
> +	if (ret)
> +		return ret;
> +
> +	mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void ili9881c_enable_bl(struct ili9881c *ctx, bool enable)
> +{
> +	if (!ctx->backlight)
> +		return;
> +
> +	if (enable) {
> +		ctx->backlight->props.state &=3D ~BL_CORE_FBBLANK;
> +		ctx->backlight->props.power =3D FB_BLANK_UNBLANK;
> +	} else {
> +		ctx->backlight->props.power =3D FB_BLANK_POWERDOWN;
> +		ctx->backlight->props.state |=3D BL_CORE_FBBLANK;
> +	}
> +
> +	backlight_update_status(ctx->backlight);
> +}

There's a new pair of functions, backlight_enable() and
backlight_disable() that do this now. Please use those. They also work
fine when passed a NULL pointer, so should be perfect to replace this
with.

> +
> +static int ili9881c_enable(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +
> +	mdelay(120);

Hogging the CPU for 120 milliseconds like this is a really bad idea. Use
msleep() instead.

> +	mipi_dsi_dcs_set_display_on(ctx->dsi);
> +
> +	ili9881c_enable_bl(ctx, true);
> +
> +	return 0;
> +}
> +
> +static int ili9881c_disable(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +
> +	ili9881c_enable_bl(ctx, false);
> +
> +	return mipi_dsi_dcs_set_display_off(ctx->dsi);
> +}
> +
> +static int ili9881c_unprepare(struct drm_panel *panel)
> +{
> +	struct ili9881c *ctx =3D panel_to_ili9881c(panel);
> +
> +	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	gpiod_set_value(ctx->power, 0);
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode default_mode =3D {
> +	.clock		=3D 62000,
> +	.vrefresh	=3D 60,
> +
> +	.hdisplay	=3D 720,
> +	.hsync_start	=3D 720 + 10,
> +	.hsync_end	=3D 720 + 10 + 20,
> +	.htotal		=3D 720 + 10 + 20 + 30,
> +
> +	.vdisplay	=3D 1280,
> +	.vsync_start	=3D 1280 + 10,
> +	.vsync_end	=3D 1280 + 10 + 10,
> +	.vtotal		=3D 1280 + 10 + 10 + 20,
> +};

You may want to consider using struct display_timing instead, since that
will allow the driver to be used on a broader range of devices.

Thierry

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmLrIACgkQ3SOs138+
s6GFRw/9H9DWqj/LMXpVUH/rW0esfihtOZz60cWwAOLioKVY0YUDD90VhADWcF7h
ZZ0pz1rs5JrgA9obSz4eIprq4R4rdsEaZxQJgjhSRaVLk/kCZGc7mLVngATLT5f+
6dvDJKewJIGBbF6cgDgOIYYthbUzn8rldnDCcvzxTk5WkF783f24pirvePXSOeya
BjGDHrfVQVRtVJ7cYgroI0LD8o+w9/jOM5XHhJ7FYWkW3a3HkJEVj8xC+BlTQjWA
EpOtGKfBHSZoMf2HsloC6Q4EiERInHBGDO8aUDWwTGtbm3adaNbcXZcq1buo/IC3
HQTQaexUHDliuWc+xiDrWFvvWlBgbQw2Rt3WVcyz88R6++mS5VmwcQ7JXhGZRLAC
0Sef9OTmfUc22m6x0C/Nh15gfD+sLF61arMWpXVmYrzeDscyVp5SSKXg3TUZpuxg
h4nAm3zw6qFH/0ofXc1xZaRLgcAMx5EooKRrhZuntR5h0UT/EJtYhpWAflUlTj2H
dLtUHGEY6H+0qmV4Nn9lZf5Dng4TE0+CKT446EQieOTEgnbkIVSQd0ETBQ59LAYx
IlHsh6MdoFapq9t0fpChWCIW/rkGJ+gyW+NIld3sH2EerZ2AXcY9pQtBSAGdVpUo
2JbS5lLtUd8qQp/HmlE1/NZUqpB2tS1On1pUBjJJVXbhMUYNJ1w=
=BwOM
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
