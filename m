Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeEPOuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:50:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40677 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeEPOuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:50:09 -0400
Date: Wed, 16 May 2018 16:50:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rick Warner <rick@microway.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bisected] rcu_sched detected stalls - 4.15 or newer kernel with
 some Xeon skylake CPUs and extended APIC
In-Reply-To: <alpine.DEB.2.21.1805152208590.1605@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1805161642040.1627@nanos.tec.linutronix.de>
References: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com> <b346f6d2-dd4e-d19b-099e-633045e88f4b@microway.com> <alpine.DEB.2.21.1805152208590.1605@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rick,

On Tue, 15 May 2018, Thomas Gleixner wrote:
> I can't spot an immediate fail with that commit, but I'll have a look
> tomorrow for instrumenting this with tracepoints which can be dumped from
> the stall detector.

can you please give the patch below a try? I assume you have a serial
console, otherwise this is going to be tedious.

Please add the following to the kernel command line:

  ftrace_dump_on_oops

Note, the box will panic after the first stall and spill out the trace
buffer over serial, which might take a while.

Thanks,

	tglx

8<--------------------

--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -52,20 +52,28 @@ static void
 	if (apic_dest != APIC_DEST_ALLINC)
 		cpumask_clear_cpu(smp_processor_id(), tmpmsk);
 
+	trace_printk("To: %*pbl\n", cpumask_pr_args(tmpmsk));
+
 	/* Collapse cpus in a cluster so a single IPI per cluster is sent */
 	for_each_cpu(cpu, tmpmsk) {
 		struct cluster_mask *cmsk = per_cpu(cluster_masks, cpu);
 
 		dest = 0;
+		trace_printk("CPU: %u cluster: %*pbl\n", cpu,
+			     cpumask_pr_args(&cmsk->mask));
 		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
 			dest |= per_cpu(x86_cpu_to_logical_apicid, clustercpu);
 
-		if (!dest)
+		if (!dest) {
+			trace_printk("dest = 0!?\n");
 			continue;
+		}
 
 		__x2apic_send_IPI_dest(dest, vector, apic->dest_logical);
 		/* Remove cluster CPUs from tmpmask */
 		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
+		trace_printk("dest %08x --> tmpmsk %*pbl\n", dest,
+			     cpumask_pr_args(tmpmsk));
 	}
 
 	local_irq_restore(flags);
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -124,7 +124,7 @@ int rcu_num_lvls __read_mostly = RCU_NUM
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
 /* panic() on RCU Stall sysctl. */
-int sysctl_panic_on_rcu_stall __read_mostly;
+int sysctl_panic_on_rcu_stall __read_mostly = 1;
 
 /*
  * The rcu_scheduler_active variable is initialized to the value
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -681,6 +681,7 @@ void on_each_cpu_cond(bool (*cond_func)(
 		for_each_online_cpu(cpu)
 			if (cond_func(cpu, info))
 				cpumask_set_cpu(cpu, cpus);
+		trace_printk("%*pbl\n", cpumask_pr_args(cpus));
 		on_each_cpu_mask(cpus, func, info, wait);
 		preempt_enable();
 		free_cpumask_var(cpus);
