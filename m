Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEEN7X (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 09:59:23 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43605 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeEEN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 09:59:19 -0400
X-Google-Smtp-Source: AB8JxZqXqlZPf0UQOGrshb33uMUL7eUGsSqvsDN1pymMxRFsKNgDm9+LB5hljS6xN+F/8faKYAsoAw==
X-ME-Sender: <xms:tLjtWuvCLqRqz6jiAtNQloieXd7F3PF08sY7bxtimOipmKQw-ltlew>
Date: Sat, 5 May 2018 22:03:40 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to
 asm/cmpxchg.h and define the full set of cmpxchg APIs
Message-ID: <20180505140340.uzfhoc42xvas4m72@tardis>
References: <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
 <20180505103550.s7xsnto7tgppkmle@gmail.com>
 <20180505112817.ihrb726i37bwm4cj@tardis>
 <20180505132751.gwzu2vbzibr2risd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wv5ky4rhnqtz72k7"
Content-Disposition: inline
In-Reply-To: <20180505132751.gwzu2vbzibr2risd@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wv5ky4rhnqtz72k7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 03:27:51PM +0200, Ingo Molnar wrote:
>=20
> * Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> > > May I suggest the patch below? No change in functionality, but it doc=
uments the=20
> > > lack of the cmpxchg_release() APIs and maps them explicitly to the fu=
ll cmpxchg()=20
> > > version. (Which the generic code does now in a rather roundabout way.)
> > >=20
> >=20
> > Hmm.. cmpxchg_release() is actually lwsync() + cmpxchg_relaxed(), but
> > you just make it sync() + cmpxchg_relaxed() + sync() with the fallback,
> > and sync() is much heavier, so I don't think the fallback is correct.
>=20
> Indeed!
>=20
> The bit I missed previously is that PowerPC provides its own __atomic_op_=
release()=20
> method:
>=20
>    #define __atomic_op_release(op, args...)                              =
  \
>    ({                                                                    =
  \
>            __asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");  =
  \
>            op##_relaxed(args);                                           =
  \
>    })
>=20
> ... which maps to LWSYNC as you say, and my patch made that worse.
>=20
> > I think maybe you can move powerpc's __atomic_op_{acqurie,release}()
> > from atomic.h to cmpxchg.h (in arch/powerpc/include/asm), and
> >=20
> > 	#define cmpxchg_release __atomic_op_release(cmpxchg, __VA_ARGS__);
> > 	#define cmpxchg64_release __atomic_op_release(cmpxchg64, __VA_ARGS__);
> >=20
> > I put a diff below to say what I mean (untested).
> >=20
> > > Also, the change to arch/powerpc/include/asm/atomic.h has no function=
al effect=20
> > > right now either, but should anyone add a _relaxed() variant in the f=
uture, with=20
> > > this change atomic_cmpxchg_release() and atomic64_cmpxchg_release() w=
ill pick that=20
> > > up automatically.
> > >=20
> >=20
> > You mean with your other modification in include/linux/atomic.h, right?
> > Because with the unmodified include/linux/atomic.h, we already pick that
> > autmatically. If so, I think that's fine.
> >=20
> > Here is the diff for the modification for cmpxchg_release(), the idea is
> > we generate them in asm/cmpxchg.h other than linux/atomic.h for ppc, so
> > we keep the new linux/atomic.h working. Because if I understand
> > correctly, the next linux/atomic.h only accepts that
> >=20
> > 1)	architecture only defines fully ordered primitives
> >=20
> > or
> >=20
> > 2)	architecture only defines _relaxed primitives
> >=20
> > or
> >=20
> > 3)	architecture defines all four (fully, _relaxed, _acquire,
> > 	_release) primitives
> >=20
> > So powerpc needs to define all four primitives in its only
> > asm/cmpxchg.h.
>=20
> Correct, although the new logic is still RFC, PeterZ didn't like the firs=
t version=20
> I proposed and might NAK them.
>=20

Understood. From my side, I don't have strong feelings for either way.
But since powerpc gets affected with the new logic, so I'm glad I could
help.

> Thanks for the patch - I have created the patch below from it and added y=
our=20
> Signed-off-by.
>=20

Thanks ;-)

> The only change I made beyond a trivial build fix is that I also added th=
e release=20
> atomics variants explicitly:
>=20
> +#define atomic_cmpxchg_release(v, o, n) \
> +	cmpxchg_release(&((v)->counter), (o), (n))
> +#define atomic64_cmpxchg_release(v, o, n) \
> +	cmpxchg_release(&((v)->counter), (o), (n))
>=20
> It has passed a PowerPC cross-build test here, but no runtime tests.
>=20

Do you have the commit at any branch in tip tree? I could pull it and
cross-build and check the assembly code of lib/atomic64_test.c, that way
I could verify whether we mess something up.

> Does this patch look good to you?
>=20

Yep!

Regards,
Boqun

> (Still subject to PeterZ's Ack/NAK.)
>=20
> Thanks,
>=20
> 	Ingo
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> From: Boqun Feng <boqun.feng@gmail.com>
> Date: Sat, 5 May 2018 19:28:17 +0800
> Subject: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to asm/cmp=
xchg.h and define the full set of cmpxchg APIs
>=20
> Move PowerPC's __op_{acqurie,release}() from atomic.h to
> cmpxchg.h (in arch/powerpc/include/asm), plus use them to
> define these two methods:
>=20
> 	#define cmpxchg_release __op_release(cmpxchg, __VA_ARGS__);
> 	#define cmpxchg64_release __op_release(cmpxchg64, __VA_ARGS__);
>=20
> ... the idea is to generate all these methods in cmpxchg.h and to define =
the full
> array of atomic primitives, including the cmpxchg_release() methods which=
 were
> defined by the generic code before.
>=20
> Also define the atomic[64]_() variants explicitly.
>=20
> This ensures that all these low level cmpxchg APIs are defined in
> PowerPC headers, with no generic header fallbacks.
>=20
> No change in functionality or code generation.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: aryabinin@virtuozzo.com
> Cc: catalin.marinas@arm.com
> Cc: dvyukov@google.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: will.deacon@arm.com
> Link: http://lkml.kernel.org/r/20180505112817.ihrb726i37bwm4cj@tardis
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/powerpc/include/asm/atomic.h  | 22 ++++------------------
>  arch/powerpc/include/asm/cmpxchg.h | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm=
/atomic.h
> index 682b3e6a1e21..4e06955ec10f 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -13,24 +13,6 @@
> =20
>  #define ATOMIC_INIT(i)		{ (i) }
> =20
> -/*
> - * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
> - * a "bne-" instruction at the end, so an isync is enough as a acquire b=
arrier
> - * on the platform without lwsync.
> - */
> -#define __atomic_op_acquire(op, args...)				\
> -({									\
> -	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
> -	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
> -	__ret;								\
> -})
> -
> -#define __atomic_op_release(op, args...)				\
> -({									\
> -	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
> -	op##_relaxed(args);						\
> -})
> -
>  static __inline__ int atomic_read(const atomic_t *v)
>  {
>  	int t;
> @@ -213,6 +195,8 @@ static __inline__ int atomic_dec_return_relaxed(atomi=
c_t *v)
>  	cmpxchg_relaxed(&((v)->counter), (o), (n))
>  #define atomic_cmpxchg_acquire(v, o, n) \
>  	cmpxchg_acquire(&((v)->counter), (o), (n))
> +#define atomic_cmpxchg_release(v, o, n) \
> +	cmpxchg_release(&((v)->counter), (o), (n))
> =20
>  #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
>  #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
> @@ -519,6 +503,8 @@ static __inline__ long atomic64_dec_if_positive(atomi=
c64_t *v)
>  	cmpxchg_relaxed(&((v)->counter), (o), (n))
>  #define atomic64_cmpxchg_acquire(v, o, n) \
>  	cmpxchg_acquire(&((v)->counter), (o), (n))
> +#define atomic64_cmpxchg_release(v, o, n) \
> +	cmpxchg_release(&((v)->counter), (o), (n))
> =20
>  #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
>  #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new=
))
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/as=
m/cmpxchg.h
> index 9b001f1f6b32..e27a612b957f 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -8,6 +8,24 @@
>  #include <asm/asm-compat.h>
>  #include <linux/bug.h>
> =20
> +/*
> + * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
> + * a "bne-" instruction at the end, so an isync is enough as a acquire b=
arrier
> + * on the platform without lwsync.
> + */
> +#define __atomic_op_acquire(op, args...)				\
> +({									\
> +	typeof(op##_relaxed(args)) __ret  =3D op##_relaxed(args);		\
> +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
> +	__ret;								\
> +})
> +
> +#define __atomic_op_release(op, args...)				\
> +({									\
> +	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
> +	op##_relaxed(args);						\
> +})
> +
>  #ifdef __BIG_ENDIAN
>  #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYT=
E)
>  #else
> @@ -512,6 +530,9 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsig=
ned long new,
>  			(unsigned long)_o_, (unsigned long)_n_,		\
>  			sizeof(*(ptr)));				\
>  })
> +
> +#define cmpxchg_release(...) __atomic_op_release(cmpxchg, __VA_ARGS__)
> +
>  #ifdef CONFIG_PPC64
>  #define cmpxchg64(ptr, o, n)						\
>    ({									\
> @@ -533,6 +554,9 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsig=
ned long new,
>  	BUILD_BUG_ON(sizeof(*(ptr)) !=3D 8);				\
>  	cmpxchg_acquire((ptr), (o), (n));				\
>  })
> +
> +#define cmpxchg64_release(...) __atomic_op_release(cmpxchg64, __VA_ARGS_=
_)
> +
>  #else
>  #include <asm-generic/cmpxchg-local.h>
>  #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o),=
 (n))

--wv5ky4rhnqtz72k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrtubgACgkQSXnow7UH
+rg9dQf+O2bQRVNEsv+rrhq+s1atn3Qpe8stknThk8FTxlYqh3cupUTGc9pzE2RS
TbL38pPLHK1ZZ66VrelCFwPoDtLc0b4K0UIox+2Tc3uFxiC1wwDA31HJQKETxgP3
sphW9LZVFT1cuI/bc0EehtJtreHlUgd3MumIYLFLW0sXBE63doscKqZL6DxqTWHT
rfS7ysGdSBna+qCWEt/veiLQo+w0cEr1Yh11apYZU8nFlh8VZTCOlKoh/Ov0M7/y
zWJkSsVIHAtMrcSK5KA/cYXArX5z0rSkDI/mpbV88eFocS3tFDCnYrEbYGWouixq
Qj8pUIROoXH/Z5h8RWRD9PAqZfoxlA==
=p6Qg
-----END PGP SIGNATURE-----

--wv5ky4rhnqtz72k7--
