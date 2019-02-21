Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D128B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="CQO2NL9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfBUNSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:18:30 -0500
Received: from mail-eopbgr690076.outbound.protection.outlook.com ([40.107.69.76]:45455
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfBUNS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd6H88cue4xQ5ULy4n5p8/myF0JpGwcb9KGsvanppis=;
 b=CQO2NL9jBD3oLGvdLNBz37PybE2THYWH9F0Uw2sZBrWe66McF9AS0f+fDBh0YXaMZ4xZ4Twufc1z6wHCn7dB+jsOwUQC8pFazJAO4mEA8bPbJHDqt+D2utH1Q9eemRJw82mLDnezeRLh0TCXICOL3rTCnNGoa87joCMAktGOjT4=
Received: from DM5PR03CA0043.namprd03.prod.outlook.com (2603:10b6:4:3b::32) by
 BYAPR03MB3512.namprd03.prod.outlook.com (2603:10b6:a02:aa::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 13:18:24 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM5PR03CA0043.outlook.office365.com
 (2603:10b6:4:3b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.16 via Frontend
 Transport; Thu, 21 Feb 2019 13:18:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 13:18:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1LDIJdo003781
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 Feb 2019 05:18:19 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:18:19 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/5] iio: imu: adis16480: Add support for ADIS1649x family of devices
Date:   Thu, 21 Feb 2019 15:15:05 +0200
Message-ID: <1550754906-24640-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
References: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(3190300001)(189003)(199004)(48376002)(186003)(77096007)(6346003)(50466002)(26005)(5660300002)(54906003)(106002)(36756003)(110136005)(6306002)(76176011)(16586007)(316002)(7696005)(51416003)(8676002)(4326008)(478600001)(116002)(126002)(486006)(2616005)(47776003)(72206003)(966005)(44832011)(476003)(356004)(6666004)(2906002)(246002)(106466001)(426003)(336012)(446003)(305945005)(11346002)(50226002)(8936002)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3512;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f35f4c3-653b-4515-164f-08d697ff0ed2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR03MB3512;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3512:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3512;20:dXtop8whFYSfwtBGLPDxpuCI+E5sA3varyvZ8XOLvyzx0/UiL4sIBibqVBCwPeASOSHM1WZT3gX0/FVrZIU/0lOpzDZ9xmYBQIBEb7Vfzld6Y7APZeZkhGghQJWAwmoGlgGcil34s5pQIKk87NNpFqgerblmnnXbh3JOpCZYU/E7MNhbZS3RxZtJqjX+kBeGQ0EGO2Stt1N1mZIdT2u23pe6pGV9FOMQEHqicFgAzBEY2yuIAgMk/gEkbVvRUZNQ27brcty+lArhPPkY3WKT+O/c6+FqSJzSzUteimbUKmTmpO1Mfo3tuuLOB75attCrBJecNZJkHTCII3vionB67iqDgayjuWMDV8P93n7jRlGccK6xdu+zsw8WIq7MOcLYqXNrq99ofoW0qu1JDbc20eECYWZfuHSewrrFbiDIVDZGlagW7ilWeXtxOiSZLFK2Gd5HD62SwnzmKuSTn+Ltp6yna2pM48XYMqgYbFTpRv/Wqmh9NpJccpWJor4QNUXT
X-Microsoft-Antispam-PRVS: <BYAPR03MB35122AAE364BEC9CDBB924C29D7E0@BYAPR03MB3512.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3512;23:aB/vI96zP+bj/SNXtzHg9A2CxaDWP5VpVSekjjyUI?=
 =?us-ascii?Q?jJn1csW+Dcq01W3jzqSojto9RMqMla2vQ1Q1/ZhkhUQ+Jpl9LsiV37mgok34?=
 =?us-ascii?Q?FTM22e6ajVjnXt4pSzm/3Uy3q3+XxeDEYceSLgYQxGhT7y7WR/ebnNsaX8xc?=
 =?us-ascii?Q?Cu83hsSWgKPWf0v3/XdusHIITAvSAunGR/02ZeKnqOb5UtBsQ+/8uIZMq3nS?=
 =?us-ascii?Q?hi8NXgISei72b2IjA64BbfI+RqBjLIs/y7T/LUc/niDvrnZ5wAUFdCBKKsnP?=
 =?us-ascii?Q?AU/N9WVDORSj2SeeoXEs98DWch7/Dc2N9223xw8PcfsOnbrHH1jEDuBXi856?=
 =?us-ascii?Q?bMwsNStWHP3QUw33005QUzZa43FoR1AIbv25yNJg/pmMfiIEIbEchE9cQh5G?=
 =?us-ascii?Q?8rXxrGOSW47J7T69wCOooGji2CMQ0rcgzsNhuejNoxfj/a7iNdKMC5z3UsaY?=
 =?us-ascii?Q?lT5DMSGIWZpoK5UPBc+gf2HNzm1AxAWQORj22MkUK7hM7GeVvKsg94lEv16a?=
 =?us-ascii?Q?l2O3VIHil9DDxBDB6MbfFYTz+KZrk0UPyXoeOYA/fUOTcr9SozCKN2eR0idj?=
 =?us-ascii?Q?vAl9ZJyQJUolwFZZO6u4nCsmc+cM4m4X7WBOEsN6IPMKAliaHW8tMXtLfKNF?=
 =?us-ascii?Q?0tvnLZgVzj5WjotpcpGnHJnRvapXfK97C1u/28m8iXejZcy+e4mfX77SRUI/?=
 =?us-ascii?Q?tatlHamAUn5zCw+ICTZElwk7OLrXz9gTnzqZb5YT+AuYynxZcHJy8lNIZktM?=
 =?us-ascii?Q?orcwKO12c3mbi6k3dUbairZKWiVWSkfG4JJVRtS1zXt4dCcHD6QvHNpyNmFi?=
 =?us-ascii?Q?TEknvOgQv0ESjx+Nit02KsNo37Ndu7Mebno/V5NzdBo/8e6B958LZMRLgfOk?=
 =?us-ascii?Q?/jC/Ugo3QlKrUsknA4qISATi4lzwhmQ3hY014pXluxGX7GsDI5UrewMJE7Jz?=
 =?us-ascii?Q?E2uE/PYsHpErPvb47MkCV4Quvehkq/l1+Wrb9PH3OlJNaYrd0sZs6vcqUt/1?=
 =?us-ascii?Q?MEzFPa5EXffwup6Al2AdK6FlzqEosbT9G7vK4g59NCqP9IkrEDNREotEKBNc?=
 =?us-ascii?Q?MYbOUQYBvGYFjwRHg94sRcRGlTLHZ8hLXVucvuXljtRF3a5d99MlNbFpt6Lp?=
 =?us-ascii?Q?agQRCxnFLE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: We4h3VCB7tyTS8GBEObDL476V5gxnNyDJduSGNN+OmNBRfLbXwP34BzPN9S+kzCU/6yPzEgqWvj8cp8f027PJVGjFMPH9tsCHuRTBVqUAlQp1W8iBGnGWs9IuU7iTlqpPCfXML9QDdFji6P6KtMzX6J5hnJNGPvWkiayR2HSXu9Zec/yu81XI+/QOyyXSQSIgaR5H7q2c1ZbZYG1kzY2/hyD8EOdgzocFwGt0SkA2CuUzI2nOYfOxuwTYpkXdJqASUqihOin2HSgpB9eS0bWU3iE3gYnKFp4yPWBVsMsXijcbcUPdwOBzdYv3hfbJKiWqQ81oyTBOcHCtIwyZfKy/+6WGcGn2atR0RLt/QaImZtptqFjR66dNPkbBLPWuwsYjgTVMK+OQuwe+CZT9KLvIdx2he6Kyf/EyoHMSo2b0c8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 13:18:20.5730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f35f4c3-653b-4515-164f-08d697ff0ed2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3512
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
index 5a2864a..313936c 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -710,6 +710,12 @@ enum adis16480_variant {
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
@@ -754,6 +760,60 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.accel_max_scale = 18,
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 	},
+	[ADIS16495_1] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 125,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+	},
+	[ADIS16495_2] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+	},
+	[ADIS16495_3] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 2000,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 8,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+	},
+	[ADIS16497_1] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 125,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+	},
+	[ADIS16497_2] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
+		.gyro_max_scale = 450,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+	},
+	[ADIS16497_3] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
+		.gyro_max_scale = 2000,
+		.accel_max_val = IIO_M_S_2_TO_G(32000),
+		.accel_max_scale = 40,
+		.temp_scale = 12500, /* 12.5 milli degree Celsius */
+	},
 };
 
 static const struct iio_info adis16480_info = {
@@ -999,6 +1059,12 @@ static const struct spi_device_id adis16480_ids[] = {
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
@@ -1008,6 +1074,12 @@ static const struct of_device_id adis16480_of_match[] = {
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

