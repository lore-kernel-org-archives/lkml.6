Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeCIAsQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:48:16 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34613 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCIAsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:48:14 -0500
X-Google-Smtp-Source: AG47ELsWHztKGXZDyjBYFgT6Iu8an2WdSOCRQ9aY/fhRsDfqBIEaJs+4WC+/paKqQPtQJ3vqH7U19A==
X-ME-Sender: <xms:zNmhWhqdDfOqsD8GcNqb8Hgi1aXcFevPrM5bNQPKBoNk_NHLWXzZJg>
Date: Fri, 9 Mar 2018 08:51:54 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/dev 39/39] kernel/rcu/tree_exp.h:163:9: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <20180309005154.ujapyqqzmwafuo5t@tardis>
References: <201803090524.gbCGY9DF%fengguang.wu@intel.com>
 <20180308225234.v2v6v5tnfkutwu5u@tardis>
 <20180309003443.GX3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akwxy2wep2y7hn6e"
Content-Disposition: inline
In-Reply-To: <20180309003443.GX3918@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--akwxy2wep2y7hn6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 04:34:43PM -0800, Paul E. McKenney wrote:
> On Fri, Mar 09, 2018 at 06:52:34AM +0800, Boqun Feng wrote:
> > On Fri, Mar 09, 2018 at 05:41:27AM +0800, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux=
-rcu.git rcu/dev
> > > head:   b8909ec707bb5beba94e7c7d62cc6b3115ceae50
> > > commit: b8909ec707bb5beba94e7c7d62cc6b3115ceae50 [39/39] rcu: Protect=
 all sync_rcu_preempt_exp_done() with rcu_node lock
> > > reproduce:
> > >         # apt-get install sparse
> > >         git checkout b8909ec707bb5beba94e7c7d62cc6b3115ceae50
> > >         make ARCH=3Dx86_64 allmodconfig
> > >         make C=3D1 CF=3D-D__CHECK_ENDIAN__
> > >=20
> > >=20
> > > sparse warnings: (new ones prefixed by >>)
> > >=20
> > [...]
> > >    kernel/rcu/tree.c:345:6: sparse: symbol 'rcu_dynticks_curr_cpu_in_=
eqs' was not declared. Should it be static?
> > >    kernel/rcu/tree.c:3953:21: sparse: incorrect type in argument 1 (d=
ifferent modifiers) @@    expected int ( *threadfn )( ... ) @@    got int (=
 [noreint ( *threadfn )( ... ) @@
> > >    kernel/rcu/tree.c:3953:21:    expected int ( *threadfn )( ... )
> > >    kernel/rcu/tree.c:3953:21:    got int ( [noreturn] *<noident> )( .=
=2E. )
> > > >> kernel/rcu/tree_exp.h:163:9: sparse: incorrect type in argument 1 =
(different modifiers) @@    expected struct lockdep_map const *lock @@    g=
ot strustruct lockdep_map const *lock @@
> > >    kernel/rcu/tree_exp.h:163:9:    expected struct lockdep_map const =
*lock
> > >    kernel/rcu/tree_exp.h:163:9:    got struct lockdep_map [noderef] *=
<noident>
> > >    kernel/rcu/tree.c:1752:9: sparse: context imbalance in 'rcu_start_=
future_gp' - different lock contexts for basic block
> > >    kernel/rcu/tree.c:2786:9: sparse: context imbalance in 'force_qs_r=
np' - different lock contexts for basic block
> > >    kernel/rcu/tree.c:2849:25: sparse: context imbalance in 'force_qui=
escent_state' - unexpected unlock
> > >    kernel/rcu/tree_exp.h:203:9: sparse: too many warnings
> > >=20
> > > vim +163 kernel/rcu/tree_exp.h
> > >=20
> > >    151=09
> > >    152	/*
> > >    153	 * Return non-zero if there is no RCU expedited grace period i=
n progress
> > >    154	 * for the specified rcu_node structure, in other words, if al=
l CPUs and
> > >    155	 * tasks covered by the specified rcu_node structure have done=
 their bit
> > >    156	 * for the current expedited grace period.  Works only for pre=
emptible
> > >    157	 * RCU -- other RCU implementation use other means.
> > >    158	 *
> > >    159	 * Caller must hold the specificed rcu_node structure's ->lock
> > >    160	 */
> > >    161	static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
> > >    162	{
> > >  > 163		lockdep_assert_held(&rnp->lock);
> >=20
> > OK, so we need ACCESS_PRIVATE() to visit ->lock in rcu_node. I will
> > introduce something like:
> >=20
> > 	#define rcu_node_lock_assert_held(rnp) lockdep_assert_held(&ACCESS_PRI=
VATE(rnp, lock))
> >=20
> > in v3.
>=20
> Or use this, which is in kernel/rcu/rcu.h:
>=20
> #define raw_lockdep_assert_held_rcu_node(p)				\
> 	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
>=20

Good point, thank you for pointing this out ;-)

Regards,
Boqun

> 							Thanx, Paul
>=20

--akwxy2wep2y7hn6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqh2qcACgkQSXnow7UH
+rhfWwf/RDGxuAl3IZ/ojBBokGfDAETFSf6r8dFsy3EPDKkNdEDeuD0X/b24lggX
erNbYXwk1TLgGRx7KXbc1oyVeCsaIjMONtVzh6A1ceOK5sweJH8QDEcZ/Q/vCkLf
qMJLM5JmE+yBAUMdjuM8N9TLfu3ehHqkKMyUu75M8qlRRamAZIhVYnK4lNxlt9iZ
g31XBO2df+CH+aKHqhy7wMiFg00gFiGPhnngDUwiEH1KR0ptl8xi79FLM2aGtsqj
0wvwRYAubO06c9rH0Hy0lvI7ZEWA1tSJvR5SkvrXABDaCAZq8wgi6XYzqCMfnR05
JjhZwJCEFSxFHuVMfEuJhZxX6M4DAA==
=HBR+
-----END PGP SIGNATURE-----

--akwxy2wep2y7hn6e--
