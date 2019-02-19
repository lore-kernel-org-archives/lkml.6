Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62499C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBB921773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NtjOjfu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfBSRNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:13:37 -0500
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:10147
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbfBSRNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zc7zmbJ41bsDKfFfPpsUCTPZ8IdjSC5WxgJLmTHb4s=;
 b=NtjOjfu/KkkN5Xv0Eb4yJvLTupjLR7OW/gOGds0y7xLTM53VwaB1nXnE+KVVKWqmOKQanO+Yf3m3GYtoEslpG97MJf1vXFDi0FE+COFXbdSKzHHOPHcmn4KvxWwIBywU+6ADJ0eDXSGtkwxUK+yuGbwNzjbrFZ+VyD/paPtsZPU=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 DM5PR03MB3067.namprd03.prod.outlook.com (2603:10b6:4:3c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 17:13:32 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:13:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:13:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHDV4u009334
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:13:31 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:13:30 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 2/6] iio: imu: adis16480: Add support for configurable drdy indicator
Date:   Tue, 19 Feb 2019 19:12:14 +0200
Message-ID: <1550596338-24220-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(3190300001)(189003)(199004)(4326008)(305945005)(51416003)(50226002)(7696005)(106466001)(8676002)(76176011)(72206003)(50466002)(7636002)(106002)(246002)(316002)(54906003)(36756003)(478600001)(110136005)(16586007)(8936002)(48376002)(336012)(446003)(426003)(6346003)(2906002)(26005)(77096007)(11346002)(44832011)(186003)(356004)(116002)(126002)(5660300002)(476003)(486006)(2616005)(6666004)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3067;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc5a590-04f1-4b3e-c641-08d6968d932d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR03MB3067;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3067:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3067;20:nIu7DaYUjL4HHHqogYru0qsnGxrqc8yUf8ovaonXjvmWxykTLdYNxXPPE9oXA58a4nMMHCIoef37BEUY+l8x85tkOCXVrxY/bCG4uuM8/JM5uJO5nR6eilOqV488xLk7HSkaOpy+kg80HULlGb19jkApROCYLLxKggUjNnA39fKJEwj4EJ9NbwTOj6DY+IVqRtf562d6gS4U9Og9UfU0k90q+Y5/fnAJ2b31nX/tH7VGwOIzA4iNfeICG1NJKcW5H/EYAupu9UyJNIwi/XKcQ3l8MXrkkODRawcclMr2KQ05Kz4mHhcnq9gs3GOE13JqgHAz6LKKEwoGAEX4g+ZBBodhJJhMO6TEqAQsQTegSymstPKuEr3PKWrYxabuqRIEAeXTgVQlRGaNMn+fZQCfiFoka2swTtAQwvTmTk2oju32dVBy4y6fra5PL+aSQLiK3NH9qYeURI9gxAIOKMA/3AoXIWffNJNqFqTai3DiU6Y8m2aKKZ866T2s30cG2N15
X-Microsoft-Antispam-PRVS: <DM5PR03MB3067BDC4354BE23133C11BC69D7C0@DM5PR03MB3067.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3067;23:zPCK1wIYktHePRGEhTiEzyA3rSUPZLcOyEcqB7Spe?=
 =?us-ascii?Q?jeDNrCFVKjGnVc2SgWuUE6JSoW3Bdw7fjqZvrG/xFon18ZBERI0BeMcJ7E0I?=
 =?us-ascii?Q?xZed5Hr0QpMWvdx6eBjyrcRZNAyt/Lp3Y6azelhfSNqYLLM0gu3iayztyzPC?=
 =?us-ascii?Q?Y3eDimGGrw9QMULSuf5XlYPymn8uWSRdthksKbJvIXkH8+jBTKCz4wcEL5v0?=
 =?us-ascii?Q?CId34mVcJRMWqwxFTiL25ItV0X9kMGpdc+/lt9DgonqvC81pWXqTww1NdXhI?=
 =?us-ascii?Q?iSZ8nh8eKzG7H8QMVhGoIx38XbfDlFPdlSXr5sDh0BtiqiklWJ6frv6But9u?=
 =?us-ascii?Q?PM/AC17/5l4TpL13TB96XSpdGeWb7wcRX6ud+ngyWwD/4uNhaMCBvF+maqhq?=
 =?us-ascii?Q?JBiJ1lykv78Y7VdZiBwZ47BIR1xScJ614zJMkVxHJq5LEc1nKTB8DUAkS2rK?=
 =?us-ascii?Q?FKoggZu0eUzuQ1ppJbbF/x8pSUw9iB9YcQETrbadtCxKZW30LTEj+IRKlsQv?=
 =?us-ascii?Q?Naic0S3Xpp9rLW7yxcTt6k+++82RlyfoPE0oCMIPckwsSmCkieWzHvS1KDwK?=
 =?us-ascii?Q?35HImo4TOfVsxmVU/jE8Kj5ipuQdsKiWj72bcO92VDuLj5wioPXAXFPdqi/8?=
 =?us-ascii?Q?gv/XUEUwXFrbiajp9+/7t5v2fdbsV91tz4kymqbTrfBCkNuyBPpoW7C7Wh1G?=
 =?us-ascii?Q?etiZDb495fb2jA3e/ulWB9TKTCD4Me2Ui8Buo+6H+6Vio46B4jxwWMC4UJIT?=
 =?us-ascii?Q?1ybM0sBsEc8CIl1wD0AX79+i9+67ptb0P4kjcdFMW6Dkb2Ce9AfKuiDL2ClW?=
 =?us-ascii?Q?4/3EVFglfxhwer0UKdzDm0R45gawjL7zOOTxTqPvrlBwfoqqnFhtHPRt+HT4?=
 =?us-ascii?Q?KT65pyoovvZWJEloyutIb05luFM50VFrJVN9IWOuT/FEuL13bfQP0aF6RC94?=
 =?us-ascii?Q?zKkKvPe3RS0Thl1IBg66fhjEM6CkQc26x4cyRIPApazTPCJM1x+a6+aUZnzG?=
 =?us-ascii?Q?EwlgnLGIdPuAok9mVWtijldGJSsTDUw5x1IWp1OzZVeX3SlRTvnDWFUCk4Om?=
 =?us-ascii?Q?ar/WTAi6DVtxiQNlJlqwxB9A1Jb?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uA+eCyBwlqGM0wcCEpezSsWeTWND/62qf/puprafcPMC9itX6Op7onAu1Bgymmb4wawrLxZkDGNne7/46E9heSW5A5RGYyHhGk7Vmgu54Qrcusi/qNOz5tNT+1qurxm18NauAENY0cFYF/xU01Oa3GHS3ShC8MQ/kwet9sWbUh1B+Pdz49GPqz4xmBAyAPcP2SY7eez5dtPu5ETMHFrPe4o4wgJY0yt92AT1R1nagsLvLvBm9ivv1tfdlMYUGCB6g3qMRypMe690DvAn8xSpPZcNuSSrTj1F5jdGaTEZ/qvsSwcLupiA74AC2SoHxOAcUNng1utWYvPzrNre/zkD2PCtOfZ0y74IwFWXg2capC0Bx5sVBTVHFaHmwG31W8WAkpUXh1J/oEG5MRMPr0/F0LL7Cc+YWjrHr70Sa9GuvNA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:13:31.8493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc5a590-04f1-4b3e-c641-08d6968d932d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FNCTIO_CTRL register provides configuration control for each I/O pin
(DIO1, DIO2, DIO3 and DIO4).

This patch adds the option to configure each DIOx pin as data ready
indicator with positive or negative polarity by reading the 'interrupts'
and 'interrupt-names' properties from the devicetree. The
'interrupt-names' property is optional, if it is not specified, then the
factory default DIO2 data ready signal is used.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index d222188..38ba0c1 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -109,6 +110,10 @@
 #define ADIS16480_FIR_COEF_D(x)			ADIS16480_FIR_COEF(0x0B, (x))
 
 /* ADIS16480_REG_FNCTIO_CTRL */
+#define ADIS16480_DRDY_SEL_MSK		GENMASK(1, 0)
+#define ADIS16480_DRDY_SEL(x)		FIELD_PREP(ADIS16480_DRDY_SEL_MSK, x)
+#define ADIS16480_DRDY_POL_MSK		BIT(2)
+#define ADIS16480_DRDY_POL(x)		FIELD_PREP(ADIS16480_DRDY_POL_MSK, x)
 #define ADIS16480_DRDY_EN_MSK		BIT(3)
 #define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
 
@@ -121,12 +126,26 @@ struct adis16480_chip_info {
 	unsigned int accel_max_scale;
 };
 
+enum adis16480_int_pin {
+	ADIS16480_PIN_DIO1,
+	ADIS16480_PIN_DIO2,
+	ADIS16480_PIN_DIO3,
+	ADIS16480_PIN_DIO4
+};
+
 struct adis16480 {
 	const struct adis16480_chip_info *chip_info;
 
 	struct adis adis;
 };
 
+static const char * const adis16480_int_pin_names[4] = {
+	[ADIS16480_PIN_DIO1] = "DIO1",
+	[ADIS16480_PIN_DIO2] = "DIO2",
+	[ADIS16480_PIN_DIO3] = "DIO3",
+	[ADIS16480_PIN_DIO4] = "DIO4",
+};
+
 #ifdef CONFIG_DEBUG_FS
 
 static ssize_t adis16480_show_firmware_revision(struct file *file,
@@ -840,6 +859,59 @@ static const struct adis_data adis16480_data = {
 	.enable_irq = adis16480_enable_irq,
 };
 
+static int adis16480_config_irq_pin(struct device_node *of_node,
+				    struct adis16480 *st)
+{
+	struct irq_data *desc;
+	enum adis16480_int_pin pin;
+	unsigned int irq_type;
+	uint16_t val;
+	int i, irq = 0;
+
+	desc = irq_get_irq_data(st->adis.spi->irq);
+	if (!desc) {
+		dev_err(&st->adis.spi->dev, "Could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+
+	/* Disable data ready */
+	val = ADIS16480_DRDY_EN(0);
+
+	/*
+	 * Get the interrupt from the devicetre by reading the
+	 * interrupt-names property. If it is not specified, use
+	 * the default interrupt on DIO2 pin.
+	 */
+	pin = ADIS16480_PIN_DIO2;
+	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
+		irq = of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
+		if (irq > 0) {
+			pin = i;
+			break;
+		}
+	}
+
+	val |= ADIS16480_DRDY_SEL(pin);
+
+	/*
+	 * Get the interrupt line behaviour. The data ready polarity can be
+	 * configured as positive or negative, corresponding to
+	 * IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING respectively.
+	 */
+	irq_type = irqd_get_trigger_type(desc);
+	if (irq_type == IRQF_TRIGGER_RISING) { /* Default */
+		val |= ADIS16480_DRDY_POL(1);
+	} else if (irq_type == IRQF_TRIGGER_FALLING) {
+		val |= ADIS16480_DRDY_POL(0);
+	} else {
+		dev_err(&st->adis.spi->dev,
+			"Invalid interrupt type 0x%x specified\n", irq_type);
+		return -EINVAL;
+	}
+	/* Write the data ready configuration to the FNCTIO_CTRL register */
+	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
+}
+
 static int adis16480_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -867,6 +939,10 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret =  adis16480_config_irq_pin(spi->dev.of_node, st);
+	if (ret)
+		return ret;
+
 	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
-- 
2.7.4

