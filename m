Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC6C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E6121850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NYsx2Tgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfB0QQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:16:57 -0500
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:39526
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfB0QQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EixBkaDR6khW1PYA7c2Ukt0kRKUqps0NiaCAkZSEsdI=;
 b=NYsx2TguMBtJOcqfG45q0bWQENH8fenFR3huPINoE2Kjskmt7acr8Vi6hmLJCtAP2HBejexDB+NYcTmOaXieDGTFFpNzBe2jc9zrTLru0qN3T9K/rLdNI40+MzA8ntw5Zs/8bJB4OgxyriuV79MmoQltXFYO42Mm9+K1nyhH0Ao=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 BN7PR03MB3507.namprd03.prod.outlook.com (2603:10b6:406:c2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 16:16:53 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.18 via Frontend
 Transport; Wed, 27 Feb 2019 16:16:53 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:16:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGGqeU022089
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:16:52 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:16:51 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 6/7] iio: imu: adis16480: Add support for ADIS1649x family of devices
Date:   Wed, 27 Feb 2019 18:14:27 +0200
Message-ID: <1551284068-4882-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(3190300001)(189003)(199004)(47776003)(11346002)(2906002)(336012)(8676002)(51416003)(106466001)(50226002)(54906003)(7696005)(50466002)(110136005)(48376002)(356004)(446003)(6666004)(5660300002)(106002)(8936002)(6306002)(16586007)(316002)(426003)(36756003)(72206003)(186003)(305945005)(966005)(26005)(77096007)(478600001)(53416004)(246002)(2616005)(476003)(76176011)(126002)(7636002)(486006)(4326008)(44832011)(116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3507;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38cd49f5-bc1c-4432-99d7-08d69ccefc8d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN7PR03MB3507;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3507:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3507;20:9jlPDNFRO22hktd5QGz7SrGXXtK7Fcw67Ly6lArt3HVLfaf6xDOkY1HWUXPN6/r+tWJ2MNMP3RNRYP6asu6bly6sg8iLiJ3XxIG/7UTiJpN5Lfl4vjkuxbR6e/pOibw9ONiLpMdV6HrG9vFuFXw9o/j7OXObfOYqBBzjA7fqRbbVQLBG5c1jYADEss5ZuQvthqECoZhDEy0UVFAy9XDB8rcuRCc6PiCbpsEJWmjxr7x5MfZIA8Z3DNCIosLGLC+wdds8ciCBIoyetHmhkky/FsdP3q0+RLLFcOXCmpKKWiOqmUv96mo4AW4DH7Hjh8gXc/+jcsq0TBYLN686/p1Bfi3O29CPshI+n/NiZ44oP/2gp34ci2C33210QNVhAyMO3XFpOCIgFN0wtyCfGtKLXr7xMgGb3XCr3kJPNwSJr9N8NA2xDQKmuPeyXBmoKh3+SEjMFfKfZHfKp/Ko7wRrOTmU/TRL0UyaTAhF0kWoRNHrEcvdNFWkbXf248MMNG1r
X-Microsoft-Antispam-PRVS: <BN7PR03MB350766B10986C5E858673AD19D740@BN7PR03MB3507.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3507;23:Az694zXv/oplg9BvDtLIf7plVzq5ohGSWZ+ZFuP22?=
 =?us-ascii?Q?0dAcyA4AsjL3MWuD56zKQluNw+G2iIoIO15JQY/n/Rb/NggZuFOc2g84iBWE?=
 =?us-ascii?Q?GSW8c05djZ9GCxZdGw/ixqa9/e3YJ3d+/Zz6TpmoE4MdFl3fJnpwD+oV/L54?=
 =?us-ascii?Q?KNb3K/l9v6clCcVWI+zHvzGl2jEaR3R3kW5yHGGY17eEz0992mcw0wbobSr5?=
 =?us-ascii?Q?SQue73LdECtFhGD7U2EJVfr2HuPRnjBqfALH4kqGmtqn4STee2q75OXX2b96?=
 =?us-ascii?Q?I2bCYxDY3t/Zv4nCCZUoUf+gk+J41mz+bEmDsSw8cJLF66z8auQNabnkfVvO?=
 =?us-ascii?Q?F2p+7TqkwfQXvir/Jqkd8D9oQZIxOKrnsitE37yXD3VHys8AZo8LGndEXDAz?=
 =?us-ascii?Q?Aqe65llAaArcALYcexVGyDUfQSad7MAg8Z/vniGbziFO1XMUGk9F7Foi1C5Q?=
 =?us-ascii?Q?0Gp2p40HvBiikh8/Odbu6saYY7NVhNDjPBhtHoht9niRIVUkrYwZVeufPzFk?=
 =?us-ascii?Q?1FcES46PjR93BXwlSi4ByxMx9hLIftxvtAnB6orP2xet66VnojewW6lLdmsf?=
 =?us-ascii?Q?o/GxXJrGn/WbYdO3l1hp3LrvkGAzansVyG1VMVfnuf1IQghTvNwsCkYF8PG7?=
 =?us-ascii?Q?1i5CzxFfgCKiqZ30E20I4Bd275licw623uVtRvphLTP27oBOqf4nUaEsvX4g?=
 =?us-ascii?Q?0fQJJpvY+0FqlXrt6hBPAXGMdaXJGMQljLIFElgN7uiVBEOVFtgI0z0EH3bU?=
 =?us-ascii?Q?zVbqX0Rh0eKsfXjpuPr8vxim/brmnFg0XT5TalzXqnrxJCgwv/aR0w101D+Q?=
 =?us-ascii?Q?2eeY9nRtcxDnoB8sDaLW7PQJrJuOt/W88weA+Asm41RYkK5TmlJW44fzegya?=
 =?us-ascii?Q?W+P/oF7qbMc65g3QVNjzoO9oGrzIidPlgbvfsArv+ZSPQ62kZ0dl+ncZMPxH?=
 =?us-ascii?Q?qSKLpXGfPAz7KQEtcir60HWM3VH6STjdwVsfF82tosywiiTPnu3wpM2J5yq9?=
 =?us-ascii?Q?dgP41mRVEbK33l3AuhJgcZZrRlXZv06ncV6mgC26y+0nY82Vknb4Ie/Wg4VM?=
 =?us-ascii?Q?kEvdC0nHxYquB31/BNnYpNh4+4VnWXTTNXiEhvhKu3M1DhL4GWj6zPifLiQp?=
 =?us-ascii?Q?kvsrODsYxI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mT1Q2er1mIsPNufGZDwkyz3GTklb7Ann++TDRpVSL5ALCIqIOrHWJ5UBt7CwhLwuq1DsXL7IVaexMsBt4ic5uGl19J94j3KquHFIJkwk3Ke2w1+RuCZS0AQEtlmB537Gz88sa1PP0HogqttY+aB72ob5GhDbyCnzkVaT5VxHkNEhHZ9attWOtbtP+pCLeYVk/YXknd629s8goZB75yX9gRZvqb2XCjADEfr8EaU8ZXCINbsTw/2lvkQ+t/3220evUYBLpWpH8RhoaOKBsM1IuPXmFNiW5veQrrAxSCRRAfM2wnqs73mfO4t/IocCzu8Zc6xZo8mjPvwmrCgnbEUZ3V5DiH4Wy0Netv7CbuIs4Msa8rwdiH6hq+IC4nzT7UZYEMX5G4ohQB4CaeYEXndjz6HluEiT8FYTbLnvVaYOous=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:16:52.9024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cd49f5-bc1c-4432-99d7-08d69ccefc8d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADIS16495 and ADIS16497 are inertial systems that include a triaxis
gyroscope and a triaxis accelerometer. The serial peripheral interface
(SPI) provide a simple interface for data collection and configuration
control. The devices are similar to ADIS16475, ADIS16480, ADIS16485 and
ADIS16488, the main differences are highlighted below:

* The temperature data scale is 0.00565 C/LSB for ADIS16475 and ADIS1648x
  devices, while for ADIS1649x 0.0125 C/LSB.

* ADIS1649x devices support different gyroscope measurement ranges which
  are dependent on the dash number (-1, -2, -3), see Table 24 in the
  ADIS16495 datasheet. However, the ADIS16497 gyroscopes have the same
  scale as ADIS16495.

* ADIS16495 devices support the acceleration maximum range of 8g, while
  ADIS16497 devices go up to 40g.

* The internal clock for ADIS1649x devices is 4.25 kSPS. The sampling
  frequency is calculated by applying a decimation rate which can take a
  maximum value of 4250.

* ADIS1649x devices support different default filter frequencies.

Datasheets:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16495.pdf
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16497.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index c90375d..28cece3 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -453,6 +453,13 @@ static const unsigned int adis16480_def_filter_freqs[] = {
 	63,
 };
 
+static const unsigned int adis16495_def_filter_freqs[] = {
+	300,
+	100,
+	300,
+	100,
+};
+
 static const unsigned int ad16480_filter_data[][2] = {
 	[ADIS16480_SCAN_GYRO_X]		= { ADIS16480_REG_FILTER_BNK0, 0 },
 	[ADIS16480_SCAN_GYRO_Y]		= { ADIS16480_REG_FILTER_BNK0, 3 },
@@ -713,6 +720,12 @@ enum adis16480_variant {
 	ADIS16480,
 	ADIS16485,
 	ADIS16488,
+	ADIS16495_1,
+	ADIS16495_2,
+	ADIS16495_3,
+	ADIS16497_1,
+	ADIS16497_2,
+	ADIS16497_3,
 };
 
 static const struct adis16480_chip_info adis16480_chip_info[] = {
@@ -769,6 +782,78 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
 	},
+	[ADIS16495_1] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 125,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+	},
+	[ADIS16495_2] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+	},
+	[ADIS16495_3] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 2000,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+	},
+	[ADIS16497_1] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 125,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+	},
+	[ADIS16497_2] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+	},
+	[ADIS16497_3] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 2000,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+	},
 };
 
 static const struct iio_info adis16480_info = {
@@ -1014,6 +1099,12 @@ static const struct spi_device_id adis16480_ids[] = {
 	{ "adis16480", ADIS16480 },
 	{ "adis16485", ADIS16485 },
 	{ "adis16488", ADIS16488 },
+	{ "adis16495-1", ADIS16495_1 },
+	{ "adis16495-2", ADIS16495_2 },
+	{ "adis16495-3", ADIS16495_3 },
+	{ "adis16497-1", ADIS16497_1 },
+	{ "adis16497-2", ADIS16497_2 },
+	{ "adis16497-3", ADIS16497_3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16480_ids);
@@ -1023,6 +1114,12 @@ static const struct of_device_id adis16480_of_match[] = {
 	{ .compatible = "adi,adis16480" },
 	{ .compatible = "adi,adis16485" },
 	{ .compatible = "adi,adis16488" },
+	{ .compatible = "adi,adis16495-1" },
+	{ .compatible = "adi,adis16495-2" },
+	{ .compatible = "adi,adis16495-3" },
+	{ .compatible = "adi,adis16497-1" },
+	{ .compatible = "adi,adis16497-2" },
+	{ .compatible = "adi,adis16497-3" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adis16480_of_match);
-- 
2.7.4

