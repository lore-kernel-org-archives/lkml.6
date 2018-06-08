Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u8yoI5nhGlvZMgAAmS7hNA
	; Fri, 08 Jun 2018 20:05:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0F93A6089E; Fri,  8 Jun 2018 20:05:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9duoL2g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 75F90601D2;
	Fri,  8 Jun 2018 20:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75F90601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeFHUFq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752729AbeFHUFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:42 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0F920874;
        Fri,  8 Jun 2018 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488342;
        bh=yQUpVdvD2XXsiyHcnuUJLiJvGI24rcsU8zNG1Ffmgt4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D9duoL2gnqPA9B33VNAl41ap9JAEc6ddi515OKgA5seeu8QRKkns17r4pXD2FhQdM
         ot+15Vt+Ew/FuPCejcsNR4v15DWjb5nZcyLb1352H8sK3vmSFefSul3+RqHAafMPnY
         Blr4PMsQlZ3+uk++l6NOfKyZ0jCHh4GJ4TBsnuiQ=
Subject: [PATCH v1 09/13] PCI/AER: Move aer_irq() declaration to portdrv.h
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:41 -0500
Message-ID: <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

The aer_irq() declaration is the only thing needed by aer_inject.c.  Move
it to portdrv.h so we eventually get rid of aerdrv.h completely.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    3 ++-
 drivers/pci/pcie/aer/aerdrv.h     |    2 --
 drivers/pci/pcie/portdrv.h        |    4 ++++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index a49090935303..6c5fda96778a 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -21,7 +21,8 @@
 #include <linux/uaccess.h>
 #include <linux/stddef.h>
 #include <linux/device.h>
-#include "aerdrv.h"
+
+#include "../portdrv.h"
 
 /* Override the existing corrected and uncorrected error masks */
 static bool aer_mask_override;
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index b0c4aaa79d9c..9867950635df 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -76,6 +76,4 @@ struct aer_rpc {
 					 */
 };
 
-irqreturn_t aer_irq(int irq, void *context);
-
 #endif /* _AERDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 6a261dc7cd4c..6ffc797a0dc1 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -121,6 +121,10 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 }
 #endif
 
+#ifdef CONFIG_PCIEAER
+irqreturn_t aer_irq(int irq, void *context);
+#endif
+
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
