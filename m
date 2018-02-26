Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AG47ELvy6hWAMgZxAswpNSNmAe9RgJwFcvm2isQyfl3+DKXVB6OjliGIhV24iYQyiDHNJnhdG4Qm
ARC-Seal: i=1; a=rsa-sha256; t=1519636900; cv=none;
        d=google.com; s=arc-20160816;
        b=dIshVKFqEFtGtDMiXK8vw78L0glsCY0xnQcnpCUJUTT59iVZOEgqWpwNQ8UOGEBK6G
         I+PN1XFgIJfurBrblidDRPwycyoJLKhyhvAL+dQIe6r91mIw69Wx15zDwqSrcvu3Xk2K
         Y+v5jQvZjwqgOJ4dK69OkUZJqNPHsFyu+l6fy5MF+E78SZ5FeWm/Z6BOFC1Hw4x+Kvco
         FAcq4ZZRHE2/qb4LbpiNP8A2sJ+uCKccjin63pvFXUL35eX+F134JKzlcZZt7zpCiD1X
         2OXtgcTHNofMV2tfgG1WPc0P4NghqednFK10/IMDk533rBAFsSN8wHuANawDjws2bt68
         tU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hNJhqX0/coEmzDQGeifksVXWL5smjTHUW06SWGz0Wq4=;
        b=DHsr8dPGN/nmPjLXE7KExoRfThMV0ZmsitXbim6fYqy6DLj+MC7qOjewCY/ulcEBMI
         I6nFFd/OqgA4YTk0AGtYCldrf62EJC4k9dJqtgTDyq1FtsdW/XmDX5G0MH5q7FLX12cl
         ZgpOupCiLcLfC372lacmW0/6d6LaRdlz9zJksrZKDdcXpi53bi+ySyVdobOWahoihZ9y
         rCx9jQg7PiwbGQeVBOMR6Ujn+Pt9h81lSzn/tUNliXL5oel2yW8sj4SWMOcyMJy/QNnq
         6tyRXYFF3Gqv4LTz8JrRr1HVLJn/JzZbh/tvnieHe6LfA0p9IE6uzP46IDG9izIEd8TG
         /WTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Mon, 26 Feb 2018 10:21:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Icenowy Zheng <icenowy@aosc.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Liu <net147@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: link in front-end code if needed
Message-ID: <20180226092129.t4uogg2q7jkeolbu@flea.lan>
References: <20180223131112.715992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mwt7qcghvtumpepn"
Content-Disposition: inline
In-Reply-To: <20180223131112.715992-1-arnd@arndb.de>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197807586940998?=
X-GMAIL-MSGID: =?utf-8?q?1593454782810503893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--mwt7qcghvtumpepn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
> When the base sun4i DRM driver is built-in but the back-end is
> a loadable module, we run into a link error:
>=20
> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_tabl=
e'
>=20
> The dependency is a bit tricky, the best workaround I have come up
> with is to use a Makefile hack to to interpret both
> CONFIG_DRM_SUN4I_BACKEND=3Dm and CONFIG_DRM_SUN4I_BACKEND=3Dy
> as a directive to build the front-end the same way as the main module.
>=20
> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makef=
ile
> index 582607c0c488..db14e023256b 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)		+=3D sun4i-tcon.o
>  obj-$(CONFIG_DRM_SUN4I)		+=3D sun4i_tv.o
>  obj-$(CONFIG_DRM_SUN4I)		+=3D sun6i_drc.o
> =20
> -obj-$(CONFIG_DRM_SUN4I_BACKEND)	+=3D sun4i-backend.o sun4i-frontend.o
> +obj-$(CONFIG_DRM_SUN4I_BACKEND)	+=3D sun4i-backend.o
> +ifdef CONFIG_DRM_SUN4I_BACKEND
> +obj-$(CONFIG_DRM_SUN4I)		+=3D sun4i-frontend.o
> +endif

Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
and we would export the symbol?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--mwt7qcghvtumpepn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT0ZgACgkQ0rTAlCFN
r3Q7tg/9G3m0D7SgLtzPHXA2TjPnCL7yRS8ckcMeE+eh3AYw0gTH8gU6GR3aQU/o
iQddQZYMWICXau3CmINPHU+nVkcsBxzPA2QlpC+zYeP8fJYOHXwOcBGCQL4kbCiw
Hb93aXeoyHrnTeOx53K10MV9JOmXKhu6auOTKidbwfuREa0xYKiiXKFRY4f5vxuY
M/wml9kdO9i4eRBTEGL/IQllSEUYhAM0CzhpD6TBVEIPDvdehVYcOHmoQgM8fDR/
nUnyczzfpHgy1S3eY/A023oj0xLKZrVAsF22VDO1mN7f6HaF7xeN/KznLa7YoI+9
f0I4NW4Fx4Z/4ENInehnK1MZeuy0lVm8LJl6hvTdZg88JPhN/nlNLu5E673PX1Pw
3M7nScwXBn5MM7RxuCt9JxjIMlQjdcSnU57m9bp1vQimFyGCW41GBeVqDPO3qJAE
obrm5O33nghxiGy0a4+cneT2EIvgz/z4GMKj+Vm+jjLWcNrvKj3ulxhrfZL5hnJ9
TD15elFUEOfGZfMpU3XxMoie7rEyKeCHbFueifLlnOyzYt3R+ApQr29MMqoNb4Ax
EguDzp1lz10miZOx1CbW+ynsNLQvoe0+UzC5XmaPrDi+BrFxsxi1j1pPfhfV/Pwm
oF6W1o95+a+8IgK/gK07Pa6xOnti5riyRyMdGvBxtv177soKcZQ=
=4Yqk
-----END PGP SIGNATURE-----

--mwt7qcghvtumpepn--
