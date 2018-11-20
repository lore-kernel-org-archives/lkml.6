Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63CC18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EE52146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EE52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeKTTQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:16:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50164 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeKTTQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:16:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7212C20D29; Tue, 20 Nov 2018 09:48:25 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 38F0020D29;
        Tue, 20 Nov 2018 09:48:15 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:48:15 +0100
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
Subject: Re: [RFC PATCH v2 05/14] irqchip/sun4i: add support for suniv
 interrupt controller
Message-ID: <20181120084815.rvh63cvvhxj6sbs2@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <d693414b1693a9018956bcc589a9048e88fbc8f6.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7nbopu3lgekzonta"
Content-Disposition: inline
In-Reply-To: <d693414b1693a9018956bcc589a9048e88fbc8f6.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7nbopu3lgekzonta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 18, 2018 at 05:17:04PM +0300, Mesih Kilinc wrote:
> The new F-series SoCs (suniv) from Allwinner use an stripped version of
> the interrupt controller in A10/A13.
>=20
> Add support for it in irq-sun4i driver.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/irqchip/irq-sun4i.c | 47 +++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> index e3e5b91..2abf662 100644
> --- a/drivers/irqchip/irq-sun4i.c
> +++ b/drivers/irqchip/irq-sun4i.c
> @@ -23,13 +23,26 @@
> =20
>  #include <asm/exception.h>
> =20
> +enum sun4i_irq_type {
> +	sun4i_ic,
> +	suniv_ic
> +};
> +
> +static enum sun4i_irq_type sun4i_irq_type;

You don't really need that type. It's completely redundant with the
compatible.

> +static int sun4i_irq_enable_reg_offset;
> +static int sun4i_irq_mask_reg_offset;

Ideally, this should be a structure so that we can easily extend it
without adding more and more global variables. And the type shouldn't
be signed.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7nbopu3lgekzonta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PKTwAKCRDj7w1vZxhR
xX31AP9cLbpcCqphd/eOd4ob256OaUp7pz46X9v96mDinDTYdgD+N8eX9d44CrCn
pEFKZp41gVJDnK0vUBTp/MAc0VWTrAs=
=PEAx
-----END PGP SIGNATURE-----

--7nbopu3lgekzonta--
