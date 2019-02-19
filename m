Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4438921773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="dZhA9FbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfBSROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:14:31 -0500
Received: from mail-eopbgr710078.outbound.protection.outlook.com ([40.107.71.78]:18784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbfBSROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaF7ISqCmTpw1Y6KPj1Gg9f1SoziwTMO2kVwHFDykqU=;
 b=dZhA9FbYBMbkdO4Vdxnb0RS7j874wmIlMcBFcgHzOMveYZ0HtnlyY8aWH3j9Lc4BoglIaQFJs9s87Kk88DLvhWIAQsVSWJBXypJIoMujVeqJC9kRxAQmEUWwsQ35v6Xc0fbo3mpC2Qds4VTkDPz4Gglp25Zi8Z84bzUVlFtIsSE=
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by CY4PR03MB3064.namprd03.prod.outlook.com (2603:10b6:910:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Tue, 19 Feb
 2019 17:14:26 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:14:26 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:14:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHEPBa009698
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:14:25 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:14:25 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 4/6] iio: imu: adis16480: Treat temperature scale in a generic way
Date:   Tue, 19 Feb 2019 19:12:16 +0200
Message-ID: <1550596338-24220-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(3190300001)(199004)(189003)(36756003)(356004)(106002)(8936002)(8676002)(50226002)(246002)(6666004)(5660300002)(16586007)(44832011)(305945005)(50466002)(4326008)(48376002)(72206003)(116002)(77096007)(26005)(478600001)(426003)(186003)(47776003)(446003)(2616005)(11346002)(476003)(126002)(486006)(110136005)(106466001)(2906002)(7696005)(51416003)(336012)(54906003)(316002)(7636002)(76176011)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3064;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9133ed0-d067-4603-bd6e-08d6968db375
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR03MB3064;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3064:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3064;20:SNwdMM0BG4gpGIQuPTzdphbC5MlojnzCty5Gj5QcXfO7yxL0m6CjeJeSA+8crMPntNB5AEA8gaXXhnlS6+NCX3BTLSKbEKjSw8H8oEasfR2VUmyVj+fepe7ga2hVSS5zu1xvRaMX5+SWWCn7N3c5abFjWQr4dEqlEKcYe7W7sMMoZ8Xvdg9hXFBOFbLz9oEoUkF80sM6mq6SiVQI1UKYDj7YIBEaUty17P0Nq/o9fsBfktUwfSGFHklLktDy5ih3eNUWS05FQV9iz8ahdJ5/q5WixHu3+wRirgn3UaswIDeiw25Hsu0citlaYqod4nSU1MdeZuAbjb+CfGYkglreFzjQjC/MNZHR0Tzg4VjxcctKPnh/Q2gBgSP2U8HvBpoF4RpMMOafacLWUVc33OvcvpTZoAyYtQju9wc0jsPJxM4qlJ2AlLf3/mdIU5z7kkY+3ryEumKN8IWPDC/bIgnU6hkTdPtiAD3XlXsYhthwdE3IDmLpadZ/OAmfTF+eGGVN
X-Microsoft-Antispam-PRVS: <CY4PR03MB3064C3C6B73BCD6F2A9BA3859D7C0@CY4PR03MB3064.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3064;23:YCp632aBXeCMfTfqY7M6OM+sTep+Xbm3rkJx6o/tV?=
 =?us-ascii?Q?FkcvfaeA0EfmsvMXwcooGmvjEumx/2tyOdxDT04sxWDcgKKJN4q9k283hsVA?=
 =?us-ascii?Q?fp/uP2J52GdLYc4dEHxzr8dzy5kd+S419RI2AWz73onv2vf4VcIdHyfRr4Vw?=
 =?us-ascii?Q?qwT/A35PMnZCnCWUot/owZwFOYxYuLCaHaiTJ1zXFGDvVToWBsu71LmM7E6M?=
 =?us-ascii?Q?GFxExWY7xJvW9n9UxUazblRYOHW04G/mthsYp0jM9pkWev2qp1rB4lCiBlGD?=
 =?us-ascii?Q?aPv/TnU11tT9OCj0kOnOHMaGTZuExeVXurXDIgiNxrRpHb+it/26pNtZ2n2h?=
 =?us-ascii?Q?tKUF6b5XXuJLrQ4+YbRobmL9ipyXAxYEe6Sz6YUztOv/dpqsqG1jCGlTch8s?=
 =?us-ascii?Q?irpSO6EkUgMu/ebmv8Baj/iKUGy+6dHX67S2sD6HUQWVouUAvSbSZSdGfhPe?=
 =?us-ascii?Q?yAfuUy/sEwbR9uTINHgAK1cSykR/SZC643Qy74GWJvc3gdHCnSO03hAjtHHp?=
 =?us-ascii?Q?f7lEDqnO35lxFIsUUEd//fl3RVFBK6b5f2BQ38O5jbEZCaLhUYU2oM3L32iy?=
 =?us-ascii?Q?i21629AVULMNIFTbn3s8GuBLzgmCLftOHlNqGDiNHe9ahkU32hCj1qCJK1wX?=
 =?us-ascii?Q?usjXYwjwHAO67VKwpvohEYnZN21G4vwmvRrB81FJH+qRwWgKArAozmc7VjFw?=
 =?us-ascii?Q?ydnjH8uSRryoC+HbHjabt9jYeKbjOet9SVQwQbsseSOr+kieUjO3pRm+ugKO?=
 =?us-ascii?Q?HAUFhlYb7+fpc9eA2qZWBhscwyz2KO2fN6Bjbo5mI0KJcmViMKk2Y9UbGtNV?=
 =?us-ascii?Q?K4a2Gfql65z2GK09fdIww+PnsOEWBIB3yVwEkXSwXh/OrbFjqJx9tjeNr/77?=
 =?us-ascii?Q?K/o6qzyRFTy1QaKLLXIYv7f+mHis3bF33ZCLnC3XvGYF5X4te/9RSdd9woyc?=
 =?us-ascii?Q?U/83bgTH6HiVa4BZVyiHmpAe2oTplI/8hZghV7AT/jZ8rvMy8CGLjoFM6YJ6?=
 =?us-ascii?Q?/GI2J1lS/T3af9t+tjaRLja5g3Y9KFbG/aSUkDRNgQlFfx/8Dy8mgI4B/8j4?=
 =?us-ascii?Q?0Z8LIu9RDZfl+HajDKdzzWaZeDy?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KS98iTHrdlWCBbft9+nCSUQB6Je2xntvrYvlbyB7/JX8AvI7b8c/0JMtzyAKgap65RmRMma9rYn3LoijVrWWwMoJuXtBFux/HiCGECbl6Bwv5igAbvVK05ToQ58+9SuPtp+rYrRhqKQc2zPo+gtZ0AHUXNTnpTeLOT8fQvS+mauYZaLNS3oC71r9qlR13BHlVg9OXBGcpNLeeomL5L3icHESpl7aB09ahG/vgZGuDv6LtTmKKJW8M1THz3v7Jt85gUa3r0srNg8BbAtPUeDu1A6rhlTENLTSX9aY13jGOAV4kX+pvI753N4r3UheGnGEEwpr7zLl6TbAOHK/nSluDKVTBDgi8ABouNJ963PcOSMTH9G4IXTlqnq6lF4x3ltX/2jWCoqmp8OklnOSuopBhkb4OLtsnmaUJbCyw9W20iw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:14:26.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9133ed0-d067-4603-bd6e-08d6968db375
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All supported devices provide internal temperature measurement from -40 C
to +85 C, with +25 C representing value 0x00.

This patch treats the temperature scale in a generic way, similar to the
accelerometer and gyroscope scales. So far, there are no temperature max
scale differences between the supported devices. However, devices that
will make use of this feature will be added in the future.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 7ae71f4..cc53825 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -124,6 +124,7 @@ struct adis16480_chip_info {
 	unsigned int gyro_max_scale;
 	unsigned int accel_max_val;
 	unsigned int accel_max_scale;
+	unsigned int temp_max_scale;
 };
 
 enum adis16480_int_pin {
@@ -530,6 +531,7 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val, int *val2, long info)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
+	unsigned int temp, scale;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
@@ -549,8 +551,15 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 			*val2 = 100; /* 0.0001 gauss */
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = 5;
-			*val2 = 650000; /* 5.65 milli degree Celsius */
+			/*
+			 * +85 degrees Celsius = temp_max_scale
+			 * +25 degrees Celsius = 0
+			 * LSB, 25 degrees Celsius  = 60 / temp_max_scale
+			 */
+			scale = DIV_ROUND_CLOSEST_ULL(60 * 1000000LL,
+					st->chip_info->temp_max_scale);
+			*val = scale / 1000;
+			*val2 = (scale % 1000) * 1000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_PRESSURE:
 			*val = 0;
@@ -561,7 +570,10 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has a offset */
-		*val = 4425; /* 25 degree Celsius = 0x0000 */
+		temp = 25 * 1000000LL; /* 25 degree Celsius = 0x0000 */
+		scale = DIV_ROUND_CLOSEST_ULL(60 * 1000000LL,
+				st->chip_info->temp_max_scale);
+		*val = DIV_ROUND_CLOSEST_ULL(temp, scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return adis16480_get_calibbias(indio_dev, chan, val);
@@ -717,6 +729,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 300,
 		.accel_max_val = IIO_M_S_2_TO_G(21973),
 		.accel_max_scale = 18,
+		.temp_max_scale = 10619,
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -725,6 +738,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 450,
 		.accel_max_val = IIO_M_S_2_TO_G(12500),
 		.accel_max_scale = 10,
+		.temp_max_scale = 10619,
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -733,6 +747,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 450,
 		.accel_max_val = IIO_M_S_2_TO_G(20000),
 		.accel_max_scale = 5,
+		.temp_max_scale = 10619,
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -741,6 +756,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 450,
 		.accel_max_val = IIO_M_S_2_TO_G(22500),
 		.accel_max_scale = 18,
+		.temp_max_scale = 10619,
 	},
 };
 
-- 
2.7.4

