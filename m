Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71687C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="F3Gg/FH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfBYRSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:18:31 -0500
Received: from mail-eopbgr680067.outbound.protection.outlook.com ([40.107.68.67]:39130
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728681AbfBYRSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OkTPGKn1OWn2Awnw/opvR8oP+pc69/4VSxPf4On0I=;
 b=F3Gg/FH2LcwFyMUoenBxv5gBM6Km0PW3bda6a6yoFFrJf/ffumB+Ql99tBeeJmGbbSQ/gU7sjSNsxtKQD+HhdW9Rup39YuHj4YMjN3SEaIw/9xPlMsDvrz6HIF78APalBSXMDpDpumnwTKWv1peoRdsq2EoMTMj6hWmTZQMFUMU=
Received: from BN8PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:94::21)
 by SN6PR03MB3757.namprd03.prod.outlook.com (2603:10b6:805:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Mon, 25 Feb
 2019 17:18:22 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN8PR03CA0008.outlook.office365.com
 (2603:10b6:408:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21 via Frontend
 Transport; Mon, 25 Feb 2019 17:18:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 25 Feb 2019 17:18:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1PHILU9022673
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 25 Feb 2019 09:18:21 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Feb 2019 12:18:20 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 2/3] staging: iio: frequency: ad9834: Move phase and scale to standard iio attribute
Date:   Mon, 25 Feb 2019 21:17:31 +0200
Message-ID: <20190225191731.5822-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225191731.5822-1-beniamin.bia@analog.com>
References: <20190225191731.5822-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(3190300001)(189003)(199004)(106466001)(72206003)(76176011)(8676002)(478600001)(14444005)(4326008)(47776003)(7636002)(50466002)(305945005)(7696005)(51416003)(50226002)(2351001)(6916009)(8936002)(77096007)(426003)(54906003)(446003)(86362001)(116002)(2906002)(5660300002)(246002)(26005)(107886003)(1076003)(316002)(53416004)(6666004)(356004)(336012)(36756003)(16586007)(486006)(11346002)(476003)(126002)(48376002)(2616005)(106002)(44832011)(186003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3757;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 024af331-7752-4fe0-efff-08d69b453e4e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR03MB3757;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3757:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3757;20:uQ6Yixkwg4ZkSesr4WSYv8G4GSl9CGNH40VAaJbeBOKpu9VtSvXlerARcqAnGPNz8iCsMl2bloYO+GtH4vt2xv2mlTKRul0+kR0FPMhKo3WaXnA1g1Q/LTnsxizVxGgdkOCwqURZO13alUtEVNsZmFjjxs1PWUsGMEQ4AaI8Metv+m/nGDbw0np+JGnrQRj7iMpQf46df1BsFQ5LvFS+aYCGyQl5iz0uZuwzWP94o9ildM0usjRJ+tQcYrjKSVWIGmxmQ8pmM+P93etVgsJbi5u4Ai45Nj+Lzl4399Z+2VUB+brcEQdkRGkLkECWanM1kawglEqAfUtr20uf4XVPYnXoq/Gc0JmsVgCL6onxrwFHTJq0hgIZnQPlfq+5jwyOn/gdD01CGgpARgwThmePWBZnN/6BFyYscWj4jfxCd1JNdxJAjYNg94j5oNsCvpr5ilREnoU2WctIzUCdVH++KVct8Zadr4OHPFZAobPpufdTUXRGGNgLmML+2ScWPbUN
X-Microsoft-Antispam-PRVS: <SN6PR03MB3757AECB2EB401D08187A90FF07A0@SN6PR03MB3757.namprd03.prod.outlook.com>
X-Forefront-PRVS: 095972DF2F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3757;23:Vhd39B/3CmEA/Zqzgfp8AAhHFtVxjDS1iSiqYZ70X?=
 =?us-ascii?Q?g1D3i3buK8JVrEJS450dmkC8oXeRGlXTQWirQ6AEue1A5GsNEsaSHKVMcny2?=
 =?us-ascii?Q?sTAHz2kcI9IdC2EJwfZmJ8uapFdOZwMOPbhly7mcdhgkQVk4T3Xvrapr6f56?=
 =?us-ascii?Q?vTDLTm7rPVfgksED0Tp8ENy0ZLHgdeYV8ZakEpXh69VmubVByxp6Ceal2hPP?=
 =?us-ascii?Q?JCnnn0bbYuUrDTLEJCQ3YJfcEQn1lYuIgmxfFOeINAGPP0hA1y29hfDJ0b4j?=
 =?us-ascii?Q?n4syBwODS5to86zUCVKTa516FCv1MWpikvl8tk90PilHPiQ9Zebry8PQdSVb?=
 =?us-ascii?Q?3JxoaBkVLPm0L4EiVWy0IkMwEKn0AKHUh74mzTesLG/p+cHqxSLzSXwD0Oce?=
 =?us-ascii?Q?IDHzT5JamuStyyqom0C+b/Dk7u5mKY+B6heAntcJxQ3f3Yu4EKh58WRuwm4Z?=
 =?us-ascii?Q?EHdiOQedLB1ucM52eD8cQrpVVarPM9wMdV9hFSlMBzMcfXwmdviJNSTkkukm?=
 =?us-ascii?Q?WJrwf21JlZeNd6HHqTc6suMMe+tn6ZuURDuDpUifeoLNoKAu8zIn7m4sGeMb?=
 =?us-ascii?Q?saSFCCKZqD9J2awxfCtvcCc1FXa4CeEr420DEspl+xEwPuNGCJv0KfJTpgiP?=
 =?us-ascii?Q?3taW2BuUhTQPF4/1ksZzl2rfhUvY6V0DK86WpE3F6hYgqOvpvacR8dtQn92Y?=
 =?us-ascii?Q?k4WtyNxKA/UK0sudxnF+AuUSDuRubt3J9J7zQ1vCcgJcUl57IU8bbbAV/CPk?=
 =?us-ascii?Q?dmJKaRL8xrxuNKXJpEs3/3lR9jjU8DbkCffNjZ7E63ixCbYpAbq7jYshqT/o?=
 =?us-ascii?Q?CDv4FUFfm2qm5lmbqQwIYT318m00vtzQO+g5rC+s20TYrMhBVvHUUeDHwv+h?=
 =?us-ascii?Q?syNwGbcN3rQaXhh+OtD3eswgH0WOIru6C4gtgQ9Gd/13DmTk+f1L8LcVRTd3?=
 =?us-ascii?Q?Stk3zgvOQCo+upH+kCkMM7qcerdBcpFTIQscKk0aaMyz41e/1aFN/ZvUcAfN?=
 =?us-ascii?Q?z7zDGgIdDyn5E7X+txpTYx1oNEoBkPawbTo23ep5nh44vUKW1w/g+hYj5eD1?=
 =?us-ascii?Q?2zAneIP3hDpD5WAxxOm3TFtNlkINqULIZ8GvhpsW6zC0Lx5rdv4Zuof3bFVt?=
 =?us-ascii?Q?nkKjC7koN7MetV98DE9R0bvQV+nmBCw8cUW3sYB4Bl3+a5EP3o+WX15ttnfj?=
 =?us-ascii?Q?D2JMtIo2+YZPS/xUswScwysbBnESebWgMYQSVFRD3lBb/mNv1bicvy5+4+sx?=
 =?us-ascii?Q?MsADAeINbbrzoRM0yNVJn7AFFZIyQ9s6ur8Wrap?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bKua41g9gGITWyR5UifNwixbM/2I/5x8M476Ge9f7WyK5VtfpwlyomvmH0FQ++pRmSP6S+kGLvZR6/Ro3KOHuZEonl/6ptd65nMRSfWgkVL9u4Mnb3IWYcah3P/9AXuIk6RXLj4YdcddH2D6bzlWoN2oc7usZenqeGZupp8D62FNteRA5kjCqEOgKFm5EGF2pPhVXvzfvgngv5azF0n4yIz4yadsT47aN8nBLHmbw8dPjX7LIkHfMCHDnE4NK/EesDD8ouCAMhzzrRrpgBsjYQx6Zxt5wsdgq7u8PctyKqFBPEVjtxAiYGMOdMgIGSns56Ty59328+EgET2AecfC1RxHJgx1MweQQUsaoNDY0ws8jDv1Bd6vW+gkIYsFhs8wOeZP+DMahnNR6QSQ6/WMk93IwDihKK+/dwrLCoHOVgo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2019 17:18:21.8812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024af331-7752-4fe0-efff-08d69b453e4e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom phase and scale attributes were moved to standard iio types.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
        -abi documentation added

 .../testing/sysfs-bus-iio-frequency-ad9834    | 10 ++--
 drivers/staging/iio/frequency/ad9834.c        | 53 +++++++++++--------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
index b912b49473a3..656aa5b6d22b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
@@ -1,3 +1,5 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_scale
+
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_frequency
 KernelVersion:	3.5.0
 Date:		April 2012
@@ -16,7 +18,7 @@ Description:
 		value is between 0 and clock frequency / 2.
 		Reading returns the value of frequency written in register 1.
 
-What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase0
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase
 KernelVersion:	3.5.0
 Date:		April 2012
 Contact:	linux-iio@vger.kernel.org
@@ -25,7 +27,7 @@ Description:
 		is between 0 and 4096 rad.
 		Reading returns the value of phase written in register 0.
 
-What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase1
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage1_phase
 KernelVersion:	3.5.0
 Date:		April 2012
 Date:		February 2019
@@ -106,9 +108,9 @@ Description:
 		have two registers for frequency and phase but only one
 		output. The user can select which one controls the output.
 		0 represents phase 0 which is mapped to
-		out_altvoltage0_phase0
+		out_altvoltage0_phase
 		1 represents phase 1 which is mapped to
-		out_altvoltage0_phase1
+		out_altvoltage1_phase
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_enable
 KernelVersion:	3.5.0
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 8465dac656dd..107d859dadd7 100644
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
@@ -170,13 +173,26 @@ static int ad9834_write_frequency(struct ad9834_state *st,
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
@@ -189,6 +205,13 @@ static int ad9834_read_raw(struct iio_dev *indio_dev,
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
@@ -205,6 +228,10 @@ static int ad9834_write_raw(struct iio_dev *indio_dev,
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
@@ -229,10 +256,6 @@ static ssize_t ad9834_write(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-	case AD9834_REG_PHASE0:
-	case AD9834_REG_PHASE1:
-		ret = ad9834_write_phase(st, this_attr->address, val);
-		break;
 	case AD9834_OPBITEN:
 		if (st->control & AD9834_MODE) {
 			ret = -EINVAL;  /* AD9843 reserved mode */
@@ -392,12 +415,8 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  */
 
 static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
 static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
 static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 	ad9834_write, AD9834_PIN_SW);
@@ -408,10 +427,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
@@ -425,10 +440,6 @@ static struct attribute *ad9834_attributes[] = {
 };
 
 static struct attribute *ad9833_attributes[] = {
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
@@ -552,11 +563,11 @@ static int ad9834_probe(struct spi_device *spi)
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

