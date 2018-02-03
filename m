Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeBCAtp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:49:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:17233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbeBCAtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:49:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15086255"
From: Sohil Mehta <sohil.mehta@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 2/5] iommu/vt-d: Enable debugfs support to show context internals
Date: Fri,  2 Feb 2018 16:49:58 -0800
Message-Id: <1517619001-148586-3-git-send-email-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Add a new config option CONFIG_INTEL_IOMMU_DEBUG and export Intel IOMMU
internals states, such as root and context in debugfs to the userspace.

Example of such dump in Kabylake:

root@OTC-KBLH-01:~# cat
/sys/kernel/debug/intel_iommu/dmar_translation_struct
IOMMU dmar1: Extended Root Table Address:4071d3800
Extended Root Table Entries:
Bus 0 L: 4071d7001 H: 0
Lower Context Table Entries for Bus: 0
[entry]	Device B:D.F	Low		High
[16]	0000:00:02.0	4071d6005	102
Higher Context Table Entries for Bus: 0
[16]	0000:00:02.0	0	0

IOMMU dmar0: Extended Root Table Address:4071d4800

IOMMU dmar2: Root Table Address:4071d5000
Root Table Entries:
Bus 0 L: 406d13001 H: 0
Context Table Entries for Bus: 0
[entry]	Device B:D.F	Low		High
[160]	0000:00:14.0	406d12001	102
[184]	0000:00:17.0	405756001	302
[248]	0000:00:1f.0	406d3b001	202
[251]	0000:00:1f.3	405497001	402
[254]	0000:00:1f.6	40662e001	502
Root Table Entries:
Bus 1 L: 401e03001 H: 0
Context Table Entries for Bus: 1
[entry]	Device B:D.F	Low		High
[0] 	0000:01:00.0	401e04001	602

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Co-Developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v7: Split patch 1/5 and 2/5 differently
    Update commit message and copyright year
    Fix typo in a comment
    Simplify code

v6: Change the order of includes to an alphabetical order
    Change seq_printf formatting

v5: Change to a SPDX license tag
    Fix seq_printf formatting

v4: Remove the unused function parameter
    Fix checkpatch.pl warnings
    Remove error reporting for debugfs_create_file function
    Fix unnecessary reprogramming of the context entries
    Simplify and merge the show context and extended context patch into one
    Remove redundant IOMMU null check under for_each_active_iommu

v3: Add a macro for seq file operations 
    Change the intel_iommu_ctx file name to dmar_translation_struct

v2: No change

 drivers/iommu/Kconfig             |   8 +++
 drivers/iommu/Makefile            |   1 +
 drivers/iommu/intel-iommu-debug.c | 129 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c       |   1 +
 include/linux/intel-iommu.h       |   6 ++
 5 files changed, 145 insertions(+)
 create mode 100644 drivers/iommu/intel-iommu-debug.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a2134..332648f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -152,6 +152,14 @@ config INTEL_IOMMU
 	  and include PCI device scope covered by these DMA
 	  remapping devices.
 
+config INTEL_IOMMU_DEBUG
+	bool "Export Intel IOMMU internals in Debugfs"
+	depends on INTEL_IOMMU && DEBUG_FS
+	help
+	  Debugfs support to export IOMMU context internals, register contents,
+	  PASID internals and interrupt remapping. To access this information in
+	  sysfs, say Y.
+
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb6958..fdbaf46 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
+obj-$(CONFIG_INTEL_IOMMU_DEBUG) += intel-iommu-debug.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
new file mode 100644
index 0000000..8253503
--- /dev/null
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright © 2018 Intel Corporation.
+ *
+ * Authors: Gayatri Kammela <gayatri.kammela@intel.com>
+ *          Jacob Pan <jacob.jun.pan@linux.intel.com>
+ *          Sohil Mehta <sohil.mehta@intel.com>
+ */
+
+#define pr_fmt(fmt)     "INTEL_IOMMU: " fmt
+#include <linux/debugfs.h>
+#include <linux/dmar.h>
+#include <linux/err.h>
+#include <linux/intel-iommu.h>
+#include <linux/intel-svm.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+
+#include "irq_remapping.h"
+
+#define TOTAL_BUS_NR	256	/* full bus range */
+#define DEFINE_SHOW_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+static const struct file_operations __name ## _fops =			\
+{									\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+	.owner		= THIS_MODULE,					\
+}
+
+static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
+			       int bus, bool ext)
+{
+	const char *ct = ext ? "Lower Context Table" : "Context Table";
+	struct context_entry *context;
+	unsigned long flags;
+	int ctx;
+
+	seq_printf(m, "%s Entries for Bus: %d\n", ct, bus);
+	seq_puts(m, "[entry]\tDevice B:D.F\tLow\t\tHigh\n");
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Publish either context entries or extended context entries */
+	for (ctx = 0; ctx < (ext ? 128 : 256); ctx++) {
+		context = iommu_context_addr(iommu, bus, ctx, 0);
+		if (!context)
+			goto out;
+
+		if (!context_present(context))
+			continue;
+
+		seq_printf(m, "[%d]\t%04x:%02x:%02x.%x\t%llx\t%llx\n", ctx,
+			   iommu->segment, bus, PCI_SLOT(ctx), PCI_FUNC(ctx),
+			   context[0].lo, context[0].hi);
+
+		if (!ecap_ecs(iommu->ecap))
+			continue;
+
+		seq_printf(m, "Higher Context Table Entries for Bus: %d\n",
+			   bus);
+		seq_printf(m, "[%d]\t%04x:%02x:%02x.%x\t%llx\t%llx\n", ctx,
+			   iommu->segment, bus, PCI_SLOT(ctx), PCI_FUNC(ctx),
+			   context[1].lo, context[1].hi);
+	}
+out:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+static void root_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu)
+{
+	u64 rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+	bool ext = !!(rtaddr_reg & DMA_RTADDR_RTT);
+	const char *rt = ext ? "Extended Root Table" : "Root Table";
+	int bus;
+
+	seq_printf(m, "IOMMU %s: %s Address:%llx\n", iommu->name, rt,
+		   rtaddr_reg);
+	/* Publish extended root table entries or root table entries here */
+	for (bus = 0; bus < TOTAL_BUS_NR; bus++) {
+		if (!iommu->root_entry[bus].lo)
+			continue;
+
+		seq_printf(m, "%s Entries:\n", rt);
+		seq_printf(m, "Bus %d L: %llx H: %llx\n", bus,
+			   iommu->root_entry[bus].lo,
+			   iommu->root_entry[bus].hi);
+
+		ctx_tbl_entry_show(m, iommu, bus, ext);
+	}
+}
+
+static int dmar_translation_struct_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		root_tbl_entry_show(m, iommu);
+		seq_putc(m, '\n');
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dmar_translation_struct);
+
+void __init intel_iommu_debugfs_init(void)
+{
+	struct dentry *iommu_debug_root;
+
+	iommu_debug_root = debugfs_create_dir("intel_iommu", NULL);
+	if (!iommu_debug_root)
+		return;
+
+	debugfs_create_file("dmar_translation_struct", 0444, iommu_debug_root,
+			    NULL, &dmar_translation_struct_fops);
+}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f6241f6..e23f31d3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4805,6 +4805,7 @@ int __init intel_iommu_init(void)
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
 	intel_iommu_enabled = 1;
+	intel_iommu_debugfs_init();
 
 	return 0;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 78ec85a..8968afa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -518,6 +518,12 @@ extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 extern unsigned long intel_iommu_get_pts(struct intel_iommu *iommu);
 #endif
 
+#ifdef CONFIG_INTEL_IOMMU_DEBUG
+extern void intel_iommu_debugfs_init(void);
+#else
+static inline void intel_iommu_debugfs_init(void) {}
+#endif /* CONFIG_INTEL_IOMMU_DEBUG */
+
 extern const struct attribute_group *intel_iommu_groups[];
 extern bool context_present(struct context_entry *context);
 extern struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
-- 
2.7.4
