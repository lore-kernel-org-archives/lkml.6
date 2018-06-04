Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeFDOv3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:51:29 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50950 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeFDOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:51:28 -0400
Message-ID: <1528123887.7898.103.camel@surriel.com>
Subject: Re: [PATCH 02/19] sched/numa: Evaluate move once per node
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 10:51:27 -0400
In-Reply-To: <1528106428-19992-3-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-3-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-395iSGHptK32OJ8NjDXI"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-395iSGHptK32OJ8NjDXI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:

> @@ -1564,97 +1563,73 @@ static void task_numa_compare(struct
> task_numa_env *env,
>  	if (cur =3D=3D env->p)
>  		goto unlock;
> =20
> +	if (!cur) {
> +		if (!move || imp <=3D env->best_imp)
> +			goto unlock;
> +		else
> +			goto assign;
> +	}

Just bike shedding, but it may be easier to read
if the "we found our destination" check were written
more explicitly:


	if (!cur) {
		if (move && imp > env->best_imp)
			gote assign;
		else
			goto unlock;
	}

Also, the "move" variable seems to indicate that
the NUMA code may move the task, but not a decision
that moving the task is better than a swap.

Would it make sense to call it "maymove"?

I like how this patch simplifies the code a little.

--=20
All Rights Reversed.
--=-395iSGHptK32OJ8NjDXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVUe8ACgkQznnekoTE
3oOFcAf+LWFfiBTbrQxxbTghL166fJhf8cYSlWD7VmQuTgwPrPx+bfDjmCsWFZ9H
KeurdddClxsPlcNtO5+PRb/CpyAISLFOaWUkO13ZHY9QPwpmv4eCFnkBDXn/kjwg
45sYVJqEJRWmi5JjdeXg8GH3zX1/JyF2NOGNctVLjBRIl3MAfzu/VEbNycDY46Hf
N6W//9Pa9e529jujFYYhHdYQColHxy1xH5RqyLyQbOQrLlGCWbNE/YbnD2D27NKN
kgx+OuWKddYR5+nPSNjLDuRlm6aIWTQ+w6dB2ZrNu393Icwf4Y1bueb9PJI44sgf
xLw/bYfVh8R/roqE8HfgpsoJQIhemQ==
=PRzE
-----END PGP SIGNATURE-----

--=-395iSGHptK32OJ8NjDXI--
