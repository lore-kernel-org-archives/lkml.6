Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeEVTh7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:37:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:16706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752420AbeEVTcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406352"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 06/38] x86/intel_rdt: Make useful functions available internally
Date: Tue, 22 May 2018 04:28:54 -0700
Message-Id: <2d44c94263cb89b04a4c01e6d59c8b3357208e9d.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In support of the work done to enable resource groups to have different
modes some static functions need to be available for sharing amongst
all RDT components.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             | 2 ++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 7ff1f633bebe..5f3915c2e599 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -465,6 +465,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
+int update_domains(struct rdt_resource *r, int closid);
+void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 116d57b248d3..2c23bb136ccc 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -175,7 +175,7 @@ static int parse_line(char *line, struct rdt_resource *r)
 	return -EINVAL;
 }
 
-static int update_domains(struct rdt_resource *r, int closid)
+int update_domains(struct rdt_resource *r, int closid)
 {
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fdc55357251b..35e538eed977 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -121,7 +121,7 @@ static int closid_alloc(void)
 	return closid;
 }
 
-static void closid_free(int closid)
+void closid_free(int closid)
 {
 	closid_free_map |= 1 << closid;
 }
-- 
2.13.6
