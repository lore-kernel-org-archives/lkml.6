Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeEUIFb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:05:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37897 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeEUIF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:05:29 -0400
Date: Mon, 21 May 2018 10:05:17 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 05/15] drm/sun4i: Add TCON TOP driver
Message-ID: <20180521080517.3qmlfajqpn4uw7jv@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kzknxzpukknjsac3"
Content-Disposition: inline
In-Reply-To: <20180519183127.2718-6-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzknxzpukknjsac3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2018 at 08:31:17PM +0200, Jernej Skrabec wrote:
> As already described in DT binding, TCON TOP is responsible for
> configuring display pipeline. In this initial driver focus is on HDMI
> pipeline, so TVE and LCD configuration is not implemented.
>=20
> Implemented features:
> - HDMI source selection
> - clock driver (TCON and DSI gating)
> - connecting mixers and TCONS
>=20
> Something similar also existed in previous SoCs, except that it was part
> of first TCON.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/Makefile             |   3 +-
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c     | 256 +++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.h     |  20 ++
>  include/dt-bindings/clock/sun8i-tcon-top.h |  11 +
>  4 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h
>  create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h
>=20
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makef=
ile
> index 2589f4acd5ae..09fbfd6304ba 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -16,7 +16,8 @@ sun8i-drm-hdmi-y		+=3D sun8i_hdmi_phy_clk.o
> =20
>  sun8i-mixer-y			+=3D sun8i_mixer.o sun8i_ui_layer.o \
>  				   sun8i_vi_layer.o sun8i_ui_scaler.o \
> -				   sun8i_vi_scaler.o sun8i_csc.o
> +				   sun8i_vi_scaler.o sun8i_csc.o \
> +				   sun8i_tcon_top.o
> =20
>  sun4i-tcon-y			+=3D sun4i_crtc.o
>  sun4i-tcon-y			+=3D sun4i_dotclock.o
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> new file mode 100644
> index 000000000000..075a356a6dfa
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
> +
> +#include <drm/drmP.h>
> +
> +#include <dt-bindings/clock/sun8i-tcon-top.h>
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#include "sun8i_tcon_top.h"
> +
> +#define TCON_TOP_PORT_SEL_REG		0x1C
> +#define TCON_TOP_PORT_DE0_MSK			GENMASK(1, 0)
> +#define TCON_TOP_PORT_DE1_MSK			GENMASK(5, 4)
> +#define TCON_TOP_PORT_TCON_LCD0			0
> +#define TCON_TOP_PORT_TCON_LCD1			1
> +#define TCON_TOP_PORT_TCON_TV0			2
> +#define TCON_TOP_PORT_TCON_TV1			3
> +
> +#define TCON_TOP_GATE_SRC_REG		0x20
> +#define TCON_TOP_HDMI_SRC_MSK			GENMASK(29, 28)
> +#define TCON_TOP_HDMI_SRC_NONE			0
> +#define TCON_TOP_HDMI_SRC_TCON_TV0		1
> +#define TCON_TOP_HDMI_SRC_TCON_TV1		2
> +#define TCON_TOP_TCON_TV1_GATE			24
> +#define TCON_TOP_TCON_TV0_GATE			20
> +#define TCON_TOP_TCON_DSI_GATE			16
> +
> +#define CLK_NUM					3
> +
> +struct sun8i_tcon_top {
> +	struct clk		*bus;
> +	void __iomem		*regs;
> +	struct reset_control	*rst;
> +
> +	/*
> +	 * spinlock is used for locking access to registers from different
> +	 * places - tcon driver and clk subsystem.
> +	 */
> +	spinlock_t		reg_lock;
> +};
> +
> +struct sun8i_tcon_top_gate {
> +	const char	*name;
> +	u8		bit;
> +	int		index;
> +};
> +
> +static const struct sun8i_tcon_top_gate gates[] =3D {
> +	{"bus-tcon-top-dsi", TCON_TOP_TCON_DSI_GATE, CLK_BUS_TCON_TOP_DSI},
> +	{"bus-tcon-top-tv0", TCON_TOP_TCON_TV0_GATE, CLK_BUS_TCON_TOP_TV0},
> +	{"bus-tcon-top-tv1", TCON_TOP_TCON_TV1_GATE, CLK_BUS_TCON_TOP_TV1},
> +};
> +
> +void sun8i_tcon_top_set_hdmi_src(struct sun8i_tcon_top *tcon_top, int tc=
on)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	if (tcon > 1) {
> +		DRM_ERROR("TCON index is too high!\n");
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);
> +
> +	val =3D readl(tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> +	val &=3D ~TCON_TOP_HDMI_SRC_MSK;
> +	val |=3D FIELD_PREP(TCON_TOP_HDMI_SRC_MSK,
> +			  TCON_TOP_HDMI_SRC_TCON_TV0 + tcon);
> +	writel(val, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> +
> +	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
> +}
> +
> +void sun8i_tcon_top_de_config(struct sun8i_tcon_top *tcon_top,
> +			      int mixer, enum tcon_type tcon_type, int tcon)
> +{
> +	unsigned long flags;
> +	u32 val, reg;
> +
> +	if (mixer > 1) {
> +		DRM_ERROR("Mixer index is too high!\n");
> +		return;
> +	}
> +
> +	if (tcon > 1) {
> +		DRM_ERROR("TCON index is too high!\n");
> +		return;
> +	}
> +
> +	switch (tcon_type) {
> +	case tcon_type_lcd:
> +		val =3D TCON_TOP_PORT_TCON_LCD0 + tcon;
> +		break;
> +	case tcon_type_tv:
> +		val =3D TCON_TOP_PORT_TCON_TV0 + tcon;
> +		break;
> +	default:
> +		DRM_ERROR("Invalid TCON type!\n");
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);
> +
> +	reg =3D readl(tcon_top->regs + TCON_TOP_PORT_SEL_REG);
> +	if (mixer =3D=3D 0) {
> +		reg &=3D ~TCON_TOP_PORT_DE0_MSK;
> +		reg |=3D FIELD_PREP(TCON_TOP_PORT_DE0_MSK, val);
> +	} else {
> +		reg &=3D ~TCON_TOP_PORT_DE1_MSK;
> +		reg |=3D FIELD_PREP(TCON_TOP_PORT_DE1_MSK, val);
> +	}
> +	writel(reg, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
> +
> +	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
> +}
> +
> +static int sun8i_tcon_top_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct sun8i_tcon_top *tcon_top;
> +	struct device *dev =3D &pdev->dev;
> +	struct resource *res;
> +	int ret, i;
> +
> +	tcon_top =3D devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> +	if (!tcon_top)
> +		return -ENOMEM;
> +
> +	clk_data =3D devm_kzalloc(&pdev->dev, sizeof(*clk_data) +
> +				sizeof(*clk_data->hws) * CLK_NUM,
> +				GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&tcon_top->reg_lock);
> +
> +	tcon_top->rst =3D devm_reset_control_get(dev, "rst");
> +	if (IS_ERR(tcon_top->rst)) {
> +		dev_err(dev, "Couldn't get our reset line\n");
> +		return PTR_ERR(tcon_top->rst);
> +	}
> +
> +	tcon_top->bus =3D devm_clk_get(dev, "bus");
> +	if (IS_ERR(tcon_top->bus)) {
> +		dev_err(dev, "Couldn't get the bus clock\n");
> +		return PTR_ERR(tcon_top->bus);
> +	}
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tcon_top->regs =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(tcon_top->regs))
> +		return PTR_ERR(tcon_top->regs);
> +
> +	ret =3D reset_control_deassert(tcon_top->rst);
> +	if (ret) {
> +		dev_err(dev, "Could not deassert ctrl reset control\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(tcon_top->bus);
> +	if (ret) {
> +		dev_err(dev, "Could not enable bus clock\n");
> +		goto err_assert_reset;
> +	}
> +
> +	/*
> +	 * Default register values might have some reserved bits set, which
> +	 * prevents TCON TOP from working properly. Set them to 0 here.
> +	 */
> +	writel(0, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
> +	writel(0, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> +
> +	for (i =3D 0; i < CLK_NUM; i++) {
> +		const char *parent_name =3D "bus-tcon-top";

I guess retrieving the parent's clock name at runtime would be more
flexible.

> +		struct clk_init_data init;
> +		struct clk_gate *gate;
> +
> +		gate =3D devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
> +		if (!gate) {
> +			ret =3D -ENOMEM;
> +			goto err_disable_clock;
> +		}
> +
> +		init.name =3D gates[i].name;
> +		init.ops =3D &clk_gate_ops;
> +		init.flags =3D CLK_IS_BASIC;
> +		init.parent_names =3D &parent_name;
> +		init.num_parents =3D 1;
> +
> +		gate->reg =3D tcon_top->regs + TCON_TOP_GATE_SRC_REG;
> +		gate->bit_idx =3D gates[i].bit;
> +		gate->lock =3D &tcon_top->reg_lock;
> +		gate->hw.init =3D &init;
> +
> +		ret =3D devm_clk_hw_register(dev, &gate->hw);
> +		if (ret)
> +			goto err_disable_clock;

Isn't it what clk_hw_register_gate is doing?

> +		clk_data->hws[gates[i].index] =3D &gate->hw;
> +	}
> +
> +	clk_data->num =3D CLK_NUM;
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_dat=
a);
> +	if (ret)
> +		goto err_disable_clock;
> +
> +	platform_set_drvdata(pdev, tcon_top);
> +
> +	return 0;
> +
> +err_disable_clock:
> +	clk_disable_unprepare(tcon_top->bus);
> +err_assert_reset:
> +	reset_control_assert(tcon_top->rst);
> +
> +	return ret;
> +}
> +
> +static int sun8i_tcon_top_remove(struct platform_device *pdev)
> +{
> +	struct sun8i_tcon_top *tcon_top =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(tcon_top->bus);
> +	reset_control_assert(tcon_top->rst);
> +
> +	return 0;
> +}
> +
> +const struct of_device_id sun8i_tcon_top_of_table[] =3D {
> +	{ .compatible =3D "allwinner,sun8i-r40-tcon-top" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
> +
> +static struct platform_driver sun8i_tcon_top_platform_driver =3D {
> +	.probe		=3D sun8i_tcon_top_probe,
> +	.remove		=3D sun8i_tcon_top_remove,
> +	.driver		=3D {
> +		.name		=3D "sun8i-tcon-top",
> +		.of_match_table	=3D sun8i_tcon_top_of_table,
> +	},
> +};
> +module_platform_driver(sun8i_tcon_top_platform_driver);
> +
> +MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@siol.net>");
> +MODULE_DESCRIPTION("Allwinner R40 TCON TOP driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.h
> new file mode 100644
> index 000000000000..19126e07d2a6
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
> +
> +#ifndef _SUN8I_TCON_TOP_H_
> +#define _SUN8I_TCON_TOP_H_
> +
> +#include <linux/device.h>
> +
> +struct sun8i_tcon_top;
> +
> +enum tcon_type {
> +	tcon_type_lcd,
> +	tcon_type_tv,

The usual practice is to have the enum values upper-case.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kzknxzpukknjsac3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsCfbwACgkQ0rTAlCFN
r3REBg/+OCrvMx4b6+z6IGimp3JsyQRyI5jZnhScmJPmJKe+9SlsUdCF0qL/D58d
HD+RsaL5XM/szhpNV7tAwgimjooDyKQAnJDhv0G2jn6XFiARy3x1NDvYrED7Raah
uduePzA/0BtmZHpmYcpJE5fvapRUAL6KnKA1erGFfW+DaMDe7pHawWfV5DZPp6SF
rYHd9N8lS18tbYJ7ay3oPTNxxJvuOkIFYRq5CDDELM1D5RNTKMW41ViDhqEgGNNU
tQ6wTLbyHWFtSrmQ7eQJvlxtLmygkQZ1AtZeJnDdc6Tpns466Cr8qHZN5Ga3LW1D
wVb0xmjX1Y/0/60YJHJmRdGu1uriIlrgqCp4FIfvCEYmCNhL40THAimCv4X/zWbx
Kpl+Z9AwVwoVStKXQMU5+XHiEv2wKZjMauR9cDq+uoK26+Nb2aHXJN0gsISi1dFV
s+dQNZknbPuCHWfP1eQk7PwjTTiSE9PR/Yqr5HyxforOsp3IVdcqy+za7LxAyKfe
0E0L0mc8mAl/DHTW7nw+KvhzffX6A4lc9542q5qQ2sfAPgbpkD3WZA6nv1dCJ+66
KGDB1StPk2KPKnzhvILs1NNVnbY3LvrJygFlOwlAefJu50QuuUfI9/bKQFR36/ky
IAcol2jc1ktAKgqUkvK5xuX3fXtNriUOpDu02r47d6PdR51Elok=
=tb8F
-----END PGP SIGNATURE-----

--kzknxzpukknjsac3--
