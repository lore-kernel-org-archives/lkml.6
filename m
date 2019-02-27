Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WtTmy/yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfB0QPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:15:37 -0500
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:42720
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbfB0QPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7nePwpCOe5OTpx4ZlDJ6WYqqpZCrnjPsnhZC3Vtf7o=;
 b=WtTmy/ydPrnF2mXXws93ACgKeJY/TrWDIgTOMCqL/EUYTgQ5lzXWMAC4s/+vapbMWzay5ETtpKGGYm+Q/giERYVaBq2wngLqOE06t8++Juyol5W0VHkyIACLe7FrJk9bk/o6GMTpQ6GLHJzXR/eWXbwSBtY2OCgnnwzRNOswFBg=
Received: from BN6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:404:23::12)
 by MWHPR03MB3070.namprd03.prod.outlook.com (2603:10b6:301:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.15; Wed, 27 Feb
 2019 16:15:25 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR03CA0002.outlook.office365.com
 (2603:10b6:404:23::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.16 via Frontend
 Transport; Wed, 27 Feb 2019 16:15:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:15:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGFOJP021639
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:15:24 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:15:24 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 3/7] iio: imu: adis16480: Treat temperature scale in a generic way
Date:   Wed, 27 Feb 2019 18:14:24 +0200
Message-ID: <1551284068-4882-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(3190300001)(199004)(189003)(44832011)(51416003)(76176011)(7696005)(4326008)(16586007)(316002)(110136005)(446003)(47776003)(11346002)(426003)(2616005)(72206003)(336012)(48376002)(50466002)(486006)(54906003)(478600001)(116002)(126002)(50226002)(246002)(186003)(8676002)(8936002)(476003)(53416004)(305945005)(7636002)(26005)(106002)(106466001)(356004)(2906002)(77096007)(36756003)(5660300002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3070;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695c40c1-781b-47cd-ca02-08d69ccec804
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR03MB3070;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3070:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3070;20:NPoN0T+Y3c4wzBD7ymGTLMpLtq4900N71tKWuWrQqOWq/+cKsMDfC11ioAMq/KKjhbUBlleAzll/DT6RM0BWHQ5v2PVE3g5Jcb8ByeSlHUQK1Jrv9dWDOMJiWPyKor2wNGscbuifN067Z9gNOhF1sVgM//EQEMQq+YlEm/r6JkQVaSJq/L6EC4hnll3m25k5qnjW1h5kPb4xUJ+4iprGkRZfcG9qgD76grFly5REPTS6ozSxAHCP2M34ldOs3CdWrqBSskDE+jdcyyLWW/ksSy9Fn6vK8xwRJjMOR36pUyab/W1pdi+kRmKzVYvRXbV13KMK7Uz/tVWWbLOIAs12L8WhMQQfUeNf27uuASHvlwTXsSnkyWKG195AQI+pOH8v5s/XTlP51PQQRAAKACtFF+ZPTNLhvkhufqNxwtaulO/4sCfM4YpxcVVfejWEAxaTA0VasNsPmQxuGZv1LuS32HWmoj/LApMcS3bMqwNaB94YuDgY9l7AFVPdj04K5M8A
X-Microsoft-Antispam-PRVS: <MWHPR03MB3070DC5C3B9056AFE8E9053E9D740@MWHPR03MB3070.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3070;23:i/HbXUXgrMGwZRXogCNIsmWhnH9Uv3FbDTC++FCW8?=
 =?us-ascii?Q?3pPa3gOC+PQaDs9ujqWf63dAqU0AOLCoez5DAPeomGy3TRuyAmZcg7vmYJR0?=
 =?us-ascii?Q?2e2lTOSxaUTnsgs8xYvDYRmnTvq3Y086f+cLLuCJUjQCveEMpgj3z8tQ5OSX?=
 =?us-ascii?Q?xaWtdYa7gx5mY3ApF1vO3nIt+874uVotLcBdkFx+5KmBYQsOYth3V1DJIgMA?=
 =?us-ascii?Q?/Rf58jqDSFr7IKfXFSkbT2E5NFAU5i8B/lOXmN8HdDHhbCNOmVsIsWLsTUEH?=
 =?us-ascii?Q?wrgpWFwkBgSzyPjHGF9Sb8YWK2eDzeGfkHVaBeYAgh4vlJ1q2IUc9qFngpym?=
 =?us-ascii?Q?yZ9uZWAVri4CsG8FCCrnMr6OROmSO84ohd/xz93V593Qw2dwmLDxcvzrTH6h?=
 =?us-ascii?Q?2wWWyidn1FXKVeBDvIz1xhudG40VjJE7Cnb4v9hx0xx20aezqcEIeQ4I9KlT?=
 =?us-ascii?Q?nfeBmuO46EeFOC15DQMuURgN+zdyzaE084tb+WgVXJIE2Kv7BfNp4tJSlWFh?=
 =?us-ascii?Q?XnixCx+LvLyRLmVhBB6AiXiXkdeXmqzXFUcQwMn4vAgAQ5ZDnhNp0XORkBct?=
 =?us-ascii?Q?5t9nSIldU52aIyN9qNwZpW4w7QTIutfRxU0XRXch8qeX3IPRe50+CaYJR0vC?=
 =?us-ascii?Q?E7K2AGW9cnKIbV7YBDnBBxMz4gtqeQPGxclWsX48SOZO8zzJIJm30NOg/XSz?=
 =?us-ascii?Q?yk1TMws1mD5cNi5OP8MoMobeZOQ5O9jhKJ2c/1B1ZAmpRu15HnN+9s2fh2GL?=
 =?us-ascii?Q?Yes0EDBBVMf5rUj7ANbb9suHZQEwN+B/4uq59cCSXsceLJjJjyh/EjKOCv67?=
 =?us-ascii?Q?NmTUXd91Wic8NcvUDJOzkr6FOMJlvu7QYz/vBfk20SVL4DxhmsPjM3VD0zh8?=
 =?us-ascii?Q?V1IULElMtNK4oLrO/EQgNEqCnlQt1s520Oz4QSHV7GIgYrHxNjuT1cDzHwT2?=
 =?us-ascii?Q?+DRXWdwb6hggs6caPceGW5s9VS3LWhETuMSmY+PR7s5G++VHxqf3lLSLc6Z0?=
 =?us-ascii?Q?WYvGgB7Atnw251+c2GACbs//a32XBjk0/AYraTJFYaTNQrEnkahi5yhvptcX?=
 =?us-ascii?Q?5iiDvISkDgsPcmshKyG6lLqFbw/?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6T80rrNSanv3j6PLXqfR7NopaOYN++M/Yqtaxg/lLwGLuEoIB730givdF+YWrjc+id+LwH2cxSAN+Nqda6qgesbPlIOqvSihc1sV/ukxxXqI3NCKaTPEFXTzZjRU0hUoerYODlLimGFdGpyXYpI9SmFgtIYMXxpBeSKK0W8D2PeSRN89lsyztMjP4hfqu4zYPMkLqr3zJUHCCX/DRKudX/eZ+d//98iMLAPhJrvhn5D93YkPq/oTS/5Gn2UslWrP0KTTRJ6+yb/TkkiH8UPKSDorogyOwuV1Sysj+UkSX70QEnLx/47kcSy0Oh3WXNYApi3zWWszzX9Kt2clfOJtRFk6eomIuNogm15McDpHNHIe4U9JweA/DVzLbgTqcLRjND6UqRWQCz9T2sFdnUXuplKPpJyqAm0/u8MZJ7OyTtU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:15:25.1436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695c40c1-781b-47cd-ca02-08d69ccec804
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3070
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

