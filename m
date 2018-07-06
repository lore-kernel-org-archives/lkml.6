Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FFA23E08
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FFA23E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeGFNwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:52:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeGFNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:52:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 737AC26096C
Date:   Fri, 6 Jul 2018 15:52:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Mack <daniel@zonque.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, robert.jarzmik@free.fr
Subject: Re: [PATCH v4 3/5] w1: core: match sub-nodes of bus masters in
 devicetree
Message-ID: <20180706135205.dkcrhbmaak2iteyw@earth.universe>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-4-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jr34mizs65dijvag"
Content-Disposition: inline
In-Reply-To: <20180706053552.11438-4-daniel@zonque.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jr34mizs65dijvag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg & Evgeniy,

I suggest, that I take this patch and the DT bindings together
with the power-supply changes, once the bindings have been
reviewed by Rob (Herring). I will prepare an immutable branch,
that can be pulled into w1 as needed. Are you fine with this?

-- Sebastian

On Fri, Jul 06, 2018 at 07:35:50AM +0200, Daniel Mack wrote:
> Once a new slave device is detected, match it against all sub-nodes of the
> master bus controller. If a match is found, set the slave device's of_node
> pointer.
>=20
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  drivers/w1/w1.c    | 3 +++
>  include/linux/w1.h | 2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index caef0e0fd817..890c038c25f8 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -26,6 +26,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/hwmon.h>
> +#include <linux/of.h>
> =20
>  #include <linux/atomic.h>
> =20
> @@ -686,6 +687,8 @@ static int __w1_attach_slave_device(struct w1_slave *=
sl)
>  	sl->dev.bus =3D &w1_bus_type;
>  	sl->dev.release =3D &w1_slave_release;
>  	sl->dev.groups =3D w1_slave_groups;
> +	sl->dev.of_node =3D of_find_matching_node(sl->master->dev.of_node,
> +						sl->family->of_match_table);
> =20
>  	dev_set_name(&sl->dev, "%02x-%012llx",
>  		 (unsigned int) sl->reg_num.family,
> diff --git a/include/linux/w1.h b/include/linux/w1.h
> index 694101f744c7..3111585c371f 100644
> --- a/include/linux/w1.h
> +++ b/include/linux/w1.h
> @@ -274,6 +274,8 @@ struct w1_family {
> =20
>  	struct w1_family_ops	*fops;
> =20
> +	const struct of_device_id *of_match_table;
> +
>  	atomic_t		refcnt;
>  };
> =20
> --=20
> 2.17.1
>=20

--jr34mizs65dijvag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/dAUACgkQ2O7X88g7
+po/Gw/+Jzss71qx02l0mYdd3zWj50h8YdC+iQ6kVQJEPqFGbEeh0wArZw1dZ84k
HNRlFpwHstfMyIkp1+BF1Snv6sYg5MuAkFhQCLrQac7oFiYGLBGdLx8LBYhbwgW5
qZhlPftWHbe9lkWZhw//V3hajzYFJS/9PBuTlJh50WsFU3wfgdMUwmezk6idKVHX
SJw7JdK2j5Y/p/IjhJwLWsd2pkZ3/mFPW3Ut2/XSeV4gkqWoEzr5XqNu8KjXBMoA
P1Oipc8tikjqYZ2TyRln/xwBOpOe3fXmqFvXkLc6AjFdtS61Exw68EmKd2jr+QuH
qHUA1rjnNmmMZ3BENMvMgPjQRyuR/flRMR6bN0U9BW08s2NwF0UowWyCRUX4Gxcg
TYsdQn4Rftc8yDtzWw0EgdS4Hkr+yVzZzob0lstMdaeiAQ3i0krs+I4Btq/g5uXk
OcUP6MJ50q0KpCTbFXF7ISIdmyoJdx4y1AF4jDqj9stfUwqpPzRq0duotaS9YAPE
3zt5mSgJpZYjThmdiYK5OBC1OVBISLrsUL1UCKyU768lAnqmXob1hhUSodQlpSPa
5J+j7JhVIEMqjP1VEArw8aG7CM8VXKsHyK3bkkmiQc4Alu2YANiZuKDHy1hdnA/J
XcXIyFhCPyh6VrrVndjCn2DwG3All1Kexz0WzZ81PKi0/lVuq9Q=
=/Cs2
-----END PGP SIGNATURE-----

--jr34mizs65dijvag--
