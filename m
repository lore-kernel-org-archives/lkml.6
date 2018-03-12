Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbeCLFY5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 01:24:57 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:40696 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeCLFY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 01:24:56 -0400
X-Google-Smtp-Source: AG47ELvilIkqa/jmnYgb21iiPbaqRofFc8AA9+X7/WhSoEi117za7tIdqR6OuGHc/pYQpAyVKjbbWw==
X-ME-Sender: <xms:JQ-mWoH3GqFOKHwWgba7rHMxJ8wRvNx2qRaP1p1DONlBrWXrWiYkbA>
Date: Mon, 12 Mar 2018 13:28:38 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: exp: Fix "must hold exp_mutex" comments for QS
 reporting functions
Message-ID: <20180312052838.676fknxi4kvucgdd@tardis>
References: <20180307084944.10229-1-boqun.feng@gmail.com>
 <20180307154829.GE3918@linux.vnet.ibm.com>
 <20180308034627.n2xw32zzujnmy2gb@tardis>
 <20180308043017.GL3918@linux.vnet.ibm.com>
 <20180308045429.py66d76trikiuguf@tardis>
 <20180308083006.wsgvkiw2ejbcwhhu@tardis>
 <20180308154255.GM3918@linux.vnet.ibm.com>
 <20180309065700.qseccsy3z3m72pa7@tardis>
 <20180309201707.GC3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fqb7mjm7zp4rxmu"
Content-Disposition: inline
In-Reply-To: <20180309201707.GC3918@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fqb7mjm7zp4rxmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 12:17:07PM -0800, Paul E. McKenney wrote:
> On Fri, Mar 09, 2018 at 02:57:00PM +0800, Boqun Feng wrote:
> > On Thu, Mar 08, 2018 at 07:42:55AM -0800, Paul E. McKenney wrote:
> > > On Thu, Mar 08, 2018 at 04:30:06PM +0800, Boqun Feng wrote:
> > > > On Thu, Mar 08, 2018 at 12:54:29PM +0800, Boqun Feng wrote:
> > > > > On Wed, Mar 07, 2018 at 08:30:17PM -0800, Paul E. McKenney wrote:
> > > > > [...]
> > > > > > > =20
> > > > > > > +/*
> > > > > > > + * Like sync_rcu_preempt_exp_done(), but this function assum=
es the caller
> > > > > > > + * doesn't hold the rcu_node's ->lock, and will acquire and =
release the lock
> > > > > > > + * itself
> > > > > > > + */
> > > > > > > +static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_no=
de *rnp)
> > > > > > > +{
> > > > > > > +	unsigned long flags;
> > > > > > > +	bool ret;
> > > > > > > +
> > > > > > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > > > +	ret =3D sync_rcu_preempt_exp_done(rnp);
> > > > > >=20
> > > > > > Let's see...  The sync_rcu_preempt_exp_done() function checks t=
he
> > > > > > ->exp_tasks pointer and the ->expmask bitmask.  The number of b=
its in the
> > > > > > mask can only decrease, and the ->exp_tasks pointer can only tr=
ansition
> > > > > > from NULL to non-NULL when there is at least one bit set.  Howe=
ver,
> > > > > > there is no ordering in sync_rcu_preempt_exp_done(), so it is p=
ossible
> > > > > > that it could be fooled without the lock:
> > > > > >=20
> > > > > > o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
> > > > > > 	sees that it is NULL.
> > > > > >=20
> > > > > > o	CPU 1 blocks within an RCU read-side critical section, so
> > > > > > 	it enqueues the task and points ->exp_tasks at it and
> > > > > > 	clears CPU 1's bit in ->expmask.
> > > > > >=20
> > > > > > o	All other CPUs clear their bits in ->expmask.
> > > > > >=20
> > > > > > o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
> > > > > > 	concludes that all quiescent states have completed, despite
> > > > > > 	the fact that ->exp_tasks is non-NULL.
> > > > > >=20
> > > > > > So it seems to me that the lock is needed.  Good catch!!!  The =
problem
> > > > > > would occur only if the task running on CPU 0 received a spurio=
us
> > > > > > wakeup, but that could potentially happen.
> > > > >=20
> > > > > Thanks for the analysis ;-)
> > >=20
> > > The other limitation is that it occurs only on systems small enough
> > > to have a single-node rcu_node tree.  But still...
> > >=20
> > > > > > If lock contention becomes a problem, memory-ordering tricks co=
uld be
> > > > > > applied, but the lock is of course simpler.
> > > > > >=20
> > > > >=20
> > > > > Agreed.
> > > > >=20
> > > > > > I am guessing that this is a prototype patch, and that you are =
planning
> > > > >=20
> > > > > Yes, this is a prototype. And I'm preparing a proper patch to send
> > > > > later.
> > >=20
> > > Very good, thank you!
> > >=20
> > > > > > to add lockdep annotations in more places, but either way pleas=
e let
> > > > > > me know.
> > > > >=20
> > > > > Give it's a bug as per your analysis, I'd like to defer other loc=
kdep
> > > > > annotations and send this first. However, I'm currently getting o=
ther
> > > > > lockdep splats after applying this, so I need to get that sorted =
first.
> > > >=20
> > > > Hmm.. the other lockdep splat seems irrelevant with my patch, I cou=
ld
> > > > observe it on mainline using rcutorture with CONFIG_PROVE_LOCKING=
=3Dy. I'd
> > > > spend some more time on it, in the meanwhile, send a proper patch f=
or
> > > > this sync_rcu_preempt_exp_done().
> > >=20
> > > I am not seeing that one, but am very interested in getting it fixed!=
  ;-)
> >=20
> > Found the root cause, and send out the patch ;-)
>=20
> Very good!  Still not sure why I don't see it, but as long as it is fixed!
>=20

One thing I could hit this is because I ran rcutorture with
CONFIG_PROVE_LOCKING=3Dy, maybe you could consider adding that in your
rcutorture testsuite?

Regards,
Boqun

> 							Thanx, Paul
>=20

--7fqb7mjm7zp4rxmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqmEAAACgkQSXnow7UH
+rjOFggAoYxpdnwegdgoZ7gv+SFXjq+BSdN4oXr2xEeWSOUDgGJXui6uU9YFJ8Tj
+6O1mDCAImTetURu6Rg756OEbeTqrPOlPYGszM+69qO6cG15YkiNPe/BdtQWYIV5
0TbKy3O40ZLg8GDOJyR6hmQTSA+B1N5ICm1wVTXeIlKJ3V85hcS7cUziClqB6fLe
TSknTf/cP3D4RQxWohegXMh16xGx8q5+5uVaUCBPIV8P6Rs/F3KPa1Og72+YOVRw
emZdKqbtp67R9tBXXDk8Dsh8VfQZ/7vlknmcOFmzLgwOdfB+1E1Zh7wNqsqsKuHl
yi+xIEKSLdcAMwqMszb33tLc2LHfvw==
=oe77
-----END PGP SIGNATURE-----

--7fqb7mjm7zp4rxmu--
