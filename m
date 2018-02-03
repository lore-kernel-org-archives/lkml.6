Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeBCAuK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:50:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:17233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753156AbeBCAt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:49:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15086259"
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
Subject: [PATCH v7 3/5] iommu/vt-d: Add debugfs support to show register contents
Date: Fri,  2 Feb 2018 16:49:59 -0800
Message-Id: <1517619001-148586-4-git-send-email-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Debugfs extension to dump all the register contents for each IOMMU
device to the user space via debugfs.

Example:
root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/iommu_regset
DMAR: dmar0: Register Base Address fed90000
Name            Offset          Contents
VER             0x00            0x0000000000000010
CAP             0x08            0x01c0000c40660462
ECAP            0x10            0x0000000000f0101a
GCMD            0x18            0x0000000000000000
GSTS            0x1c            0x00000000c7000000
RTADDR          0x20            0x00000004071d3800
CCMD            0x28            0x0800000000000000
FSTS            0x34            0x0000000000000000
FECTL           0x38            0x0000000000000000
FEDATA          0x3c            0xfee0100400004021

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Co-Developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v7: Use macro for register set definitions
    Fix compiler warning for readq with 32bit architecture
    Remove leading '\n'

v6: No change

v5: No change

v4: Fix checkpatch.pl warnings
    Remove error reporting for debugfs_create_file function
    Remove redundant IOMMU null check under for_each_active_iommu

v3: Use a macro for seq file operations 
    Change the intel_iommu_regset file name to iommu_regset
    Add information for MTRR registers

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 84 +++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h       |  2 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 8253503..38651ad 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -38,6 +38,49 @@ static const struct file_operations __name ## _fops =			\
 	.owner		= THIS_MODULE,					\
 }
 
+struct iommu_regset {
+	int offset;
+	const char *regs;
+};
+
+#define IOMMU_REGSET_ENTRY(_reg_)					\
+	{ DMAR_##_reg_##_REG, __stringify(_reg_) }
+static const struct iommu_regset iommu_regs[] = {
+	IOMMU_REGSET_ENTRY(VER),
+	IOMMU_REGSET_ENTRY(CAP),
+	IOMMU_REGSET_ENTRY(ECAP),
+	IOMMU_REGSET_ENTRY(GCMD),
+	IOMMU_REGSET_ENTRY(GSTS),
+	IOMMU_REGSET_ENTRY(RTADDR),
+	IOMMU_REGSET_ENTRY(CCMD),
+	IOMMU_REGSET_ENTRY(FSTS),
+	IOMMU_REGSET_ENTRY(FECTL),
+	IOMMU_REGSET_ENTRY(FEDATA),
+	IOMMU_REGSET_ENTRY(FEADDR),
+	IOMMU_REGSET_ENTRY(FEUADDR),
+	IOMMU_REGSET_ENTRY(AFLOG),
+	IOMMU_REGSET_ENTRY(PMEN),
+	IOMMU_REGSET_ENTRY(PLMBASE),
+	IOMMU_REGSET_ENTRY(PLMLIMIT),
+	IOMMU_REGSET_ENTRY(PHMBASE),
+	IOMMU_REGSET_ENTRY(PHMLIMIT),
+	IOMMU_REGSET_ENTRY(IQH),
+	IOMMU_REGSET_ENTRY(IQT),
+	IOMMU_REGSET_ENTRY(IQA),
+	IOMMU_REGSET_ENTRY(ICS),
+	IOMMU_REGSET_ENTRY(IRTA),
+	IOMMU_REGSET_ENTRY(PQH),
+	IOMMU_REGSET_ENTRY(PQT),
+	IOMMU_REGSET_ENTRY(PQA),
+	IOMMU_REGSET_ENTRY(PRS),
+	IOMMU_REGSET_ENTRY(PECTL),
+	IOMMU_REGSET_ENTRY(PEDATA),
+	IOMMU_REGSET_ENTRY(PEADDR),
+	IOMMU_REGSET_ENTRY(PEUADDR),
+	IOMMU_REGSET_ENTRY(MTRRCAP),
+	IOMMU_REGSET_ENTRY(MTRRDEF)
+};
+
 static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 			       int bus, bool ext)
 {
@@ -116,6 +159,45 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(dmar_translation_struct);
 
+static int iommu_regset_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	unsigned long long base;
+	int i, ret = 0;
+	u64 value;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!drhd->reg_base_addr) {
+			seq_puts(m, "IOMMU: Invalid base address\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		base = drhd->reg_base_addr;
+		seq_printf(m, "DMAR: %s: Register Base Address %llx\n",
+			   iommu->name, base);
+		seq_puts(m, "Name\t\t\tOffset\t\tContents\n");
+		/*
+		 * Publish the contents of the 64-bit hardware registers
+		 * by adding the offset to the pointer (virtual address).
+		 */
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs); i++) {
+			value = dmar_readq(iommu->reg + iommu_regs[i].offset);
+			seq_printf(m, "%-8s\t\t0x%02x\t\t0x%016llx\n",
+				   iommu_regs[i].regs, iommu_regs[i].offset,
+				   value);
+		}
+		seq_putc(m, '\n');
+	}
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_regset);
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -126,4 +208,6 @@ void __init intel_iommu_debugfs_init(void)
 
 	debugfs_create_file("dmar_translation_struct", 0444, iommu_debug_root,
 			    NULL, &dmar_translation_struct_fops);
+	debugfs_create_file("iommu_regset", 0444, iommu_debug_root, NULL,
+			    &iommu_regset_fops);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8968afa..1044a14 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -71,6 +71,8 @@
 #define	DMAR_PEDATA_REG	0xe4	/* Page request event interrupt data register */
 #define	DMAR_PEADDR_REG	0xe8	/* Page request event interrupt addr register */
 #define	DMAR_PEUADDR_REG 0xec	/* Page request event Upper address register */
+#define	DMAR_MTRRCAP_REG 0x100	/* Memory type range register capability register */
+#define	DMAR_MTRRDEF_REG 0x108	/* Memory type range register default type register */
 
 #define OFFSET_STRIDE		(9)
 
-- 
2.7.4
