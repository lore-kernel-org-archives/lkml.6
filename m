Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F59C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81409204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v1fbUDys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfAGHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:48:02 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:27839
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfAGHsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDF5JBjGuxoy2zaeA0PGKKZZq6KdY2rzMmQ+HjSqSz8=;
 b=v1fbUDysqpxXVj7t+aSvAQ8jQG+shmub+una3R1j892S5S3vWGBykrgb9rplZiNUMIIF4wx4aIrNau+psKi1wnxc4XBJEq6XO7UKv3/eIVpui5pwuHd+362NVtchXSL5xbPKDfWOQlBb3zBBmsB0w/7IE3F1l1fq62AnhOgRhdo=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5831.eurprd04.prod.outlook.com (20.179.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:47 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:47 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 7/8] spi: lpspi: Add cs-gpio support
Thread-Topic: [PATCH 7/8] spi: lpspi: Add cs-gpio support
Thread-Index: AQHUpl1INeQZiTxjVUa2XfvHnLPYEw==
Date:   Mon, 7 Jan 2019 07:47:47 +0000
Message-ID: <20190107074639.6336-8-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5831;6:zwRX8xSGwS2DAhRoI4UIbFtXL/siUtmvVzmUCadk8JRtBGMBpFqjvwMNm3d1v8B0pGmfjU9TgnTpV9ZCyRquV/CAEjOf3zmxF4rhiXv5S8ooVOEjrVGhO4KKtyVFqQxozAX2JBe3mqNQXhJD0/5gGXWvDUqLqReZ8DuN/9pMzSAtMzLL7EV3tIPAcklHf9044yHtKswTlHpgRrDLpL5Fkh9i7x99BizCIJ5h2j64gEhSUKwMXhbO1bPRgg4t3+hl8ywu+P5M8NPMWLVhJHL+Rpyf4V+Jeb4R/dlPFpxkDN7hVWRemScSOJkcfyIdA8RMIFxNYv6hDUArg2iYBzt4iBn7SnBf16yRjV7ivQX/dnABqI7u6xq8Rnc1hYYvEBZqeuaQqbqRFaKjzlRHDvURQ0/8Ph2WHp5LK0as/4ok8OqxF9clXrQmggKaMNodM8SpJGQjBe0sWnTdl0gwDyqkfg==;5:XVBcKohHmwj2hYT7/9TI/ePGmj5w43ufwoWZ13M7m7o2Y9g/vUKqc80jHVX6I7OwiBCIR8DD1TU5uRJ3YtZXUYy1KtyOS7BBYd6NfjXjTbEW1I1Aq79Zo8f1Txv4wolJr209mG+VNoba5GkOZdTMROfINjkZcFT5qvmP9+3yuniK2cn9ERtXBKmVrRztq4YgLMkxnirPW9L/ovBE7H1Dnw==;7:9g4OH8tovH+t3Qsrl21iqHhi1REpR6Nt7mQQ5o7xVMPyvOctRQVlqDd+RS9tshPCMOnMDYh9zjZWwHBukw9tBlVYvIvZ4yTExK3Mk5Rb54Nw/Q9JPjdOgl4Wf5EHpK+GUfhfpBH3IsWvEyyUmruZ1w==
x-ms-office365-filtering-correlation-id: e9b7b770-f94e-4882-43f9-08d674746aa4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5831;
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-microsoft-antispam-prvs: <AM6PR04MB5831CED8C9D13DFFF1CB77C6F3890@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5831;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(14444005)(256004)(8676002)(6436002)(97736004)(5640700003)(54906003)(6486002)(68736007)(316002)(6916009)(575784001)(86362001)(2351001)(105586002)(99286004)(66066001)(186003)(26005)(81166006)(2501003)(476003)(8936002)(446003)(36756003)(11346002)(50226002)(2616005)(7736002)(81156014)(106356001)(1730700003)(52116002)(305945005)(76176011)(6116002)(3846002)(102836004)(2906002)(386003)(6506007)(4326008)(1076003)(25786009)(71190400001)(71200400001)(14454004)(486006)(6512007)(478600001)(5660300001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5831;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 524FiG2pF4hvT/lT6+F/uU2pMFNmVzqIDAqkfV6+AjTOfVMLS6glGWRtODLrXECMCBv73FGB8+y23vfSlpwtwWg/B/KXvByLEEeGkpONbDr38VbBRQsFHUJbZasE1D0MgetLrXKsMxA9u/iLdcdaicuChgFtjRNwzGvXNRIhbaTSch3WwnNWYvEnMnAdEZv96anLVdYW21IX8ZcUPuTw2c/Pz/soi7TM7gX3YEIeLQsaHtICBXkDny4+5rac2rRLv9KCevwXdvAqNO6QV+sUbADNEJFDUOsAvN+UykK0OMNXANnvCK1Q5oxWAyibqgrS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b7b770-f94e-4882-43f9-08d674746aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:45.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cs-gpio feature for LPSPI.
The cs line will be controlled in fsl_lpspi_transfe_one_msg() function.

Still support using the mode without cs-gpio. It depends on if attribute
cs-gpio has been configured in dts file.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 89 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 69635cde0e22..83e15366b739 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -9,6 +9,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -16,7 +17,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_data/spi-imx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -28,6 +31,10 @@
=20
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
=20
+#define LPSPI_CS_ACTIVE		1
+#define LPSPI_CS_INACTIVE	0
+#define LPSPI_CS_DELAY		100
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -91,6 +98,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	bool hascsgpio;
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -106,6 +114,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
=20
 	bool slave_aborted;
+
+	int chipselect[4];
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -178,6 +188,20 @@ static int lpspi_unprepare_xfer_hardware(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static void fsl_lpspi_chipselect(struct spi_device *spi, bool enable)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	enable =3D (!!(spi->mode & SPI_CS_HIGH) =3D=3D enable);
+
+	if (!gpio_is_valid(gpio))
+		return;
+
+	gpio_set_value_cansleep(gpio, enable);
+}
+
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -422,6 +446,25 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	return 0;
 }
=20
+static int fsl_lpspi_setup(struct spi_device *spi)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
+		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
+
+	if (gpio_is_valid(gpio)) {
+		gpio_direction_output(gpio,
+				fsl_lpspi->config.mode & SPI_CS_HIGH ? 0 : 1);
+	}
+
+	fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
 				      struct spi_message *msg)
 {
@@ -430,8 +473,12 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
+	bool keep_cs =3D false;
 	int ret =3D 0;
=20
+	if (fsl_lpspi->hascsgpio)
+		fsl_lpspi_chipselect(spi, LPSPI_CS_ACTIVE);
+
 	msg->status =3D 0;
 	msg->actual_length =3D 0;
=20
@@ -448,10 +495,24 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
roller *controller,
 		if (ret < 0)
 			goto complete;
=20
+		if (fsl_lpspi->hascsgpio && xfer->cs_change) {
+			if (list_is_last(&xfer->transfer_list,
+					 &msg->transfers)) {
+				keep_cs =3D true;
+			} else {
+				fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+				udelay(10);
+				fsl_lpspi_chipselect(spi, LPSPI_CS_ACTIVE);
+			}
+		}
+
 		msg->actual_length +=3D xfer->len;
 	}
=20
 complete:
+	if (fsl_lpspi->hascsgpio && !keep_cs)
+		fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+
 	msg->status =3D ret;
 	spi_finalize_current_message(controller);
=20
@@ -531,10 +592,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *=
fsl_lpspi)
=20
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
+	struct device_node *np =3D pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
+	struct spi_imx_master *lpspi_platform_info =3D
+		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int ret, irq;
+	int i, ret, irq;
 	u32 temp;
=20
 	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
@@ -558,6 +622,29 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
+	fsl_lpspi->hascsgpio =3D false;
+	if (!fsl_lpspi->is_slave) {
+		for (i =3D 0; i < controller->num_chipselect; i++) {
+			int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
+
+			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
+				cs_gpio =3D lpspi_platform_info->chipselect[i];
+
+			fsl_lpspi->chipselect[i] =3D cs_gpio;
+			if (!gpio_is_valid(cs_gpio))
+				continue;
+
+			ret =3D devm_gpio_request(&pdev->dev,
+					fsl_lpspi->chipselect[i], DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "can't get cs gpios\n");
+				goto out_controller_put;
+			}
+			controller->setup =3D fsl_lpspi_setup;
+			fsl_lpspi->hascsgpio =3D true;
+		}
+	}
+
 	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
--=20
2.17.1

