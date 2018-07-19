Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4503ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43020671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGSXRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:17:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbeGSXRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:17:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMVlTV2439590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:31:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMVlhd2439587;
        Thu, 19 Jul 2018 15:31:47 -0700
Date:   Thu, 19 Jul 2018 15:31:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-e2a9ca29b5edc89da2fddeae30e1070b272395c5@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, pasha.tatashin@oracle.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          pasha.tatashin@oracle.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180719205545.16512-21-pasha.tatashin@oracle.com>
References: <20180719205545.16512-21-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Initialize cyc2ns when tsc frequency is
 determined
Git-Commit-ID: e2a9ca29b5edc89da2fddeae30e1070b272395c5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e2a9ca29b5edc89da2fddeae30e1070b272395c5
Gitweb:     https://git.kernel.org/tip/e2a9ca29b5edc89da2fddeae30e1070b272395c5
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:39 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:42 +0200

x86/tsc: Initialize cyc2ns when tsc frequency is determined

cyc2ns converts tsc to nanoseconds, and it is handled in a per-cpu data
structure.

Currently, the setup code for c2ns data for every possible CPU goes through
the same sequence of calculations as for the boot CPU, but is based on the
same tsc frequency as the boot CPU, and thus this is not necessary.

Initialize the boot cpu when tsc frequency is determined. Copy the
calculated data from the boot CPU to the other CPUs in tsc_init().

In addition do the following:

 - Remove unnecessary zeroing of c2ns data by removing cyc2ns_data_init()

 - Split set_cyc2ns_scale() into two functions, so set_cyc2ns_scale() can be
   called when system is up, and wraps around __set_cyc2ns_scale() that can
   be called directly when system is booting but avoids saving restoring
   IRQs and going and waking up from idle.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-21-pasha.tatashin@oracle.com

---
 arch/x86/kernel/tsc.c | 94 +++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4cab2236169e..7ea0718a4c75 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -103,23 +103,6 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static void cyc2ns_data_init(struct cyc2ns_data *data)
-{
-	data->cyc2ns_mul = 0;
-	data->cyc2ns_shift = 0;
-	data->cyc2ns_offset = 0;
-}
-
-static void __init cyc2ns_init(int cpu)
-{
-	struct cyc2ns *c2n = &per_cpu(cyc2ns, cpu);
-
-	cyc2ns_data_init(&c2n->data[0]);
-	cyc2ns_data_init(&c2n->data[1]);
-
-	seqcount_init(&c2n->seq);
-}
-
 static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
@@ -135,18 +118,11 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
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
 
@@ -178,12 +154,55 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
 	c2n->data[0] = data;
 	raw_write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+}
+
+static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
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
 
+/*
+ * Initialize cyc2ns for boot cpu
+ */
+static void __init cyc2ns_init_boot_cpu(void)
+{
+	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
+
+	seqcount_init(&c2n->seq);
+	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
+}
+
+/*
+ * Secondary CPUs do not run through cyc2ns_init(), so set up
+ * all the scale factors for all CPUs, assuming the same
+ * speed as the bootup CPU. (cpufreq notifiers will fix this
+ * up if their speed diverges)
+ */
+static void __init cyc2ns_init_secondary_cpus(void)
+{
+	unsigned int cpu, this_cpu = smp_processor_id();
+	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
+	struct cyc2ns_data *data = c2n->data;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu != this_cpu) {
+			seqcount_init(&c2n->seq);
+			c2n = per_cpu_ptr(&cyc2ns, cpu);
+			c2n->data[0] = data[0];
+			c2n->data[1] = data[1];
+		}
+	}
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -1385,6 +1404,10 @@ void __init tsc_early_init(void)
 	if (!determine_cpu_tsc_frequencies())
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
+
+	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+	tsc_store_and_check_tsc_adjust(true);
+	cyc2ns_init_boot_cpu();
 }
 
 void __init tsc_init(void)
@@ -1401,23 +1424,12 @@ void __init tsc_init(void)
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
 		}
+		/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+		tsc_store_and_check_tsc_adjust(true);
+		cyc2ns_init_boot_cpu();
 	}
 
-	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-	tsc_store_and_check_tsc_adjust(true);
-
-	/*
-	 * Secondary CPUs do not run through tsc_init(), so set up
-	 * all the scale factors for all CPUs, assuming the same
-	 * speed as the bootup CPU. (cpufreq notifiers will fix this
-	 * up if their speed diverges)
-	 */
-	cyc = rdtsc();
-	for_each_possible_cpu(cpu) {
-		cyc2ns_init(cpu);
-		set_cyc2ns_scale(tsc_khz, cpu, cyc);
-	}
-
+	cyc2ns_init_secondary_cpus();
 	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
