Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30EBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A17223FFC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b8TnsnkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A17223FFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeGFN1a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:27:30 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:37435 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbeGFN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:26:32 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A237310C1AB7;
        Fri,  6 Jul 2018 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530883591; bh=ubDOCv2Zg6l+GkOjO39wB/t5YyTbjAmNF91vggFWVlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=b8TnsnkX9R7DCAuQomkVq0q0WaR7+FjQqpFllhaGjexrLf+JgV6iYuH+clLX4KxPI
         yzHJ9o/Bf7gQedMBDICD6mzea9p5e5YRVxnv6+SxSy82KGCF7dmuI2Tw4JWBT59hhg
         +80JVO03UWAyX1cQZ0QR6ghkIbPCbvfYoNDgf4BdiwyjhHvBqKt7nmI+fY5OtW4BVB
         tZpuigTke5Phyc5WH6Ul+jgDrvC4d4CiJY8KjMP2VxISzG293CGmSrsE2T1FWIb+R4
         sXtLphLn1u8O9KHOXh9HU50Fmaw+Rlhob64mtbJ+VvgFVHHADa7t/rs0lN4l3Zu26I
         IlcfYJmr4N+IA==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 38A033FB7;
        Fri,  6 Jul 2018 06:26:31 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 94BF93F794;
        Fri,  6 Jul 2018 14:26:29 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v7 06/11] pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
Date:   Fri,  6 Jul 2018 14:26:18 +0100
Message-Id: <64373bc2ed00465155585722961997fd985888eb.1530877028.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
References: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
References: <cover.1530877028.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup PCI_ENDPOINT_TEST memspace (by moving the interrupt number away
from command section).

Update documentation accordingly.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Reverted irq_num rename to msi_num.
 - Added comment about the MSI-X bit reservation for future implementation.
Change v5->v6:
 - Nothing changed, just to follow the patch set version.
Change v6->v7:
 - Updated documentation.

 Documentation/PCI/endpoint/pci-test-function.txt |  8 +--
 drivers/misc/pci_endpoint_test.c                 | 81 +++++++++++++++---------
 drivers/pci/endpoint/functions/pci-epf-test.c    | 61 ++++++++++++------
 3 files changed, 95 insertions(+), 55 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.txt
index 0c519c9..7ee2361 100644
--- a/Documentation/PCI/endpoint/pci-test-function.txt
+++ b/Documentation/PCI/endpoint/pci-test-function.txt
@@ -34,10 +34,10 @@ that the endpoint device must perform.
 Bitfield Description:
   Bit 0		: raise legacy IRQ
   Bit 1		: raise MSI IRQ
-  Bit 2 - 7	: MSI interrupt number
-  Bit 8		: read command (read data from RC buffer)
-  Bit 9		: write command (write data to RC buffer)
-  Bit 10	: copy command (copy data from one RC buffer to another
+  Bit 2		: raise MSI-X IRQ (reserved for future implementation)
+  Bit 3		: read command (read data from RC buffer)
+  Bit 4		: write command (write data to RC buffer)
+  Bit 5		: copy command (copy data from one RC buffer to another
 		  RC buffer)
 
 *) PCI_ENDPOINT_TEST_STATUS
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 7b37046..35fbfbd 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -35,38 +35,43 @@
 
 #include <uapi/linux/pcitest.h>
 
-#define DRV_MODULE_NAME			"pci-endpoint-test"
-
-#define PCI_ENDPOINT_TEST_MAGIC		0x0
-
-#define PCI_ENDPOINT_TEST_COMMAND	0x4
-#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
-#define COMMAND_RAISE_MSI_IRQ		BIT(1)
-#define MSI_NUMBER_SHIFT		2
-/* 6 bits for MSI number */
-#define COMMAND_READ                    BIT(8)
-#define COMMAND_WRITE                   BIT(9)
-#define COMMAND_COPY                    BIT(10)
-
-#define PCI_ENDPOINT_TEST_STATUS	0x8
-#define STATUS_READ_SUCCESS             BIT(0)
-#define STATUS_READ_FAIL                BIT(1)
-#define STATUS_WRITE_SUCCESS            BIT(2)
-#define STATUS_WRITE_FAIL               BIT(3)
-#define STATUS_COPY_SUCCESS             BIT(4)
-#define STATUS_COPY_FAIL                BIT(5)
-#define STATUS_IRQ_RAISED               BIT(6)
-#define STATUS_SRC_ADDR_INVALID         BIT(7)
-#define STATUS_DST_ADDR_INVALID         BIT(8)
-
-#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0xc
+#define DRV_MODULE_NAME				"pci-endpoint-test"
+
+#define IRQ_TYPE_LEGACY				0
+#define IRQ_TYPE_MSI				1
+
+#define PCI_ENDPOINT_TEST_MAGIC			0x0
+
+#define PCI_ENDPOINT_TEST_COMMAND		0x4
+#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
+#define COMMAND_RAISE_MSI_IRQ			BIT(1)
+/* BIT(2) is reserved for raising MSI-X IRQ command */
+#define COMMAND_READ				BIT(3)
+#define COMMAND_WRITE				BIT(4)
+#define COMMAND_COPY				BIT(5)
+
+#define PCI_ENDPOINT_TEST_STATUS		0x8
+#define STATUS_READ_SUCCESS			BIT(0)
+#define STATUS_READ_FAIL			BIT(1)
+#define STATUS_WRITE_SUCCESS			BIT(2)
+#define STATUS_WRITE_FAIL			BIT(3)
+#define STATUS_COPY_SUCCESS			BIT(4)
+#define STATUS_COPY_FAIL			BIT(5)
+#define STATUS_IRQ_RAISED			BIT(6)
+#define STATUS_SRC_ADDR_INVALID			BIT(7)
+#define STATUS_DST_ADDR_INVALID			BIT(8)
+
+#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
 
 #define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
 #define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
 
-#define PCI_ENDPOINT_TEST_SIZE		0x1c
-#define PCI_ENDPOINT_TEST_CHECKSUM	0x20
+#define PCI_ENDPOINT_TEST_SIZE			0x1c
+#define PCI_ENDPOINT_TEST_CHECKSUM		0x20
+
+#define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
+#define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -179,6 +184,9 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 IRQ_TYPE_LEGACY);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_RAISE_LEGACY_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
@@ -195,8 +203,10 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	u32 val;
 	struct pci_dev *pdev = test->pdev;
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 msi_num << MSI_NUMBER_SHIFT |
 				 COMMAND_RAISE_MSI_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
@@ -281,8 +291,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
 				 size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_COPY);
+				 COMMAND_COPY);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -348,8 +361,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_READ);
+				 COMMAND_READ);
 
 	wait_for_completion(&test->irq_raised);
 
@@ -403,8 +419,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
+				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 1 << MSI_NUMBER_SHIFT | COMMAND_WRITE);
+				 COMMAND_WRITE);
 
 	wait_for_completion(&test->irq_raised);
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 63ed706..eb9cd00 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -18,13 +18,15 @@
 #include <linux/pci-epf.h>
 #include <linux/pci_regs.h>
 
+#define IRQ_TYPE_LEGACY			0
+#define IRQ_TYPE_MSI			1
+
 #define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
-#define MSI_NUMBER_SHIFT		2
-#define MSI_NUMBER_MASK			(0x3f << MSI_NUMBER_SHIFT)
-#define COMMAND_READ			BIT(8)
-#define COMMAND_WRITE			BIT(9)
-#define COMMAND_COPY			BIT(10)
+/* BIT(2) is reserved for raising MSI-X IRQ command */
+#define COMMAND_READ			BIT(3)
+#define COMMAND_WRITE			BIT(4)
+#define COMMAND_COPY			BIT(5)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -56,6 +58,8 @@ struct pci_epf_test_reg {
 	u64	dst_addr;
 	u32	size;
 	u32	checksum;
+	u32	irq_type;
+	u32	irq_number;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -244,31 +248,39 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	return ret;
 }
 
-static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq)
+static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
+				   u16 irq)
 {
-	u8 msi_count;
 	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	reg->status |= STATUS_IRQ_RAISED;
-	msi_count = pci_epc_get_msi(epc, epf->func_no);
-	if (irq > msi_count || msi_count <= 0)
+
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
 		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
-	else
+		break;
+	case IRQ_TYPE_MSI:
 		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
+		break;
+	default:
+		dev_err(dev, "Failed to raise IRQ, unknown type\n");
+		break;
+	}
 }
 
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	int ret;
-	u8 irq;
-	u8 msi_count;
+	u16 count;
 	u32 command;
 	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
 						     cmd_handler.work);
 	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
@@ -280,7 +292,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	reg->command = 0;
 	reg->status = 0;
 
-	irq = (command & MSI_NUMBER_MASK) >> MSI_NUMBER_SHIFT;
+	if (reg->irq_type > IRQ_TYPE_MSI) {
+		dev_err(dev, "Failed to detect IRQ type\n");
+		goto reset_handler;
+	}
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
@@ -294,7 +309,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_WRITE_FAIL;
 		else
 			reg->status |= STATUS_WRITE_SUCCESS;
-		pci_epf_test_raise_irq(epf_test, irq);
+		pci_epf_test_raise_irq(epf_test, reg->irq_type,
+				       reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -304,7 +320,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_READ_SUCCESS;
 		else
 			reg->status |= STATUS_READ_FAIL;
-		pci_epf_test_raise_irq(epf_test, irq);
+		pci_epf_test_raise_irq(epf_test, reg->irq_type,
+				       reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -314,16 +331,18 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_COPY_SUCCESS;
 		else
 			reg->status |= STATUS_COPY_FAIL;
-		pci_epf_test_raise_irq(epf_test, irq);
+		pci_epf_test_raise_irq(epf_test, reg->irq_type,
+				       reg->irq_number);
 		goto reset_handler;
 	}
 
 	if (command & COMMAND_RAISE_MSI_IRQ) {
-		msi_count = pci_epc_get_msi(epc, epf->func_no);
-		if (irq > msi_count || msi_count <= 0)
+		count = pci_epc_get_msi(epc, epf->func_no);
+		if (reg->irq_number > count || count <= 0)
 			goto reset_handler;
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
+		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI,
+				  reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -457,8 +476,10 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return ret;
 
 	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "MSI configuration failed\n");
 		return ret;
+	}
 
 	if (!epf_test->linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
-- 
2.7.4


