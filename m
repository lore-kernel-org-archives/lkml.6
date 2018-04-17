Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeDQNrF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:47:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbeDQNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:46:59 -0400
Date: Tue, 17 Apr 2018 06:46:12 -0700
From: tip-bot for Alison Schofield <tipbot@zytor.com>
Message-ID: <tip-1340ccfa9a9afefdbab90d7935d4ed19817e37c2@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, prarit@redhat.com,
        imammedo@redhat.com, rientjes@google.com, mingo@kernel.org,
        alison.schofield@intel.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, tony.luck@intel.com, bp@suse.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, hpa@linux.intel.com,
        bp@alien8.de
Reply-To: hpa@zytor.com, bp@suse.de, tony.luck@intel.com,
        tim.c.chen@linux.intel.com, bp@alien8.de, hpa@linux.intel.com,
        dave.hansen@linux.intel.com, imammedo@redhat.com, prarit@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        alison.schofield@intel.com, tglx@linutronix.de, mingo@kernel.org,
        rientjes@google.com
In-Reply-To: <20180407002130.GA18984@alison-desk.jf.intel.com>
References: <20180407002130.GA18984@alison-desk.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86,sched: Allow topologies where NUMA nodes share
 an LLC
Git-Commit-ID: 1340ccfa9a9afefdbab90d7935d4ed19817e37c2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1340ccfa9a9afefdbab90d7935d4ed19817e37c2
Gitweb:     https://git.kernel.org/tip/1340ccfa9a9afefdbab90d7935d4ed19817e37c2
Author:     Alison Schofield <alison.schofield@intel.com>
AuthorDate: Fri, 6 Apr 2018 17:21:30 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 15:39:55 +0200

x86,sched: Allow topologies where NUMA nodes share an LLC

Intel's Skylake Server CPUs have a different LLC topology than previous
generations. When in Sub-NUMA-Clustering (SNC) mode, the package is divided
into two "slices", each containing half the cores, half the LLC, and one
memory controller and each slice is enumerated to Linux as a NUMA
node. This is similar to how the cores and LLC were arranged for the
Cluster-On-Die (CoD) feature.

CoD allowed the same cache line to be present in each half of the LLC.
But, with SNC, each line is only ever present in *one* slice. This means
that the portion of the LLC *available* to a CPU depends on the data being
accessed:

    Remote socket: entire package LLC is shared
    Local socket->local slice: data goes into local slice LLC
    Local socket->remote slice: data goes into remote-slice LLC. Slightly
                    		higher latency than local slice LLC.

The biggest implication from this is that a process accessing all
NUMA-local memory only sees half the LLC capacity.

The CPU describes its cache hierarchy with the CPUID instruction. One of
the CPUID leaves enumerates the "logical processors sharing this
cache". This information is used for scheduling decisions so that tasks
move more freely between CPUs sharing the cache.

But, the CPUID for the SNC configuration discussed above enumerates the LLC
as being shared by the entire package. This is not 100% precise because the
entire cache is not usable by all accesses. But, it *is* the way the
hardware enumerates itself, and this is not likely to change.

The userspace visible impact of all the above is that the sysfs info
reports the entire LLC as being available to the entire package. As noted
above, this is not true for local socket accesses. This patch does not
correct the sysfs info. It is the same, pre and post patch.

The current code emits the following warning:

 sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.

The warning is coming from the topology_sane() check in smpboot.c because
the topology is not matching the expectations of the model for obvious
reasons.

To fix this, add a vendor and model specific check to never call
topology_sane() for these systems. Also, just like "Cluster-on-Die" disable
the "coregroup" sched_domain_topology_level and use NUMA information from
the SRAT alone.

This is OK at least on the hardware we are immediately concerned about
because the LLC sharing happens at both the slice and at the package level,
which are also NUMA boundaries.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: brice.goglin@gmail.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lkml.kernel.org/r/20180407002130.GA18984@alison-desk.jf.intel.com

---
 arch/x86/kernel/smpboot.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b6fc54..45175b81dd5b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -77,6 +77,8 @@
 #include <asm/i8259.h>
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
+#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -390,15 +392,47 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+/*
+ * Define snc_cpu[] for SNC (Sub-NUMA Cluster) CPUs.
+ *
+ * These are Intel CPUs that enumerate an LLC that is shared by
+ * multiple NUMA nodes. The LLC on these systems is shared for
+ * off-package data access but private to the NUMA node (half
+ * of the package) for on-package access.
+ *
+ * CPUID (the source of the information about the LLC) can only
+ * enumerate the cache as being shared *or* unshared, but not
+ * this particular configuration. The CPU in this case enumerates
+ * the cache to be shared across the entire package (spanning both
+ * NUMA nodes).
+ */
+
+static const struct x86_cpu_id snc_cpu[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X },
+	{}
+};
+
 static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
-	if (per_cpu(cpu_llc_id, cpu1) != BAD_APICID &&
-	    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2))
-		return topology_sane(c, o, "llc");
+	/* Do not match if we do not have a valid APICID for cpu: */
+	if (per_cpu(cpu_llc_id, cpu1) == BAD_APICID)
+		return false;
 
-	return false;
+	/* Do not match if LLC id does not match: */
+	if (per_cpu(cpu_llc_id, cpu1) != per_cpu(cpu_llc_id, cpu2))
+		return false;
+
+	/*
+	 * Allow the SNC topology without warning. Return of false
+	 * means 'c' does not share the LLC of 'o'. This will be
+	 * reflected to userspace.
+	 */
+	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu))
+		return false;
+
+	return topology_sane(c, o, "llc");
 }
 
 /*
@@ -456,7 +490,8 @@ static struct sched_domain_topology_level x86_topology[] = {
 
 /*
  * Set if a package/die has multiple NUMA nodes inside.
- * AMD Magny-Cours and Intel Cluster-on-Die have this.
+ * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
+ * Sub-NUMA Clustering have this.
  */
 static bool x86_has_numa_in_package;
 
