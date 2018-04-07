Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbeDGFTE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 01:19:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37561 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDGFTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 01:19:03 -0400
X-Google-Smtp-Source: AIpwx4+T6xsBYL94ddobv/dqdOz43K93p6N+LWeNZN4zMS1aHqxY8nQMqKmyv/fzMdLVLoyR185kPA==
X-ME-Sender: <xms:xFTIWj270qsqwiwxRDeNLfD4SrixEZQooHzqmO7qUn8-pvHr-UBokQ>
Date: Sat, 7 Apr 2018 13:23:12 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 08/10] locking/qspinlock: Merge struct __qspinlock into
 struct qspinlock
Message-ID: <20180407052312.aidpjj3y3hftdldo@tardis>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-9-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gj5m52rbeckvcqi2"
Content-Disposition: inline
In-Reply-To: <1522947547-24081-9-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gj5m52rbeckvcqi2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 05:59:05PM +0100, Will Deacon wrote:
> struct __qspinlock provides a handy union of fields so that
> subcomponents of the lockword can be accessed by name, without having to
> manage shifts and masks explicitly and take endianness into account.
>=20
> This is useful in qspinlock.h and also potentially in arch headers, so
> move the struct __qspinlock into struct qspinlock and kill the extra
> definition.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

As I said in the IRC, it's glad to see such a merge ;-)

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/include/asm/qspinlock.h          |  2 +-
>  arch/x86/include/asm/qspinlock_paravirt.h |  3 +-
>  include/asm-generic/qspinlock_types.h     | 32 +++++++++++++++++++--
>  kernel/locking/qspinlock.c                | 46 ++-----------------------=
------
>  kernel/locking/qspinlock_paravirt.h       | 34 ++++++++---------------
>  5 files changed, 46 insertions(+), 71 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspi=
nlock.h
> index 5e16b5d40d32..90b0b0ed8161 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -16,7 +16,7 @@
>   */
>  static inline void native_queued_spin_unlock(struct qspinlock *lock)
>  {
> -	smp_store_release((u8 *)lock, 0);
> +	smp_store_release(&lock->locked, 0);
>  }
> =20
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
> diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include=
/asm/qspinlock_paravirt.h
> index 923307ea11c7..9ef5ee03d2d7 100644
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -22,8 +22,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowp=
ath);
>   *
>   * void __pv_queued_spin_unlock(struct qspinlock *lock)
>   * {
> - *	struct __qspinlock *l =3D (void *)lock;
> - *	u8 lockval =3D cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
> + *	u8 lockval =3D cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
>   *
>   *	if (likely(lockval =3D=3D _Q_LOCKED_VAL))
>   *		return;
> diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/=
qspinlock_types.h
> index 034acd0c4956..0763f065b975 100644
> --- a/include/asm-generic/qspinlock_types.h
> +++ b/include/asm-generic/qspinlock_types.h
> @@ -29,13 +29,41 @@
>  #endif
> =20
>  typedef struct qspinlock {
> -	atomic_t	val;
> +	union {
> +		atomic_t val;
> +
> +		/*
> +		 * By using the whole 2nd least significant byte for the
> +		 * pending bit, we can allow better optimization of the lock
> +		 * acquisition for the pending bit holder.
> +		 */
> +#ifdef __LITTLE_ENDIAN
> +		struct {
> +			u8	locked;
> +			u8	pending;
> +		};
> +		struct {
> +			u16	locked_pending;
> +			u16	tail;
> +		};
> +#else
> +		struct {
> +			u16	tail;
> +			u16	locked_pending;
> +		};
> +		struct {
> +			u8	reserved[2];
> +			u8	pending;
> +			u8	locked;
> +		};
> +#endif
> +	};
>  } arch_spinlock_t;
> =20
>  /*
>   * Initializier
>   */
> -#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
> +#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val =3D ATOMIC_INIT(0) }
> =20
>  /*
>   * Bitfields in the atomic value:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index c8b57d375b49..3ad8786a47e2 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -114,40 +114,6 @@ static inline __pure struct mcs_spinlock *decode_tai=
l(u32 tail)
> =20
>  #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
> =20
> -/*
> - * By using the whole 2nd least significant byte for the pending bit, we
> - * can allow better optimization of the lock acquisition for the pending
> - * bit holder.
> - *
> - * This internal structure is also used by the set_locked function which
> - * is not restricted to _Q_PENDING_BITS =3D=3D 8.
> - */
> -struct __qspinlock {
> -	union {
> -		atomic_t val;
> -#ifdef __LITTLE_ENDIAN
> -		struct {
> -			u8	locked;
> -			u8	pending;
> -		};
> -		struct {
> -			u16	locked_pending;
> -			u16	tail;
> -		};
> -#else
> -		struct {
> -			u16	tail;
> -			u16	locked_pending;
> -		};
> -		struct {
> -			u8	reserved[2];
> -			u8	pending;
> -			u8	locked;
> -		};
> -#endif
> -	};
> -};
> -
>  #if _Q_PENDING_BITS =3D=3D 8
>  /**
>   * clear_pending_set_locked - take ownership and clear the pending bit.
> @@ -159,9 +125,7 @@ struct __qspinlock {
>   */
>  static __always_inline void clear_pending_set_locked(struct qspinlock *l=
ock)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
> -	WRITE_ONCE(l->locked_pending, _Q_LOCKED_VAL);
> +	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>  }
> =20
>  /*
> @@ -176,13 +140,11 @@ static __always_inline void clear_pending_set_locke=
d(struct qspinlock *lock)
>   */
>  static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
>  	/*
>  	 * Use release semantics to make sure that the MCS node is properly
>  	 * initialized before changing the tail code.
>  	 */
> -	return (u32)xchg_release(&l->tail,
> +	return (u32)xchg_release(&lock->tail,
>  				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
>  }
> =20
> @@ -237,9 +199,7 @@ static __always_inline u32 xchg_tail(struct qspinlock=
 *lock, u32 tail)
>   */
>  static __always_inline void set_locked(struct qspinlock *lock)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
> -	WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
> +	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
>  }
> =20
> =20
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlo=
ck_paravirt.h
> index 6ee477765e6c..2711940429f5 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -87,8 +87,6 @@ struct pv_node {
>  #define queued_spin_trylock(l)	pv_hybrid_queued_unfair_trylock(l)
>  static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *loc=
k)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
>  	/*
>  	 * Stay in unfair lock mode as long as queued mode waiters are
>  	 * present in the MCS wait queue but the pending bit isn't set.
> @@ -97,7 +95,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(stru=
ct qspinlock *lock)
>  		int val =3D atomic_read(&lock->val);
> =20
>  		if (!(val & _Q_LOCKED_PENDING_MASK) &&
> -		   (cmpxchg_acquire(&l->locked, 0, _Q_LOCKED_VAL) =3D=3D 0)) {
> +		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) =3D=3D 0)) {
>  			qstat_inc(qstat_pv_lock_stealing, true);
>  			return true;
>  		}
> @@ -117,16 +115,12 @@ static inline bool pv_hybrid_queued_unfair_trylock(=
struct qspinlock *lock)
>  #if _Q_PENDING_BITS =3D=3D 8
>  static __always_inline void set_pending(struct qspinlock *lock)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
> -	WRITE_ONCE(l->pending, 1);
> +	WRITE_ONCE(lock->pending, 1);
>  }
> =20
>  static __always_inline void clear_pending(struct qspinlock *lock)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
> -	WRITE_ONCE(l->pending, 0);
> +	WRITE_ONCE(lock->pending, 0);
>  }
> =20
>  /*
> @@ -136,10 +130,8 @@ static __always_inline void clear_pending(struct qsp=
inlock *lock)
>   */
>  static __always_inline int trylock_clear_pending(struct qspinlock *lock)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
> -
> -	return !READ_ONCE(l->locked) &&
> -	       (cmpxchg_acquire(&l->locked_pending, _Q_PENDING_VAL,
> +	return !READ_ONCE(lock->locked) &&
> +	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
>  				_Q_LOCKED_VAL) =3D=3D _Q_PENDING_VAL);
>  }
>  #else /* _Q_PENDING_BITS =3D=3D 8 */
> @@ -384,7 +376,6 @@ static void pv_wait_node(struct mcs_spinlock *node, s=
truct mcs_spinlock *prev)
>  static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *no=
de)
>  {
>  	struct pv_node *pn =3D (struct pv_node *)node;
> -	struct __qspinlock *l =3D (void *)lock;
> =20
>  	/*
>  	 * If the vCPU is indeed halted, advance its state to match that of
> @@ -413,7 +404,7 @@ static void pv_kick_node(struct qspinlock *lock, stru=
ct mcs_spinlock *node)
>  	 * the hash table later on at unlock time, no atomic instruction is
>  	 * needed.
>  	 */
> -	WRITE_ONCE(l->locked, _Q_SLOW_VAL);
> +	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
>  	(void)pv_hash(lock, pn);
>  }
> =20
> @@ -428,7 +419,6 @@ static u32
>  pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
>  {
>  	struct pv_node *pn =3D (struct pv_node *)node;
> -	struct __qspinlock *l =3D (void *)lock;
>  	struct qspinlock **lp =3D NULL;
>  	int waitcnt =3D 0;
>  	int loop;
> @@ -479,13 +469,13 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct=
 mcs_spinlock *node)
>  			 *
>  			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
>  			 */
> -			if (xchg(&l->locked, _Q_SLOW_VAL) =3D=3D 0) {
> +			if (xchg(&lock->locked, _Q_SLOW_VAL) =3D=3D 0) {
>  				/*
>  				 * The lock was free and now we own the lock.
>  				 * Change the lock value back to _Q_LOCKED_VAL
>  				 * and unhash the table.
>  				 */
> -				WRITE_ONCE(l->locked, _Q_LOCKED_VAL);
> +				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
>  				WRITE_ONCE(*lp, NULL);
>  				goto gotlock;
>  			}
> @@ -493,7 +483,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct m=
cs_spinlock *node)
>  		WRITE_ONCE(pn->state, vcpu_hashed);
>  		qstat_inc(qstat_pv_wait_head, true);
>  		qstat_inc(qstat_pv_wait_again, waitcnt);
> -		pv_wait(&l->locked, _Q_SLOW_VAL);
> +		pv_wait(&lock->locked, _Q_SLOW_VAL);
> =20
>  		/*
>  		 * Because of lock stealing, the queue head vCPU may not be
> @@ -518,7 +508,6 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct m=
cs_spinlock *node)
>  __visible void
>  __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
>  	struct pv_node *node;
> =20
>  	if (unlikely(locked !=3D _Q_SLOW_VAL)) {
> @@ -547,7 +536,7 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lo=
ck, u8 locked)
>  	 * Now that we have a reference to the (likely) blocked pv_node,
>  	 * release the lock.
>  	 */
> -	smp_store_release(&l->locked, 0);
> +	smp_store_release(&lock->locked, 0);
> =20
>  	/*
>  	 * At this point the memory pointed at by lock can be freed/reused,
> @@ -573,7 +562,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lo=
ck, u8 locked)
>  #ifndef __pv_queued_spin_unlock
>  __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
>  {
> -	struct __qspinlock *l =3D (void *)lock;
>  	u8 locked;
> =20
>  	/*
> @@ -581,7 +569,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlo=
ck *lock)
>  	 * unhash. Otherwise it would be possible to have multiple @lock
>  	 * entries, which would be BAD.
>  	 */
> -	locked =3D cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
> +	locked =3D cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
>  	if (likely(locked =3D=3D _Q_LOCKED_VAL))
>  		return;
> =20
> --=20
> 2.1.4
>=20

--gj5m52rbeckvcqi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrIVbwACgkQSXnow7UH
+rivfAf/RKp530GSim7xHQtM2SoUCCcDuA4CPz3AunqovvaIFR/0tsTG/t+bwdX6
vsCadralQLMDn0GDXYdT943kd9hdPuDgVI2g5cpbvZ3SSzfZlu/y2DiMnSu0o5MG
wbpcFV8rSecI9q68LH6JcmgvaemEh2l2Md9SgBaVemoG+/55/a5jaVBynj4fhIj9
TkwegBPsoVRHNUY46ZpoP0u4FWsA06+v8LlcWRLCcrmnD9Y9rEGG1CovUhmKXu52
B/5laElJCXZvc8l+4cjaSdJ9VaGfEjU7y9MdRdXEHoPxQmeXgufukTRx+22EKfrr
ULGCvJajVu2oMzqX70p5qKS+Blf28w==
=Aa3i
-----END PGP SIGNATURE-----

--gj5m52rbeckvcqi2--
