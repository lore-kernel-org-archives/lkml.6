Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BE620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BE620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeGYGDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbeGYGDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC752AEBC;
        Wed, 25 Jul 2018 04:53:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com
Date:   Wed, 25 Jul 2018 14:53:36 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180724225825.GE12945@linux.vnet.ibm.com>
References: <153086169828.24852.10332573315056854948.stgit@noble> <153086175009.24852.7782466383056542839.stgit@noble> <20180720075409.kfckhodsnvktift7@gondor.apana.org.au> <20180720144152.GW12945@linux.vnet.ibm.com> <87muulqq8q.fsf@notabene.neil.brown.name> <20180722215446.GH12945@linux.vnet.ibm.com> <87h8kqrhi0.fsf@notabene.neil.brown.name> <20180723205625.GZ12945@linux.vnet.ibm.com> <87r2jtpqm4.fsf@notabene.neil.brown.name> <20180724225825.GE12945@linux.vnet.ibm.com>
Message-ID: <87in53oqzz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24 2018, Paul E. McKenney wrote:

> On Tue, Jul 24, 2018 at 07:52:03AM +1000, NeilBrown wrote:
>> On Mon, Jul 23 2018, Paul E. McKenney wrote:
>>=20
>> > On Mon, Jul 23, 2018 at 09:13:43AM +1000, NeilBrown wrote:
>> >> On Sun, Jul 22 2018, Paul E. McKenney wrote:
>> >> >
>> >> > One issue is that the ->func pointer can legitimately be NULL while=
 on
>> >> > RCU's callback lists.  This happens when someone invokes kfree_rcu()
>> >> > with the rcu_head structure at the beginning of the enclosing struc=
ture.
>> >> > I could add an offset to avoid this, or perhaps the kmalloc() folks
>> >> > could be persuaded Rao Shoaib's patch moving kfree_rcu() handling to
>> >> > the slab allocators, so that RCU only ever sees function pointers in
>> >> > the ->func field.
>> >> >
>> >> > Either way, this should be hidden behind an API to allow adjustments
>> >> > to be made if needed.  Maybe something like is_after_call_rcu()?
>> >> > This would (for example) allow debug-object checks to be used to ca=
tch
>> >> > check-after-free bugs.
>> >> >
>> >> > Would something of that sort work for you?
>> >>=20
>> >> Yes, if you could provide an is_after_call_rcu() API, that would
>> >> perfectly suit my use-case.
>> >
>> > After beating my head against the object-debug code a bit, I have to a=
sk
>> > if it would be OK for you if the is_after_call_rcu() API also takes the
>> > function that was passed to RCU.
>>=20
>> Sure.  It feels a bit clumsy, but I can see it could be easier to make
>> robust.
>> So yes: I'm fine with pass the same function and rcu_head to both
>> call_rcu() and is_after_call_rcu().  Actually, when I say it like that,
>> it seems less clumsy :-)
>
> How about like this?  (It needs refinements, like lockdep, but should
> get the gist.)
>

Looks good ... except ... naming is hard.

 is_after_call_rcu_init()  asserts where in the lifecycle we are,
 is_after_call_rcu() tests where in the lifecycle we are.

 The names are similar but the purpose is quite different.
 Maybe s/is_after_call_rcu_init/call_rcu_init/ ??

Thanks,
NeilBrown


> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 5aa0ebf4799b8bddbbd0124db1c008526e99fc7c
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Jul 24 15:28:09 2018 -0700
>
>     rcu: Provide functions for determining if call_rcu() has been invoked
>=20=20=20=20=20
>     This commit adds is_after_call_rcu() and is_after_call_rcu_init()
>     functions to help RCU users detect when another CPU has passed
>     the specified rcu_head structure and function to call_rcu().
>     The is_after_call_rcu_init() should be invoked before making the
>     structure visible to RCU readers, and then the is_after_call_rcu() may
>     be invoked from within an RCU read-side critical section on an rcu_he=
ad
>     structure that was obtained during a traversal of the data structure
>     in question.  The is_after_call_rcu() function will return true if the
>     rcu_head structure has already been passed (with the specified functi=
on)
>     to call_rcu(), otherwise it will return false.
>=20=20=20=20=20
>     If is_after_call_rcu_init() has not been invoked on the rcu_head
>     structure or if the rcu_head (AKA callback) has already been invoked,
>     then is_after_call_rcu() will do WARN_ON_ONCE().
>=20=20=20=20=20
>     Reported-by: NeilBrown <neilb@suse.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index e4f821165d0b..82e5a91539b5 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -857,6 +857,45 @@ static inline notrace void rcu_read_unlock_sched_not=
race(void)
>  #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>=20=20
>=20=20
> +/* Has the specified rcu_head structure been handed to call_rcu()? */
> +
> +/*
> + * is_after_call_rcu_init - Initialize rcu_head for is_after_call_rcu()
> + * @rhp: The rcu_head structure to initialize.
> + *
> + * If you intend to invoke is_after_call_rcu() to test whether a given
> + * rcu_head structure has already been passed to call_rcu(), then you mu=
st
> + * also invoke this is_after_call_rcu_init() function on it just after
> + * allocating that structure.  Calls to this function must not race with
> + * calls to call_rcu(), is_after_call_rcu(), or callback invocation.
> + */
> +static inline void is_after_call_rcu_init(struct rcu_head *rhp)
> +{
> +	rhp->func =3D (rcu_callback_t)~0L;
> +}
> +
> +/*
> + * is_after_call_rcu - Has this rcu_head been passed to call_rcu()?
> + * @rhp: The rcu_head structure to test.
> + * @func: The function passed to call_rcu() along with @rhp.
> + *
> + * Returns @true if the @rhp has been passed to call_rcu() with @func, a=
nd
> + * @false otherwise.  Emits a warning in any other case, including the
> + * case where @rhp has already been invoked after a grace period.
> + * Calls to this function must not race with callback invocation.  One
> + * way to avoid such races is to enclose the call to is_after_call_rcu()
> + * in an RCU read-side critical section that includes a read-side fetch
> + * of the pointer to the structure containing @rhp.
> + */
> +static inline bool is_after_call_rcu(struct rcu_head *rhp, rcu_callback_=
t f)
> +{
> +	if (READ_ONCE(rhp->func) =3D=3D f)
> +		return true;
> +	WARN_ON_ONCE(READ_ONCE(rhp->func) !=3D (rcu_callback_t)~0L);
> +	return false;
> +}
> +
> +
>  /* Transitional pre-consolidation compatibility definitions. */
>=20=20
>  static inline void synchronize_rcu_bh(void)
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 5dec94509a7e..4c56c1d98fb3 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -224,6 +224,7 @@ void kfree(const void *);
>   */
>  static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
>  {
> +	rcu_callback_t f;
>  	unsigned long offset =3D (unsigned long)head->func;
>=20=20
>  	rcu_lock_acquire(&rcu_callback_map);
> @@ -234,7 +235,9 @@ static inline bool __rcu_reclaim(const char *rn, stru=
ct rcu_head *head)
>  		return true;
>  	} else {
>  		RCU_TRACE(trace_rcu_invoke_callback(rn, head);)
> -		head->func(head);
> +		f =3D head->func;
> +		WRITE_ONCE(head->func, (rcu_callback_t)0L);
> +		f(head);
>  		rcu_lock_release(&rcu_callback_map);
>  		return false;
>  	}

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltYAlAACgkQOeye3VZi
gbn89BAAl1iMKnWPC+Db5Xq6jw9auLrNGhCGt+tmaghLWWYVonuVj6hDhB5Nj4+w
YsKRw8SJDIu7/oBYk3KJivZCDnpnhAZwT1VMSpx0SlMZUbFJkJyY4YGf/HYK9x+H
+wmDKOFkSQCvVkz06YBCEayFTtSaSPFolZkM53fGbxJeYa0enuqMfAee/WIG7TRP
QyQZIaX/yTFNO2yU5EIRyRf2ZtMnHcODeCB1jdCsx5p2w0Qho1PPLeMXaxtqb2pp
l/ZeQSAbtUndneX2esRqJIGfB5hQ9jgjdOkUOJyRHxXC9OVzKCAFgkOC1AgDsgDF
fH5RHY+l952HuqUiycMZGTaFykxWDCc5Uzj3/AqLVFmNkX0BkbJN2pcK/3xXJBzn
CSd311zfP7d3zr8YAcrbvF8deK3oMUX2xinsQxb17vC4YjEA+q2l0NYpsN4u8RUa
Yr1wepVh8mtuPaOxXRPI4/loP+2wds0qJQUG61Kb/Ta8Q+Xj4SBH868CHTfDBYXu
U3J/xGqJjKZ9+/aIiLdxwfWfmtVc2cwjoRDjdXgZMLgmgs6J0xsMdYC6HlEC8kcz
yCjjhFYgq3tIQLjWoLT1NK+pHdD8mJxVK4juYYEyJ7owA014S72YhHQILNnu4qy9
J6EdnrTR/VV9DCOFBSsJjiZp9MPNSDMTe1KM8H6WkPRX0n8mB/Q=
=WhxW
-----END PGP SIGNATURE-----
--=-=-=--
