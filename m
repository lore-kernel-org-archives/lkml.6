Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AH8x225ffce75kR4RxBtcBJwmZaM1a7KM+67kvuTlkaW0qz4XOR3IzsaeqdmlVWOai6sgYo7Ke/k
ARC-Seal: i=1; a=rsa-sha256; t=1519642450; cv=none;
        d=google.com; s=arc-20160816;
        b=yR8i56r0SONIBs+0mTnfyn3BZ+V5NGnnFL0TfPHijm8N/LEmqiO36bTZXMnozIl3N8
         t90mAHFFPgYlZDVHk5FragHUOC9hR66c2+jf6H+yhLEBq6M9G/ZOpEPLstRsRZUNNh5w
         ryX6uKsnS+xk650Sx16UaDujLQ3/ouC9EekLYyXppVPm85OlYgHpBC9mcIIlItjqfyxr
         gK8V8VNk+mU/9ON9x+P8s4I6sbYoP13fWWF0IQZc1E+ec5B4fkXs5kSMjCT1r9CXYIO5
         y1PvA5GNm6wbiEMegZeA2MtA3FJkL2+K1xyeMkMxa42lM4GukOhxVU5MuHvStpeGxuPX
         77YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=z5IvwYRFa97A5ZFXnHtHOyBlP6/m5Iz18+kt2wqycFM=;
        b=xiMjay2rQ4+bM63LIPaF/N3TgSe+eageoxCRsa1edqul1NZ9yx/adGJIgHX7kr8kc8
         yCiHd7RjIYJ6259sb4Ea0BIQax9OuH4fq32gzbB9WVzahC8J0U/hUAk79vfkc1lSzPBx
         winG3CJpz3pFPUS3Yqhu5N66dY99haYXe5bRAoDu1xAlyqCAGef0tL2iiwiPmEl08DjY
         GY8fmivD94GbXM7bAhSkHfSVDRb3Ul0Yx5mmrU29UXepglO868C/OxDxw8AtvazMPdBI
         6GL881app9ZbPC0qMXsokAsHHPxclW+hcCG80DRW7cPCryq+GFw0kE6WRZrkqYez/st0
         vaaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Mon, 26 Feb 2018 11:53:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Icenowy Zheng <icenowy@aosc.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Liu <net147@gmail.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: link in front-end code if needed
Message-ID: <20180226105359.k5a3rz2wow4gweba@flea.lan>
References: <20180223131112.715992-1-arnd@arndb.de>
 <20180226092129.t4uogg2q7jkeolbu@flea.lan>
 <CAK8P3a1w=hLzZLPe1TURPyyu5oxpG8yD0eb_8GrVviUODy0zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j2kcn4ygrh7mnubm"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1w=hLzZLPe1TURPyyu5oxpG8yD0eb_8GrVviUODy0zqQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197807586940998?=
X-GMAIL-MSGID: =?utf-8?q?1593460601684606130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--j2kcn4ygrh7mnubm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 10:31:51AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2018 at 10:21 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
> >> When the base sun4i DRM driver is built-in but the back-end is
> >> a loadable module, we run into a link error:
> >>
> >> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
> >> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_t=
able'
> >>
> >> The dependency is a bit tricky, the best workaround I have come up
> >> with is to use a Makefile hack to to interpret both
> >> CONFIG_DRM_SUN4I_BACKEND=3Dm and CONFIG_DRM_SUN4I_BACKEND=3Dy
> >> as a directive to build the front-end the same way as the main module.
> >>
> >> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend=
")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Ma=
kefile
> >> index 582607c0c488..db14e023256b 100644
> >> --- a/drivers/gpu/drm/sun4i/Makefile
> >> +++ b/drivers/gpu/drm/sun4i/Makefile
> >> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)             +=3D sun4i-tcon.o
> >>  obj-$(CONFIG_DRM_SUN4I)              +=3D sun4i_tv.o
> >>  obj-$(CONFIG_DRM_SUN4I)              +=3D sun6i_drc.o
> >>
> >> -obj-$(CONFIG_DRM_SUN4I_BACKEND)      +=3D sun4i-backend.o sun4i-front=
end.o
> >> +obj-$(CONFIG_DRM_SUN4I_BACKEND)      +=3D sun4i-backend.o
> >> +ifdef CONFIG_DRM_SUN4I_BACKEND
> >> +obj-$(CONFIG_DRM_SUN4I)              +=3D sun4i-frontend.o
> >> +endif
> >
> > Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
> > and we would export the symbol?
>=20
> Yes, I think that would work just as well. Something like
>=20
> config DRM_SUN4I_FRONTEND
>       tristate
>       default DRM_SUN4I if CONFIG_DRM_SUN4I_BACKEND !=3D n
>=20
> should do the trick.

I had more something like this in mind:
https://pastebin.com/raw/XydvzAtz

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--j2kcn4ygrh7mnubm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT50YACgkQ0rTAlCFN
r3QevA/9FGGbYCL2zJtgoh1D+NgmLkqfhHfnTpZAOri9O04j/VEGc5AXO7+QwOc1
oWtGHrlUxSJRYCDxxSix88quel0VhF0/WfjmDBWcbDs1vax9wtn9/E8YW1U85eXN
L4V/JDGaQ1eG5Jqlprg1TDVoEjZteRiIBVmWhNpNBcorYUnMOibOWQ9hT8BrFJ54
Tm42t/SJugwqw43LlXcj2rBIUJ/r4t4NGpzhZt0K/+xWGEITu/Gtl65mcH5YvR3a
9MHsNNBXh+guDI6ZDgFFHVdfDn9TWWqODMNi21nH803M0clqJTUrTm80/qjKV1QD
MjgNpyLSzM4qo6HzVGYuQomRUBWP/WmFkrtOX3CaIP40LroTGwp+ItL3+/R0jhwr
ekQnu71aIs+mvQ0vxKLrcHgPyuGnxMJlkT2rGN1jEtuezf9fpPzjesyMktXMrQCJ
aEzw6qHZSQtUoyNSugX5WJlCzuXEiyGS7MWIurnUc83tG+5qvWSIIxj/gmnVqdUK
r5B6u6zjQWREs4odNN3GppKEiE5cHt6qYEdFqCXtL2bOVjsTVkVaBtWN14dNeFro
lDFL9ZgYbOgGlKTgJsFqdMe2BVecrtSyhPXYk+pBG8tU6J4nog9H/RbWbXtM7i2D
DRCy6K7C8PEb2hsO6ts2696pP5FPkXaIM4DLae9rHxPWn2y+/jE=
=t5Wy
-----END PGP SIGNATURE-----

--j2kcn4ygrh7mnubm--
