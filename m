Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeBCAt5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:49:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:17237 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753126AbeBCAt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:49:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15086262"
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
Subject: [PATCH v7 4/5] iommu/vt-d: Add debugfs support to show Pasid table contents
Date: Fri,  2 Feb 2018 16:50:00 -0800
Message-Id: <1517619001-148586-5-git-send-email-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Debugfs extension to dump the internals such as pasid table entries for
each IOMMU to the userspace.

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
Pasid Table Address: 00000000746cb0af
Pasid Table Entries for domain 0:
[Entry]         Contents
[0]             12c409801

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Co-Developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

v7: Improve code indentation and formatting

v6: No change

v5: No change

v4: Remove the unused function parameter
    Fix checkpatch.pl warnings

v3: No change

v2: Fix seq_printf formatting

 drivers/iommu/intel-iommu-debug.c | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/intel-svm.c         |  8 --------
 include/linux/intel-svm.h         |  8 ++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
index 38651ad..a9a99aa 100644
--- a/drivers/iommu/intel-iommu-debug.c
+++ b/drivers/iommu/intel-iommu-debug.c
@@ -81,6 +81,36 @@ static const struct iommu_regset iommu_regs[] = {
 	IOMMU_REGSET_ENTRY(MTRRDEF)
 };
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static void pasid_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu)
+{
+	int pasid_size = 0, i;
+
+	if (!ecap_pasid(iommu->ecap))
+		return;
+
+	pasid_size = intel_iommu_get_pts(iommu);
+	seq_printf(m, "Pasid Table Address: %p\n", iommu->pasid_table);
+
+	if (!iommu->pasid_table)
+		return;
+
+	seq_printf(m, "Pasid Table Entries for domain %d:\n", iommu->segment);
+	seq_puts(m, "[Entry]\t\tContents\n");
+
+	/* Publish the pasid table entries here */
+	for (i = 0; i < pasid_size; i++) {
+		if (!iommu->pasid_table[i].val)
+			continue;
+
+		seq_printf(m, "[%d]\t\t%04llx\n", i, iommu->pasid_table[i].val);
+	}
+}
+#else /* CONFIG_INTEL_IOMMU_SVM */
+static inline void
+pasid_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu) {}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
+
 static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 			       int bus, bool ext)
 {
@@ -116,6 +146,7 @@ static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
 			   iommu->segment, bus, PCI_SLOT(ctx), PCI_FUNC(ctx),
 			   context[1].lo, context[1].hi);
 	}
+	pasid_tbl_entry_show(m, iommu);
 out:
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index ed1cf7c..c646724 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -28,14 +28,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-struct pasid_entry {
-	u64 val;
-};
-
-struct pasid_state_entry {
-	u64 val;
-};
-
 int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 {
 	struct page *pages;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 733eaf9..a8abad6 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -18,6 +18,14 @@
 
 struct device;
 
+struct pasid_entry {
+	u64 val;
+};
+
+struct pasid_state_entry {
+	u64 val;
+};
+
 struct svm_dev_ops {
 	void (*fault_cb)(struct device *dev, int pasid, u64 address,
 			 u32 private, int rwxp, int response);
-- 
2.7.4
