Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeFDS4u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:56:50 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53808 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeFDS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:56:49 -0400
Message-ID: <1528138607.7898.119.camel@surriel.com>
Subject: Re: [PATCH 15/19] sched/numa: Use group_weights to identify if
 migration degrades locality
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 14:56:47 -0400
In-Reply-To: <1528106428-19992-16-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-16-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vm/PiTlZVk6smF16HD17"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vm/PiTlZVk6smF16HD17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
>=20
> +	dist =3D node_distance(src_nid, dst_nid);
>  	if (numa_group) {
> -		src_faults =3D group_faults(p, src_nid);
> -		dst_faults =3D group_faults(p, dst_nid);
> +		src_weight =3D group_weight(p, src_nid, dist);
> +		dst_weight =3D group_weight(p, dst_nid, dist);
>  	} else {
> -		src_faults =3D task_faults(p, src_nid);
> -		dst_faults =3D task_faults(p, dst_nid);
> +		src_weight =3D task_weight(p, src_nid, dist);
> +		dst_weight =3D task_weight(p, dst_nid, dist);
>  	}
> =20
> -	return dst_faults < src_faults;
> +	return dst_weight < src_weight;
>  }

While this is better in principle, in practice
task/group_weight is a LOT more expensive to
calculate than just comparing the faults.

This may be too expensive to do in the load
balancing code.

This patch regressed performance in your synthetic
test. How does it do for "real workload" style
benchmarks?

--=20
All Rights Reversed.
--=-vm/PiTlZVk6smF16HD17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVi28ACgkQznnekoTE
3oPy/gf+MFXl8ZzBs064TLIo9omq8SH8FkR+HfixkP6UIYb7pxwYC3Vdocuq9GYl
r3QrqeTBe7K8qdkN7T3rhT5Rgq4GNSG+1nJeHFmPqLGK7RySaHFwESEZmAqjbg0v
Gz9DhzSyrIg5LNV4UwynzcpFQ8UGnkt/6nc4tEYm9SQ8c4XNFDU7j74OAhDw0ZHQ
5MwAdXHTWQZbcFmH7UsJN4Y592EAlm1s1TBY54HHwyE38KJZlQVr0saviqGqjsy3
h1CrK/GmhfO6jkX7qd/8qkkayTWcYeMzU6eWMUUM8E272YI56FJ5WmCpXspe5Xw+
E+d83HkNy5UQHEZFskFaXItZXoErOQ==
=MKv5
-----END PGP SIGNATURE-----

--=-vm/PiTlZVk6smF16HD17--
