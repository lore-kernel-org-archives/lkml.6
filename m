Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E80CC4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E292021721
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2C8GopAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfBBEHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:25 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55646 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfBBEHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:22 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="26219228"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:21 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtbAqREoWkX7nANZbVL3n56uBWF5+XZNtj7XOgfN3X0=;
 b=2C8GopAhAfpw8rZvvFWHM4/m+zarp5ZfsC8zYfclcwG44vZ6Xxc9z1RD/jcJLVjr3E0SsE/6Xf7qrlqFwjbWTW08Ol0WOytQofSddw53rdAIjpXvMi2tL2B1MsPLWnfl3PHsQfDlAH5hnfh4rj7hJLNBKfsfdh2Fe7cqj8ADWKo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:19 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem accesses
Thread-Topic: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Index: AQHUuqzK70j+j/B0dE+wG5hbzKgwlw==
Date:   Sat, 2 Feb 2019 04:07:19 +0000
Message-ID: <20190202040653.1217-4-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:HGidBeeEx5u217OLRTIfr6HD+jpIxuV9p4shWbEJA4aJadyluKCsuq/iK/p+LzYxLIaMIXAeG6cZ0SI2DQqe2PHYsE5D+siZt0hM3jwA9Vp6tZIuZ4K5ooPaq2tPHAgijYEDS/5KORl+aDFH6xviHeDGHavEI1wKU7GvPFbY/zFIOkcmHWMRuaPmelCysRBDQOCMfdfj5GUZ4gUNH029/+/Wi3/P93dFNmO8Ddxd3/NEad91WIXFci1Aea802fw5B7eE6mQq4vLJ4KpaKyyWF/vHmZUJ+1HnDWPuIDN0opCKO8ZofrIRnfREtI8k9sbhDkWQhPiVCjVuIqIcoCjsNtMVzmuFa0nXVpnbUn8ivGYvbnDDx6CQwAl0Y3NXrVybZdqMlwvsZDBk9Hd+K+2XfTQtz/sW79Uz5Ee0NvteOOx6SAzQsy40gnRw6hV9Yy1shsci6BTkVIqIKjTl49cfrA==;5:l7/KOIZPGRn+DlZZvwJK31cbpsaYj86Obab0tJud65KcK7wb0m+zHoWG8vUqWKk+FhV4deWWc8UcI5nG9Ok2hOa5AkWiJh0VgvIBafvXk9ODRXjK5Br5SGGexpqyQUtn17tfBHAkYwTMZwN83VKQPZlbTRbQ2Wf20Jab9fPuR/REsfQLsE3zW+R4Xyjrbik+Vi3TgYyqUEbMtahWqlRo4Q==;7:gs2y53NuKjegj4DX6D31UyNcariDccxwrjGtihGZKqMLU5U8aBS+nBLMQDLUeHBHeVIyHtmcEFzfbrSf8xuI1ALbIL4M1cqxYU8SoJMaJ947WXqXbebW5AWWXPDxUv2heFdEIPv1EVfrINAqsGJzfA==
x-ms-office365-filtering-correlation-id: 6876fc07-8d06-43e4-4abd-08d688c3ecaf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB13003515698ACC624F69F703F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r6Cw52Y4lj51NHsgIiw8qFkIabLXi8/AQPi3+eZFMWIvY1eITJIKY0Ty6SBXa6VtOYDo9e1gGhVI63i2eYrJT5DZMMLrOCSazold1y9OiW903qj+r+ehTGvEOTOpu0vAZL51TlUHQ6y+rGxreXZn2DHacs7GjJ8N8k1KAKBnGTKuHpdvBwBUoSBy7lB7LuE8Qqu+Jk8mF1WSo5CAEjW3BqpXqEBURot42PJzBOS6apv0pyo6fhypBSwAJnR1Xr75UA+K6mjN41taYoEngT76szIOrqrlJGsuer8qE27MzDqBt/AMAK6mX1ylBJfg6U0JZn7rq14hwg2hv0K5udcYmWT2aRZjSOjXaqjZrnhHORgYcfwF8AJXwwfsrhqUIiWhhxj+SENqd4+4Zemot/3Xp8R0iVDkVtBKbUqfcbVUmdY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6876fc07-8d06-43e4-4abd-08d688c3ecaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:16.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The wrappers hid that the accesses are relaxed. Drop them.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: no change
v2: new patch

 drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++----------------------=
----
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index feeddcb25e1f..131374db0db4 100644
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
 	if (aq->smm !=3D QSPI_MR_SMM) {
-		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
 		aq->smm =3D QSPI_MR_SMM;
 	}
=20
@@ -300,17 +290,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
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
@@ -321,22 +311,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
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
@@ -375,18 +365,20 @@ static int atmel_qspi_setup(struct spi_device *spi)
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
@@ -394,10 +386,11 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
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
@@ -503,7 +496,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
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

