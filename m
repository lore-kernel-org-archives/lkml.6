Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756361AbeDYSUM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:20:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:41714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932210AbeDYSMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243710"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 21/39] x86/intel_rdt: Utilities to restrict/restore access to specific files
Date: Wed, 25 Apr 2018 03:09:57 -0700
Message-Id: <f53fe1d300197d268356eea23d2edaac8e95323b.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
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
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 121 ++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)
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
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
new file mode 100644
index 000000000000..a373ca3ff567
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -0,0 +1,121 @@
+/*
+ * Resource Director Technology (RDT)
+ *
+ * Pseudo-locking support built on top of Cache Allocation Technology (CAT)
+ *
+ * Copyright (C) 2018 Intel Corporation
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
