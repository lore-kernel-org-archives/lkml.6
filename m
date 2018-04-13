Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeDMNUf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:20:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39197 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753507AbeDMNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:20:33 -0400
X-Google-Smtp-Source: AIpwx49MrrRBdy8Rycl5OqhH+0LfzQoRMjPj1SfpIct3B/nM/+0y2GAqVsr9m+TzWdn0WrOFLbkEZw==
X-ME-Sender: <xms:nK7QWqyem4EAilAaTJfXdUOI72jAN9GyUd3-VoJeeEy42H7MZXLJIQ>
Date: Fri, 13 Apr 2018 21:24:44 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC tip/locking/lockdep v6 19/20] rcu: Equip sleepable RCU with
 lockdep dependency graph checks
Message-ID: <20180413132444.wb2liczapxxizrne@tardis>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
 <20180411135647.21496-1-boqun.feng@gmail.com>
 <20180411185730.GU3948@linux.vnet.ibm.com>
 <20180412021233.ewncg5jjuzjw3x62@tardis>
 <20180412091217.GY4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="daajw7nzooe3mxat"
Content-Disposition: inline
In-Reply-To: <20180412091217.GY4082@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--daajw7nzooe3mxat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 11:12:17AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 12, 2018 at 10:12:33AM +0800, Boqun Feng wrote:
> > A trivial fix/hack would be adding local_irq_disable() and
> > local_irq_enable() around srcu_lock_sync() like:
> >=20
> > 	static inline void srcu_lock_sync(struct lockdep_map *map)
> > 	{
> > 		local_irq_disable();
> > 		lock_map_acquire(map);
> > 		lock_map_release(map);
> > 		local_irq_enable();
> > 	}
> >=20
> > However, it might be better, if lockdep could provide some annotation
> > API for such an empty critical section to say the grap-and-drop is
> > atomic. Something like:
> >=20
> > 	/*
> > 	 * Annotate a wait point for all previous critical section to
> > 	 * go out.
> > 	 *=20
> > 	 * This won't make @map a irq unsafe lock, no matter it's called
> > 	 * w/ or w/o irq disabled.
> > 	 */
> > 	lock_wait_unlock(struct lockdep_map *map, ..)
> >=20
> > And in this primitive, we do something similar like
> > lock_acquire()+lock_release(). This primitive could be used elsewhere,
> > as I bebieve we have several empty grab-and-drop critical section for
> > lockdep annotations, e.g. in start_flush_work().
> >=20
> > Thoughts?
> >=20
> > This cerntainly requires a bit more work, in the meanwhile, I will add
> > another self testcase which has a srcu_read_lock() called in irq.
>=20
> Yeah, I've never really bothered to clean those things up, but I don't
> see any reason to stop you from doing it ;-)
>=20
> As to the initial pattern with disabling IRQs, I think I've seen code
> like that before, and in general performance isn't a top priority

Yeah, I saw we used that pattern in del_timer_sync()

> (within reason) when you're running lockdep kernels, so I've usually let
> it be.

Turns out it's not very hard to write a working version of
lock_wait_unlock() ;-) Just call __lock_acquire() and __lock_release()
back-to-back with the @hardirqoff for __lock_acquire() to be 1:

	/*
	 * lock_sync() - synchronize with all previous critical sections to finish.
	 *
	 * Simply a acquire+release annotation with hardirqoff is true, because no=
 lock
	 * is actually held, so this annotaion alone is safe to be interrupted as =
if
	 * irqs are off
	 */
	void lock_sync(struct lockdep_map *lock, unsigned subclass, int read,
		       int check, struct lockdep_map *nest_lock, unsigned long ip)
	{
		unsigned long flags;

		if (unlikely(current->lockdep_recursion))
			return;

		raw_local_irq_save(flags);
		check_flags(flags);

		current->lockdep_recursion =3D 1;
		__lock_acquire(lock, subclass, 0, read, check, 1, nest_lock, ip, 0, 0);
		if (__lock_release(lock, 0, ip))
			check_chain_key(current);

		current->lockdep_recursion =3D 0;
		raw_local_irq_restore(flags);
	}
	EXPORT_SYMBOL_GPL(lock_sync);

I rename as lock_sync(), because most of the time, we annotate with this
for a "sync point" with other critical sections. We can avoid some
overhead if we refactor __lock_acquire() and __lock_release() with some
helper functions, but I think this version is good enough for now, at
least better than disabling IRQs around lock_map_acquire() +
lock_map_release() ;-)

Thoughts?

Regards,
Boqun


--daajw7nzooe3mxat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrQr5gACgkQSXnow7UH
+rjwTAf/d2oiJk8R5Rc/5yGOs7wHBCXksrQpfCTg/0lmcGzF/Xco9BCmmuav5bCg
kj5qfEPID0beQcbhXuPDeajsbdrsb/b8LLlwjO5VGi2XSH8tiSzSbjUTQ/97+n6n
n0bFnEd2eCjHYK/KWuCs0Y8R3Ink7BhvBf4pbZdjKK34GATA/7sUqxOzdQ0Mu5HS
6ygTKvZMM6XZetlI8A0anWvtgwQPBiHz3Kdy7wA3XeTzFLkrnMJ9KJB/I1ysXDm2
H5oB60W6Qu7gxYptGIKfuzj1Lq/FQ1Qmx6dMEH5K6bk/HhGHenRdkoVLt0CLMaSb
puvgtnTmnsOCeuwBa5q1nd7sNKq+zQ==
=2D6C
-----END PGP SIGNATURE-----

--daajw7nzooe3mxat--
