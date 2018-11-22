Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73302C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3441620865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3441620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393084AbeKVTO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:14:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46088 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbeKVTO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:14:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C836520DA7; Thu, 22 Nov 2018 09:35:57 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 87A872072F;
        Thu, 22 Nov 2018 09:35:47 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:35:47 +0100
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
Message-ID: <20181122083547.srnopylueqx6p2qj@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ecrjc4ssrumvdhdn"
Content-Disposition: inline
In-Reply-To: <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ecrjc4ssrumvdhdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mesih,

On Wed, Nov 21, 2018 at 09:30:38PM +0300, Mesih Kilinc wrote:
> The new F-series SoCs (suniv) from Allwinner use an stripped version of
> the interrupt controller in A10/A13
>=20
> Add support for it in irq-sun4i driver.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/irqchip/irq-sun4i.c | 104 +++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 74 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> index e3e5b91..7ca4a4d 100644
> --- a/drivers/irqchip/irq-sun4i.c
> +++ b/drivers/irqchip/irq-sun4i.c
> @@ -28,11 +28,21 @@
>  #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
>  #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
>  #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
> -#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
> -#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
> +#define SUN4I_IRQ_ENABLE_REG(x)		(irq_ic_data->enable_req_offset + 0x4 *=
 x)
> +#define SUN4I_IRQ_MASK_REG(x)		(irq_ic_data->mask_req_offset + 0x4 * x)

You shouldn't have all the values you use passed as argument, so
irq_ic_data should be one of them here.

> +#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
> +#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
> +#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
> +#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
> +
> +struct sunxi_irq_chip_data{
                             ^ a space here

> +	void __iomem *irq_base;
> +	struct irq_domain *irq_domain;
> +	u32 enable_req_offset;
> +	u32 mask_req_offset;

s/req/reg/ ?

> +};
>
> -static void __iomem *sun4i_irq_base;
> -static struct irq_domain *sun4i_irq_domain;
> +static struct sunxi_irq_chip_data *irq_ic_data;

This is a very welcome change, but you should do it in two patches:
one to convert the existing code to that structure (with only the
domain and base), and then a second patch to add the register offsets.

(also the structure should be prefixed with sun4i, for consistency
with the rest of the driver).

> =20
>  static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs);
> =20
> @@ -43,7 +53,7 @@ static void sun4i_irq_ack(struct irq_data *irqd)
>  	if (irq !=3D 0)
>  		return; /* Only IRQ 0 / the ENMI needs to be acked */
> =20
> -	writel(BIT(0), sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
> +	writel(BIT(0), irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
>  }
> =20
>  static void sun4i_irq_mask(struct irq_data *irqd)
> @@ -53,9 +63,9 @@ static void sun4i_irq_mask(struct irq_data *irqd)
>  	int reg =3D irq / 32;
>  	u32 val;
> =20
> -	val =3D readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
> +	val =3D readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
>  	writel(val & ~(1 << irq_off),
> -	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
> +	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
>  }
> =20
>  static void sun4i_irq_unmask(struct irq_data *irqd)
> @@ -65,9 +75,9 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
>  	int reg =3D irq / 32;
>  	u32 val;
> =20
> -	val =3D readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
> +	val =3D readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
>  	writel(val | (1 << irq_off),
> -	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
> +	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
>  }
> =20
>  static struct irq_chip sun4i_irq_chip =3D {
> @@ -95,42 +105,76 @@ static const struct irq_domain_ops sun4i_irq_ops =3D=
 {
>  static int __init sun4i_of_init(struct device_node *node,
>  				struct device_node *parent)
>  {
> -	sun4i_irq_base =3D of_iomap(node, 0);
> -	if (!sun4i_irq_base)
> +	irq_ic_data->irq_base =3D of_iomap(node, 0);
> +	if (!irq_ic_data->irq_base)
>  		panic("%pOF: unable to map IC registers\n",
>  			node);
> =20
>  	/* Disable all interrupts */
> -	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(0));
> -	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(1));
> -	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(2));
> +	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(0));
> +	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(1));
> +	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(2));
> =20
>  	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
> -	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(0));
> -	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(1));
> -	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(2));
> +	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(0));
> +	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(1));
> +	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(2));
> =20
>  	/* Clear all the pending interrupts */
> -	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
> -	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(1));
> -	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(2));
> +	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
> +	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(1));
> +	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(2));
> =20
> -	/* Enable protection mode */
> -	writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
> +	/* Enable protection mode (not available in suniv) */
> +	if (of_device_is_compatible(node, "allwinner,sun4i-a10-ic"))
> +		writel(0x01, irq_ic_data->irq_base + SUN4I_IRQ_PROTECTION_REG);
> =20
>  	/* Configure the external interrupt source type */
> -	writel(0x00, sun4i_irq_base + SUN4I_IRQ_NMI_CTRL_REG);
> +	writel(0x00, irq_ic_data->irq_base + SUN4I_IRQ_NMI_CTRL_REG);
> =20
> -	sun4i_irq_domain =3D irq_domain_add_linear(node, 3 * 32,
> +	irq_ic_data->irq_domain =3D irq_domain_add_linear(node, 3 * 32,
>  						 &sun4i_irq_ops, NULL);
> -	if (!sun4i_irq_domain)
> +	if (!irq_ic_data->irq_domain)
>  		panic("%pOF: unable to create IRQ domain\n", node);
> =20
>  	set_handle_irq(sun4i_handle_irq);
> =20
>  	return 0;
>  }
> -IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_i=
nit);
> +
> +static int __init sun4i_ic_of_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	irq_ic_data =3D kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
> +	if (!irq_ic_data) {
> +		pr_err("kzalloc failed!\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_ic_data->enable_req_offset =3D SUN4I_IRQ_ENABLE_REG_OFFSET;
> +	irq_ic_data->mask_req_offset =3D SUN4I_IRQ_MASK_REG_OFFSET;
> +
> +	return sun4i_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_o=
f_init);
> +
> +static int __init suniv_ic_of_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	irq_ic_data =3D kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
> +	if (!irq_ic_data) {
> +		pr_err("kzalloc failed!\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_ic_data->enable_req_offset =3D SUNIV_IRQ_ENABLE_REG_OFFSET;
> +	irq_ic_data->mask_req_offset =3D SUNIV_IRQ_MASK_REG_OFFSET;
> +
> +	return sun4i_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic", suniv_=
ic_of_init);

You can even split that addition to a new patch as well.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ecrjc4ssrumvdhdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZqYwAKCRDj7w1vZxhR
xdGOAQDxpqJwf0I/LToCQCndBUrsb9SmCstt8xcUGSLeLZG8WAD/fx564sSavQMu
cAM0Bd+K0oBrnMOS22uJ600uu4o8Vwo=
=khyV
-----END PGP SIGNATURE-----

--ecrjc4ssrumvdhdn--
