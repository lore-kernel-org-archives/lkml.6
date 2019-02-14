Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92709222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BJxdunS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408031AbfBNQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:42:03 -0500
Received: from mail-eopbgr810074.outbound.protection.outlook.com ([40.107.81.74]:58507
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405240AbfBNQmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CL8zDF+DXfN5u5jbjCAi0AzKnyyaHC8Vwpmmj/u83Q=;
 b=BJxdunS6XdC9FQ8tn4+4kHLnO7rih8QY1T1/CgephyPoprD0gWh0kt9cm5Spe+deKYXI8qxj9+MH6WT+D/k76WMS7ky6PKerVjnhOvFMgd2eRTFy80BFWQrh4IwsKP+2lzMR1FLsUchYMFa6cijyXqt4xNCiDlMpzQQ43QOhAdA=
Received: from DM5PR03CA0046.namprd03.prod.outlook.com (2603:10b6:4:3b::35) by
 DM5PR03MB3066.namprd03.prod.outlook.com (2603:10b6:4:3c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 16:41:58 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by DM5PR03CA0046.outlook.office365.com
 (2603:10b6:4:3b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 16:41:58 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 14 Feb 2019 16:41:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1EGfuXm021586
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 08:41:56 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 11:41:56 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/2] staging: iio: frequency: ad9834: Move frequency to standard iio types
Date:   Thu, 14 Feb 2019 18:41:29 +0200
Message-ID: <20190214164130.30085-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(3190300001)(189003)(199004)(336012)(2351001)(305945005)(426003)(356004)(246002)(7636002)(44832011)(186003)(48376002)(77096007)(26005)(6666004)(8676002)(476003)(126002)(116002)(2616005)(53416004)(50466002)(106466001)(486006)(50226002)(4326008)(51416003)(36756003)(8936002)(478600001)(1076003)(107886003)(72206003)(106002)(16586007)(316002)(2906002)(54906003)(86362001)(6916009)(7696005)(47776003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3066;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT035;1:wk2VNnbVYY+IMtWc+sKhwMgSWjryHdo1na+cpTFXLmhfu2A/Tq9cqSw2/dfctj38+6SVZM/3vEanFAB0VZSkIu/ij6P8zTYpgUHhFGdSMdyO3fmzii1OwwVmNAWdeO7s4t3Aq/z7iNb4GiVyMmy3yw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12a9ac41-363f-4827-fde8-08d6929b5626
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR03MB3066;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3066:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3066;20:v1KwUmgdDfaoU3udN8pIbAypjcICRTwpFq7xwLUOyfOVantcurFm7M4zJloqSjuMgO9LgffmyaB/ZFYQ0kDEM01lAmHd/sXGmSdL8nGqsgZK7Ra8Q8SRdlhcAmo5JLYqMmlyirF3NlIx+4X9cp86LgWWyW4y3kZxTYxbfpTvDOvL2foJKP2ndbGibMa4S/VzqLjhti8j+6yjatFAjbNqWwMrLbaSdXz1ekZTgwkvA9kEZjJ0aoIj8Rz3hgDXPIsoyqHTsvV6dsvcuheP3YFkVdwxBKtSxUqT9CN3ZE08oFEGL6kPBYOQao2eZrGjeTcdj2i+sxl0bFiIWDv2GhF31yu43PfM+iV/vUEMGMknpyGQbYrhvfL+IWeIJBTZxDfmDAXBPEvyroRIUXwbPPVBQtVDNdwh8+Xxa8TeDX/AbpyC1r4Uru8ZADudRDbBLcxHgUu9tL3t5uaefeLqu4tT17MfmKCFUGm17Ovz268t2PbsoZlBUk74fN9BtnBgpweT
X-Microsoft-Antispam-PRVS: <DM5PR03MB30667A53D3C4EFFEDD614FD7F0670@DM5PR03MB3066.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3066;23:LQOKs+BbKTVhltoW9iMXy+l3AkCTX8XQLpsbxGrNa?=
 =?us-ascii?Q?nJUAMJjyB4jJ1MmtJAGPAqIDrq0RlXLq2HV2ADU3Kik+uikJedwbVStsXDQr?=
 =?us-ascii?Q?X88zmBqVBCB37TcUnoOXcfT6bjgmeOr9YSnDQwY+sn3FKpzjzbGq48flBXwm?=
 =?us-ascii?Q?t51zAMZbhWsRuBjcf8hOntBxfq27jbnyUwRQusXZbseXwF9lSqoDAyKtTNUt?=
 =?us-ascii?Q?EBI2LFSJSxOwtZMR+ctvoSoPdABUJrlwFUHIw1itUwBD4Qk99e7kMi/GJPnY?=
 =?us-ascii?Q?EKx1f7YQrH5QCmMSs0v3+q03nxb39zhD8PnpfRft6t9XiPWWs3xbVUc5flSB?=
 =?us-ascii?Q?7F1lNfZb2L4mZ5SCVHxYGwAnbgF3bhw73sD6HSpf/2e7/Nyh0xzM0xuVo1en?=
 =?us-ascii?Q?1XgfYs7DMCkZ3Vvf7cOnacv4zGmioUeQe6xMH3is6N5C/bC9dg4Cqe7aqy3R?=
 =?us-ascii?Q?+lg5y3rubFM3uhF/tZ++ZN7Z69AaU9hPYAOp/COciCBJCvIuIzOlgNLhKKp8?=
 =?us-ascii?Q?Poig2TqiU89PVMrw75+lfTt/iuGrbDI9QGu//9LfwPAxmYzmHA3++YhTkE27?=
 =?us-ascii?Q?IzfcEplw2NAvTpgKEh6jw+kdw9iyxXhskQGhnOS4qB/NdFkJKxfuM/Rh5Kax?=
 =?us-ascii?Q?bSuTweZJ1cPSv0xTBiP8Rn0FLZH6KCEpbEjOCT1xM/KY4Xi9ebAwKzcWC5h5?=
 =?us-ascii?Q?e/lSqy+l4sCDAKolv64clXHXETOJ9NNDAapfMg/dLEGx14eYCOnEEqdKaTUZ?=
 =?us-ascii?Q?ECOHwogYkCfMAOP6jRvC0HCcDOVvjYaHS3CJIr19CZrg8wAmR7P7rQ542dwJ?=
 =?us-ascii?Q?SFinzg8MNwAoe80qLJkIovg7Obp5T4c4lHXD3JFywYSGBZYhT70sCxbeA7MH?=
 =?us-ascii?Q?Vk4GaxRhNiLsXL9fm0u2rUkGZWceOQKkMKajjbU5FdE84fjfYgNBI/Kkk0/N?=
 =?us-ascii?Q?nYbwgbxCA2pzcQRqqYn+NnvL5MSLPfiG3tpXyLJI11pxmoU1LcTcDp8WCksq?=
 =?us-ascii?Q?7nDgPmCl/tLR8QJXABv/bhy8CbwuEAtYKGfU4q3jnVEjM4G1S70PK7NfQgU1?=
 =?us-ascii?Q?A6J2/i6vs5FyjDny/KAyFpG1Q+wOI27eaAcdEXGruOhy8nZaw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: v+9OodkYsEqXFdmn4V7Ck/znrIjNd1VspKjuBNIRCcj2aIKEdfGZ0i2F3auL49HEZiPVqQMpDpdh5pDvrxh3qQVuoOYsd5GklHPJOdxZ/ZNwuCL4evT1eol/ehG4AcY+yaqP7wjVWyzl+Uki/XUNMlA0mnymoDInBYPAkueKsALCc+iUSp1xHX2o0u+WfTG95bIG7nFoi2UxgfE6frVx/4S1/HDxdFa2PaAbGfFrVD1fzKDo0PWkd4TOr/nxgaOE7JqQSuRWptHgrH8mzqo3GcH7s3zLQcQlso/lI2zj+WkxSv5TvLSwd++gmg8So46uGRCwszMmHlX9Tf6mV1P9C1pD+mtA3jYTLFGsxkgF2nd5ik+F27UPY40CnOLcLAtrIu2tJ4yBJKU6lGIGnznZmXruoPsIyPdllz5CdyXQ/BA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 16:41:57.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a9ac41-363f-4827-fde8-08d6929b5626
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frequency attribute is added with a standard type from iio framework
instead of custom attribute. This is a small step towards removing any
unnecessary custom attribute. Ad9834 will diverge from ad9833 in the
future, that is why we have two identical arrays for ad9834 and 9833.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
	-the personal email address was replaced by the work email
	-separate define for frequency channel
	-address field from channel specification was removed
	-frequency variables were replaced by an array
	-specified in comment why we have differente chan_spec for ad9834 and ad9833
	-enum used for write_frequency function

 drivers/staging/iio/frequency/ad9834.c | 110 ++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f036f75d1f22..561617046c20 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -81,6 +81,8 @@ struct ad9834_state {
 	struct spi_message		freq_msg;
 	struct mutex                    lock;   /* protect sensor state */
 
+	unsigned long			frequency[2];
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -89,6 +91,11 @@ struct ad9834_state {
 	__be16				freq_data[2];
 };
 
+enum ad9834_ch_addr {
+	AD9834_CHANNEL_ADDRESS0,
+	AD9834_CHANNEL_ADDRESS1,
+};
+
 /**
  * ad9834_supported_device_ids:
  */
@@ -100,6 +107,24 @@ enum ad9834_supported_device_ids {
 	ID_AD9838,
 };
 
+#define AD9833_CHANNEL(chan) {						\
+		.type = IIO_ALTVOLTAGE,					\
+		.indexed = 1,						\
+		.output = 1,						\
+		.channel = (chan),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
+}
+
+static const struct iio_chan_spec ad9833_channels[] = {
+	AD9833_CHANNEL(0),
+	AD9833_CHANNEL(1),
+};
+
+static const struct iio_chan_spec ad9834_channels[] = {
+	AD9833_CHANNEL(0),
+	AD9833_CHANNEL(1),
+};
+
 static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
@@ -109,10 +134,12 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 }
 
 static int ad9834_write_frequency(struct ad9834_state *st,
-				  unsigned long addr, unsigned long fout)
+				  enum ad9834_ch_addr addr,
+				  unsigned long fout)
 {
 	unsigned long clk_freq;
 	unsigned long regval;
+	int ret;
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -121,13 +148,27 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
 
-	st->freq_data[0] = cpu_to_be16(addr | (regval &
-				       RES_MASK(AD9834_FREQ_BITS / 2)));
-	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
-				       (AD9834_FREQ_BITS / 2)) &
-				       RES_MASK(AD9834_FREQ_BITS / 2)));
+	if (addr == AD9834_CHANNEL_ADDRESS0) {
+		st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ0 | (regval &
+					       RES_MASK(AD9834_FREQ_BITS / 2)));
+		st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ0 | ((regval >>
+					       (AD9834_FREQ_BITS / 2)) &
+					       RES_MASK(AD9834_FREQ_BITS / 2)));
+	} else {
+		st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ1 | (regval &
+					       RES_MASK(AD9834_FREQ_BITS / 2)));
+		st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ1 | ((regval >>
+					       (AD9834_FREQ_BITS / 2)) &
+					       RES_MASK(AD9834_FREQ_BITS / 2)));
+	}
+
+	ret = spi_sync(st->spi, &st->freq_msg);
+	if (ret)
+		return ret;
+
+	st->frequency[(int)addr] = fout;
 
-	return spi_sync(st->spi, &st->freq_msg);
+	return 0;
 }
 
 static int ad9834_write_phase(struct ad9834_state *st,
@@ -140,6 +181,39 @@ static int ad9834_write_phase(struct ad9834_state *st,
 	return spi_sync(st->spi, &st->msg);
 }
 
+static int ad9834_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad9834_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		*val = st->frequency[chan->channel];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ad9834_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad9834_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		return ad9834_write_frequency(st,
+					      (enum ad9834_ch_addr)chan->channel,
+					      val);
+	default:
+		return  -EINVAL;
+	}
+
+	return 0;
+}
+
 static ssize_t ad9834_write(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf,
@@ -157,10 +231,6 @@ static ssize_t ad9834_write(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-	case AD9834_REG_FREQ0:
-	case AD9834_REG_FREQ1:
-		ret = ad9834_write_frequency(st, this_attr->address, val);
-		break;
 	case AD9834_REG_PHASE0:
 	case AD9834_REG_PHASE1:
 		ret = ad9834_write_phase(st, this_attr->address, val);
@@ -323,8 +393,6 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
 static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
@@ -342,8 +410,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
 	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
@@ -361,8 +427,6 @@ static struct attribute *ad9834_attributes[] = {
 };
 
 static struct attribute *ad9833_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
 	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
@@ -384,11 +448,15 @@ static const struct attribute_group ad9833_attribute_group = {
 };
 
 static const struct iio_info ad9834_info = {
+	.write_raw = &ad9834_write_raw,
+	.read_raw = &ad9834_read_raw,
 	.attrs = &ad9834_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad9833_info = {
+	.write_raw = &ad9834_write_raw,
+	.read_raw = &ad9834_read_raw,
 	.attrs = &ad9833_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -435,9 +503,13 @@ static int ad9834_probe(struct spi_device *spi)
 	switch (st->devid) {
 	case ID_AD9833:
 	case ID_AD9837:
+		indio_dev->channels = ad9833_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad9833_channels);
 		indio_dev->info = &ad9833_info;
 		break;
 	default:
+		indio_dev->channels = ad9834_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad9834_channels);
 		indio_dev->info = &ad9834_info;
 		break;
 	}
@@ -474,11 +546,11 @@ static int ad9834_probe(struct spi_device *spi)
 		goto error_clock_unprepare;
 	}
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
+	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS0, 1000000);
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
+	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS1, 5000000);
 	if (ret)
 		goto error_clock_unprepare;
 
-- 
2.17.1

