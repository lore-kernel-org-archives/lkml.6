Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeBCAuR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:50:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:17239 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753165AbeBCAtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:49:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15086269"
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
Subject: [PATCH v7 5/5] iommu/vt-d: Add debugfs support for Interrupt remapping
Date: Fri,  2 Feb 2018 16:50:01 -0800
Message-Id: <1517619001-148586-6-git-send-email-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs extension for Intel IOMMU to dump Interrupt remapping table
entries for Interrupt remapping and Interrupt posting.

The file /sys/kernel/debug/intel_iommu/ir_translation_struct provides
detailed information, such as Index, Source Id, Destination Id, Vector
and the IRTE values for entries with the present bit set, in the format
shown.

Remapped Interrupt supported on IOMMU: dmar7
 IR table address:85e500000
 Index  SrcID DstID    Vct IRTE_high            IRTE_low
 1      f0f8  00000100 30  000000000004f0f8     000001000030000d
 7      f0f8  00000400 22  000000000004f0f8     000004000022000d

Posted Interrupt supported on IOMMU: dmar5
 IR table address:85ec00000
 Index  SrcID PDA_high PDA_low  Vct IRTE_high           IRTE_low
 4      4300  0000000f ff765980 41  0000000f00044300    ff76598000418001
 5      4300  0000000f ff765980 51  0000000f00044300    ff76598000518001

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Co-Developed-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

v7: Print the IR table physical base address
    Simplify IR table formatting

v6: Change a couple of seq_puts to seq_putc

v5: Fix seq_puts formatting and remove leading '\n's

v4: Remove the unused function parameter
    Fix checkpatch.pl warnings
    Remove error reporting for debugfs_create_file function
    Remove redundant IOMMU null check under for_each_active_iommu

v3: Use a macro for seq file operations 
    Change the intel_iommu_interrupt_remap file name to ir_translation_struct

v2: Handle the case when IR is not enabled. Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index a9a99aa..b66a073 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -229,6 +229,96 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_regset);
 
+#ifdef CONFIG_IRQ_REMAP
+static void ir_tbl_remap_entry_show(struct seq_file *m,
+				    struct intel_iommu *iommu)
+{
+	struct irte *ri_entry;
+	int idx;
+
+	seq_puts(m, " Index  SrcID DstID    Vct IRTE_high\t\tIRTE_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		ri_entry = &iommu->ir_table->base[idx];
+		if (!ri_entry->present || ri_entry->p_pst)
+			continue;
+
+		seq_printf(m, " %d\t%04x  %08x %02x  %016llx\t%016llx\n", idx,
+			   ri_entry->sid, ri_entry->dest_id, ri_entry->vector,
+			   ri_entry->high, ri_entry->low);
+	}
+}
+
+static void ir_tbl_posted_entry_show(struct seq_file *m,
+				     struct intel_iommu *iommu)
+{
+	struct irte *pi_entry;
+	int idx;
+
+	seq_puts(m, " Index  SrcID PDA_high PDA_low  Vct IRTE_high\t\tIRTE_low\n");
+
+	for (idx = 0; idx < INTR_REMAP_TABLE_ENTRIES; idx++) {
+		pi_entry = &iommu->ir_table->base[idx];
+		if (!pi_entry->present || !pi_entry->p_pst)
+			continue;
+
+		seq_printf(m, " %d\t%04x  %08x %08x %02x  %016llx\t%016llx\n",
+			   idx, pi_entry->sid, pi_entry->pda_h,
+			   pi_entry->pda_l << 6, pi_entry->vector,
+			   pi_entry->high, pi_entry->low);
+	}
+}
+
+/*
+ * For active IOMMUs go through the Interrupt remapping
+ * table and print valid entries in a table format for
+ * Remapped and Posted Interrupts.
+ */
+static int ir_translation_struct_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	u64 irta;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!ecap_ir_support(iommu->ecap))
+			continue;
+
+		irta = dmar_readq(iommu->reg + DMAR_IRTA_REG) & VTD_PAGE_MASK;
+		seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\n"
+			      " IR table address:%llx\n", iommu->name, irta);
+
+		if (iommu->ir_table && irta)
+			ir_tbl_remap_entry_show(m, iommu);
+		else
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "****\n\n");
+
+	for_each_active_iommu(iommu, drhd) {
+		if (!cap_pi_support(iommu->cap))
+			continue;
+
+		irta = dmar_readq(iommu->reg + DMAR_IRTA_REG) & VTD_PAGE_MASK;
+		seq_printf(m, "Posted Interrupt supported on IOMMU: %s\n"
+			      " IR table address:%llx\n", iommu->name, irta);
+
+		if (iommu->ir_table && irta)
+			ir_tbl_posted_entry_show(m, iommu);
+		else
+			seq_puts(m, "Interrupt Remapping is not enabled\n");
+		seq_putc(m, '\n');
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
+#endif
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *iommu_debug_root;
@@ -241,4 +331,8 @@ void __init intel_iommu_debugfs_init(void)
 			    NULL, &dmar_translation_struct_fops);
 	debugfs_create_file("iommu_regset", 0444, iommu_debug_root, NULL,
 			    &iommu_regset_fops);
+#ifdef CONFIG_IRQ_REMAP
+	debugfs_create_file("ir_translation_struct", 0444, iommu_debug_root,
+			    NULL, &ir_translation_struct_fops);
+#endif
 }
-- 
2.7.4
