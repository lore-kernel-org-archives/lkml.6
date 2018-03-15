Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeCOKt1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:49:27 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41307 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCOKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:49:25 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 15 Mar 2018 11:30:27 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Message-ID: <20180315103027.GE16424@w540>
References: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
 <CGME20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd@epcas4p4.samsung.com>
 <1520951425-13843-3-git-send-email-jacopo+renesas@jmondi.org>
 <8c224e1e-9871-dce9-89d0-3dad8218a747@samsung.com>
 <20180314100902.GB16424@w540>
 <4204d21d-080f-b275-1f89-828cfdcdf90a@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <4204d21d-080f-b275-1f89-828cfdcdf90a@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

HI Andrezej,

On Thu, Mar 15, 2018 at 10:44:42AM +0100, Andrzej Hajda wrote:
> On 14.03.2018 11:09, jacopo mondi wrote:
> > Hi Andrzej,
> >     thanks for review
> >
> > On Wed, Mar 14, 2018 at 09:42:36AM +0100, Andrzej Hajda wrote:
> >> On 13.03.2018 15:30, Jacopo Mondi wrote:
> >>> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> >>> output decoder.
> >> IMO converter suits here better, but it is just suggestion.
> >>
> >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>> ---
> >>>  drivers/gpu/drm/bridge/Kconfig        |   7 +
> >>>  drivers/gpu/drm/bridge/Makefile       |   1 +
> >>>  drivers/gpu/drm/bridge/thc63lvd1024.c | 241 ++++++++++++++++++++++++++++++++++
> >>>  3 files changed, 249 insertions(+)
> >>>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >>> index 3b99d5a..facf6bd 100644
> >>> --- a/drivers/gpu/drm/bridge/Kconfig
> >>> +++ b/drivers/gpu/drm/bridge/Kconfig
> >>> @@ -92,6 +92,13 @@ config DRM_SII9234
> >>>  	  It is an I2C driver, that detects connection of MHL bridge
> >>>  	  and starts encapsulation of HDMI signal.
> >>>
> >>> +config DRM_THINE_THC63LVD1024
> >>> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> >>> +	depends on OF
> >>> +	select DRM_PANEL_BRIDGE
> >> You don't use PANEL_BRIDGE, it should be possible to drop the select.
> >>
> > Ack
> >
> >>> +	---help---
> >>> +	  Thine THC63LVD1024 LVDS decoder bridge driver.
> >> Decoder to what?
> >> Maybe it would be better to say it is LVDS/parallel or LVDS/RGB
> >> converter or bridge.
> > "LVDS to digital CMOS/TTL parallel data converter" as the manual
> > describes the chip?
>
> Should work, unless we want some consistency in interface names, we have
> already: parallel / DPI / RGB. I am little bit confused about relations
> between them so I do not want to enforce any.

config DRM_THINE_THC63LVD1024
	tristate "Thine THC63LVD1024 LVDS decoder bridge"
	depends on OF
	---help---
	  Thine THC63LVD1024 LVDS/parallel converter driver.

I guess this is consistent with other symbol descriptions I found

>

[snip]
>
> >>> +
> >>> +static int thc63_gpio_init(struct thc63_dev *thc63)
> >>> +{
> >>> +	thc63->pwdn = devm_gpiod_get_optional(thc63->dev, "pwdn",
> >>> +					      GPIOD_OUT_LOW);
> >> Shouldn't be GPIOD_OUT_HIGH - bridge initially disabled?
> > No, the PWDN gpio is active low, it puts the chip in power down mode
> > when the physical line level is set to 0.
> >
> > That's another confusing thing, when requesting the GPIO, the actual
> > physical line value has to be provided, while when "set_value()" the
> > logical one is requested, iirc.
>
> I think it is opposite, only *raw* functions uses physical level. Other
> uses logical level.
>
> >
> > Being the GPIO defined as active low, in power enable we set it to
> > "logical inactive" == "physical 1", while during power disable it has
> > to be set to "logical active" == "physical 0"
> >
> > Not the right place to complain here, but imo that's not consistent.
> > Or have I misinterpreted the APIs? I cannot do much test, as in my setup
> > the PWDN pin is hardwired to +vcc (through a physical switch, not
> > controlled through a GPIO though).
>
> devm_gpiod_get_optional calls (indirectly) gpiod_configure_flags, which
> calls gpiod_direction_output which uses logical levels.

I clearly mis-interpreted the APIs.

I'll fix and I'm sending v4 out shortly.

Thanks
   j

>
> Regards
> Andrzej
>
> >
> > Thanks
> >    j
> >
> >> Regards
> >> Andrzej
> >>> +	if (IS_ERR(thc63->pwdn)) {
> >>> +		dev_err(thc63->dev, "Unable to get GPIO \"pwdn\"\n");
> >>> +		return PTR_ERR(thc63->pwdn);
> >>> +	}
> >>> +
> >>> +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
> >>> +	if (IS_ERR(thc63->oe)) {
> >>> +		dev_err(thc63->dev, "Unable to get GPIO \"oe\"\n");
> >>> +		return PTR_ERR(thc63->oe);
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int thc63_regulator_init(struct thc63_dev *thc63)
> >>> +{
> >>> +	struct regulator **reg;
> >>> +	int i;
> >>> +
> >>> +	reg = &thc63->vccs[0];
> >>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++, reg++) {
> >>> +		*reg = devm_regulator_get_optional(thc63->dev,
> >>> +						   thc63_reg_names[i]);
> >>> +		if (IS_ERR(*reg)) {
> >>> +			if (PTR_ERR(*reg) == -EPROBE_DEFER)
> >>> +				return -EPROBE_DEFER;
> >>> +			*reg = NULL;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int thc63_probe(struct platform_device *pdev)
> >>> +{
> >>> +	struct thc63_dev *thc63;
> >>> +	int ret;
> >>> +
> >>> +	thc63 = devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
> >>> +	if (!thc63)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	thc63->dev = &pdev->dev;
> >>> +	platform_set_drvdata(pdev, thc63);
> >>> +
> >>> +	ret = thc63_regulator_init(thc63);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	ret = thc63_gpio_init(thc63);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	ret = thc63_parse_dt(thc63);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	thc63->bridge.driver_private = thc63;
> >>> +	thc63->bridge.of_node = pdev->dev.of_node;
> >>> +	thc63->bridge.funcs = &thc63_bridge_func;
> >>> +
> >>> +	drm_bridge_add(&thc63->bridge);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int thc63_remove(struct platform_device *pdev)
> >>> +{
> >>> +	struct thc63_dev *thc63 = platform_get_drvdata(pdev);
> >>> +
> >>> +	drm_bridge_remove(&thc63->bridge);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_OF
> >>> +static const struct of_device_id thc63_match[] = {
> >>> +	{ .compatible = "thine,thc63lvd1024", },
> >>> +	{ },
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, thc63_match);
> >>> +#endif
> >>> +
> >>> +static struct platform_driver thc63_driver = {
> >>> +	.probe	= thc63_probe,
> >>> +	.remove	= thc63_remove,
> >>> +	.driver	= {
> >>> +		.name		= "thc63lvd1024",
> >>> +		.of_match_table	= thc63_match,
> >>> +	},
> >>> +};
> >>> +module_platform_driver(thc63_driver);
> >>> +
> >>> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> >>> +MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver");
> >>> +MODULE_LICENSE("GPL v2");
> >>
>

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaqktDAAoJEHI0Bo8WoVY8LtAP/3DDVciU0sbBOOzRmJDOhKvX
tp8CL5/6Y1hL76QcnEwBjfh5yYeHpi5VSbTVPnsbCZ7UeepzDVCPqcx7YeXjImRQ
g8bMeIz2h9tRY66xtwtvCtSNNGp8icO3ux7l/gL5t9jQupqe5SPlFJd8pdEkNw4o
wZzl7RoimObi/SXL4VHtQym70RLtBco9N1UVg/Lb2gK8K1hHlnGHCL/IVbLxEayk
KFoZHyq7DJkgvBbZMRppV6oktMdUQr7YzKdsXnyJDOGxKliDE6sMj2pskSW7eSaH
QLys3csCoQ/aaPv3QLSM9TQbs0XMrLr5qYAfEjo3TJ33AyEzkEbzIgJCEUf++Fa7
ZC8jhIEbK/RZOlDvKFx/X3X7ofiaOh83P9zsbQ5yBdr3AZv8lj2iqHYGykHNhSVp
ZcLR7aOKvm870MWMFqWd3JlExdOfEAZdQ6r79XA/8HIgXCn5xZKxCE4wrQ1TOfI2
jK2N4eLnHjLUu7qMWSbNU2JTzQKVkeuAP6lDrpe97eMsRqh1LPDyRDuDZMK79Nw+
XvZTZM2QOQznHikQMgLOh8eNz5eakImVEoJp++jkzaw5SxMiVeNixIcAkicg9ovg
XbCLNsjIavng0FSAz3O52CN/JIiRUNMpiESgfktRnaOy/+lfEjNIU2R1LxB5i/YG
WeXaFGrTasPXLTnDLgXy
=L0Kg
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
