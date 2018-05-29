Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967301AbeE2VDr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:03:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:53962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966175AbeE2VBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:01:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127721"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 18/38] x86/intel_rdt: Add utility to test if tasks assigned to resource group
Date: Tue, 29 May 2018 05:57:43 -0700
Message-Id: <9149005d01de4b197bae13a45e6efdb536383ca1.1527593970.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
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
index bda87f5ef7bc..10a1539cbec6 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -480,6 +480,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  u32 cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
+int rdtgroup_tasks_assigned(struct rdtgroup *r);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 void closid_free(int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 83379982f26a..8f754a05d44d 100644
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
