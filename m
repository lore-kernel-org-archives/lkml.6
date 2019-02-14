Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8700C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EF8222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="UGv0uxmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408066AbfBNQml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:42:41 -0500
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:54899
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391003AbfBNQmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkpgmJ7AOd4kaONzecoLxjhjDuUHwCBz95Nqa0+NfHA=;
 b=UGv0uxmXyPZ89eeGikhXdgdxt8YhOwSmzoiMSqIHRfSWvv0cByUERCKM3vijN9HKxFb+cP7PraqBBWlz43LyfS5fXZ73DFWnL72Ro5Kx1mV/imhEW/qiazgBXrgDqs4sU10WN9+ZBEV2QVJHkRtoy2prPSBbFCewxvNq3FAd4ik=
Received: from MWHPR03CA0028.namprd03.prod.outlook.com (2603:10b6:301:3b::17)
 by BN7PR03MB3748.namprd03.prod.outlook.com (2603:10b6:408:23::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 16:42:34 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR03CA0028.outlook.office365.com
 (2603:10b6:301:3b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 16:42:34 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 14 Feb 2019 16:42:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x1EGgTle017053
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 08:42:29 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 11:42:29 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 2/2] staging: iio: frequency: ad9834: Move phase and scale to standard iio attribute
Date:   Thu, 14 Feb 2019 18:41:30 +0200
Message-ID: <20190214164130.30085-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214164130.30085-1-beniamin.bia@analog.com>
References: <20190214164130.30085-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(3190300001)(199004)(189003)(186003)(106466001)(478600001)(106002)(54906003)(336012)(4326008)(2351001)(50466002)(14444005)(53416004)(86362001)(356004)(6666004)(26005)(77096007)(2616005)(446003)(476003)(486006)(2906002)(116002)(126002)(426003)(44832011)(11346002)(76176011)(48376002)(36756003)(107886003)(1076003)(8936002)(51416003)(7696005)(246002)(6916009)(316002)(50226002)(16586007)(72206003)(8676002)(305945005)(7636002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3748;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT017;1:/c/sCwQVcKGIaIDKt5C5nurICfkryHOeUofu1Xyy5M2xdUdGd7sC5Z4+kaNwWWFlCMU3Vtbn3MLuqukbMe0/RwU8X8emqNwoW8wnWgxBHiKPgPpgmr3AGOA6lQMKb2N45UcGY6+TnodoNFUuZ7g7+A==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a7c4d05-b46f-494f-faf0-08d6929b6b1d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN7PR03MB3748;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3748:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3748;20:wGZs9Yyg1vtrOM6lkGQbYZk3qAy69anXCmKPDnWp1bUA4NbnBxxGFzq4pCqqJe1lgAdhQs8wkIhirHm/DUgvnOs6a7OUEMq8ZKZpRrJpaIWh/W/WU04GSWPNqjK+GsmIPuTfMxL9Lwh+ZjwXgLVsy1/41T6Vq5dsq7u+f3l5kVyqPnW7a7ZzZdz4E4CRNowAzj9+RQ84Ph4FJMDZm2o7kgkJc9T0cHzzKLCyzj6LnN6cB3KnE9/xnLswdH2oqsFo15+sRcW0lHFv0x91NSjzLIxC+vlgg8lHTfIMqvB3Dk9p+rLzLWJPbb75QAL3/tfqkTDXmu1SyZHwveY36eOrIa6ByTgYJqBRUK5T0BG2H2PHqNkWZq97siIlN3cxzqgmsfjbOri7rx6SkoERnhz3+zYXLzoaIK33MDT9g4KMuGaNJzzs3cgWdPO1JHJomp8nldHTT1Akl5PP0IfILogD8jOJhUqu1QiJ3jAKY0RU2Ojae8w1u3m+pCNkBcd7vwTr
X-Microsoft-Antispam-PRVS: <BN7PR03MB37488DCD72BA28B1E8BF4E07F0670@BN7PR03MB3748.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3748;23:wCHCnB2bYh85AfgEwGbxIaV+8LOM7AT+8ydLbMMKE?=
 =?us-ascii?Q?ZPoHMYQS3eQizFjFsfXV5zzoo021P7vGXzkEp3Zh1nagrZnNmiKAO24DzkYh?=
 =?us-ascii?Q?/2G1DIN6eqI0BJJP1uOQr7BGOxqN+9Q9+uEqZPBAQJ/gUZ9a+EIwRz+jn/Kq?=
 =?us-ascii?Q?P3SbKPtj8Bu+Ez9kD2cKZ2j8TcqrPpp/wkIGkS+6QzLFj3Q9rZZPwSzfsIBw?=
 =?us-ascii?Q?jFG8Ji2ztFXCJJGm3gfwwG72h6UwLzA41/kNVnPlWfJYKCEgXNvy4HVdkCdG?=
 =?us-ascii?Q?m2nfJNEpzLEDgRWrHzDVLwx6KYPwl1XBJfJNB250euD881VAlhl5t20bf/NQ?=
 =?us-ascii?Q?gq9SPJ2IVqc7MgIHwo7HpG8XgXRky4up4Q2Swp2mcK1aeeaCNqJlsWIPj0ak?=
 =?us-ascii?Q?TcV1dE1ImHQDcgKvQE7MfyEteRaQ/URdvArBXugzZZ3tPsYsC9AFIhM8P0H0?=
 =?us-ascii?Q?SQoC5nhttYaiQ0N3FELa19rKJvIliLmWDwdAHurQhzjJjpF8sXVzR3W+bJcK?=
 =?us-ascii?Q?sg2t4X4QRebz7KWAi0G8fVj9VqQdDt4HGvo2QfF211OlT/rW+G2WqMWXDy1i?=
 =?us-ascii?Q?xGKvXZRyeLNLNk4g6zp44sPMu3FVdE7KuBGSVeR0i3MpTkiAIqOU7GhR4bAC?=
 =?us-ascii?Q?irm++Z1SkCX0m/391qeiAfvSfoOBYloTsLXWJIwM+bNTMaUGhHCBCfgAura/?=
 =?us-ascii?Q?6L4RZD3+2z1RGyveTHa1uizHdXQRwE9ErkPzjTEpiIupr0PFGFksEWIFQrr8?=
 =?us-ascii?Q?wAOi/RC5hVrPj8aRQzRo4W55WDhUGXWvJ3AfpgYnXt+OSsujLMIdK1atTDE6?=
 =?us-ascii?Q?85dckeGbDwQpIIl5vp/IIHjYmdwU4+N9pYSJl95UHQVz3ZkuR9tem6Sfd8B6?=
 =?us-ascii?Q?N/hyHGqvafghjt07aylWunI6+A/hJf/uwEA/CWPnn/3DvBVhJc506Mc9rKZ0?=
 =?us-ascii?Q?joz9jvNDIVkzE48Rayu9VR9zkTEKMXJHKI7qAYh4IwPHCNEBiQWrSyMNjMFW?=
 =?us-ascii?Q?nwkkbjUyaLkJ+zs4mCU95lr+sCmG0tE2gcu97Eoi2+y1sYFubcjJ+1tYJFwn?=
 =?us-ascii?Q?DBke8vlshK/e3of+cl1RoG6CHb5vkCCRqcR3M0Sd+fD5Xyhd3rFU7rKZUEnm?=
 =?us-ascii?Q?8D46nC5Q6c5pl0dXzidpBcL/aVF4S1r?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HrQtPd0gKEtWGw6KbV7+ylyWG6lve8Y3mpa8r4Cpnhoe3JXXDWbYl8Y5EhTmy4z6Nz/d86M9oG4CBYsJSmfv7rjj7pH64IFHUZ6y0Zu4vBWlq/wdahMqk8NIcxNFTq8wVzSMbaxR1y0Lt889GRW+3OE7zvX9sraoyGovbcsNSSXPKNoAr/I8lEMWu4FriqBAcyg2qvUpmsXI2/+zSpz9veg9dTJ9bMOR8Raq1beKeDjuxnyot9yACH4c2bkYcXnHmOzg5h+WwUnf1axoI3E9lN6GmlJSFTuaye4kGunkvDPja/WZ5Io+eLRHYhhS0kEUJd19raNyDBqgw7V4TzMx4r1Fm3XeBMaPXjRzSQoJSX3JqRqV14M1I0APSAeT0nEcb7hxYKqPdsF1jfsk61j4F0kzUd1Luibw1Hrxh57kpNU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 16:42:30.1270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7c4d05-b46f-494f-faf0-08d6929b6b1d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom phase and scale attributes were moved to standard iio types.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
	-the personal email address was replaced by the work email
	-separate define for every phase channel
	-enum used for write_phase functions
	-phase variables were replaced by an array

 drivers/staging/iio/frequency/ad9834.c | 53 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 561617046c20..4366b6121154 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -82,6 +82,7 @@ struct ad9834_state {
 	struct mutex                    lock;   /* protect sensor state */
 
 	unsigned long			frequency[2];
+	unsigned long			phase[2];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -113,6 +114,8 @@ enum ad9834_supported_device_ids {
 		.output = 1,						\
 		.channel = (chan),					\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
+						| BIT(IIO_CHAN_INFO_PHASE),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 }
 
 static const struct iio_chan_spec ad9833_channels[] = {
@@ -172,13 +175,26 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 }
 
 static int ad9834_write_phase(struct ad9834_state *st,
-			      unsigned long addr, unsigned long phase)
+			      enum ad9834_ch_addr addr,
+			      unsigned long phase)
 {
+	int ret;
+
 	if (phase > BIT(AD9834_PHASE_BITS))
 		return -EINVAL;
-	st->data = cpu_to_be16(addr | phase);
 
-	return spi_sync(st->spi, &st->msg);
+	if (addr == AD9834_CHANNEL_ADDRESS0)
+		st->data = cpu_to_be16(AD9834_REG_PHASE0 | phase);
+	else
+		st->data = cpu_to_be16(AD9834_REG_PHASE1 | phase);
+
+	ret = spi_sync(st->spi, &st->msg);
+	if (ret)
+		return ret;
+
+	st->phase[(int)addr] = phase;
+
+	return 0;
 }
 
 static int ad9834_read_raw(struct iio_dev *indio_dev,
@@ -191,6 +207,13 @@ static int ad9834_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_FREQUENCY:
 		*val = st->frequency[chan->channel];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		*val = st->phase[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*1 hz */
+		*val = 1;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -207,6 +230,10 @@ static int ad9834_write_raw(struct iio_dev *indio_dev,
 		return ad9834_write_frequency(st,
 					      (enum ad9834_ch_addr)chan->channel,
 					      val);
+	case IIO_CHAN_INFO_PHASE:
+		return ad9834_write_phase(st,
+					  (enum ad9834_ch_addr)chan->channel,
+					  val);
 	default:
 		return  -EINVAL;
 	}
@@ -231,10 +258,6 @@ static ssize_t ad9834_write(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-	case AD9834_REG_PHASE0:
-	case AD9834_REG_PHASE1:
-		ret = ad9834_write_phase(st, this_attr->address, val);
-		break;
 	case AD9834_OPBITEN:
 		if (st->control & AD9834_MODE) {
 			ret = -EINVAL;  /* AD9843 reserved mode */
@@ -394,12 +417,8 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  */
 
 static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
 static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
 static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 	ad9834_write, AD9834_PIN_SW);
@@ -410,10 +429,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
@@ -427,10 +442,6 @@ static struct attribute *ad9834_attributes[] = {
 };
 
 static struct attribute *ad9833_attributes[] = {
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
@@ -554,11 +565,11 @@ static int ad9834_probe(struct spi_device *spi)
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
+	ret = ad9834_write_phase(st, AD9834_CHANNEL_ADDRESS0, 512);
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
+	ret = ad9834_write_phase(st, AD9834_CHANNEL_ADDRESS1, 1024);
 	if (ret)
 		goto error_clock_unprepare;
 
-- 
2.17.1

