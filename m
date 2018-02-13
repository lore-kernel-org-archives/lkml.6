Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966309AbeBMXyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:54:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:53392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966125AbeBMXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822302"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 03/22] x86/intel_rdt: Introduce hooks to create pseudo-locking files
Date: Tue, 13 Feb 2018 07:46:47 -0800
Message-Id: <1c827e6bb424e94f7ddbf7bf323c4fc4e93ee6af.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We create a new file to host pseudo-locking specific code. The first of
this code are the functions that create the initial pseudo_lock
directory with its first file, "avail", starting by reporting zero. This
will be expanded in future commits.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/Makefile                |   3 +-
 arch/x86/kernel/cpu/intel_rdt.h             |   2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 105 ++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 570e8bb1f386..53022c2413e0 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,7 +35,8 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 
-obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o intel_rdt_ctrlmondata.o
+obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
+obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
 
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index df4db23ddd74..146a8090bb58 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -454,5 +454,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+int rdt_pseudo_lock_fs_init(struct kernfs_node *root);
+void rdt_pseudo_lock_fs_remove(void);
 
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
new file mode 100644
index 000000000000..ad8b97747024
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -0,0 +1,105 @@
+/*
+ * Resource Director Technology(RDT)
+ *
+ * Pseudo-locking support built on top of Cache Allocation Technology (CAT)
+ *
+ * Copyright (C) 2017 Intel Corporation
+ *
+ * Author: Reinette Chatre <reinette.chatre@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernfs.h>
+#include <linux/seq_file.h>
+#include <linux/stat.h>
+#include "intel_rdt.h"
+
+static struct kernfs_node *pseudo_lock_kn;
+
+static int pseudo_lock_avail_show(struct seq_file *sf, void *v)
+{
+	seq_puts(sf, "0\n");
+	return 0;
+}
+
+static struct kernfs_ops pseudo_lock_avail_ops = {
+	.seq_show		= pseudo_lock_avail_show,
+};
+
+/**
+ * rdt_pseudo_lock_fs_init - Create and initialize pseudo-locking files
+ * @root: location in kernfs where directory and files should be created
+ *
+ * The pseudo_lock directory and the pseudo-locking related files and
+ * directories will live within the structure created here.
+ *
+ * LOCKING:
+ * rdtgroup_mutex is expected to be held when called
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure
+ */
+int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
+{
+	struct kernfs_node *kn;
+	int ret;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	pseudo_lock_kn = kernfs_create_dir(root, "pseudo_lock",
+					   root->mode, NULL);
+	if (IS_ERR(pseudo_lock_kn))
+		return PTR_ERR(pseudo_lock_kn);
+
+	kn = __kernfs_create_file(pseudo_lock_kn, "avail", 0444,
+				  0, &pseudo_lock_avail_ops,
+				  NULL, NULL, NULL);
+	if (IS_ERR(kn)) {
+		ret = PTR_ERR(kn);
+		goto error;
+	}
+
+	ret = rdtgroup_kn_set_ugid(pseudo_lock_kn);
+	if (ret)
+		goto error;
+
+	kernfs_activate(pseudo_lock_kn);
+
+	ret = 0;
+	goto out;
+
+error:
+	kernfs_remove(pseudo_lock_kn);
+	pseudo_lock_kn = NULL;
+out:
+	return ret;
+}
+
+/**
+ * rdt_pseudo_lock_fs_remove - Remove all pseudo-locking files
+ *
+ * All pseudo-locking related files and directories are removed.
+ *
+ * LOCKING:
+ * rdtgroup_mutex is expected to be held when called
+ *
+ * RETURNS:
+ * none
+ */
+void rdt_pseudo_lock_fs_remove(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	kernfs_remove(pseudo_lock_kn);
+	pseudo_lock_kn = NULL;
+}
-- 
2.13.6
