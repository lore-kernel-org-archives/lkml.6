Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B616C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D12424F1C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D12424F1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeFXNlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:41:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeFXNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:41:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5ODfOfA843906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 06:41:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5ODfO3h843903;
        Sun, 24 Jun 2018 06:41:24 -0700
Date:   Sun, 24 Jun 2018 06:41:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-6fc0de37f663278af160e8e1f0c38b27e6c06206@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        reinette.chatre@intel.com, mingo@kernel.org
Reply-To: mingo@kernel.org, reinette.chatre@intel.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1ef4f99dd6ba12fa6fb44c5a1141e75f952b9cd9.1529706536.git.reinette.chatre@intel.com>
References: <1ef4f99dd6ba12fa6fb44c5a1141e75f952b9cd9.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Limit C-states dynamically when
 pseudo-locking active
Git-Commit-ID: 6fc0de37f663278af160e8e1f0c38b27e6c06206
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

Commit-ID:  6fc0de37f663278af160e8e1f0c38b27e6c06206
Gitweb:     https://git.kernel.org/tip/6fc0de37f663278af160e8e1f0c38b27e6c06206
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:30 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 15:35:48 +0200

x86/intel_rdt: Limit C-states dynamically when pseudo-locking active

Deeper C-states impact cache content through shrinking of the cache or
flushing entire cache to memory before reducing power to the cache.
Deeper C-states will thus negatively impact the pseudo-locked regions.

To avoid impacting pseudo-locked regions C-states are limited on
pseudo-locked region creation so that cores associated with the
pseudo-locked region are prevented from entering deeper C-states.
This is accomplished by requesting a CPU latency target which will
prevent the core from entering C6 across all supported platforms.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1ef4f99dd6ba12fa6fb44c5a1141e75f952b9cd9.1529706536.git.reinette.chatre@intel.com


---
 Documentation/x86/intel_rdt_ui.txt          |  4 +-
 arch/x86/kernel/cpu/intel_rdt.h             |  2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 85 ++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index bcd0a6d2fcf8..acac30b67c62 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -461,8 +461,8 @@ in the cache via carefully configuring the CAT feature and controlling
 application behavior. There is no guarantee that data is placed in
 cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
 “locked” data from cache. Power management C-states may shrink or
-power off cache. It is thus recommended to limit the processor maximum
-C-state, for example, by setting the processor.max_cstate kernel parameter.
+power off cache. Deeper C-states will automatically be restricted on
+pseudo-locked region creation.
 
 It is required that an application using a pseudo-locked region runs
 with affinity to the cores (or a subset of the cores) associated
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index b8e490a43290..2d9cbb9d7a58 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -142,6 +142,7 @@ struct mongroup {
  *			region
  * @debugfs_dir:	pointer to this region's directory in the debugfs
  *			filesystem
+ * @pm_reqs:		Power management QoS requests related to this region
  */
 struct pseudo_lock_region {
 	struct rdt_resource	*r;
@@ -155,6 +156,7 @@ struct pseudo_lock_region {
 	void			*kmem;
 	unsigned int		minor;
 	struct dentry		*debugfs_dir;
+	struct list_head	pm_reqs;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index dd1341557c9d..6e83f61552a5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
 #include <linux/mman.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -175,6 +176,76 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 	return rdtgrp_match;
 }
 
+/**
+ * pseudo_lock_pm_req - A power management QoS request list entry
+ * @list:	Entry within the @pm_reqs list for a pseudo-locked region
+ * @req:	PM QoS request
+ */
+struct pseudo_lock_pm_req {
+	struct list_head list;
+	struct dev_pm_qos_request req;
+};
+
+static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
+{
+	struct pseudo_lock_pm_req *pm_req, *next;
+
+	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
+		dev_pm_qos_remove_request(&pm_req->req);
+		list_del(&pm_req->list);
+		kfree(pm_req);
+	}
+}
+
+/**
+ * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ *
+ * To prevent the cache from being affected by power management entering
+ * C6 has to be avoided. This is accomplished by requesting a latency
+ * requirement lower than lowest C6 exit latency of all supported
+ * platforms as found in the cpuidle state tables in the intel_idle driver.
+ * At this time it is possible to do so with a single latency requirement
+ * for all supported platforms.
+ *
+ * Since Goldmont is supported, which is affected by X86_BUG_MONITOR,
+ * the ACPI latencies need to be considered while keeping in mind that C2
+ * may be set to map to deeper sleep states. In this case the latency
+ * requirement needs to prevent entering C2 also.
+ */
+static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
+{
+	struct pseudo_lock_pm_req *pm_req;
+	int cpu;
+	int ret;
+
+	for_each_cpu(cpu, &plr->d->cpu_mask) {
+		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
+		if (!pm_req) {
+			rdt_last_cmd_puts("fail allocating mem for PM QoS\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
+					     &pm_req->req,
+					     DEV_PM_QOS_RESUME_LATENCY,
+					     30);
+		if (ret < 0) {
+			rdt_last_cmd_printf("fail to add latency req cpu%d\n",
+					    cpu);
+			kfree(pm_req);
+			ret = -1;
+			goto out_err;
+		}
+		list_add(&pm_req->list, &plr->pm_reqs);
+	}
+
+	return 0;
+
+out_err:
+	pseudo_lock_cstates_relax(plr);
+	return ret;
+}
+
 /**
  * pseudo_lock_region_init - Initialize pseudo-lock region information
  * @plr: pseudo-lock region
@@ -242,6 +313,7 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 		return -ENOMEM;
 
 	init_waitqueue_head(&plr->lock_thread_wq);
+	INIT_LIST_HEAD(&plr->pm_reqs);
 	rdtgrp->plr = plr;
 	return 0;
 }
@@ -1135,6 +1207,12 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (ret < 0)
 		return ret;
 
+	ret = pseudo_lock_cstates_constrain(plr);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out_region;
+	}
+
 	plr->thread_done = 0;
 
 	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
@@ -1143,7 +1221,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
 		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
-		goto out_region;
+		goto out_cstates;
 	}
 
 	kthread_bind(thread, plr->cpu);
@@ -1161,7 +1239,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		 * empty pseudo-locking loop.
 		 */
 		rdt_last_cmd_puts("locking thread interrupted\n");
-		goto out_region;
+		goto out_cstates;
 	}
 
 	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
@@ -1222,6 +1300,8 @@ out_minor:
 	pseudo_lock_minor_release(new_minor);
 out_debugfs:
 	debugfs_remove_recursive(plr->debugfs_dir);
+out_cstates:
+	pseudo_lock_cstates_relax(plr);
 out_region:
 	pseudo_lock_region_clear(plr);
 out:
@@ -1255,6 +1335,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 		goto free;
 	}
 
+	pseudo_lock_cstates_relax(plr);
 	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
 	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
 	pseudo_lock_minor_release(plr->minor);
