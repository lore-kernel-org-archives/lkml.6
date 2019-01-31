Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D0C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2CF2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="F2hCDDIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfAaQPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:15:39 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62802 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfAaQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:38 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="26148200"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:15:37 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M37xH/eSQ/M416zshM3Z3yF+CM4zdkhU7VBss7DExa8=;
 b=F2hCDDIMsJQA9HShee9ZtbN/UM3XHgP7uG4MC+iBvGff7KAUSxDQwiabECEVRFGL820QegTiN9MOVGKJXNQnr+KHNg479m41G+FRPKUhmKep1KZsL2GFFKwcCUAafhbfYbSbDOm8nqLWmUOA/sOhOc5bij37Jw5dlMjagzLG130=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0004.namprd11.prod.outlook.com (10.161.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 16:15:34 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:33 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 03/10] spi: atmel-quadspi: drop wrappers for iomem accesses
Thread-Topic: [PATCH v2 03/10] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Index: AQHUuYAx9b//q0v6hUW7FfCSTVlftQ==
Date:   Thu, 31 Jan 2019 16:15:33 +0000
Message-ID: <20190131161515.21605-4-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0004;6:Xi5KOmEPRYP2JHAaoM3UXQRYTM4/MIZHV4OzjmhEsNpWzVNQBMcTW4lZAiDuaZrWln1/WEC2NiedJcZKrXnh5H4i3kuAxwafXF3ID+WDz47KbIg6faASbpkh58jwrZN+Es7DENhHrwK31QD/8E147Ssdq/FX8+1cl3eyK+sC9jxPFOhZQ6t8OY95YyFK2GdZvHcRK464BLnQM1CxPegWTzXySmd04B2vi5cO1ZmSAbG7w/DFmUIokOLQvR4EJNRjKrt/Idfby6p1sSHtqzHaOoeYHosRY4x1Oacc6HK8oceS7q7eFPSfYqVRoUltpHM5c/+eNzy9N0qNornL7hU7kPApWdzGi0IxLFKOQN57Vao6TCmE6gCUbKtZDpb+w9JtcJndqwXNKseOKpWcRRMn0cDBYtTLCehtR6BbfbZOa0eLulMvUcQvyJyrX8YYD3viXnLNrCEgAshuUC8zGj3vTw==;5:NwYdzYsvRjyXpOjkRq+8sHCqFdQlwkZcxRYaOlmCRsUaU/jHoQ1TrJ/v8QBD9yl1kUwQ1YbO8SNLu0BJmWWhqYCBbyzPQW2PzpeYoF0UKh3E67CZHnQURQr7rGDomR6hcB394bz1Lv5XAO8prdfjsYGkdu+XiDDfg/+QVlzKMteRGRwCqdn61DJ/qlfivDxWN6hSg3m+on6efntmp9MEXg==;7:hxG85/W6NjrSiZY7DyL/9AJk7pxlNO7DwZ4ivY/gF3KT5EBy66rIRQ6nO4nq3gO+9rzMEXtOErnaD7r33y9t8AXowQ9Z2abvNyuuwN7XJewjy4fEHBJQGcPSyWeTFdgQOWzofb92l+sgRZBfC4sSyA==
x-ms-office365-filtering-correlation-id: 0f5a08fd-b883-4e9c-6958-08d6879753ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0004;
x-ms-traffictypediagnostic: BN6PR11MB0004:
x-microsoft-antispam-prvs: <BN6PR11MB00041A1011D2422F8A981BA8F0910@BN6PR11MB0004.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(14454004)(186003)(86362001)(36756003)(1076003)(76176011)(68736007)(81166006)(256004)(7416002)(8936002)(72206003)(14444005)(52116002)(6486002)(386003)(6506007)(305945005)(11346002)(2906002)(2616005)(102836004)(50226002)(6436002)(66066001)(71190400001)(486006)(316002)(6512007)(4326008)(446003)(107886003)(71200400001)(476003)(97736004)(26005)(6116002)(3846002)(105586002)(478600001)(25786009)(53936002)(54906003)(99286004)(7736002)(2501003)(106356001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0004;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YhGrX1jLX6nf//lM/1rM9cP3ko+R0aeKhlynJuMvZ3dvxtI94U6Qp2ce87M4phS/mtjtc7lmDFVCBphBhOFS7smgrXhJZNZa+TrHXz6qfpgUUM7MgxiYL0PC2wDoXMXpW2vXA7lJx7m6PFVXJ/j7ASrIkl2rljbQCFRWhiIItnMHiHSuhePRweMNlQoTMVpCsshaOwyFOyZyPy2sONtRH1UnKY++urPk3ufu9K4ylFw72cxKxAysoZZEJtL14dKoOv8SZQ+MOPh0pMJnNqzKGjx0hDM9r33C0GZGLWhRGZwPDmoQEeTKWVyIqxrBzhfXmouVp0NHVIhT/qjiMH3e1FAEupwB9AK0rbPn6cNbEqdclTsCCQ4iXgBUsC9XsOA6x0g/YdVboz8mkSHUp2/iOE/JZEAWfT8oCQ4CxPXLWTM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5a08fd-b883-4e9c-6958-08d6879753ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:31.5785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The wrappers hid that the accesses are relaxed. Drop them.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: new patch

 drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++----------------------=
----
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index c986daa895a1..3a7648ea07e8 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] =3D=
 {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
=20
-/* Register access functions */
-static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
-{
-	return readl_relaxed(aq->regs + reg);
-}
-
-static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
-{
-	writel_relaxed(value, aq->regs + reg);
-}
-
 static inline bool is_compatible(const struct spi_mem_op *op,
 				 const struct qspi_mode *mode)
 {
@@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
 {
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
+	void __iomem *base =3D aq->regs;
 	int mode;
 	u32 dummy_cycles =3D 0;
 	u32 iar, icr, ifr, sr;
@@ -240,7 +230,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
=20
 	/* Set the QSPI controller in Serial Memory Mode */
 	if (!(aq->mr & QSPI_MR_SMM))
-		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
=20
 	mode =3D find_mode(op);
 	if (mode < 0)
@@ -298,17 +288,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
=20
 	/* Clear pending interrupts */
-	(void)qspi_readl(aq, QSPI_SR);
+	(void)readl_relaxed(base + QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	qspi_writel(aq, QSPI_IAR, iar);
-	qspi_writel(aq, QSPI_ICR, icr);
-	qspi_writel(aq, QSPI_IFR, ifr);
+	writel_relaxed(iar, base + QSPI_IAR);
+	writel_relaxed(icr, base + QSPI_ICR);
+	writel_relaxed(ifr, base + QSPI_IFR);
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
 		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)qspi_readl(aq, QSPI_IFR);
+		(void)readl_relaxed(base + QSPI_IFR);
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
@@ -319,22 +309,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 				op->data.buf.out, op->data.nbytes);
=20
 		/* Release the chip-select */
-		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
 	}
=20
 	/* Poll INSTRuction End status */
-	sr =3D qspi_readl(aq, QSPI_SR);
+	sr =3D readl_relaxed(base + QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) =3D=3D QSPI_SR_CMD_COMPLETED)
 		return err;
=20
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
 	aq->pending =3D sr & QSPI_SR_CMD_COMPLETED;
-	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IER);
 	if (!wait_for_completion_timeout(&aq->cmd_completion,
 					 msecs_to_jiffies(1000)))
 		err =3D -ETIMEDOUT;
-	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IDR);
=20
 	return err;
 }
@@ -373,18 +363,20 @@ static int atmel_qspi_setup(struct spi_device *spi)
 		scbr--;
=20
 	scr =3D QSPI_SCR_SCBR(scbr);
-	qspi_writel(aq, QSPI_SCR, scr);
+	writel_relaxed(scr, aq->regs + QSPI_SCR);
=20
 	return 0;
 }
=20
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
+	void __iomem *base =3D aq->regs;
+
 	/* Reset the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
+	writel_relaxed(QSPI_CR_SWRST, base + QSPI_CR);
=20
 	/* Enable the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
+	writel_relaxed(QSPI_CR_QSPIEN, base + QSPI_CR);
=20
 	return 0;
 }
@@ -392,10 +384,11 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
 	struct atmel_qspi *aq =3D (struct atmel_qspi *)dev_id;
+	void __iomem *base =3D aq->regs;
 	u32 status, mask, pending;
=20
-	status =3D qspi_readl(aq, QSPI_SR);
-	mask =3D qspi_readl(aq, QSPI_IMR);
+	status =3D readl_relaxed(base + QSPI_SR);
+	mask =3D readl_relaxed(base + QSPI_IMR);
 	pending =3D status & mask;
=20
 	if (!pending)
@@ -501,7 +494,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(ctrl);
=20
 	spi_unregister_controller(ctrl);
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
+	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
 	clk_disable_unprepare(aq->clk);
 	return 0;
 }
--=20
2.9.5

