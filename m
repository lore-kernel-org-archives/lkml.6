Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCCB2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCCB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJIEJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:09:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33547 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeJIEJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:09:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 35A82207C3; Mon,  8 Oct 2018 22:55:39 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 577A320719;
        Mon,  8 Oct 2018 22:55:36 +0200 (CEST)
Date:   Mon, 8 Oct 2018 22:55:36 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <20181008205536.emefo2lddcuxl6sr@qschulz>
References: <20181008180649.GA9152@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jqv2n7jpxh5j4sz"
Content-Disposition: inline
In-Reply-To: <20181008180649.GA9152@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7jqv2n7jpxh5j4sz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Mon, Oct 08, 2018 at 08:06:49PM +0200, Gustavo A. R. Silva wrote:
> Currently, there is an out-of-bounds read on array ctrl->phys,
> once variable i reaches the maximum array size of SERDES_MAX
> in the for loop.
>=20
> Fix this by changing the condition in the for loop from
> i <=3D SERDES_MAX to i < SERDES_MAX.
>=20

Thanks for the heads up. However, as defined today, SERDES_MAX is a
valid value so I need it in the iteration. There are two possible fixes
though:

Either we let all the for loops as `for (i =3D 0; i <=3D SERDES_MAX; i++)`
and define ctrl->phys as an array of size SERDES_MAX + 1.

Or we modify the for loops as `for (i =3D 0; i < SERDES_MAX; i++)` and we
update SERDES_MAX in include/dt-bindings/phy/phy-ocelot-serdes.h to be
SERDES6G_MAX + 1.

As you wish!

Thanks,
Quentin

> Addresses-Coverity-ID: 1473966 ("Out-of-bounds read")
> Addresses-Coverity-ID: 1473959 ("Out-of-bounds read")
> Fixes: 51f6b410fc22 ("phy: add driver for Microsemi Ocelot SerDes muxing")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/phy/mscc/phy-ocelot-serdes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-=
ocelot-serdes.c
> index 8936abd..c4eee3a 100644
> --- a/drivers/phy/mscc/phy-ocelot-serdes.c
> +++ b/drivers/phy/mscc/phy-ocelot-serdes.c
> @@ -206,7 +206,7 @@ static struct phy *serdes_simple_xlate(struct device =
*dev,
>  	port =3D args->args[0];
>  	idx =3D args->args[1];
> =20
> -	for (i =3D 0; i <=3D SERDES_MAX; i++) {
> +	for (i =3D 0; i < SERDES_MAX; i++) {
>  		struct serdes_macro *macro =3D phy_get_drvdata(ctrl->phys[i]);
> =20
>  		if (idx !=3D macro->idx)
> @@ -260,7 +260,7 @@ static int serdes_probe(struct platform_device *pdev)
>  	if (!ctrl->regs)
>  		return -ENODEV;
> =20
> -	for (i =3D 0; i <=3D SERDES_MAX; i++) {
> +	for (i =3D 0; i < SERDES_MAX; i++) {
>  		ret =3D serdes_phy_create(ctrl, i, &ctrl->phys[i]);
>  		if (ret)
>  			return ret;
> --=20
> 2.7.4
>=20

--7jqv2n7jpxh5j4sz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7xEgACgkQhLiadT7g
8aOcQBAAhhrepp+SQgXoIGQt8SnUIc2tKM5nHP0/LVb6DQwRE06QF5L+DhgTN2kx
A/2GSlo5eYOGbLiJnXmevqm5TuZMOFlI14QcdTSooanAdr3Myav6mpB3jrIXYD0R
gpTp0pfZFn1PVQWUweIg8VFQDy1vSSlXrvK9iInAYYP3BsHQDqsr2oBYkoJ5V8lj
EGByxd4hxhYXf2W6R45YM4yUxzId4R2C6kinZuj4vmcfFrL8ia/0nz6B4c0rgEop
NmMdgPqvwkYH/zzM1fgsD5yZ3/5BwmM3FT3mpKO3xu4y6n765CaH4iQYHXJKHIVy
Vz+mkP7kVyBtS4GfjmT6VOpQbkLD593BgrxwA3Ghtdicn+DI4rMCo82jsG3bf3uA
rbKxbRf0JPT1Dxjt06moT3k9kUQ2Fg/Wyq0r6JnhMQGlnWARYxgP3fTFOjifbgpO
braFZ658amSkDvRK4KWU9NJFXo9u6AEHpDwqTvFmoWvWBi+ukBROTovW2S/RmbG2
aBWWQKlxxhyBNqwVcWISpBT43wHSHEaEo78grRha87zqB7Hn7lEZlXjKOmv//Q2C
6cSsg/vNjR1TKJfOONePyfxLAgDg+Ok0CcJJOPeCpohPP3Mwg3uBu/1im/3vkHdX
tPkzWJ9kJNvKbOVJAIFHYg3o2Bp6YEbA15U1Q9eZnWqY5CnhAo4=
=uDdN
-----END PGP SIGNATURE-----

--7jqv2n7jpxh5j4sz--
