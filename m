Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF820ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="OPil9t6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD9920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJ0Cwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:52:47 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com ([40.107.3.93]:50723
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726815AbeJ0Cwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9lEOxZPKXJrpoVlohnWzrYu8iEh+MhmhexTqvZL7TU=;
 b=OPil9t6IrUrv48oeySkixitIXfj2BajTUumV8QMlVGdwFrOOm/8Jq7aLLcIPHmFBJ3S/S4mBVvu1u/bH9EUOUOco8cQG5E7SQX091VIT6dGGZKPwd+0yWFur4rECBZ8kQuphUL8XsAca0N362OYGb6e+WrPUpm48/H7hec0vTY8=
Received: from HE1P190MB0011.EURP190.PROD.OUTLOOK.COM (10.172.129.136) by
 HE1P190MB0156.EURP190.PROD.OUTLOOK.COM (10.172.131.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 18:14:37 +0000
Received: from HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 ([fe80::8544:bd36:102c:871f]) by HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 ([fe80::8544:bd36:102c:871f%11]) with mapi id 15.20.1273.022; Fri, 26 Oct
 2018 18:14:37 +0000
From:   Carlos Iglesias <carlos.iglesias@emutex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: [PATCH 2/2] iio: pressure: Add support for Honeywell HSC SPI sensors
Thread-Topic: [PATCH 2/2] iio: pressure: Add support for Honeywell HSC SPI
 sensors
Thread-Index: AQHUbVfBw4UELp7oLUyTBRWwtUvMFg==
Date:   Fri, 26 Oct 2018 18:14:37 +0000
Message-ID: <20181026181406.14545-3-carlos.iglesias@emutex.com>
References: <20181026181406.14545-1-carlos.iglesias@emutex.com>
In-Reply-To: <20181026181406.14545-1-carlos.iglesias@emutex.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:3:c9::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=carlos.iglesias@emutex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.51.199.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1P190MB0156;6:WUujHzJV8ecm65hBMGaM/I/xxl6bQNtWsEeTiWb638+N7M442F5m5fio71G/wczQsFrhh/UFHSlcOIZg6nvGOlrfyBscGKL9acgE2Z6yo9QLzQEMDEFP/XsycuGwK4crf3a+63FTCmJE64nkX2ESUOmEb7DtoO+SrkJpNfhvCeSNXdOa2Z3yrOWm+zHOMnH4RTilbqe8rjlebUEMw0PqQwrxMN8gAap5eN7s8UH+KCUZ5Ysa/Q2lfOibqVTH8lasKjRbLpwb1oT9PRqmeozUR+yuJMsW9ii0CMEMUPl0qGqxCyN8jahRSIhsPZ5klSlYcl9YQjayr9z5A/eeihLSKZfse75d1PIreDwKPwb1VyyWp1ZkZhbBz4+rC3SVHoT7TDdDWVs00IZf92yqiqh1TXUI4SQC/phoALTS9Yefh8fFcTqzgiNNVRQv9Ow4mXKm1PY9Bi2g0iehW1Eo9yvJVA==;5:mfP/vKIdJOXYWt3hiw+U8Wms4l9pC1tVFkBsZFI/ma+e62vkyyKZ6hA+ElvWg/lpYN4nCtMDDRFh9yv8DD0u9fyJQhbqU6kj/1+SQ9vUbea00aYiGEoSi5dy82uzd49pwNhqe7tTQgICOPHGf20wFSUyHKNexriYqWF5HfrlBhI=;7:vhlsIHAXiuB8n+NWQ0ClmpL2VjJlzGW9Ab/PdgIeqjETMToUzSyjPJXhNqMb//AMDDd4AfENqw+L/2CtO3jMXE3CeLhXNZDrkMO+hfFRzujTnfqQJzn+yCO8XsnQyJg7E7V8E6p1Btza+fEnWR7ryA==
x-ms-office365-filtering-correlation-id: b2b1ac5f-2cc7-47f8-c23d-08d63b6ee385
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1P190MB0156;
x-ms-traffictypediagnostic: HE1P190MB0156:
x-microsoft-antispam-prvs: <HE1P190MB0156ACADE2622E728997AA0680F00@HE1P190MB0156.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(4982022)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(20161123555045)(201703061421075)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1P190MB0156;BCL:0;PCL:0;RULEID:;SRVR:HE1P190MB0156;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(199004)(189003)(14454004)(53936002)(106356001)(55236004)(105586002)(71190400001)(99286004)(2900100001)(386003)(71200400001)(4744004)(6506007)(8676002)(81156014)(110136005)(81166006)(8936002)(54906003)(25786009)(76176011)(52116002)(4326008)(68736007)(97736004)(5660300001)(508600001)(186003)(2501003)(44832011)(66066001)(6486002)(6436002)(26005)(217873002)(2616005)(11346002)(256004)(14444005)(2906002)(5250100002)(102836004)(486006)(476003)(446003)(6116002)(3846002)(86362001)(575784001)(305945005)(7736002)(36756003)(107886003)(6306002)(1076002)(6512007)(53946003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1P190MB0156;H:HE1P190MB0011.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NDIxiWRuSWvYiHrnux+dS1jt29SbY4K6WvgsbzzeNwxxPuzNkeaTMlxXqoonM16zQhi2g0gRfzjE7H1eUlZyAlQr2UD66yCo2tzt7CskxtCgNZW06/cbHX30cXZuF9hZIwbxE5Gvgd6TaeIP2jOZPRF4l1KT1SN2AzGhvUgPPKFrkXgWNiJ3RI+ZnJ9Pid2DbHVvv+Faj57nkLQxohj2v9qBybEWNjn3uZyEW7z9q0z7GCT0aYF7xk6qTFJIpAV9KnN66LWtPDxmNk1sAe9cB7K6IG06GBfL3vZsVPPlRhtQfRdg4fkw3Gx5y/nTLtXCIxE7msWOVn7a1LZL3Jf/yIR40IpSyKhgfwgIP8d1EeM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b1ac5f-2cc7-47f8-c23d-08d63b6ee385
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 18:14:37.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device driver for the HSC pressure sensors with SPI interface.
In addition to the main measurement -pressure- these sensors also
provide temperature measurement.

Signed-off-by: Carlos Iglesias <carlos.iglesias@emutex.com>
---
 MAINTAINERS                    |   6 +
 drivers/iio/pressure/Kconfig   |  10 +
 drivers/iio/pressure/Makefile  |   2 +
 drivers/iio/pressure/hsc_spi.c | 543 +++++++++++++++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/iio/pressure/hsc_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 556f902b3766..a4af4cbd4b0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6696,6 +6696,12 @@ W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/=
hpfs/index-e.cgi
 S:	Maintained
 F:	fs/hpfs/
=20
+HSC SERIES PRESSURE SENSORS
+M;	Carlos Iglesias <carlos.iglesias@emutex.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
+F:	drivers/iio/pressure/hsc_spi.c
+
 HSI SUBSYSTEM
 M:	Sebastian Reichel <sre@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index eaa7cfcb4c2a..593663d4ffa8 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -227,4 +227,14 @@ config ZPA2326_SPI
 	tristate
 	select REGMAP_SPI
=20
+config HSC_SPI
+	tristate "Honeywell HSC pressure sensors (SPI)"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for the Honeywell HSC range of
+	  pressure sensors (SPI interface only).
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hsc_spi.
+
 endmenu
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index c2058d7b2f93..b1db2116e9f6 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_ZPA2326_SPI) +=3D zpa2326_spi.o
=20
 obj-$(CONFIG_IIO_ST_PRESS_I2C) +=3D st_pressure_i2c.o
 obj-$(CONFIG_IIO_ST_PRESS_SPI) +=3D st_pressure_spi.o
+
+obj-$(CONFIG_HSC_SPI) +=3D hsc_spi.o
diff --git a/drivers/iio/pressure/hsc_spi.c b/drivers/iio/pressure/hsc_spi.=
c
new file mode 100644
index 000000000000..efe45a09da8f
--- /dev/null
+++ b/drivers/iio/pressure/hsc_spi.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * hsc_spi.c - Driver for Honeywell HSC pressure sensors with
+ *             SPI interface
+ *
+ * Copyright (c) 2018 Carlos Iglesias <carlos.iglesias@emutex.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/spi/spi.h>
+
+#define HSC_MAX_SPI_FREQ_HZ	400000
+
+#define HSC_TEMP_BITS		11
+#define HSC_PRESS_BITS		14
+#define HSC_TEMP_MASK		(0x7FF)
+#define HSC_TEMP_SHIFT		(5)
+
+#define HSC_STATUS_S0		BIT(14)
+#define HSC_STATUS_S1		BIT(15)
+#define HSC_STATUS_MSK		((HSC_STATUS_S0) | (HSC_STATUS_S1))
+#define HSC_STATUS_CMD		HSC_STATUS_S0
+#define HSC_STATUS_STALE	HSC_STATUS_S1
+#define HSC_STATUS_DIAG		((HSC_STATUS_S0) | (HSC_STATUS_S1))
+
+static inline int hsc_status_error(struct device dev, int val)
+{
+	int st_check =3D val & HSC_STATUS_MSK;
+
+	if (st_check) {
+		switch (st_check) {
+		case HSC_STATUS_CMD:
+			dev_warn(&dev, "%s:Device in COMMAND MODE\n",
+				 __func__);
+			return -EIO;
+		case HSC_STATUS_STALE:
+			dev_warn(&dev, "%s:Stale data - sampling too fast?\n",
+				 __func__);
+			return -EAGAIN;
+		case HSC_STATUS_DIAG:
+			dev_warn(&dev, "%s:Calibration signature changed\n",
+				 __func__);
+			return -EIO;
+		default:
+			dev_err(&dev, "%s:Invalid status code (%d)\n",
+				__func__, st_check);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+enum hsc_variant {
+	/* Note: Only the absolute range sensors are supported */
+	HSC001BAA, HSC001BAB, HSC001BAC, HSC001BAF,
+	HSC1_6BAA, HSC1_6BAB, HSC1_6BAC, HSC1_6BAF,
+	HSC2_5BAA, HSC2_5BAB, HSC2_5BAC, HSC2_5BAF,
+	HSC004BAA, HSC004BAB, HSC004BAC, HSC004BAF,
+	HSC006BAA, HSC006BAB, HSC006BAC, HSC006BAF,
+	HSC010BAA, HSC010BAB, HSC010BAC, HSC010BAF,
+
+	HSC100KAA, HSC100KAB, HSC100KAC, HSC100KAF,
+	HSC160KAA, HSC160KAB, HSC160KAC, HSC160KAF,
+	HSC250KAA, HSC250KAB, HSC250KAC, HSC250KAF,
+	HSC400KAA, HSC400KAB, HSC400KAC, HSC400KAF,
+	HSC600KAA, HSC600KAB, HSC600KAC, HSC600KAF,
+	HSC001GAA, HSC001GAB, HSC001GAC, HSC001GAF,
+
+	HSC015PAA, HSC015PAB, HSC015PAC, HSC015PAF,
+	HSC030PAA, HSC030PAB, HSC030PAC, HSC030PAF,
+	HSC060PAA, HSC060PAB, HSC060PAC, HSC060PAF,
+	HSC100PAA, HSC100PAB, HSC100PAC, HSC100PAF,
+	HSC150PAA, HSC150PAB, HSC150PAC, HSC150PAF,
+};
+
+enum hsc_meas_channel {
+	HSC_CH_PRESSURE,
+	HSC_CH_TEMPERATURE
+};
+
+struct hsc_config {
+	int pmin;	/* Lower pressure limit */
+	int pmax;	/* Upper pressure limit */
+	int rmin;	/* Lower transfer function limit (%) */
+	int rmax;	/* Upper transfer function limit (%) */
+	int knum;	/* Pressure kPa conversion factor (numerator) */
+	int kden;	/* Pressure kPa conversion factor /denominator) */
+};
+
+struct hsc_fract_val {
+	int num;	/* numerator */
+	int den;	/* denominator */
+};
+
+struct hsc_state {
+	struct device *dev;
+	struct spi_device *spi_dev;
+	struct spi_transfer spi_xfer;
+	struct spi_message spi_msg;
+	__be16 rx_buf[2];
+
+	/* Model-dependent values */
+	struct hsc_fract_val scale;
+	struct hsc_fract_val offset;
+};
+
+#define HSC_CONFIG(_pmin, _pmax, _rmin, _rmax, _knum, _kden) {	\
+		.pmin =3D (_pmin),				\
+		.pmax =3D (_pmax),				\
+		.rmin =3D (_rmin),				\
+		.rmax =3D (_rmax),				\
+		.knum =3D (_knum),				\
+		.kden =3D (_kden),				\
+	}
+
+static struct hsc_config hsc_cfg[] =3D {
+	/* Absolute range, mbar */
+	[HSC001BAA] =3D HSC_CONFIG(0, 1000, 10, 90, 1, 10),
+	[HSC001BAB] =3D HSC_CONFIG(0, 1000, 5, 95, 1, 10),
+	[HSC001BAC] =3D HSC_CONFIG(0, 1000, 5, 85, 1, 10),
+	[HSC001BAF] =3D HSC_CONFIG(0, 1000, 4, 94, 1, 10),
+	[HSC1_6BAA] =3D HSC_CONFIG(0, 1600, 10, 90, 1, 10),
+	[HSC1_6BAB] =3D HSC_CONFIG(0, 1600, 5, 95, 1, 10),
+	[HSC1_6BAC] =3D HSC_CONFIG(0, 1600, 5, 85, 1, 10),
+	[HSC1_6BAF] =3D HSC_CONFIG(0, 1600, 4, 94, 1, 10),
+	[HSC2_5BAA] =3D HSC_CONFIG(0, 2500, 10, 90, 1, 10),
+	[HSC2_5BAB] =3D HSC_CONFIG(0, 2500, 5, 95, 1, 10),
+	[HSC2_5BAC] =3D HSC_CONFIG(0, 2500, 5, 85, 1, 10),
+	[HSC2_5BAF] =3D HSC_CONFIG(0, 2500, 4, 94, 1, 10),
+	[HSC004BAA] =3D HSC_CONFIG(0, 4000, 10, 90, 1, 10),
+	[HSC004BAB] =3D HSC_CONFIG(0, 4000, 5, 95, 1, 10),
+	[HSC004BAC] =3D HSC_CONFIG(0, 4000, 5, 85, 1, 10),
+	[HSC004BAF] =3D HSC_CONFIG(0, 4000, 4, 94, 1, 10),
+	[HSC006BAA] =3D HSC_CONFIG(0, 6000, 10, 90, 1, 10),
+	[HSC006BAB] =3D HSC_CONFIG(0, 6000, 5, 95, 1, 10),
+	[HSC006BAC] =3D HSC_CONFIG(0, 6000, 5, 85, 1, 10),
+	[HSC006BAF] =3D HSC_CONFIG(0, 6000, 4, 94, 1, 10),
+	[HSC010BAA] =3D HSC_CONFIG(0, 10000, 10, 90, 1, 10),
+	[HSC010BAB] =3D HSC_CONFIG(0, 10000, 5, 95, 1, 10),
+	[HSC010BAC] =3D HSC_CONFIG(0, 10000, 5, 85, 1, 10),
+	[HSC010BAF] =3D HSC_CONFIG(0, 10000, 4, 94, 1, 10),
+	/* Absolute range, kPa */
+	[HSC100KAA] =3D HSC_CONFIG(0, 100, 10, 90, 1, 1),
+	[HSC100KAB] =3D HSC_CONFIG(0, 100, 5, 95, 1, 1),
+	[HSC100KAC] =3D HSC_CONFIG(0, 100, 5, 85, 1, 1),
+	[HSC100KAF] =3D HSC_CONFIG(0, 100, 4, 94, 1, 1),
+	[HSC160KAA] =3D HSC_CONFIG(0, 160, 10, 90, 1, 1),
+	[HSC160KAB] =3D HSC_CONFIG(0, 160, 5, 95, 1, 1),
+	[HSC160KAC] =3D HSC_CONFIG(0, 160, 5, 85, 1, 1),
+	[HSC160KAF] =3D HSC_CONFIG(0, 160, 4, 94, 1, 1),
+	[HSC250KAA] =3D HSC_CONFIG(0, 250, 10, 90, 1, 1),
+	[HSC250KAB] =3D HSC_CONFIG(0, 250, 5, 95, 1, 1),
+	[HSC250KAC] =3D HSC_CONFIG(0, 250, 5, 85, 1, 1),
+	[HSC250KAF] =3D HSC_CONFIG(0, 250, 4, 94, 1, 1),
+	[HSC400KAA] =3D HSC_CONFIG(0, 400, 10, 90, 1, 1),
+	[HSC400KAB] =3D HSC_CONFIG(0, 400, 5, 95, 1, 1),
+	[HSC400KAC] =3D HSC_CONFIG(0, 400, 5, 85, 1, 1),
+	[HSC400KAF] =3D HSC_CONFIG(0, 400, 4, 94, 1, 1),
+	[HSC600KAA] =3D HSC_CONFIG(0, 600, 10, 90, 1, 1),
+	[HSC600KAB] =3D HSC_CONFIG(0, 600, 5, 95, 1, 1),
+	[HSC600KAC] =3D HSC_CONFIG(0, 600, 5, 85, 1, 1),
+	[HSC600KAF] =3D HSC_CONFIG(0, 600, 4, 94, 1, 1),
+	[HSC001GAA] =3D HSC_CONFIG(0, 1000, 10, 90, 1, 1),
+	[HSC001GAB] =3D HSC_CONFIG(0, 1000, 5, 95, 1, 1),
+	[HSC001GAC] =3D HSC_CONFIG(0, 1000, 5, 85, 1, 1),
+	[HSC001GAF] =3D HSC_CONFIG(0, 1000, 4, 94, 1, 1),
+	/* Absolute range, psi */
+	[HSC015PAA] =3D HSC_CONFIG(0, 15, 10, 90, 6895, 1000),
+	[HSC015PAB] =3D HSC_CONFIG(0, 15, 5, 95, 6895, 1000),
+	[HSC015PAC] =3D HSC_CONFIG(0, 15, 5, 85, 6895, 1000),
+	[HSC015PAF] =3D HSC_CONFIG(0, 15, 4, 94, 6895, 1000),
+	[HSC030PAA] =3D HSC_CONFIG(0, 30, 10, 90, 6895, 1000),
+	[HSC030PAB] =3D HSC_CONFIG(0, 30, 5, 95, 6895, 1000),
+	[HSC030PAC] =3D HSC_CONFIG(0, 30, 5, 85, 6895, 1000),
+	[HSC030PAF] =3D HSC_CONFIG(0, 30, 4, 94, 6895, 1000),
+	[HSC060PAA] =3D HSC_CONFIG(0, 60, 10, 90, 6895, 1000),
+	[HSC060PAB] =3D HSC_CONFIG(0, 60, 5, 95, 6895, 1000),
+	[HSC060PAC] =3D HSC_CONFIG(0, 60, 5, 85, 6895, 1000),
+	[HSC060PAF] =3D HSC_CONFIG(0, 60, 4, 94, 6895, 1000),
+	[HSC100PAA] =3D HSC_CONFIG(0, 100, 10, 90, 6895, 1000),
+	[HSC100PAB] =3D HSC_CONFIG(0, 100, 5, 95, 6895, 1000),
+	[HSC100PAC] =3D HSC_CONFIG(0, 100, 5, 85, 6895, 1000),
+	[HSC100PAF] =3D HSC_CONFIG(0, 100, 4, 94, 6895, 1000),
+	[HSC150PAA] =3D HSC_CONFIG(0, 150, 10, 90, 6895, 1000),
+	[HSC150PAB] =3D HSC_CONFIG(0, 150, 5, 95, 6895, 1000),
+	[HSC150PAC] =3D HSC_CONFIG(0, 150, 5, 85, 6895, 1000),
+	[HSC150PAF] =3D HSC_CONFIG(0, 150, 4, 94, 6895, 1000),
+};
+
+static const struct iio_chan_spec hsc_channels[] =3D {
+	{
+		.type =3D IIO_PRESSURE,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel =3D HSC_CH_PRESSURE,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D HSC_PRESS_BITS,
+			.storagebits =3D 16,
+			.shift =3D 0,
+			.endianness =3D IIO_BE,
+		}
+	},
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel =3D HSC_CH_TEMPERATURE,
+		.scan_type =3D {
+			.sign =3D 'u',
+			.realbits =3D HSC_TEMP_BITS,
+			.storagebits =3D 16,
+			.shift =3D HSC_TEMP_SHIFT,
+			.endianness =3D IIO_BE,
+		}
+	}
+};
+
+static int hsc_get_pressure(struct hsc_state *state)
+{
+	int ret =3D 0;
+	int error;
+
+	state->spi_xfer.len =3D 2;
+	ret =3D spi_sync(state->spi_dev, &state->spi_msg);
+	if (ret)
+		return ret;
+
+	ret =3D be16_to_cpu(state->rx_buf[0]);
+
+	error =3D hsc_status_error(state->spi_dev->dev, ret);
+	if (error)
+		return error;
+
+	return ret;
+}
+
+static int hsc_get_temperature(struct hsc_state *state)
+{
+	int ret;
+	int error;
+
+	state->spi_xfer.len =3D 4;
+	ret =3D spi_sync(state->spi_dev, &state->spi_msg);
+	if (ret)
+		return ret;
+
+	ret =3D be16_to_cpu(state->rx_buf[0]);
+	error =3D hsc_status_error(state->spi_dev->dev, ret);
+	if (error)
+		return error;
+
+	ret =3D be16_to_cpu(state->rx_buf[1]);
+	ret =3D (ret >> HSC_TEMP_SHIFT) & HSC_TEMP_MASK;
+
+	return ret;
+}
+
+static int hsc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct hsc_state *state =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->channel) {
+		case HSC_CH_PRESSURE:
+			ret =3D hsc_get_pressure(state);
+			if (ret < 0)
+				break;
+			*val =3D ret;
+			ret =3D IIO_VAL_INT;
+			break;
+		case HSC_CH_TEMPERATURE:
+			ret =3D hsc_get_temperature(state);
+			if (ret < 0)
+				break;
+			*val =3D ret;
+			ret =3D IIO_VAL_INT;
+			break;
+		default:
+			ret =3D -EINVAL;
+			dev_err(state->dev,
+				"%s - IIO_CHAN_INFO_RAW-bad channel (%d)\n",
+				__func__, chan->channel);
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->channel) {
+		case HSC_CH_PRESSURE:
+			*val =3D state->offset.num;
+			*val2 =3D state->offset.den;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		case HSC_CH_TEMPERATURE:
+			*val =3D BIT(HSC_TEMP_BITS) - 1;
+			*val2 =3D -200 / 50;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		default:
+			dev_err(state->dev,
+				"%s - IIO_CHAN_INFO_OFFSET-bad channel (%d)\n",
+				__func__, chan->channel);
+			ret =3D -EINVAL;
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case HSC_CH_PRESSURE:		/* output unit is kPa */
+			*val =3D state->scale.num;
+			*val2 =3D state->scale.den;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		case HSC_CH_TEMPERATURE:  /* output unit is milli Celsius */
+			*val =3D 200 * 1000;
+			*val2 =3D BIT(HSC_TEMP_BITS) - 1;
+			ret =3D IIO_VAL_FRACTIONAL;
+			break;
+		default:
+			dev_err(state->dev,
+				"%s - IIO_CHAN_INFO_SCALE-bad channel (%d)\n",
+				__func__, chan->channel);
+			ret =3D -EINVAL;
+			break;
+		}
+		break;
+	default:
+		dev_err(state->dev, "%s - mask =3D %ld (INVALID)\n",
+			__func__, mask);
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info hsc_info =3D {
+	.read_raw =3D hsc_read_raw,
+};
+
+static void hsc_init_device(struct iio_dev *indio_dev)
+{
+	struct hsc_state *state =3D iio_priv(indio_dev);
+	const struct hsc_config *cfg =3D of_device_get_match_data(state->dev);
+
+	/* Pressure offset value */
+	state->offset.num =3D BIT(HSC_PRESS_BITS) *
+			    (cfg->pmin * cfg->rmax - cfg->pmax * cfg->rmin);
+	state->offset.den =3D 100 * (cfg->pmax - cfg->pmin);
+
+	/* Pressure scale value */
+	state->scale.num =3D 100 * cfg->knum * (cfg->pmax - cfg->pmin);
+	state->scale.den =3D BIT(HSC_PRESS_BITS) *
+			   cfg->kden * (cfg->rmax - cfg->rmin);
+}
+
+static int hsc_spi_probe(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct hsc_state *state;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (spi->max_speed_hz > HSC_MAX_SPI_FREQ_HZ) {
+		dev_warn(dev, "SPI CLK, %d Hz exceeds %d Hz - changed to max\n",
+			spi->max_speed_hz,
+			HSC_MAX_SPI_FREQ_HZ);
+		spi->max_speed_hz =3D HSC_MAX_SPI_FREQ_HZ;
+	}
+
+	spi->bits_per_word =3D 8;
+	spi->mode =3D SPI_MODE_0;
+
+	ret =3D spi_setup(spi);
+	if (ret < 0) {
+		dev_err(dev, "%s - Error in spi_setup()\n", __func__);
+		return ret;
+	}
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev) {
+		dev_err(dev, "%s - Error allocating iio_device\n", __func__);
+		return -ENOMEM;
+	}
+
+	state =3D iio_priv(indio_dev);
+	spi_set_drvdata(spi, state);
+	state->spi_dev =3D spi;
+	state->dev =3D dev;
+
+	indio_dev->dev.parent =3D dev;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &hsc_info;
+	indio_dev->channels =3D hsc_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(hsc_channels);
+
+	state->spi_xfer.rx_buf =3D &state->rx_buf[0];
+	state->spi_xfer.tx_buf =3D NULL;
+	state->spi_xfer.cs_change =3D 0;
+	spi_message_init(&state->spi_msg);
+	spi_message_add_tail(&state->spi_xfer, &state->spi_msg);
+
+	hsc_init_device(indio_dev);
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret < 0)
+		dev_err(dev, "iio_device_register failed: %d\n", ret);
+
+	dev_dbg(dev, "%s - scale =3D %d/%d, offset =3D %d/%d\n", __func__,
+		state->scale.num, state->scale.den,
+		state->offset.num, state->offset.den);
+
+	return ret;
+}
+
+static int hsc_spi_remove(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id hsc_of_match[] =3D {
+	{ .compatible =3D "honeywell,hsc001baa", .data =3D &hsc_cfg[HSC001BAA] },
+	{ .compatible =3D "honeywell,hsc001bab", .data =3D &hsc_cfg[HSC001BAB] },
+	{ .compatible =3D "honeywell,hsc001bac", .data =3D &hsc_cfg[HSC001BAC] },
+	{ .compatible =3D "honeywell,hsc001baf", .data =3D &hsc_cfg[HSC001BAF] },
+
+	{ .compatible =3D "honeywell,hsc1_6baa", .data =3D &hsc_cfg[HSC1_6BAA] },
+	{ .compatible =3D "honeywell,hsc1_6bab", .data =3D &hsc_cfg[HSC1_6BAB] },
+	{ .compatible =3D "honeywell,hsc1_6bac", .data =3D &hsc_cfg[HSC1_6BAC] },
+	{ .compatible =3D "honeywell,hsc1_6baf", .data =3D &hsc_cfg[HSC1_6BAF] },
+
+	{ .compatible =3D "honeywell,hsc2_5baa", .data =3D &hsc_cfg[HSC2_5BAA] },
+	{ .compatible =3D "honeywell,hsc2_5bab", .data =3D &hsc_cfg[HSC2_5BAB] },
+	{ .compatible =3D "honeywell,hsc2_5bac", .data =3D &hsc_cfg[HSC2_5BAC] },
+	{ .compatible =3D "honeywell,hsc2_5baf", .data =3D &hsc_cfg[HSC2_5BAF] },
+
+	{ .compatible =3D "honeywell,hsc004baa", .data =3D &hsc_cfg[HSC004BAA] },
+	{ .compatible =3D "honeywell,hsc004bab", .data =3D &hsc_cfg[HSC004BAB] },
+	{ .compatible =3D "honeywell,hsc004bac", .data =3D &hsc_cfg[HSC004BAC] },
+	{ .compatible =3D "honeywell,hsc004baf", .data =3D &hsc_cfg[HSC004BAF] },
+
+	{ .compatible =3D "honeywell,hsc006baa", .data =3D &hsc_cfg[HSC006BAA] },
+	{ .compatible =3D "honeywell,hsc006bab", .data =3D &hsc_cfg[HSC006BAB] },
+	{ .compatible =3D "honeywell,hsc006bac", .data =3D &hsc_cfg[HSC006BAC] },
+	{ .compatible =3D "honeywell,hsc006baf", .data =3D &hsc_cfg[HSC006BAF] },
+
+	{ .compatible =3D "honeywell,hsc010baa", .data =3D &hsc_cfg[HSC010BAA] },
+	{ .compatible =3D "honeywell,hsc010bab", .data =3D &hsc_cfg[HSC010BAB] },
+	{ .compatible =3D "honeywell,hsc010bac", .data =3D &hsc_cfg[HSC010BAC] },
+	{ .compatible =3D "honeywell,hsc010baf", .data =3D &hsc_cfg[HSC010BAF] },
+
+	{ .compatible =3D "honeywell,hsc100kaa", .data =3D &hsc_cfg[HSC100KAA] },
+	{ .compatible =3D "honeywell,hsc100kab", .data =3D &hsc_cfg[HSC100KAB] },
+	{ .compatible =3D "honeywell,hsc100kac", .data =3D &hsc_cfg[HSC100KAC] },
+	{ .compatible =3D "honeywell,hsc100kaf", .data =3D &hsc_cfg[HSC100KAF] },
+
+	{ .compatible =3D "honeywell,hsc160kaa", .data =3D &hsc_cfg[HSC160KAA] },
+	{ .compatible =3D "honeywell,hsc160kab", .data =3D &hsc_cfg[HSC160KAB] },
+	{ .compatible =3D "honeywell,hsc160kac", .data =3D &hsc_cfg[HSC160KAC] },
+	{ .compatible =3D "honeywell,hsc160kaf", .data =3D &hsc_cfg[HSC160KAF] },
+
+	{ .compatible =3D "honeywell,hsc250kaa", .data =3D &hsc_cfg[HSC250KAA] },
+	{ .compatible =3D "honeywell,hsc250kab", .data =3D &hsc_cfg[HSC250KAB] },
+	{ .compatible =3D "honeywell,hsc250kac", .data =3D &hsc_cfg[HSC250KAC] },
+	{ .compatible =3D "honeywell,hsc250kaf", .data =3D &hsc_cfg[HSC250KAF] },
+
+	{ .compatible =3D "honeywell,hsc400kaa", .data =3D &hsc_cfg[HSC400KAA] },
+	{ .compatible =3D "honeywell,hsc400kab", .data =3D &hsc_cfg[HSC400KAB] },
+	{ .compatible =3D "honeywell,hsc400kac", .data =3D &hsc_cfg[HSC400KAC] },
+	{ .compatible =3D "honeywell,hsc400kaf", .data =3D &hsc_cfg[HSC400KAF] },
+
+	{ .compatible =3D "honeywell,hsc600kaa", .data =3D &hsc_cfg[HSC600KAA] },
+	{ .compatible =3D "honeywell,hsc600kab", .data =3D &hsc_cfg[HSC600KAB] },
+	{ .compatible =3D "honeywell,hsc600kac", .data =3D &hsc_cfg[HSC600KAC] },
+	{ .compatible =3D "honeywell,hsc600kaf", .data =3D &hsc_cfg[HSC600KAF] },
+
+	{ .compatible =3D "honeywell,hsc001gaa", .data =3D &hsc_cfg[HSC001GAA] },
+	{ .compatible =3D "honeywell,hsc001gab", .data =3D &hsc_cfg[HSC001GAB] },
+	{ .compatible =3D "honeywell,hsc001gac", .data =3D &hsc_cfg[HSC001GAC] },
+	{ .compatible =3D "honeywell,hsc001gaf", .data =3D &hsc_cfg[HSC001GAF] },
+
+	{ .compatible =3D "honeywell,hsc015paa", .data =3D &hsc_cfg[HSC015PAA] },
+	{ .compatible =3D "honeywell,hsc015pab", .data =3D &hsc_cfg[HSC015PAB] },
+	{ .compatible =3D "honeywell,hsc015pac", .data =3D &hsc_cfg[HSC015PAC] },
+	{ .compatible =3D "honeywell,hsc015paf", .data =3D &hsc_cfg[HSC015PAF] },
+
+	{ .compatible =3D "honeywell,hsc030paa", .data =3D &hsc_cfg[HSC030PAA] },
+	{ .compatible =3D "honeywell,hsc030pab", .data =3D &hsc_cfg[HSC030PAB] },
+	{ .compatible =3D "honeywell,hsc030pac", .data =3D &hsc_cfg[HSC030PAC] },
+	{ .compatible =3D "honeywell,hsc030paf", .data =3D &hsc_cfg[HSC030PAF] },
+
+	{ .compatible =3D "honeywell,hsc060paa", .data =3D &hsc_cfg[HSC060PAA] },
+	{ .compatible =3D "honeywell,hsc060pab", .data =3D &hsc_cfg[HSC060PAB] },
+	{ .compatible =3D "honeywell,hsc060pac", .data =3D &hsc_cfg[HSC060PAC] },
+	{ .compatible =3D "honeywell,hsc060paf", .data =3D &hsc_cfg[HSC060PAF] },
+
+	{ .compatible =3D "honeywell,hsc100paa", .data =3D &hsc_cfg[HSC100PAA] },
+	{ .compatible =3D "honeywell,hsc100pab", .data =3D &hsc_cfg[HSC100PAB] },
+	{ .compatible =3D "honeywell,hsc100pac", .data =3D &hsc_cfg[HSC100PAC] },
+	{ .compatible =3D "honeywell,hsc100paf", .data =3D &hsc_cfg[HSC100PAF] },
+
+	{ .compatible =3D "honeywell,hsc150paa", .data =3D &hsc_cfg[HSC150PAA] },
+	{ .compatible =3D "honeywell,hsc150pab", .data =3D &hsc_cfg[HSC150PAB] },
+	{ .compatible =3D "honeywell,hsc150pac", .data =3D &hsc_cfg[HSC150PAC] },
+	{ .compatible =3D "honeywell,hsc150paf", .data =3D &hsc_cfg[HSC150PAF] },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, hsc_of_match);
+
+static struct spi_driver hsc_spi_driver =3D {
+	.probe =3D hsc_spi_probe,
+	.remove =3D hsc_spi_remove,
+	.driver =3D {
+		.name =3D "hsc_spi_pressure_sensor",
+		.of_match_table =3D hsc_of_match,
+	},
+};
+
+module_spi_driver(hsc_spi_driver);
+
+MODULE_AUTHOR("Carlos Iglesias <carlosiglesias@emutex.com>");
+MODULE_DESCRIPTION("Honeywell HSC SPI pressure sensor driver");
+MODULE_LICENSE("GPL v2");
--=20
2.19.1

