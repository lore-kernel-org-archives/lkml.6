Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEA1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0A820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0A820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965728AbeFRKPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:15:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54545 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934242AbeFRKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:15:28 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fUrC1-0008Vt-MM; Mon, 18 Jun 2018 12:15:25 +0200
Date:   Mon, 18 Jun 2018 12:15:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.15-rt7
Message-ID: <20180618101524.6mrngxrcmbjktyck@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.15-rt7 patch set. 

Changes since v4.16.15-rt6:

  - Add the mm/memcontro pach back to fix a "sleeping while atomic"
    warning. It was dropped in the v4.16 cycle because it was wrongly
    assumed that it is not longer required. Reported by Mike Galbraith.

  - Add a percpu_ida fix from upstream.

  - Drop the patch for the X86 Ultraviolet platform. It should be merged
    upstream because PREEMPT causes warnings, too. This is not going to
    happen so I drop it from RT since nobody cares.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.15-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.15-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.15-rt7

The RT patch against v4.16.15 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.15-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.15-rt7.tar.xz

Sebastian

diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 2242c3ae1bb6..7803114aa140 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -642,9 +642,9 @@ struct bau_control {
 	cycles_t		send_message;
 	cycles_t		period_end;
 	cycles_t		period_time;
-	raw_spinlock_t		uvhub_lock;
-	raw_spinlock_t		queue_lock;
-	raw_spinlock_t		disable_lock;
+	spinlock_t		uvhub_lock;
+	spinlock_t		queue_lock;
+	spinlock_t		disable_lock;
 	/* tunables */
 	int			max_concurr;
 	int			max_concurr_const;
@@ -846,15 +846,15 @@ static inline int atom_asr(short i, struct atomic_short *v)
  * to be lowered below the current 'v'.  atomic_add_unless can only stop
  * on equal.
  */
-static inline int atomic_inc_unless_ge(raw_spinlock_t *lock, atomic_t *v, int u)
+static inline int atomic_inc_unless_ge(spinlock_t *lock, atomic_t *v, int u)
 {
-	raw_spin_lock(lock);
+	spin_lock(lock);
 	if (atomic_read(v) >= u) {
-		raw_spin_unlock(lock);
+		spin_unlock(lock);
 		return 0;
 	}
 	atomic_inc(v);
-	raw_spin_unlock(lock);
+	spin_unlock(lock);
 	return 1;
 }
 
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index ca74e1e24dcd..b36caae0fb2f 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -740,9 +740,9 @@ static void destination_plugged(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		raw_spin_lock(&hmaster->queue_lock);
+		spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		raw_spin_unlock(&hmaster->queue_lock);
+		spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -762,9 +762,9 @@ static void destination_timeout(struct bau_desc *bau_desc,
 
 		quiesce_local_uvhub(hmaster);
 
-		raw_spin_lock(&hmaster->queue_lock);
+		spin_lock(&hmaster->queue_lock);
 		reset_with_ipi(&bau_desc->distribution, bcp);
-		raw_spin_unlock(&hmaster->queue_lock);
+		spin_unlock(&hmaster->queue_lock);
 
 		end_uvhub_quiesce(hmaster);
 
@@ -785,7 +785,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 	cycles_t tm1;
 
 	hmaster = bcp->uvhub_master;
-	raw_spin_lock(&hmaster->disable_lock);
+	spin_lock(&hmaster->disable_lock);
 	if (!bcp->baudisabled) {
 		stat->s_bau_disabled++;
 		tm1 = get_cycles();
@@ -798,7 +798,7 @@ static void disable_for_period(struct bau_control *bcp, struct ptc_stats *stat)
 			}
 		}
 	}
-	raw_spin_unlock(&hmaster->disable_lock);
+	spin_unlock(&hmaster->disable_lock);
 }
 
 static void count_max_concurr(int stat, struct bau_control *bcp,
@@ -861,7 +861,7 @@ static void record_send_stats(cycles_t time1, cycles_t time2,
  */
 static void uv1_throttle(struct bau_control *hmaster, struct ptc_stats *stat)
 {
-	raw_spinlock_t *lock = &hmaster->uvhub_lock;
+	spinlock_t *lock = &hmaster->uvhub_lock;
 	atomic_t *v;
 
 	v = &hmaster->active_descriptor_count;
@@ -995,7 +995,7 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 	struct bau_control *hmaster;
 
 	hmaster = bcp->uvhub_master;
-	raw_spin_lock(&hmaster->disable_lock);
+	spin_lock(&hmaster->disable_lock);
 	if (bcp->baudisabled && (get_cycles() >= bcp->set_bau_on_time)) {
 		stat->s_bau_reenabled++;
 		for_each_present_cpu(tcpu) {
@@ -1007,10 +1007,10 @@ static int check_enable(struct bau_control *bcp, struct ptc_stats *stat)
 				tbcp->period_giveups = 0;
 			}
 		}
-		raw_spin_unlock(&hmaster->disable_lock);
+		spin_unlock(&hmaster->disable_lock);
 		return 0;
 	}
-	raw_spin_unlock(&hmaster->disable_lock);
+	spin_unlock(&hmaster->disable_lock);
 	return -1;
 }
 
@@ -1942,9 +1942,9 @@ static void __init init_per_cpu_tunables(void)
 		bcp->cong_reps			= congested_reps;
 		bcp->disabled_period		= sec_2_cycles(disabled_period);
 		bcp->giveup_limit		= giveup_limit;
-		raw_spin_lock_init(&bcp->queue_lock);
-		raw_spin_lock_init(&bcp->uvhub_lock);
-		raw_spin_lock_init(&bcp->disable_lock);
+		spin_lock_init(&bcp->queue_lock);
+		spin_lock_init(&bcp->uvhub_lock);
+		spin_lock_init(&bcp->disable_lock);
 	}
 }
 
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index badf377efc21..b082d71b08ee 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -57,7 +57,7 @@ static DEFINE_PER_CPU(struct clock_event_device, cpu_ced);
 
 /* There is one of these allocated per node */
 struct uv_rtc_timer_head {
-	raw_spinlock_t	lock;
+	spinlock_t	lock;
 	/* next cpu waiting for timer, local node relative: */
 	int		next_cpu;
 	/* number of cpus on this node: */
@@ -177,7 +177,7 @@ static __init int uv_rtc_allocate_timers(void)
 				uv_rtc_deallocate_timers();
 				return -ENOMEM;
 			}
-			raw_spin_lock_init(&head->lock);
+			spin_lock_init(&head->lock);
 			head->ncpus = uv_blade_nr_possible_cpus(bid);
 			head->next_cpu = -1;
 			blade_info[bid] = head;
@@ -231,7 +231,7 @@ static int uv_rtc_set_timer(int cpu, u64 expires)
 	unsigned long flags;
 	int next_cpu;
 
-	raw_spin_lock_irqsave(&head->lock, flags);
+	spin_lock_irqsave(&head->lock, flags);
 
 	next_cpu = head->next_cpu;
 	*t = expires;
@@ -243,12 +243,12 @@ static int uv_rtc_set_timer(int cpu, u64 expires)
 		if (uv_setup_intr(cpu, expires)) {
 			*t = ULLONG_MAX;
 			uv_rtc_find_next_timer(head, pnode);
-			raw_spin_unlock_irqrestore(&head->lock, flags);
+			spin_unlock_irqrestore(&head->lock, flags);
 			return -ETIME;
 		}
 	}
 
-	raw_spin_unlock_irqrestore(&head->lock, flags);
+	spin_unlock_irqrestore(&head->lock, flags);
 	return 0;
 }
 
@@ -267,7 +267,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
 	unsigned long flags;
 	int rc = 0;
 
-	raw_spin_lock_irqsave(&head->lock, flags);
+	spin_lock_irqsave(&head->lock, flags);
 
 	if ((head->next_cpu == bcpu && uv_read_rtc(NULL) >= *t) || force)
 		rc = 1;
@@ -279,7 +279,7 @@ static int uv_rtc_unset_timer(int cpu, int force)
 			uv_rtc_find_next_timer(head, pnode);
 	}
 
-	raw_spin_unlock_irqrestore(&head->lock, flags);
+	spin_unlock_irqrestore(&head->lock, flags);
 
 	return rc;
 }
@@ -299,17 +299,13 @@ static int uv_rtc_unset_timer(int cpu, int force)
 static u64 uv_read_rtc(struct clocksource *cs)
 {
 	unsigned long offset;
-	u64 cycles;
 
-	preempt_disable();
 	if (uv_get_min_hub_revision_id() == 1)
 		offset = 0;
 	else
 		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
 
-	cycles = (u64)uv_read_local_mmr(UVH_RTC | offset);
-	preempt_enable();
-	return cycles;
+	return (u64)uv_read_local_mmr(UVH_RTC | offset);
 }
 
 /*
diff --git a/lib/percpu_ida.c b/lib/percpu_ida.c
index 9bbd9c5d375a..beb14839b41a 100644
--- a/lib/percpu_ida.c
+++ b/lib/percpu_ida.c
@@ -141,7 +141,7 @@ int percpu_ida_alloc(struct percpu_ida *pool, int state)
 	spin_lock_irqsave(&tags->lock, flags);
 
 	/* Fastpath */
-	if (likely(tags->nr_free >= 0)) {
+	if (likely(tags->nr_free)) {
 		tag = tags->freelist[--tags->nr_free];
 		spin_unlock_irqrestore(&tags->lock, flags);
 		return tag;
diff --git a/localversion-rt b/localversion-rt
index 8fc605d80667..045478966e9f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 93bf018af10e..82d1842ef814 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1786,7 +1786,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu = get_cpu();
+	curcpu = get_cpu_light();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -1806,7 +1806,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		}
 		css_put(&memcg->css);
 	}
-	put_cpu();
+	put_cpu_light();
 	mutex_unlock(&percpu_charge_mutex);
 }
 
