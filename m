Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeCHDmz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 22:42:55 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33619 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbeCHDmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 22:42:53 -0500
X-Google-Smtp-Source: AG47ELtyqnrE9ov0ioNoaFUwTgdaJDdSXQsXqx4fuh2MtCYQzR0Ji3KoK8KtEaiVIYoP/9ug7FhinQ==
X-ME-Sender: <xms:N7GgWv9P4qQoE4UPc7K6Un-UTpv4kB9fjTG_-RR8QvH3JUsYZHKvdQ>
Date: Thu, 8 Mar 2018 11:46:27 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: exp: Fix "must hold exp_mutex" comments for QS
 reporting functions
Message-ID: <20180308034627.n2xw32zzujnmy2gb@tardis>
References: <20180307084944.10229-1-boqun.feng@gmail.com>
 <20180307154829.GE3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nym733cdcminardu"
Content-Disposition: inline
In-Reply-To: <20180307154829.GE3918@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nym733cdcminardu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 07:48:29AM -0800, Paul E. McKenney wrote:
> On Wed, Mar 07, 2018 at 04:49:39PM +0800, Boqun Feng wrote:
> > Since commit d9a3da0699b2 ("rcu: Add expedited grace-period support for
> > preemptible RCU"), there are comments for some funtions in
> > rcu_report_exp_rnp()'s call-chain saying that exp_mutex or its
> > predecessors needs to be held.
> >=20
> > However, exp_mutex and its predecessors are merely used for synchronize
> > between GPs, and it's clearly that all variables visited by those
> > functions are under the protection of rcu_node's ->lock. Moreover, those
> > functions are currently called without held exp_mutex, and seems that
> > doesn't introduce any trouble.
> >=20
> > So this patch fix this problem by correcting the comments
> >=20
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Fixes: d9a3da0699b2 ("rcu: Add expedited grace-period support for preem=
ptible RCU")
>=20
> Good catch, applied!
>=20
> These have been around for almost a decade!  ;-)  They happened because
> I ended up rewriting expedited support several times before it was
> accepted, and apparently failed to update the comments towards the end.
>=20
> So thank you for catching this one!
>=20
> But wouldn't it be better to use lockdep instead of comments in this case?
>=20

Agreed. That's a good idea. And I might find something about this, so I
add this for sync_rcu_preempt_exp_done(),=20

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2fd882b08b7c..1fa394fe2f8a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -20,6 +20,8 @@
  * Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
  */
=20
+#include <linux/lockdep.h>
+
 /*
  * Record the start of an expedited grace period.
  */
@@ -158,6 +160,8 @@ static void __maybe_unused sync_exp_reset_tree(struct r=
cu_state *rsp)
  */
 static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 {
+	BUG_ON(!lockdep_is_held(&rnp->lock));
+
 	return rnp->exp_tasks =3D=3D NULL &&
 	       READ_ONCE(rnp->expmask) =3D=3D 0;
 }

And I could got this with rcutorture (--configs TREE03 --bootargs
"rcutorture.gp_exp=3D1" --duration 10 --kconfig "CONFIG_PROVE_LOCKING=3Dy"):

[    0.013629] ------------[ cut here ]------------=0D
[    0.014000] kernel BUG at /home/fixme/linux-rcu/kernel/rcu/tree_exp.h:16=
3!=0D
[    0.014009] invalid opcode: 0000 [#1] PREEMPT SMP PTI=0D
[    0.014697] Modules linked in:=0D
[    0.014992] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc1+ #1=0D
[    0.015000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-20171110_100015-anatol 04/01/2014=0D
[    0.015000] RIP: 0010:sync_rcu_preempt_exp_done+0x30/0x40=0D
[    0.015000] RSP: 0000:ffffffffb7003d00 EFLAGS: 00010246=0D
[    0.015000] RAX: 0000000000000000 RBX: ffffffffb7064d00 RCX: 00000000000=
00003=0D
[    0.015000] RDX: 0000000080000003 RSI: ffffffffb7064d18 RDI: ffffffffb70=
24da8=0D
[    0.015000] RBP: ffffffffb7064d00 R08: 0000000000000000 R09: 00000000000=
00000=0D
[    0.015000] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffb70=
686d0=0D
[    0.015000] R13: ffffffffb765e2e0 R14: ffffffffb7064d00 R15: 00000000000=
00004=0D
[    0.015000] FS:  0000000000000000(0000) GS:ffff94fb9fc00000(0000) knlGS:=
0000000000000000=0D
[    0.015000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[    0.015000] CR2: ffff94fb8e57f000 CR3: 000000000d01e000 CR4: 00000000000=
006f0=0D
[    0.015000] Call Trace:=0D
[    0.015000]  rcu_exp_wait_wake+0x6d/0x9e0=0D
[    0.015000]  ? rcu_cleanup_dead_rnp+0x90/0x90=0D
[    0.015000]  ? rcu_report_exp_cpu_mult+0x60/0x60=0D
[    0.015000]  _synchronize_rcu_expedited+0x680/0x6f0=0D
[    0.015000]  ? rcu_cleanup_dead_rnp+0x90/0x90=0D
[    0.015000]  ? acpi_hw_read_port+0x4c/0xc2=0D
[    0.015000]  ? acpi_hw_read+0xf4/0x153=0D
[    0.015000]  synchronize_rcu.part.79+0x53/0x60=0D
[    0.015000]  ? acpi_read_bit_register+0x38/0x69=0D
[    0.015000]  rcu_test_sync_prims+0x5/0x20=0D
[    0.015000]  rest_init+0x6/0xc0=0D
[    0.015000]  start_kernel+0x447/0x467=0D
[    0.015000]  secondary_startup_64+0xa5/0xb0=0D
[    0.015000] Code: ff 48 89 fb 48 83 c7 18 e8 9e 52 fd ff 85 c0 74 1a 31 =
c0 48 83 bb c0 00 00 00 00 74 02 5b c3 48 8b 43 68 5b 48 85 c0 0f 94 c0 c3 =
<0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 56 49 89 fe =0D
[    0.015000] RIP: sync_rcu_preempt_exp_done+0x30/0x40 RSP: ffffffffb7003d=
00=0D
[    0.015007] ---[ end trace 09539f6b90637d6c ]---=0D


And I found in rcu_exp_wait_wake(), some of sync_rcu_preempt_exp_done()
are not protected by rcu_node's lock. I have a straight-forward fix
(along with the debug changes I mention above).

With this fix, rcutorture doesn't complain about the lock missing
anymore. I will continue to investigate whether missing lock is a
problem, but in the meanwhile, looking forward to your insight ;-)

Regards,
Boqun
---------------------------------->8
Subject: [PATCH] rcu: exp: Protect sync_rcu_preempt_exp_done() with rcu_node
 lock

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_exp.h | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2fd882b08b7c..0001ac0ce6a7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -20,6 +20,8 @@
  * Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
  */
=20
+#include <linux/lockdep.h>
+
 /*
  * Record the start of an expedited grace period.
  */
@@ -158,10 +160,30 @@ static void __maybe_unused sync_exp_reset_tree(struct=
 rcu_state *rsp)
  */
 static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 {
+	BUG_ON(!lockdep_is_held(&rnp->lock));
+
 	return rnp->exp_tasks =3D=3D NULL &&
 	       READ_ONCE(rnp->expmask) =3D=3D 0;
 }
=20
+/*
+ * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
+ * doesn't hold the rcu_node's ->lock, and will acquire and release the lo=
ck
+ * itself
+ */
+static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
+{
+	unsigned long flags;
+	bool ret;
+
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	ret =3D sync_rcu_preempt_exp_done(rnp);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	return ret;
+}
+
+
 /*
  * Report the exit from RCU read-side critical section for the last task
  * that queued itself during or before the current expedited preemptible-R=
CU
@@ -490,6 +512,7 @@ static void synchronize_sched_expedited_wait(struct rcu=
_state *rsp)
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root =3D rcu_get_root(rsp);
 	int ret;
+	unsigned long flags;
=20
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("st=
artwait"));
 	jiffies_stall =3D rcu_jiffies_till_stall_check();
@@ -498,9 +521,9 @@ static void synchronize_sched_expedited_wait(struct rcu=
_state *rsp)
 	for (;;) {
 		ret =3D swait_event_timeout(
 				rsp->expedited_wq,
-				sync_rcu_preempt_exp_done(rnp_root),
+				sync_rcu_preempt_exp_done_unlocked(rnp_root),
 				jiffies_stall);
-		if (ret > 0 || sync_rcu_preempt_exp_done(rnp_root))
+		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
 			return;
 		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
 		if (rcu_cpu_stall_suppress)
@@ -533,8 +556,14 @@ static void synchronize_sched_expedited_wait(struct rc=
u_state *rsp)
 			rcu_for_each_node_breadth_first(rsp, rnp) {
 				if (rnp =3D=3D rnp_root)
 					continue; /* printed unconditionally */
-				if (sync_rcu_preempt_exp_done(rnp))
+
+				raw_spin_lock_irqsave_rcu_node(rnp, flags);
+				if (sync_rcu_preempt_exp_done(rnp)) {
+					raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 					continue;
+				}
+				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
 				pr_cont(" l=3D%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
 					rnp->expmask,
--=20
2.16.2


--nym733cdcminardu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqgshAACgkQSXnow7UH
+ridSQgAlrq1q/dFzOgWfoO1z/W2SIrZUhD2Fr7YJswx8r06dApSO+Fyccx4c4o4
8H0ppw/cqNDSpob8CmB9Zyd/02kQ+T4Il+4g0bJkkfUEA1+TKIR08vSTPrczo4y3
PX7LEUKvujtSFzCG4WfjLVShES72+giSujI/s8Iw2aOzpsr8iat3mSR9ZOcHKHha
tmksE8AlY1DZ5PpqX/Z74TO5ulb0GFVjt0F4hntf1w58z7qzer1rua2WGJZoTf21
OI119hw/RlGdkhjNU4cZPdpPPVyB+B/xUSiw+0++0cIrKYBRjW1aOsZTgrxyXGO8
poJF+wl3FKrZ/EafrxEDZPnzL9+86g==
=2Wat
-----END PGP SIGNATURE-----

--nym733cdcminardu--
