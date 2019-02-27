Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FDAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4D21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="LW7GBNTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfB0QP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:15:58 -0500
Received: from mail-eopbgr790050.outbound.protection.outlook.com ([40.107.79.50]:34778
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729943AbfB0QP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2RvkOXmqkLVtgdx4+xeS0jEbUbwlbN5q+TBJ3Mj/B4=;
 b=LW7GBNTXDtFd8sdzmluzqIzEwtyoeUNQT4AuY5wq4tFrj9iXqY4u8QTcq8Oxn2pntVrEIlo/stCyawdNYdVSKuW50aIWPpW8MB1Q8++knnCQfdKfPmACnXF04QaVs2H3/4ZQf75U735XdAYdFWYWbD9hCzNjzUHzHh2Xkvbuq24=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 BN6PR03MB3058.namprd03.prod.outlook.com (2603:10b6:405:44::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 16:15:52 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Wed, 27 Feb 2019 16:15:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:15:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGFon7021770
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:15:50 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:15:50 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/7] iio: imu: adis16480: Calculate the sampling frequency in a generic way
Date:   Wed, 27 Feb 2019 18:14:25 +0200
Message-ID: <1551284068-4882-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(3190300001)(189003)(199004)(44832011)(486006)(476003)(106002)(53416004)(126002)(2616005)(116002)(106466001)(446003)(11346002)(72206003)(478600001)(7636002)(77096007)(110136005)(54906003)(8676002)(186003)(305945005)(51416003)(26005)(246002)(76176011)(336012)(316002)(50226002)(426003)(50466002)(2906002)(16586007)(7696005)(4326008)(36756003)(5660300002)(47776003)(356004)(8936002)(6666004)(48376002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3058;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbef9041-6b85-44de-edfe-08d69cced819
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR03MB3058;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3058:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3058;20:+QKzptwphWA3i9h1aDenizoSzPsfsGV5zHJ8PT3rrlsHwAZB06n0+1fbU4NIZqVxZaruHUS+rGkcwTyb70JDWb5pNeqDR57kS/D1a0lXKCv4qmGfFc4BQGDS5n8ouAgVGVaSTs9IKzvrY7uzVSC5G0fUM/6qdfCzFuCEoy55xJXbrniTUDa00Rmvevu5Xt22Bwy33zAOhPVpiJlW4031sZ4DnAezpPPVMeHv5R7v+YafQpVIUMFAh2w6xtTvZykAF4jlVYWMZSpC4htqEjXYaJhkwkkM/Du+ddOtyrGurPuKgRqLmhjvPX+6UrgIGugzWqqLoXjKMrDMab8c7/tfS9jAk0XFroYD9nVyFHHAVu1uFIvhqfI0qOhaNaYOZEUXymK6OfKuy9iDSXNbfI3CQ6/9Qae8lIOdy0Ygq3nhj2btakEt7Xg/09hAEubTembuRfxMoPV70qNZKyUAZkDUSbAJjBB4KS/1maZV+O5XpHEFFeP2FVsyQ3PEIPQN+uXo
X-Microsoft-Antispam-PRVS: <BN6PR03MB3058E1A2548FCAF5FA16DE9C9D740@BN6PR03MB3058.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3058;23:xwoT8pJLn7t6ul1qQVcsWHPlNfxqAM3bzE087k1YQ?=
 =?us-ascii?Q?l2eLOC0Bm7su3m2Gt1DbqsdND+9K6FroHn0mOv6wbD5ss5uToP8fE8AoNtib?=
 =?us-ascii?Q?i15KsXQ91WK7OqUnYZHpcQh2o75k8p6Ve5B9HtIMKrZoKFQ1vs8C6qYqwoQF?=
 =?us-ascii?Q?f+DrOE6bqtZt9SDB6788drDvG6L7pTqJ893CfQSbDVNX599z8jJfE+aIKFbA?=
 =?us-ascii?Q?IDXGcjQJlwiZSWNecMRZUpFB6paLPv9WcDFTKOzhkC4+xcDO+bOYtVTfNwsk?=
 =?us-ascii?Q?DRWFrnhqE89QWe/36NbWWupEWOhzh9vHPwi1ZKiVkOTUoikTwnNAApkMecPr?=
 =?us-ascii?Q?DtUbTI2V0GPp00/2bIofggRuQW91JQy+zvt9QoW/TcyP+Z9UakUeDJYu6ivH?=
 =?us-ascii?Q?LE6I+lqc7EciTu2PtfzX6542oKEClsu2a57Bjgp5JLSgenzFTwuwfCO3wnRo?=
 =?us-ascii?Q?vjg/iS4GoAEvqSdOCldiVYh6dVxA+Fhdee44iTVKT2GM0q6nykV0Dc6J30qy?=
 =?us-ascii?Q?fpIWdfasLmOPgqk5036QYjV6hSwHgiv+8GJWbN/Llh8xSPUZOrFq4nBFpfSo?=
 =?us-ascii?Q?EW4fOWi6/6Xb3B8eFv5pC6L5f10G9kWqNgaN+jy5xNK5FONjGksdCx1TuKGX?=
 =?us-ascii?Q?+WSRJQ6yd81usf7ltBCk7EmsAZJgcuJGqw81NcZ7G/K9tBK/c/QsImrUH9BG?=
 =?us-ascii?Q?6IOJmzfMJVtqG4Fllnpk3fuHRKyLCC5BwBQOls2bIrmvPCxJtO/5Ge+0lN0z?=
 =?us-ascii?Q?BEreay87/2DhVXuFUL3nPZQdE7ZJmWvoemlH4xSZe6NTQMrpiRPdWoBk1ypu?=
 =?us-ascii?Q?fAIahe4kPhnKUygLlrnhWyzf+9iIr3BqPcfVsORdV97ZtlZ6tuaTb3QdmIo9?=
 =?us-ascii?Q?YIs8NY51zVaMExak4P6iSQvG4MpSpdqo4i/TWCA6s8QYc8hfWS65SZLKELLq?=
 =?us-ascii?Q?4pWR+swj17UrrkdbmEo4DGTdHFVd3JfykSUgD/U5cgunZeizVYDVZekrDOn5?=
 =?us-ascii?Q?TlcnD1ItEQEhg9Pj8e1Dw9cOihBAzBkem7+FbDmRfADtRww3SeMq/PiY67pS?=
 =?us-ascii?Q?bXlLXFZNHcNKpqn0edU2C3Aul7M1RuK4Jnduj3HrqmdSoyeZg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8xI9um2IetmckL7zzI3UtlAonMNLv4wz88F/BELH+yE570FaXzmCUoEfu2sgqC4VUmGCgFGE1yxwYGIh64HCpxTBrUIAgqb0paOPBP9xzGQeTVp0cY/XL2sfyUxoOLrQt5ORXPS7NFmYNdcIjnGgmejdFbwNDwCwlUzWBoFzu4h1GC9lJfvjssD3ByhiEgnQVDwEc2X0IesmL6zaHmQSXE7XZaHzNDcDVuZ4k5PQcgvJy0wiZ4FVn+kkuERrJZeDgd3+45TKCfUhmXWo+qH9jNA+DE5djgE4oI015gZW5VIBuQtAtEAEgsO0Jqj5hSoPOcxv7jG/kElQH+whjvhMxcZQE7sGxqEQakhSIWm9YkvlsRtK6DfTFLE2Rx+lSYnDydg8QGUgjKx22hGIMKsGYwWXmKZKjyq17neYT2Ne7eg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:15:51.5962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbef9041-6b85-44de-edfe-08d69cced819
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adis1648x devices have an internal clock of 2.46 kSPS. The sampling
frequency is calculated by applying a decimation rate which can take the
maximum value of 2047.

Although all adis1648x devices are similar in this regard, devices that
will use this feature will be added in the future.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 5a2864a..92abc95 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -125,6 +125,8 @@ struct adis16480_chip_info {
 	unsigned int accel_max_val;
 	unsigned int accel_max_scale;
 	unsigned int temp_scale;
+	unsigned int int_clk;
+	unsigned int max_dec_rate;
 };
 
 enum adis16480_int_pin {
@@ -299,9 +301,9 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	if (t <= 0)
 		return -EINVAL;
 
-	t = 2460000 / t;
-	if (t > 2048)
-		t = 2048;
+	t = st->chip_info->int_clk / t;
+	if (t > st->chip_info->max_dec_rate)
+		t = st->chip_info->max_dec_rate;
 
 	if (t != 0)
 		t--;
@@ -320,7 +322,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	freq = 2460000 / (t + 1);
+	freq = st->chip_info->int_clk / (t + 1);
 	*val = freq / 1000;
 	*val2 = (freq % 1000) * 1000;
 
@@ -726,6 +728,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(21973),
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -735,6 +739,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(12500),
 		.accel_max_scale = 10,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -744,6 +750,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(20000),
 		.accel_max_scale = 5,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -753,6 +761,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_val = IIO_M_S_2_TO_G(22500),
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
 	},
 };
 
-- 
2.7.4

