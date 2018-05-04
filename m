Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeEDLKK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:10:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44210 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeEDLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:10:08 -0400
X-Google-Smtp-Source: AB8JxZq4ABlk7z7++PL6ydWlI6XT1AsG81jbnKc5OqQgjgW+MgA2dOs++P1Sz0W65INuQ2WtgDu9ig==
Date: Fri, 4 May 2018 13:10:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drm/tegra: dc: Enable plane scaling filters
Message-ID: <20180504111004.GP13459@ulmo>
References: <20180504000844.18661-1-digetx@gmail.com>
 <20180504000844.18661-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvq4FPIYehQuVelz"
Content-Disposition: inline
In-Reply-To: <20180504000844.18661-2-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvq4FPIYehQuVelz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:08:42AM +0300, Dmitry Osipenko wrote:
> Currently resized plane produces a "pixelated" image which doesn't look
> nice, especially in a case of a video overlay. Enable scaling filters that
> significantly improve image quality of a scaled overlay.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 51 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.h |  7 ++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 9f83a65b5ea9..2e81142281c3 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -361,6 +361,47 @@ static void tegra_dc_setup_window(struct tegra_plane=
 *plane,
>  	if (window->bottom_up)
>  		value |=3D V_DIRECTION;
> =20
> +	if (!(dc->soc->has_win_a_without_filter && plane->index =3D=3D 0) &&
> +	    !(window->src.w =3D=3D window->dst.w)) {

I don't know about you, but I get dizzy trying to parse the above. How
about we move this into helpers:

	static bool tegra_plane_has_horizontal_filter(struct tegra_plane *plane)
	{
		struct tegra_dc *dc =3D plane->dc;

		/* this function should never be called on inactive planes */
		if (WARN_ON(!dc))
			return false;

		if (plane->index =3D=3D 0 && dc->soc->has_win_a_without_filter)
			return false;

		return true;
	}

Then the above becomes:

	bool scale_x =3D window->dst.w !=3D window->src.w;

	if (scale_x && tegra_plane_has_horizontal_filter(plane)) {

> +		/*
> +		 * Enable horizontal 6-tap filter and set filtering
> +		 * coefficients to the default values defined in TRM.
> +		 */
> +		tegra_plane_writel(plane, 0x00008000, DC_WIN_H_FILTER_P(0));
> +		tegra_plane_writel(plane, 0x3e087ce1, DC_WIN_H_FILTER_P(1));
> +		tegra_plane_writel(plane, 0x3b117ac1, DC_WIN_H_FILTER_P(2));
> +		tegra_plane_writel(plane, 0x591b73aa, DC_WIN_H_FILTER_P(3));
> +		tegra_plane_writel(plane, 0x57256d9a, DC_WIN_H_FILTER_P(4));
> +		tegra_plane_writel(plane, 0x552f668b, DC_WIN_H_FILTER_P(5));
> +		tegra_plane_writel(plane, 0x73385e8b, DC_WIN_H_FILTER_P(6));
> +		tegra_plane_writel(plane, 0x72435583, DC_WIN_H_FILTER_P(7));
> +		tegra_plane_writel(plane, 0x714c4c8b, DC_WIN_H_FILTER_P(8));
> +		tegra_plane_writel(plane, 0x70554393, DC_WIN_H_FILTER_P(9));
> +		tegra_plane_writel(plane, 0x715e389b, DC_WIN_H_FILTER_P(10));
> +		tegra_plane_writel(plane, 0x71662faa, DC_WIN_H_FILTER_P(11));
> +		tegra_plane_writel(plane, 0x536d25ba, DC_WIN_H_FILTER_P(12));
> +		tegra_plane_writel(plane, 0x55731bca, DC_WIN_H_FILTER_P(13));
> +		tegra_plane_writel(plane, 0x387a11d9, DC_WIN_H_FILTER_P(14));
> +		tegra_plane_writel(plane, 0x3c7c08f1, DC_WIN_H_FILTER_P(15));
> +
> +		value |=3D H_FILTER;
> +	}
> +
> +	if (!(dc->soc->has_win_a_without_filter && plane->index =3D=3D 0) &&
> +	    !(dc->soc->has_win_c_without_vert_filter && plane->index =3D=3D 2) =
&&
> +	    !(window->src.h =3D=3D window->dst.h)) {

	static bool tegra_plane_has_vertical_filter(struct tegra_plane *plane)
	{
		struct tegra_dc *dc =3D plane->dc;

		/* this function should never be called on inactive planes */
		if (WARN_ON(!dc))
			return false;

		if (plane->index =3D=3D 0 && dc->soc->has_win_a_without_filter)
			return false;

		if (plane->index =3D=3D 2 && dc->soc->has_win_c_without_vert_filter)
			return false;

		return true;
	}

And the above becomes:

	bool scale_y =3D window->dst.h !=3D window->src.h;

	if (scale_y && tegra_plane_has_vertical_filter(plane)) {

Thierry

--pvq4FPIYehQuVelz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsP4oACgkQ3SOs138+
s6HY/BAAmOC5ECVGWzPr6DZOuQVlLl4CS3iBDaKHPQLMw4pcBl6Ng1dVhtmH5RD1
9LAECWRsIws465JXhx20ypSwuaa495GL0V7BYcrmKtsONW0wE0GWvUgMSGJSF+3g
PLymRAUprsAH+RIY1/MIWNeROGae1ozdgEkTVKkdVXIqNGptssni/Vw5qA4sMgZq
dJygvfmMOCcTDVOyqyFQWdesdh+/IoASpkA/etxTeR7rUmTnfJBRhCAAy6opGW2G
Q8aPTroAG5eYxCYnAvwRpu34Attl7FZ/0hXZ8/jk1kT4V++rQm/XvogvdfFZH5/2
Y8Va6FTniGMcxai9D1vO5AZ36+HibO5F3AY+vvAs8kOHGxEbZ3P7UYwumUezFZjf
Fh/ZoouQ47qN/RgLdVBQ1tuskJZrVcT0yO81h86A03X50WO2WOgDctNgV1OBDG6h
Tu27ud3udIEO+rvGB8kbbiG6SEMRT167JkFuIhTveluSLFquOgHq8yp6RS2j7gXr
6HrlV4S6AHOBgkv7AhKPij1SuxE3Lv8d0cu7/hq9SKVo/Ec/NdKqkMhxYAQjIYWI
pYGx9DLbG5a5eji3BlYbWn0ti437iZbeNFJi5FV2ADXOZb40jiXrjzJ9pS6dUD+R
r5yyaxsWyNvcsRXCVAR9EPvy/lAuSpPqWM3+GVJ7FBav4cFWN8E=
=Y4md
-----END PGP SIGNATURE-----

--pvq4FPIYehQuVelz--
