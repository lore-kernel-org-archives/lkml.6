Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeBVPIt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:08:49 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43523 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeBVPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:08:48 -0500
X-Google-Smtp-Source: AH8x227XPA7GexyU6UEiFBxyJwg48szjFA6czbqwajuwccb9dQ1Gm5eqUGI4yWe8G7wP42pPZPpKNw==
X-ME-Sender: <xms:_dyOWpUFCR2jLjLBYobE6A4hRMbucyBVWZvdPew6RnZ81dylnEKTbA>
Date: Thu, 22 Feb 2018 23:12:10 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222151210.jwxjchywk4jfecyf@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipaldxvkbhgugx34"
Content-Disposition: inline
In-Reply-To: <20180222142614.GR25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ipaldxvkbhgugx34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 03:26:14PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 03:08:52PM +0800, Boqun Feng wrote:
> > Now we have four kinds of dependencies in the dependency graph, and not
> > all the pathes carry strong dependencies, for example:
> >=20
> > 	Given lock A, B, C, if we have:
> >=20
> > 	CPU1			CPU2
> > 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > 	write_lock(A);		read_lock(B);
> > 	read_lock(B);		write_lock(C);
> >=20
> > 	then we have dependencies A--(NR)-->B, and B--(RN)-->C, (NR and
> > 	RN are to indicate the dependency kind), A actually doesn't have
> > 	strong dependency to C(IOW, C doesn't depend on A), to see this,
>                               ^ missing space
>=20
> You're fairly consistent with not putting spaces before opening braces
> in text, please don't do this, this is not a C function call. Also

Got it.

> double check all your braces are matched, IIRC there's at least one that
> isn't closed in the previous patches.
>=20

Sure, will do.

> > 	let's say we have a third CPU3 doing:
> >=20
> > 	CPU3:
> > 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 	write_lock(C);
> > 	write_lock(A);
> >=20
> > 	, this is not a deadlock. However if we change the read_lock()
> > 	on CPU2 to a write_lock(), it's a deadlock then.
> >=20
> > 	So A --(NR)--> B --(RN)--> C is not a strong dependency path but
> > 	A --(NR)--> B --(NN)-->C is a strong dependency path.
>=20
> I'm not really satisfied with the above reasoning. I don't disagree, but
> if possible it would be nice to have something a little more solid.
>=20

What do you mean by "solid"? You mean "A --(NR)--> B --(NN)-->C" is too
abstract, and want something like the below instead:

	CPU 1			CPU 2			CPU 3
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	write_lock(A);
				write_lock(B);
	read_lock(B); // blocked			write_lock(C);
				write_lock(C); // blocked
							write_lock(A); // blocked

?


>=20
> > We can generalize this as: If a path of dependencies doesn't have two
> > adjacent dependencies as (*R)--L-->(R*), where L is some lock, it is a
> > strong dependency path, otherwise it's not.
> >=20
> > Now our mission is to make __bfs() traverse only the strong dependency
> > paths, which is simple: we record whether we have -(*R)-> at the current
> > tail of the path in lock_list::is_rr, and whenever we pick a dependency
> > in the traverse, we 1) make sure we don't pick a -(R*)-> dependency if
> > our current tail is -(*R)-> and 2) greedily pick a -(*N)-> as hard as
> > possible.
> >=20
> > With this extension for __bfs(), we now need to initialize the root of
> > __bfs() properly(with a correct ->is_rr), to do so, we introduce some
>                   ^ another missing space
>=20
> Also, I don't like is_rr as a name, have_xr might be better.
>=20

Maybe "pick_xr", which means we pick a *R in the BFS search path for the
previous entry, then we can not pick R* for the next entry.

> Only if we combine *R with R* do we have RR.
>=20
> > +/*
> > + * return -1 if no proper dependency could be picked
> > + * return 0 if a -(*N)-> dependency could be picked
> > + * return 1 if only a -(*R)-> dependency could be picked
> > + *
> > + * N: non-recursive lock
> > + * R: recursive read lock
> > + */
> > +static inline int pick_dep(u16 is_rr, u16 cap_dep)
> > +{
> > +	if (is_rr) { /* could only pick -(N*)-> */
> > +		if (cap_dep & DEP_NN_MASK)
> > +			return 0;
> > +		else if (cap_dep & DEP_NR_MASK)
> > +			return 1;
> > +		else
> > +			return -1;
> > +	} else {
> > +		if (cap_dep & DEP_NN_MASK || cap_dep & DEP_RN_MASK)
>=20
> 	if (cap_dep & (DEP_NN_MASK | DEP_RN_MASK))

Good point!


>=20
> > +			return 0;
> > +		else
> > +			return 1;
> > +	}
> > +}
>=20
> However, I would suggest:
>=20
> static inline bool is_xr(u16 dep)
> {
> 	return !!(dep & (DEP_NR_MASK | DEP_RR_MASK));
> }
>=20
> static inline bool is_rx(u16 dep)
> {
> 	return !!(dep & (DEP_RN_MASK | DEP_RR_MASK));
> }
>=20
>=20
> > @@ -1095,11 +1179,18 @@ static enum bfs_result __bfs(struct lock_list *=
source_entry,
> >  		else
> >  			head =3D &lock->class->locks_before;
> > =20
> > +		is_rr =3D lock->is_rr;
> > +
> >  		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
> > =20
> >  		list_for_each_entry_rcu(entry, head, entry) {
> >  			unsigned int cq_depth;
> > =20
> > +			next_is_rr =3D pick_dep(is_rr, entry->dep);
> > +			if (next_is_rr < 0)
> > +				continue;
> > +			entry->is_rr =3D next_is_rr;
>=20
> 		/* Skip *R -> R* relations */
> 		if (have_xr && is_rx(entry->dep))
> 			continue;

I don't think this works, if we pick a *R for previous entry, and for
current entry, we have RR, NN and NR, your approach will skip the
current entry, but actually we can pick NN or NR (of course, in __bfs(),
we can greedily pick NN, because if NR causes a deadlock, so does NN).

Note that lock_list::dep can be treated as a set/bitmap for different
kinds of dependencies between the same pair of locks.

Some related explanation of pick_dep() is put in the comment of
__bfs(), which is my bad ;-( I will reorder the code to have an
overall explanation for the algorithm, and put all related functions
after that.

Regards,
Boqun

>=20
> 		entry->have_xr =3D is_xr(entry->dep);
>=20
> Which to me is a much simpler construct, hmm?
>=20
> > +
> >  			visit_lock_entry(entry, lock);
> >  			if (match(entry, data)) {
> >  				*target_entry =3D entry;
>=20
>=20
>=20

--ipaldxvkbhgugx34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqO3ccACgkQSXnow7UH
+rjjzggArnklZHe7A7LKNeljg6JDsq/5yqIal3s5KH8JiZ8ZwzYE5dWzOgz2opTU
Mt2Yh7vW3u2pMTcnflWw7AVgf0ETH524RedGcHcGDbPnMAVzLBF32+pM8J0CeC/W
79yTCxWKdFzNaOnUZBb5rZixnBbh9njZ+jfGMD2ErrdUd8x/WsD+YDeNljjXsIwM
AVujqtxkr54lw2gpuEwlJlsxSexQZYeHij4HD6+vd9U+tRkB+jj5TCtWuD6W1TyS
YcfAu+tSVz56wJoqV26RafOGLzmwXd/9c2eBcrVW6EnGaNRrGRzudO3HMvv3ieE5
6fHpfygh91uguyhpZIlCNe9lfG4oQw==
=ITZT
-----END PGP SIGNATURE-----

--ipaldxvkbhgugx34--
