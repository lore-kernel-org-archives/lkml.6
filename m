Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeCOQkm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeCOQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:40:40 -0400
Subject: [PATCH] vfio/pci: Quiet broken INTx whining when INTx is
 unsupported by device
From: Alex Williamson <alex.williamson@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, aik@ozlabs.ru,
        alex.williamson@redhat.com, leedom@chelsio.com, ganeshgr@chelsio.com,
        arjun@chelsio.com, indranil@chelsio.com, nirranjan@chelsio.com
Date: Thu, 15 Mar 2018 10:40:35 -0600
Message-ID: <20180315163956.30579.92502.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of commit 2170dd04316e ("vfio-pci: Mask INTx if a device is
not capabable of enabling it") was to disallow the user from seeing
that the device supports INTx if the platform is incapable of enabling
it.  The detection of this case however incorrectly includes devices
which natively do not support INTx, such as SR-IOV VFs.  We don't need
the nointx handling code for such devices, nor do we want to issue a
broken INTx masking warning.  Check whether the device supports INTx
before enabling nointx.

Reported-by: Arjun Vynipadath <arjun@chelsio.com>
Fixes: 2170dd04316e ("vfio-pci: Mask INTx if a device is not capabable of enabling it")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index ad18ed266dc0..f2ca24644a2c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -192,6 +192,8 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev);
  */
 static bool vfio_pci_nointx(struct pci_dev *pdev)
 {
+	u8 pin;
+
 	switch (pdev->vendor) {
 	case PCI_VENDOR_ID_INTEL:
 		switch (pdev->device) {
@@ -207,7 +209,18 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
 		}
 	}
 
-	if (!pdev->irq)
+	pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+
+	/*
+	 * If the device supports INTx, but it cannot be enabled, invoke
+	 * nointx to mask the pin value and INTx IRQ_INFO to the user.
+	 *
+	 * NB. Generally nointx depends on at least being able to prevent the
+	 * device from generating INTx, so ideally we might check if INTx
+	 * masking is supported, but perhaps we can interpret lack of an irq
+	 * as lack of routing and presume the INTx line is unwired.
+	 */
+	if (pin && !pdev->irq)
 		return true;
 
 	return false;
