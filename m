Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbeEEKWa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:22:30 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39123 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:22:28 -0400
X-Google-Smtp-Source: AB8JxZppcPMUERGZDBq+KQ7Q+e1RQlN2wkY8CR3cm3eYgs7IVJSFGAIp8WNeFlJFcWLqR0+YEUIzwg==
X-ME-Sender: <xms:4oXtWgg2u8P0ZfRuSzt7pFOqYippoLu6Inse1WllKv-qG86Cs8lJnw>
Date: Sat, 5 May 2018 18:26:49 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: Re: [RFC PATCH] locking/atomics/powerpc: Introduce optimized
 cmpxchg_release() family of APIs for PowerPC
Message-ID: <20180505102649.t74xclzalkejeb6x@tardis>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505100055.yc4upauxo5etq5ud@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6emnqv4lzprmfndx"
Content-Disposition: inline
In-Reply-To: <20180505100055.yc4upauxo5etq5ud@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6emnqv4lzprmfndx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Sat, May 05, 2018 at 12:00:55PM +0200, Ingo Molnar wrote:
>=20
> * Ingo Molnar <mingo@kernel.org> wrote:
>=20
> > > So there's no loss in arch flexibility.
> >=20
> > BTW., PowerPC for example is already in such a situation, it does not d=
efine=20
> > atomic_cmpxchg_release(), only the other APIs:
> >=20
> > #define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
> > #define atomic_cmpxchg_relaxed(v, o, n) \
> > 	cmpxchg_relaxed(&((v)->counter), (o), (n))
> > #define atomic_cmpxchg_acquire(v, o, n) \
> > 	cmpxchg_acquire(&((v)->counter), (o), (n))
> >=20
> > Was it really the intention on the PowerPC side that the generic code f=
alls back=20
> > to cmpxchg(), i.e.:
> >=20
> > #  define atomic_cmpxchg_release(...)           __atomic_op_release(ato=
mic_cmpxchg, __VA_ARGS__)
> >=20
> > Which after macro expansion becomes:
> >=20
> > 	smp_mb__before_atomic();
> > 	atomic_cmpxchg_relaxed(v, o, n);
> >=20
> > smp_mb__before_atomic() on PowerPC falls back to the generic __smp_mb()=
, which=20
> > falls back to mb(), which on PowerPC is the 'sync' instruction.
> >=20
> > Isn't this a inefficiency bug?
> >=20
> > While I'm pretty clueless about PowerPC low level cmpxchg atomics, they=
 appear to=20
> > have the following basic structure:
> >=20
> > full cmpxchg():
> >=20
> > 	PPC_ATOMIC_ENTRY_BARRIER # sync
> > 	ldarx + stdcx
> > 	PPC_ATOMIC_EXIT_BARRIER  # sync
> >=20
> > cmpxchg_relaxed():
> >=20
> > 	ldarx + stdcx
> >=20
> > cmpxchg_acquire():
> >=20
> > 	ldarx + stdcx
> > 	PPC_ACQUIRE_BARRIER      # lwsync
> >=20
> > The logical extension for cmpxchg_release() would be:
> >=20
> > cmpxchg_release():
> >=20
> > 	PPC_RELEASE_BARRIER      # lwsync
> > 	ldarx + stdcx
> >=20
> > But instead we silently get the generic fallback, which does:
> >=20
> > 	smp_mb__before_atomic();
> > 	atomic_cmpxchg_relaxed(v, o, n);
> >=20
> > Which maps to:
> >=20
> > 	sync
> > 	ldarx + stdcx
> >=20
> > Note that it uses a full barrier instead of lwsync (does that stand for=
=20
> > 'lightweight sync'?).
> >=20
> > Even if it turns out we need the full barrier, with the overly finegrai=
ned=20
> > structure of the atomics this detail is totally undocumented and non-ob=
vious.
>=20
> The patch below fills in those bits and implements the optimized cmpxchg_=
release()=20
> family of APIs. The end effect should be that cmpxchg_release() will now =
use=20
> 'lwsync' instead of 'sync' on PowerPC, for the following APIs:
>=20
>   cmpxchg_release()
>   cmpxchg64_release()
>   atomic_cmpxchg_release()
>   atomic64_cmpxchg_release()
>=20
> I based this choice of the release barrier on an existing bitops low leve=
l PowerPC=20
> method:
>=20
>    DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
>=20
> This clearly suggests that PPC_RELEASE_BARRIER is in active use and 'lwsy=
nc' is=20
> the 'release barrier' instruction, if I interpreted that right.
>=20

Thanks for looking into this, but as I said in other email:

	https://marc.info/?l=3Dlinux-kernel&m=3D152551511324210&w=3D2

, we actually generate light weight barriers for cmpxchg_release()
familiy.

The reason of the asymmetry between cmpxchg_acquire() and
cmpxchg_release() is that we want to save a barrier for
cmpxchg_acquire() if the cmp fails, but doing the similar for
cmpxchg_release() will introduce a scenario that puts a barrier in a
ll/sc loop, which may be a bad idea.

> But I know very little about PowerPC so this might be spectacularly wrong=
=2E It's=20
> totally untested as well. I also pretty sick today so my mental capabilit=
ies are=20
> significantly reduced ...
>=20

Feel sorry about that, hope you well!

Please let me know if you think I should provide more document work to
make this more informative.

Regards,
Boqun

> So not signed off and such.
>=20
> Thanks,
>=20
> 	Ingo
>=20
> ---
>  arch/powerpc/include/asm/atomic.h  |  4 ++
>  arch/powerpc/include/asm/cmpxchg.h | 81 ++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 85 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm=
/atomic.h
> index 682b3e6a1e21..f7a6f29acb12 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -213,6 +213,8 @@ static __inline__ int atomic_dec_return_relaxed(atomi=
c_t *v)
>  	cmpxchg_relaxed(&((v)->counter), (o), (n))
>  #define atomic_cmpxchg_acquire(v, o, n) \
>  	cmpxchg_acquire(&((v)->counter), (o), (n))
> +#define atomic_cmpxchg_release(v, o, n) \
> +	cmpxchg_release(&((v)->counter), (o), (n))
> =20
>  #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
>  #define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
> @@ -519,6 +521,8 @@ static __inline__ long atomic64_dec_if_positive(atomi=
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
> index 9b001f1f6b32..6e46310b1833 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -213,10 +213,12 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned=
 int size)
>  CMPXCHG_GEN(u8, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "me=
mory");
>  CMPXCHG_GEN(u8, _local, , , "memory");
>  CMPXCHG_GEN(u8, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
> +CMPXCHG_GEN(u8, _release, PPC_RELEASE_BARRIER, , "memory");
>  CMPXCHG_GEN(u8, _relaxed, , , "cc");
>  CMPXCHG_GEN(u16, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "m=
emory");
>  CMPXCHG_GEN(u16, _local, , , "memory");
>  CMPXCHG_GEN(u16, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
> +CMPXCHG_GEN(u16, _release, PPC_RELEASE_BARRIER, , "memory");
>  CMPXCHG_GEN(u16, _relaxed, , , "cc");
> =20
>  static __always_inline unsigned long
> @@ -314,6 +316,29 @@ __cmpxchg_u32_acquire(u32 *p, unsigned long old, uns=
igned long new)
>  	return prev;
>  }
> =20
> +static __always_inline unsigned long
> +__cmpxchg_u32_release(u32 *p, unsigned long old, unsigned long new)
> +{
> +	unsigned long prev;
> +
> +	__asm__ __volatile__ (
> +	PPC_RELEASE_BARRIER
> +"1:	lwarx	%0,0,%2		# __cmpxchg_u32_release\n"
> +"	cmpw	0,%0,%3\n"
> +"	bne-	2f\n"
> +	PPC405_ERR77(0, %2)
> +"	stwcx.	%4,0,%2\n"
> +"	bne-	1b\n"
> +	"\n"
> +"2:"
> +	: "=3D&r" (prev), "+m" (*p)
> +	: "r" (p), "r" (old), "r" (new)
> +	: "cc", "memory");
> +
> +	return prev;
> +}
> +
> +
>  #ifdef CONFIG_PPC64
>  static __always_inline unsigned long
>  __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned lon=
g new)
> @@ -397,6 +422,27 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, uns=
igned long new)
> =20
>  	return prev;
>  }
> +
> +static __always_inline unsigned long
> +__cmpxchg_u64_release(u64 *p, unsigned long old, unsigned long new)
> +{
> +	unsigned long prev;
> +
> +	__asm__ __volatile__ (
> +	PPC_RELEASE_BARRIER
> +"1:	ldarx	%0,0,%2		# __cmpxchg_u64_release\n"
> +"	cmpd	0,%0,%3\n"
> +"	bne-	2f\n"
> +"	stdcx.	%4,0,%2\n"
> +"	bne-	1b\n"
> +	"\n"
> +"2:"
> +	: "=3D&r" (prev), "+m" (*p)
> +	: "r" (p), "r" (old), "r" (new)
> +	: "cc", "memory");
> +
> +	return prev;
> +}
>  #endif
> =20
>  static __always_inline unsigned long
> @@ -478,6 +524,27 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsi=
gned long new,
>  	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
>  	return old;
>  }
> +
> +static __always_inline unsigned long
> +__cmpxchg_release(void *ptr, unsigned long old, unsigned long new,
> +		  unsigned int size)
> +{
> +	switch (size) {
> +	case 1:
> +		return __cmpxchg_u8_release(ptr, old, new);
> +	case 2:
> +		return __cmpxchg_u16_release(ptr, old, new);
> +	case 4:
> +		return __cmpxchg_u32_release(ptr, old, new);
> +#ifdef CONFIG_PPC64
> +	case 8:
> +		return __cmpxchg_u64_release(ptr, old, new);
> +#endif
> +	}
> +	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_release");
> +	return old;
> +}
> +
>  #define cmpxchg(ptr, o, n)						 \
>    ({									 \
>       __typeof__(*(ptr)) _o_ =3D (o);					 \
> @@ -512,6 +579,15 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsi=
gned long new,
>  			(unsigned long)_o_, (unsigned long)_n_,		\
>  			sizeof(*(ptr)));				\
>  })
> +
> +#define cmpxchg_release(ptr, o, n)					\
> +({									\
> +	__typeof__(*(ptr)) _o_ =3D (o);					\
> +	__typeof__(*(ptr)) _n_ =3D (n);					\
> +	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
> +			(unsigned long)_o_, (unsigned long)_n_,		\
> +			sizeof(*(ptr)));				\
> +})
>  #ifdef CONFIG_PPC64
>  #define cmpxchg64(ptr, o, n)						\
>    ({									\
> @@ -533,6 +609,11 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsi=
gned long new,
>  	BUILD_BUG_ON(sizeof(*(ptr)) !=3D 8);				\
>  	cmpxchg_acquire((ptr), (o), (n));				\
>  })
> +#define cmpxchg64_release(ptr, o, n)					\
> +({									\
> +	BUILD_BUG_ON(sizeof(*(ptr)) !=3D 8);				\
> +	cmpxchg_release((ptr), (o), (n));				\
> +})
>  #else
>  #include <asm-generic/cmpxchg-local.h>
>  #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o),=
 (n))

--6emnqv4lzprmfndx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrthuYACgkQSXnow7UH
+riybAgAkE2D2/lWoAaq5HRc51qEhomJWGZ+DZxHRf8AH03bg/X3sCrFG4S83wBa
DbZYsifCUb6CHKVw2/vHO74zD3ah5cioGb6L/VnNni7lCoXxAnr1I6CtYc9zmCPs
kN4bbTFRsOLqsmrhFPCYFi+9EWFVs5uU8LcuO659Tqa0juenijP8kYExUN0hQTU5
eCSpb4322lCF7ALQuDHQrX0r+38bU9xESVm4bPnfHRhiE+0OlRBqtvf7Ncll/jk5
Uj84sqVafj1iv6wXxzSPNY5LeJCQSMgilLm2jCkL2zlLVRvK5sglb/9XjPskAfrg
LOHrhjTPsqwtz+AMHRpef5xBcS/jYQ==
=cOha
-----END PGP SIGNATURE-----

--6emnqv4lzprmfndx--
