Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeEVTgO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:36:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:16707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbeEVTcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406399"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 21/38] x86/intel_rdt: Utilities to restrict/restore access to specific files
Date: Tue, 22 May 2018 04:29:09 -0700
Message-Id: <d7a017c82185e91b3968309db623e62e862121d5.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In support of Cache Pseudo-Locking we need to restrict access to
specific resctrl files to protect the state of a resource group used for
pseudo-locking from being changed in unsupported ways.

Introduce two utilities that can be used to either restrict or restore
the access to all files irrelevant to cache pseudo-locking when
pseudo-locking in progress for the resource group.

At this time introduce a new source file, intel_rdt_pseudo_lock.c, that
will contain most of the code related to cache pseudo-locking.

Temporarily mark these new functions as unused to silence compile
warnings until they are used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/Makefile                |   3 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 113 ++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a66229f51b12..071f50162727 100644
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
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
new file mode 100644
index 000000000000..dc79b3090ac5
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resource Director Technology (RDT)
+ *
+ * Pseudo-locking support built on top of Cache Allocation Technology (CAT)
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Reinette Chatre <reinette.chatre@intel.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include "intel_rdt.h"
+
+/**
+ * rdtgroup_locksetup_user_restrict - Restrict user access to group
+ * @rdtgrp: resource group needing access restricted
+ *
+ * A resource group used for cache pseudo-locking cannot have cpus or tasks
+ * assigned to it. This is communicated to the user by restricting access
+ * to all the files that can be used to make such changes.
+ *
+ * Permissions restored with rdtgroup_locksetup_user_restore()
+ *
+ * Return: 0 on success, <0 on failure. If a failure occurs during the
+ * restriction of access an attempt will be made to restore permissions but
+ * the state of the mode of these files will be uncertain when a failure
+ * occurs.
+ */
+static int __attribute__ ((unused))
+rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	ret = rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
+	if (ret)
+		return ret;
+
+	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
+	if (ret)
+		goto err_tasks;
+
+	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
+	if (ret)
+		goto err_cpus;
+
+	if (rdt_mon_capable) {
+		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
+		if (ret)
+			goto err_cpus_list;
+	}
+
+	ret = 0;
+	goto out;
+
+err_cpus_list:
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list");
+err_cpus:
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus");
+err_tasks:
+	rdtgroup_kn_mode_restore(rdtgrp, "tasks");
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_locksetup_user_restore - Restore user access to group
+ * @rdtgrp: resource group needing access restored
+ *
+ * Restore all file access previously removed using
+ * rdtgroup_locksetup_user_restrict()
+ *
+ * Return: 0 on success, <0 on failure.  If a failure occurs during the
+ * restoration of access an attempt will be made to restrict permissions
+ * again but the state of the mode of these files will be uncertain when
+ * a failure occurs.
+ */
+static int __attribute__ ((unused))
+rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "tasks");
+	if (ret)
+		return ret;
+
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus");
+	if (ret)
+		goto err_tasks;
+
+	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus_list");
+	if (ret)
+		goto err_cpus;
+
+	if (rdt_mon_capable) {
+		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups");
+		if (ret)
+			goto err_cpus_list;
+	}
+
+	ret = 0;
+	goto out;
+
+err_cpus_list:
+	rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
+err_cpus:
+	rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
+err_tasks:
+	rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
+out:
+	return ret;
+}
-- 
2.13.6
