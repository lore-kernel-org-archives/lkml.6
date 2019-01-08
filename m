Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C7206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfAHI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:58:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58188 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfAHI6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:58:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E9312209BC; Tue,  8 Jan 2019 09:58:39 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr [90.88.149.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id B7085206DC;
        Tue,  8 Jan 2019 09:58:29 +0100 (CET)
Date:   Tue, 8 Jan 2019 09:58:29 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190108085829.clianbtjovu3oieq@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m3ctiswi7poqkfry"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m3ctiswi7poqkfry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 08:48:21PM +0530, Jagan Teki wrote:
> On Mon, Jan 7, 2019 at 7:42 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> > > On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > > > Video start delay can be computed by subtracting total vertical
> > > > > timing with front porch timing and with adding 1 delay line for T=
CON.
> > > > >
> > > > > BSP code form BPI-M64-bsp is computing video start delay as
> > > > > (from linux-sunxi/
> > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > >
> > > > > u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > > =3D> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > > =3D> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > > =3D> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > > =3D> timmings->ver_front_porch
> > > > >
> > > > > So, update the start delay computation accordingly.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > >
> > > > Even though it's a bit better now on my A33 board and I don't have =
the
> > > > white stripes on the bottom of the display, there's still some
> > > > flickering with your patches applied.
> > > >
> > > > Bisecting it seems to point at that patch, but reverting it doesn't
> > > > make the issue go away, so it's not really clear which one exactly =
is
> > > > at fault.
> > >
> > > Is reverting this patch, work fine or not?
> >
> > As I was saying, it doesn't.
> >
> > > This patch is trying to make use of front porch instead of existing
> > > back porch to compute the delay. Since we revert the VBP fix patch[1]
> > > to assume VBP as VFP value look like your setup would also require to
> > > revert this change. But as per BSP or drm_mode details all of my
> > > displays even work with and w/o reverting these two.
> >
> > Again, I cannot help you without the datasheet for the panels you're
> > trying to submit.
>=20
> The panel bound with Sitronix ST7701 IC
> http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.=
pdf

It's the controller, not the panel

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m3ctiswi7poqkfry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDRmNQAKCRDj7w1vZxhR
xX0hAQD/08EfBi/WV1bd+mCQeFb+ux+liOt8kbGwfwOdJWle2wEAxsZnPybyH+5c
Q7Xrz0RlIUvqu9Sy6WXGgZ9aLOn+lwQ=
=zTbv
-----END PGP SIGNATURE-----

--m3ctiswi7poqkfry--
