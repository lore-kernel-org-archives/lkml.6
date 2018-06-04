Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeFDSWm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:22:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53752 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFDSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:22:39 -0400
Message-ID: <1528136558.7898.115.camel@surriel.com>
Subject: Re: [PATCH 13/19] mm/migrate: Use xchg instead of spinlock
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 14:22:38 -0400
In-Reply-To: <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-R90uq2lBlyTIAr4P3UMv"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-R90uq2lBlyTIAr4P3UMv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
>=20
> +++ b/mm/migrate.c
> @@ -1874,11 +1874,9 @@ static bool
> numamigrate_update_ratelimit(pg_data_t *pgdat,
>  	 * all the time is being spent migrating!
>  	 */
>  	if (time_after(jiffies, pgdat-
> >numabalancing_migrate_next_window)) {
> -		spin_lock(&pgdat->numabalancing_migrate_lock);
> -		pgdat->numabalancing_migrate_nr_pages =3D 0;
> -		pgdat->numabalancing_migrate_next_window =3D jiffies +
> -			msecs_to_jiffies(migrate_interval_millisecs)
> ;
> -		spin_unlock(&pgdat->numabalancing_migrate_lock);
> +		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
> +			pgdat->numabalancing_migrate_next_window =3D
> jiffies +
> +				msecs_to_jiffies(migrate_interval_mi
> llisecs);
>  	}

I am not convinced this is simpler, but no real
objection either way :)

--=20
All Rights Reversed.
--=-R90uq2lBlyTIAr4P3UMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVg24ACgkQznnekoTE
3oOnMggAqziD23EDTbKNizoTmHvA8yUDoTI2LBcUIp9WNbz9vO8ohixyMU4VANLq
UP5tew+98R2PdtKv8MT97NFDU5pJ46EtFoRYGT/U8TeHxw5IQ1MMvtWpC8wo7aNK
DrJFDu1ZECAFwQnPTOf7NjxfoGWAl67yWbVSSJki6pXiBc06vlvLhkt++yL2Jcl6
D76CM6VQWKnp045VUZApPT5i2L/idG2RJRp1EBV4uz5aM79w7yR4TNbYSX+VmGIu
ywmQ4v5zjYErB2eQKA+Dudx73rrw5ijjELaH+WaLV6z8dOfF1iS1xdcakwyfVNqB
Yt3GXUVNh58yr6HBT0bwdq25nGywDg==
=5tGL
-----END PGP SIGNATURE-----

--=-R90uq2lBlyTIAr4P3UMv--
