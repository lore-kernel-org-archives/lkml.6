Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E528C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3959C20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfBEJ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:58:20 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:53202 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfBEJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:58:20 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id C84523A1E96;
        Tue,  5 Feb 2019 10:45:32 +0100 (CET)
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DFCF0FF80B;
        Tue,  5 Feb 2019 09:45:29 +0000 (UTC)
Date:   Tue, 5 Feb 2019 10:45:29 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190205094529.t7je4ozzu2b4ornc@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqrr4j6aqz3xqscg"
Content-Disposition: inline
In-Reply-To: <20190202155209.31617-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqrr4j6aqz3xqscg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> Recent patch of improving MP clock rate calculations by taking
> into account whether adjusting parent rate is allowed, have
> unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> boards which fail with following error:
>=20
> [snip]
> EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> sunxi-mmc 1c11000.mmc: data error, sending stop command
> sunxi-mmc 1c11000.mmc: send stop command failed
> [/snip]
>=20
> Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> clock rate with following parents:
> [snip]
> pll-ddr-base        2  2        0   768000000 0     0  50000
>    pll-ddr-other    1  1        0   768000000 0     0  50000
>       mmc2          0  0        0    51200000 0     0  50000
> [/snip]
>=20
> Now, after the improvements, requested and settled rate are both
> 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> ends up like this:
> [snip]
> pll-periph-base     3  3        0  1200000000 0     0  50000
>    pll-periph       6  6        0   600000000 0     0  50000
>       mmc2          3  3        0    50000000 0     0  50000
> [/snip]
>=20
> With this patch (allowing mmc2 to set parent rate), we end up with
> working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> [snip]
> pll-periph-base     3  3        0   312000000 0     0  50000
>    mbus             1  1        0    78000000 0     0  50000
>    pll-periph-sata  1  1        0    26000000 0     0  50000
>       sata          1  1        0    26000000 0     0  50000
>    pll-periph       5  5        0   156000000 0     0  50000
>       mmc2          0  0        0    52000000 0     0  50000
>       mmc0          0  0        0    39000000 0     0  50000
> [/snip]
>=20
> Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when all=
owed")
> Signed-off-by: Priit Laes <plaes@plaes.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--eqrr4j6aqz3xqscg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFlbOQAKCRDj7w1vZxhR
xaRYAQC0WLNx/9ga8vQdJsVGLopmekwrngsA7dsqJWdwuT6Y2QEA1g9aSZKzSpQL
Gfc8ryx3K2r9net+Ehu/S9GU8vpXfQ8=
=1aqM
-----END PGP SIGNATURE-----

--eqrr4j6aqz3xqscg--
