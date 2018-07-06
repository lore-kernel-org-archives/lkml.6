Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB111C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA3721C39
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA3721C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbeGFNoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:44:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48816 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753714AbeGFNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:44:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 78EB426096C
Date:   Fri, 6 Jul 2018 15:43:57 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
Subject: Re: [PATCH v4 5/5] power: supply: ds2760_battery: add devicetree
 probing
Message-ID: <20180706134357.4vjzj6775vjx5bew@earth.universe>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-6-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7p4xh6cexouua6y"
Content-Disposition: inline
In-Reply-To: <20180706053552.11438-6-daniel@zonque.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y7p4xh6cexouua6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 06, 2018 at 07:35:52AM +0200, Daniel Mack wrote:
> Add a matching table for devicetree probing, and optionally set the module
> parameter variables from DT properties.
>=20
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---

Acked-for-power-supply: Sebastian Reichel <sebastian.reichel@collabora.co.u=
k>

-- Sebastian

>  drivers/power/supply/ds2760_battery.c | 29 ++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply=
/ds2760_battery.c
> index aa406a7c65a1..11bed88a89fa 100644
> --- a/drivers/power/supply/ds2760_battery.c
> +++ b/drivers/power/supply/ds2760_battery.c
> @@ -29,6 +29,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/suspend.h>
>  #include <linux/w1.h>
> +#include <linux/of.h>
> =20
>  static unsigned int cache_time =3D 1000;
>  module_param(cache_time, uint, 0644);
> @@ -705,6 +706,24 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
> =20
>  	psy_cfg.drv_data =3D di;
> =20
> +	if (dev->of_node) {
> +		u32 tmp;
> +
> +		psy_cfg.of_node =3D dev->of_node;
> +
> +		if (!of_property_read_bool(dev->of_node, "maxim,pmod-enabled"))
> +			pmod_enabled =3D true;
> +
> +		if (!of_property_read_u32(dev->of_node,
> +					  "maxim,cache-time-ms", &tmp))
> +			cache_time =3D tmp;
> +
> +		if (!of_property_read_u32(dev->of_node,
> +					  "rated-capacity-microamp-hours",
> +					  &tmp))
> +			rated_capacity =3D tmp / 10; /* property is in mAh */
> +	}
> +
>  	di->charge_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> =20
>  	sl->family_data =3D di;
> @@ -719,7 +738,7 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
> =20
>  	ds2760_battery_write_status(di, status);
> =20
> -	/* set rated capacity from module param */
> +	/* set rated capacity from module param or device tree */
>  	if (rated_capacity)
>  		ds2760_battery_write_rated_capacity(di, rated_capacity);
> =20
> @@ -769,6 +788,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *=
sl)
>  	power_supply_unregister(di->bat);
>  }
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id w1_ds2760_of_ids[] =3D {
> +	{ .compatible =3D "maxim,ds2760" },
> +	{}
> +};
> +#endif
> +
>  static struct w1_family_ops w1_ds2760_fops =3D {
>  	.add_slave	=3D w1_ds2760_add_slave,
>  	.remove_slave	=3D w1_ds2760_remove_slave,
> @@ -778,6 +804,7 @@ static struct w1_family_ops w1_ds2760_fops =3D {
>  static struct w1_family w1_ds2760_family =3D {
>  	.fid		=3D W1_FAMILY_DS2760,
>  	.fops		=3D &w1_ds2760_fops,
> +	.of_match_table	=3D of_match_ptr(w1_ds2760_of_ids),
>  };
>  module_w1_family(w1_ds2760_family);
> =20
> --=20
> 2.17.1
>=20

--y7p4xh6cexouua6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/ch0ACgkQ2O7X88g7
+ppC1A//eeFh0WSQh4dt5TVvTN5pnK8QQJ+tk+zUoDzfavKuUyZWPvBGcJd2zlRK
3F9lTA3K2868RZ5J7EEYAYh4RbE2a/aPIwxE1EHGT+vJkh4mMdNQvnRP1ceQuafA
VattGr9cMHvOjE7M1/OT8LalFNtpJPRZ/vjKVlN6P45zJyF/KYGoVl+dw1KuuOjX
kDz69ZBFdBQjp9usYVvUsHg+Lo/cCOF6XfqOEPOSfGePJ7dTSAsEd4Sa+sufk+TT
ZinhIMzKaqeD4ZfsWNx4t0XRHzXfB+JkvKzkfhzzLELvzoJ9ZwdL97acgCq8EVZD
bgCqjAlOvzffYMTUuKegYw/Im+bXLuPtV+gP0F93KVrfbe67iQrOZ1ISStVUvEXC
fDU9nWO7pkpGKtvurUYnYzQyHVwhhEi7jmuqIOWG4CxBa5i5VZwxyqiSS6MenjjA
mE9IWVsIA6kmwD7UbpjlskisJfdS7bMvRn4PZWEZgjy2S3m4qlsAqGLkLp3IhbCF
npebRwB4GipOzrfWhsbctuz8G45WvXC10Ahc4hKCZ96NIvCzAdNKfI4QHi+RbKhK
qJyO5x+r2H3vdIoH3Rh8KOUQIEoNfbxk7AOHYcxVWqU3SR8UTxjoSru3GF0592CV
YnfKNDuS8O0RU7qL+Mf9DKoTZgQ6sydBtGl6MsEkH3eEGEuEOpU=
=qrxO
-----END PGP SIGNATURE-----

--y7p4xh6cexouua6y--
