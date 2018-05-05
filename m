Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEELX4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:23:56 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36045 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEELXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:23:54 -0400
X-Google-Smtp-Source: AB8JxZrkfzN1jjImVgqyyk2AQnjdS9P8f6HkyrmL8qLwoz9exYJ/e2twNoLdDanNFHqfQj6ebqNQIA==
X-ME-Sender: <xms:R5TtWh4Pj-1pMz36UsW8SBTaKB2MtvPER2wgov2hrOs4oxCHQrNFkQ>
Date: Sat, 5 May 2018 19:28:17 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: Re: [RFC PATCH] locking/atomics/powerpc: Clarify why the
 cmpxchg_relaxed() family of APIs falls back to full cmpxchg()
Message-ID: <20180505112817.ihrb726i37bwm4cj@tardis>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
 <20180505103550.s7xsnto7tgppkmle@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2iswuugrxkyo4hcv"
Content-Disposition: inline
In-Reply-To: <20180505103550.s7xsnto7tgppkmle@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2iswuugrxkyo4hcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 12:35:50PM +0200, Ingo Molnar wrote:
>=20
> * Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> > On Sat, May 05, 2018 at 11:38:29AM +0200, Ingo Molnar wrote:
> > >=20
> > > * Ingo Molnar <mingo@kernel.org> wrote:
> > >=20
> > > > * Peter Zijlstra <peterz@infradead.org> wrote:
> > > >=20
> > > > > > So we could do the following simplification on top of that:
> > > > > >=20
> > > > > >  #ifndef atomic_fetch_dec_relaxed
> > > > > >  # ifndef atomic_fetch_dec
> > > > > >  #  define atomic_fetch_dec(v)		atomic_fetch_sub(1, (v))
> > > > > >  #  define atomic_fetch_dec_relaxed(v)	atomic_fetch_sub_relaxed=
(1, (v))
> > > > > >  #  define atomic_fetch_dec_acquire(v)	atomic_fetch_sub_acquire=
(1, (v))
> > > > > >  #  define atomic_fetch_dec_release(v)	atomic_fetch_sub_release=
(1, (v))
> > > > > >  # else
> > > > > >  #  define atomic_fetch_dec_relaxed		atomic_fetch_dec
> > > > > >  #  define atomic_fetch_dec_acquire		atomic_fetch_dec
> > > > > >  #  define atomic_fetch_dec_release		atomic_fetch_dec
> > > > > >  # endif
> > > > > >  #else
> > > > > >  # ifndef atomic_fetch_dec
> > > > > >  #  define atomic_fetch_dec(...)		__atomic_op_fence(atomic_fetc=
h_dec, __VA_ARGS__)
> > > > > >  #  define atomic_fetch_dec_acquire(...)	__atomic_op_acquire(at=
omic_fetch_dec, __VA_ARGS__)
> > > > > >  #  define atomic_fetch_dec_release(...)	__atomic_op_release(at=
omic_fetch_dec, __VA_ARGS__)
> > > > > >  # endif
> > > > > >  #endif
> > > > >=20
> > > > > This would disallow an architecture to override just fetch_dec_re=
lease for
> > > > > instance.
> > > >=20
> > > > Couldn't such a crazy arch just define _all_ the 3 APIs in this gro=
up?
> > > > That's really a small price and makes the place pay the complexity
> > > > price that does the weirdness...
> > > >=20
> > > > > I don't think there currently is any architecture that does that,=
 but the
> > > > > intent was to allow it to override anything and only provide defa=
ults where it
> > > > > does not.
> > > >=20
> > > > I'd argue that if a new arch only defines one of these APIs that's =
probably a bug.=20
> > > > If they absolutely want to do it, they still can - by defining all =
3 APIs.
> > > >=20
> > > > So there's no loss in arch flexibility.
> > >=20
> > > BTW., PowerPC for example is already in such a situation, it does not=
 define=20
> > > atomic_cmpxchg_release(), only the other APIs:
> > >=20
> > > #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
> > > #define atomic_cmpxchg_relaxed(v, o, n) \
> > > 	cmpxchg_relaxed(&((v)->counter), (o), (n))
> > > #define atomic_cmpxchg_acquire(v, o, n) \
> > > 	cmpxchg_acquire(&((v)->counter), (o), (n))
> > >=20
> > > Was it really the intention on the PowerPC side that the generic code=
 falls back=20
> > > to cmpxchg(), i.e.:
> > >=20
> > > #  define atomic_cmpxchg_release(...)           __atomic_op_release(a=
tomic_cmpxchg, __VA_ARGS__)
> > >=20
> >=20
> > So ppc has its own definition __atomic_op_release() in
> > arch/powerpc/include/asm/atomic.h:
> >=20
> > 	#define __atomic_op_release(op, args...)				\
> > 	({									\
> > 		__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
> > 		op##_relaxed(args);						\
> > 	})
> >=20
> > , and PPC_RELEASE_BARRIER is lwsync, so we map to
> >=20
> > 	lwsync();
> > 	atomic_cmpxchg_relaxed(v, o, n);
> >=20
> > And the reason, why we don't define atomic_cmpxchg_release() but define
> > atomic_cmpxchg_acquire() is that, atomic_cmpxchg_*() could provide no
> > ordering guarantee if the cmp fails, we did this for
> > atomic_cmpxchg_acquire() but not for atomic_cmpxchg_release(), because
> > doing so may introduce a memory barrier inside a ll/sc critical section,
> > please see the comment before __cmpxchg_u32_acquire() in
> > arch/powerpc/include/asm/cmpxchg.h:
> >=20
> > 	/*
> > 	 * cmpxchg family don't have order guarantee if cmp part fails, theref=
ore we
> > 	 * can avoid superfluous barriers if we use assembly code to implement
> > 	 * cmpxchg() and cmpxchg_acquire(), however we don't do the similar for
> > 	 * cmpxchg_release() because that will result in putting a barrier in =
the
> > 	 * middle of a ll/sc loop, which is probably a bad idea. For example, =
this
> > 	 * might cause the conditional store more likely to fail.
> > 	 */
>=20
> Makes sense, thanks a lot for the explanation, missed that comment in the=
 middle=20
> of the assembly functions!
>=20

;-) I could move it so somewhere else in the future.

> So the patch I sent is buggy, please disregard it.
>=20
> May I suggest the patch below? No change in functionality, but it documen=
ts the=20
> lack of the cmpxchg_release() APIs and maps them explicitly to the full c=
mpxchg()=20
> version. (Which the generic code does now in a rather roundabout way.)
>=20

Hmm.. cmpxchg_release() is actually lwsync() + cmpxchg_relaxed(), but
you just make it sync() + cmpxchg_relaxed() + sync() with the fallback,
and sync() is much heavier, so I don't think the fallback is correct.

I think maybe you can move powerpc's __atomic_op_{acqurie,release}()
=66rom atomic.h to cmpxchg.h (in arch/powerpc/include/asm), and

	#define cmpxchg_release __atomic_op_release(cmpxchg, __VA_ARGS__);
	#define cmpxchg64_release __atomic_op_release(cmpxchg64, __VA_ARGS__);

I put a diff below to say what I mean (untested).

> Also, the change to arch/powerpc/include/asm/atomic.h has no functional e=
ffect=20
> right now either, but should anyone add a _relaxed() variant in the futur=
e, with=20
> this change atomic_cmpxchg_release() and atomic64_cmpxchg_release() will =
pick that=20
> up automatically.
>=20

You mean with your other modification in include/linux/atomic.h, right?
Because with the unmodified include/linux/atomic.h, we already pick that
autmatically. If so, I think that's fine.

Here is the diff for the modification for cmpxchg_release(), the idea is
we generate them in asm/cmpxchg.h other than linux/atomic.h for ppc, so
we keep the new linux/atomic.h working. Because if I understand
correctly, the next linux/atomic.h only accepts that

1)	architecture only defines fully ordered primitives

or

2)	architecture only defines _relaxed primitives

or

3)	architecture defines all four (fully, _relaxed, _acquire,
	_release) primitives

So powerpc needs to define all four primitives in its only
asm/cmpxchg.h.

Regards,
Boqun

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/a=
tomic.h
index 682b3e6a1e21..0136be11c84f 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -13,24 +13,6 @@
=20
 #define ATOMIC_INIT(i)		{ (i) }
=20
-/*
- * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
- * a "bne-" instruction at the end, so an isync is enough as a acquire bar=
rier
- * on the platform without lwsync.
- */
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
-	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
-	op##_relaxed(args);						\
-})
-
 static __inline__ int atomic_read(const atomic_t *v)
 {
 	int t;
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/=
cmpxchg.h
index 9b001f1f6b32..9e20a942aff9 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -8,6 +8,24 @@
 #include <asm/asm-compat.h>
 #include <linux/bug.h>
=20
+/*
+ * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
+ * a "bne-" instruction at the end, so an isync is enough as a acquire bar=
rier
+ * on the platform without lwsync.
+ */
+#define __atomic_op_acquire(op, args...)				\
+({									\
+	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
+	__ret;								\
+})
+
+#define __atomic_op_release(op, args...)				\
+({									\
+	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
+	op##_relaxed(args);						\
+})
+
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
 #else
@@ -512,6 +530,8 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigne=
d long new,
 			(unsigned long)_o_, (unsigned long)_n_,		\
 			sizeof(*(ptr)));				\
 })
+
+#define cmpxchg_release(ptr, o, n) __atomic_op_release(cmpxchg, __VA_ARGS_=
_)
 #ifdef CONFIG_PPC64
 #define cmpxchg64(ptr, o, n)						\
   ({									\
@@ -533,6 +553,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigne=
d long new,
 	BUILD_BUG_ON(sizeof(*(ptr)) !=3D 8);				\
 	cmpxchg_acquire((ptr), (o), (n));				\
 })
+#define cmpxchg64_release(ptr, o, n) __atomic_op_release(cmpxchg64, __VA_A=
RGS__)
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (=
n))

--2iswuugrxkyo4hcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrtlU4ACgkQSXnow7UH
+rj20Qf9EdsDMz1pYhUevokUpcINCw5RZlOfJ1MG/rsfi1/I0d+6B1hhyUsJKM8V
rzH0cYH2Z9lGvlGnG0JwBaocV11e6gtJif+t6IbW+KCH5BVKNWdz83QAgSdDyKw9
6IIn5qmt7HPxuW3ezZXZIcjZ8230dDauN0q+bhLjKbfqYvDo9iTbo+tifB9v4OrD
bHA6Dp/y1IQn7lvlotqpyAVZC1YgQZkugGae+rmGbfuI+KSfV7BniW96wRYrwRYm
AnutV4nrwGCh41+FaEQX+KOHXaPnealpxQN0uHld2Beymlnpa0y9umWgcdAJR4vt
9STFtDsIfKf9OSdnOls8Da9Tiejgiw==
=l0yj
-----END PGP SIGNATURE-----

--2iswuugrxkyo4hcv--
