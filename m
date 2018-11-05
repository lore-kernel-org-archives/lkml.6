Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C90C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D020862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2D020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeKESis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:38:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46160 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:38:47 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8365780805; Mon,  5 Nov 2018 10:19:58 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:20:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 10/14] USB: gadget: mv-udc: use phy-pxa-usb
Message-ID: <20181105092000.GJ4439@amd>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-11-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
In-Reply-To: <20180822204307.13251-11-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-22 22:43:03, Lubomir Rintel wrote:
> Use a proper PHY driver, instead of hooks to a board support package.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/arm/mach-mmp/devices.c          | 11 +-------
>  drivers/usb/gadget/udc/mv_udc.h      |  7 ++++-
>  drivers/usb/gadget/udc/mv_udc_core.c | 38 ++++++++--------------------
>  3 files changed, 17 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
> index eb9b3c34e90a..d925be9f14a9 100644
> --- a/arch/arm/mach-mmp/devices.c
> +++ b/arch/arm/mach-mmp/devices.c
> @@ -263,21 +263,12 @@ struct platform_device pxa168_device_usb_phy =3D {
> =20
>  #if IS_ENABLED(CONFIG_USB_MV_UDC)
>  struct resource pxa168_u2o_resources[] =3D {
> -	/* regbase */
>  	[0] =3D {
> -		.start	=3D PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
> +		.start	=3D PXA168_U2O_REGBASE,
>  		.end	=3D PXA168_U2O_REGBASE + USB_REG_RANGE,
>  		.flags	=3D IORESOURCE_MEM,
> -		.name	=3D "capregs",
>  	},
> -	/* phybase */
>  	[1] =3D {
> -		.start	=3D PXA168_U2O_PHYBASE,
> -		.end	=3D PXA168_U2O_PHYBASE + USB_PHY_RANGE,
> -		.flags	=3D IORESOURCE_MEM,
> -		.name	=3D "phyregs",
> -	},
> -	[2] =3D {
>  		.start	=3D IRQ_PXA168_USB1,
>  		.end	=3D IRQ_PXA168_USB1,
>  		.flags	=3D IORESOURCE_IRQ,
> diff --git a/drivers/usb/gadget/udc/mv_udc.h b/drivers/usb/gadget/udc/mv_=
udc.h
> index b3f759c0962c..6f04f432964d 100644
> --- a/drivers/usb/gadget/udc/mv_udc.h
> +++ b/drivers/usb/gadget/udc/mv_udc.h
> @@ -6,6 +6,9 @@
>  #ifndef __MV_UDC_H
>  #define __MV_UDC_H
> =20
> +/* registers */
> +#define U2x_CAPREGS_OFFSET	0x100
> +
>  #define VUSBHS_MAX_PORTS	8
> =20
>  #define DQH_ALIGNMENT		2048
> @@ -174,9 +177,9 @@ struct mv_udc {
>  	struct platform_device		*dev;
>  	int				irq;
> =20
> +	void __iomem                    *base;
>  	struct mv_cap_regs __iomem	*cap_regs;
>  	struct mv_op_regs __iomem	*op_regs;
> -	void __iomem                    *phy_regs;
>  	unsigned int			max_eps;
>  	struct mv_dqh			*ep_dqh;
>  	size_t				ep_dqh_size;
> @@ -219,6 +222,8 @@ struct mv_udc {
> =20
>  	/* some SOC has mutiple clock sources for USB*/
>  	struct clk      *clk;
> +
> +	struct phy	*phy;
>  };
> =20
>  /* endpoint data structure */
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/ud=
c/mv_udc_core.c
> index 95f52232493b..c701c83d3af5 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -1069,14 +1069,11 @@ static int mv_udc_enable_internal(struct mv_udc *=
udc)
>  	if (retval)
>  		return retval;
> =20
> -	if (udc->pdata->phy_init) {
> -		retval =3D udc->pdata->phy_init(udc->phy_regs);
> -		if (retval) {
> -			dev_err(&udc->dev->dev,
> -				"init phy error %d\n", retval);
> -			udc_clock_disable(udc);
> -			return retval;
> -		}
> +	retval =3D phy_init(udc->phy);
> +	if (retval) {
> +		dev_err(&udc->dev->dev, "init phy error %d\n", retval);
> +		udc_clock_disable(udc);
> +		return retval;
>  	}
>  	udc->active =3D 1;
> =20
> @@ -1095,8 +1092,7 @@ static void mv_udc_disable_internal(struct mv_udc *=
udc)
>  {
>  	if (udc->active) {
>  		dev_dbg(&udc->dev->dev, "disable udc\n");
> -		if (udc->pdata->phy_deinit)
> -			udc->pdata->phy_deinit(udc->phy_regs);
> +		phy_exit(udc->phy);
>  		udc_clock_disable(udc);
>  		udc->active =3D 0;
>  	}
> @@ -2147,30 +2143,16 @@ static int mv_udc_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(udc->clk))
>  		return PTR_ERR(udc->clk);
> =20
> -	r =3D platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
> +	r =3D platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
>  	if (r =3D=3D NULL) {
>  		dev_err(&pdev->dev, "no I/O memory resource defined\n");
>  		return -ENODEV;
>  	}
> =20
> -	udc->cap_regs =3D (struct mv_cap_regs __iomem *)
> -		devm_ioremap(&pdev->dev, r->start, resource_size(r));
> -	if (udc->cap_regs =3D=3D NULL) {
> -		dev_err(&pdev->dev, "failed to map I/O memory\n");
> -		return -EBUSY;
> -	}
> -
> -	r =3D platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "phyregs");
> -	if (r =3D=3D NULL) {
> -		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
> -		return -ENODEV;
> -	}
> +	udc->base =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
> =20
> -	udc->phy_regs =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
> -	if (udc->phy_regs =3D=3D NULL) {
> -		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
> -		return -EBUSY;
> -	}
> +	udc->cap_regs =3D
> +		(void __iomem *) ((unsigned long)udc->base + U2x_CAPREGS_OFFSET);
> =20
>  	/* we will acces controller register, so enable the clk */
>  	retval =3D mv_udc_enable_internal(udc);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvgC0AACgkQMOfwapXb+vIRDQCfU1xerhnJD27kdw+JOaEQUdVB
MxgAn1kBpH9+c+mF9cSVDbmW8uDK0of0
=UJt7
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
