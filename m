Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31DFC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50105208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="o4cx7F0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50105208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbeLMMrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:20 -0500
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:57580
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729120AbeLMMrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCJbW75sZrRew19yUY6Sbhbd8WY+zTlGken96V6lJcI=;
 b=o4cx7F0sPbmqDdpSMdrAoA+clsfRyv7ids7Tefg7tE1qSNz+rev5TU8E4IZVVHiTlTE+Jmja1WSxZECZIhI0QjoqZHD0LYe1j87/5yZtVUx+cmMxDZBeF7jwTQp+W38c0CvebQrSRh4gP/z0vvKk4xPLK3AuwRwENBUC3rZCtv0=
Received: from DM6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:40::14) by
 DM2PR03MB558.namprd03.prod.outlook.com (2a01:111:e400:241d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Thu, 13 Dec
 2018 12:47:14 +0000
Received: from BN1BFFO11FD007.protection.gbl (2a01:111:f400:7c10::1:108) by
 DM6PR03CA0001.outlook.office365.com (2603:10b6:5:40::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Thu, 13 Dec 2018 12:47:14 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1BFFO11FD007.mail.protection.outlook.com (10.58.144.70) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:14 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDClEbu004154
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:14 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:13 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 04/11] staging: iio: adc: ad7606: Use devm functions in probe
Date:   Thu, 13 Dec 2018 14:46:16 +0200
Message-ID: <1544705183-13288-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(3190300001)(189003)(199004)(16586007)(186003)(486006)(26005)(76176011)(305945005)(446003)(36756003)(2616005)(476003)(77096007)(126002)(11346002)(116002)(336012)(426003)(478600001)(51416003)(106002)(14444005)(44832011)(72206003)(7636002)(356004)(7696005)(8676002)(2906002)(48376002)(106466001)(50226002)(5660300001)(316002)(7416002)(8936002)(110136005)(54906003)(50466002)(47776003)(4326008)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB558;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD007;1:PxxhUiFPqhT0ybREyffc3Yq2AprLQUMKmsY2SvwAb2wVErU6dZCvUvIERdCArYU+Fal/9cpzSRolfCQz5/hPJmB2m7G6e7a8bnZTPaoGHlUZ5meTHreJh8B84kGFxXhd
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f09352b-f808-4694-ea8b-08d660f91b9d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR03MB558;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;3:7St1/WrBgICxkpDFt1DZmX0B1RWzqXMmExJSmjUBLZ4Z5t8d8S8C/cbjCiLxovK4ldsvkunmLy4SzFnvY+XwfMNDikj8YID00fsY62xp4WaQL9iwifQPveetstvSym4jqs8IyjC7qOdh8hKTEObqpnwdWQZ9xmpAezGb6K9ZXMVw7ti7I5xUHPocYSlcAc2+R5k57GtChdkid1g3PoFO/+018P+gTrGxPAtdwTtHrDmoKEG3M6xSF7lyfW2td3eWeW/y6LJSpv4rH6bTpHKo07wl4bYGm6lnqyPZtPzhtnpARCoAYwChfIxu4tQqx7iPRFZLFfhxyuP3aDCW8Igl2UdtcjmzurWqm8jk4jOGVbg=;25:pLGZZMlYwzDYZVrYmYWNJdLSsuDi3Op2kaK8XAS2HUind1Bv8P50CRDsnbFJJR/nqMSAKkX9VJJ/kKJOh/gzHYMgXGLa7vmNyTBooBGRTr9SAtdbV+8UfNiF+eN7eZHmM5lHp7ADfwbHG8YZHm66iVAeaKd9BkL4O4EWXEdiAbv0wwAV4fndFgSQuloD0HqPm4JkyBI4/wVhmsilEgb8Mzb0XcbNXJyUAyFDuudBCAtxlXgoRzRId5Pdcwn7qHDKSfR1p+YBL4Qxemy23XSB07U/hfI/mshd0SgTqQGIIznq8b2qCdpi8U9uGkh4Hz6+ZbHQBtlyJJJiF4Nu8W948tcaU/eTuzAZevuqpNaDiBw=
X-MS-TrafficTypeDiagnostic: DM2PR03MB558:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;31:siq56tO3MaICuUC1WdVqepYc7+3tf/lgU7ju4WfkVozb/xSMnLIaeWEspzrbLDaNnrZaKk/NSOqnudOcKLc+i63DubnJYZ811/op4AiFNHsYuurM4G0G9MJx4Bo3fppTEpmFmnKzrqpWi9Z0vQIuffGp9QisD3tTkkTslkvvXaHSQ6L4wT+ATpMIp/LoQJXxKxzUKdHXj+KVO91DxhFYAxmputC/M1gwxm0cKzs45Jw=;20:CjErwLjQg65+St/q0l1KPmaAsPnPoMxZhsotsJNQsuCO2dq5myNBXqY+T1Q2OzpZ4fWbxZ6RRlN483hZvDcdCNWE/BWMqG9AXnhOt8jBn9sZYCtcgwm/nGnSs76p0jOqpQx+4vE7NbLrNUteqpomhmfNLphZjYt0HiTP4PVuxAPgqC9bjbIsYZuaikYnohkGfxizT1knbB2MVu6USJHFpsWsbA0oVjnVACT7Sv9TLAri5V33WWWu8odg96ig3l489UKej189CR5jsKlciP3CUH7X9Z7jljJmRJTVtCM1gEslKrwaFvh6MZrIMq3F2BuZKx1jmnKqnLpw3Tzasi+8x3jMkX8puZcQ2u212pqmld//Rm4Yz7Xy7EaC2JYGH3LC4s3A7aqC5INQn4KXuHh/e4n2u31dqLBm/3m3xKedtFevFLEY5bbF0ziT1lWmx4H0RTze1ezezFq2qLymxHuWmgTd6nZ9V22Oep8/iaysAzp5qR/jFK1phTIrKByx/dXD
X-Microsoft-Antispam-PRVS: <DM2PR03MB558D4CE1B7F1976CA37A38B9DA00@DM2PR03MB558.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM2PR03MB558;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB558;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;4:qgcU4DcjaAp0FHmhROaLKZmeqSTuA5EFvBbL/xGKjztMsm22t9ONB4ZWRX7+P/kAyXbmo394KC+1l1Xx/ZxQDk4MtK30C/gE7tOadM2J9WmiVgQxrQUbz8pZj7Vx1q+BLlQO54S/e9PqwigbaKxwOzjrj9meX1fVgVIgFLcq/04Q9M8eITOPYs1wfRNkXO/6hJQueyne22DwIxoE07q+8kq/7vr/UtDNFS6vMZ5TYBKu+aD58AAjyeXLMfiuKfJWXc0/vg5HdxPVrQoM7C4Yhw==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB558;23:8zcPA4Q4+0SJr7X89QAJjCMIgPaQUcJ3ZqOYGzpoey?=
 =?us-ascii?Q?HCewzo+cKVGvWANB9eZq9guKLLogTwmosCKJsJKefBMv7qQ2L78qIvFh/zEv?=
 =?us-ascii?Q?BG7aDF087Ur3ttCqrgdN84sGj2sn5roMnUuvurrhuyASS3O6b2SCRzBOs8uU?=
 =?us-ascii?Q?NyXvOo5DBQqjf/L1b/NCqoDhiwGol5bfm8xJLTQZyZW8FDaFsJIPzA8YRqkU?=
 =?us-ascii?Q?+cBMnBrrY13zpG9lV9Qfy6urA36R9fWErvaldkZeGA78JuLR7Ec0P+VLMj2e?=
 =?us-ascii?Q?4wmQOwurNso0F9q5JWwW3wHkzV0VDDupqq4ViGHQ7ITygEBL8fOTPein324R?=
 =?us-ascii?Q?oUIGMIYQ8Yzwv0I5sd+6UePJl7+vCFSiWFnn7KkCqvFxrpwjkedZlGmhjn6N?=
 =?us-ascii?Q?9w26l9lm+gUSdolk4iRpwSjzlQE0ac5GYnzPOLlit2To/b/BVBEBMwZmIejY?=
 =?us-ascii?Q?ZxAGmt9jJvBnSRhgy7Xi3ciUQnmz4OC/F/VR+JEKYXE7KpxhZryLk9phj6O2?=
 =?us-ascii?Q?l95dVTmSrENkpxRk2BoUrjyAsxNbYRfuG3SDsmskKgiHx4xjq2F9TUAa+nzG?=
 =?us-ascii?Q?gThkfTvN5NQOjLEHRQZg1M0w4uG0M+1JKAA6E+e49e3RdLqMIiXnzrXsHbvI?=
 =?us-ascii?Q?3c47pDw0GgZosjKxkhNTIjAnnfBDhenjvUkVGoXJRWQF8fukDygf9muTNmTk?=
 =?us-ascii?Q?/22/fFXvnaDbI32bMSKBVVkB6gpMie7sGFWJuvhqtYRQOl3s8OAkF+dD5yrO?=
 =?us-ascii?Q?vUyQaDHPfH5ZbPPnqpl/5Zr5zBvdzC1SxL6vpCJuWI9+4Sn/kPTGzK6ByOTr?=
 =?us-ascii?Q?S6XScOCIERpPXxCTlxGYs+ou4G2w0sI7fTJsy3mwX+9KGp9fLlBDcR4lsLuu?=
 =?us-ascii?Q?Boombu1kjtzx5bdM3QVjokJPg0MucT2g5DvA1aTr6eSkVAI/iC0MP8LcJ2UJ?=
 =?us-ascii?Q?oYXmO/qAClrdez85cpVYAM7u5T8LLHKKBUZXbyfnqENFcW6+ivQJbfij2+7J?=
 =?us-ascii?Q?iK6TGnnU5itRfWPs/1BTXs4rBKIunwy8sUcX1AxLr9aHjjo5j46FdUu1oLfW?=
 =?us-ascii?Q?rD3vVSedD7P6IrVZAcGrCWmAwt?=
X-Microsoft-Antispam-Message-Info: PwfDatLmyNny9bvGov3m6lgNRjj1GgOU8LLoRtSwsrsZZHZnB2X3jUnl3hBLXYU71aWNnlwq8y0VSBYW0QOLGfm61HvbbtJYHGq3WDR6L+Q4lLOi2kvwn/yRkbcuntqnn7cWPMcjhueT6YGigb59y1K+dK+kQ48f4jIbcI7mvDaKmZoOyUmUWnWW2D7+4u+InGIW8HTgCKArxv6sYwCGdyMy7MIJJkYGmeM2keVOMFohjtmQ7vVtH94tRN+D3tE2L1JKWSIVS90gkFBW9pN2p+DHAEND30rEywxF00z9tvcD4zfXc76xfR+Gu0P6IOR4
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;6:nAzCpi275zmlp9rFUHBlDnTHfojrDViHsQEyxDlT/ObFq5Mza5Y0c5jxtxcqNBxkGAxoke/UpMAvCJQx2HU3B6rxwFMWfGnDQOihHqXvBXd2roMqKRW6Td+Fdwl039kGvDFGKIF9Thpn1RC0xphWlmUKv1qm68xBewstoYNHPO7j+6MENuc0Xkyh8EebJ6/iZpqKW133+mghKgmcU2ylpEVH7ACrDPleGBgdPtOBfgx+OFgzBxIbC49cFW7zGJYpz5ccySTy0ymQOQRXiSaCN+umjoLx5MFTE+rTSCAgHKGgJuWCRh925ltM5CrJv3FwaI4jn6Uyu9wzIZhZttHhuQD807dEgKiEPHMD8u1kZBBn3QAW9TNlT73HWi9xY4hY2EFjFQyajhn1zikPH+X28J4vpWip1LuxU3j69SiL3YneeQpFf2kEHw37JDHSe+Y4oKtvwSyllM5s99QNzeOJCw==;5:7X97ZG1JJr3g/6TZl+csC/VHJgliKbDYZ7qfXm6NzFmanjbmsBdihquHv6/lgxN8WYUb9nSX0AQl2UvVCdDjfkOhVXzaWIVY0U5bdIaskAouLdJctC5eZ5ZkhADTR1WorsvtcYQvaInPSsUPMG3B0KmZFE0a2dqMbpV6cC4Yz8M=;7:sYJ+UKjn0QqVMIgSyZV2McClxAMdBbKT8Bk/LYsM3gNjqoOx04wIf2fW98TVY8aSTJOtXskuGWoUR3RGZLzBVUnc687mt/NVlfTNHeAEz/hqf3cQCm0leiBB3JdWSFo06XmLPsu3a81ufaJumVo0+A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:14.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f09352b-f808-4694-ea8b-08d660f91b9d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm version of request_irq, iio_triggered_buffer_setup,
iio_device_register. To avoid potential ordering issues in probe,
devm_add_action_or_reset() is used for the regulator_disable(). This
simplifies the code and decreases the chance of bugs.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c     | 59 +++++++++++++-----------------------
 drivers/staging/iio/adc/ad7606.h     |  1 -
 drivers/staging/iio/adc/ad7606_par.c |  6 ----
 drivers/staging/iio/adc/ad7606_spi.c |  6 ----
 4 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 4b1bc20..7191d51 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -417,6 +417,13 @@ static const struct iio_info ad7606_info_range = {
 	.attrs = &ad7606_attribute_group_range,
 };
 
+static void ad7606_regulator_disable(void *data)
+{
+	struct ad7606_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -430,6 +437,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	dev_set_drvdata(dev, indio_dev);
 
 	st->dev = dev;
 	mutex_init(&st->lock);
@@ -450,11 +458,15 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, ad7606_regulator_disable, st);
+	if (ret)
+		return ret;
+
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
 	ret = ad7606_request_gpios(st);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	indio_dev->dev.parent = dev;
 	if (st->gpio_os) {
@@ -479,50 +491,21 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
-	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
-			  indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
-					 NULL, NULL);
+	ret = devm_request_irq(dev, irq, ad7606_interrupt, IRQF_TRIGGER_FALLING,
+			       name, indio_dev);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &ad7606_trigger_handler,
+					      NULL, NULL);
 	if (ret)
-		goto error_unregister_ring;
-
-	dev_set_drvdata(dev, indio_dev);
-
-	return 0;
-error_unregister_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-error_free_irq:
-	free_irq(irq, indio_dev);
+		return ret;
 
-error_disable_reg:
-	regulator_disable(st->reg);
-	return ret;
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(ad7606_probe);
 
-int ad7606_remove(struct device *dev, int irq)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	free_irq(irq, indio_dev);
-	regulator_disable(st->reg);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ad7606_remove);
-
 #ifdef CONFIG_PM_SLEEP
 
 static int ad7606_suspend(struct device *dev)
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index cf20ca2..70486ef 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -84,7 +84,6 @@ struct ad7606_bus_ops {
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops);
-int ad7606_remove(struct device *dev, int irq);
 
 enum ad7606_supported_device_ids {
 	ID_AD7605_4,
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index db2fede46..6269ee7 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -71,11 +71,6 @@ static int ad7606_par_probe(struct platform_device *pdev)
 			    &ad7606_par8_bops);
 }
 
-static int ad7606_par_remove(struct platform_device *pdev)
-{
-	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
-}
-
 static const struct platform_device_id ad7606_driver_ids[] = {
 	{
 		.name		= "ad7605-4",
@@ -97,7 +92,6 @@ MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
 
 static struct platform_driver ad7606_driver = {
 	.probe = ad7606_par_probe,
-	.remove	= ad7606_par_remove,
 	.id_table = ad7606_driver_ids,
 	.driver = {
 		.name	 = "ad7606",
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index b6553ce..9291598 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -48,11 +48,6 @@ static int ad7606_spi_probe(struct spi_device *spi)
 			    &ad7606_spi_bops);
 }
 
-static int ad7606_spi_remove(struct spi_device *spi)
-{
-	return ad7606_remove(&spi->dev, spi->irq);
-}
-
 static const struct spi_device_id ad7606_id[] = {
 	{"ad7605-4", ID_AD7605_4},
 	{"ad7606-8", ID_AD7606_8},
@@ -68,7 +63,6 @@ static struct spi_driver ad7606_driver = {
 		.pm = AD7606_PM_OPS,
 	},
 	.probe = ad7606_spi_probe,
-	.remove = ad7606_spi_remove,
 	.id_table = ad7606_id,
 };
 module_spi_driver(ad7606_driver);
-- 
2.7.4

