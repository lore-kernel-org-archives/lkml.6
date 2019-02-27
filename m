Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC0EC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301CC20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="lk8A0yiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfB0QQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:16:33 -0500
Received: from mail-eopbgr810043.outbound.protection.outlook.com ([40.107.81.43]:7296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfB0QQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qVyqs7R/HnXeTBRRccmCqefK/S6u6iiA8X05YV5mGA=;
 b=lk8A0yiCqm1eqWvkVj2q4yPfmCkHMNILkmL6sG2zmqArseKT47GeYRdLfgUpB0L8gtzLiu15ve4tUV1Yh2xzkh6o2J6zbMDhsM8qzos3uX/olcijbh59IHJknFAAesweX5YA2bUSYylZcn13c174IORWk+/NFmqCmq+EwLdmaHA=
Received: from CY4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:910:4d::32)
 by BYAPR03MB3751.namprd03.prod.outlook.com (2603:10b6:a03:6f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Wed, 27 Feb
 2019 16:16:28 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR03CA0091.outlook.office365.com
 (2603:10b6:910:4d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Wed, 27 Feb 2019 16:16:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:16:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGGRQr021935
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:16:27 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:16:26 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 5/7] iio: imu: adis16480: Deal with filter freq in a generic way
Date:   Wed, 27 Feb 2019 18:14:26 +0200
Message-ID: <1551284068-4882-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(3190300001)(199004)(189003)(77096007)(7696005)(5660300002)(76176011)(51416003)(316002)(110136005)(54906003)(16586007)(48376002)(356004)(478600001)(106002)(50466002)(4326008)(50226002)(8936002)(305945005)(7636002)(11346002)(2616005)(26005)(476003)(8676002)(44832011)(246002)(336012)(486006)(106466001)(426003)(72206003)(36756003)(186003)(47776003)(53416004)(2906002)(126002)(116002)(446003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3751;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdf77b2-ed23-460c-8fc6-08d69cceed67
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR03MB3751;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3751:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3751;20:2PqprMrYbnec2u8Gda9sIxXXP1kBb5+5LGTzO+u76+IViYkjF5Ao6MbulGc/MY23yi25N40ykpWDGcbHjzpiMoMX7V6/JWloNt1Kt/4sjtYvGnIWICnYUeFP0Gmwu2F/dLd3UBfEZba0vQX3OPnBgv+1uLd3fH15aEQWDAUM5NkkQMWeXsoaHkAw/fx9b49/QzunEwezICqECUowmUr1hDozeK9n2D/LKHTJ8R46V2yISqALp11ElEjKLXghri6hf+87e+RBOt4zC0v8ESLlUEEQLRaWMDlH+g6N3rrnxahz083aLru8csaZVwYj37zoip0kHvR2+bWiUwLldsbMiGABFm0WldVbF74Wb4hdPZ3Fa0hJ1ouJMvQ1pmJXzu5vxIkT9CJKs6R0ojSwhAFcwBJXEEgoDUqztE5OnOVdapIQxi3416A/pryZaUyn9wMCQ5L5j7cNaRR9pVLBlzBj1d5dGxJSPV+jOFFQv7U1dUnx0J8BlomzLiycaYKAm24f
X-Microsoft-Antispam-PRVS: <BYAPR03MB375192BBCA1B66DB338EFB3A9D740@BYAPR03MB3751.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3751;23:mKqx3VhoeDcbnS7xK6DO3urScXqiqd5AYoLNTStcZ?=
 =?us-ascii?Q?R7zNMYEsHWdVKPlJa+PJjC09L0urY6TwdcEqeyQreGYIU7GKIyNTsr/AqlEJ?=
 =?us-ascii?Q?SaIIwX/9Maxxf7516VmeC3VqSsS958HBIrbhHIGScVVacKtyPuQOBGiaA/OL?=
 =?us-ascii?Q?j2W81xRVEJ8VLygseeEddsvm+Rh9zkJA0DzH3ZMGUs3oWUfWAI5+4fCF1dTS?=
 =?us-ascii?Q?p3tCVP5bnF3g1135rXfok9u3WqWmVkynKnF09jZONm4zqrl6SiwesoNvwYFT?=
 =?us-ascii?Q?DbLF7KvYvfUsNWdH2zmk0SbKPbirKq4kKGPCRIrJZwV+d9dGPIhoQ99Gj8c7?=
 =?us-ascii?Q?5PESiPuzp7ZWFHA6GTK71X9Fy2hHls/YW9I9nI6J29VuW8PpLhuZEMq5crNV?=
 =?us-ascii?Q?y7Rr0TuuL95H+RWhqxdT6ALaSuj+l4MrMlbVZJGpSHi+gubQyupUrifM8fqy?=
 =?us-ascii?Q?8S2sOFb+Fil72cSF5tHUnOUXGjN6IsZBswseJuentraKLNzfCKgsfj+fRP+B?=
 =?us-ascii?Q?guRV3FIBJUgFvptt2MjoTPcKyi74AolseQYt72V+alXMvoGuNiw4Ipf+EeLl?=
 =?us-ascii?Q?52wqxRzC53l7bo40oB0aREKpzZCZrkfgLm2G87FxjTfd168x+dKDI7iAXXdM?=
 =?us-ascii?Q?DqPsyO83wsbLJ0Qu7nVHsxwv+hIv5Zs8qRfQ4t5GIfQdzCxk9052d7g+6Oy1?=
 =?us-ascii?Q?xxqUOaLFBA23v2WqFk9prAEm/X7mCVzpfX5ahfFEhLG7saVjtBANSIsHJCKH?=
 =?us-ascii?Q?4r/yhd2eiHbZQmur95u7XY6nnWtXv6fBvhWTUMrwDRI4b8jBKf6mYpINT5pd?=
 =?us-ascii?Q?0klVFke2fmAdxCogw0ZF1+xj4nS6IQ6LGZlHPA6l5yEWAeJW4zUoZKgYrZtP?=
 =?us-ascii?Q?+QQXso2cg4Sn12Y7bwTX1BsqxDLI5Prb6zTSVC7OqmTPd+Tj3HIJNF0XCtrp?=
 =?us-ascii?Q?KbxCj64GHwIIqUKD6gaxunXs4gWB2vNrss/opsPstvSmhrQJ+lf0DALiMSnl?=
 =?us-ascii?Q?aGI1PC3YWtXqBsjZCxnTPD4X79hXHUyar6avOLNSmT7qgJzX1gLsYbL1fvFI?=
 =?us-ascii?Q?f+bBTDrfZLTQU4ZLt/lgdKocbY7?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ooe+qzAKbXdl4y4CMPV8/teAiJWSdqoJu2tJIXrw9Blsw88yZN65DXAC3vnAk6f2zbD3yK52vvTBIxeTCs+tB4/Rqjl2J0Hj3/pRQGjCo2vNePdyncLLo8tEVrOBpoendmHoStW9OwuyMQZhu9XpX5fBock80vXCkHeoc/sANyjuSpZ5NmNuREcr7+DkUkTsl8dxrWln31neQwXpez7fCa/CiP4+jJsc1u8nKwt5QsYx7QiHVPpiSVbc8nkh4xYL7CDNg+72/eIfWLJhgbsjgxSYmA5GnJ0n8h7uA5rIrzlxzm9u1bFT9AIhfPwJrAxXT6rhKnkQwDjgmxwbE/z3abWDVuJ9byPF37xYp0fMY/3zqjszb0FOoTdMESx0jtLkh5+CtWBaob3uUKmtbdZmNR+0AVcYXa08Ae8O8EgwALY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:16:27.8676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdf77b2-ed23-460c-8fc6-08d69cceed67
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the filter frequency, the driver looks into the
adis16480_def_filter_freqs table for the best match. Pass this table to
the chip_info struct since future devices will need to use a different
table.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 92abc95..c90375d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -127,6 +127,7 @@ struct adis16480_chip_info {
 	unsigned int temp_scale;
 	unsigned int int_clk;
 	unsigned int max_dec_rate;
+	const unsigned int *filter_freqs;
 };
 
 enum adis16480_int_pin {
@@ -483,7 +484,7 @@ static int adis16480_get_filter_freq(struct iio_dev *indio_dev,
 	if (!(val & enable_mask))
 		*freq = 0;
 	else
-		*freq = adis16480_def_filter_freqs[(val >> offset) & 0x3];
+		*freq = st->chip_info->filter_freqs[(val >> offset) & 0x3];
 
 	return IIO_VAL_INT;
 }
@@ -510,10 +511,10 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 		val &= ~enable_mask;
 	} else {
 		best_freq = 0;
-		best_diff = 310;
+		best_diff = st->chip_info->filter_freqs[0];
 		for (i = 0; i < ARRAY_SIZE(adis16480_def_filter_freqs); i++) {
-			if (adis16480_def_filter_freqs[i] >= freq) {
-				diff = adis16480_def_filter_freqs[i] - freq;
+			if (st->chip_info->filter_freqs[i] >= freq) {
+				diff = st->chip_info->filter_freqs[i] - freq;
 				if (diff < best_diff) {
 					best_diff = diff;
 					best_freq = i;
@@ -730,6 +731,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.filter_freqs = adis16480_def_filter_freqs,
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -741,6 +743,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.filter_freqs = adis16480_def_filter_freqs,
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -752,6 +755,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.filter_freqs = adis16480_def_filter_freqs,
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -763,6 +767,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.temp_scale = 5650, /* 5.65 milli degree Celsius */
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
+		.filter_freqs = adis16480_def_filter_freqs,
 	},
 };
 
-- 
2.7.4

