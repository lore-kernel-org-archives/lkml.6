Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEDMJQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:09:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39644 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:09:14 -0400
X-Google-Smtp-Source: AB8JxZoNP5LO/faET4XPkFqVK16iAM8FYn4nD356KHTXo0D6dP62YspM3QW2lkd42hwwDmNZZmv0Pw==
Date: Fri, 4 May 2018 14:09:10 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drm/tegra: dc: Enable plane scaling filters
Message-ID: <20180504120910.GQ13459@ulmo>
References: <20180504000844.18661-1-digetx@gmail.com>
 <20180504000844.18661-2-digetx@gmail.com>
 <20180504111004.GP13459@ulmo>
 <85841227-e008-b129-f1e0-689837877e61@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E50aLcSU4JxQSj/B"
Content-Disposition: inline
In-Reply-To: <85841227-e008-b129-f1e0-689837877e61@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E50aLcSU4JxQSj/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:55:01PM +0300, Dmitry Osipenko wrote:
> On 04.05.2018 14:10, Thierry Reding wrote:
> > On Fri, May 04, 2018 at 03:08:42AM +0300, Dmitry Osipenko wrote:
> >> Currently resized plane produces a "pixelated" image which doesn't look
> >> nice, especially in a case of a video overlay. Enable scaling filters =
that
> >> significantly improve image quality of a scaled overlay.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/gpu/drm/tegra/dc.c | 51 ++++++++++++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/tegra/dc.h |  7 ++++++
> >>  2 files changed, 58 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> >> index 9f83a65b5ea9..2e81142281c3 100644
> >> --- a/drivers/gpu/drm/tegra/dc.c
> >> +++ b/drivers/gpu/drm/tegra/dc.c
> >> @@ -361,6 +361,47 @@ static void tegra_dc_setup_window(struct tegra_pl=
ane *plane,
> >>  	if (window->bottom_up)
> >>  		value |=3D V_DIRECTION;
> >> =20
> >> +	if (!(dc->soc->has_win_a_without_filter && plane->index =3D=3D 0) &&
> >> +	    !(window->src.w =3D=3D window->dst.w)) {
> >=20
> > I don't know about you, but I get dizzy trying to parse the above. How
> > about we move this into helpers:
>=20
> +1
>=20
> > 	static bool tegra_plane_has_horizontal_filter(struct tegra_plane *plan=
e)
> > 	{
> > 		struct tegra_dc *dc =3D plane->dc;
> >=20
> > 		/* this function should never be called on inactive planes */
> > 		if (WARN_ON(!dc))
> > 			return false;
> >=20
> > 		if (plane->index =3D=3D 0 && dc->soc->has_win_a_without_filter)
> > 			return false;
> >=20
> > 		return true;
> > 	}
> >=20
> > Then the above becomes:
> >=20
> > 	bool scale_x =3D window->dst.w !=3D window->src.w;
> >=20
> > 	if (scale_x && tegra_plane_has_horizontal_filter(plane)) {
> >=20
> >> +		/*
> >> +		 * Enable horizontal 6-tap filter and set filtering
> >> +		 * coefficients to the default values defined in TRM.
> >> +		 */
> >> +		tegra_plane_writel(plane, 0x00008000, DC_WIN_H_FILTER_P(0));
> >> +		tegra_plane_writel(plane, 0x3e087ce1, DC_WIN_H_FILTER_P(1));
> >> +		tegra_plane_writel(plane, 0x3b117ac1, DC_WIN_H_FILTER_P(2));
> >> +		tegra_plane_writel(plane, 0x591b73aa, DC_WIN_H_FILTER_P(3));
> >> +		tegra_plane_writel(plane, 0x57256d9a, DC_WIN_H_FILTER_P(4));
> >> +		tegra_plane_writel(plane, 0x552f668b, DC_WIN_H_FILTER_P(5));
> >> +		tegra_plane_writel(plane, 0x73385e8b, DC_WIN_H_FILTER_P(6));
> >> +		tegra_plane_writel(plane, 0x72435583, DC_WIN_H_FILTER_P(7));
> >> +		tegra_plane_writel(plane, 0x714c4c8b, DC_WIN_H_FILTER_P(8));
> >> +		tegra_plane_writel(plane, 0x70554393, DC_WIN_H_FILTER_P(9));
> >> +		tegra_plane_writel(plane, 0x715e389b, DC_WIN_H_FILTER_P(10));
> >> +		tegra_plane_writel(plane, 0x71662faa, DC_WIN_H_FILTER_P(11));
> >> +		tegra_plane_writel(plane, 0x536d25ba, DC_WIN_H_FILTER_P(12));
> >> +		tegra_plane_writel(plane, 0x55731bca, DC_WIN_H_FILTER_P(13));
> >> +		tegra_plane_writel(plane, 0x387a11d9, DC_WIN_H_FILTER_P(14));
> >> +		tegra_plane_writel(plane, 0x3c7c08f1, DC_WIN_H_FILTER_P(15));
> >> +
> >> +		value |=3D H_FILTER;
> >> +	}
> >> +
> >> +	if (!(dc->soc->has_win_a_without_filter && plane->index =3D=3D 0) &&
> >> +	    !(dc->soc->has_win_c_without_vert_filter && plane->index =3D=3D =
2) &&
> >> +	    !(window->src.h =3D=3D window->dst.h)) {
> >=20
> > 	static bool tegra_plane_has_vertical_filter(struct tegra_plane *plane)
> > 	{
> > 		struct tegra_dc *dc =3D plane->dc;
> >=20
> > 		/* this function should never be called on inactive planes */
> > 		if (WARN_ON(!dc))
> > 			return false;
> >=20
> > 		if (plane->index =3D=3D 0 && dc->soc->has_win_a_without_filter)
> > 			return false;
> >=20
> > 		if (plane->index =3D=3D 2 && dc->soc->has_win_c_without_vert_filter)
> > 			return false;
> >=20
> > 		return true;
> > 	}
> >=20
> > And the above becomes:
> >=20
> > 	bool scale_y =3D window->dst.h !=3D window->src.h;
> >=20
> > 	if (scale_y && tegra_plane_has_vertical_filter(plane)) {
>=20
> I'll adjust this patch, thanks.
>=20
> Maybe it also worth to factor filtering out into a custom DRM property? F=
or
> example in a case of libvdpau-tegra we perform the exact same filtering on
> blitting YUV to RGB surface (shown as overlay) by GR2D for displaying vid=
eo
> players interface on top of video, this results in a double filtering tha=
t has
> no visual effect and probably wastes memory bandwidth a tad.
>=20
> Though I'm not very keen anymore on trying to add custom plane properties=
 after
> being previously NAK'ed. We can wrap filtering into a property later if w=
ill be
> desired, should be good to just have it enabled by default for now.

Agreed. Let's keep this enabled by default and then address the corner
cases separately.

Thierry

--E50aLcSU4JxQSj/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsTWMACgkQ3SOs138+
s6FgeA//RMGyP2dbejTxHLeMnc+cDh75rpM87KEYmPB5/SgzfhDYvW1eGaSlAqSp
xU8ugTGnAiaE+qY+ECjYuNKcBLqsS9JlyrwmiTwPEYHu0gmIQY2v60bQNqYzcSFJ
AxPQNX8vtSj2XylCFmj3TEEJdjfx5hD25pMRLBbP3oKmbnQL+/gHpX6o4z3/ZUpV
+26Ru7g8H7GTKyYN91jMw5fa6Q6bxbDd7AF9IEzj+RcQL9Sb8FgxsefseFwSczTZ
ZnCYHeS18cfhOSCbmUGkab9GU1V4HGgxFGSL2mAjo0oTUVxrpQsH+vX9HLzXO5HE
82Ak8PWhPot7BIjs4I8th/V8DJUpw2MJT85kH4J3idSETZC8+EzWCFoL3VhXGFxx
RDxNFJqw+CjKIE4D8PNnRcdFEf0JhmqwiqW0wnHLwZWdD4W8A2qzyWjMc2SzpWi2
ejJsA2RY33+WYxynjqAxDoHlP7nchVaS+DuI2DLFvXxMAv+3z983YAEsr4NHLii8
MFA6ZFWaITacIS72hVyCYGPxM1Ne/oGFgmqqVggmx5r4sRIeQ5REt8AUK9xA3h75
h71d/do414AnOYSGjEpYeX+rRsZw6oydeYpQpKAjmIfFUFBchS7vXuiUM6iSakMP
+Ri+XgRKEJPEYGxHmY4slqPi++gg2wxwya9/dcocWyx/ZysSAWs=
=s909
-----END PGP SIGNATURE-----

--E50aLcSU4JxQSj/B--
