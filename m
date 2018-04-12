Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeDLCI0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 22:08:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54924 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDLCIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 22:08:24 -0400
X-Google-Smtp-Source: AIpwx49nDKBNO4eXrKROVIovabW0rQpAgqCdPcxhnL22nrjs0U9BWKnk1ipAY7EdthcJTPlHJUrL8w==
X-ME-Sender: <xms:k7_OWhXrrpzieB_JxWssAuhwse6ASmpkC0az1bU-OMrERVUj1t8Bww>
Date: Thu, 12 Apr 2018 10:12:33 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Andrea Parri <parri.andrea@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC tip/locking/lockdep v6 19/20] rcu: Equip sleepable RCU with
 lockdep dependency graph checks
Message-ID: <20180412021233.ewncg5jjuzjw3x62@tardis>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
 <20180411135647.21496-1-boqun.feng@gmail.com>
 <20180411185730.GU3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7ivliwxqub6kddu"
Content-Disposition: inline
In-Reply-To: <20180411185730.GU3948@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7ivliwxqub6kddu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 11:57:30AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 11, 2018 at 09:56:44PM +0800, Boqun Feng wrote:
> > Although all flavors of RCU are annotated correctly with lockdep
> > annotations as recursive read locks, the 'check' parameter for their
> > calls to lock_acquire() is unset. Which means RCU read locks are not
> > added into the lockdep dependency graph. This is fine for all flavors
> > except sleepable RCU, because the deadlock scenarios for them are
> > simple: calling synchronize_rcu() and its friends inside their read-side
> > critical sections. But for sleepable RCU, as there may be multiple
> > instances with multiple classes, there are more deadlock cases.
> > Considering the following:
> >=20
> > 	TASK 1				TASK 2
> > 	=3D=3D=3D=3D=3D=3D=3D				=3D=3D=3D=3D=3D=3D=3D=3D
> > 	i =3D srcu_read_lock(&sa);	i =3D srcu_read_lock(&sb);
> > 	synchronize_srcu(&sb);		synchronize_srcu(&sa);
> > 	srcu_read_unlock(&sa);		srcu_read_unlock(&sb);
> >=20
> > Neither TASK 1 or 2 could go out of the read-side critical sections,
> > because they are waiting for each other at synchronize_srcu().
> >=20
> > With the new improvement for lockdep, which allows us to detect
> > deadlocks for recursive read locks, we can actually detect this. What we
> > need to do are simply: a) mark srcu_read_{,un}lock() as 'check'
> > lock_acquire() and b) annotate synchronize_srcu() as a empty
> > grab-and-drop for a write lock (because synchronize_srcu() will wait for
> > previous srcu_read_lock() to release, and won't block the next
> > srcu_read_lock(), just like a empty write lock section).
> >=20
> > This patch adds those to allow we check deadlocks related to sleepable
> > RCU with lockdep.
> >=20
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>=20
> Very cool!
>=20
> One question though...  Won't this report a false-positive self-deadlock =
if
> srcu_read_lock() is invoked from an interrupt handler?
>=20

Ah.. right. And the false-positive happens because synchronize_srcu() is
annotated as a irq-write-unsafe lock, which should be fixed because
synchronize_srcu() doesn't block a srcu_read_lock() and the empty
write lock critical section in srcu_lock_sync() should mean the
grab-and-drop is atomic (i.e. no one could interrupt), therefore no irq
inversion problem.

A trivial fix/hack would be adding local_irq_disable() and
local_irq_enable() around srcu_lock_sync() like:

	static inline void srcu_lock_sync(struct lockdep_map *map)
	{
		local_irq_disable();
		lock_map_acquire(map);
		lock_map_release(map);
		local_irq_enable();
	}

However, it might be better, if lockdep could provide some annotation
API for such an empty critical section to say the grap-and-drop is
atomic. Something like:

	/*
	 * Annotate a wait point for all previous critical section to
	 * go out.
	 *=20
	 * This won't make @map a irq unsafe lock, no matter it's called
	 * w/ or w/o irq disabled.
	 */
	lock_wait_unlock(struct lockdep_map *map, ..)

And in this primitive, we do something similar like
lock_acquire()+lock_release(). This primitive could be used elsewhere,
as I bebieve we have several empty grab-and-drop critical section for
lockdep annotations, e.g. in start_flush_work().

Thoughts?

This cerntainly requires a bit more work, in the meanwhile, I will add
another self testcase which has a srcu_read_lock() called in irq.
Thanks!

Regards,
Boqun

> 							Thanx, Paul
>=20
> > ---
> >  include/linux/srcu.h  | 51 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  kernel/rcu/srcutiny.c |  2 ++
> >  kernel/rcu/srcutree.c |  2 ++
> >  3 files changed, 53 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 33c1c698df09..23f397bd192c 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -99,6 +99,49 @@ static inline int srcu_read_lock_held(const struct s=
rcu_struct *sp)
> >  	return lock_is_held(&sp->dep_map);
> >  }
> >=20
> > +/**
> > + * lockdep annotations for srcu_read_{un,}lock, and synchronize_srcu():
> > + *
> > + * srcu_read_lock() and srcu_read_unlock() are similar to rcu_read_loc=
k() and
> > + * rcu_read_unlock(), they are recursive read locks. But we mark them =
as
> > + * "check", they will be added into lockdep dependency graph for deadl=
ock
> > + * detection. And we also annotate synchronize_srcu() as a
> > + * write_lock()+write_unlock(), because synchronize_srcu() will wait f=
or any
> > + * corresponding previous srcu_read_lock() to release, and that acts l=
ike a
> > + * empty grab-and-drop write lock.
> > + *
> > + * We do so because multiple sleepable rcu instances may cause deadloc=
k as
> > + * follow:
> > + *
> > + *   Task 1:
> > + *     ia =3D srcu_read_lock(&srcu_A);
> > + *     synchronize_srcu(&srcu_B);
> > + *     srcu_read_unlock(&srcu_A, ia);
> > + *
> > + *   Task 2:
> > + *     ib =3D srcu_read_lock(&srcu_B);
> > + *     synchronize_srcu(&srcu_A);
> > + *     srcu_read_unlock(&srcu_B, ib);
> > + *
> > + * And we want lockdep to detect this or more complicated deadlock wit=
h SRCU
> > + * involved.
> > + */
> > +static inline void srcu_lock_acquire(struct lockdep_map *map)
> > +{
> > +	lock_map_acquire_read(map);
> > +}
> > +
> > +static inline void srcu_lock_release(struct lockdep_map *map)
> > +{
> > +	lock_map_release(map);
> > +}
> > +
> > +static inline void srcu_lock_sync(struct lockdep_map *map)
> > +{
> > +	lock_map_acquire(map);
> > +	lock_map_release(map);
> > +}
> > +
> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> >=20
> >  static inline int srcu_read_lock_held(const struct srcu_struct *sp)
> > @@ -106,6 +149,10 @@ static inline int srcu_read_lock_held(const struct=
 srcu_struct *sp)
> >  	return 1;
> >  }
> >=20
> > +#define srcu_lock_acquire(m)	do { } while (0)
> > +#define srcu_lock_release(m)	do { } while (0)
> > +#define srcu_lock_sync(m)	do { } while (0)
> > +
> >  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> >=20
> >  /**
> > @@ -157,7 +204,7 @@ static inline int srcu_read_lock(struct srcu_struct=
 *sp) __acquires(sp)
> >  	int retval;
> >=20
> >  	retval =3D __srcu_read_lock(sp);
> > -	rcu_lock_acquire(&(sp)->dep_map);
> > +	srcu_lock_acquire(&(sp)->dep_map);
> >  	return retval;
> >  }
> >=20
> > @@ -171,7 +218,7 @@ static inline int srcu_read_lock(struct srcu_struct=
 *sp) __acquires(sp)
> >  static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
> >  	__releases(sp)
> >  {
> > -	rcu_lock_release(&(sp)->dep_map);
> > +	srcu_lock_release(&(sp)->dep_map);
> >  	__srcu_read_unlock(sp, idx);
> >  }
> >=20
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 76ac5f50b2c7..bc89cb48d800 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -188,6 +188,8 @@ void synchronize_srcu(struct srcu_struct *sp)
> >  {
> >  	struct rcu_synchronize rs;
> >=20
> > +	srcu_lock_sync(&sp->dep_map);
> > +
> >  	init_rcu_head_on_stack(&rs.head);
> >  	init_completion(&rs.completion);
> >  	call_srcu(sp, &rs.head, wakeme_after_rcu);
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index d5cea81378cc..e2628e9275b9 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -997,6 +997,8 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
> >   */
> >  void synchronize_srcu(struct srcu_struct *sp)
> >  {
> > +	srcu_lock_sync(&sp->dep_map);
> > +
> >  	if (srcu_might_be_idle(sp) || rcu_gp_is_expedited())
> >  		synchronize_srcu_expedited(sp);
> >  	else
> > --=20
> > 2.16.2
> >=20
>=20

--w7ivliwxqub6kddu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrOwI4ACgkQSXnow7UH
+rjp8Af+KO+DVdv3qtHIPJY4dhU19fZMMAxHD2DO+Eoq8jHyRisJ5uo5ecMq0XAl
7wNofmGHD2QFW0G+wMRVXTs07DmOb2T2Pmx+T5YVU4FAuzQ8DPpj/QBV9sMHNypt
uGR81gBymFj86uW90hYizzMm34z2X9P/Yhq3qqjc5u0vo/L12wYPvfysalbhPjxA
RFF5OH6ruQ9LUnNs5hpE4A5yQwsehdXSmrbkovBOlLmd36RmzxGkcLohe10D7GBC
4o5SinuhVHl14sv+l2C6LdfEGAp2zjUIrI6xAlSZF22RTLHOe31+JTqLr07d4OlM
WKS/B604GKPAGUy+25b6K9VaQ4AxZw==
=hfpL
-----END PGP SIGNATURE-----

--w7ivliwxqub6kddu--
