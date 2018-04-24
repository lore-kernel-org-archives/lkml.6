Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755840AbeDXHLr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:11:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58377 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751534AbeDXHLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:11:45 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <tglx@linutronix.de>, <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] irqchip/gic-v3: check kasprintf() for failures
Date: Tue, 24 Apr 2018 15:10:36 +0800
Message-ID: <20180424071036.20188-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should just return -ENOMEM here if the allocation fails,
otherwise it may cause a panic.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 3 +++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 25a98de..ef3911f 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -160,6 +160,9 @@ its_pci_msi_parse_madt(struct acpi_subtable_header *header,
 	its_entry = (struct acpi_madt_generic_translator *)header;
 	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
 			      (long)its_entry->base_address);
+	if(!node_name)
+		return -ENOMEM;
+
 	dom_handle = iort_find_domain_token(its_entry->translation_id);
 	if (!dom_handle) {
 		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 8881a05..b676fb4 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -126,6 +126,9 @@ its_pmsi_parse_madt(struct acpi_subtable_header *header,
 	its_entry = (struct acpi_madt_generic_translator *)header;
 	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
 			      (long)its_entry->base_address);
+	if(!node_name)
+		return -ENOMEM;
+
 	domain_handle = iort_find_domain_token(its_entry->translation_id);
 	if (!domain_handle) {
 		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-- 
2.7.0
