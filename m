Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9284A2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KJARmHaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfBUNSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:18:00 -0500
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:44704
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbfBUNR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7nePwpCOe5OTpx4ZlDJ6WYqqpZCrnjPsnhZC3Vtf7o=;
 b=KJARmHaHdQOd1+5bqgKiLWaGPG/AzEjGdTcxtURoWPt8ORCeIUDZmeMnZRqzsuCHVmwKEIhxqQQi/jQVN5Zi5DxTuq9tJr4ip2Aj9VHUmjAStqZzGOJlSGUuf+4MqBlsh0CIMYY8c3dHtjB7JiYdzszgTfZgdIL/iLGZhOrWRO4=
Received: from DM5PR03CA0040.namprd03.prod.outlook.com (2603:10b6:4:3b::29) by
 BN6PR03MB3058.namprd03.prod.outlook.com (2603:10b6:405:44::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 13:17:57 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by DM5PR03CA0040.outlook.office365.com
 (2603:10b6:4:3b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Thu, 21 Feb 2019 13:17:56 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 13:17:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1LDHsFe003662
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 Feb 2019 05:17:54 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:17:53 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/5] iio: imu: adis16480: Treat temperature scale in a generic way
Date:   Thu, 21 Feb 2019 15:15:04 +0200
Message-ID: <1550754906-24640-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
References: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(3190300001)(199004)(189003)(476003)(11346002)(356004)(2616005)(7636002)(305945005)(336012)(72206003)(426003)(6666004)(446003)(316002)(246002)(116002)(126002)(486006)(44832011)(478600001)(106466001)(51416003)(7696005)(47776003)(5660300002)(76176011)(16586007)(110136005)(77096007)(50226002)(4326008)(8676002)(50466002)(48376002)(54906003)(26005)(36756003)(8936002)(186003)(106002)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3058;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac339457-a335-4537-adb1-08d697fefe77
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR03MB3058;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3058:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3058;20:/JBLM3yy5+31JoeqkTNLa/mK2dLDob+C+Kabx/vavZqMtE0vMweqKLPK8+m1V6XX3ZT3Nj2gql/8zmc1ZlliG4lwiS7YgDE8g9wnJtwdOXI664BIU1KqdrmOtEiOscmu/LQgmVr+S7dxxwgZHgeDFzH1XnIFbMO7rPRBeyafZ8semA7Cvm5ww5BL0BplphgQzvPwipZ4QqXxTzt7ViNiz10AzX7RfhMh+XutEzwMWdUeh+2oQPlu5MD7Ss6YeZZNwGbbmglVBPuSEoOBwdsNoYNUFAuLTtVGfeInoKgFyyGU9/EPn0cdKeeD+wyWGVtu4ykHcH0d78qt1ktCHfCv1VfnmUCYg4Q2HqDjrjLJryfLvl77hAQioAjcGARng/uJ/2PPxUC37LfF6QmX8xUVE1eke5SCt5xc7O+JypBYjjR5Y+PkLneShWzcSuDzaLhllFPkQWFV4mmWIVGdklPOhh95PeaQb+thIYZGWlW2IXFByr1lrnkrlw/V7A9u4rnj
X-Microsoft-Antispam-PRVS: <BN6PR03MB305892CE2AAE7FFF7F6D02FF9D7E0@BN6PR03MB3058.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3058;23:bmWfbA2uibhVFiDH+jBIEEtr9NESvwCtrGuxmjHC4?=
 =?us-ascii?Q?FuQfz9x19ewRWrfDU+rdOCz0tQQB/rG/V8eZOk1QPIP209xH9j0LanOdqWYk?=
 =?us-ascii?Q?rpttStr1/kPWISxFI19Wk4maUp6Yw+SiczLvBEJDoNJirUF4SQaFE3lxAqaQ?=
 =?us-ascii?Q?YLJw1rG5a0hpTeGZlNUSPeipWBupqMOwLt1lzoX/9gZTAm0EZFl2E90KPM0T?=
 =?us-ascii?Q?S79/EjMaw8bf6RB01VHOD7PKDFwLN3a04rIouEx48ZFrB7XgEf39X05e2ZCm?=
 =?us-ascii?Q?WUlo+iEZTowqtwIffKBwrdFdKfhitlgsPxNOPl3OildchSzovfh1Vk62SIpe?=
 =?us-ascii?Q?rnUUYrEa6h+Nfuemg+/wFYlNMzJcVnYPDfb0QNbSLxEIQOOcob8mmvqd8eKq?=
 =?us-ascii?Q?Evie0PMXHcJLV8vNCZ3Uby4tIAkt9GFQCaTygIo2a4BKYLqvlb3mG/X8QNuX?=
 =?us-ascii?Q?LgwsrcKHaUsq1jdIHRjO4/lZRj9lCwGwrLY9CgortfWntOP8Rs/VDAT7dPZY?=
 =?us-ascii?Q?SEe9s4FX75kO7UPtHVzB/cgJK/PkMDrfOzwOz2fvxk+2wWlJZoFxuWeiRZD+?=
 =?us-ascii?Q?kC4s/2spO0dDfyIh7mz4819YOHT6pZwrYM+3AOg2fZdlSCdqh8xej+iS+nzh?=
 =?us-ascii?Q?i01q3weDUXwEg1RzDxY8sAselfu2m4CdSI3/FR0Yaehh4H0i4zQm1YsEGaDm?=
 =?us-ascii?Q?VY0Q8oGCbn7+XbQ74TtPa/ODWqWx9GhEbAkMXPhSo6JnfDuTMZeeOQF6XEYH?=
 =?us-ascii?Q?JW1ql7SfC7VqrZgW+6ZPPafjwEatgJbl8ApUSTWtcTevUC/y0kpFFpWilnEu?=
 =?us-ascii?Q?taCPFiq1JofMYOUMxSOJ1wx4NK7E5jSxS+E+WxOhHYnBUFqlVizVT8UwZM76?=
 =?us-ascii?Q?kJzRC/2aDlDEt4aZe/ZKaH5rXDOwDKn92K5aeC+/fpxSBtTRSVsHfeNdUF66?=
 =?us-ascii?Q?EOonI9jrUR3ItqxNhwvkwrE6Pwl/XOYnYjAPs91k/JgMQzUwpMG0ayMmlWH0?=
 =?us-ascii?Q?Cj3WFe2yOaJ1fxF/DqJKkxBoBqyM2zsVB9J13+sYXokGYJU2DoWigFfgoQRO?=
 =?us-ascii?Q?YDdUf3km+A40PZ8/hDkBYh8KmKr?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: W2crbfpPUvvcK25AQlk36OKN+AmuF+wnBD4Xhe5PLLeCTURs4rIp6TrDc169MaTp91buuCYZ3CgUtyBV5/oFJ9G+lxnhg5zHC0h4nq77hvUqUOBSLeBRuR3nJ4JKwlWFowasjckCVYfcwGEgrsFkVM+aC5qtIwUFoaHNcnGFI5xojXRFZhHp7aZtQE2gESQ8qM+6Y875KKg8gE6p7kMhkBIL2WRSIYMzIbJJrerpEhoHVfkKNdG/GC0Ls/gcUtE2375VF85A44lbl5mA+IHBefcJaGSCWkJCBRfB2944g/mHr+7L+aE6e7zLtsqXFofXp6X+QYqgI9JsH2gvVzJEZuttLBLKNe4HrmmOQp4FTXTPjtOmFWpVEx10d4f4UcetYCiMpZwYzb/QPgNW3plG7Y1l5OkrGeb5wQGXi233n+Y=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 13:17:55.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac339457-a335-4537-adb1-08d697fefe77
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3058
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
 drivers/iio/imu/adis16480.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 150d814..5a2864a 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -124,6 +124,7 @@ struct adis16480_chip_info {
 	unsigned int gyro_max_scale;
 	unsigned int accel_max_val;
 	unsigned int accel_max_scale;
+	unsigned int temp_scale;
 };
 
 enum adis16480_int_pin {
@@ -530,6 +531,7 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val, int *val2, long info)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
+	unsigned int temp;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
@@ -549,8 +551,13 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
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
+			*val = st->chip_info->temp_scale / 1000;
+			*val2 = (st->chip_info->temp_scale % 1000) * 1000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_PRESSURE:
 			*val = 0;
@@ -561,7 +568,8 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has a offset */
-		*val = 4425; /* 25 degree Celsius = 0x0000 */
+		temp = 25 * 1000000LL; /* 25 degree Celsius = 0x0000 */
+		*val = DIV_ROUND_CLOSEST_ULL(temp, st->chip_info->temp_scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return adis16480_get_calibbias(indio_dev, chan, val);
@@ -717,6 +725,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 300,
 		.accel_max_val = IIO_M_S_2_TO_G(21973),
 		.accel_max_scale = 18,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -725,6 +734,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 450,
 		.accel_max_val = IIO_M_S_2_TO_G(12500),
 		.accel_max_scale = 10,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -733,6 +743,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 450,
 		.accel_max_val = IIO_M_S_2_TO_G(20000),
 		.accel_max_scale = 5,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -741,6 +752,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.gyro_max_scale = 450,
 		.accel_max_val = IIO_M_S_2_TO_G(22500),
 		.accel_max_scale = 18,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 	},
 };
 
-- 
2.7.4

