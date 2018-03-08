Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbeCHWs5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:48:57 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38437 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeCHWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:48:55 -0500
X-Google-Smtp-Source: AG47ELt0+I84eELwluEIswkxnKK229Tj8gj1YCFww4VB5J7E5Ebw99J/eOZLRQdy8auowB3cK5rlzA==
X-ME-Sender: <xms:0r2hWmGkwMrseHm8qyD8wNh6zY0Zf779vEqqjgpXIEP0LBsvudocVQ>
Date: Fri, 9 Mar 2018 06:52:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rcu:rcu/dev 39/39] kernel/rcu/tree_exp.h:163:9: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <20180308225234.v2v6v5tnfkutwu5u@tardis>
References: <201803090524.gbCGY9DF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qwe4jb2eidhy67w2"
Content-Disposition: inline
In-Reply-To: <201803090524.gbCGY9DF%fengguang.wu@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qwe4jb2eidhy67w2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 05:41:27AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu=
=2Egit rcu/dev
> head:   b8909ec707bb5beba94e7c7d62cc6b3115ceae50
> commit: b8909ec707bb5beba94e7c7d62cc6b3115ceae50 [39/39] rcu: Protect all=
 sync_rcu_preempt_exp_done() with rcu_node lock
> reproduce:
>         # apt-get install sparse
>         git checkout b8909ec707bb5beba94e7c7d62cc6b3115ceae50
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
[...]
>    kernel/rcu/tree.c:345:6: sparse: symbol 'rcu_dynticks_curr_cpu_in_eqs'=
 was not declared. Should it be static?
>    kernel/rcu/tree.c:3953:21: sparse: incorrect type in argument 1 (diffe=
rent modifiers) @@    expected int ( *threadfn )( ... ) @@    got int ( [no=
reint ( *threadfn )( ... ) @@
>    kernel/rcu/tree.c:3953:21:    expected int ( *threadfn )( ... )
>    kernel/rcu/tree.c:3953:21:    got int ( [noreturn] *<noident> )( ... )
> >> kernel/rcu/tree_exp.h:163:9: sparse: incorrect type in argument 1 (dif=
ferent modifiers) @@    expected struct lockdep_map const *lock @@    got s=
trustruct lockdep_map const *lock @@
>    kernel/rcu/tree_exp.h:163:9:    expected struct lockdep_map const *lock
>    kernel/rcu/tree_exp.h:163:9:    got struct lockdep_map [noderef] *<noi=
dent>
>    kernel/rcu/tree.c:1752:9: sparse: context imbalance in 'rcu_start_futu=
re_gp' - different lock contexts for basic block
>    kernel/rcu/tree.c:2786:9: sparse: context imbalance in 'force_qs_rnp' =
- different lock contexts for basic block
>    kernel/rcu/tree.c:2849:25: sparse: context imbalance in 'force_quiesce=
nt_state' - unexpected unlock
>    kernel/rcu/tree_exp.h:203:9: sparse: too many warnings
>=20
> vim +163 kernel/rcu/tree_exp.h
>=20
>    151=09
>    152	/*
>    153	 * Return non-zero if there is no RCU expedited grace period in pr=
ogress
>    154	 * for the specified rcu_node structure, in other words, if all CP=
Us and
>    155	 * tasks covered by the specified rcu_node structure have done the=
ir bit
>    156	 * for the current expedited grace period.  Works only for preempt=
ible
>    157	 * RCU -- other RCU implementation use other means.
>    158	 *
>    159	 * Caller must hold the specificed rcu_node structure's ->lock
>    160	 */
>    161	static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
>    162	{
>  > 163		lockdep_assert_held(&rnp->lock);

OK, so we need ACCESS_PRIVATE() to visit ->lock in rcu_node. I will
introduce something like:

	#define rcu_node_lock_assert_held(rnp) lockdep_assert_held(&ACCESS_PRIVATE=
(rnp, lock))

in v3.

Regards,
Boqun
>    164=09
>    165		return rnp->exp_tasks =3D=3D NULL &&
>    166		       READ_ONCE(rnp->expmask) =3D=3D 0;
>    167	}
>    168=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

--qwe4jb2eidhy67w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqhvq4ACgkQSXnow7UH
+rishggAmltAWp48hBQYJCdcjMV7v5vCI/sXUxsNJ31gv7Z3olltfHlpn794oaU6
uw+dk8p3t1TIcBKQYOzfDeUn5jEXzvpYI+BsKfuUsOMvPJ04IgR5sH7SnDrW2B+R
+kWB569m4SQIoEMKpSZqU5duNwB/J4FBT6Wqa1DFNEaiAHbeTTi7tsPH0O1G/BaB
MCRmRlOJ6XLpHoGBj0t5UgyWCmYI+mdLd7f5VqOskMq89fgAifVm3uVnkcSkq6sk
CvQCXA8uI8njUghujMtf3Sacys+2JI1zJc5tE1NR3tvOYPtPT3YifA9i4XPJeJFj
39R0hPT2H9FDZg07kTHjOtNRDnrWXA==
=qhJf
-----END PGP SIGNATURE-----

--qwe4jb2eidhy67w2--
