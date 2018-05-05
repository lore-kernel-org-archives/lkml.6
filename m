Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeEEKLs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:11:48 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41853 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:11:46 -0400
X-Google-Smtp-Source: AB8JxZroiA+u4B8PBOtkAR7NKabOVgaEVqOpjGwoqTF2uB4ulS7n3VGB+AvoPzKIDlmtK0Ridqcdiw==
X-ME-Sender: <xms:X4PtWmydH0tTjqBNjy9RWMNESDj5242HlsG0ahimaIQKXOcJS4Nsxw>
Date: Sat, 5 May 2018 18:16:09 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
Message-ID: <20180505101609.5wb56j4mspjkokmw@tardis>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="46lmvgfbnthzcywx"
Content-Disposition: inline
In-Reply-To: <20180505093829.xfylnedwd5nonhae@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--46lmvgfbnthzcywx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 11:38:29AM +0200, Ingo Molnar wrote:
>=20
> * Ingo Molnar <mingo@kernel.org> wrote:
>=20
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> >=20
> > > > So we could do the following simplification on top of that:
> > > >=20
> > > >  #ifndef atomic_fetch_dec_relaxed
> > > >  # ifndef atomic_fetch_dec
> > > >  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
> > > >  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed(1, =
(v))
> > > >  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire(1, =
(v))
> > > >  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release(1, =
(v))
> > > >  # else
> > > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > > >  # endif
> > > >  #else
> > > >  # ifndef atomic_fetch_dec
> > > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetch_de=
c, __VA_ARGS__)
> > > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(atomic=
_fetch_dec, __VA_ARGS__)
> > > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(atomic=
_fetch_dec, __VA_ARGS__)
> > > >  # endif
> > > >  #endif
> > >=20
> > > This would disallow an architecture to override just fetch_dec_releas=
e for
> > > instance.
> >=20
> > Couldn't such a crazy arch just define _all_ the 3 APIs in this group?
> > That's really a small price and makes the place pay the complexity
> > price that does the weirdness...
> >=20
> > > I don't think there currently is any architecture that does that, but=
 the
> > > intent was to allow it to override anything and only provide defaults=
 where it
> > > does not.
> >=20
> > I'd argue that if a new arch only defines one of these APIs that's prob=
ably a bug.=20
> > If they absolutely want to do it, they still can - by defining all 3 AP=
Is.
> >=20
> > So there's no loss in arch flexibility.
>=20
> BTW., PowerPC for example is already in such a situation, it does not def=
ine=20
> atomic_cmpxchg_release(), only the other APIs:
>=20
> #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
> #define atomic_cmpxchg_relaxed(v, o, n) \
> 	cmpxchg_relaxed(&((v)->counter), (o), (n))
> #define atomic_cmpxchg_acquire(v, o, n) \
> 	cmpxchg_acquire(&((v)->counter), (o), (n))
>=20
> Was it really the intention on the PowerPC side that the generic code fal=
ls back=20
> to cmpxchg(), i.e.:
>=20
> #  define atomic_cmpxchg_release(...)           __atomic_op_release(atomi=
c_cmpxchg, __VA_ARGS__)
>=20

So ppc has its own definition __atomic_op_release() in
arch/powerpc/include/asm/atomic.h:

	#define __atomic_op_release(op, args...)				\
	({									\
		__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
		op##_relaxed(args);						\
	})

, and PPC_RELEASE_BARRIER is lwsync, so we map to

	lwsync();
	atomic_cmpxchg_relaxed(v, o, n);

And the reason, why we don't define atomic_cmpxchg_release() but define
atomic_cmpxchg_acquire() is that, atomic_cmpxchg_*() could provide no
ordering guarantee if the cmp fails, we did this for
atomic_cmpxchg_acquire() but not for atomic_cmpxchg_release(), because
doing so may introduce a memory barrier inside a ll/sc critical section,
please see the comment before __cmpxchg_u32_acquire() in
arch/powerpc/include/asm/cmpxchg.h:

	/*
	 * cmpxchg family don't have order guarantee if cmp part fails, therefore =
we
	 * can avoid superfluous barriers if we use assembly code to implement
	 * cmpxchg() and cmpxchg_acquire(), however we don't do the similar for
	 * cmpxchg_release() because that will result in putting a barrier in the
	 * middle of a ll/sc loop, which is probably a bad idea. For example, this
	 * might cause the conditional store more likely to fail.
	 */

Regards,
Boqun


> Which after macro expansion becomes:
>=20
> 	smp_mb__before_atomic();
> 	atomic_cmpxchg_relaxed(v, o, n);
>=20
> smp_mb__before_atomic() on PowerPC falls back to the generic __smp_mb(), =
which=20
> falls back to mb(), which on PowerPC is the 'sync' instruction.
>=20
> Isn't this a inefficiency bug?
>=20
> While I'm pretty clueless about PowerPC low level cmpxchg atomics, they a=
ppear to=20
> have the following basic structure:
>=20
> full cmpxchg():
>=20
> 	PPC_ATOMIC_ENTRY_BARRIER # sync
> 	ldarx + stdcx
> 	PPC_ATOMIC_EXIT_BARRIER  # sync
>=20
> cmpxchg_relaxed():
>=20
> 	ldarx + stdcx
>=20
> cmpxchg_acquire():
>=20
> 	ldarx + stdcx
> 	PPC_ACQUIRE_BARRIER      # lwsync
>=20
> The logical extension for cmpxchg_release() would be:
>=20
> cmpxchg_release():
>=20
> 	PPC_RELEASE_BARRIER      # lwsync
> 	ldarx + stdcx
>=20
> But instead we silently get the generic fallback, which does:
>=20
> 	smp_mb__before_atomic();
> 	atomic_cmpxchg_relaxed(v, o, n);
>=20
> Which maps to:
>=20
> 	sync
> 	ldarx + stdcx
>=20
> Note that it uses a full barrier instead of lwsync (does that stand for=
=20
> 'lightweight sync'?).
>=20
> Even if it turns out we need the full barrier, with the overly finegraine=
d=20
> structure of the atomics this detail is totally undocumented and non-obvi=
ous.
>=20
> Thanks,
>=20
> 	Ingo

--46lmvgfbnthzcywx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrthGYACgkQSXnow7UH
+rhBBwf+O8n+9mXYGlMSnV/abToUz8WiRyzrngOJnBqwCAqnVQmEfGzMBEvh6pNU
UetaAk/irO1mi30ldVlEaYODWOmL4IJS5N0WDydV8cQ6BYzBs/rlvDBCjCdmXOaL
6Rd4cVciMpwbFMOBoDfix+fRAQE4TpjC09KQNzmCb4zYsPWrhRzLPsz2to0c+sQ8
gTLYNK350kH6Xv9JV8kg4594Ef8rpzx7EE16Wt6PsPbB/PBStcxz4YIM01ZwgTeM
LlouyB/Zu4uOyPYld6gnXcp3Xon0G7IBhlNLJUt1RqM8Dgw2k7gC5iwpYRxJ688D
hISRfAFtyNCpkENY/9jYdnUVNNzkRg==
=u+QW
-----END PGP SIGNATURE-----

--46lmvgfbnthzcywx--
