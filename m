Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935301AbeBMNcO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:32:14 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53793 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935222AbeBMNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:32:13 -0500
Date: Tue, 13 Feb 2018 14:32:01 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: wens@csie.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-rtc@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v2] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180213133201.kwq4aatpts7nerc2@flea.lan>
References: <20180213121414.7000-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2wq7o7ftvpg2t3d5"
Content-Disposition: inline
In-Reply-To: <20180213121414.7000-1-embed3d@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2wq7o7ftvpg2t3d5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 01:14:14PM +0100, Philipp Rossak wrote:
> This patch fixes a bug, that prevents the Allwinner A83T and the A80
> from a successful boot. You can find the shortend trace below:

Since when is it there?

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> pgd =3D (ptrval)
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be #2
> Hardware name: Allwinner sun8i Family
> Workqueue: events deferred_probe_work_func
> PC is at clk_hw_get_rate+0x0/0x34
> LR is at ac100_clkout_determine_rate+0x48/0x19c
>=20
> [ ... ]
>=20
> (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
> (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
> (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
> (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
> (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
>=20
> To fix that bug, we first check if the return of the
> clk_hw_get_parent_by_index is non zero. If it is zero we skip that
> clock parent.
>=20
> The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198
>=20
> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")

Should it be sent to stable?

> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>=20
> Changes in v2:
> 	* add tag Fixes: ... to commit message
> 	* add comment to if statement why we are doing this check
>=20
>  drivers/rtc/rtc-ac100.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index 8ff9dc3fe5bf..ba73201d8cc1 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -183,7 +183,17 @@ static int ac100_clkout_determine_rate(struct clk_hw=
 *hw,
> =20
>  	for (i =3D 0; i < num_parents; i++) {
>  		struct clk_hw *parent =3D clk_hw_get_parent_by_index(hw, i);
> -		unsigned long tmp, prate =3D clk_hw_get_rate(parent);
> +		unsigned long tmp, prate;
> +
> +		/*
> +		 * We purposefully left open the possibility to use the clock
> +		 * from the codec side but it is not implemented right now.
> +		 * Thus we need to check if the parent exists.
> +		 */
> +		if (!parent)
> +			continue;
> +
> +		prate =3D clk_hw_get_rate(parent);

clk_hw_get_num_parents should return the exact number of parents,
which is going to be 1 if you only have one parent, like all DTS seems
to have.

If not, then it should be explained in the comment and / or fixed
properly.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--2wq7o7ftvpg2t3d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqC6NAACgkQ0rTAlCFN
r3RoSBAAk4nxd4PISUCAekki9exnTstZGIPl4RX3Jf5v/01wUTtXhzzABiXQcu8d
im3SJUjnWDAy7DsEHso/jJAjSOsdylc3ZGvj8NfN9QUogC0aZ/PjrZg3xz5hEfnM
8sbklyElVvRR6iDHU+C8LQGpTDHviDPHaHkzHHOKQFUCXYucjYxyhaEL50Ih1XmQ
/0BiAmo6cIvIB9oZg7LXNp9aYUlIqMzIE7YELiBCYqwVU6tXe4CKkzjMTTmhoPyf
r/jMocvzAmtBIH1gKjrD88iCFxDK8bU9qyP/tUXCuEMOWC5pMUlNkU4E47cRYOgh
UHPLJUyc3VGwr59HHE3sK1e3UIyokA60hvgZtT06o3+50pRUgAukf86vw9KCKSjU
FXGL3VWGgAeN+rJmahu1dRlEKYjyO48Ppqtl3/sCuZa3uG3Cun4myhVtYF3f9lD9
7IjDV7zglXPRy4V0WxSkqtFAa6jh7GVs8e6Dns3C4zFQI2x/JR9bmM5X9OYgsEcl
HbxoFyaqABYdb3p9vS5uOJKTSH4KjhbGiCmvmFuppkMqosF9O0JGEozUXKMZwIEP
uK8XVAteNWF4lq5HkKR62Kelx0cSinV65WYPvMFii0Rk5RXMiLtZ46KAk3n9zUS2
jWGNt7vw2MZLlni+lpv6uJFlPb2qfCC6KqXVcSD0gTyAHmvWcVY=
=rPDX
-----END PGP SIGNATURE-----

--2wq7o7ftvpg2t3d5--
