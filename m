Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C4320894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C4320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeGaGnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeGaGnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C76FACAD;
        Tue, 31 Jul 2018 05:04:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com
Date:   Tue, 31 Jul 2018 15:04:48 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180731041425.GI24813@linux.vnet.ibm.com>
References: <87h8kqrhi0.fsf@notabene.neil.brown.name> <20180723205625.GZ12945@linux.vnet.ibm.com> <87r2jtpqm4.fsf@notabene.neil.brown.name> <20180724225825.GE12945@linux.vnet.ibm.com> <87in53oqzz.fsf@notabene.neil.brown.name> <20180725152250.GN12945@linux.vnet.ibm.com> <87r2jpmqu2.fsf@notabene.neil.brown.name> <20180727031815.GW24813@linux.vnet.ibm.com> <20180727145731.GA2780@linux.vnet.ibm.com> <87zhy8s05i.fsf@notabene.neil.brown.name> <20180731041425.GI24813@linux.vnet.ibm.com>
Message-ID: <87lg9sro5r.fsf@notabene.neil.brown.name>
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

On Mon, Jul 30 2018, Paul E. McKenney wrote:

> On Tue, Jul 31, 2018 at 10:45:45AM +1000, NeilBrown wrote:
>> On Fri, Jul 27 2018, Paul E. McKenney wrote:
>>=20
>> > On Thu, Jul 26, 2018 at 08:18:15PM -0700, Paul E. McKenney wrote:
>> >> On Fri, Jul 27, 2018 at 11:04:37AM +1000, NeilBrown wrote:
>> >> > On Wed, Jul 25 2018, Paul E. McKenney wrote:
>> >> > >>=20
>> >> > >> Looks good ... except ... naming is hard.
>> >> > >>=20
>> >> > >>  is_after_call_rcu_init()  asserts where in the lifecycle we are,
>> >> > >>  is_after_call_rcu() tests where in the lifecycle we are.
>> >> > >>=20
>> >> > >>  The names are similar but the purpose is quite different.
>> >> > >>  Maybe s/is_after_call_rcu_init/call_rcu_init/ ??
>> >> > >
>> >> > > How about rcu_head_init() and rcu_head_after_call_rcu()?
>> >>=20
>> >> Very well, I will pull this change in on my next rebase.
>> >
>> > Like this?
>>=20
>> Hard to say - unwinding white-space damage in my head is too challenging
>> when newlines have been deleted :-(
>
> What???  Don't you like block-structured code?
>
> All kidding aside, how about the following more conventionally formatted
> version?

Wow - it's like I just got new glasses!
Yes - nice an clear and now flaws to be found.  Thanks a lot.

NeilBrown

>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit e3408141ed7d702995b2fdc94703af88aadd226b
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Jul 24 15:28:09 2018 -0700
>
>     rcu: Provide functions for determining if call_rcu() has been invoked
>=20=20=20=20=20
>     This commit adds rcu_head_init() and rcu_head_after_call_rcu() functi=
ons
>     to help RCU users detect when another CPU has passed the specified
>     rcu_head structure and function to call_rcu().  The rcu_head_init()
>     should be invoked before making the structure visible to RCU readers,
>     and then the rcu_head_after_call_rcu() may be invoked from within
>     an RCU read-side critical section on an rcu_head structure that
>     was obtained during a traversal of the data structure in question.
>     The rcu_head_after_call_rcu() function will return true if the rcu_he=
ad
>     structure has already been passed (with the specified function) to
>     call_rcu(), otherwise it will return false.
>=20=20=20=20=20
>     If rcu_head_init() has not been invoked on the rcu_head structure
>     or if the rcu_head (AKA callback) has already been invoked, then
>     rcu_head_after_call_rcu() will do WARN_ON_ONCE().
>=20=20=20=20=20
>     Reported-by: NeilBrown <neilb@suse.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     [ paulmck: Apply neilb naming feedback. ]
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index e4f821165d0b..4db8bcacc51a 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -857,6 +857,46 @@ static inline notrace void rcu_read_unlock_sched_not=
race(void)
>  #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>=20=20
>=20=20
> +/* Has the specified rcu_head structure been handed to call_rcu()? */
> +
> +/*
> + * rcu_head_init - Initialize rcu_head for rcu_head_after_call_rcu()
> + * @rhp: The rcu_head structure to initialize.
> + *
> + * If you intend to invoke rcu_head_after_call_rcu() to test whether a
> + * given rcu_head structure has already been passed to call_rcu(), then
> + * you must also invoke this rcu_head_init() function on it just after
> + * allocating that structure.  Calls to this function must not race with
> + * calls to call_rcu(), rcu_head_after_call_rcu(), or callback invocatio=
n.
> + */
> +static inline void rcu_head_init(struct rcu_head *rhp)
> +{
> +	rhp->func =3D (rcu_callback_t)~0L;
> +}
> +
> +/*
> + * rcu_head_after_call_rcu - Has this rcu_head been passed to call_rcu()?
> + * @rhp: The rcu_head structure to test.
> + * @func: The function passed to call_rcu() along with @rhp.
> + *
> + * Returns @true if the @rhp has been passed to call_rcu() with @func,
> + * and @false otherwise.  Emits a warning in any other case, including
> + * the case where @rhp has already been invoked after a grace period.
> + * Calls to this function must not race with callback invocation.  One w=
ay
> + * to avoid such races is to enclose the call to rcu_head_after_call_rcu=
()
> + * in an RCU read-side critical section that includes a read-side fetch
> + * of the pointer to the structure containing @rhp.
> + */
> +static inline bool
> +rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltf7fAACgkQOeye3VZi
gbkEKQ//VicHcEaMKHfomb99Pw/HD9+tgU6zi8EXSvuvZPhGsuIEF7ALpJsQ2gdn
Y4CGNTePtIAPLBgCGkRJI3luT1BIbt4yeSdYkDVLhux1xIOxz51SB85BtxFn4o3O
0ivRqYJdUK6T35yEMIw3iEa2u79VUd0i4/r0PTKbk9TCPTU6JjddrMfuYK/Q6R/5
pYhPYbOuDOXGDpIfifihjw1JnFw0wSWslVI9gMhEeYM13p3xpUxrqC3raa2F9GOM
OfnQ2RnbHfOC+RTh+hPpsvkoN4W82UUs19pgRwpAMZJp3Z5KGJdA8CSgrX4MBQdA
9D9ERWZx1/R+K9oIqw6qaGQ5EVl1BsUNWN/iLh/7qLZklZzwWM8OblKlWNDmGPGd
Ecyl92fIa2zWI/+/Ceb0AJah6W4vAwrAFUzOJsaOrqluzD7H+lOaZ0hL9ju+1daV
UV+A6C4VPPzlsw94zyyDXH8Dlam6TV8gM9hwYCsM2wDtYEG3/jRhvAl3ClV/0FYm
Yd4+UtGN45s6wefJtNmiv48SXPkPlQQeX5xLSz/ox4O2jHKtM6ojMIKRUrLiz2v0
vM6p9yr8JACRDktiw0dqeXGRBs9oxKRo5+tQoC4daibiyTKmii/ZQ/JWuKe+0am+
31R+aPutdxyusLJfBasUYo/mb0djEe4N6QibIsprc4ugftuNzMk=
=M0Dk
-----END PGP SIGNATURE-----
--=-=-=--
