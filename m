Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DBC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E69420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E69420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeILFMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:12:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:25689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbeILFML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:12:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72213126"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 17:10:09 -0700
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
Subject: [PATCH v8 3/6] iommu/vt-d: Enable base Intel IOMMU debugfs support
Date:   Tue, 11 Sep 2018 17:11:38 -0700
Message-Id: <20180912001141.64025-4-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new config option CONFIG_INTEL_IOMMU_DEBUGFS and do the base
enabling for Intel IOMMU debugfs.

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

v8: Move to the common iommu debugfs directory
    Simplify and split the patches differently
    Change filename to intel-iommu-debugfs.c

 drivers/iommu/Kconfig               | 13 +++++++++++++
 drivers/iommu/Makefile              |  1 +
 drivers/iommu/intel-iommu-debugfs.c | 20 ++++++++++++++++++++
 drivers/iommu/intel-iommu.c         |  1 +
 include/linux/intel-iommu.h         |  6 ++++++
 5 files changed, 41 insertions(+)
 create mode 100644 drivers/iommu/intel-iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c60395b7470f..51ba19c8847b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -186,6 +186,19 @@ config INTEL_IOMMU
 	  and include PCI device scope covered by these DMA
 	  remapping devices.
 
+config INTEL_IOMMU_DEBUGFS
+	bool "Export Intel IOMMU internals in Debugfs"
+	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+	help
+	  !!!WARNING!!!
+
+	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!!
+
+	  Expose Intel IOMMU internals in Debugfs.
+
+	  This option is -NOT- intended for production environments, and should
+	  only be enabled for debugging Intel IOMMU.
+
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ab5eba6edf82..a158a68c8ea8 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
+obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
new file mode 100644
index 000000000000..33e0a6c12d92
--- /dev/null
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright © 2018 Intel Corporation.
+ *
+ * Authors: Gayatri Kammela <gayatri.kammela@intel.com>
+ *	    Sohil Mehta <sohil.mehta@intel.com>
+ *	    Jacob Pan <jacob.jun.pan@linux.intel.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/dmar.h>
+#include <linux/intel-iommu.h>
+#include <linux/pci.h>
+
+#include <asm/irq_remapping.h>
+
+void __init intel_iommu_debugfs_init(void)
+{
+	debugfs_create_dir("intel", iommu_debugfs_dir);
+}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b5868c757995..b9cf7c8c1616 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4837,6 +4837,7 @@ int __init intel_iommu_init(void)
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
 	intel_iommu_enabled = 1;
+	intel_iommu_debugfs_init();
 
 	return 0;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3bdb9aa198af..b0ae25837361 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -621,6 +621,12 @@ extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
+#ifdef CONFIG_INTEL_IOMMU_DEBUGFS
+void intel_iommu_debugfs_init(void);
+#else
+static inline void intel_iommu_debugfs_init(void) {}
+#endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
+
 extern const struct attribute_group *intel_iommu_groups[];
 bool context_present(struct context_entry *context);
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
-- 
2.18.0

