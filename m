Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032362AbeEZTf3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 15:35:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33483 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032304AbeEZTf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 15:35:27 -0400
X-Google-Smtp-Source: AB8JxZqzUSGEQgwJ8iu4xpZ3LEQqVxRjG9G9CgKv1hjJh72H5FmVAgRM6ClB8b3hWZTcsmHpouRh2w==
From: Matt Turner <mattst88@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        Sergej Pupykin <ml@sergej.pp.ru>
Subject: [PATCH] parport: Add support for the WCH384 4S multi-IO card
Date: Sat, 26 May 2018 12:35:23 -0700
Message-Id: <20180526193523.3896-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Multi-IO card has one serial 16550-like serial connectors. Here's
the lspci output, after this commit is applied:

01:00.0 Serial controller [0700]: Device [1c00:3470] (rev 10) (prog-if 05 [16850])
        Subsystem: Device [1c00:3470]
        Flags: fast devsel, IRQ 16
        I/O ports at e000 [size=256]
        Memory at f0100000 (32-bit, prefetchable) [size=32K]
        I/O ports at e100 [size=4]
        Expansion ROM at f7d00000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 3
        Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
        Capabilities: [80] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: parport_serial

This card was already added to the blacklist of 8250_pci.c in commit
72a3c0e4e662 ("tty: Add support for the WCH384 4S multi-IO card").

Cc: Sergej Pupykin <ml@sergej.pp.ru>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
It looks like CH355_4S is similarly missing, but I don't have hardware
to test.

This commit makes me wonder if I'm missing something -- how could
anything have worked after commit 72a3c0e4e662 without support in
parport_serial?

 drivers/parport/parport_serial.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e15b4845f7c6..2c166d5a0d91 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,7 @@ enum parport_pc_pci_cards {
 	wch_ch353_1s1p,
 	wch_ch353_2s1p,
 	wch_ch382_2s1p,
+	wch_ch384_4,
 	sunix_2s1p,
 };
 
@@ -153,6 +154,7 @@ static struct parport_pc_pci cards[] = {
 	/* wch_ch353_1s1p*/             { 1, { { 1, -1}, } },
 	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 	/* wch_ch382_2s1p*/             { 1, { { 2, -1}, } },
+	/* wch_ch384_4 */               { 1, { { 4, -1}, } },
 	/* sunix_2s1p */                { 1, { { 3, -1 }, } },
 };
 
@@ -260,6 +262,7 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
 	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
 	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
+	{ 0x1c00, 0x3470, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch384_4},
 
 	/*
 	 * More SUNIX variations. At least one of these has part number
@@ -504,6 +507,13 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.uart_offset    = 8,
 		.first_offset   = 0xC0,
 	},
+	[wch_ch384_4] = {
+		.flags          = FL_BASE0,
+		.num_ports      = 4,
+		.base_baud      = 115200,
+		.uart_offset    = 8,
+		.first_offset   = 0xC0,
+	},
 	[sunix_2s1p] = {
 		.flags		= FL_BASE0|FL_BASE_BARS,
 		.num_ports	= 2,
-- 
2.16.1
