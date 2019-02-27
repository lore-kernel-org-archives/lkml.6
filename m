Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NPtdGMVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfB0QO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:14:57 -0500
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:11920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728124AbfB0QO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC4qCLSqMp5fYwwWpJSc42mfKLO7Qvye4BVVS39Nqck=;
 b=NPtdGMVFpnV3UTc1oSRFVxqXCWvMONgQ2ZAUMLF7hWAg5nKtzouR54fBxYmx8SekD5qX6yU7oYaRa2ZaKCea4Hw3tMA69JTcZWTlNd/F+5kOeOWHPoegpub7+wDo5X3BbS+g5gwbsf5U07eYU2TNuD4bTvuOMqY+eEmgB2fzQCs=
Received: from BL0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:2d::14)
 by CY4PR03MB3063.namprd03.prod.outlook.com (2603:10b6:910:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.20; Wed, 27 Feb
 2019 16:14:51 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BL0PR03CA0001.outlook.office365.com
 (2603:10b6:208:2d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Wed, 27 Feb 2019 16:14:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:14:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGEnhM021533
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:14:49 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:14:49 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/7] iio: imu: adis16480: Add support for configurable drdy indicator
Date:   Wed, 27 Feb 2019 18:14:22 +0200
Message-ID: <1551284068-4882-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(3190300001)(199004)(189003)(53416004)(246002)(5660300002)(50466002)(48376002)(446003)(336012)(77096007)(7636002)(186003)(26005)(8676002)(2906002)(7696005)(76176011)(51416003)(4326008)(305945005)(54906003)(110136005)(106002)(47776003)(478600001)(356004)(72206003)(6666004)(2616005)(476003)(486006)(44832011)(426003)(50226002)(8936002)(11346002)(116002)(106466001)(16586007)(36756003)(316002)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3063;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07bddd46-256b-481d-9566-08d69cceb35a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR03MB3063;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3063:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3063;20:aHCU/WTRbiSNuH8E4GHjkrPorm7YXj5QLNJ6jFuRgrgNCkcSeYgiH6d0BHhi6VRjdDA5Z3v4Rc6zPejHIkgIOIe0UcEnP068Uh9Td8Pe5BeTbDe5oqFDc2O40cQDxwVBh5xwJh3Bvct5DuAynbM6kFRYHscG2vKuUF+wSQylblQ23zNf/VpirrXmN56bKhFs1okk4kC8vpc/yYAhyMbX8ptWVUks/F5t1wDfIxhd5IqEuswb4O4f4fQ3/0cNX2sVIkevsAHgbHJ5EQbkx46zgATGMFZTYpwzMu9mWZ/oUqwneGPcq3UotkB5HykXGsYpM8QRa2bVn6RRpUZ6X8RfFGMzdxLYlVNHFl08NKLxVzROFgccAP65Zk7E5k7C4LzntRaVT3klRNaKaeQu0a1sN1bwAQUr5PFN/e6oqgvlBpPKTdRboFjJPhRnlMS7D9crx0t+HPYlfzcoHUE7YeIbjvQkyXzLdBxmNhqBgpf8090mIPn5pf3+AVjlZvc0g+Z7
X-Microsoft-Antispam-PRVS: <CY4PR03MB30639A3D820DBD6FB33DFCD89D740@CY4PR03MB3063.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3063;23:DRjeGfJItYmLEvZ/Bui7WInwe5kj3eJtBaGOXahSF?=
 =?us-ascii?Q?rpZFYTtqK8ZmO7ARCxb7L/sUKX42QGS4rwDZ2RLs05ow3Oro0UN7qjRnmWip?=
 =?us-ascii?Q?fT0hki2RgPRTg1WYO5/OxMzK/v75RZgavNB2589eb7+1xxPeOInVqmCi3NWq?=
 =?us-ascii?Q?qeppZtjCzPXA4vrIY2mGiMcoRIc26/48ZR0heKbWPdAia+7D/Gxq/yYpTzkx?=
 =?us-ascii?Q?/3oT1plCq4FnR7BSg+948Kl41FoITbLZ4ov8/wJeHAqXOTK41Ybhlu2T+Y59?=
 =?us-ascii?Q?Pos42I5WR/VpeRusFFNh2MR8W/8qnMql/axC8L7Sp2WatptPRLgECzt70ZTk?=
 =?us-ascii?Q?hA8pv8PExVK8FD4JDw9ZNu2CrYy+v/PhrM0l1nxCkqLjU49FCp0Lf9yJid8Z?=
 =?us-ascii?Q?TwfCbrpApwckqUbdk7RYs/Xf3mTkGKWxqiZFVLe54rDCED9/mOXwSSAq8h/g?=
 =?us-ascii?Q?O+PtexuShA28h1s5uuoZUi1V9QKTzNvth1i1gRqtLCplH1MLpgp5hgbzrmE3?=
 =?us-ascii?Q?diS/nDKgggeRAFaQG88jQH29cFyqR4Wt3AO7DH+P6xGdwmbjqD6KJfpQ1olg?=
 =?us-ascii?Q?vORe2ip2v5qak3t5goehc9M6DfJcQtklRFIYQD7G/QPsEHs7uvfd8H/qceKI?=
 =?us-ascii?Q?7WsTUxrB9t2AZXa2nwop/4YERlc23FF4+wYRPRmrykfEwQI1JobEUDs5aszH?=
 =?us-ascii?Q?wgicgJErIQ3AnpeobG5g2R0MPv6pt/jJ15bkfsHr41jUMwxjPGdUrMtomo2G?=
 =?us-ascii?Q?FX+KyjlQUBsi4h2CR5W/w8NMObkoazrHvGsV+s7hkzTnfPUIQvl86gh8twwO?=
 =?us-ascii?Q?83FNUfFbVKrVpk25iZO4epeVGAAhEPHawDJx98/8ghaZ/fAQX4i17VOb7B6a?=
 =?us-ascii?Q?5OvfVXwNZe3eeGM2s/QDlju4koPx4ER1Q9pHPVuoruqWReLl2urkT6FJaLGb?=
 =?us-ascii?Q?3eVLGsugtRJ+ogRRggEJjy/sey4nqmYBplW8ey6AG8/ymF/henUe06ZJ71Ma?=
 =?us-ascii?Q?yL+zwGe9gAlS2mNOC6eo1eH+JqGSkGJqGZJqS1Gc76dUsTSOIC9JFDxwKw5v?=
 =?us-ascii?Q?aSwLa+UDPlKPh7lVvZVJwcnSfnJ?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /9HOQ1w67p2wHcS22xqboIT2h/BcnSi4ujVegDE0d487g6Wx2//wk7Ob7+Hg+BKB0t3FbVS2zEvPT4o95zKtpLH25yN08Pd2GLyfM+uHdXyfzMazW8Jg5gK16qtPcG41dAY+1t/0KX1LHAGQFvlwIW20sq9Yp+q7HLci1vveY+4dkDGlKwYEuuXmWuPdeeOAmNuB9XwSg1/kKC/NX6fjmBMUi8bxft439r7f2HqqwHD9QgrB0kTzArMEeYmzIoiI/I+0IOitIELVUZy1+HEY5XEz2yJKB30ZHNSsTiLlvcSsolQFAOjq/2k/lGJt/si5R36hzXGLKz/WVRVbenivRw0oBXmwbaF/A5LNEx7NpO2Om8zJpljMeS2ImC9WQo5QZkt6sQuUyZNa/uq/7xCRhtjtPEQ6djduAr2gMxFGIYg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:14:50.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bddd46-256b-481d-9566-08d69cceb35a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3063
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
DIO1 pin is used as default data ready signal.

Although the factory default assigns DIO2 as data ready signal, in the
versions previous this patch, DIO1 pin was used. We should leave this
configuration as is, since some devices might be expecting the interrupt
on the wrong physical pin.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index a27fe20..98a23ac 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -9,6 +9,8 @@
  *
  */
 
+#include <linux/bitfield.h>
+#include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -107,6 +109,14 @@
 #define ADIS16480_FIR_COEF_C(x)			ADIS16480_FIR_COEF(0x09, (x))
 #define ADIS16480_FIR_COEF_D(x)			ADIS16480_FIR_COEF(0x0B, (x))
 
+/* ADIS16480_REG_FNCTIO_CTRL */
+#define ADIS16480_DRDY_SEL_MSK		GENMASK(1, 0)
+#define ADIS16480_DRDY_SEL(x)		FIELD_PREP(ADIS16480_DRDY_SEL_MSK, x)
+#define ADIS16480_DRDY_POL_MSK		BIT(2)
+#define ADIS16480_DRDY_POL(x)		FIELD_PREP(ADIS16480_DRDY_POL_MSK, x)
+#define ADIS16480_DRDY_EN_MSK		BIT(3)
+#define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
+
 struct adis16480_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
@@ -116,12 +126,26 @@ struct adis16480_chip_info {
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
@@ -741,8 +765,17 @@ static int adis16480_stop_device(struct iio_dev *indio_dev)
 
 static int adis16480_enable_irq(struct adis *adis, bool enable)
 {
-	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL,
-		enable ? BIT(3) : 0);
+	uint16_t val;
+	int ret;
+
+	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= ~ADIS16480_DRDY_EN_MSK;
+	val |= ADIS16480_DRDY_EN(enable);
+
+	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
 static int adis16480_initial_setup(struct iio_dev *indio_dev)
@@ -826,6 +859,62 @@ static const struct adis_data adis16480_data = {
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
+	/* Disable data ready since the default after reset is on */
+	val = ADIS16480_DRDY_EN(0);
+
+	/*
+	 * Get the interrupt from the devicetre by reading the interrupt-names
+	 * property. If it is not specified, use DIO1 pin as default.
+	 * According to the datasheet, the factory default assigns DIO2 as data
+	 * ready signal. However, in the previous versions of the driver, DIO1
+	 * pin was used. So, we should leave it as is since some devices might
+	 * be expecting the interrupt on the wrong physical pin.
+	 */
+	pin = ADIS16480_PIN_DIO1;
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
@@ -853,6 +942,10 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	if (ret)
+		return ret;
+
 	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
-- 
2.7.4

