Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8EDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F722084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="M5Jl1rD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBUNSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:18:52 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:26351
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfBUNSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC4qCLSqMp5fYwwWpJSc42mfKLO7Qvye4BVVS39Nqck=;
 b=M5Jl1rD/wchmBD4VT4MvEURzv0+R3tdxQKwngpXVOlQnRHgyVKUezlaEqgLzu+8cfCJR5OTbK5XDzz9ZyoQpOJEfT/VfQYJ/aT4YN87Ked33rPf3CDYooqiWO2sJSzDylK5/hZ4cK+3V5IDWNrJLmEQ89cnwsHVD/TqHf+zqHso=
Received: from MWHPR03CA0044.namprd03.prod.outlook.com (2603:10b6:301:3b::33)
 by BN7PR03MB3747.namprd03.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Thu, 21 Feb
 2019 13:17:08 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR03CA0044.outlook.office365.com
 (2603:10b6:301:3b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 21 Feb 2019 13:17:08 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 13:17:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1LDH0VO003392
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 Feb 2019 05:17:00 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:16:59 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/5] iio: imu: adis16480: Add support for configurable drdy indicator
Date:   Thu, 21 Feb 2019 15:15:02 +0200
Message-ID: <1550754906-24640-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
References: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(3190300001)(189003)(199004)(36756003)(26005)(186003)(8676002)(47776003)(77096007)(336012)(16586007)(48376002)(2906002)(7636002)(305945005)(8936002)(316002)(50466002)(4326008)(106466001)(54906003)(110136005)(50226002)(106002)(44832011)(76176011)(51416003)(72206003)(126002)(7696005)(116002)(476003)(486006)(5660300002)(478600001)(246002)(356004)(6666004)(2616005)(11346002)(426003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3747;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696ee9c0-9f0f-476d-66c1-08d697fee14e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN7PR03MB3747;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3747:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3747;20:taVVnXT4JtXMTeFzTSxE71ROKp2qCifJMQ6OEYN2grM/Kj7OzsyI2NcDBVsnsimOTrp6CcEdbdDNMdOxu6v8gQYLX1RZvzS+i+FhenQijTKZumQ4PrsrOi59Ipd0Y7/5sNV1SrC4V6giKW4TLqmHRib659NNj7Wc/7fpdLRE2lVuI/xaZAHwwmNvdJ5e+XAaj/uzdeAqdZVNTB/cZ/eBO9vCfxsGyimEhM05IkDfF1C8VhMhhRCE4fZ+k0KzNreYZgXOYkkYDX2KMT9X+4FpYt3suNjFYG10Y7hp2ZvG+cRSxUqTYCS1ur99iuSTtiMvFOSFmA9F+U1pqzug9dy5RT61v8IoOVLVeoF/nX6XbT/voghh6bthROqT7E/XD1WRbWYMq3ANLAIZcJM99HgmB5gXgWjyb2isKtRZjSPTHTxCPZ6uFNquHDdU9X3a2r8uZAnrw4nqxwJ1oZfVXyNcBiNsRKk+tAmJKvL/oUqg+uVO06wGHCr3KIiREbRmMB8z
X-Microsoft-Antispam-PRVS: <BN7PR03MB37477AB3F19409AE14E6FF259D7E0@BN7PR03MB3747.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3747;23:REV9/eOGcADj8OrhHk4hJul+UYbbHGf7Ukf9ilTnn?=
 =?us-ascii?Q?PRsWRvWrWoIj0L8r4na21LMXtJoBM0wPMGsnJv16JlKmAKfUdXp4sySPmqQt?=
 =?us-ascii?Q?9EnUP25xlfhInf77YHCyXK0scYVv2wEU6ceYEgplHFdrzjRJQ2AdVDA1ef4f?=
 =?us-ascii?Q?T5TEvdwIzyJvMukycjaBxQ9Kz+sFrr0X6yG7LYZ1KPbDDLWqhWVUuRCJEwfU?=
 =?us-ascii?Q?pMlkoA+niCT05OF44rzxyYqZ/7AOk3hBUbxVt8W/N7akwpmVRIpmwPs6lA4O?=
 =?us-ascii?Q?IzItV+VFLNVC5Jg2ceFkdvYbu6iqZrnpBiE6Hx/+g2dbEAReDyWMV1a2MW5k?=
 =?us-ascii?Q?JISiEPfaS86/C/DCHFUqQW8v2evLe+mC4pMX69jxuRBrs4v0CTjh2IJHx2Y9?=
 =?us-ascii?Q?8ltFACbLuXv9t/mNsP+dW19nltw8g7KIqK4OVAN6B/0jv2WmdFNC/ErFVq3W?=
 =?us-ascii?Q?cdiPlblEQ5MvpT+f6gljhbqXnamj9AVVurorlYQEzAmaKRgb07phB2c6GNF6?=
 =?us-ascii?Q?+ULowWXHAOKL+YYKxrR0ITIn0c5Cfhkrf18HOeyeVbb8tRtDDbjscOUdRgco?=
 =?us-ascii?Q?lIzyC4dbRB5srUNlDaPhmB5Sn4KyhZZosOyi6SOaepcZbsP1aG/8AV+XIfsH?=
 =?us-ascii?Q?gTTVenedA1dsLcAuICCo3rmiHJ7vKPjbCUL3VVzznRzPeeF3EEYIwZkUNH17?=
 =?us-ascii?Q?AbXoLLBJnc6dZ+BLbgLCoR7Q29Ddkf02r1cTyuQ0bluD3B6/567eaAMyFjuH?=
 =?us-ascii?Q?EPJ6NMZpcBiP0D64fWSn8Q8M7vrx4X15bVtprHRqMLnu8UOIsz19iJngc72L?=
 =?us-ascii?Q?aoV2BJI/9mqetebA2jXCCfa15Fnh3gJx3vXz+XekrsyqX0gun/0uJj8J+05+?=
 =?us-ascii?Q?HBWC56NVjW/f84EdgbCpVCBls2HDTWxj1F7W5tmZypBfmTYzkswxufxp+QbO?=
 =?us-ascii?Q?pEJQEag/kjoreENCiL8G9FtvyfRxOpnJqrzuIX/SB1zxTOt5L8+G22kB5Msy?=
 =?us-ascii?Q?aXoj0Sd/Z5a/1mRFD+BmtUvEiwt8ETEkCBCt2XOh8hA3RlN2vXgBml4PyMaP?=
 =?us-ascii?Q?TaBOjU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YamX6PEPOiyQAmJLt/9GzQKmjfVrSHCKDA0RNZr9mS1MIh3I1zTMPGtuwFx6FCLN0ZydkJA/mnO21TOkWySRsvPcJQXf10P8UaT1xCtHp6qZxX5GNqglYeokXp9XDTeTQ5NH6yBLc4KCqawsUpo5uYOpe/dND96e6jV7Xrf84nnpPA6+MA1QPNCWay1S9d7YUk/AkraI3tbf3ucYkgSRc/YjGCsdAB3ihJ0CiQoZftHVCBiACSboCuGW15bIVWnaM5AUmPK+q2gtj0QErfJ3vmsVjL3HBARyNKWmxtCuyGd2EsZjGvOmiaxfBwY7vld4psznbOnPGe5e8jv3bVthyJR3tTfx0t+NqAmbR4lUCQgRhbm6oNEL8iqyg1u3jncJQR7RaFD9BCjYvPiemRxkwIY7tn8aMtLmAL6hBMagbeo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 13:17:04.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696ee9c0-9f0f-476d-66c1-08d697fee14e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3747
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

