Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA595C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA7C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA7C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeKUC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:27:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33741 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKUC1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:27:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ADFCB2074F; Tue, 20 Nov 2018 16:57:15 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F37E206A1;
        Tue, 20 Nov 2018 16:57:15 +0100 (CET)
Date:   Tue, 20 Nov 2018 16:57:15 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix VBP size
 calculation
Message-ID: <20181120155715.andrjp5kg6ugcv72@flea>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
 <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rozt26x7vcumdji5"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rozt26x7vcumdji5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
> On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > Hi,
> >
> > On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > > The horizontal and vertical back porch calculation in BSP
> > > code is simply following the Linux drm comment diagram, in
> > > include/drm/drm_modes.h which is
> > >
> > > [hv]back porch =3D [hv]total - [hv]sync_end
> > >
> > > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> > >
> > > timmings->ver_sync_time=3D panel_info->lcd_vspw;
> > > timmings->ver_back_porch=3D panel_info->lcd_vbp-panel_info->lcd_vspw;
> > >
> > > vbp =3D panel->lcd_vbp;
> > > vspw =3D panel->lcd_vspw;
> > > dsi_dev[sel]->dsi_basic_size0.bits.vbp =3D vbp-vspw;
> > > dsi_dev[sel]->dsi_basic_size0.bits.vbp =3D panel->lcd_vbp - panel->lc=
d_vspw;
> > > =3D>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->l=
cd_vspw
> > > =3D>  timmings->ver_back_porch
> > > =3D>  mode->vtotal - mode->end
> > >
> > > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > > same in SUN6I_DSI_BASIC_SIZE0_VBP
> > >
> > > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > > value.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > I've tested your changes on my A33 board, and this commit will break
> > it.
> >
> > It creates vblank timeouts, and visual artifacts at the bottom of the
> > display.
>=20
> Strange, VBP is earlier gives front porch which is anyway wrong.
>=20
> >
> > Later commits seem to fix the issue, but will create some blanking on
> > the upper third of the display.
> >
> > Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> > way too expensive, I'd really like to have at least what each of these
> > commits are actually fixing, and what symptoms each of these were
> > causing, and not just "the BSP does it".
>=20
> W/o this 2-lane panel is breaking, same vblank timeout and visual
> artifacts at the bottom of the panel. though the commits may reference
> BSP, I have at-least tested on 3 different panels for us to prove its
> working.
>=20
> > Having some datasheet for the panels you had working would help too.
>=20
> Unfortunately datasheet doesn't have any required information what we
> actually looking for.

Not even the timings? How did you get that information then?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rozt26x7vcumdji5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/Qu2wAKCRDj7w1vZxhR
xd14AP0bxtEeWSMiAB+I3XkIFKxBM+MVNUKhVbfjDgjN+iouAwEAnI16TT36Gqfi
EXi6pfCij66MdxW67uJ5sxTskukyJwA=
=Vlls
-----END PGP SIGNATURE-----

--rozt26x7vcumdji5--
