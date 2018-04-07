Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeDGFnE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 01:43:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50882 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeDGFnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 01:43:03 -0400
X-Google-Smtp-Source: AIpwx4/crOLDe9CJKxks4xBEXA8tDBmOzuNzJfrHvgKV9ixeHCATR6Mek/yT4QlhFbrJTnNGiXMMVw==
X-ME-Sender: <xms:Y1rIWkh6IjE-r21YUKkBI6Of6Xyllre1hZTdPUchJ_Q2-DthTwAPlw>
Date: Sat, 7 Apr 2018 13:47:11 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
Message-ID: <20180407054711.rldyfcmni2wtblyu@tardis>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hchqiumxxg5z2323"
Content-Disposition: inline
In-Reply-To: <1522947547-24081-11-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hchqiumxxg5z2323
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> The qspinlock slowpath must ensure that the MCS node is fully initialised
> before it can be reached by another other CPU. This is currently enforced
> by using a RELEASE operation when updating the tail and also when linking
> the node into the waitqueue (since the control dependency off xchg_tail
> is insufficient to enforce sufficient ordering -- see 95bcade33a8a
> ("locking/qspinlock: Ensure node is initialised before updating prev->nex=
t")).
>=20
> Back-to-back RELEASE operations may be expensive on some architectures,
> particularly those that implement them using fences under the hood. We
> can replace the two RELEASE operations with a single smp_wmb() fence and
> use RELAXED operations for the subsequent publishing of the node.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/locking/qspinlock.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 3ad8786a47e2..42c61f7b37c5 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -141,10 +141,10 @@ static __always_inline void clear_pending_set_locke=
d(struct qspinlock *lock)
>  static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  {
>  	/*
> -	 * Use release semantics to make sure that the MCS node is properly
> -	 * initialized before changing the tail code.
> +	 * We can use relaxed semantics since the caller ensures that the
> +	 * MCS node is properly initialized before updating the tail.
>  	 */
> -	return (u32)xchg_release(&lock->tail,
> +	return (u32)xchg_relaxed(&lock->tail,
>  				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
>  }
> =20
> @@ -178,10 +178,11 @@ static __always_inline u32 xchg_tail(struct qspinlo=
ck *lock, u32 tail)
>  	for (;;) {
>  		new =3D (val & _Q_LOCKED_PENDING_MASK) | tail;
>  		/*
> -		 * Use release semantics to make sure that the MCS node is
> -		 * properly initialized before changing the tail code.
> +		 * We can use relaxed semantics since the caller ensures that
> +		 * the MCS node is properly initialized before updating the
> +		 * tail.
>  		 */
> -		old =3D atomic_cmpxchg_release(&lock->val, val, new);
> +		old =3D atomic_cmpxchg_relaxed(&lock->val, val, new);
>  		if (old =3D=3D val)
>  			break;
> =20
> @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lo=
ck, u32 val)
>  		goto release;
> =20
>  	/*
> +	 * Ensure that the initialisation of @node is complete before we
> +	 * publish the updated tail and potentially link @node into the

I think it might be better if we mention exactly where we "publish the
updated tail" and "link @node", how about:

	* publish the update tail via xchg_tail() and potentially link
	* @node into the waitqueue via WRITE_ONCE(->next,..) below.

and also add comments below like:

> +	 * waitqueue.
> +	 */
> +	smp_wmb();
> +
> +	/*
>  	 * We have already touched the queueing cacheline; don't bother with
>  	 * pending stuff.
>  	 *
>  	 * p,*,* -> n,*,*
> -	 *
> -	 * RELEASE, such that the stores to @node must be complete.

	* publish the updated tail

>  	 */
>  	old =3D xchg_tail(lock, tail);
>  	next =3D NULL;
> @@ -356,15 +362,7 @@ void queued_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>  	 */
>  	if (old & _Q_TAIL_MASK) {
>  		prev =3D decode_tail(old);
> -
> -		/*
> -		 * We must ensure that the stores to @node are observed before
> -		 * the write to prev->next. The address dependency from
> -		 * xchg_tail is not sufficient to ensure this because the read
> -		 * component of xchg_tail is unordered with respect to the
> -		 * initialisation of @node.
> -		 */
> -		smp_store_release(&prev->next, node);

		/* Eventually link @node to the wait queue */
=09
Thoughts?

Regards,
Boqun

> +		WRITE_ONCE(prev->next, node);
> =20
>  		pv_wait_node(node, prev);
>  		arch_mcs_spin_lock_contended(&node->locked);
> --=20
> 2.1.4
>=20

--hchqiumxxg5z2323
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrIW1wACgkQSXnow7UH
+rgkAQf/SS2aZeHDOVr/tDVYJegkRpetMU7oWjRIZpASQLwwvdYwNO5SpiyOHZXO
rYvoKW7GR/DLHdq9HyCclqURYNQ7RoyNTjK8VikbNOgMi661e8CktwB/hmCDQLfu
H+2mgM4/jZWJ++yPVFZzi7VUK3mHOkK5iqFGxLseSIKAyqiN/oMKZkhPWo3fo9NO
VeWCNU5Alhs+ZI1fCos+giafuVIxb+w2n9n8a8kxzieF69CcU2wbDcCdM8BWXLrY
M8zls2UtyOKroxhSKGs0bA2y7aRAWEuDr7hAaXr2PoJmy8dLTGrSjrFaoV/bGWQO
peJP4nTLQ/z442/xjSGWuVnEACd42Q==
=p9TP
-----END PGP SIGNATURE-----

--hchqiumxxg5z2323--
