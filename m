Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966301AbeBMXw2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:52:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:53397 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966196AbeBMXtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822327"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 10/22] x86/intel_rdt: Disable pseudo-locking if CDP enabled
Date: Tue, 13 Feb 2018 07:46:54 -0800
Message-Id: <e55972642c15170c9cce78cf24dabde3df8d6c6b.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pseudo-locking can work when Code and Data Prioritization (CDP) is enabled,
but there are a few additional checks and actions involved. At this time
it is not clear if users would want to use pseudo-locking and CDP at the
same time so the support of this is delayed until we understand the
usage better.

Disable pseudo-locking if CDP is enabled. Add the details of things to
keep in mind for anybody considering enabling this support.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index a0c144b5b09b..f6932a7de6e7 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -443,6 +443,36 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	/*
+	 * Pseudo-locking not supported when CDP is enabled.
+	 *
+	 * Some things to consider if you would like to enable this support
+	 * (using L3 CDP as example):
+	 * - When CDP is enabled two separate resources are exposed, L3DATA
+	 *   and L3CODE, but they are actually on the same cache. The
+	 *   implication for pseudo-locking is that if a pseudo-locked
+	 *   region is created on a domain of one resource (eg. L3CODE),
+	 *   then a pseudo-locked region cannot be created on that same
+	 *   domain of the other resource (eg. L3DATA). This is because
+	 *   the creation of a pseudo-locked region involves a call to
+	 *   wbinvd that will affect all cache allocations on particular
+	 *   domain.
+	 * - Considering the previous, it may be possible to only expose
+	 *   one of the CDP resources to pseudo-locking and hide the other.
+	 *   For example, we could consider to only expose L3DATA and since
+	 *   the L3 cache is unified it is still possible to place
+	 *   instructions there are execute it.
+	 * - If only one region is exposed to pseudo-locking we should still
+	 *   keep in mind that availability of a portion of cache for
+	 *   pseudo-locking should take into account both resources. Similarly,
+	 *   if a pseudo-locked region is created in one resource, the portion
+	 *   of cache used by it should be made unavailable to all future
+	 *   allocations from both resources.
+	 */
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled ||
+	    rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+		return 0;
+
+	/*
 	 * Not knowing the bits to disable prefetching is not a failure
 	 * that should be propagated since we only return prefetching bits
 	 * for those platforms pseudo-locking has been tested on. If
-- 
2.13.6
