Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeFENIC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:08:02 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36792 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeFENIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:08:01 -0400
Message-ID: <1528204074.7898.126.camel@surriel.com>
Subject: Re: [PATCH 16/19] sched/numa: Detect if node actively handling
 migration
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 05 Jun 2018 09:07:54 -0400
In-Reply-To: <20180605035616.GD30328@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
         <1528142755.7898.122.camel@surriel.com>
         <20180605035616.GD30328@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eq1f2yO6FIv0pXwTJrZq"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eq1f2yO6FIv0pXwTJrZq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 20:56 -0700, Srikar Dronamraju wrote:
> * Rik van Riel <riel@surriel.com> [2018-06-04 16:05:55]:
>=20
> > On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> >=20
> > > @@ -1554,6 +1562,9 @@ static void task_numa_compare(struct
> > > task_numa_env *env,
> > >  	if (READ_ONCE(dst_rq->numa_migrate_on))
> > >  		return;
> > > =20
> > > +	if (*move && READ_ONCE(pgdat->active_node_migrate))
> > > +		*move =3D false;
> >=20
> > Why not do this check in task_numa_find_cpu?
> >=20
> > That way you won't have to pass this in as a
> > pointer, and you also will not have to recalculate
> > NODE_DATA(cpu_to_node(env->dst_cpu)) for every CPU.
> >=20
>=20
> I thought about this. Lets say we evaluated that destination node can
> allow movement. While we iterate through the list of cpus trying to
> find
> the best cpu node, we find a idle cpu towards the end of the list.
> However if another task as already raced with us to move a task to
> this
> node, then we should bail out. Keeping the check in task_numa_compare
> will allow us to do this.

Your check is called once for every invocation
of task_numa_compare. It does not matter whether
it is inside or outside, except on the outside
the variable manipulation will be easier to read.

> > > +	 * task migration might only result in ping pong
> > > +	 * of tasks and also hurt performance due to cache
> > > +	 * misses.
> > > +	 */
> > > +	if (imp < SMALLIMP || imp <=3D env->best_imp + SMALLIMP /
> > > 2)
> > > +		goto unlock;
> >=20
> > I can see a use for the first test, but why limit the
> > search for the best score once you are past the
> > threshold?
> >=20
> > I don't understand the use for that second test.
> >=20
>=20
> Lets say few threads are racing with each other to find a cpu on the
> node. The first thread has already found a task/cpu 'A' to swap and
> finds another task/cpu 'B' thats slightly better than the current
> best_cpu which is 'A'. Currently we allow the second task/cpu 'B' to
> be
> set as best_cpu. However the second or subsequent threads cannot find
> the first task/cpu A because its suppose to be in active migration.
> By
> the time it reaches task/cpu B even that may look to be in active
> migration. It may never know that task/cpu A was cleared. In this
> way,
> the second and subsequent threads may not get a task/cpu in the
> preferred node to swap just because the first task kept hopping
> task/cpu
> as its choice of migration.
>=20
> While we can't complete avoid this, the second check will try to make
> sure we don't hop on/hop off just for small incremental numa
> improvement.

However, all those racing tasks start searching
the CPUs on a node from the same start position.

That means they may all get stuck on the same
task/cpu A, and not select the better task/cpu B.

What am I missing?=20

--=20
All Rights Reversed.
--=-eq1f2yO6FIv0pXwTJrZq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsWiyoACgkQznnekoTE
3oPsygf8CL3r1OSfblgGqP74msPXaeKt38dDue3qzEhqGAeor+xAcptVOPaQ6skf
gf4t8WNX+r8wAmaG+RQ0w/O9n6Wce4b2oK3FrKkW/imcaBQcoFwWs+REalecanPV
FfqdOIstWVucBB30ZrwypjaaydAfaxJzqBzCiJmJzk81pdHJ89CN+gA7ndMaILyC
/AZUwTz7cwe31viwwYKt6kftm4r+3WgT0WwU3lMhG1TjcmIBar+we6Mqr6kg7S+m
oe+xL1rqDefxn8pQcmqDsA0xjQXK2yKwCQosziaD5XIHhUrRhFoHyRINpAg1tFyD
r3qUl7GRR2GlZiDmFwYCbOo9yX9UWw==
=xcJ/
-----END PGP SIGNATURE-----

--=-eq1f2yO6FIv0pXwTJrZq--
