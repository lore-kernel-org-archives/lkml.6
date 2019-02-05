Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A86C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA755217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="GohVVHV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfBEPnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:33 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:40457 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBEPnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="25876473"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:20 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTUqlijysMEDDano6588hxQdEzz/9N7+Qyd4QuHospE=;
 b=GohVVHV8ESWtiT6/gIz3Z/SdbJ5LutJkFabThIQRAOGWPvhIUmc+5GM/FP1L8NeXO/qa8tmafvxWECYqkGUTkaPeVbs/kwnC5UxA8HJqNGsoYPBdoFEAopr3yYOYCE11oNCpG5gnGfrOF7WzCkoalHmLbZb0kWMg7NFTbwN0/ac=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1409.namprd11.prod.outlook.com (10.173.31.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 15:43:17 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 03/13] spi: atmel-quadspi: drop wrappers for iomem accesses
Thread-Topic: [PATCH v5 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Index: AQHUvWmDcT1ucFdst0mnT2cDYB/JpQ==
Date:   Tue, 5 Feb 2019 15:43:17 +0000
Message-ID: <20190205154257.29529-4-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1409;6:Vp+U80ksuwGfire68Rrsq4G2zFur7hIq7jeAUFRjIrOHrm0UPl2tmShqkmfdWILGUFGQDgI+bYXGWnJXqfvY/rBtawfoeTDyf+dVHdm0ZJytsjeY1t2GD9oJAnCZKzi9bwpGlY9FMlV/UT5HYyoJSMJF2pJWIanxMkCz3NAZHWYp3Y60ut447pX8GT1lbuhBvnjDXknzJswSuWoNXnDsyrds4eAJInFXiVsV29ekhBNS6pFS//OoT2pQBzRKAmvl1YtGeBKf8Lcgyo45U1oSsxaWABzzXEeYZe5RsHnKVSXJ2BGeHzfb37C8w2uR568f/GKEh0AxsTWOnzYzW0kMd2dRskRgIRfY5n7YeR0XbPh3/ZxGt4+SKYhXQtZDpcXS/JyQ4T5aK6VKtgD2cvGMYSQZmxg4XIL1Aew7v8zwyXd20XIoJKzGsaz0vEHQmsU/ushV7iAiavhYfob/lppE0w==;5:h+2Z+MqbMiF0pd0OdC8x2DlGSktXb+eeaB4TCMvx86fksceW0wW2KFGR0ubOW/N37nZw3iluLgbMVv44T/bpjG9NpXqX0BdWULmVPtDHNf6gEq8Mdq5QNfTP5/fTkvlZsMS7mi3mbvYO7904ENAT7pwD8fCeeJaWJLCAyDsvP93SpVDwnBE9nrpLoye35KM44ZZXhmKW3UdXPlQ5xYzxeA==;7:ZIwiPGYrQvbeKI23WJdKiF+ABov56AB6YPcEd5uzKSEZTzXQHa8bD2EskteMsYQjeIWN8lt1NTU0A2hPohsO/jZJcaJpeIcvv2+0hrNwxwTWyWz8rHUXXaDvariR3JfWdB92sCsfW5x6n3zSMuOCaA==
x-ms-office365-filtering-correlation-id: bd271a51-136a-444a-0743-08d68b80a594
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1409;
x-ms-traffictypediagnostic: BN6PR11MB1409:
x-microsoft-antispam-prvs: <BN6PR11MB1409EE7D2CA7CCCDE70C1366F06E0@BN6PR11MB1409.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(97736004)(105586002)(106356001)(2501003)(26005)(6506007)(386003)(186003)(71190400001)(71200400001)(11346002)(446003)(4326008)(25786009)(316002)(2616005)(2906002)(102836004)(476003)(7416002)(110136005)(54906003)(86362001)(486006)(256004)(6436002)(99286004)(72206003)(478600001)(7736002)(68736007)(36756003)(14454004)(76176011)(52116002)(50226002)(3846002)(53936002)(81156014)(6116002)(66066001)(6486002)(8676002)(305945005)(81166006)(6512007)(8936002)(1076003)(107886003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1409;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W96q2C7/ApADYaEktJJYQuIKXeGDWCkyD9pJwdSb9IVOPAFtmtqRJOatX90vUC3+zSmK+uktCDhS+eegCsR+SXBv/9qiI0SLaV1kUqwf9kYw/8XE8UH0Sf2SOZcm97ACGfzqj7jOyqGFf9nFcRt3IUTLrOGJuNUdydXWHiPYoOZTaL7OrJl3vOn38Ytlmodjd8o/eDRrwLWUiTcV62MxP4MdzfKpjBovrAORJqdipc0RthPAsVDoOWzo203yebfWav8zysW9pMycuy0G2RA2k9abcezSD/XpWhyeQSnbxyQcFq1jiJTZeF4SK5gtyByE8N7hJyNCbHFq2G8lGjcYnr61jwZqpMPcY5JtpVhiRHjp4ZIJQAecbKu/YMcDhWtfDs2p9pgMWQ0P9i6ilPEouZHlxhckECAu7/CICzFajxA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd271a51-136a-444a-0743-08d68b80a594
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:14.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1409
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The wrappers hid that the accesses are relaxed. Drop them.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no changes
v4:
- drop local variable that kept aq->regs, the compiler should be
  smart enough to store it in a register
- collect R-b
v3: no change
v2: new patch

 drivers/spi/atmel-quadspi.c | 45 +++++++++++++++++------------------------=
----
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 7d83ce8747e8..c745e75b755e 100644
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
@@ -243,7 +232,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 	 * Serial Memory Mode (SMM).
 	 */
 	if (aq->mr !=3D QSPI_MR_SMM) {
-		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
 		aq->mr =3D QSPI_MR_SMM;
 	}
=20
@@ -303,17 +292,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
=20
 	/* Clear pending interrupts */
-	(void)qspi_readl(aq, QSPI_SR);
+	(void)readl_relaxed(aq->regs + QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	qspi_writel(aq, QSPI_IAR, iar);
-	qspi_writel(aq, QSPI_ICR, icr);
-	qspi_writel(aq, QSPI_IFR, ifr);
+	writel_relaxed(iar, aq->regs + QSPI_IAR);
+	writel_relaxed(icr, aq->regs + QSPI_ICR);
+	writel_relaxed(ifr, aq->regs + QSPI_IFR);
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
 		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)qspi_readl(aq, QSPI_IFR);
+		(void)readl_relaxed(aq->regs + QSPI_IFR);
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
@@ -324,22 +313,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 				op->data.buf.out, op->data.nbytes);
=20
 		/* Release the chip-select */
-		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
 	}
=20
 	/* Poll INSTRuction End status */
-	sr =3D qspi_readl(aq, QSPI_SR);
+	sr =3D readl_relaxed(aq->regs + QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) =3D=3D QSPI_SR_CMD_COMPLETED)
 		return err;
=20
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
 	aq->pending =3D sr & QSPI_SR_CMD_COMPLETED;
-	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	writel_relaxed(QSPI_SR_CMD_COMPLETED, aq->regs + QSPI_IER);
 	if (!wait_for_completion_timeout(&aq->cmd_completion,
 					 msecs_to_jiffies(1000)))
 		err =3D -ETIMEDOUT;
-	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+	writel_relaxed(QSPI_SR_CMD_COMPLETED, aq->regs + QSPI_IDR);
=20
 	return err;
 }
@@ -378,7 +367,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 		scbr--;
=20
 	scr =3D QSPI_SCR_SCBR(scbr);
-	qspi_writel(aq, QSPI_SCR, scr);
+	writel_relaxed(scr, aq->regs + QSPI_SCR);
=20
 	return 0;
 }
@@ -386,14 +375,14 @@ static int atmel_qspi_setup(struct spi_device *spi)
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
+	writel_relaxed(QSPI_CR_SWRST, aq->regs + QSPI_CR);
=20
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
 	aq->mr =3D QSPI_MR_SMM;
=20
 	/* Enable the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
+	writel_relaxed(QSPI_CR_QSPIEN, aq->regs + QSPI_CR);
=20
 	return 0;
 }
@@ -403,8 +392,8 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *=
dev_id)
 	struct atmel_qspi *aq =3D (struct atmel_qspi *)dev_id;
 	u32 status, mask, pending;
=20
-	status =3D qspi_readl(aq, QSPI_SR);
-	mask =3D qspi_readl(aq, QSPI_IMR);
+	status =3D readl_relaxed(aq->regs + QSPI_SR);
+	mask =3D readl_relaxed(aq->regs + QSPI_IMR);
 	pending =3D status & mask;
=20
 	if (!pending)
@@ -510,7 +499,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
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

