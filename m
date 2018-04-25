Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeDYSNF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:41713 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932160AbeDYSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243691"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 18/39] x86/intel_rdt: Add utility to test if tasks assigned to resource group
Date: Wed, 25 Apr 2018 03:09:54 -0700
Message-Id: <fdb111c9dfffb508cc6a9bcecffe325f374532ad.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In considering changes to a resource group it becomes necessary to know
whether tasks have been assigned to the resource group in question.

Introduce a new utility that can be used to check if any tasks have been
assigned to a particular resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |  1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index fa2aa7e8ad73..e33b1215f394 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -465,6 +465,7 @@ int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
+int rdtgroup_tasks_assigned(struct rdtgroup *r);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 void closid_free(int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 541103a2dea0..f2da6a2827c8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -564,6 +564,32 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return ret;
 }
 
+/**
+ * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
+ * @r: Resource group
+ *
+ * Return: 1 if tasks have been assigned to @r, 0 otherwise
+ */
+int rdtgroup_tasks_assigned(struct rdtgroup *r)
+{
+	struct task_struct *p, *t;
+	int ret = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
+		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid)) {
+			ret = 1;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static int rdtgroup_task_write_permission(struct task_struct *task,
 					  struct kernfs_open_file *of)
 {
-- 
2.13.6
