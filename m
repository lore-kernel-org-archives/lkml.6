Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996C72081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfBDNlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:41:15 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49005 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBDNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:41:14 -0500
Received: from localhost (unknown [185.94.189.188])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0F82B100002;
        Mon,  4 Feb 2019 13:41:10 +0000 (UTC)
Date:   Mon, 4 Feb 2019 14:41:10 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Chris Blake <chrisrblake93@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
Message-ID: <20190204134110.dvo3qvnhiksqig2l@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea>
 <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qilzeq5czyowhtcp"
Content-Disposition: inline
In-Reply-To: <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qilzeq5czyowhtcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 06:16:24PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > > The MMC device tree bindings include properties used to signal various
> > > signalling speed modes. Until now the sunxi driver was accepting them
> > > without any further filtering, while the sunxi device trees were not
> > > actually using them.
> > >
> > > Since some of the H5 boards can not run at higher speed modes stably,
> > > we are resorting to declaring the higher speed modes per-board.
> > >
> > > Regardless, having boards declare modes and blindly following them,
> > > even without proper support in the driver, is generally a bad thing.
> > >
> > > Filter out all unsupported modes from the capabilities mask after
> > > the device tree properties have been parsed.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > >
> > > ---
> > >
> > > This should be backported to stable kernels in case people try to run
> > > new device trees (that declare newly supported modes) with old kernel=
s.
> > > ---
> > >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> > > index 7415af8c8ff6..a01433012db0 100644
> > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_dev=
ice *pdev)
> > >       if (ret)
> > >               goto error_free_dma;
> > >
> > > +     /*
> > > +      * If we don't support delay chains in the SoC, we can't use any
> > > +      * of the DDR speed modes. Mask them out in case the device
> > > +      * tree specifies the properties for them, which gets added to
> > > +      * the caps by mmc_of_parse() above.
> > > +      */
> > > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > > +             mmc->caps &=3D ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> > > +                            MMC_CAP_1_2V_DDR);
> > > +
> > > +     /* TODO: UHS modes untested due to lack of supporting boards */
> > > +     mmc->caps &=3D ~MMC_CAP_UHS;
> >
> > I've tested up to SDR104 and it works on the A64 at least
>=20
> That's good to know. What board was this on? I had given up hope waiting
> for a vendor to produce a board that could do proper voltage switching for
> SD cards.

On a Sootech SoM, that had an HS400 eMMC and an SDR104 Marvell WiFi
chip. I don't have that board anymore, and the website seems down now
though :/

> > > +     /* TODO: This driver doesn't support HS200 and HS400 modes yet =
*/
> > > +     mmc->caps2 &=3D ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> >
> > And HS200 works too.
>=20
> OK. I thought there was some special magic required in the driver. Maybe
> that was for HS400 only? Again, what board was this on?

Yeah, that was for HS400 only

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qilzeq5czyowhtcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFhA9gAKCRDj7w1vZxhR
xaobAPwLwX3ogiUqN3Oj6o37AjbNLtO/vajLyLFZu913WAuNYwEA5jzX101gyNCb
BERtJbVDvTkxluO4bcxt9+nivDLIDg4=
=poHW
-----END PGP SIGNATURE-----

--qilzeq5czyowhtcp--
