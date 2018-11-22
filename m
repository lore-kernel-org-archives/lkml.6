Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAFB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAFB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438041AbeKWCjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:39:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33448 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438023AbeKWCjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:39:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7001820DC6; Thu, 22 Nov 2018 16:59:54 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4287B20712;
        Thu, 22 Nov 2018 16:59:44 +0100 (CET)
Date:   Thu, 22 Nov 2018 16:59:44 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v3 05/17] irqchip/sun4i: add support for suniv
 interrupt controller
Message-ID: <20181122155944.vkx2u4iwwedheor2@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
 <20181122083547.srnopylueqx6p2qj@flea>
 <20181122150200.p6e22sp3v4npb42w@ThinkPad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h2z3qr6y2agvh63m"
Content-Disposition: inline
In-Reply-To: <20181122150200.p6e22sp3v4npb42w@ThinkPad>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h2z3qr6y2agvh63m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 06:02:00PM +0300, Mesih Kilinc wrote:
> > > diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> > > index e3e5b91..7ca4a4d 100644
> > > --- a/drivers/irqchip/irq-sun4i.c
> > > +++ b/drivers/irqchip/irq-sun4i.c
> > > @@ -28,11 +28,21 @@
> > >  #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
> > >  #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
> > >  #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
> > > -#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
> > > -#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
> > > +#define SUN4I_IRQ_ENABLE_REG(x)		(irq_ic_data->enable_req_offset + 0=
x4 * x)
> > > +#define SUN4I_IRQ_MASK_REG(x)		(irq_ic_data->mask_req_offset + 0x4 *=
 x)
> >=20
> > You shouldn't have all the values you use passed as argument, so
> > irq_ic_data should be one of them here.
> >
>
> Could you elaborate it a little bit?

You should change your macro to something like:

SUN4I_IRQ_ENABLE_REG(data, x) ((data)->enable_req_offset + 0x4 * x)

That way, you are transparent about the parameters that the macro
expects, and don't rely on some unwritten rule about the variable
name.

> > > +
> > > +static int __init suniv_ic_of_init(struct device_node *node,
> > > +				   struct device_node *parent)
> > > +{
> > > +	irq_ic_data =3D kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KER=
NEL);
> > > +	if (!irq_ic_data) {
> > > +		pr_err("kzalloc failed!\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	irq_ic_data->enable_req_offset =3D SUNIV_IRQ_ENABLE_REG_OFFSET;
> > > +	irq_ic_data->mask_req_offset =3D SUNIV_IRQ_MASK_REG_OFFSET;
> > > +
> > > +	return sun4i_of_init(node, parent);
> > > +}
> > > +
> > > +IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic", su=
niv_ic_of_init);
> >=20
> > You can even split that addition to a new patch as well.
>=20
> OK. I will do 3 patches. First one will add a struct that holds only
> base and domain. Second one will add register offsets to that struct.=20
> Third one will add f1c100s support. Is that ok?

Sounds perfect :)

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--h2z3qr6y2agvh63m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/bScAAKCRDj7w1vZxhR
xeTNAQCVVvFSY83AwPAdDSiPgA7y2KdvvK38YF4s6yokph6yXgEAh+yXGenXIuaz
Bx6K/lyvdgkoeZ2bStF5yFF56RD8HwQ=
=FloS
-----END PGP SIGNATURE-----

--h2z3qr6y2agvh63m--
