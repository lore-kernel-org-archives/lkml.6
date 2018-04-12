Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeDLTcT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:32:19 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:11042 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeDLTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:32:18 -0400
From: Micah Parrish <micah.parrish@hpe.com>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Kieulien.Dang@seagate.com,
        jeffrey.wang@seagate.com, keith.busch@intel.com,
        pragyansri.pathi@intel.com, micah.parrish@hpe.com
Subject: [PATCH] NVMe: Add Quirk Delay before CHK RDY for Seagate Nytro Flash Storage
Date: Thu, 12 Apr 2018 13:25:25 -0600
Message-Id: <1523561125-31945-1-git-send-email-micah.parrish@hpe.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Seagate Nytro Flash Storage nvme drive to quirk list for
NVME_QUIRK_DELAY_BEFORE_CHK_RDY, which solves a bug where the drive is
probed on hot-add before the firmare is ready, I/O errors are generated
while reading sector 0, and linux is "unable to read partition table".
This has occurred when the drive is in an NVME drive slot adjacent to an 
Intel drive.

Intel (Keith Busch and Pragyan Pathi) and Seagate (Jeffery Wang
and Kieulien Dang) agreed to add this quirk in off-list discussion.

Signed-off-by: micah.parrish@hpe.com

--- linux/drivers/nvme/host/pci.c.orig	2018-04-05 13:52:23.048890019 -0600
+++ linux/drivers/nvme/host/pci.c	2018-04-09 11:20:57.432900569 -0600
@@ -2687,6 +2687,8 @@ static const struct pci_device_id nvme_i
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
+	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0023),	/* WDC SN200 adapter */
