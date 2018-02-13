Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966318AbeBMXyf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:54:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:53393 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966120AbeBMXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822298"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 02/22] x86/intel_rdt: Make useful functions available internally
Date: Tue, 13 Feb 2018 07:46:46 -0800
Message-Id: <8a7d55dae1d5a103b30faeaf45f107697718929e.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for support of pseudo-locking we move some static
functions to be available for sharing amongst all RDT components.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             | 5 +++++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 8 ++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3fd7a70ee04a..df4db23ddd74 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -430,7 +430,12 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags);
+int rdtgroup_kn_set_ugid(struct kernfs_node *kn);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
+int closid_alloc(void);
+void closid_free(int closid);
+int update_domains(struct rdt_resource *r, int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 23e1d5c249c6..9e1a455e4d9b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -174,7 +174,7 @@ static int parse_line(char *line, struct rdt_resource *r)
 	return -EINVAL;
 }
 
-static int update_domains(struct rdt_resource *r, int closid)
+int update_domains(struct rdt_resource *r, int closid)
 {
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bdab7d2f51af..2a14867a14f7 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -109,7 +109,7 @@ static void closid_init(void)
 	closid_free_map &= ~1;
 }
 
-static int closid_alloc(void)
+int closid_alloc(void)
 {
 	u32 closid = ffs(closid_free_map);
 
@@ -121,13 +121,13 @@ static int closid_alloc(void)
 	return closid;
 }
 
-static void closid_free(int closid)
+void closid_free(int closid)
 {
 	closid_free_map |= 1 << closid;
 }
 
 /* set uid and gid of rdtgroup dirs and files to that of the creator */
-static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
+int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
 {
 	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
 				.ia_uid = current_fsuid(),
@@ -855,7 +855,7 @@ static struct rftype res_common_files[] = {
 	},
 };
 
-static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
+int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 {
 	struct rftype *rfts, *rft;
 	int ret, len;
-- 
2.13.6
