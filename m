Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C944420852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C944420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967376AbeFRJDg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:03:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966934AbeFRIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 428CDBAD;
        Mon, 18 Jun 2018 08:32:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Wang <xswang@marvell.com>,
        Ofer Heifetz <oferh@marvell.com>, Tejun Heo <tj@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/189] ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI
Date:   Mon, 18 Jun 2018 10:12:49 +0200
Message-Id: <20180618081212.218835867@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evan Wang <xswang@marvell.com>

[ Upstream commit daa2e3bdbb0b3e691cf20a042350817310cb8cb5 ]

There is an issue(Errata Ref#226) that the SATA can not be
detected via SATA Port-MultiPlayer(PMP) with following
error log:
  ata1.15: PMP product ID mismatch
  ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  ata1.15: Port Multiplier vendor mismatch '0x1b4b'!='0x0'
  ata1.15: PMP revalidation failed (errno=-19)

After debugging, the reason is found that the value Port-x
FIS-based Switching Control(PxFBS@0x40) become wrong.
According to design, the bits[11:8, 0] of register PxFBS
are cleared when Port Command and Status (0x18) bit[0]
changes its value from 1 to 0, i.e. falling edge of Port
Command and Status bit[0] sends PULSE that resets PxFBS
bits[11:8; 0].
So it needs a mvebu SATA WA to save the port PxFBS register
before PxCMD ST write and restore it afterwards.

This patch implements the WA in a separate function of
ahci_mvebu_stop_engine to override ahci_stop_gngine.

Signed-off-by: Evan Wang <xswang@marvell.com>
Cc: Ofer Heifetz <oferh@marvell.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/ahci_mvebu.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -62,6 +62,60 @@ static void ahci_mvebu_regret_option(str
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+/**
+ * ahci_mvebu_stop_engine
+ *
+ * @ap:	Target ata port
+ *
+ * Errata Ref#226 - SATA Disk HOT swap issue when connected through
+ * Port Multiplier in FIS-based Switching mode.
+ *
+ * To avoid the issue, according to design, the bits[11:8, 0] of
+ * register PxFBS are cleared when Port Command and Status (0x18) bit[0]
+ * changes its value from 1 to 0, i.e. falling edge of Port
+ * Command and Status bit[0] sends PULSE that resets PxFBS
+ * bits[11:8; 0].
+ *
+ * This function is used to override function of "ahci_stop_engine"
+ * from libahci.c by adding the mvebu work around(WA) to save PxFBS
+ * value before the PxCMD ST write of 0, then restore PxFBS value.
+ *
+ * Return: 0 on success; Error code otherwise.
+ */
+int ahci_mvebu_stop_engine(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp, port_fbs;
+
+	tmp = readl(port_mmio + PORT_CMD);
+
+	/* check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
+		return 0;
+
+	/* save the port PxFBS register for later restore */
+	port_fbs = readl(port_mmio + PORT_FBS);
+
+	/* setting HBA to idle */
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/*
+	 * bit #15 PxCMD signal doesn't clear PxFBS,
+	 * restore the PxFBS register right after clearing the PxCMD ST,
+	 * no need to wait for the PxCMD bit #15.
+	 */
+	writel(port_fbs, port_mmio + PORT_FBS);
+
+	/* wait for engine to stop. This could be as long as 500 msec */
+	tmp = ata_wait_register(ap, port_mmio + PORT_CMD,
+				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
+	if (tmp & PORT_CMD_LIST_ON)
+		return -EIO;
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int ahci_mvebu_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -112,6 +166,8 @@ static int ahci_mvebu_probe(struct platf
 	if (rc)
 		return rc;
 
+	hpriv->stop_engine = ahci_mvebu_stop_engine;
+
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "marvell,armada-380-ahci")) {
 		dram = mv_mbus_dram_info();


