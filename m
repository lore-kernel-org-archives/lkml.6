Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147EFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BCD208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BCD208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGaCXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:23:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731503AbeGaCXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:23:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F18A5AD44;
        Tue, 31 Jul 2018 00:45:53 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com
Date:   Tue, 31 Jul 2018 10:45:45 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180727145731.GA2780@linux.vnet.ibm.com>
References: <87muulqq8q.fsf@notabene.neil.brown.name> <20180722215446.GH12945@linux.vnet.ibm.com> <87h8kqrhi0.fsf@notabene.neil.brown.name> <20180723205625.GZ12945@linux.vnet.ibm.com> <87r2jtpqm4.fsf@notabene.neil.brown.name> <20180724225825.GE12945@linux.vnet.ibm.com> <87in53oqzz.fsf@notabene.neil.brown.name> <20180725152250.GN12945@linux.vnet.ibm.com> <87r2jpmqu2.fsf@notabene.neil.brown.name> <20180727031815.GW24813@linux.vnet.ibm.com> <20180727145731.GA2780@linux.vnet.ibm.com>
Message-ID: <87zhy8s05i.fsf@notabene.neil.brown.name>
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

On Fri, Jul 27 2018, Paul E. McKenney wrote:

> On Thu, Jul 26, 2018 at 08:18:15PM -0700, Paul E. McKenney wrote:
>> On Fri, Jul 27, 2018 at 11:04:37AM +1000, NeilBrown wrote:
>> > On Wed, Jul 25 2018, Paul E. McKenney wrote:
>> > >>=20
>> > >> Looks good ... except ... naming is hard.
>> > >>=20
>> > >>  is_after_call_rcu_init()  asserts where in the lifecycle we are,
>> > >>  is_after_call_rcu() tests where in the lifecycle we are.
>> > >>=20
>> > >>  The names are similar but the purpose is quite different.
>> > >>  Maybe s/is_after_call_rcu_init/call_rcu_init/ ??
>> > >
>> > > How about rcu_head_init() and rcu_head_after_call_rcu()?
>>=20
>> Very well, I will pull this change in on my next rebase.
>
> Like this?

Hard to say - unwinding white-space damage in my head is too challenging
when newlines have been deleted :-(

Thanks,
NeilBrown

>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 45dfdcaee39bf6dd1785253c78e4805122ee8d93
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Jul 24 15:28:09 2018 -0700
>
>     rcu: Provide functions for determining if call_rcu() has been invoked
>
>     This commit adds rcu_head_init() and rcu_head_after_call_rcu()
>     functions to help RCU users detect when another CPU has passed
>     the specified rcu_head structure and function to call_rcu().
>     The rcu_head_init() should be invoked before making the structure
>     visible to RCU readers, and then the rcu_head_after_call_rcu()
>     may be invoked from within an RCU read-side critical section on an
>     rcu_head structure that was obtained during a traversal of the data
>     structure in question.  The rcu_head_after_call_rcu() function will
>     return true if the rcu_head structure has already been passed (with
>     the specified function) to call_rcu(), otherwise it will return false.
>
>     If rcu_head_init() has not been invoked on the rcu_head structure
>     or if the rcu_head (AKA callback) has already been invoked, then
>     rcu_head_after_call_rcu() will do WARN_ON_ONCE().
>
>     Reported-by: NeilBrown <neilb@suse.com> Signed-off-by: Paul
>     E. McKenney <paulmck@linux.vnet.ibm.com> [ paulmck: Apply neilb
>     feedback on naming. ]
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h index
> e4f821165d0b..4db8bcacc51a 100644 --- a/include/linux/rcupdate.h +++
> b/include/linux/rcupdate.h @@ -857,6 +857,46 @@ static inline notrace
> void rcu_read_unlock_sched_notrace(void)
>  #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>
>
> +/* Has the specified rcu_head structure been handed to call_rcu()? */ +
> +/* + * rcu_head_init - Initialize rcu_head for rcu_head_after_call_rcu()
> + * @rhp: The rcu_head structure to initialize.  + * + * If you intend
> to invoke rcu_head_after_call_rcu() to test whether a + * given rcu_head
> structure has already been passed to call_rcu(), then + * you must also
> invoke this rcu_head_init() function on it just after + * allocating
> that structure.  Calls to this function must not race with + * calls
> to call_rcu(), rcu_head_after_call_rcu(), or callback invocation.
> + */ +static inline void rcu_head_init(struct rcu_head *rhp) +{ +
> rhp->func =3D (rcu_callback_t)~0L; +} + +/* + * rcu_head_after_call_rcu -
> Has this rcu_head been passed to call_rcu()?  + * @rhp: The rcu_head
> structure to test.  + * @func: The function passed to call_rcu()
> along with @rhp.  + * + * Returns @true if the @rhp has been passed to
> call_rcu() with @func, + * and @false otherwise.  Emits a warning in any
> other case, including + * the case where @rhp has already been invoked
> after a grace period.  + * Calls to this function must not race with
> callback invocation.  One way + * to avoid such races is to enclose the
> call to rcu_head_after_call_rcu() + * in an RCU read-side critical section
> that includes a read-side fetch + * of the pointer to the structure
> containing @rhp.  + */ +static inline bool +rcu_head_after_call_rcu(struct
> rcu_head *rhp, rcu_callback_t f) +{ +	    if (READ_ONCE(rhp->func) =3D=3D=
 f)
> +		return true; +	     WARN_ON_ONCE(READ_ONCE(rhp->func) !=3D
> (rcu_callback_t)~0L); +       return false; +} + +
>  /* Transitional pre-consolidation compatibility definitions. */
>
>  static inline void synchronize_rcu_bh(void)
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index
> 5dec94509a7e..4c56c1d98fb3 100644 --- a/kernel/rcu/rcu.h +++
> b/kernel/rcu/rcu.h @@ -224,6 +224,7 @@ void kfree(const void *);
>   */
>  static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head) {
> +	rcu_callback_t f;
> 	unsigned long offset =3D (unsigned long)head->func;
>
> 	rcu_lock_acquire(&rcu_callback_map);
> @@ -234,7 +235,9 @@ static inline bool __rcu_reclaim(const char *rn,
> struct rcu_head *head)
> 		return true;
> 	} else {
> 		RCU_TRACE(trace_rcu_invoke_callback(rn, head);)
> -		head->func(head); +		  f =3D head->func; +
> WRITE_ONCE(head->func, (rcu_callback_t)0L); +		    f(head);
> 		rcu_lock_release(&rcu_callback_map); return false;
> 	}

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltfsTkACgkQOeye3VZi
gbnSpg/7Bmj7OP2K+KzrKRgu1A0/gxOvy22OlFK3o2zxUVPJSiGre2Fdy6vckhmC
d5tGLaQOP1JYjdqJH1nOfJmNFdhNHm+QC7mxp33PKk5ouHlDhpNheQKGI3/dHCdv
KwZiDq0c2Tbw5I8N5u/xPY2WJYEJrlQT9EHkDn1vwgQJDw5VD9A2SX1tLaetJuxX
yHydyKdL/WFWRPFdRQcmgjkONJsxOIohKHz7PQmXc4yEaVTAc/7TBE48DLoGKBQX
MX6kqpHpc/FaMzyn8R9hepG2Q6e6k9yo/jU25hXW1xs5iNPEt1gv7OZhreW0BpK9
GouGCLAckDdwpKKtLksyAKriQ+tLUzAbjFLwZb3MP7V/dQKerdc0Wc+d+ossDHOJ
1CXCAnl/iKyO1GnzptQfg6cN5foIA97TTFwxWjf3LZdcJ1QF4zjUvgub7+fy3lp7
48ecmkwYCeL2mQONArJIzdv3HY9OSwaNwfExEC6IoQOvdGG2TBLS2kNqgAyKTNbG
mCutQEwZ0A5dpIzf8SpE28/DtvTS/NeKgt9HY0ipmWn+XVThHZ/3esVnKQ+r441r
IAMK7wdVYUm4fozkcgW05GjdhLih+jOu1q0Pk9tzHFsfZ1pv19LXu6CHvLNzsZ2+
pFrfm4l7Zyt7m3yAvy3nn6kfyEtXG3RsQssEUrNqAjy7BuoCl04=
=94dD
-----END PGP SIGNATURE-----
--=-=-=--
