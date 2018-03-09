Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCIGx3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:53:29 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:50888 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeCIGx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:53:27 -0500
X-Google-Smtp-Source: AG47ELuWEKTRK/PVAZqibCLZ3w+aVxFE8erGiSZ3sKfbNtZfl59zIQvYJgS3Eu/JtaGLC/5J0BSxEw==
X-ME-Sender: <xms:Yy-iWnivE5J-i-UlClCAh53qVLi0MdSidx0Owyn9bSyAYPnW8OWuKQ>
Date: Fri, 9 Mar 2018 14:57:00 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: exp: Fix "must hold exp_mutex" comments for QS
 reporting functions
Message-ID: <20180309065700.qseccsy3z3m72pa7@tardis>
References: <20180307084944.10229-1-boqun.feng@gmail.com>
 <20180307154829.GE3918@linux.vnet.ibm.com>
 <20180308034627.n2xw32zzujnmy2gb@tardis>
 <20180308043017.GL3918@linux.vnet.ibm.com>
 <20180308045429.py66d76trikiuguf@tardis>
 <20180308083006.wsgvkiw2ejbcwhhu@tardis>
 <20180308154255.GM3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="26t2p7xpkiadyvj2"
Content-Disposition: inline
In-Reply-To: <20180308154255.GM3918@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--26t2p7xpkiadyvj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 07:42:55AM -0800, Paul E. McKenney wrote:
> On Thu, Mar 08, 2018 at 04:30:06PM +0800, Boqun Feng wrote:
> > On Thu, Mar 08, 2018 at 12:54:29PM +0800, Boqun Feng wrote:
> > > On Wed, Mar 07, 2018 at 08:30:17PM -0800, Paul E. McKenney wrote:
> > > [...]
> > > > > =20
> > > > > +/*
> > > > > + * Like sync_rcu_preempt_exp_done(), but this function assumes t=
he caller
> > > > > + * doesn't hold the rcu_node's ->lock, and will acquire and rele=
ase the lock
> > > > > + * itself
> > > > > + */
> > > > > +static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *=
rnp)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +	bool ret;
> > > > > +
> > > > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > +	ret =3D sync_rcu_preempt_exp_done(rnp);
> > > >=20
> > > > Let's see...  The sync_rcu_preempt_exp_done() function checks the
> > > > ->exp_tasks pointer and the ->expmask bitmask.  The number of bits =
in the
> > > > mask can only decrease, and the ->exp_tasks pointer can only transi=
tion
> > > > from NULL to non-NULL when there is at least one bit set.  However,
> > > > there is no ordering in sync_rcu_preempt_exp_done(), so it is possi=
ble
> > > > that it could be fooled without the lock:
> > > >=20
> > > > o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
> > > > 	sees that it is NULL.
> > > >=20
> > > > o	CPU 1 blocks within an RCU read-side critical section, so
> > > > 	it enqueues the task and points ->exp_tasks at it and
> > > > 	clears CPU 1's bit in ->expmask.
> > > >=20
> > > > o	All other CPUs clear their bits in ->expmask.
> > > >=20
> > > > o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
> > > > 	concludes that all quiescent states have completed, despite
> > > > 	the fact that ->exp_tasks is non-NULL.
> > > >=20
> > > > So it seems to me that the lock is needed.  Good catch!!!  The prob=
lem
> > > > would occur only if the task running on CPU 0 received a spurious
> > > > wakeup, but that could potentially happen.
> > >=20
> > > Thanks for the analysis ;-)
>=20
> The other limitation is that it occurs only on systems small enough
> to have a single-node rcu_node tree.  But still...
>=20
> > > > If lock contention becomes a problem, memory-ordering tricks could =
be
> > > > applied, but the lock is of course simpler.
> > > >=20
> > >=20
> > > Agreed.
> > >=20
> > > > I am guessing that this is a prototype patch, and that you are plan=
ning
> > >=20
> > > Yes, this is a prototype. And I'm preparing a proper patch to send
> > > later.
>=20
> Very good, thank you!
>=20
> > > > to add lockdep annotations in more places, but either way please let
> > > > me know.
> > >=20
> > > Give it's a bug as per your analysis, I'd like to defer other lockdep
> > > annotations and send this first. However, I'm currently getting other
> > > lockdep splats after applying this, so I need to get that sorted firs=
t.
> >=20
> > Hmm.. the other lockdep splat seems irrelevant with my patch, I could
> > observe it on mainline using rcutorture with CONFIG_PROVE_LOCKING=3Dy. =
I'd
> > spend some more time on it, in the meanwhile, send a proper patch for
> > this sync_rcu_preempt_exp_done().
>=20
> I am not seeing that one, but am very interested in getting it fixed!  ;-)
>=20

Found the root cause, and send out the patch ;-)

Regards,
Boqun

> 							Thanx, Paul
>=20

--26t2p7xpkiadyvj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqiMDkACgkQSXnow7UH
+rgHHwgAoaF70G3NFrmME1568NOk+1Jvhz25ma/545lt/KOXV/M4yD/1M5pEDd5u
l1PdgMs9kCYjn4PzxAgbNjPG5PQ5LFOhAugAg2fLMNcGpyhL2o8+9HZ1c9kaFPJX
35r2H9gfGZME4B75PDGKUkmEnR+OvVpk4ey1oAj+pDa9LwW13FBxTwm5dkJz3qwo
bZou94ok2mzic4kGA2uMuU11xi5tO/QxhsTkiLHvHP4xyt3qACx4K+reusQd7Q+2
dr9r3TasUAG/HAkeekZeM02hM8n1d4l9/6Duq0b4VoRKTzJx8amL2V9JuPvIRAsb
Dsmli8MLsiq2pS0fdexBYUh8wJiAzw==
=1VC7
-----END PGP SIGNATURE-----

--26t2p7xpkiadyvj2--
