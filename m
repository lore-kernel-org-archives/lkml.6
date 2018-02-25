Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeBYTiN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:38:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:38:11 -0500
Date: Sun, 25 Feb 2018 20:38:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fixes for 4.16
Message-ID: <alpine.DEB.2.21.1802252029020.1468@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A small set of fixes:

  - UAPI data type correction for hyperv

  - Correct the cpu cores field in /proc/cpuinfo on CPU hotplug

  - Return proper error code in the resctrl file system failure path to avoid silent
    subsequent failures

  - Correct a subtle accounting issue in the new vector allocation code
    which went unnoticed for a while and caused suspend/resume failures

Thanks,

	tglx

------------------>
Dou Liyang (1):
      x86/topology: Fix function name in documentation

KarimAllah Ahmed (1):
      x86/headers/UAPI: Use __u64 instead of u64 in <uapi/asm/hyperv.h>

Samuel Neves (1):
      x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly across CPU hotplug operations

Thomas Gleixner (2):
      genirq/matrix: Handle CPU offlining proper
      x86/apic/vector: Handle vector release on CPU unplug correctly

Wang Hui (1):
      x86/intel_rdt: Fix incorrect returned value when creating rdgroup sub-directory in resctrl file system


 Documentation/x86/topology.txt           |  2 +-
 arch/x86/include/uapi/asm/hyperv.h       | 18 +++++++++---------
 arch/x86/kernel/apic/vector.c            | 25 ++++++++++++++++++++++---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  1 +
 arch/x86/kernel/smpboot.c                |  1 +
 kernel/irq/matrix.c                      | 23 ++++++++++++++---------
 6 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index f3e9d7e9ed6c..2953e3ec9a02 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -108,7 +108,7 @@ The topology of a system is described in the units of:
 
     The number of online threads is also printed in /proc/cpuinfo "siblings."
 
-  - topology_sibling_mask():
+  - topology_sibling_cpumask():
 
     The cpumask contains all online threads in the core to which a thread
     belongs.
diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 197c2e6c7376..099414345865 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -241,24 +241,24 @@
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
 
 struct hv_reenlightenment_control {
-	u64 vector:8;
-	u64 reserved1:8;
-	u64 enabled:1;
-	u64 reserved2:15;
-	u64 target_vp:32;
+	__u64 vector:8;
+	__u64 reserved1:8;
+	__u64 enabled:1;
+	__u64 reserved2:15;
+	__u64 target_vp:32;
 };
 
 #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
 #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
 
 struct hv_tsc_emulation_control {
-	u64 enabled:1;
-	u64 reserved:63;
+	__u64 enabled:1;
+	__u64 reserved:63;
 };
 
 struct hv_tsc_emulation_status {
-	u64 inprogress:1;
-	u64 reserved:63;
+	__u64 inprogress:1;
+	__u64 reserved:63;
 };
 
 #define HV_X64_MSR_HYPERCALL_ENABLE		0x00000001
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3cc471beb50b..bb6f7a2148d7 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -134,21 +134,40 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	struct irq_desc *desc = irq_data_to_desc(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
 
 	lockdep_assert_held(&vector_lock);
 
 	trace_vector_update(irqd->irq, newvec, newcpu, apicd->vector,
 			    apicd->cpu);
 
-	/* Setup the vector move, if required  */
-	if (apicd->vector && cpu_online(apicd->cpu)) {
+	/*
+	 * If there is no vector associated or if the associated vector is
+	 * the shutdown vector, which is associated to make PCI/MSI
+	 * shutdown mode work, then there is nothing to release. Clear out
+	 * prev_vector for this and the offlined target case.
+	 */
+	apicd->prev_vector = 0;
+	if (!apicd->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
+		goto setnew;
+	/*
+	 * If the target CPU of the previous vector is online, then mark
+	 * the vector as move in progress and store it for cleanup when the
+	 * first interrupt on the new vector arrives. If the target CPU is
+	 * offline then the regular release mechanism via the cleanup
+	 * vector is not possible and the vector can be immediately freed
+	 * in the underlying matrix allocator.
+	 */
+	if (cpu_online(apicd->cpu)) {
 		apicd->move_in_progress = true;
 		apicd->prev_vector = apicd->vector;
 		apicd->prev_cpu = apicd->cpu;
 	} else {
-		apicd->prev_vector = 0;
+		irq_matrix_free(vector_matrix, apicd->cpu, apicd->vector,
+				managed);
 	}
 
+setnew:
 	apicd->vector = newvec;
 	apicd->cpu = newcpu;
 	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bdab7d2f51af..fca759d272a1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1804,6 +1804,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 		goto out_common_fail;
 	}
 	closid = ret;
+	ret = 0;
 
 	rdtgrp->closid = closid;
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9eee25d07586..ff99e2b6fc54 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1437,6 +1437,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	c->cpu_core_id = 0;
+	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
 }
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5187dfe809ac..4c5770407031 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -16,6 +16,7 @@ struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
 	unsigned int		managed;
+	bool			initialized;
 	bool			online;
 	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
 	unsigned long		managed_map[IRQ_MATRIX_SIZE];
@@ -81,9 +82,11 @@ void irq_matrix_online(struct irq_matrix *m)
 
 	BUG_ON(cm->online);
 
-	bitmap_zero(cm->alloc_map, m->matrix_bits);
-	cm->available = m->alloc_size - (cm->managed + m->systembits_inalloc);
-	cm->allocated = 0;
+	if (!cm->initialized) {
+		cm->available = m->alloc_size;
+		cm->available -= cm->managed + m->systembits_inalloc;
+		cm->initialized = true;
+	}
 	m->global_available += cm->available;
 	cm->online = true;
 	m->online_maps++;
@@ -370,14 +373,16 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
 	if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
 		return;
 
-	if (cm->online) {
-		clear_bit(bit, cm->alloc_map);
-		cm->allocated--;
+	clear_bit(bit, cm->alloc_map);
+	cm->allocated--;
+
+	if (cm->online)
 		m->total_allocated--;
-		if (!managed) {
-			cm->available++;
+
+	if (!managed) {
+		cm->available++;
+		if (cm->online)
 			m->global_available++;
-		}
 	}
 	trace_irq_matrix_free(bit, cpu, m, cm);
 }
