Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeBWOy1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:54:27 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:52193 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBWOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:54:26 -0500
Date: Fri, 23 Feb 2018 15:54:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 01/10] ARM: sun9i: smp: Add sun9i dt parsing function
Message-ID: <20180223145423.5og5bdhtznu5qlw7@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57ofgl56jgiq36ka"
Content-Disposition: inline
In-Reply-To: <20180223133742.26044-2-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--57ofgl56jgiq36ka
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2018 at 02:37:33PM +0100, Myl=E8ne Josserand wrote:
> To prepare the support for sun8i-a83t, create a new function
> that handles all the resources needed on sun9i-a80 (because
> it will be different from sun8i-a83t).
>=20
> All the parsing of device tree is moved into this new function:
> sun9i_dt_parsing. Create also a function to release the resources
> retrieved during the dt parsing in case there is an error in init
> function.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 99 ++++++++++++++++++++++++++------------=
------
>  1 file changed, 58 insertions(+), 41 deletions(-)
>=20
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 11e46c6efb90..650a2ad4398f 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -684,35 +684,22 @@ static int __init sunxi_mc_smp_lookback(void)
>  	return ret;
>  }
> =20
> -static int __init sunxi_mc_smp_init(void)
> +static int sun9i_dt_parsing(struct resource res)

Like I told you in the previous version, this should be _parse_dt, and
not _dt_parsing.

Also, I'm not sure why you are passing by copy the resource structure?

>  {
> -	struct device_node *cpucfg_node, *sram_node, *node;
> -	struct resource res;
> +	struct device_node *prcm_node, *cpucfg_node, *sram_node;
>  	int ret;
> =20
> -	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
> -		return -ENODEV;
> -
> -	if (!sunxi_mc_smp_cpu_table_init())
> -		return -EINVAL;
> -
> -	if (!cci_probed()) {
> -		pr_err("%s: CCI-400 not available\n", __func__);
> -		return -ENODEV;
> -	}
> -
> -	node =3D of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm"=
);
> -	if (!node) {
> -		pr_err("%s: PRCM not available\n", __func__);
> +	prcm_node =3D of_find_compatible_node(NULL, NULL,
> +				       "allwinner,sun9i-a80-prcm");
> +	if (!prcm_node)
>  		return -ENODEV;
> -	}
> =20
>  	/*
>  	 * Unfortunately we can not request the I/O region for the PRCM.
>  	 * It is shared with the PRCM clock.
>  	 */
> -	prcm_base =3D of_iomap(node, 0);
> -	of_node_put(node);
> +	prcm_base =3D of_iomap(prcm_node, 0);

So it does more a bit more than just parsing the DT?

Can you maybe just fill the DT nodes and have the common part map the
memory regions if the pointer is not NULL?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--57ofgl56jgiq36ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQKx4ACgkQ0rTAlCFN
r3Q01w//WaHbgn54ArvGB7FNCVQh84gMjz+7RnszcF89tlJg9aQNnGsBlzZLbaun
uKpf/K4n3TI8cgL568wCPrdu00yiqftX56IvQvh2qtgDVSBRv+b30ftjqy3OMJ9E
UBiTh1KDdZtdpzrcxCm1eUtBSkxtajTgYsX55kRK/EsQ08z8jTVPx4P7UbyTCaUC
0ufBeUh1gz2KKHs0NCF7pVHaXCvahK5K3JCvfGnlar7sbAxHsc8SLvGGWG+DDWuK
K3iOmFWQM6GUc4js63HAoDKSnH5NXTf7OiPj2BEscdNT2zWpDFPRItoAwLzmgQGo
McLDkW92tcoSp7ipB7tpTv/RZOJ9FTpdok8K5Rq5Fmo5WHqjT9N+dDDeOUH3idt4
loDTBTVBcwlq9DuJTC2B+99DRmjRcSOsFVktXMv4CZUBeIgBffEe0LnRuvj3OoBn
gzBlqHrT1XC9xrSDljehqlibGvd7+FZEoeQ+hlRJnmYn6MVuTW9N8qb937b07MBP
j9Ee14Pte+51hTrdvgvSKAExD3y6gE75tZHWf34ir7gdBvv095uvlYJRsJsMAoDK
XDD0CYjCxjjptoaxv48WX+VSuDstBMsR1gWlEDIVluQDv/1sRco4U66lBBN+3gZ6
Nf9MyFChxlzM2RDPwWtdnZmlpJQWQZy3c7MykNK9xftdM1Px+ig=
=+F+R
-----END PGP SIGNATURE-----

--57ofgl56jgiq36ka--
