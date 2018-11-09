Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA420C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF9120883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF9120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKJAgB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:36:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJAgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:36:00 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gL8BW-0006Ti-5B; Fri, 09 Nov 2018 15:54:58 +0100
Date:   Fri, 9 Nov 2018 15:54:58 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.19.1-rt3
Message-ID: <20181109145457.ql57auel3bzwdsk5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.19.1-rt3 patch set. 

Changes since v4.19.1-rt2:

  - A patch to the bcm2835 pinctrl driver to use raw_spinlock_t. Patch
    by Lukas Wunner.

  - The Atmel TCB timer patch set by Alexandre Belloni has been update
    to v7.

  - The RCU Kconfig entry has been tweaked and now it is no longer
    required to enable RCU_EXPERT in order to enable RCU_BOOST.
    Suggested by Paul E. McKenney.

  - The crypto caam driver did not compile. Patch by Horia Geantă.

  - The kbuild test robot complained about various patches because they
    did not compile and so hurt bisectibility. As a result a few patches
    and hunks have been moved to avoid that.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.19.1-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.1-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.19.1-rt3

The RT patch against v4.19.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.1-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patches-4.19.1-rt3.tar.xz

Sebastian
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index bbbacf8c46b0f..63ce3b69338a0 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -11,7 +11,7 @@
 #include <linux/sched_clock.h>
 #include <soc/at91/atmel_tcb.h>
 
-static struct atmel_tcb_clksrc {
+struct atmel_tcb_clksrc {
 	struct clocksource clksrc;
 	struct clock_event_device clkevt;
 	struct regmap *regmap;
@@ -29,56 +29,55 @@ static struct atmel_tcb_clksrc {
 	} cache[2];
 	u32 bmr_cache;
 	bool registered;
-} tc = {
-	.clksrc = {
-		.rating		= 200,
-		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	},
-	.clkevt	= {
-		.features	= CLOCK_EVT_FEAT_ONESHOT,
-		/* Should be lower than at91rm9200's system timer */
-		.rating		= 125,
-	},
+	bool clk_enabled;
 };
 
-static struct tc_clkevt_device {
-	struct clock_event_device clkevt;
-	struct regmap *regmap;
-	void __iomem *base;
-	struct clk *slow_clk;
+static struct atmel_tcb_clksrc tc, tce;
+
+static struct clk *tcb_clk_get(struct device_node *node, int channel)
+{
 	struct clk *clk;
-	char name[20];
-	int channel;
-	int irq;
-	struct {
-		u32 cmr;
-		u32 imr;
-		u32 rc;
-		bool clken;
-	} cache;
-	bool registered;
-} tce = {
-	.clkevt	= {
-		.features		= CLOCK_EVT_FEAT_PERIODIC |
-					  CLOCK_EVT_FEAT_ONESHOT,
-		/*
-		 * Should be lower than at91rm9200's system timer
-		 * but higher than tc.clkevt.rating
-		 */
-		.rating			= 140,
-	},
-};
+	char clk_name[] = "t0_clk";
+
+	clk_name[1] += channel;
+	clk = of_clk_get_by_name(node->parent, clk_name);
+	if (!IS_ERR(clk))
+		return clk;
+
+	return of_clk_get_by_name(node->parent, "t0_clk");
+}
 
 /*
  * Clockevent device using its own channel
  */
+
+static void tc_clkevt2_clk_disable(struct clock_event_device *d)
+{
+	clk_disable(tce.clk[0]);
+	tce.clk_enabled = false;
+}
+
+static void tc_clkevt2_clk_enable(struct clock_event_device *d)
+{
+	if (tce.clk_enabled)
+		return;
+	clk_enable(tce.clk[0]);
+	tce.clk_enabled = true;
+}
+
+static int tc_clkevt2_stop(struct clock_event_device *d)
+{
+	writel(0xff, tce.base + ATMEL_TC_IDR(tce.channels[0]));
+	writel(ATMEL_TC_CCR_CLKDIS, tce.base + ATMEL_TC_CCR(tce.channels[0]));
+
+	return 0;
+}
+
 static int tc_clkevt2_shutdown(struct clock_event_device *d)
 {
-	writel(0xff, tce.base + ATMEL_TC_IDR(tce.channel));
-	writel(ATMEL_TC_CCR_CLKDIS, tce.base + ATMEL_TC_CCR(tce.channel));
+	tc_clkevt2_stop(d);
 	if (!clockevent_state_detached(d))
-		clk_disable(tce.clk);
+		tc_clkevt2_clk_disable(d);
 
 	return 0;
 }
@@ -93,15 +92,15 @@ static int tc_clkevt2_shutdown(struct clock_event_device *d)
 static int tc_clkevt2_set_oneshot(struct clock_event_device *d)
 {
 	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
-		tc_clkevt2_shutdown(d);
+		tc_clkevt2_stop(d);
 
-	clk_enable(tce.clk);
+	tc_clkevt2_clk_enable(d);
 
 	/* slow clock, count up to RC, then irq and stop */
 	writel(ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_CPCSTOP |
 	       ATMEL_TC_CMR_WAVE | ATMEL_TC_CMR_WAVESEL_UPRC,
-	       tce.base + ATMEL_TC_CMR(tce.channel));
-	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channel));
+	       tce.base + ATMEL_TC_CMR(tce.channels[0]));
+	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channels[0]));
 
 	return 0;
 }
@@ -109,23 +108,23 @@ static int tc_clkevt2_set_oneshot(struct clock_event_device *d)
 static int tc_clkevt2_set_periodic(struct clock_event_device *d)
 {
 	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
-		tc_clkevt2_shutdown(d);
+		tc_clkevt2_stop(d);
 
 	/* By not making the gentime core emulate periodic mode on top
 	 * of oneshot, we get lower overhead and improved accuracy.
 	 */
-	clk_enable(tce.clk);
+	tc_clkevt2_clk_enable(d);
 
 	/* slow clock, count up to RC, then irq and restart */
 	writel(ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_WAVE |
 	       ATMEL_TC_CMR_WAVESEL_UPRC,
-	       tce.base + ATMEL_TC_CMR(tce.channel));
-	writel((32768 + HZ / 2) / HZ, tce.base + ATMEL_TC_RC(tce.channel));
+	       tce.base + ATMEL_TC_CMR(tce.channels[0]));
+	writel((32768 + HZ / 2) / HZ, tce.base + ATMEL_TC_RC(tce.channels[0]));
 
 	/* Enable clock and interrupts on RC compare */
-	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channel));
+	writel(ATMEL_TC_CPCS, tce.base + ATMEL_TC_IER(tce.channels[0]));
 	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
-	       tce.base + ATMEL_TC_CCR(tce.channel));
+	       tce.base + ATMEL_TC_CCR(tce.channels[0]));
 
 	return 0;
 }
@@ -133,9 +132,9 @@ static int tc_clkevt2_set_periodic(struct clock_event_device *d)
 static int tc_clkevt2_next_event(unsigned long delta,
 				 struct clock_event_device *d)
 {
-	writel(delta, tce.base + ATMEL_TC_RC(tce.channel));
+	writel(delta, tce.base + ATMEL_TC_RC(tce.channels[0]));
 	writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
-	       tce.base + ATMEL_TC_CCR(tce.channel));
+	       tce.base + ATMEL_TC_CCR(tce.channels[0]));
 
 	return 0;
 }
@@ -144,7 +143,7 @@ static irqreturn_t tc_clkevt2_irq(int irq, void *handle)
 {
 	unsigned int sr;
 
-	sr = readl(tce.base + ATMEL_TC_SR(tce.channel));
+	sr = readl(tce.base + ATMEL_TC_SR(tce.channels[0]));
 	if (sr & ATMEL_TC_CPCS) {
 		tce.clkevt.event_handler(&tce.clkevt);
 		return IRQ_HANDLED;
@@ -155,29 +154,29 @@ static irqreturn_t tc_clkevt2_irq(int irq, void *handle)
 
 static void tc_clkevt2_suspend(struct clock_event_device *d)
 {
-	tce.cache.cmr = readl(tce.base + ATMEL_TC_CMR(tce.channel));
-	tce.cache.imr = readl(tce.base + ATMEL_TC_IMR(tce.channel));
-	tce.cache.rc = readl(tce.base + ATMEL_TC_RC(tce.channel));
-	tce.cache.clken = !!(readl(tce.base + ATMEL_TC_SR(tce.channel)) &
+	tce.cache[0].cmr = readl(tce.base + ATMEL_TC_CMR(tce.channels[0]));
+	tce.cache[0].imr = readl(tce.base + ATMEL_TC_IMR(tce.channels[0]));
+	tce.cache[0].rc = readl(tce.base + ATMEL_TC_RC(tce.channels[0]));
+	tce.cache[0].clken = !!(readl(tce.base + ATMEL_TC_SR(tce.channels[0])) &
 				ATMEL_TC_CLKSTA);
 }
 
 static void tc_clkevt2_resume(struct clock_event_device *d)
 {
 	/* Restore registers for the channel, RA and RB are not used  */
-	writel(tce.cache.cmr, tc.base + ATMEL_TC_CMR(tce.channel));
-	writel(tce.cache.rc, tc.base + ATMEL_TC_RC(tce.channel));
-	writel(0, tc.base + ATMEL_TC_RA(tce.channel));
-	writel(0, tc.base + ATMEL_TC_RB(tce.channel));
+	writel(tce.cache[0].cmr, tc.base + ATMEL_TC_CMR(tce.channels[0]));
+	writel(tce.cache[0].rc, tc.base + ATMEL_TC_RC(tce.channels[0]));
+	writel(0, tc.base + ATMEL_TC_RA(tce.channels[0]));
+	writel(0, tc.base + ATMEL_TC_RB(tce.channels[0]));
 	/* Disable all the interrupts */
-	writel(0xff, tc.base + ATMEL_TC_IDR(tce.channel));
+	writel(0xff, tc.base + ATMEL_TC_IDR(tce.channels[0]));
 	/* Reenable interrupts that were enabled before suspending */
-	writel(tce.cache.imr, tc.base + ATMEL_TC_IER(tce.channel));
+	writel(tce.cache[0].imr, tc.base + ATMEL_TC_IER(tce.channels[0]));
 
 	/* Start the clock if it was used */
-	if (tce.cache.clken)
+	if (tce.cache[0].clken)
 		writel(ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG,
-		       tc.base + ATMEL_TC_CCR(tce.channel));
+		       tc.base + ATMEL_TC_CCR(tce.channels[0]));
 }
 
 static int __init tc_clkevt_register(struct device_node *node,
@@ -185,23 +184,24 @@ static int __init tc_clkevt_register(struct device_node *node,
 				     int channel, int irq, int bits)
 {
 	int ret;
+	struct clk *slow_clk;
 
 	tce.regmap = regmap;
 	tce.base = base;
-	tce.channel = channel;
+	tce.channels[0] = channel;
 	tce.irq = irq;
 
-	tce.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
-	if (IS_ERR(tce.slow_clk))
-		return PTR_ERR(tce.slow_clk);
+	slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(slow_clk))
+		return PTR_ERR(slow_clk);
 
-	ret = clk_prepare_enable(tce.slow_clk);
+	ret = clk_prepare_enable(slow_clk);
 	if (ret)
 		return ret;
 
-	tce.clk = tcb_clk_get(node, tce.channel);
-	if (IS_ERR(tce.clk)) {
-		ret = PTR_ERR(tce.clk);
+	tce.clk[0] = tcb_clk_get(node, tce.channels[0]);
+	if (IS_ERR(tce.clk[0])) {
+		ret = PTR_ERR(tce.clk[0]);
 		goto err_slow;
 	}
 
@@ -215,14 +215,17 @@ static int __init tc_clkevt_register(struct device_node *node,
 	tce.clkevt.set_state_oneshot = tc_clkevt2_set_oneshot,
 	tce.clkevt.suspend = tc_clkevt2_suspend,
 	tce.clkevt.resume = tc_clkevt2_resume,
+	tce.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	tce.clkevt.rating = 140;
 
 	/* try to enable clk to avoid future errors in mode change */
-	ret = clk_prepare_enable(tce.clk);
+	ret = clk_prepare_enable(tce.clk[0]);
 	if (ret)
 		goto err_slow;
-	clk_disable(tce.clk);
+	clk_disable(tce.clk[0]);
 
-	clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
+	clockevents_config_and_register(&tce.clkevt, 32768, 1,
+					CLOCKSOURCE_MASK(bits));
 
 	ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
 			  tce.clkevt.name, &tce);
@@ -234,9 +237,9 @@ static int __init tc_clkevt_register(struct device_node *node,
 	return 0;
 
 err_clk:
-	clk_unprepare(tce.clk);
+	clk_unprepare(tce.clk[0]);
 err_slow:
-	clk_disable_unprepare(tce.slow_clk);
+	clk_disable_unprepare(slow_clk);
 
 	return ret;
 }
@@ -276,7 +279,6 @@ static int tcb_clkevt_next_event(unsigned long delta,
 {
 	u32 old, next, cur;
 
-
 	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
 	next = old + delta;
 	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
@@ -503,6 +505,9 @@ static int __init tcb_clksrc_register(struct device_node *node,
 	tc.clksrc.name = tc.name;
 	tc.clksrc.suspend = tc_clksrc_suspend;
 	tc.clksrc.resume = tc_clksrc_resume;
+	tc.clksrc.rating = 200;
+	tc.clksrc.mask = CLOCKSOURCE_MASK(32);
+	tc.clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	err = clocksource_register_hz(&tc.clksrc, divided_rate);
 	if (err)
@@ -518,6 +523,9 @@ static int __init tcb_clksrc_register(struct device_node *node,
 	tc.clkevt.set_next_event = tcb_clkevt_next_event;
 	tc.clkevt.set_state_oneshot = tcb_clkevt_oneshot;
 	tc.clkevt.set_state_shutdown = tcb_clkevt_shutdown;
+	tc.clkevt.features = CLOCK_EVT_FEAT_ONESHOT;
+	tc.clkevt.rating = 125;
+
 	clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
 					BIT(tc.bits) - 1);
 
@@ -546,11 +554,11 @@ static int __init tcb_clksrc_register(struct device_node *node,
 static int __init tcb_clksrc_init(struct device_node *node)
 {
 	const struct of_device_id *match;
-	const struct atmel_tcb_info *tcb_info;
 	struct regmap *regmap;
 	void __iomem *tcb_base;
 	u32 channel;
-	int bits, irq, err, chan1 = -1;
+	int irq, err, chan1 = -1;
+	unsigned bits;
 
 	if (tc.registered && tce.registered)
 		return -ENODEV;
@@ -571,16 +579,18 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	}
 
 	match = of_match_node(atmel_tcb_dt_ids, node->parent);
-	tcb_info = match->data;
-	bits = tcb_info->bits;
+	bits = (uintptr_t)match->data;
 
 	err = of_property_read_u32_index(node, "reg", 0, &channel);
 	if (err)
 		return err;
 
-	irq = tcb_irq_get(node, channel);
-	if (irq < 0)
-		return irq;
+	irq = of_irq_get(node->parent, channel);
+	if (irq < 0) {
+		irq = of_irq_get(node->parent, 0);
+		if (irq < 0)
+			return irq;
+	}
 
 	if (tc.registered)
 		return tc_clkevt_register(node, regmap, tcb_base, channel, irq,
@@ -604,5 +614,4 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	return tcb_clksrc_register(node, regmap, tcb_base, channel, chan1, irq,
 				   bits);
 }
-CLOCKSOURCE_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer",
-		       tcb_clksrc_init);
+TIMER_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer", tcb_clksrc_init);
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 67f7f8c42c932..b84e6c8b1e138 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -83,13 +83,6 @@ EXPORT_SYMBOL(caam_congested);
 static u64 times_congested;
 #endif
 
-/*
- * CPU from where the module initialised. This is required because QMan driver
- * requires CGRs to be removed from same CPU from where they were originally
- * allocated.
- */
-static int mod_init_cpu;
-
 /*
  * This is a a cache of buffers, from which the users of CAAM QI driver
  * can allocate short (CAAM_QI_MEMCACHE_SIZE) buffers. It's faster than
@@ -492,12 +485,11 @@ void caam_drv_ctx_rel(struct caam_drv_ctx *drv_ctx)
 }
 EXPORT_SYMBOL(caam_drv_ctx_rel);
 
-int caam_qi_shutdown(struct device *qidev)
+void caam_qi_shutdown(struct device *qidev)
 {
-	int i, ret;
+	int i;
 	struct caam_qi_priv *priv = dev_get_drvdata(qidev);
 	const cpumask_t *cpus = qman_affine_cpus();
-	struct cpumask old_cpumask = current->cpus_allowed;
 
 	for_each_cpu(i, cpus) {
 		struct napi_struct *irqtask;
@@ -510,26 +502,12 @@ int caam_qi_shutdown(struct device *qidev)
 			dev_err(qidev, "Rsp FQ kill failed, cpu: %d\n", i);
 	}
 
-	/*
-	 * QMan driver requires CGRs to be deleted from same CPU from where they
-	 * were instantiated. Hence we get the module removal execute from the
-	 * same CPU from where it was originally inserted.
-	 */
-	set_cpus_allowed_ptr(current, get_cpu_mask(mod_init_cpu));
-
-	ret = qman_delete_cgr(&priv->cgr);
-	if (ret)
-		dev_err(qidev, "Deletion of CGR failed: %d\n", ret);
-	else
-		qman_release_cgrid(priv->cgr.cgrid);
+	qman_delete_cgr_safe(&priv->cgr);
+	qman_release_cgrid(priv->cgr.cgrid);
 
 	kmem_cache_destroy(qi_cache);
 
-	/* Now that we're done with the CGRs, restore the cpus allowed mask */
-	set_cpus_allowed_ptr(current, &old_cpumask);
-
 	platform_device_unregister(priv->qi_pdev);
-	return ret;
 }
 
 static void cgr_cb(struct qman_portal *qm, struct qman_cgr *cgr, int congested)
@@ -718,22 +696,11 @@ int caam_qi_init(struct platform_device *caam_pdev)
 	struct device *ctrldev = &caam_pdev->dev, *qidev;
 	struct caam_drv_private *ctrlpriv;
 	const cpumask_t *cpus = qman_affine_cpus();
-	struct cpumask old_cpumask = current->cpus_allowed;
 	static struct platform_device_info qi_pdev_info = {
 		.name = "caam_qi",
 		.id = PLATFORM_DEVID_NONE
 	};
 
-	/*
-	 * QMAN requires CGRs to be removed from same CPU+portal from where it
-	 * was originally allocated. Hence we need to note down the
-	 * initialisation CPU and use the same CPU for module exit.
-	 * We select the first CPU to from the list of portal owning CPUs.
-	 * Then we pin module init to this CPU.
-	 */
-	mod_init_cpu = cpumask_first(cpus);
-	set_cpus_allowed_ptr(current, get_cpu_mask(mod_init_cpu));
-
 	qi_pdev_info.parent = ctrldev;
 	qi_pdev_info.dma_mask = dma_get_mask(ctrldev);
 	qi_pdev = platform_device_register_full(&qi_pdev_info);
@@ -795,8 +762,6 @@ int caam_qi_init(struct platform_device *caam_pdev)
 		return -ENOMEM;
 	}
 
-	/* Done with the CGRs; restore the cpus allowed mask */
-	set_cpus_allowed_ptr(current, &old_cpumask);
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("qi_congested", 0444, ctrlpriv->ctl,
 			    &times_congested, &caam_fops_u64_ro);
diff --git a/drivers/crypto/caam/qi.h b/drivers/crypto/caam/qi.h
index 357b69f570725..b6c8acc308536 100644
--- a/drivers/crypto/caam/qi.h
+++ b/drivers/crypto/caam/qi.h
@@ -174,7 +174,7 @@ int caam_drv_ctx_update(struct caam_drv_ctx *drv_ctx, u32 *sh_desc);
 void caam_drv_ctx_rel(struct caam_drv_ctx *drv_ctx);
 
 int caam_qi_init(struct platform_device *pdev);
-int caam_qi_shutdown(struct device *dev);
+void caam_qi_shutdown(struct device *dev);
 
 /**
  * qi_cache_alloc - Allocate buffers from CAAM-QI cache
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index fa530913a2c8f..08925d24180b0 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -90,7 +90,7 @@ struct bcm2835_pinctrl {
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range gpio_range;
 
-	spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
 };
 
 /* pins are just named GPIO0..GPIO53 */
@@ -461,10 +461,10 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	set_bit(offset, &pc->enabled_irq_map[bank]);
 	bcm2835_gpio_irq_config(pc, gpio, true);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static void bcm2835_gpio_irq_disable(struct irq_data *data)
@@ -476,12 +476,12 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	bcm2835_gpio_irq_config(pc, gpio, false);
 	/* Clear events that were latched prior to clearing event sources */
 	bcm2835_gpio_set_bit(pc, GPEDS0, gpio);
 	clear_bit(offset, &pc->enabled_irq_map[bank]);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static int __bcm2835_gpio_irq_set_type_disabled(struct bcm2835_pinctrl *pc,
@@ -584,7 +584,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 
 	if (test_bit(offset, &pc->enabled_irq_map[bank]))
 		ret = __bcm2835_gpio_irq_set_type_enabled(pc, gpio, type);
@@ -596,7 +596,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_level_irq);
 
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 
 	return ret;
 }
@@ -1047,7 +1047,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		for_each_set_bit(offset, &events, 32)
 			bcm2835_gpio_wr(pc, GPEDS0 + i * 4, BIT(offset));
 
-		spin_lock_init(&pc->irq_lock[i]);
+		raw_spin_lock_init(&pc->irq_lock[i]);
 	}
 
 	err = gpiochip_add_data(&pc->gpio_chip, pc);
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index d263ea6772259..657e234b14832 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+//SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2018 Microchip */
 
 #ifndef __SOC_ATMEL_TCB_H
@@ -166,48 +166,15 @@
 #define ATMEL_TC_WPMR_WPKEY		(0x54494d << 8)
 #define ATMEL_TC_WPMR_WPEN		BIT(0)
 
-static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
-{
-	struct clk *clk;
-	char clk_name[] = "t0_clk";
-
-	clk_name[1] += channel;
-	clk = of_clk_get_by_name(node->parent, clk_name);
-	if (!IS_ERR(clk))
-		return clk;
-
-	return of_clk_get_by_name(node->parent, "t0_clk");
-}
-
-static inline int tcb_irq_get(struct device_node *node, int channel)
-{
-	int irq;
-
-	irq = of_irq_get(node->parent, channel);
-	if (irq > 0)
-		return irq;
-
-	return of_irq_get(node->parent, 0);
-}
-
 static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
 
-struct atmel_tcb_info {
-	int bits;
-};
-
-static const struct atmel_tcb_info atmel_tcb_infos[] = {
-	{ .bits = 16 },
-	{ .bits = 32 },
-};
-
 static const struct of_device_id atmel_tcb_dt_ids[] = {
 	{
 		.compatible = "atmel,at91rm9200-tcb",
-		.data = &atmel_tcb_infos[0],
+		.data = (void *)16,
 	}, {
 		.compatible = "atmel,at91sam9x5-tcb",
-		.data = &atmel_tcb_infos[1],
+		.data = (void *)32,
 	}, {
 		/* sentinel */
 	}
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0be2c96fb640e..a243a78ff38c0 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -36,7 +36,7 @@ config TINY_RCU
 
 config RCU_EXPERT
 	bool "Make expert-level adjustments to RCU configuration"
-	default y if PREEMPT_RT_FULL
+	default n
 	help
 	  This option needs to be enabled if you wish to make
 	  expert-level adjustments to RCU configuration.  By default,
@@ -190,7 +190,7 @@ config RCU_FAST_NO_HZ
 
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
-	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
+	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL
 	default y if PREEMPT_RT_FULL
 	help
 	  This option boosts the priority of preempted RCU readers that
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
