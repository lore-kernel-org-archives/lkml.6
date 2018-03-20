Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeCTInb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:43:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:57922 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeCTIna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:43:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,334,1517904000";
   d="scan'208";a="38964554"
Date: Tue, 20 Mar 2018 16:42:55 +0800
From: "Liu, Changcheng" <changcheng.liu@intel.com>
To: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ioapic: don't use unstable TSC to detect timer IRQ
Message-ID: <20180320084255.GA187704@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rare case, the TSC is every unstable or can't sync with
real time hardware clock. After setting "tsc=unstable" in
command line, system should use delay_without_tsc to detect
timer IRQ. Or system could panic as shown in below log:

[    0.000000] Command line: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
reboot_panic=p,w tsc=unstable gpt loglevel=8 xxxxxxxxxxxxxx
vga=current nomodeset console=ttyS0,115200n8 xxxxxxxxxxxxxx
[    0.048000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.049000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.049000] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.049000] ..... (found apic 0 pin 2) ...
[    0.052000] ....... failed.
[    0.052000] ...trying to set up timer as Virtual Wire IRQ...
[    0.052000] ..... failed.
[    0.052000] ...trying to set up timer as ExtINT IRQ...
[    0.052000] ..... failed :(.
[    0.052000] Kernel panic - not syncing: IO-APIC + timer
doesn't work!  Boot with apic=debug and send a report.  Then try
booting with the 'noapic' option.
[    0.052000]
[    0.052000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.15.0-ga804a55 #5
[    0.052000] Hardware name: Intel Corporation Tiger Lake
Client Platform/TigerLake U LPDDR4 UDIMM, BIOS
TGLSFWR1.R00.1063.A00.1802071025 02/07/2018
[    0.052000] Call Trace:
[    0.052000]  dump_stack+0x68/0x9d

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index cf5d53c..dcfc5b9 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -17,6 +17,7 @@ typedef unsigned long long cycles_t;
 
 extern unsigned int cpu_khz;
 extern unsigned int tsc_khz;
+extern int tsc_unstable;
 
 extern void disable_TSC(void);
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7c55387..0809ec6 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1643,7 +1643,7 @@ static int __init timer_irq_works(void)
 	local_save_flags(flags);
 	local_irq_enable();
 
-	if (boot_cpu_has(X86_FEATURE_TSC))
+	if (boot_cpu_has(X86_FEATURE_TSC) && !tsc_unstable)
 		delay_with_tsc();
 	else
 		delay_without_tsc();
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fb43027..27b1bae 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -36,7 +36,8 @@ EXPORT_SYMBOL(tsc_khz);
 /*
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
  */
-static int __read_mostly tsc_unstable;
+int __read_mostly tsc_unstable;
+EXPORT_SYMBOL(tsc_unstable);
 
 /* native_sched_clock() is called before tsc_init(), so
    we must start with the TSC soft disabled to prevent
-- 
2.7.4
