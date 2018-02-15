Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033135AbeBOOMS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:12:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55215 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbeBOOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:12:06 -0500
Date: Thu, 15 Feb 2018 15:11:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: wens@csie.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180215141154.monvwx25awwetqrc@flea.lan>
References: <20180214135612.21356-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cg6ihztcak7gnejl"
Content-Disposition: inline
In-Reply-To: <20180214135612.21356-1-embed3d@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cg6ihztcak7gnejl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 02:56:12PM +0100, Philipp Rossak wrote:
> This patch fixes a bug, that prevents the Allwinner A83T and the A80
> from a successful boot.
>=20
> The bug is there since v4.16-rc1 and appeared after the clk branch was
> merged.

Out of curiosity, which patch has introduced this? I couldn't find any
obvious match.

> You can find the shortend trace below:
>=20
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
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>=20
> Changes in v3:
> 	* add information when the bug appeared=20
> 	* make the comment more clear
> Changes in v2:
> 	* add tag Fixes: ... to commit message
> 	* add comment to if statement why we are doing this check
>=20
>  drivers/rtc/rtc-ac100.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index 8ff9dc3fe5bf..2412aa2e8399 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -183,7 +183,24 @@ static int ac100_clkout_determine_rate(struct clk_hw=
 *hw,
> =20
>  	for (i =3D 0; i < num_parents; i++) {
>  		struct clk_hw *parent =3D clk_hw_get_parent_by_index(hw, i);
> -		unsigned long tmp, prate =3D clk_hw_get_rate(parent);
> +		unsigned long tmp, prate;
> +
> +		/*
> +		 * The clock has two parents, one is a fixed clock which is
> +		 * internally registered by the ac100 driver. The other parent
> +		 * is a clock from the codec side of the chip, which we
> +		 * properly declare and reference in the devicetree and is
> +		 * not implemented in any driver right now.
> +		 * If the clock core looks for the parent of that second
> +		 * missing clock, it can't one that is registered and
> +		 * returns NULL.
> +		 * Thus we need to check if the parent exists before
> +		 * we get the parent rate.
> +		 */
> +		if (!parent)
> +			continue;

I'm sorry, but I still don't get it. When you register that clock, you
will give it two parents. Why would that change during the life of the
clock?

This really looks like a workaround rather than an actual fix.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--cg6ihztcak7gnejl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqFlSkACgkQ0rTAlCFN
r3SnIQ/9H4KCuDsE4ffbMrJlaqaXFYhlEGDvYV5IiNwScplUGl28q73vE85pEl5h
xZb/VgnJeGFfm1lJBfj9xGxoelrWUp73tA5E3/Os820LciAGGwFvl5+lkq/Sl7t5
p6gSQFpWWCpywvoOQzMvZuBjh9Q2RPgb2MA4gi5mCDKkNohW5I7JmCIKh4jsEQkV
HtiLM4Kb6MCa6j+aDoRK61HWMcAxspPEWzzoNc9+dHO9DsbtgRaUskQ7CiulGaQX
az4wxC9XP3XJJHw51rf57rgJMhiQiBTkZTSW/aZxv/hdn7AsNhWj9AdQawm7Wczy
pKc2UDqsVdfh9NQCFJH27aI7Ak6hcSQi7vkRR93hOoH/CKN0tei8f79DjmIHZf9t
qJWGSlh6szowFsQpYtCsKfngVelBQHrhbCrdreZEe0SltxFbSFu7L+WJhWGwfqRn
z0V9qBR9WoGEWzdx9iVOVjjAt9KvvA8dRLGC22h3tTijIVkRXVWraZBzjrMN9I7x
5F5wxTFTsU7HsR6MqJatoATifFHt2q519g2y4uSetENgHRkARSI8fi/LF+SjwcWm
DUbENPxZssTwr8nwfr20lWlq5GVYjQ9RdFrox+9xa8h/Twklb9Hku8SOTJ6qgtJ0
GZzzU1nl6E2shANi7HtK0xJy+dWD3pqQuUThxTYisTb/fc9zDDE=
=nYtT
-----END PGP SIGNATURE-----

--cg6ihztcak7gnejl--
