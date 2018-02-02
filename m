Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeBBSkH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:40:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:50075 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754055AbeBBSj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:39:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="16579939"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/8] parport: Add support for BrainBoxes PX272/PX306 MIO card
Date: Fri,  2 Feb 2018 20:39:48 +0200
Message-Id: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for BrainBoxes Multi I/O cards (4+1 serial + 1 parallel port):

02:00.0 0702: 135a:4100 (rev 02)
        Subsystem: 135a:0443
	Flags: fast devsel, IRQ 18
	Memory at f7d02000 (32-bit, non-prefetchable) [size=128]
	I/O ports at e000 [size=128]
	I/O ports at e080 [size=64]
	I/O ports at e0c0 [size=16]
	Memory at f7d01000 (32-bit, non-prefetchable) [size=128]
	Memory at f7d00000 (32-bit, non-prefetchable) [size=128]
	Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Legacy Endpoint, MSI 01
	Capabilities: [100] Virtual Channel
	Capabilities: [800] Advanced Error Reporting

Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 087e847b1da2..eda733c8f6e0 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,7 @@ enum parport_pc_pci_cards {
 	wch_ch353_1s1p,
 	wch_ch353_2s1p,
 	wch_ch382_2s1p,
+	brainboxes_5s1p,
 	sunix_2s1p,
 };
 
@@ -153,6 +154,7 @@ static struct parport_pc_pci cards[] = {
 	/* wch_ch353_1s1p*/             { 1, { { 1, -1}, } },
 	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 	/* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
+	/* brainboxes_5s1p */           { 1, { { 3, -1 }, } },
 	/* sunix_2s1p */                { 1, { { 3, -1 }, } },
 };
 
@@ -258,6 +260,10 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
 	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
 
+	/* BrainBoxes PX272/PX306 MIO card */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_5s1p },
+
 	/*
 	 * More SUNIX variations. At least one of these has part number
 	 * '5079A but subdevice 0x102. That board reports 0x0708 as
@@ -501,6 +507,12 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.uart_offset    = 8,
 		.first_offset   = 0xC0,
 	},
+	[brainboxes_5s1p] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 5,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 	[sunix_2s1p] = {
 		.flags		= FL_BASE0|FL_BASE_BARS,
 		.num_ports	= 2,
-- 
2.15.1
