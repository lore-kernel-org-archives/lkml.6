Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725A921582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725A921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbeKOAzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:55:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38314 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731585AbeKOAzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:55:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 277832074F; Wed, 14 Nov 2018 15:51:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id EDE7C20379;
        Wed, 14 Nov 2018 15:51:31 +0100 (CET)
Date:   Wed, 14 Nov 2018 15:51:31 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        icenowy@aosc.io
Subject: Re: [PATCH] arm64: sunxi: Enable REGMAP_MMIO to fix linker error
Message-ID: <20181114145131.qv4gzg6pqktkpun5@flea>
References: <1542128665-78302-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rhoukju7jkkjh5rs"
Content-Disposition: inline
In-Reply-To: <1542128665-78302-1-git-send-email-john.garry@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rhoukju7jkkjh5rs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Wed, Nov 14, 2018 at 01:04:25AM +0800, John Garry wrote:
> The following linker failure can be seen for a certain heavily reduced
> defconfig:
> drivers/soc/sunxi/sunxi_sram.o: In function `sunxi_sram_probe':
> drivers/soc/sunxi/sunxi_sram.c:353: undefined reference to `__devm_regmap=
_init_mmio_clk'
> drivers/soc/sunxi/sunxi_sram.c:353:(.text+0x3c4): relocation truncated to=
 fit: R_AARCH64_CALL26 against undefined symbol `__devm_regmap_init_mmio_cl=
k'
>=20
> It would seem that the sunxi sram driver implicitly depended on config
> REGMAP_MMIO.
>=20
> To solve, select config REGMAP_MMIO for ARCH_SUNXI. This seems a better
> option than selecting from the respective driver config as this just
> defaults to ARCH_SUNXI.
>=20
> Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A=
64")
> Signed-off-by: John Garry <john.garry@huawei.com>
>=20
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 51bc479..c8a6ad3 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -12,6 +12,7 @@ config ARCH_SUNXI
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
> +	select REGMAP_MMIO
>  	select RESET_CONTROLLER
>  	help
>  	  This enables support for Allwinner sunxi based SoCs like the A64.

The sunxi_sram driver has a Kconfig symbol of its own now, it would
make more sense to add that select there, especially since we can also
compile it for arm.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rhoukju7jkkjh5rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+w2cwAKCRDj7w1vZxhR
xRp5AQCe36RAikjCgNlMGBgMPdDUbcBEQl8Yphs/Nrlqy/tFPQD9Fsq6fdgXmLhm
OLa5lr712+1tPnbvwEPQcuKXDudu8w8=
=5vzN
-----END PGP SIGNATURE-----

--rhoukju7jkkjh5rs--
