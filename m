Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0677C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EDE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIrasD4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfB0KGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:06:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41611 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfB0KGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:06:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so7720631pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 02:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rA0RlvjRoH07LApCq1jTc7q639kpusfijdFAjYjb7jg=;
        b=bIrasD4tE2isWUWbqaHpok6/eebSsixKPJFFsmKgf+XFULaj0oDa90o4cX8X+Lu9hj
         Kc395S9TGYkRpXUC07aEF4xN3LqD7pcoK2cbtkrXTZWLP350Xhk2PNmLdVMxXoDO1ahk
         nzlDtcw4gQTSJfv0UqK0O2GDXDdeDoDVdV4XY7LAvVGARRWpp4B46YF9ePdUcfDpiY9I
         +rl2ZCz9PLOJFCHj16CgJ5I/R0lYdAg3PqNh1lvRwMRN2vRsw0tSQB0WZ3LLMUrwlU/N
         /1oxvkLByLVfR24klIwSUsehYF3/FBddlEF1CdnKOhAwpE9IzefwhzAh6qyK4BtFQxMT
         p+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rA0RlvjRoH07LApCq1jTc7q639kpusfijdFAjYjb7jg=;
        b=fcPVA1PR14EduX6ZRow6gqBPloms9/6adY02zLoQuR1ajdEu4tDfqJcEKcZhjSPw4I
         ng7POR65qGfqxMxIvcYQUJqD3K0GBKIeEv3AO43PoXgHHuTjt9ITRH2ZST9RBdTcLXk6
         WPEjYzP0gmnM2GPJk2J9OowbKLicsEBqmRz5qJmV6ucnybOKdFjarx4409w80AwAowSd
         bNl+2jBNdAayx5k3G/H9WOF7QcM5Y+P3AlQ0ARohufnEQxt7WETs90LWMD9+E1kVcXIR
         Bu4GfmiWN8dGN4Xa/D2zsc3M1XPa2PBZlZ5f5kMCOTMtcHszKn9AmgBfo8boweDXjubW
         gl+A==
X-Gm-Message-State: AHQUAubsjmZbsQmDhVAdiH4YeVs8t4eQFogJ9pryFJtX0IS7wsPcA9NF
        89e9vIB1XxwFlM3XcjOfTgY=
X-Google-Smtp-Source: AHgI3IaEc4cDe1/Z1LzvXn6jCJ7PVHpQ3H/0+b82p0q5sUz0emeK+0OyHOn/7mDRmF+JemELJjCTQw==
X-Received: by 2002:a62:5789:: with SMTP id i9mr794326pfj.75.1551261997461;
        Wed, 27 Feb 2019 02:06:37 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-235-188.dynamic-ip.hinet.net. [114.36.235.188])
        by smtp.gmail.com with ESMTPSA id f14sm16626460pgv.23.2019.02.27.02.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 02:06:36 -0800 (PST)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] fix driver conflict issues
Date:   Wed, 27 Feb 2019 18:06:22 +0800
Message-Id: <20190227100622.3779-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am an engineer in the software team at SUNIX Inc.,
maintain SUNIX Multi-I/O Board Device driver,we plan to submit drivers to
the kernel,therefore,i want to modify file for resolve driver conflict issue.
---
 tty/serial/8250/8250_pci.c | 163 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

diff --git a/tty/serial/8250/8250_pci.c b/tty/serial/8250/8250_pci.c
index e4bb1bf3..48bd694a 100644
--- a/tty/serial/8250/8250_pci.c
+++ b/tty/serial/8250/8250_pci.c
@@ -519,6 +519,116 @@ static int pci_siig_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+/*
+ * Timedia has an explosion of boards, and to avoid the PCI table from
+ * growing *huge*, we use this function to collapse some 70 entries
+ * in the PCI table into one, for sanity's and compactness's sake.
+ */
+static const unsigned short timedia_single_port[] = {
+	0x4025, 0x4027, 0x4028, 0x5025, 0x5027, 0
+};
+
+static const unsigned short timedia_dual_port[] = {
+	0x0002, 0x4036, 0x4037, 0x4038, 0x4078, 0x4079, 0x4085,
+	0x4088, 0x4089, 0x5037, 0x5078, 0x5079, 0x5085, 0x6079,
+	0x7079, 0x8079, 0x8137, 0x8138, 0x8237, 0x8238, 0x9079,
+	0x9137, 0x9138, 0x9237, 0x9238, 0xA079, 0xB079, 0xC079,
+	0xD079, 0
+};
+
+static const unsigned short timedia_quad_port[] = {
+	0x4055, 0x4056, 0x4095, 0x4096, 0x5056, 0x8156, 0x8157,
+	0x8256, 0x8257, 0x9056, 0x9156, 0x9157, 0x9158, 0x9159,
+	0x9256, 0x9257, 0xA056, 0xA157, 0xA158, 0xA159, 0xB056,
+	0xB157, 0
+};
+
+static const unsigned short timedia_eight_port[] = {
+	0x4065, 0x4066, 0x5065, 0x5066, 0x8166, 0x9066, 0x9166,
+	0x9167, 0x9168, 0xA066, 0xA167, 0xA168, 0
+};
+
+static const struct timedia_struct {
+	int num;
+	const unsigned short *ids;
+} timedia_data[] = {
+	{ 1, timedia_single_port },
+	{ 2, timedia_dual_port },
+	{ 4, timedia_quad_port },
+	{ 8, timedia_eight_port }
+};
+
+/*
+ * There are nearly 70 different Timedia/SUNIX PCI serial devices.  Instead of
+ * listing them individually, this driver merely grabs them all with
+ * PCI_ANY_ID.  Some of these devices, however, also feature a parallel port,
+ * and should be left free to be claimed by parport_serial instead.
+ */
+static int pci_timedia_probe(struct pci_dev *dev)
+{
+	/*
+	 * Check the third digit of the subdevice ID
+	 * (0,2,3,5,6: serial only -- 7,8,9: serial + parallel)
+	 */
+	if ((dev->subsystem_device & 0x00f0) >= 0x70) {
+		dev_info(&dev->dev,
+			"ignoring Timedia subdevice %04x for parport_serial\n",
+			dev->subsystem_device);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int pci_timedia_init(struct pci_dev *dev)
+{
+	const unsigned short *ids;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(timedia_data); i++) {
+		ids = timedia_data[i].ids;
+		for (j = 0; ids[j]; j++)
+			if (dev->subsystem_device == ids[j])
+				return timedia_data[i].num;
+	}
+	return 0;
+}
+
+/*
+ * Timedia/SUNIX uses a mixture of BARs and offsets
+ * Ugh, this is ugly as all hell --- TYT
+ */
+static int
+pci_timedia_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	unsigned int bar = 0, offset = board->first_offset;
+
+	switch (idx) {
+	case 0:
+		bar = 0;
+		break;
+	case 1:
+		offset = board->uart_offset;
+		bar = 0;
+		break;
+	case 2:
+		bar = 1;
+		break;
+	case 3:
+		offset = board->uart_offset;
+		/* FALLTHROUGH */
+	case 4: /* BAR 2 */
+	case 5: /* BAR 3 */
+	case 6: /* BAR 4 */
+	case 7: /* BAR 5 */
+		bar = idx - 2;
+	}
+
+	return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
 /*
  * Some Titan cards are also a little weird
  */
@@ -1993,7 +2103,42 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= titan_400l_800l_setup,
 	},
-
+	/*
+	 * Timedia cards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_TIMEDIA,
+		.device		= PCI_DEVICE_ID_TIMEDIA_1889,
+		.subvendor	= PCI_VENDOR_ID_TIMEDIA,
+		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_timedia_probe,
+		.init		= pci_timedia_init,
+		.setup		= pci_timedia_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_TIMEDIA,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_timedia_setup,
+	},
+	/*
+	 * SUNIX (Timedia) cards
+	 * Do not "probe" for these cards as there is at least one combination
+	 * card that should be handled by parport_pc that doesn't match the
+	 * rule in pci_timedia_probe.
+	 * It is part number is MIO5079A but its subdevice ID is 0x0102.
+	 * There are some boards with part number SER5037AL that report
+	 * subdevice ID 0x0002.
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_SUNIX,
+		.device		= PCI_DEVICE_ID_SUNIX_1999,
+		.subvendor	= PCI_VENDOR_ID_SUNIX,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_timedia_init,
+		.setup		= pci_timedia_setup,
+	},
 	/*
 	 * Xircom cards
 	 */
@@ -4231,6 +4376,22 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi },
+	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
+		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_1_921600 },
+
+	/*
+	 * SUNIX (TIMEDIA)
+	 */
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
+		PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00,
+		pbn_b0_bt_1_921600 },
+
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
+		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b0_bt_1_921600 },
 
 	/*
 	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
-- 
2.17.1

