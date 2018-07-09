Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A502087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A502087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeGIJPh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:15:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45151 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932445AbeGIJPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:15:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 17B66203D9; Mon,  9 Jul 2018 11:15:35 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF641203D9;
        Mon,  9 Jul 2018 11:15:24 +0200 (CEST)
Date:   Mon, 9 Jul 2018 11:15:24 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonathan Liu <net147@gmail.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180709091524.sfamfdmbmwclmegj@flea>
References: <20180706124628.3192421-1-arnd@arndb.de>
 <20180709080724.3ekqb45fsjubvhcm@flea>
 <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nn7mxiiqrcm4ucny"
Content-Disposition: inline
In-Reply-To: <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nn7mxiiqrcm4ucny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 04:58:48PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 9, 2018 at 4:07 PM, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
> >> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module res=
ults in
> >> a link error, as we try to access a symbol from the sun8i_tcon_top.ko =
module:
> >>
> >> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi=
=2Eko] undefined!
> >> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] =
undefined!
> >>
> >> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, bui=
lding
> >> the sun8i_tcon_top module the same way as the core sun4i-drm module wh=
enever
> >> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
> >>
> >> Alternatively, we could always build sun8i_tcon_top.ko along with sun4=
-drm.ko
> >> and detach it from the mixer module, I could not tell which way is more
> >> appropriate here.
> >
> > If that's easily doable, then yeah, that would be the preferred option
> > I guess. Jernej? Chen-Yu? Any opinion on this?
>=20
> Yeah, that definitely works for me. Having TCON TOP being part of the core
> sun4i-drm makes more sense. The TCON code will likely call into it later =
on
> when Jernej adds the encoder muxing code.
>=20
> I wonder if we shouldn't just build the whole display engine code, exclud=
ing
> downstream encoders (HDMI, DSI, TV) into one module. That would also fix =
the
> issue that DRM_SUN4I_BACKEND has to be built-in if DRM_SUN4I is built-in.
> That might be overkill though, given that one day we should be able to get
> rid of the frontend check.

We can't really do that (or at least without rewriting a significant
part of the driver), since we can have only one
module_init/module_exit function per module, and we have one
per-hardware block.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nn7mxiiqrcm4ucny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltDJ6sACgkQ0rTAlCFN
r3Spzw/6AzvWYsrj3XxWxJ3Xpp0zKlGm7+i4599pTE2aC7pUbh/0WqjGBG1OWA9u
kZ2xBHI4GWSPF7HoXco50OPm0Hv31jsEXxdRtXXKh5rxDbUuA8/mYfSeS7saSJ0k
Yp+U9roNZYCm+0eYNwcojsJ0Q9jEPaDdZ1XYLJXYZ+mlB7VJVU4NoHGc7VpdgPOQ
gn4dc+GBDD4mXyhAqwdYevltl4r98m06GSdTcWmqgJMyMIowqI7KDJX+igFgxS3L
hnULm9ktShMS4hDe7FuP/soqMr0axrxgWMiaPMGgYCXjEVL8Y7mhhRJdckyEioRU
aW5B6rBFAAzVgQ5xE55arJx8uiELUvFmQ1k5NbQsSMgHHqrNAVsSRx1gzadH6vUp
WTcaQc2DZoA+b3oHfgm0+Rr4/oOpuWcWLGujpWLkEpNeMw33PuQPDOXtEvDHWZW6
2ovuwMHTygK14lScUSv8GbiTlG1vKzsW33gwWy6D/gZq8BGyVogKgTZzzaCNSydx
oCgqqsYueA5umswZ6t4UYZeGdP+vYhd2jTSjRzr9Yu94JSWT8Pxcl9b5lkNBucrj
ZotpaPK66hIYjkjy695lsZDlDxxC0KmwKAc4rkFT/OvPkBZsF+6FydTgv0XovMkW
GW6gUI0xUXJAJBVCn0CjpNCq6n3g9flTGr2L2NJ4S2AJyQNnAsc=
=i7Df
-----END PGP SIGNATURE-----

--nn7mxiiqrcm4ucny--
