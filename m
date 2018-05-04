Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEDKpX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:45:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33411 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeEDKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:45:18 -0400
X-Google-Smtp-Source: AB8JxZq+mx8fPWZbWffIJd1FGkeipRtSZTZPh4W42V7jR86bdPf9uZZvubGiyJ9vfGb+KD2tCJ7O1w==
Date: Fri, 4 May 2018 12:45:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] drm/tegra: dc: Balance IOMMU group refcounting
Message-ID: <20180504104515.GM13459@ulmo>
References: <20180503234723.4368-1-digetx@gmail.com>
 <20180503234723.4368-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KSyhVCl2eeZHT0Rn"
Content-Disposition: inline
In-Reply-To: <20180503234723.4368-2-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KSyhVCl2eeZHT0Rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:47:19AM +0300, Dmitry Osipenko wrote:
> Remove unneeded iommu_group_get() and add missing iommu_group_put(),
> correcting IOMMU group refcount. This is a minor correction / cleanup that
> doesn't really fix anything because Tegra's IOMMU driver are built-in and
> hence groups refcounting can't hold IOMMU driver from unloading.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c  | 35 +++++++++++++++++------------------
>  drivers/gpu/drm/tegra/dc.h  |  2 +-
>  drivers/gpu/drm/tegra/drm.h |  2 +-
>  3 files changed, 19 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index d7a0f62c6e2e..9fc34c6a7218 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -1927,7 +1927,6 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
>  static int tegra_dc_init(struct host1x_client *client)
>  {
>  	struct drm_device *drm =3D dev_get_drvdata(client->parent);
> -	struct iommu_group *group =3D iommu_group_get(client->dev);
>  	unsigned long flags =3D HOST1X_SYNCPT_CLIENT_MANAGED;
>  	struct tegra_dc *dc =3D host1x_client_to_dc(client);
>  	struct tegra_drm *tegra =3D drm->dev_private;
> @@ -1939,20 +1938,21 @@ static int tegra_dc_init(struct host1x_client *cl=
ient)
>  	if (!dc->syncpt)
>  		dev_warn(dc->dev, "failed to allocate syncpoint\n");
> =20
> -	if (group && tegra->domain) {
> -		if (group !=3D tegra->group) {
> -			err =3D iommu_attach_group(tegra->domain, group);
> +	if (tegra->domain) {
> +		dc->group =3D iommu_group_get(client->dev);
> +
> +		if (dc->group && dc->group !=3D tegra->dc_group) {
> +			err =3D iommu_attach_group(tegra->domain, dc->group);
>  			if (err < 0) {
>  				dev_err(dc->dev,
>  					"failed to attach to domain: %d\n",
>  					err);
> +				iommu_group_put(dc->group);
>  				return err;
>  			}
> =20
> -			tegra->group =3D group;
> +			tegra->dc_group =3D dc->group;
>  		}
> -
> -		dc->domain =3D tegra->domain;
>  	}
> =20
>  	if (dc->soc->wgrps)
> @@ -2017,13 +2017,13 @@ static int tegra_dc_init(struct host1x_client *cl=
ient)
>  	if (!IS_ERR(primary))
>  		drm_plane_cleanup(primary);
> =20
> -	if (group && dc->domain) {
> -		if (group =3D=3D tegra->group) {
> -			iommu_detach_group(dc->domain, group);
> -			tegra->group =3D NULL;
> +	if (dc->group) {
> +		if (dc->group && dc->group =3D=3D tegra->dc_group) {

You can drop the dc->group check from the second conditional.

> +			iommu_detach_group(tegra->domain, dc->group);
> +			tegra->dc_group =3D NULL;
>  		}
> =20
> -		dc->domain =3D NULL;
> +		iommu_group_put(dc->group);
>  	}
> =20
>  	return err;
> @@ -2032,7 +2032,6 @@ static int tegra_dc_init(struct host1x_client *clie=
nt)
>  static int tegra_dc_exit(struct host1x_client *client)
>  {
>  	struct drm_device *drm =3D dev_get_drvdata(client->parent);
> -	struct iommu_group *group =3D iommu_group_get(client->dev);
>  	struct tegra_dc *dc =3D host1x_client_to_dc(client);
>  	struct tegra_drm *tegra =3D drm->dev_private;
>  	int err;
> @@ -2045,13 +2044,13 @@ static int tegra_dc_exit(struct host1x_client *cl=
ient)
>  		return err;
>  	}
> =20
> -	if (group && dc->domain) {
> -		if (group =3D=3D tegra->group) {
> -			iommu_detach_group(dc->domain, group);
> -			tegra->group =3D NULL;
> +	if (dc->group) {
> +		if (dc->group && dc->group =3D=3D tegra->dc_group) {
> +			iommu_detach_group(tegra->domain, dc->group);
> +			tegra->dc_group =3D NULL;
>  		}
> =20
> -		dc->domain =3D NULL;
> +		iommu_group_put(dc->group);
>  	}
> =20
>  	host1x_syncpt_free(dc->syncpt);
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index ca5cac6bf8ea..5ca4e07333bb 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -94,7 +94,7 @@ struct tegra_dc {
> =20
>  	const struct tegra_dc_soc_info *soc;
> =20
> -	struct iommu_domain *domain;
> +	struct iommu_group *group;
>  };
> =20
>  static inline struct tegra_dc *
> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> index 4f41aaec8530..7777640a6911 100644
> --- a/drivers/gpu/drm/tegra/drm.h
> +++ b/drivers/gpu/drm/tegra/drm.h
> @@ -46,7 +46,7 @@ struct tegra_drm {
>  	struct drm_device *drm;
> =20
>  	struct iommu_domain *domain;
> -	struct iommu_group *group;
> +	struct iommu_group *dc_group;

It's not obvious to me why this needs to be renamed.

Thierry

--KSyhVCl2eeZHT0Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsObsACgkQ3SOs138+
s6GWlw/+MIAxdCOSqrBkZndVTLv9Tsg7BBg4vsTJj8cTdkGMjWpX7AOqpHPYrW8C
DKbUEJtoiHh5VyyJ2ohxplDPwGMqKBtLb/AEQ31lu1J9OputvwUmUHs17qW2OpRk
aR+LYwwVgdSwIikOBhnmBw2lnNsvguTulnkYgd+GU6RHfItmQ2FuMAjt4tlp9mhu
cSLiTHhC6fZMykWqmc+XtQIDVaY3fb8Qekj+6aMHqJrU6j1iHLpLbR1BhCCFSU17
YOpw9X5EjwARFLTvohCWhGbDPOaSQnObXO0QqbMWTaT6sHOF6t1dC+RH/CsZBs3L
odmd4DEtX+Y52R+ZbS+InnoOgbzVEQRBatwVHrFTK20FD1E3bi5EszYZWicITVwW
4KK8LizuIaXepRqaNrp9AD3HryNhInsl43C8Y0sFmovs5f6SbbxBaU2kJtSMpYRI
NZlQmmmFKyT08d4dR0Bwx9XKX1gDL13f3Qo8RxftsmWVSN5Tlmzdj0dmwE+JC565
50zKQQlNochMfaCjHTuO++WEavyafb+cvrwKMKutszt64ko47qsKOZBKaAu5iEiy
FroNjCxKjJL5TRI4eEJR897usNqWHoknV+nYgBEBa1olc7Cg6ic5puZhXDTtIDH9
MymSWiu6zV7qfdDHC0kisf8nY7NUON3kCVl1uxhCbSe3h8na6fY=
=digL
-----END PGP SIGNATURE-----

--KSyhVCl2eeZHT0Rn--
