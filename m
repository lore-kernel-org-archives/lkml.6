Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC92C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924772168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924772168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeHNUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:24:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbeHNUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:24:15 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2794DDE;
        Tue, 14 Aug 2018 17:36:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4.14 055/104] cpu/hotplug: Boot HT siblings at least once
Date:   Tue, 14 Aug 2018 19:17:09 +0200
Message-Id: <20180814171518.896066209@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 0cc3cd21657be04cb0559fe8063f2130493f92cf upstream

Due to the way Machine Check Exceptions work on X86 hyperthreads it's
required to boot up _all_ logical cores at least once in order to set the
CR4.MCE bit.

So instead of ignoring the sibling threads right away, let them boot up
once so they can configure themselves. After they came out of the initial
boot stage check whether its a "secondary" sibling and cancel the operation
which puts the CPU back into offline state.

Reported-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cpu.c |   72 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 24 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -60,6 +60,7 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
+	bool			booted_once;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -346,6 +347,40 @@ void cpu_hotplug_enable(void)
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 #endif	/* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_HOTPLUG_SMT
+enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
+
+static int __init smt_cmdline_disable(char *str)
+{
+	cpu_smt_control = CPU_SMT_DISABLED;
+	if (str && !strcmp(str, "force")) {
+		pr_info("SMT: Force disabled\n");
+		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
+	}
+	return 0;
+}
+early_param("nosmt", smt_cmdline_disable);
+
+static inline bool cpu_smt_allowed(unsigned int cpu)
+{
+	if (cpu_smt_control == CPU_SMT_ENABLED)
+		return true;
+
+	if (topology_is_primary_thread(cpu))
+		return true;
+
+	/*
+	 * On x86 it's required to boot all logical CPUs at least once so
+	 * that the init code can get a chance to set CR4.MCE on each
+	 * CPU. Otherwise, a broadacasted MCE observing CR4.MCE=0b on any
+	 * core will shutdown the machine.
+	 */
+	return !per_cpu(cpuhp_state, cpu).booted_once;
+}
+#else
+static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
+#endif
+
 static inline enum cpuhp_state
 cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 {
@@ -426,6 +461,16 @@ static int bringup_wait_for_ap(unsigned
 	stop_machine_unpark(cpu);
 	kthread_unpark(st->thread);
 
+	/*
+	 * SMT soft disabling on X86 requires to bring the CPU out of the
+	 * BIOS 'wait for SIPI' state in order to set the CR4.MCE bit.  The
+	 * CPU marked itself as booted_once in cpu_notify_starting() so the
+	 * cpu_smt_allowed() check will now return false if this is not the
+	 * primary sibling.
+	 */
+	if (!cpu_smt_allowed(cpu))
+		return -ECANCELED;
+
 	if (st->target <= CPUHP_AP_ONLINE_IDLE)
 		return 0;
 
@@ -937,29 +982,6 @@ EXPORT_SYMBOL(cpu_down);
 #define takedown_cpu		NULL
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-#ifdef CONFIG_HOTPLUG_SMT
-enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
-
-static int __init smt_cmdline_disable(char *str)
-{
-	cpu_smt_control = CPU_SMT_DISABLED;
-	if (str && !strcmp(str, "force")) {
-		pr_info("SMT: Force disabled\n");
-		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
-	}
-	return 0;
-}
-early_param("nosmt", smt_cmdline_disable);
-
-static inline bool cpu_smt_allowed(unsigned int cpu)
-{
-	return cpu_smt_control == CPU_SMT_ENABLED ||
-		topology_is_primary_thread(cpu);
-}
-#else
-static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
-#endif
-
 /**
  * notify_cpu_starting(cpu) - Invoke the callbacks on the starting CPU
  * @cpu: cpu that just started
@@ -974,6 +996,7 @@ void notify_cpu_starting(unsigned int cp
 	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
+	st->booted_once = true;
 	while (st->state < target) {
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
@@ -2192,5 +2215,6 @@ void __init boot_cpu_init(void)
  */
 void __init boot_cpu_hotplug_init(void)
 {
-	per_cpu_ptr(&cpuhp_state, smp_processor_id())->state = CPUHP_ONLINE;
+	this_cpu_write(cpuhp_state.booted_once, true);
+	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }


