Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CBC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC06023FAA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AX3vlk/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06023FAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933678AbeGFPwq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:52:46 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:40291 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933495AbeGFPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:51:41 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4A9E710C11D5;
        Fri,  6 Jul 2018 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530892301; bh=qNehnQ1zo2UCvpAT9/WtBqkk9wEmjYzmMvXcJNoKN48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AX3vlk/oktJ6PerD4htyayAY2r7uH2sfvU8vIFg/xAa2nVg+muOv6Gb/N7dz5E+6t
         vly1hOed5WE42SPZ3B40goX0YbX0gZR5tuYkm31Sx647uOMAkscIE4X6m8oB5D+lG4
         pekTFV0HFXHkHCyKL9N/xZCF0M6R38MuVaBUQ1uZx7ArS83nbC5qWsS0sfLJlhkIwa
         QN4G9TEVhWY3fGBGiT2vsM3wc0fbEZuQZK8FgAzduupUnvXszZw6PZFUxBNgztUF6a
         0BkZJjH91cfB3cG9xDo+fauEhUBL1xzUpOTBi7iGSgRD8XcwZoBUTICeWNEf+iBbXd
         ncfCjoIpUYGnQ==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id D380740D1;
        Fri,  6 Jul 2018 08:51:40 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 44C073D259;
        Fri,  6 Jul 2018 16:51:39 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v8 09/11] pci_endpoint_test: Add 2 ioctl commands
Date:   Fri,  6 Jul 2018 16:51:32 +0100
Message-Id: <93f542ee1ec24d3a24150d8909074614536d6ce9.1530891871.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSI-X support and update driver documentation accordingly.

Add 2 new IOCTL commands:
 - Allow to reconfigure driver IRQ type in runtime.
 - Allow to retrieve current driver IRQ type configured.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Nothing changed, just to follow the patch set version.
Change v5->v6:
 - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
from patch #10 to here.
 - Increased ioctl parameters range associated to
drivers/misc/pci_endpoint_test.c driver.
Change v6->v7:
 - irq_type variable update just before returning the function.
Change v7->v8:
 - Re-sending the patch series.

 Documentation/ioctl/ioctl-number.txt             |   2 +-
 Documentation/misc-devices/pci-endpoint-test.txt |   3 +
 drivers/misc/pci_endpoint_test.c                 | 175 +++++++++++++++++------
 include/uapi/linux/pcitest.h                     |   2 +
 4 files changed, 135 insertions(+), 47 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 65259d4..c15c4f3 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
 'P'	all	linux/soundcard.h	conflict!
 'P'	60-6F	sound/sscape_ioctl.h	conflict!
 'P'	00-0F	drivers/usb/class/usblp.c	conflict!
-'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
+'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
 'Q'	all	linux/soundcard.h
 'R'	00-1F	linux/random.h		conflict!
 'R'	01	linux/rfkill.h		conflict!
diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
index fdfa0f6..58ccca4 100644
--- a/Documentation/misc-devices/pci-endpoint-test.txt
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -28,6 +28,9 @@ ioctl
 	      to be tested should be passed as argument.
  PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
 	      to be tested should be passed as argument.
+ PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
+	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
+ PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
  PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
 		as argument.
  PCITEST_READ: Perform read tests. The size of the buffer should be passed
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f4fef10..97082e3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
+{
+	int i;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	for (i = 0; i < test->num_irqs; i++)
+		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
+
+	test->num_irqs = 0;
+}
+
+static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test)
+{
+	int irq = -1;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	bool res = true;
+
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
+		irq = 0;
+		break;
+	case IRQ_TYPE_MSI:
+		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI interrupts\n");
+		break;
+	case IRQ_TYPE_MSIX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI-X interrupts\n");
+		break;
+	default:
+		dev_err(dev, "Invalid IRQ type selected\n");
+	}
+
+	if (irq < 0) {
+		irq = 0;
+		res = false;
+	}
+	test->num_irqs = irq;
+
+	return res;
+}
+
+static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+
+	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
+}
+
+static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
+{
+	int i;
+	int err;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
+			       IRQF_SHARED, DRV_MODULE_NAME, test);
+	if (err) {
+		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
+		return false;
+	}
+
+	for (i = 1; i < test->num_irqs; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+				       pci_endpoint_test_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, test);
+		if (err)
+			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
+				pci_irq_vector(pdev, i),
+				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
+	}
+
+	return true;
+}
+
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
@@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
+static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
+				      int req_irq_type)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	if (irq_type == req_irq_type)
+		return true;
+
+	pci_endpoint_test_free_irq_vectors(test);
+	pci_endpoint_test_release_irq(test);
+
+	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
+		pci_endpoint_test_release_irq(test);
+		return false;
+	}
+
+	if (!pci_endpoint_test_request_irq(test)) {
+		pci_endpoint_test_release_irq(test);
+		return false;
+	}
+
+	irq_type = req_irq_type;
+
+	return true;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -471,6 +584,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_COPY:
 		ret = pci_endpoint_test_copy(test, arg);
 		break;
+	case PCITEST_SET_IRQTYPE:
+		ret = pci_endpoint_test_set_irq(test, arg);
+		break;
+	case PCITEST_GET_IRQTYPE:
+		ret = irq_type;
+		break;
 	}
 
 ret:
@@ -486,9 +605,7 @@ static const struct file_operations pci_endpoint_test_fops = {
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
-	int i;
 	int err;
-	int irq = 0;
 	int id;
 	char name[20];
 	enum pci_barno bar;
@@ -537,41 +654,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	switch (irq_type) {
-	case IRQ_TYPE_LEGACY:
-		break;
-	case IRQ_TYPE_MSI:
-		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
-		if (irq < 0)
-			dev_err(dev, "Failed to get MSI interrupts\n");
-		test->num_irqs = irq;
-		break;
-	case IRQ_TYPE_MSIX:
-		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
-		if (irq < 0)
-			dev_err(dev, "Failed to get MSI-X interrupts\n");
-		test->num_irqs = irq;
-		break;
-	default:
-		dev_err(dev, "Invalid IRQ type selected\n");
-	}
+	if (!pci_endpoint_test_alloc_irq_vectors(test))
+		goto err_disable_irq;
 
-	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
-			       IRQF_SHARED, DRV_MODULE_NAME, test);
-	if (err) {
-		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
-		goto err_disable_msi;
-	}
-
-	for (i = 1; i < irq; i++) {
-		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
-				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, DRV_MODULE_NAME, test);
-		if (err)
-			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
-				pci_irq_vector(pdev, i),
-				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
-	}
+	if (!pci_endpoint_test_request_irq(test))
+		goto err_disable_irq;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
@@ -631,12 +718,10 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	for (i = 0; i < irq; i++)
-		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
+	pci_endpoint_test_free_irq_vectors(test);
 
-err_disable_msi:
-	pci_disable_msi(pdev);
-	pci_disable_msix(pdev);
+err_disable_irq:
+	pci_endpoint_test_release_irq(test);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -648,7 +733,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
 {
 	int id;
-	int i;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &test->miscdev;
@@ -665,10 +749,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
-	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
-	pci_disable_msi(pdev);
-	pci_disable_msix(pdev);
+	pci_endpoint_test_free_irq_vectors(test);
+
+	pci_endpoint_test_release_irq(test);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d746fb1..cbf422e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -17,5 +17,7 @@
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
 #define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
+#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
+#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 
 #endif /* __UAPI_LINUX_PCITEST_H */
-- 
2.7.4


