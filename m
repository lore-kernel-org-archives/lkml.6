Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDST4d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:56:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDST4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:56:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69C186081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Date: Thu, 19 Apr 2018 15:56:23 -0400
Message-Id: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infiniband adapter might be connected to a PCI hotplug slot. Performing
secondary bus reset on a hotplug slot causes PCI link up/down interrupts.

Hotplug driver removes the device from system when a link down interrupt
is observed and performs re-enumeration when link up interrupt is observed.

This conflicts with what this code is trying to do. Try secondary bus reset
only if pci_reset_slot() fails/unsupported.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 83d66e8..75f49e3 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -908,7 +908,8 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	pci_reset_bridge_secondary_bus(dev->bus->self);
+	if (pci_reset_slot(dev->slot))
+		pci_reset_bridge_secondary_bus(dev->bus->self);
 
 	return 0;
 }
-- 
2.7.4
