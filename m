Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFDUF6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:05:58 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53898 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeFDUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:05:57 -0400
Message-ID: <1528142755.7898.122.camel@surriel.com>
Subject: Re: [PATCH 16/19] sched/numa: Detect if node actively handling
 migration
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 16:05:55 -0400
In-Reply-To: <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QvcmWrj+G+DSdPGPn/WV"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QvcmWrj+G+DSdPGPn/WV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:

> @@ -1554,6 +1562,9 @@ static void task_numa_compare(struct
> task_numa_env *env,
>  	if (READ_ONCE(dst_rq->numa_migrate_on))
>  		return;
> =20
> +	if (*move && READ_ONCE(pgdat->active_node_migrate))
> +		*move =3D false;

Why not do this check in task_numa_find_cpu?

That way you won't have to pass this in as a
pointer, and you also will not have to recalculate
NODE_DATA(cpu_to_node(env->dst_cpu)) for every CPU.

>  	/*
> +	 * If the numa importance is less than SMALLIMP,

              ^^^ numa improvement

> +	 * task migration might only result in ping pong
> +	 * of tasks and also hurt performance due to cache
> +	 * misses.
> +	 */
> +	if (imp < SMALLIMP || imp <=3D env->best_imp + SMALLIMP / 2)
> +		goto unlock;

I can see a use for the first test, but why limit the
search for the best score once you are past the
threshold?

I don't understand the use for that second test.

What workload benefits from it?

--=20
All Rights Reversed.
--=-QvcmWrj+G+DSdPGPn/WV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVm6MACgkQznnekoTE
3oOSnwf/bbTYHVhtD7SxCuBW1Fl5XvQVaF+EgGecbI9e1HkXEthcT/HVQC58WIWR
8a0lgBmcrmSOnIRIJX6fbSOcaQrR2OWUdV29S6sznZm/sf7W/0YMh3lEudJNDy/E
E9BcFMBnkIaq5b2e/pgIfeYnw802OowC0/gOXQ8xD8OUA2eHIhEaflFX20Xw7zPG
L4jW2UP7GprEYBGiGcakhu+qL/MdQCLJbdS89ANKBDykoWVdRtdhp983oIFuZ0TB
ysGv/IdOoMXu9ojb1Wp+0390MoLhcjO5dBUaxi0rFOWTgzpTIBg5cWldDYM2a6WN
5qaI5dnnHaKcLjDjjYlWgXHelHDvVQ==
=pR+q
-----END PGP SIGNATURE-----

--=-QvcmWrj+G+DSdPGPn/WV--
