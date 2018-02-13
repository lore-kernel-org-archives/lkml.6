Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966286AbeBMXyF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:54:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:53393 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966133AbeBMXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822308"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 04/22] x86/intel_rdt: Introduce test to determine if closid is in use
Date: Tue, 13 Feb 2018 07:46:48 -0800
Message-Id: <5858b9df20e81bc140bae9283c3e63cc219fb7c8.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During CAT feature discovery the capacity bitmasks (CBMs) associated
with all the classes of service are initialized to all ones, even if the
class of service is not in use. Introduce a test that can be used to
determine if a class of service is in use. This test enables code
interested in parsing the CBMs to know if its values are meaningful or
can be ignored.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          | 1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 146a8090bb58..8f5ded384e19 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -435,6 +435,7 @@ int rdtgroup_kn_set_ugid(struct kernfs_node *kn);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closid_alloc(void);
 void closid_free(int closid);
+bool closid_allocated(unsigned int closid);
 int update_domains(struct rdt_resource *r, int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 2a14867a14f7..5698d66b6892 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -126,6 +126,12 @@ void closid_free(int closid)
 	closid_free_map |= 1 << closid;
 }
 
+/* closid_allocated - test if provided closid is in use */
+bool closid_allocated(unsigned int closid)
+{
+	return (closid_free_map & (1 << closid)) == 0;
+}
+
 /* set uid and gid of rdtgroup dirs and files to that of the creator */
 int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
 {
-- 
2.13.6
