Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936178AbeEYOEh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:04:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936046AbeEYOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:04:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9839601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: Try to clean up resources via remove if shutdown doesn't exist
Date: Fri, 25 May 2018 10:04:23 -0400
Message-Id: <1527257063-15843-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is up to a driver to implement shutdown() callback. If shutdown()
callback is not implemented, PCI device can have pending interrupt and
even do DMA transactions while the system is going down.

If kexec is in use, this can damage the newly booting kexec kernel
or even prevent it from booting altogether. Fallback to calling the
remove() callback if shutdown() isn't implemented for a given driver.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci-driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6ace470..4ac72e3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -475,8 +475,17 @@ static void pci_device_shutdown(struct device *dev)
 
 	pm_runtime_resume(dev);
 
+	/*
+	 * Try shutdown callback if it exists, otherwise fallback to remove
+	 * callback. PCI drivers can do DMA and have pending interrupts.
+	 * Leaving the DMA and interrupts pending could damage the newly
+	 * booting kexec kernel as well as prevent it from booting altogether
+	 * if the pending interrupt is level.
+	 */
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
+	else if (drv && drv->remove)
+		drv->remove(pci_dev);
 
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
-- 
2.7.4
