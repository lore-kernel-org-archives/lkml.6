Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966261AbeBMXxt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:53:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:53392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966139AbeBMXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822311"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 05/22] x86/intel_rdt: Print more accurate pseudo-locking availability
Date: Tue, 13 Feb 2018 07:46:49 -0800
Message-Id: <9057ea509f1e7b5b10d695c176622214753cb41a.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A region of cache is considered available for pseudo-locking when:
 * Cache area is in use by default COS.
 * Cache area is NOT in use by any other (other than default) COS.
 * Cache area is not shared with any other entity. Specifically, the
   cache area does not appear in "Bitmask of Shareable Resource with Other
   executing entities" found in EBX during CAT enumeration.
 * Cache area is not currently pseudo-locked.

At this time the first three tests are possible and we update the "avail"
file associated with pseudo-locking to print a more accurate reflection
of pseudo-locking availability.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 62 ++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index ad8b97747024..a787a103c432 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -26,9 +26,69 @@
 
 static struct kernfs_node *pseudo_lock_kn;
 
+/**
+ * pseudo_lock_avail_get - return bitmask of cache available for locking
+ * @r: resource to which this cache instance belongs
+ * @d: domain representing the cache instance
+ *
+ * Availability for pseudo-locking is determined as follows:
+ * * Cache area is in use by default COS.
+ * * Cache area is NOT in use by any other (other than default) COS.
+ * * Cache area is not shared with any other entity. Specifically, the
+ *   cache area does not appear in "Bitmask of Shareable Resource with Other
+ *   executing entities" found in EBX during CAT enumeration.
+ *
+ * Below is also required to determine availability and will be
+ * added in later:
+ * * Cache area is not currently pseudo-locked.
+ *
+ * LOCKING:
+ * rdtgroup_mutex is expected to be held when called
+ *
+ * RETURNS:
+ * Bitmask representing region of cache that can be locked, zero if nothing
+ * available.
+ */
+static u32 pseudo_lock_avail_get(struct rdt_resource *r, struct rdt_domain *d)
+{
+	u32 avail;
+	int i;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	avail = d->ctrl_val[0];
+	for (i = 1; i < r->num_closid; i++) {
+		if (closid_allocated(i))
+			avail &= ~d->ctrl_val[i];
+	}
+	avail &= ~r->cache.shareable_bits;
+
+	return avail;
+}
+
 static int pseudo_lock_avail_show(struct seq_file *sf, void *v)
 {
-	seq_puts(sf, "0\n");
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+	bool sep;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		sep = false;
+		seq_printf(sf, "%s:", r->name);
+		list_for_each_entry(d, &r->domains, list) {
+			if (sep)
+				seq_puts(sf, ";");
+			seq_printf(sf, "%d=%x", d->id,
+				   pseudo_lock_avail_get(r, d));
+			sep = true;
+		}
+		seq_puts(sf, "\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
 	return 0;
 }
 
-- 
2.13.6
