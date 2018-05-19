Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeESCFn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 22:05:43 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:57140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751117AbeESCFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 22:05:41 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:1:41:69:355:379:421:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1461:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2194:2196:2199:2200:2393:2553:2559:2562:2637:2691:2737:2828:2895:2899:2904:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:4250:4321:4605:5007:6117:6119:7875:7903:7974:9040:10004:10241:10848:11026:11232:11473:11657:11658:11914:12043:12291:12296:12438:12555:12683:12740:12760:12895:13132:13160:13229:13231:13439:13868:13972:14659:21080:21325:21433:21451:21627:30054:30056:30060:30069:30070:30090:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.14.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: dirt49_4e11a1b722f61
X-Filterd-Recvd-Size: 13177
Message-ID: <e97aa7a7b09f020614025ddd8ec2ca4b1fcc18e7.camel@perches.com>
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 18 May 2018 19:05:28 -0700
In-Reply-To: <CAHp75VcaAMM7NxSWEFhrmQfKMOskuzbAHL-+eqi4DQ71cT7=Bg@mail.gmail.com>
References: <cover.1525964381.git.joe@perches.com>
         <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
         <20180518084203.n2etqcigvwxzcanv@pathway.suse.cz>
         <9332d922caf8e25747aa19e573cc3ab82519f6f7.camel@perches.com>
         <CAHp75VcaAMM7NxSWEFhrmQfKMOskuzbAHL-+eqi4DQ71cT7=Bg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 23:29 +0300, Andy Shevchenko wrote:
> On Fri, May 18, 2018 at 12:10 PM, Joe Perches <joe@perches.com> wrote:
> > On Fri, 2018-05-18 at 10:42 +0200, Petr Mladek wrote:
> > > On Thu 2018-05-10 08:45:29, Joe Perches wrote:
> > > [    0.000000] libftrace: ftrace: allocating 40753 entries in 160 pages
> > > [    0.004008] apic: APIC: Switch to symmetric I/O mode setup
> > 
> > I believe the uppercase APIC: bit should be removed.
> 
> I disagree on lowering the case of some prefixes.
> 
> In the case when kernel crashes at boot time and only what you have is
> what on your screen it's much better to catch with different cases
> than if everything would be either upper or lower.

I don't parse.
My suggestion is to make "apic: " the only prefix.

ie:
---
 arch/x86/kernel/apic/apic.c | 100 +++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 2aabd4cb0e3f..67dd4e9191da 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -14,6 +14,8 @@
  *	Mikael Pettersson	:	PM converted to driver model.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/perf_event.h>
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
@@ -232,7 +234,7 @@ static int modern_apic(void)
  */
 static void __init apic_disable(void)
 {
-	pr_info("APIC: switched to apic NOOP\n");
+	pr_info("switched to apic NOOP\n");
 	apic = &apic_noop;
 }
 
@@ -430,17 +432,13 @@ int setup_APIC_eilvt(u8 offset, u8 vector, u8 msg_type, u8 mask)
 	reserved = reserve_eilvt_offset(offset, new);
 
 	if (reserved != new) {
-		pr_err(FW_BUG "cpu %d, try to use APIC%lX (LVT offset %d) for "
-		       "vector 0x%x, but the register is already in use for "
-		       "vector 0x%x on another cpu\n",
+		pr_err(FW_BUG "cpu %d, try to use APIC%lX (LVT offset %d) for vector 0x%x, but the register is already in use for vector 0x%x on another cpu\n",
 		       smp_processor_id(), reg, offset, new, reserved);
 		return -EINVAL;
 	}
 
 	if (!eilvt_entry_is_changeable(old, new)) {
-		pr_err(FW_BUG "cpu %d, try to use APIC%lX (LVT offset %d) for "
-		       "vector 0x%x, but the register is already in use for "
-		       "vector 0x%x on this cpu\n",
+		pr_err(FW_BUG "cpu %d, try to use APIC%lX (LVT offset %d) for vector 0x%x, but the register is already in use for vector 0x%x on this cpu\n",
 		       smp_processor_id(), reg, offset, new, old);
 		return -EBUSY;
 	}
@@ -624,8 +622,8 @@ static void apic_check_deadline_errata(void)
 		return;
 
 	setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-	pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; "
-	       "please update microcode to version: 0x%x (or later)\n", rev);
+	pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; please update microcode to version: 0x%x (or later)\n",
+	       rev);
 }
 
 /*
@@ -769,14 +767,14 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 
 	res = (((u64)deltapm) *  mult) >> 22;
 	do_div(res, 1000000);
-	pr_warning("APIC calibration not consistent "
-		   "with PM-Timer: %ldms instead of 100ms\n",(long)res);
+	pr_warn("calibration not consistent with PM-Timer: %ldms instead of 100ms\n",
+		   (long)res);
 
 	/* Correct the lapic counter value */
 	res = (((u64)(*delta)) * pm_100ms);
 	do_div(res, deltapm);
-	pr_info("APIC delta adjusted to PM-Timer: "
-		"%lu (%ld)\n", (unsigned long)res, *delta);
+	pr_info("APIC delta adjusted to PM-Timer: %lu (%ld)\n",
+		(unsigned long)res, *delta);
 	*delta = (long)res;
 
 	/* Correct the tsc counter value */
@@ -893,7 +891,7 @@ static int __init calibrate_APIC_clock(void)
 	 */
 	if (lapic_timer_frequency < (1000000 / HZ)) {
 		local_irq_enable();
-		pr_warning("APIC frequency too slow, disabling apic timer\n");
+		pr_warn("frequency too slow, disabling apic timer\n");
 		return -1;
 	}
 
@@ -936,8 +934,8 @@ static int __init calibrate_APIC_clock(void)
 	local_irq_enable();
 
 	if (levt->features & CLOCK_EVT_FEAT_DUMMY) {
-		pr_warning("APIC timer disabled due to verification failure\n");
-			return -1;
+		pr_warn("timer disabled due to verification failure\n");
+		return -1;
 	}
 
 	return 0;
@@ -1010,8 +1008,8 @@ static void local_apic_timer_interrupt(void)
 	 * spurious.
 	 */
 	if (!evt->event_handler) {
-		pr_warning("Spurious LAPIC timer interrupt on cpu %d\n",
-			   smp_processor_id());
+		pr_warn("Spurious LAPIC timer interrupt on cpu %d\n",
+			smp_processor_id());
 		/* Switch it off */
 		lapic_timer_shutdown(evt);
 		return;
@@ -1254,7 +1252,7 @@ static int __init apic_intr_mode_select(void)
 		APIC_INTEGRATED(boot_cpu_apic_version)) {
 		disable_apic = 1;
 		pr_err(FW_BUG "Local APIC %d not detected, force emulation\n",
-				       boot_cpu_physical_apicid);
+		       boot_cpu_physical_apicid);
 		return APIC_PIC;
 	}
 #endif
@@ -1263,7 +1261,7 @@ static int __init apic_intr_mode_select(void)
 	if (!smp_found_config) {
 		disable_ioapic_support();
 		if (!acpi_lapic) {
-			pr_info("APIC: ACPI MADT or MP tables are not detected\n");
+			pr_info("ACPI MADT or MP tables are not detected\n");
 			return APIC_VIRTUAL_WIRE_NO_CONFIG;
 		}
 		return APIC_VIRTUAL_WIRE;
@@ -1272,7 +1270,7 @@ static int __init apic_intr_mode_select(void)
 #ifdef CONFIG_SMP
 	/* If SMP should be disabled, then really disable it! */
 	if (!setup_max_cpus) {
-		pr_info("APIC: SMP mode deactivated\n");
+		pr_info("SMP mode deactivated\n");
 		return APIC_SYMMETRIC_IO_NO_ROUTING;
 	}
 
@@ -1344,23 +1342,23 @@ void __init apic_intr_mode_init(void)
 
 	switch (apic_intr_mode) {
 	case APIC_PIC:
-		pr_info("APIC: Keep in PIC mode(8259)\n");
+		pr_info("Keep in PIC mode(8259)\n");
 		return;
 	case APIC_VIRTUAL_WIRE:
-		pr_info("APIC: Switch to virtual wire mode setup\n");
+		pr_info("Switch to virtual wire mode setup\n");
 		default_setup_apic_routing();
 		break;
 	case APIC_VIRTUAL_WIRE_NO_CONFIG:
-		pr_info("APIC: Switch to virtual wire mode setup with no configuration\n");
+		pr_info("Switch to virtual wire mode setup with no configuration\n");
 		upmode = true;
 		default_setup_apic_routing();
 		break;
 	case APIC_SYMMETRIC_IO:
-		pr_info("APIC: Switch to symmetric I/O mode setup\n");
+		pr_info("Switch to symmetric I/O mode setup\n");
 		default_setup_apic_routing();
 		break;
 	case APIC_SYMMETRIC_IO_NO_ROUTING:
-		pr_info("APIC: Switch to symmetric I/O mode setup in no SMP routine\n");
+		pr_info("Switch to symmetric I/O mode setup in no SMP routine\n");
 		break;
 	}
 
@@ -1372,7 +1370,7 @@ static void lapic_setup_esr(void)
 	unsigned int oldvalue, value, maxlvt;
 
 	if (!lapic_is_integrated()) {
-		pr_info("No ESR for 82489DX.\n");
+		pr_info("No ESR for 82489DX\n");
 		return;
 	}
 
@@ -1383,7 +1381,7 @@ static void lapic_setup_esr(void)
 		 * ESR disabled - we can't do anything useful with the
 		 * errors anyway - mbligh
 		 */
-		pr_info("Leaving ESR disabled.\n");
+		pr_info("Leaving ESR disabled\n");
 		return;
 	}
 
@@ -1442,7 +1440,8 @@ static void apic_pending_intr_clear(void)
 			}
 		}
 		if (acked > 256) {
-			pr_err("LAPIC pending interrupts after %d EOI\n", acked);
+			pr_err("LAPIC pending interrupts after %d EOI\n",
+			       acked);
 			break;
 		}
 		if (queued) {
@@ -1679,11 +1678,11 @@ static int __init setup_nox2apic(char *str)
 		int apicid = native_apic_msr_read(APIC_ID);
 
 		if (apicid >= 255) {
-			pr_warning("Apicid: %08x, cannot enforce nox2apic\n",
-				   apicid);
+			pr_warn("Apicid: %08x, cannot enforce nox2apic\n",
+				apicid);
 			return 0;
 		}
-		pr_warning("x2apic already enabled.\n");
+		pr_warn("x2apic already enabled\n");
 		__x2apic_disable();
 	}
 	setup_clear_cpu_cap(X86_FEATURE_X2APIC);
@@ -1851,7 +1850,7 @@ static int __init apic_verify(void)
 	 */
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
-		pr_warning("Could not enable APIC!\n");
+		pr_warn("Could not enable APIC!\n");
 		return -1;
 	}
 	set_cpu_cap(&boot_cpu_data, X86_FEATURE_APIC);
@@ -1923,8 +1922,7 @@ static int __init detect_init_APIC(void)
 		 * "lapic" specified.
 		 */
 		if (!force_enable_local_apic) {
-			pr_info("Local APIC disabled by BIOS -- "
-				"you can enable it with \"lapic\"\n");
+			pr_info("Local APIC disabled by BIOS -- you can enable it with \"lapic\"\n");
 			return -1;
 		}
 		if (apic_force_enable(APIC_DEFAULT_PHYS_BASE))
@@ -1961,7 +1959,7 @@ void __init init_apic_mappings(void)
 	/* If no local APIC can be found return early */
 	if (!smp_found_config && detect_init_APIC()) {
 		/* lets NOP'ify apic operations */
-		pr_info("APIC: disable apic facility\n");
+		pr_info("disable apic facility\n");
 		apic_disable();
 	} else {
 		apic_phys = mp_lapic_addr;
@@ -2248,9 +2246,8 @@ int generic_processor_info(int apicid, int version)
 	    disabled_cpu_apicid == apicid) {
 		int thiscpu = num_processors + disabled_cpus;
 
-		pr_warning("APIC: Disabling requested cpu."
-			   " Processor %d/0x%x ignored.\n",
-			   thiscpu, apicid);
+		pr_warn("Disabling requested cpu. Processor %d/0x%x ignored.\n",
+			thiscpu, apicid);
 
 		disabled_cpus++;
 		return -ENODEV;
@@ -2264,10 +2261,7 @@ int generic_processor_info(int apicid, int version)
 	    apicid != boot_cpu_physical_apicid) {
 		int thiscpu = max + disabled_cpus - 1;
 
-		pr_warning(
-			"APIC: NR_CPUS/possible_cpus limit of %i almost"
-			" reached. Keeping one slot for boot cpu."
-			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
+		pr_warn("NR_CPUS/possible_cpus limit of %i almost reached.  Keeping one slot for boot cpu.  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
 		return -ENODEV;
@@ -2276,9 +2270,8 @@ int generic_processor_info(int apicid, int version)
 	if (num_processors >= nr_cpu_ids) {
 		int thiscpu = max + disabled_cpus;
 
-		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
-			   "reached. Processor %d/0x%x ignored.\n",
-			   max, thiscpu, apicid);
+		pr_warn("NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
+			max, thiscpu, apicid);
 
 		disabled_cpus++;
 		return -EINVAL;
@@ -2308,13 +2301,13 @@ int generic_processor_info(int apicid, int version)
 	 * Validate version
 	 */
 	if (version == 0x0) {
-		pr_warning("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
-			   cpu, apicid);
+		pr_warn("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
+			cpu, apicid);
 		version = 0x10;
 	}
 
 	if (version != boot_cpu_apic_version) {
-		pr_warning("BIOS bug: APIC version mismatch, boot CPU: %x, CPU %d: version %x\n",
+		pr_warn("BIOS bug: APIC version mismatch, boot CPU: %x, CPU %d: version %x\n",
 			boot_cpu_apic_version, cpu, version);
 	}
 
@@ -2590,7 +2583,7 @@ static int set_multi(const struct dmi_system_id *d)
 {
 	if (multi)
 		return 0;
-	pr_info("APIC: %s detected, Multi Chassis\n", d->ident);
+	pr_info("%s detected, Multi Chassis\n", d->ident);
 	multi = 1;
 	return 0;
 }
@@ -2686,8 +2679,8 @@ static int __init apic_set_verbosity(char *arg)
 		apic_verbosity = APIC_VERBOSE;
 #ifdef CONFIG_X86_64
 	else {
-		pr_warning("APIC Verbosity level %s not recognised"
-			" use apic=verbose or apic=debug\n", arg);
+		pr_warn("Verbosity level %s not recognised use apic=verbose or apic=debug\n",
+			arg);
 		return -EINVAL;
 	}
 #endif
@@ -2736,7 +2729,8 @@ static int __init apic_set_extnmi(char *arg)
 	else if (!strncmp("bsp", arg, 3))
 		apic_extnmi = APIC_EXTNMI_BSP;
 	else {
-		pr_warn("Unknown external NMI delivery mode `%s' ignored\n", arg);
+		pr_warn("Unknown external NMI delivery mode `%s' ignored\n",
+			arg);
 		return -EINVAL;
 	}
 
