Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FEB260767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeFFJgw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:36:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:36978 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932353AbeFFJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:36:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="55159984"
Date: Wed, 6 Jun 2018 17:38:33 +0800
From: Feng Tang <feng.tang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, alek.du@intel.com,
        pasha.tatashin@oracle.com, arjan@linux.intel.com,
        len.brown@intel.com, feng.tang@intel.com
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
Message-ID: <20180606093833.vqg47yhdq7mnj2kp@shbuild888>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com>
 <20180531135542.4j7w7bxsw43ydx3j@pathway.suse.cz>
 <20180531155210.GL12180@hirez.programming.kicks-ass.net>
 <20180601161213.tm44nhrhwfxa2767@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601161213.tm44nhrhwfxa2767@shbuild888>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 12:12:13AM +0800, Feng Tang wrote:

Hi Peter and  all,


> Hi Peter and Petr,
> 
> Thanks for your suggestions, will try to find a cleaner and less hacky way,
> and it may take some time as dealing with all kinds of TSC is tricky :)
> 
> - Feng
> 
> On Thu, May 31, 2018 at 05:52:10PM +0200, Peter Zijlstra wrote:
> > On Thu, May 31, 2018 at 03:55:42PM +0200, Petr Mladek wrote:
> > > I wonder if we could get some cleaner integration into the timer and
> > > printk code.
> > 
> > Yes, these patches are particularly horrific..
> > 
> > There were some earlier patches by Pavel Tatashin, which attempted do
> > get things running earlier.
> > 
> >   http://lkml.kernel.org/r/20180209211143.16215-1-pasha.tatashin@oracle.com
> > 
> > I'm not entirely happy with that, but I never did get around to
> > reviewing that last version :-( In particuarly, now that you made me
> > look, I dislike his patch 6 almost as much as these patches.
> > 
> > The idea was to get regular sched_clock() running earlier, not to botch
> > some early_sched_clock() into it.
> > 
> > Basically run calibrate_tsc() earlier (like _waaay_ earlier, it doesn't
> > rely on anything other than CPUID) and if you have a recent part (with
> > exception of SKX) you'll get a usable tsc rate (and TSC_RELIABLE) and
> > things will work.


I just did a hacky experiment by moving the tsc_init()earlier into
setup_arch() and remove the tsc_early_delay_calibrate(). The printk stamp
does start working much earlier!


But the __use_tsc and __sched_clock_stable are relying on jump_label,
which can't be used so early (I tried to call the jump_label_init() before
tsc_init(), but kernel crashs, and I worked around it for now).

Please review the debug patch, thanks!

---
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5c623df..b636888 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1201,7 +1201,8 @@ void __init setup_arch(char **cmdline_p)
 	kvmclock_init();
 #endif
 
-	tsc_early_delay_calibrate();
+	tsc_init();
+
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4008dd6..8288f39 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -33,6 +33,7 @@ EXPORT_SYMBOL(cpu_khz);
 unsigned int __read_mostly tsc_khz;
 EXPORT_SYMBOL(tsc_khz);
 
+int tsc_inited;
 /*
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
  */
@@ -192,7 +193,7 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
  */
 u64 native_sched_clock(void)
 {
-	if (static_branch_likely(&__use_tsc)) {
+	if (static_branch_likely(&__use_tsc) || tsc_inited) {
 		u64 tsc_now = rdtsc();
 
 		/* return the value in ns */
@@ -1387,30 +1391,16 @@ static int __init init_tsc_clocksource(void)
  */
 device_initcall(init_tsc_clocksource);
 
-void __init tsc_early_delay_calibrate(void)
-{
-	unsigned long lpj;
-
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return;
-
-	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
-
-	tsc_khz = tsc_khz ? : cpu_khz;
-	if (!tsc_khz)
-		return;
-
-	lpj = tsc_khz * 1000;
-	do_div(lpj, HZ);
-	loops_per_jiffy = lpj;
-}
-
 void __init tsc_init(void)
 {
 	u64 lpj, cyc;
 	int cpu;
 
+	if (tsc_inited)
+		return;
+
+	tsc_inited = 1;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 		return;
@@ -1474,11 +1464,15 @@ void __init tsc_init(void)
 	lpj = ((u64)tsc_khz * 1000);
 	do_div(lpj, HZ);
 	lpj_fine = lpj;
+	loops_per_jiffy = lpj;
 
 	use_tsc_delay();
 
 	check_system_tsc_reliable();
 
+	extern void early_set_sched_clock_stable(u64 sched_clock_offset);
+	early_set_sched_clock_stable(div64_u64(rdtsc() * 1000, tsc_khz));
+
 	if (unsynchronized_tsc()) {
 		mark_tsc_unstable("TSCs unsynchronized");
 		return;
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 10c83e7..6c5c22d 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -119,6 +119,13 @@ static void __scd_stamp(struct sched_clock_data *scd)
 	scd->tick_raw = sched_clock();
 }
 
+
+void early_set_sched_clock_stable(u64 sched_clock_offset)
+{
+	__sched_clock_offset = sched_clock_offset;
+	static_branch_enable(&__sched_clock_stable);
+}
+
 static void __set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
@@ -342,12 +349,14 @@ static u64 sched_clock_remote(struct sched_clock_data *scd)
  *
  * See cpu_clock().
  */
+
+extern int tsc_inited;
 u64 sched_clock_cpu(int cpu)
 {
 	struct sched_clock_data *scd;
 	u64 clock;
 
-	if (sched_clock_stable())
+	if (sched_clock_stable() || tsc_inited)
 		return sched_clock() + __sched_clock_offset;
 
 	if (unlikely(!sched_clock_running))
	   



> > 
> > If you have a dodgy part (sorry SKX), you'll just have to live with
> > sched_clock starting late(r).
> > 
> > Do not cobble things on the side, try and get the normal things running
> > earlier.
