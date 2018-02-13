Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966356AbeBMXwo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:52:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:53394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966195AbeBMXtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822323"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 09/22] x86/intel_rdt: Discover supported platforms via prefetch disable bits
Date: Tue, 13 Feb 2018 07:46:53 -0800
Message-Id: <d44d5a2d01194fc6ca4fb05aabef954b5682a739.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing the model specific prefetch disable bits is required to support
cache pseudo-locking because the hardware prefetchers need to be disabled
when the kernel memory is pseudo-locked to cache. We add these bits only
for platforms known to support cache pseudo-locking.

If we have not validated pseudo-locking on a platform that does support
RDT/CAT this should not be seen as a failure of CAT, the pseudo-locking
interface will just not be set up.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 80 +++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 94bd1b4fbfee..a0c144b5b09b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -24,8 +24,22 @@
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <asm/intel-family.h>
 #include "intel_rdt.h"
 
+/*
+ * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
+ * prefetcher state. Details about this register can be found in the MSR
+ * tables for specific platforms found in Intel's SDM.
+ */
+#define MSR_MISC_FEATURE_CONTROL	0x000001a4
+
+/*
+ * The bits needed to disable hardware prefetching varies based on the
+ * platform. During initialization we will discover which bits to use.
+ */
+static u64 prefetch_disable_bits;
+
 struct kernfs_node *pseudo_lock_kn;
 
 /*
@@ -358,6 +372,57 @@ int rdt_pseudo_lock_rmdir(struct kernfs_node *kn)
 }
 
 /**
+ * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ *
+ * Here we capture the list of platforms that have been validated to support
+ * pseudo-locking. This includes testing to ensure pseudo-locked regions
+ * with low cache miss rates can be created under variety of load conditions
+ * as well as that these pseudo-locked regions can maintain their low cache
+ * miss rates under variety of load conditions for significant lengths of time.
+ *
+ * After a platform has been validated to support pseudo-locking its
+ * hardware prefetch disable bits are included here as they are documented
+ * in the SDM.
+ *
+ * RETURNS
+ * If platform is supported, the bits to disable hardware prefetchers, 0
+ * if platform is not supported.
+ */
+static u64 get_prefetch_disable_bits(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86 != 6)
+		return 0;
+
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_BROADWELL_X:
+		/*
+		 * SDM defines bits of MSR_MISC_FEATURE_CONTROL register
+		 * as:
+		 * 0    L2 Hardware Prefetcher Disable (R/W)
+		 * 1    L2 Adjacent Cache Line Prefetcher Disable (R/W)
+		 * 2    DCU Hardware Prefetcher Disable (R/W)
+		 * 3    DCU IP Prefetcher Disable (R/W)
+		 * 63:4 Reserved
+		 */
+		return 0xF;
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+		/*
+		 * SDM defines bits of MSR_MISC_FEATURE_CONTROL register
+		 * as:
+		 * 0     L2 Hardware Prefetcher Disable (R/W)
+		 * 1     Reserved
+		 * 2     DCU Hardware Prefetcher Disable (R/W)
+		 * 63:3  Reserved
+		 */
+		return 0x5;
+	}
+
+	return 0;
+}
+
+/**
  * rdt_pseudo_lock_fs_init - Create and initialize pseudo-locking files
  * @root: location in kernfs where directory and files should be created
  *
@@ -377,6 +442,17 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	/*
+	 * Not knowing the bits to disable prefetching is not a failure
+	 * that should be propagated since we only return prefetching bits
+	 * for those platforms pseudo-locking has been tested on. If
+	 * pseudo-locking has not been tested to work on this platform the
+	 * other RDT features should continue to be available.
+	 */
+	prefetch_disable_bits = get_prefetch_disable_bits();
+	if (prefetch_disable_bits == 0)
+		return 0;
+
 	pseudo_lock_kn = kernfs_create_dir(root, "pseudo_lock",
 					   root->mode, NULL);
 	if (IS_ERR(pseudo_lock_kn))
@@ -420,6 +496,10 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 void rdt_pseudo_lock_fs_remove(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!pseudo_lock_kn)
+		return;
+
 	mutex_lock(&rdt_pseudo_lock_mutex);
 
 	if (new_plr) {
-- 
2.13.6
