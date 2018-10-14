Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C261C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F502077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F502077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeJNXie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:38:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37581 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727999AbeJNXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:38:34 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMA-0004io-Ml; Sun, 14 Oct 2018 16:31:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Ft-7Y; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Michael Neuling" <mikey@neuling.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.792808895@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 087/366] powerpc/eeh: Fix race with driver un/bind
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit f0295e047fcf52ccb42561fb7de6942f5201b676 upstream.

The current EEH callbacks can race with a driver unbind. This can
result in a backtraces like this:

  EEH: Frozen PHB#0-PE#1fc detected
  EEH: PE location: S000009, PHB location: N/A
  CPU: 2 PID: 2312 Comm: kworker/u258:3 Not tainted 4.15.6-openpower1 #2
  Workqueue: nvme-wq nvme_reset_work [nvme]
  Call Trace:
    dump_stack+0x9c/0xd0 (unreliable)
    eeh_dev_check_failure+0x420/0x470
    eeh_check_failure+0xa0/0xa4
    nvme_reset_work+0x138/0x1414 [nvme]
    process_one_work+0x1ec/0x328
    worker_thread+0x2e4/0x3a8
    kthread+0x14c/0x154
    ret_from_kernel_thread+0x5c/0xc8
  nvme nvme1: Removing after probe failure status: -19
  <snip>
  cpu 0x23: Vector: 300 (Data Access) at [c000000ff50f3800]
      pc: c0080000089a0eb0: nvme_error_detected+0x4c/0x90 [nvme]
      lr: c000000000026564: eeh_report_error+0xe0/0x110
      sp: c000000ff50f3a80
     msr: 9000000000009033
     dar: 400
   dsisr: 40000000
    current = 0xc000000ff507c000
    paca    = 0xc00000000fdc9d80   softe: 0        irq_happened: 0x01
      pid   = 782, comm = eehd
  Linux version 4.15.6-openpower1 (smc@smc-desktop) (gcc version 6.4.0 (Buildroot 2017.11.2-00008-g4b6188e)) #2 SM                                             P Tue Feb 27 12:33:27 PST 2018
  enter ? for help
    eeh_report_error+0xe0/0x110
    eeh_pe_dev_traverse+0xc0/0xdc
    eeh_handle_normal_event+0x184/0x4c4
    eeh_handle_event+0x30/0x288
    eeh_event_handler+0x124/0x170
    kthread+0x14c/0x154
    ret_from_kernel_thread+0x5c/0xc8

The first part is an EEH (on boot), the second half is the resulting
crash. nvme probe starts the nvme_reset_work() worker thread. This
worker thread starts touching the device which see a device error
(EEH) and hence queues up an event in the powerpc EEH worker
thread. nvme_reset_work() then continues and runs
nvme_remove_dead_ctrl_work() which results in unbinding the driver
from the device and hence releases all resources. At the same time,
the EEH worker thread starts doing the EEH .error_detected() driver
callback, which no longer works since the resources have been freed.

This fixes the problem in the same way the generic PCIe AER code (in
drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code hold
the device_lock() while performing the driver EEH callbacks and
associated code. This ensures either the callbacks are no longer
register, or if they are registered the driver will not be removed
from underneath us.

This has been broken forever. The EEH call backs were first introduced
in 2005 (in 77bd7415610) but it's not clear if a lock was needed back
then.

Fixes: 77bd74156101 ("[PATCH] powerpc: PCI Error Recovery: PPC64 core recovery routines")
Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -198,18 +198,18 @@ static void *eeh_report_error(void *data
 
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_frozen;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
@@ -217,7 +217,10 @@ static void *eeh_report_error(void *data
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -240,15 +243,14 @@ static void *eeh_report_mmio_enabled(voi
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
 
+	device_lock(&dev->dev);
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->mmio_enabled ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out;
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
@@ -256,7 +258,10 @@ static void *eeh_report_mmio_enabled(voi
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -279,19 +284,19 @@ static void *eeh_report_reset(void *data
 
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out;
 
 	rc = driver->err_handler->slot_reset(dev);
 	if ((*res == PCI_ERS_RESULT_NONE) ||
@@ -299,7 +304,10 @@ static void *eeh_report_reset(void *data
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -320,10 +328,12 @@ static void *eeh_report_resume(void *dat
 
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_enable_irq(dev);
 
@@ -331,13 +341,15 @@ static void *eeh_report_resume(void *dat
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER)) {
 		edev->mode &= ~EEH_DEV_NO_HANDLER;
-		eeh_pcid_put(dev);
-		return NULL;
+		goto out;
 	}
 
 	driver->err_handler->resume(dev);
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -357,22 +369,25 @@ static void *eeh_report_failure(void *da
 
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_perm_failure;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 

