Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEDLPr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:15:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39318 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEDLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:15:46 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Mike Galbraith <umgwanakikbuti@gmail.com>,
        x86@kernel.org, Mike Galbraith <mgalbraith@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86: UV: raw_spinlock conversion
Date: Fri,  4 May 2018 13:14:59 +0200
Message-Id: <20180504111459.24825-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504111459.24825-1-bigeasy@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Shrug.  Lots of hobbyists have a beast in their basement, right?

Cc: x86@kernel.org
Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/uv/uv_bau.h |   14 +++++++-------
 arch/x86/platform/uv/tlb_uv.c    |   26 +++++++++++++-------------
 arch/x86/platform/uv/uv_time.c   |   20 ++++++++++++--------
 3 files changed, 32 insertions(+), 28 deletions(-)

--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -643,9 +643,9 @@ struct bau_control {
 	cycles_t		send_message;
 	cycles_t		period_end;
 	cycles_t		period_time;
-	spinlock_t		uvhub_lock;
-	spinlock_t		queue_lock;
-	spinlock_t		disable_lock;
+	raw_spinlock_t		uvhub_lock;
+	raw_spinlock_t		queue_lock;
+	raw_spinlock_t		disable_lock;
 	/* tunables */
 	int			max_concurr;
 	int			max_concurr_const;
@@ -847,15 +847,15 @@ static inline int atom_asr(short i, stru
  * to be lowered below the current 'v'.  atomic_add_unless can only stop
  * on equal.
  */
-static inline int atomic_inc_unless_ge(spinlock_t *lock, atomic_t *v, int =
u)
+static inline int atomic_inc_unless_ge(raw_spinlock_t *lock, atomic_t *v, =
int u)
 {
-	spin_lock(lock);
+	raw_spin_lock(lock);
 	if (atomic_read(v) >=3D u) {
-		spin_unlock(lock);
+		raw_spin_unlock(lock);
 		return 0;
 	}
 	atomic_inc(v);
-	spin_unlock(lock);
+	raw_spin_unlock(lock);
 	return 1;
 }
=20
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -740,9 +740,9 @@ static void destination_plugged(struct b
=20
 		quiesce_local_uvhub(hmaster);
=20
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
=20
 		end_uvhub_quiesce(hmaster);
=20
@@ -762,9 +762,9 @@ static void destination_timeout(struct b
=20
 		quiesce_local_uvhub(hmaster);
=20
-		spin_lock(&hmaster->queue_lock);
+		raw_spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		spin_unlock(&hmaster->queue_lock);
+		raw_spin_unlock(&hmaster->queue_lock);
=20
 		end_uvhub_quiesce(hmaster);
=20
@@ -785,7 +785,7 @@ static void disable_for_period(struct ba
 	cycles_t tm1;
=20
 	hmaster =3D bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 =3D get_cycles();
@@ -798,7 +798,7 @@ static void disable_for_period(struct ba
 			}
 		}
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 }
=20
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -861,7 +861,7 @@ static void record_send_stats(cycles_t t
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *st=
at)
 {
-	spinlock_t *lock =3D &hmaster->uvhub_lock;
+	raw_spinlock_t *lock =3D &hmaster->uvhub_lock;
 	atomic_t *v;
=20
 	v =3D &hmaster->active_descriptor_count;
@@ -995,7 +995,7 @@ static int check_enable(struct bau_contr
 	struct bau_control *hmaster;
=20
 	hmaster =3D bcp->uvhub_master;
-	spin_lock(&hmaster->disable_lock);
+	raw_spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >=3D bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -1007,10 +1007,10 @@ static int check_enable(struct bau_contr
 				tbcp->period_giveups =3D 0;
 			}
 		}
-		spin_unlock(&hmaster->disable_lock);
+		raw_spin_unlock(&hmaster->disable_lock);
 		return 0;
 	}
-	spin_unlock(&hmaster->disable_lock);
+	raw_spin_unlock(&hmaster->disable_lock);
 	return -1;
 }
=20
@@ -1941,9 +1941,9 @@ static void __init init_per_cpu_tunables
 		bcp->cong_reps			=3D congested_reps;
 		bcp->disabled_period		=3D sec_2_cycles(disabled_period);
 		bcp->giveup_limit		=3D giveup_limit;
-		spin_lock_init(&bcp->queue_lock);
-		spin_lock_init(&bcp->uvhub_lock);
-		spin_lock_init(&bcp->disable_lock);
+		raw_spin_lock_init(&bcp->queue_lock);
+		raw_spin_lock_init(&bcp->uvhub_lock);
+		raw_spin_lock_init(&bcp->disable_lock);
 	}
 }
=20
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -57,7 +57,7 @@ static DEFINE_PER_CPU(struct clock_event
=20
 /* There is one of these allocated per node */
 struct uv_rtc_timer_head {
-	spinlock_t	lock;
+	raw_spinlock_t	lock;
 	/* next cpu waiting for timer, local node relative: */
 	int		next_cpu;
 	/* number of cpus on this node: */
@@ -177,7 +177,7 @@ static __init int uv_rtc_allocate_timers
 				uv_rtc_deallocate_timers();
 				return -ENOMEM;
 			}
-			spin_lock_init(&head->lock);
+			raw_spin_lock_init(&head->lock);
 			head->ncpus =3D uv_blade_nr_possible_cpus(bid);
 			head->next_cpu =3D -1;
 			blade_info[bid] =3D head;
@@ -231,7 +231,7 @@ static int uv_rtc_set_timer(int cpu, u64
 	unsigned long flags;
 	int next_cpu;
=20
-	spin_lock_irqsave(&head->lock, flags);
+	raw_spin_lock_irqsave(&head->lock, flags);
=20
 	next_cpu =3D head->next_cpu;
 	*t =3D expires;
@@ -243,12 +243,12 @@ static int uv_rtc_set_timer(int cpu, u64
 		if (uv_setup_intr(cpu, expires)) {
 			*t =3D ULLONG_MAX;
 			uv_rtc_find_next_timer(head, pnode);
-			spin_unlock_irqrestore(&head->lock, flags);
+			raw_spin_unlock_irqrestore(&head->lock, flags);
 			return -ETIME;
 		}
 	}
=20
-	spin_unlock_irqrestore(&head->lock, flags);
+	raw_spin_unlock_irqrestore(&head->lock, flags);
 	return 0;
 }
=20
@@ -267,7 +267,7 @@ static int uv_rtc_unset_timer(int cpu, i
 	unsigned long flags;
 	int rc =3D 0;
=20
-	spin_lock_irqsave(&head->lock, flags);
+	raw_spin_lock_irqsave(&head->lock, flags);
=20
 	if ((head->next_cpu =3D=3D bcpu && uv_read_rtc(NULL) >=3D *t) || force)
 		rc =3D 1;
@@ -279,7 +279,7 @@ static int uv_rtc_unset_timer(int cpu, i
 			uv_rtc_find_next_timer(head, pnode);
 	}
=20
-	spin_unlock_irqrestore(&head->lock, flags);
+	raw_spin_unlock_irqrestore(&head->lock, flags);
=20
 	return rc;
 }
@@ -299,13 +299,17 @@ static int uv_rtc_unset_timer(int cpu, i
 static u64 uv_read_rtc(struct clocksource *cs)
 {
 	unsigned long offset;
+	u64 cycles;
=20
+	preempt_disable();
 	if (uv_get_min_hub_revision_id() =3D=3D 1)
 		offset =3D 0;
 	else
 		offset =3D (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
=20
-	return (u64)uv_read_local_mmr(UVH_RTC | offset);
+	cycles =3D (u64)uv_read_local_mmr(UVH_RTC | offset);
+	preempt_enable();
+	return cycles;
 }
=20
 /*
