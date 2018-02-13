Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966294AbeBMXvg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:51:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:53399 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966219AbeBMXti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822340"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 14/22] x86/intel_rdt: Enable testing for pseudo-locked region
Date: Tue, 13 Feb 2018 07:46:58 -0800
Message-Id: <4e496c20779a21154eea9b37270eed9d340b9514.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new test that can be used to determine if a provided CBM
intersects with an existing pseudo-locked region of cache domain.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  1 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 85f9ad6de113..17b7d14e2e02 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -462,6 +462,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+bool cbm_pseudo_locked(unsigned long cbm, struct rdt_domain *d);
 int rdt_pseudo_lock_fs_init(struct kernfs_node *root);
 void rdt_pseudo_lock_fs_remove(void);
 int rdt_pseudo_lock_mkdir(const char *name, umode_t mode);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 1f351b7170ef..e9ab724432f8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -273,6 +273,25 @@ static void pseudo_lock_region_kn_unlock(struct kernfs_node *kn)
 }
 
 /**
+ * cbm_pseudo_locked - Test if all or portion of CBM is pseudo-locked
+ * @cbm:	bitmask to be tested
+ * @d:		rdt_domain for which @cbm was provided
+ *
+ * RETURNS:
+ * True if bits from @cbm intersects with what has been pseudo-locked in
+ * rdt_domain @d, false otherwise.
+ */
+bool cbm_pseudo_locked(unsigned long cbm, struct rdt_domain *d)
+{
+	if (d->plr &&
+	    bitmap_intersects(&cbm, (unsigned long *)&d->plr->cbm,
+			      d->plr->r->cache.cbm_len))
+		return true;
+
+	return false;
+}
+
+/**
  * pseudo_lock_avail_get - return bitmask of cache available for locking
  * @r: resource to which this cache instance belongs
  * @d: domain representing the cache instance
-- 
2.13.6
