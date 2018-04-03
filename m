Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeDCVMR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:12:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:59154 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeDCVMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:12:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000";
   d="scan'208";a="40449474"
Date: Tue, 3 Apr 2018 14:12:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86,sched: allow topologies where NUMA nodes share an LLC
Message-ID: <20180403211230.GA12842@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Intel's Skylake Server CPUs have a different LLC topology than previous
generations. When in Sub-NUMA-Clustering (SNC) mode, the package is
divided into two "slices", each containing half the cores, half the LLC,
and one memory controller and each slice is enumerated to Linux as a
NUMA node. This is similar to how the cores and LLC were arranged
for the Cluster-On-Die (CoD) feature.

CoD allowed the same cache line to be present in each half of the LLC.
But, with SNC, each line is only ever present in *one* slice. This
means that the portion of the LLC *available* to a CPU depends on the
data being accessed:

    Remote socket: entire package LLC is shared
    Local socket->local slice: data goes into local slice LLC
    Local socket->remote slice: data goes into remote-slice LLC. Slightly
                    		higher latency than local slice LLC.

The biggest implication from this is that a process accessing all
NUMA-local memory only sees half the LLC capacity.

The CPU describes its cache hierarchy with the CPUID instruction. One
of the CPUID leaves enumerates the "logical processors sharing this
cache". This information is used for scheduling decisions so that tasks
move more freely between CPUs sharing the cache.

But, the CPUID for the SNC configuration discussed above enumerates
the LLC as being shared by the entire package. This is not 100%
precise because the entire cache is not usable by all accesses. But,
it *is* the way the hardware enumerates itself, and this is not likely
to change.

The userspace visible impact of all the above is that the sysfs info
reports the entire LLC as being available to the entire package. As
noted above, this is not true for local socket accesses. This patch
does not correct the sysfs info. It is the same, pre and post patch.

This patch continues to allow this SNC topology and it does so without
complaint. It eliminates a warning that looks like this:

	sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.

The warning is coming from the sane_topology check() in smpboot.c.
To fix this, add a vendor and model specific check to never call
topology_sane() for these systems. Also, just like "Cluster-on-Die"
we throw out the "coregroup" sched_domain_topology_level and use
NUMA information from the SRAT alone.

This is OK at least on the hardware we are immediately concerned about
because the LLC sharing happens at both the slice and at the package
level, which are also NUMA boundaries.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: brice.goglin@gmail.com
Cc: Ingo Molnar <mingo@kernel.org>
---

Changes in v4:

 * Added this to the patch description above:

   The userspace visible impact of all the above is that the sysfs info
   reports the entire LLC as being available to the entire package. As
   noted above, this is not true for local socket accesses. This patch
   does not correct the sysfs info. It is the same, pre and post patch.

   This patch continues to allow this SNC topology and it does so without
   complaint. It eliminates a warning that looks like this:
  
 * Changed the code comment per PeterZ/DaveH discussion wrt bypassing
   that topology_sane() check in match_llc()
	/*
	 * false means 'c' does not share the LLC of 'o'.
	 * Note: this decision gets reflected all the way
	 * out to userspace
	 */
   This message hopes to clarify what happens when we return false.
   Note that returning false is *not* new to this patch. Without
   this patch we always returned false - with a warning. This avoids
   that warning and returns false directly.

 * Remove __initconst from snc_cpu[] declaration that I had added in
   v3. This is not an init time only path. 

 * Do not deal with the wrong sysfs info. It was wrong before this
   patch and it will be the exact same 'wrongness' after this patch.

   We can address the sysfs reporting separately. Here are some options:
   1) Change the way the LLC-size is reported.  Enumerate two separate,
      half-sized LLCs shared only by the slice when SNC mode is on.
   2) Do not export the sysfs info that is wrong. Prevents userspace
      from making bad decisions based on inaccurate info.


Changes in v3:

 * Use x86_match_cpu() for vendor & model check and moved related
   comments to the array define. (Still just one system model)

 * Updated the comments surrounding the topology_sane() check.


Changes in v2:

 * Add vendor check (Intel) where we only had a model check (Skylake_X).
   Considered the suggestion of adding a new flag here but thought that
   to be overkill for this usage.

 * Return false, instead of true, from match_llc() per reviewer suggestion.
   That also cleaned up a topology broken bug message in sched_domain().

 * Updated the comments around the match_llc() return value, continuing to
   note that the return value doesn't actually matter because we are throwing
   away coregroups for scheduling.

 * Changed submitter. I'm following up on this patch originally submitted
   by Dave Hansen.

 arch/x86/kernel/smpboot.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b..93fc502 100644
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
@@ -390,15 +392,66 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+/*
+ * Set if a package/die has multiple NUMA nodes inside.
+ * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
+ * Sub-NUMA Clustering have this.
+ */
+
+static bool x86_has_numa_in_package;
+
+/*
+ * Define SNC (Sub-NUMA Cluster) CPUs.
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
+	 * topology_sane() considers LLCs that span NUMA nodes to be
+	 * insane and will display a warning message. Bypass the call
+	 * to topology_sane() for snc_cpu's to avoid that warning.
+	 */
+
+	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu)) {
+		/* Indicate that package has NUMA nodes inside: */
+		x86_has_numa_in_package = true;
+
+		/*
+		 * false means 'c' does not share the LLC of 'o'.
+		 * Note: this decision gets reflected all the way
+		 * out to userspace.
+		 */
+
+		return false;
+	}
+
+	return topology_sane(c, o, "llc");
 }
 
 /*
@@ -454,12 +507,6 @@ static struct sched_domain_topology_level x86_topology[] = {
 	{ NULL, },
 };
 
-/*
- * Set if a package/die has multiple NUMA nodes inside.
- * AMD Magny-Cours and Intel Cluster-on-Die have this.
- */
-static bool x86_has_numa_in_package;
-
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = smp_num_siblings > 1;
-- 
2.7.4
