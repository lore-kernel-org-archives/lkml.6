Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935540AbeCHI0b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:26:31 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53183 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934717AbeCHI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:26:29 -0500
X-Google-Smtp-Source: AG47ELvkEx9iiWqepdu8KytIbD8i2s5jk8I72G4E/ywOpqMvZqrmnKPoKw+FSEOXdVAEOks6SHxiJA==
X-ME-Sender: <xms:sfOgWnclJdeyQ8dhypKQ-8TpWE5UU11ileWijukL2zbdJ94LmbMDVQ>
Date: Thu, 8 Mar 2018 16:30:06 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: exp: Fix "must hold exp_mutex" comments for QS
 reporting functions
Message-ID: <20180308083006.wsgvkiw2ejbcwhhu@tardis>
References: <20180307084944.10229-1-boqun.feng@gmail.com>
 <20180307154829.GE3918@linux.vnet.ibm.com>
 <20180308034627.n2xw32zzujnmy2gb@tardis>
 <20180308043017.GL3918@linux.vnet.ibm.com>
 <20180308045429.py66d76trikiuguf@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xclsvex53f4dd3zp"
Content-Disposition: inline
In-Reply-To: <20180308045429.py66d76trikiuguf@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xclsvex53f4dd3zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 12:54:29PM +0800, Boqun Feng wrote:
> On Wed, Mar 07, 2018 at 08:30:17PM -0800, Paul E. McKenney wrote:
> [...]
> > > =20
> > > +/*
> > > + * Like sync_rcu_preempt_exp_done(), but this function assumes the c=
aller
> > > + * doesn't hold the rcu_node's ->lock, and will acquire and release =
the lock
> > > + * itself
> > > + */
> > > +static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
> > > +{
> > > +	unsigned long flags;
> > > +	bool ret;
> > > +
> > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > +	ret =3D sync_rcu_preempt_exp_done(rnp);
> >=20
> > Let's see...  The sync_rcu_preempt_exp_done() function checks the
> > ->exp_tasks pointer and the ->expmask bitmask.  The number of bits in t=
he
> > mask can only decrease, and the ->exp_tasks pointer can only transition
> > from NULL to non-NULL when there is at least one bit set.  However,
> > there is no ordering in sync_rcu_preempt_exp_done(), so it is possible
> > that it could be fooled without the lock:
> >=20
> > o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
> > 	sees that it is NULL.
> >=20
> > o	CPU 1 blocks within an RCU read-side critical section, so
> > 	it enqueues the task and points ->exp_tasks at it and
> > 	clears CPU 1's bit in ->expmask.
> >=20
> > o	All other CPUs clear their bits in ->expmask.
> >=20
> > o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
> > 	concludes that all quiescent states have completed, despite
> > 	the fact that ->exp_tasks is non-NULL.
> >=20
> > So it seems to me that the lock is needed.  Good catch!!!  The problem
> > would occur only if the task running on CPU 0 received a spurious
> > wakeup, but that could potentially happen.
> >=20
>=20
> Thanks for the analysis ;-)
>=20
> > If lock contention becomes a problem, memory-ordering tricks could be
> > applied, but the lock is of course simpler.
> >=20
>=20
> Agreed.
>=20
> > I am guessing that this is a prototype patch, and that you are planning
>=20
> Yes, this is a prototype. And I'm preparing a proper patch to send
> later.
>=20
> > to add lockdep annotations in more places, but either way please let
> > me know.
> >=20
>=20
> Give it's a bug as per your analysis, I'd like to defer other lockdep
> annotations and send this first. However, I'm currently getting other
> lockdep splats after applying this, so I need to get that sorted first.
>=20

Hmm.. the other lockdep splat seems irrelevant with my patch, I could
observe it on mainline using rcutorture with CONFIG_PROVE_LOCKING=3Dy. I'd
spend some more time on it, in the meanwhile, send a proper patch for
this sync_rcu_preempt_exp_done().

Regards,
Boqun

> Regards,
> Boqun
>=20
> > 						Thanx, Paul
> >=20
> > > +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +
> > >  /*
> > >   * Report the exit from RCU read-side critical section for the last =
task
> > >   * that queued itself during or before the current expedited preempt=
ible-RCU
> > > @@ -490,6 +512,7 @@ static void synchronize_sched_expedited_wait(stru=
ct rcu_state *rsp)
> > >  	struct rcu_node *rnp;
> > >  	struct rcu_node *rnp_root =3D rcu_get_root(rsp);
> > >  	int ret;
> > > +	unsigned long flags;
> > > =20
> > >  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), T=
PS("startwait"));
> > >  	jiffies_stall =3D rcu_jiffies_till_stall_check();
> > > @@ -498,9 +521,9 @@ static void synchronize_sched_expedited_wait(stru=
ct rcu_state *rsp)
> > >  	for (;;) {
> > >  		ret =3D swait_event_timeout(
> > >  				rsp->expedited_wq,
> > > -				sync_rcu_preempt_exp_done(rnp_root),
> > > +				sync_rcu_preempt_exp_done_unlocked(rnp_root),
> > >  				jiffies_stall);
> > > -		if (ret > 0 || sync_rcu_preempt_exp_done(rnp_root))
> > > +		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
> > >  			return;
> > >  		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
> > >  		if (rcu_cpu_stall_suppress)
> > > @@ -533,8 +556,14 @@ static void synchronize_sched_expedited_wait(str=
uct rcu_state *rsp)
> > >  			rcu_for_each_node_breadth_first(rsp, rnp) {
> > >  				if (rnp =3D=3D rnp_root)
> > >  					continue; /* printed unconditionally */
> > > -				if (sync_rcu_preempt_exp_done(rnp))
> > > +
> > > +				raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > +				if (sync_rcu_preempt_exp_done(rnp)) {
> > > +					raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  					continue;
> > > +				}
> > > +				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > +
> > >  				pr_cont(" l=3D%u:%d-%d:%#lx/%c",
> > >  					rnp->level, rnp->grplo, rnp->grphi,
> > >  					rnp->expmask,
> > > --=20
> > > 2.16.2
> > >=20
> >=20
> >=20



--xclsvex53f4dd3zp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqg9IsACgkQSXnow7UH
+riinggAidt3TcIAKTxbFjZ4rBP7nE2s/xai6pCnyQDaBJMfAUf5A2vgtz/3PX5I
kp5aCFGeTI4GsiPoyoK+iiA2s9Cwa8ytKALt9rsLGL8MH+Th8jf7etJ7ghLc5Qsv
tdtKPe0xBX/GLjV3v7TS27+XpCfcGbJtxFrHRZuvmFYSIb0JlMIzPMoDvCBtp4Ec
bDU52o64p2GRxt+pwy9jjWV1Vkne0jSkWLAaphM3eoMNsWnT0VxPT5ijpkrkaSvg
R603/4LKHBc/iXLK4kLgq4Xa79cBtDndrxQhEQkyLVSQPwlvyxuMPKf0FrEv6oZg
oFQnVAA3PNx3XuZXHoDveWxI6NgY1A==
=36o9
-----END PGP SIGNATURE-----

--xclsvex53f4dd3zp--
