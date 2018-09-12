Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B90CC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44A520882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44A520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeILFMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:12:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:25689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeILFMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:12:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72213175"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 17:10:15 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 6/6] iommu/vt-d: Add debugfs support to show context internals
Date:   Tue, 11 Sep 2018 17:11:41 -0700
Message-Id: <20180912001141.64025-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Intel IOMMU DMA remapping internal states, such as root and
context table entries in debugfs.

Example of such dump in Kabylake:
/sys/kernel/debug/iommu/intel/dmar_translation_struct

IOMMU dmar0: Root Table Address:45699c000
Root Table Entries:
 Bus: 0 H: 0 L: 45699f001
 Context Table Entries for Bus: 0
  Entry B:D.F   High    Low
  16    00:02.0 102     45699e005

IOMMU dmar1: Root Table Address:45699d000
Root Table Entries:
 Bus: 0 H: 0 L: 45644f001
 Context Table Entries for Bus: 0
  Entry B:D.F   High    Low
  160   00:14.0 102     45644e001
  184   00:17.0 302     456310001
  248   00:1f.0 202     4564bf001

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-Developed-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
    
v8: Remove extended context support since it is deprecated in the new spec
    Use iommu lock to protect context table access
    Simplify and split the patches differently

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

 drivers/iommu/intel-iommu-debugfs.c | 65 +++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 2becbd78620f..7fabf9b1c2dc 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -131,6 +131,69 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_regset);
 
+static void ctx_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu,
+			       int bus)
+{
+	struct context_entry *context;
+	int devfn;
+
+	seq_printf(m, " Context Table Entries for Bus: %d\n", bus);
+	seq_puts(m, "  Entry\tB:D.F\tHigh\tLow\n");
+
+	for (devfn = 0; devfn < 256; devfn++) {
+		context = iommu_context_addr(iommu, bus, devfn, 0);
+		if (!context)
+			return;
+
+		if (!context_present(context))
+			continue;
+
+		seq_printf(m, "  %-5d\t%02x:%02x.%x\t%-6llx\t%llx\n", devfn,
+			   bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
+			   context[0].hi, context[0].lo);
+	}
+}
+
+static void root_tbl_entry_show(struct seq_file *m, struct intel_iommu *iommu)
+{
+	unsigned long flags;
+	int bus;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	seq_printf(m, "IOMMU %s: Root Table Address:%llx\n", iommu->name,
+		   (u64)virt_to_phys(iommu->root_entry));
+	seq_puts(m, "Root Table Entries:\n");
+
+	for (bus = 0; bus < 256; bus++) {
+		if (!(iommu->root_entry[bus].lo & 1))
+			continue;
+
+		seq_printf(m, " Bus: %d H: %llx L: %llx\n", bus,
+			   iommu->root_entry[bus].hi,
+			   iommu->root_entry[bus].lo);
+
+		ctx_tbl_entry_show(m, iommu, bus);
+		seq_putc(m, '\n');
+	}
+	spin_unlock_irqrestore(&iommu->lock, flags);
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
 #ifdef CONFIG_IRQ_REMAP
 static void ir_tbl_remap_entry_show(struct seq_file *m,
 				    struct intel_iommu *iommu)
@@ -242,6 +305,8 @@ void __init intel_iommu_debugfs_init(void)
 
 	debugfs_create_file("iommu_regset", 0444, intel_iommu_debug, NULL,
 			    &iommu_regset_fops);
+	debugfs_create_file("dmar_translation_struct", 0444, intel_iommu_debug,
+			    NULL, &dmar_translation_struct_fops);
 #ifdef CONFIG_IRQ_REMAP
 	debugfs_create_file("ir_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &ir_translation_struct_fops);
-- 
2.18.0

