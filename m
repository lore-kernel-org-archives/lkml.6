Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849E020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849E020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeFSXw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:52:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeFSXw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:52:26 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVQPy-0005Lz-P7; Wed, 20 Jun 2018 01:52:11 +0200
Date:   Wed, 20 Jun 2018 01:52:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
In-Reply-To: <20180615174204.30581-8-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-8-pasha.tatashin@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Pavel Tatashin wrote:

> tsc_early_init():
> Determines offset, shift and multiplier for the early clock based on the
> TSC frequency.
> 
> tsc_early_fini()
> Implement the finish part of early tsc feature, prints message about the
> offset, which can be useful to find out how much time was spent in post and
> boot manager (if TSC starts from 0 during boot)
>
> sched_clock_early():
> TSC based implementation of early clock and is called from sched_clock().
> 
> start_early_clock():
> Calls tsc_early_init(), and makes sched_clock() to use early boot clock
> 
> set_final_clock():
> Sets the final clock which is either platform specific or
> native_sched_clock(). Also calls tsc_early_fini() if early clock was
> previously initialized.
> 
> Call start_early_clock() to start using early boot time stamps
> functionality on the supported x86 platforms, and call set_final_clock() to
> finish this feature and switch back to the default clock. The supported x86
> systems are those where TSC frequency is determined early in boot.

Lots of functions for dubious value.
  
> +static struct cyc2ns_data  cyc2ns_early;
> +
> +static u64 sched_clock_early(void)
> +{
> +	u64 ns = mul_u64_u32_shr(rdtsc(), cyc2ns_early.cyc2ns_mul,
> +				 cyc2ns_early.cyc2ns_shift);
> +	return ns + cyc2ns_early.cyc2ns_offset;
> +}
> +
> +/*
> + * Initialize clock for early time stamps
> + */
> +static void __init tsc_early_init(unsigned int khz)
> +{
> +	clocks_calc_mult_shift(&cyc2ns_early.cyc2ns_mul,
> +			       &cyc2ns_early.cyc2ns_shift,
> +			       khz, NSEC_PER_MSEC, 0);
> +	cyc2ns_early.cyc2ns_offset = -sched_clock_early();
> +}
> +
> +/*
> + * Finish clock for early time stamps, and hand over to permanent clock by
> + * setting __sched_clock_offset appropriately for continued time keeping.
> + */
> +static void __init tsc_early_fini(void)
> +{
> +	unsigned long long t;
> +	unsigned long r;
> +
> +	t = -cyc2ns_early.cyc2ns_offset;
> +	r = do_div(t, NSEC_PER_SEC);
> +
> +	__sched_clock_offset = sched_clock_early() - sched_clock();
> +	pr_info("early sched clock is finished, offset [%lld.%09lds]\n", t, r);
> +}
> +
> +#ifdef CONFIG_PARAVIRT
> +static inline void __init start_early_clock(void)
> +{
> +	tsc_early_init(tsc_khz);
> +	pv_time_ops.active_sched_clock = sched_clock_early;
> +}
> +
> +static inline void __init set_final_clock(void)
> +{
> +	pv_time_ops.active_sched_clock = pv_time_ops.sched_clock;
> +
> +	/* We did not have early sched clock if multiplier is 0 */
> +	if (cyc2ns_early.cyc2ns_mul)
> +		tsc_early_fini();
> +}
> +#else /* CONFIG_PARAVIRT */
> +/*
> + * For native clock we use two switches static and dynamic, the static switch is
> + * initially true, so we check the dynamic switch, which is initially false.
> + * Later  when early clock is disabled, we can alter the static switch in order
> + * to avoid branch check on every sched_clock() call.
> + */
> +static bool __tsc_early;
> +static DEFINE_STATIC_KEY_TRUE(__tsc_early_static);
> +
> +static inline void __init start_early_clock(void)
> +{
> +	tsc_early_init(tsc_khz);
> +	__tsc_early = true;
> +}
> +
> +static inline void __init set_final_clock(void)
> +{
> +	__tsc_early = false;
> +	static_branch_disable(&__tsc_early_static);
> +
> +	/* We did not have early sched clock if multiplier is 0 */
> +	if (cyc2ns_early.cyc2ns_mul)
> +		tsc_early_fini();
> +}
> +#endif /* CONFIG_PARAVIRT */
> +
>  /*
>   * Scheduler clock - returns current time in nanosec units.
>   */
> @@ -194,6 +272,13 @@ u64 native_sched_clock(void)
>  		return cycles_2_ns(tsc_now);
>  	}
>  
> +#ifndef CONFIG_PARAVIRT
> +	if (static_branch_unlikely(&__tsc_early_static)) {
> +		if (__tsc_early)
> +			return sched_clock_early();
> +	}
> +#endif /* !CONFIG_PARAVIRT */
> +

This whole function maze plus the ifdeffery which comes with it is really
horrible and not required. What's wrong with reusing the existing
functionality?

The patch below (uncompiled and untested) should achieve the same thing
without all the paravirt muck (which can be easily added w/o all the
ifdeffery if really required) by just reusing the existing conversion and
initialization functions.

If I'm not completely mistaken then the second invocation of
set_cyc2ns_scale() from tsc_init() will also take care of the smooth
sched_clock() transition from early to final w/o touching the core
__sched_clock_offset at all. Though my tired brain might trick me.

It might not work as is, but it should not be rocket science to make it do
so.

Thanks,

	tglx

8<----------------------

tsc.c |   59 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -39,6 +39,9 @@ EXPORT_SYMBOL(tsc_khz);
 static int __read_mostly tsc_unstable;
 
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
+static DEFINE_STATIC_KEY_TRUE(tsc_early_enabled);
+
+static bool tsc_early_sched_clock;
 
 int tsc_clocksource_reliable;
 
@@ -133,18 +136,12 @@ static inline unsigned long long cycles_
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu,
+			       unsigned long long tsc_now)
 {
 	unsigned long long ns_now;
 	struct cyc2ns_data data;
 	struct cyc2ns *c2n;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	sched_clock_idle_sleep_event();
-
-	if (!khz)
-		goto done;
 
 	ns_now = cycles_2_ns(tsc_now);
 
@@ -176,22 +173,46 @@ static void set_cyc2ns_scale(unsigned lo
 	c2n->data[0] = data;
 	raw_write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+}
+
+static void set_cyc2ns_scale(unsigned long khz, int cpu,
+			     unsigned long long tsc_now)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	if (khz)
+		__set_cyc2ns_scale(khz, cpu, tsc_now);
 
-done:
 	sched_clock_idle_wakeup_event();
 	local_irq_restore(flags);
 }
 
+static void __init sched_clock_early_init(unsigned int khz)
+{
+	cyc2ns_init(smp_processor_id());
+	__set_cyc2ns_scale(khz, smp_processor_id(), rdtsc());
+	tsc_early_sched_clock = true;
+}
+
+static void __init sched_clock_early_exit(void)
+{
+	static_branch_disable(&tsc_early_enabled);
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
 u64 native_sched_clock(void)
 {
-	if (static_branch_likely(&__use_tsc)) {
-		u64 tsc_now = rdtsc();
+	if (static_branch_likely(&__use_tsc))
+		return cycles_2_ns(rdtsc());
 
-		/* return the value in ns */
-		return cycles_2_ns(tsc_now);
+	if (static_branch_unlikely(&tsc_early_enabled)) {
+		if (tsc_early_sched_clock)
+			return cycles_2_ns(rdtsc());
 	}
 
 	/*
@@ -1332,9 +1353,10 @@ void __init tsc_early_delay_calibrate(vo
 	lpj = tsc_khz * 1000;
 	do_div(lpj, HZ);
 	loops_per_jiffy = lpj;
+	sched_clock_early_init(tsc_khz);
 }
 
-void __init tsc_init(void)
+static void __init __tsc_init(void)
 {
 	u64 lpj, cyc;
 	int cpu;
@@ -1384,7 +1406,8 @@ void __init tsc_init(void)
 	 */
 	cyc = rdtsc();
 	for_each_possible_cpu(cpu) {
-		cyc2ns_init(cpu);
+		if (!tsc_early_sched_clock || cpu != smp_processor_id())
+			cyc2ns_init(cpu);
 		set_cyc2ns_scale(tsc_khz, cpu, cyc);
 	}
 
@@ -1411,6 +1434,12 @@ void __init tsc_init(void)
 	detect_art();
 }
 
+void __init tsc_init(void)
+{
+	__tsc_init();
+	sched_clock_early_exit();
+}
+
 #ifdef CONFIG_SMP
 /*
  * If we have a constant TSC and are using the TSC for the delay loop,



