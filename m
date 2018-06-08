Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dWniE07hGlsCLgAAmS7hNA
	; Fri, 08 Jun 2018 20:05:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 28E8E60909; Fri,  8 Jun 2018 20:05:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ0HS1Ia"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1CB2A608FC;
	Fri,  8 Jun 2018 20:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CB2A608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeFHUFj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932146AbeFHUFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:36 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE80B20874;
        Fri,  8 Jun 2018 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488336;
        bh=o7Bjuhz6mlNkxN04uXXq9urmSNLANHw+KAxxiniKvq4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VJ0HS1IacLWM5jULpW2KuuVLWJwYX3VVW5bR7GdCEThFMM/VGhwU2cu8T/fZ7m088
         /w7sfGVyIBVvagsUCfDT9RqpghXkKqxLP65Xy/SOwViovbhUKYXcQO6PGIQwPXMEyg
         stLUr3R3ADyCOOpjdY8UqW08EHZlbOjlcqeG0tMI=
Subject: [PATCH v1 08/13] PCI/AER: Move pcie_aer_get_firmware_first() to
 portdrv.h
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:35 -0500
Message-ID: <152848833510.11888.13834530632280301120.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move pcie_aer_get_firmware_first() to portdrv.h, where it can be more
easily shared between AER and DPC.  Then DPC no longer needs to include
aer/aerdrv.h.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h |   10 ----------
 drivers/pci/pcie/dpc.c        |    1 -
 drivers/pci/pcie/portdrv.h    |   11 +++++++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index f4fc71119cf2..b0c4aaa79d9c 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -78,14 +78,4 @@ struct aer_rpc {
 
 irqreturn_t aer_irq(int irq, void *context);
 
-#ifdef CONFIG_ACPI_APEI
-int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
-#else
-static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
-{
-	if (pci_dev->__aer_firmware_first_valid)
-		return pci_dev->__aer_firmware_first;
-	return 0;
-}
-#endif
 #endif /* _AERDRV_H_ */
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index d6436681c535..921ed979109d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -13,7 +13,6 @@
 
 #include "portdrv.h"
 #include "../pci.h"
-#include "aer/aerdrv.h"
 
 struct dpc_dev {
 	struct pcie_device	*dev;
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 2bb5db7b53e6..6a261dc7cd4c 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -110,6 +110,17 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
+#ifdef CONFIG_ACPI_APEI
+int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
+#else
+static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
+{
+	if (pci_dev->__aer_firmware_first_valid)
+		return pci_dev->__aer_firmware_first;
+	return 0;
+}
+#endif
+
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
