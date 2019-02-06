Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB0AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfBFJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:20:06 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56255 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:20:06 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BC586240075;
        Wed,  6 Feb 2019 09:20:00 +0000 (UTC)
Date:   Wed, 6 Feb 2019 10:20:00 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Priit Laes <plaes@plaes.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190206092000.f46nsn4fw2n4crub@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sl7pkaf3p7ikf3a2"
Content-Disposition: inline
In-Reply-To: <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl7pkaf3p7ikf3a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:44:02PM +0800, Chen-Yu Tsai wrote:
> On Tue, Feb 5, 2019 at 5:45 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> > > Recent patch of improving MP clock rate calculations by taking
> > > into account whether adjusting parent rate is allowed, have
> > > unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> > > boards which fail with following error:
> > >
> > > [snip]
> > > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > > sunxi-mmc 1c11000.mmc: send stop command failed
> > > [/snip]
> > >
> > > Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> > > clock rate with following parents:
>=20
> You mean 52 and 51.2 MHz.
>=20
> > > [snip]
> > > pll-ddr-base        2  2        0   768000000 0     0  50000
> > >    pll-ddr-other    1  1        0   768000000 0     0  50000
> > >       mmc2          0  0        0    51200000 0     0  50000
> > > [/snip]
> > >
> > > Now, after the improvements, requested and settled rate are both
> > > 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> > > ends up like this:
> > > [snip]
> > > pll-periph-base     3  3        0  1200000000 0     0  50000
> > >    pll-periph       6  6        0   600000000 0     0  50000
> > >       mmc2          3  3        0    50000000 0     0  50000
> > > [/snip]
> > >
> > > With this patch (allowing mmc2 to set parent rate), we end up with
> > > working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> > > [snip]
> > > pll-periph-base     3  3        0   312000000 0     0  50000
> > >    mbus             1  1        0    78000000 0     0  50000
> > >    pll-periph-sata  1  1        0    26000000 0     0  50000
> > >       sata          1  1        0    26000000 0     0  50000
> > >    pll-periph       5  5        0   156000000 0     0  50000
> > >       mmc2          0  0        0    52000000 0     0  50000
> > >       mmc0          0  0        0    39000000 0     0  50000
> > > [/snip]
> > >
> > > Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when=
 allowed")
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> >
> > Applied, thanks!
> > Maxime
>=20
> I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> all of them, except the HRTIMER, expect the clock rate to stay
> the same and not change underneath them. And SATA expects it to
> be at 600 MHz, as the datasheet says. And while it may not directly
> apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> reduced rate of 50 MHz just fine.
>=20
> In the commit in question, clocks without CLK_SET_RATE_PARENT
> should be using the old code (now in the if conditional block),
> i.e. the behavior should not have changed.
>=20
> I don't think this actually "fixes" whatever bug was introduced,
> but only papers over the issue, and possible introduces further
> issues for other users.

You're right, I've overlooked that it was pll-periph being
affected. I've dropped it for now.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sl7pkaf3p7ikf3a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFqmvwAKCRDj7w1vZxhR
xSw7AQDHxqxuEw37JOpF6w0RMseJfomBli6NRTUeA+PWrP5ymAD+KJFoB88BMXPP
9BMD/2yvAg8+f+AtitKtK8nYtlhzVgM=
=Hlbo
-----END PGP SIGNATURE-----

--sl7pkaf3p7ikf3a2--
