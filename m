Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07551C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE30219A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE30219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asem.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbeHGJae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:30:34 -0400
Received: from smtp.asem.it ([151.1.184.197]:53514 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732772AbeHGJae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:30:34 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 4.0.1)
        with ESMTP id SG003401868.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:17:26 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Tue, 7
 Aug 2018 09:17:28 +0200
Received: from flavio-x.asem.intra (172.16.17.160) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Tue, 7 Aug 2018 09:17:28 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v4] can: sja1000: plx_pci: add support for ASEM CAN raw device
Date:   Tue, 7 Aug 2018 09:17:19 +0200
Message-ID: <1533626239-4065-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <53dae6d6-c25b-71d5-b43f-1d444d9c352b@pengutronix.de>
References: <53dae6d6-c25b-71d5-b43f-1d444d9c352b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020A.5B694788.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for ASEM opto-isolated dual channels
CAN raw device (http://www.asem.it)

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v2: - rename ASEM_... constants to reduce space size;
    - remove "else" in "plx_pci_reset_asem_dual_can_raw" function to avoid 
      strings breaking
v3: - fix wrong comment for PLX_LINT2_POL
    - put string into just one line in "plx_pci_reset_asem_dual_can_raw"
      function
v4: - remove unnecessary variable "reset_bar" in 
      "plx_pci_reset_asem_dual_can_raw" function

 drivers/net/can/sja1000/Kconfig   |  1 +
 drivers/net/can/sja1000/plx_pci.c | 66 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 1e65cb6..f6dc899 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -88,6 +88,7 @@ config CAN_PLX_PCI
 	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
 	   - IXXAT Automation PC-I 04/PCI card (http://www.ixxat.com/)
 	   - Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card (http://www.connecttech.com)
+	   - ASEM CAN raw - 2 isolated CAN channels (www.asem.it)
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index f8ff25c..79fc327 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -46,7 +46,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
 			"esd CAN-PCIe/2000, "
 			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
 			"IXXAT PC-I 04/PCI, "
-			"ELCUS CAN-200-PCI")
+			"ELCUS CAN-200-PCI, "
+			"ASEM DUAL CAN-RAW")
 MODULE_LICENSE("GPL v2");
 
 #define PLX_PCI_MAX_CHAN 2
@@ -70,7 +71,9 @@ struct plx_pci_card {
 					 */
 
 #define PLX_LINT1_EN	0x1		/* Local interrupt 1 enable */
+#define PLX_LINT1_POL	(1 << 1)	/* Local interrupt 1 polarity */
 #define PLX_LINT2_EN	(1 << 3)	/* Local interrupt 2 enable */
+#define PLX_LINT2_POL	(1 << 4)	/* Local interrupt 2 polarity */
 #define PLX_PCI_INT_EN	(1 << 6)	/* PCI Interrupt Enable */
 #define PLX_PCI_RESET	(1 << 30)	/* PCI Adapter Software Reset */
 
@@ -92,6 +95,9 @@ struct plx_pci_card {
  */
 #define PLX_PCI_OCR	(OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
 
+/* OCR setting for ASEM Dual CAN raw */
+#define ASEM_PCI_OCR	0xfe
+
 /*
  * In the CDR register, you should set CBP to 1.
  * You will probably also want to set the clock divider value to 7
@@ -145,10 +151,20 @@ struct plx_pci_card {
 #define MOXA_PCI_VENDOR_ID		0x1393
 #define MOXA_PCI_DEVICE_ID		0x0100
 
+#define ASEM_RAW_CAN_VENDOR_ID		0x10b5
+#define ASEM_RAW_CAN_DEVICE_ID		0x9030
+#define ASEM_RAW_CAN_SUB_VENDOR_ID	0x3000
+#define ASEM_RAW_CAN_SUB_DEVICE_ID	0x1001
+#define ASEM_RAW_CAN_SUB_DEVICE_ID_BIS	0x1002
+#define ASEM_RAW_CAN_RST_REGISTER	0x54
+#define ASEM_RAW_CAN_RST_MASK_CAN1	0x20
+#define ASEM_RAW_CAN_RST_MASK_CAN2	0x04
+
 static void plx_pci_reset_common(struct pci_dev *pdev);
 static void plx9056_pci_reset_common(struct pci_dev *pdev);
 static void plx_pci_reset_marathon_pci(struct pci_dev *pdev);
 static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev);
+static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev);
 
 struct plx_pci_channel_map {
 	u32 bar;
@@ -269,6 +285,14 @@ static struct plx_pci_card_info plx_pci_card_info_moxa = {
 	 /* based on PLX9052 */
 };
 
+static struct plx_pci_card_info plx_pci_card_info_asem_dual_can = {
+	"ASEM Dual CAN raw PCI", 2,
+	PLX_PCI_CAN_CLOCK, ASEM_PCI_OCR, PLX_PCI_CDR,
+	{0, 0x00, 0x00}, { {2, 0x00, 0x00}, {4, 0x00, 0x00} },
+	&plx_pci_reset_asem_dual_can_raw
+	/* based on PLX9030 */
+};
+
 static const struct pci_device_id plx_pci_tbl[] = {
 	{
 		/* Adlink PCI-7841/cPCI-7841 */
@@ -375,6 +399,20 @@ static const struct pci_device_id plx_pci_tbl[] = {
 		0, 0,
 		(kernel_ulong_t)&plx_pci_card_info_moxa
 	},
+	{
+		/* ASEM Dual CAN raw */
+		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
+		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
+	},
+	{
+		/* ASEM Dual CAN raw -new model */
+		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
+		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
+		0, 0,
+		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
+	},
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
@@ -524,6 +562,32 @@ static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev)
 	}
 }
 
+/* Special reset function for ASEM Dual CAN raw card */
+static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev)
+{
+	void __iomem *bar0_addr;
+	u8 tmpval;
+
+	plx_pci_reset_common(pdev);
+
+	bar0_addr = pci_iomap(pdev, 0, 0);
+	if (!bar0_addr) {
+		dev_err(&pdev->dev, "Failed to remap reset space %d (BAR%d)\n",
+			0, 0);
+		return;
+	}
+
+	/* reset the two SJA1000 chips */
+	tmpval = ioread8(bar0_addr + ASEM_RAW_CAN_RST_REGISTER);
+	tmpval &= ~(ASEM_RAW_CAN_RST_MASK_CAN1 | ASEM_RAW_CAN_RST_MASK_CAN2);
+	iowrite8(tmpval, bar0_addr + ASEM_RAW_CAN_RST_REGISTER);
+	usleep_range(300, 400);
+	tmpval |= ASEM_RAW_CAN_RST_MASK_CAN1 | ASEM_RAW_CAN_RST_MASK_CAN2;
+	iowrite8(tmpval, bar0_addr + ASEM_RAW_CAN_RST_REGISTER);
+	usleep_range(300, 400);
+	pci_iounmap(pdev, bar0_addr);
+}
+
 static void plx_pci_del_card(struct pci_dev *pdev)
 {
 	struct plx_pci_card *card = pci_get_drvdata(pdev);
-- 
2.7.4

