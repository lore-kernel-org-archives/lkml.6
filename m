Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD2E21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="bg+sxP7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfBSRPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:15:02 -0500
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:32469
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbfBSRPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZQPrfKnsMi1LB+3mW47UVP7A8fDTFH65kjhCvDivbk=;
 b=bg+sxP7HUv4an6HNmZ6hqPdIRIQlgqzcDy61CnmtsDbWUc5xApP4PWZxgYz4vyuUDzBiYUj7GCCykM0KKXXLSgKg9tUALN34C9Q52Vrgi+Z8e+9siiwCI1jB6yEExNIpm56H5p5aDtmVgQey3vlf93g8ujQXUSgz8Ae1KN8xFaU=
Received: from BN6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:405:6f::24)
 by SN6PR03MB3757.namprd03.prod.outlook.com (2603:10b6:805:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Tue, 19 Feb
 2019 17:14:58 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR03CA0086.outlook.office365.com
 (2603:10b6:405:6f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:14:58 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:14:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHEuq3009846
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:14:56 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:14:56 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 5/6] iio: imu: adis16480: Add support for ADIS1649x family of devices
Date:   Tue, 19 Feb 2019 19:12:17 +0200
Message-ID: <1550596338-24220-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(3190300001)(189003)(199004)(356004)(77096007)(966005)(6666004)(54906003)(110136005)(316002)(16586007)(6306002)(26005)(478600001)(8676002)(72206003)(2906002)(186003)(48376002)(8936002)(106002)(36756003)(47776003)(246002)(4326008)(7636002)(5660300002)(50466002)(51416003)(7696005)(50226002)(426003)(76176011)(44832011)(336012)(126002)(116002)(106466001)(476003)(2616005)(11346002)(305945005)(446003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3757;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c40c36-be5e-4a54-84c0-08d6968dc620
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR03MB3757;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3757:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3757;20:xoN9ia7Z62OuN4Hfkf70KkkKm9bvjKdfQffhX+9QbJJ3fFgQPCQSY/pgQrHxUQW4jelSofEI8ZkEGOOY5+7Rum4858M4ns7R6nMu09DvL92nnssY0UomjFOuTGHp03guukyJ5sfpcgoB0JDK5I5ueDb9+JLWKpp4CpkTUblkRfv4qTgVKbW4GK6HhP6tUOakYRHDFYeg6uy/Pxs0Qp2ImsX+Kl7vnz2xLw6BuNXLHg0g5xH1m8D5DipFPL7CVSJLwU1EagGTS5slTaraYXaihA4164ZAeGzf81jCgDEe7312wnUK1W5G0TeaNghRO5fvvzJJF6MmDCaF5gahvRDpVIZ6jBf5GXP9Q7hhk5m47QmRFyHZha+oiF+OSpO9b7UciY+D6mCCkbYWIJc7uBhpK2m3KJYF7di+DQO/uPYxoPz6A1FXg50CvgIUWGJjFqhRfDmZo0lObYGYPfsr33fsaOrhmfXSzwr2AjA8YeRMWB2ZwyEDLynkVRhR+/s1Wg7K
X-Microsoft-Antispam-PRVS: <SN6PR03MB3757D9D2AE63D15D0CA900BE9D7C0@SN6PR03MB3757.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3757;23:bjW8hm8eEpMsIgD2xAF5FntTT7rfUBEsK6NpMddz6?=
 =?us-ascii?Q?kHkiEqVqf47O6OKES+vp+mdy4aa61rfkyRA1tnJLBDs+KldqKhb9peiVch/F?=
 =?us-ascii?Q?Spf/Bn4rqK/nOh0SzEOkDTV3fDXCs6JZgEM7IR9aTE10GjmPljsWlC34Ywv+?=
 =?us-ascii?Q?9DCAnFipN8MgpSPjO7lalAt+Q3OCg21rHPPBpaQjgZWRu3YdEDje8KTvSbvE?=
 =?us-ascii?Q?iTOO/Zm5eMF1HidPb4GikbB6gE89eWH2WHDKh9klE4SjPRYO6S6rnukt4gM/?=
 =?us-ascii?Q?bWHwFIlibT6O+TMdP2dgzEpPtHYSMxOvZXfNntw8a9C/1j4BXzqKHdK4POJ7?=
 =?us-ascii?Q?W8JJO7fIonjcPj3LfM+600sU/H/QIzH22CKKV9ZNW7kM4Q3BeRvjcS34LJYd?=
 =?us-ascii?Q?GRjpW41fiIYNQ4JI6Hp3FvlH56+w/6fvnjluWYuslKee7uxHXDwjTbvYOVPo?=
 =?us-ascii?Q?pOe+RSyP3eeUcIC2UxkmNgVWdzyp/Yrg6rFzJhCDWT2yeaHrtWZ/awrp9U+f?=
 =?us-ascii?Q?WVfTOEWfG8So5UW5jh5U6AD0989kTiNClIab1fPceojHKxndy9DimoYAlJGE?=
 =?us-ascii?Q?eaEM6wnWrYs+0ajfo4nUwupSCGmb48YSyq0EhW7grmkdW1ViO6vlL477dth9?=
 =?us-ascii?Q?Qasv/oxpR72uBlR0VGNRd97Nxg9kjxil88h89o8TDpEt6ZAOh7FaBz9lbaAx?=
 =?us-ascii?Q?kBIPeXZnhwc06ePBeFVA1DAiNRXXybBYMaYQ88nJVgkMu5JJtW6LBEcUtLB1?=
 =?us-ascii?Q?rlSygcaoy5fYuqU946VjGloNN+4vFbEmU1ChWNc+PQX5dp2/rnlKo93iOZze?=
 =?us-ascii?Q?Wj47ioxtK7zmPBpjG8regBKWmNOffKIaWPj57ubCWaMFxyrfkTMMG4nWsWed?=
 =?us-ascii?Q?wYK0wbrpxfZElHyee3DVLxheFnUKCeSpJaeTwZtbMC5lXuBfBZpHA8HfER4S?=
 =?us-ascii?Q?BZV6SyS0qMVG3nfwp5i1wpoSrrdvP8IU12JUR14H2gBiPnQIJu1uiqcasdnh?=
 =?us-ascii?Q?cNMsicNWr3gQpLNQqsVuLtWkuFLFT7cAEvkY0htDzzNN51G0kvxlXDVu5tUl?=
 =?us-ascii?Q?HZHXdf7Ir9ILBoYij/V9IbvQl7szZpvOh2kLJYEcAl9PvPZKw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: P2hJVR0noBPSQBhVcW0iRbV22LIx7P7LypAl7FfP/Mz+Ypt22RNwXa4VX9MhS0zsYukGMUqRmUOv7gHXfdYwVRLnY0YWX83Q6B9pgabj1woPxc8OSj1Y+tYVpv/XiSlzWQzajv6vbafNkhFojxgUacLpwdcCZr6RaTOlDQhTzmT8qVl15bFtXxhIZp+iF9akwBxTGZTwFXi7cHwDUSZ4g3KkMF6122Va0eLpW3Q6JnSC3u2PLcryNDrew/7qOsslw9OBUfTWrlrJPLn5T7Tzrk9OnoNSXZ60yIARH0dYVjeUYHk/BJ/8+cfA2n/Z5o6UxOvClh+iffemekA2ZuLkghdueCMLALaLiPlcvBonftlbTjXcQCtfWu5v4rTm7ikP9HuOda1oga3LHgpXFlpzY1Gjgnkt14cQgXoDsnn+AYI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:14:57.2114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c40c36-be5e-4a54-84c0-08d6968dc620
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADIS16495 and ADIS16497 are inertial systems that include a triaxis
gyroscope and a triaxis accelerometer. The serial peripheral interface
(SPI) provide a simple interface for data collection and configuration
control. The devices are similar to ADIS16475, ADIS16480, ADIS16485 and
ADIS16488, the main differences are related to range and scale factors.

The temperature data scale is 0.00565 C/LSB for ADIS16475 and ADIS1648x
devices, while for ADIS1649x 0.0125 C/LSB.

Another difference is that ADIS1649x devices support different gyroscope
measurement ranges which are dependent on the dash number (-1, -2, -3),
see Table 24 in the ADIS16495 datasheet. However, the ADIS16497
gyroscopes have the same scale as ADIS16495.

Furthermore, ADIS16495 devices support the acceleration maximum range of
8g, while ADIS16497 devices go up to 40g.

Datasheets:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16495.pdf
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16497.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index cc53825..c30acfdb 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -714,6 +714,12 @@ enum adis16480_variant {
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
@@ -758,6 +764,60 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_scale = 18,
 		.temp_max_scale = 10619,
 	},
+	[ADIS16495_1] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 125,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_max_scale = 4800,
+	},
+	[ADIS16495_2] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_max_scale = 4800,
+	},
+	[ADIS16495_3] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 2000,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_max_scale = 4800,
+	},
+	[ADIS16497_1] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 125,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_max_scale = 4800,
+	},
+	[ADIS16497_2] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_max_scale = 4800,
+	},
+	[ADIS16497_3] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 2000,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_max_scale = 4800,
+	},
 };
 
 static const struct iio_info adis16480_info = {
@@ -1000,6 +1060,12 @@ static const struct spi_device_id adis16480_ids[] = {
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
@@ -1009,6 +1075,12 @@ static const struct of_device_id adis16480_of_match[] = {
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

