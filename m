Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F607C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FCD2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="H2PHDYjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfBFM0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:26:03 -0500
Received: from mail-eopbgr810040.outbound.protection.outlook.com ([40.107.81.40]:16304
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbfBFM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrNxHZ3/YRRU2HGtdQY6d5jmLiPhAZijYROCYU+finY=;
 b=H2PHDYjoFMZISBOGgrLNPiT2721rq56fsRWMXSq8Q0O+s5rfmLojX6ZNZFQX++n0Mrs1L94c5isMb9bLGt0CTUW6joLhoWd6kbmpdlzT4RpjxIL/kuWNLMnuPXL9WEPDzh3Hys0zmdQPdewkY+knwoTpuNvR9gR+twta0v7LW6k=
Received: from BN3PR03CA0081.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::41) by BYAPR03MB3751.namprd03.prod.outlook.com
 (2603:10b6:a03:6f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22; Wed, 6 Feb
 2019 12:25:52 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN3PR03CA0081.outlook.office365.com
 (2a01:111:e400:7a4d::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Wed, 6 Feb 2019 12:25:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Wed, 6 Feb 2019 12:25:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x16CPoZM019450
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 6 Feb 2019 04:25:50 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Feb 2019 07:25:49 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Beniamin Bia <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/2] staging: iio: frequency: ad9834: Move frequency to standard iio types
Date:   Wed, 6 Feb 2019 14:25:41 +0200
Message-ID: <20190206122542.18362-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(3190300001)(199004)(189003)(77096007)(54906003)(7636002)(26005)(246002)(186003)(107886003)(50466002)(50226002)(8936002)(116002)(4326008)(336012)(486006)(126002)(476003)(44832011)(2616005)(48376002)(8676002)(426003)(16586007)(106466001)(47776003)(45080400002)(2351001)(316002)(478600001)(6916009)(72206003)(53416004)(106002)(7696005)(51416003)(305945005)(86362001)(1076003)(6666004)(356004)(2906002)(14444005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3751;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT006;1:IGm2hUrfblIGlUJBkpTjUCD2DxsDtl0diKEGi0kF1cj+6ozrLnv2WtdaV/zsFXDP4u6HUncqqhrkBqXf3vKkEtr2+hw2f0Mt+/qqj4iAiS0pPIbfvCoO/kNCOolV/UMUWwV1P7RTqQNbIY5t4J8Q4A==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5656c98d-5797-481e-86d5-08d68c2e3bc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR03MB3751;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3751;3:8dCLpqtVEjyEWASJx1poQf4ciQ7Gs1tX6eqiRVFFCn7W9NJudQSvRgR+DCfc9us3nr8nH4FWwFLZzi7LnQUUtRLuOfohQ57ThdDXrrjMlg7Lt9HD8rrpGaeVos7Cpq5Gr0vzGtJmT6ZcK7jyPcjisgyJedsAI3HyIoPI3GxWQL0Miwz7IyPKK824BReLBG8yc1u/r/GTYotzSXkm1LlZWxEHESxuU0fVA3K/Ezcg0JjPJgwdqHQGSr5tf5moRvc/UGUZ0/zaoYqawTO2rGJ40Bst2aUmeeBzSb+nqBnXYQTFXdPMT7gfabDkaYWNeR/A7J8HuI+oAxBrQCScP8lB4w3GO+LsnbEDWf8rmVU84uP+UmiAMh0n+TYCnqTx9y4o;25:ly9nylMK2vkZKW0UcMctHrKvjcYW+YOKlvyQCM7tfiyQdiJkIXYl7d4BJSJmMKD4JToebwsD4WRkVf0Ry1PvlXv1ET2nQXupROWt6/mCQ1Jnbb8Dfo0ce+S+fb7hefYhPJBlrIFTYG7n2eR9DgSW9Ft0v0b4xqHo1f5E51GurZkjvLfzoONtq3QQbKLRkM97Z4Y/5tUPrIyYD6ZNgqg5APGMmV8scRmCnuhfLbx0qga+lQG8bgGA6uPcpvJ9i4FlNCD5KMF7BiG0TbeD50Dxim7t5eQ3Xz9xuVoq9u4vZT4tE96GDukGT2UcYwMEgRwkZNhbHxywOHItD298YWw89A==
X-MS-TrafficTypeDiagnostic: BYAPR03MB3751:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3751;31:nU+fnhlPqXjo0j+v2bAbHoTj+vmkeq/xicZcuBummusW0srZVz89Isqosi7uoiIIHB0UcYmcMWSOyUOhJbEWsQHJOLonZG/PMH8uKL94dwV4MpmUauu/D6M04CInfph+lBULFure2jPWONf7/x+JTDNcVhvFOWLeF25vYm1+braDcFsbirZAU9ZxkBP2r5/4xLlnX/Qp9G7Jn+tv7Zv1EsQLw5IcfQr/eZ9W3JjgT3M=;20:oqdET0G5NgIJXdyZIaDtonYTxqS9BSNZYzInPOUYCFKu8eUtEDtq/ZayZZiegIPDZaDo0fadrLIEZnK1F1pP9f/DpfT70KeeCkn2UQGeAr+qlY0Ceb8YU7HJ0pUMF2y0J6lIu5qdePXsXeEUFaBtVIk7YHMrZ0cjdH+MrdoUGMBmg4/oZ4AmfTjZ2Ffy7Y+9voldW7gZqXwoD34nRjInBZ7R1qvAwLo8Vawvzte27lUCbvGaZPfVovH7CHRyYfy3RuulERcQDKVPkEyn/INrTtF2Lm5SOBghWK9Hddd8SUS/wWcThxaqY11Nb8CWU4ApAf6qbjgCcTpFV5RKXvZ2kGtF0CIco+IZO34Dp8Q9znGM0jtkyDXJHnpDkRcgAuPr2x+ACdo6CtePAPq06R2RaUBlga0PdDOpVlzalr3gw80cccQOZuebeyUh+8YoPmyg9gRqz19tUeZdrqj/egqD3LiTqjqwVT6uK8nC7NlXio+4EAUsQX53zw1qJztlo2IK
X-Microsoft-Antispam-PRVS: <BYAPR03MB37512D93D55457E5F65E2A16F06F0@BYAPR03MB3751.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3751;4:aAWxCD6GMiM2gn1mLDjPot0V/94CNYnEvSpDEMPcfa8lZwYuMo//wQJVj6ulye3oT49QuUz0K8s7WeYzi9ZyKMV+xM9aPduG+lZ3ECGzehpRBAU0E18F8JIhwX4MsP4zjv4Q0FXCO+2YdyrKZAFRfHAXa9hKV7IuXJ5WfX1TciePFkWzAuxbls6HRoRNW9VimGbkfdimy26xJYFeYHMUtZwZ8BiM58MeoxMuLAymgFXLtYUWGnlWpgswZYVW7eQOAsmfIkEh6TZpFd+ZtYjLd21wpbeJARmPTUAHxfo4PtE+ec4/H8hWYyQwPZzU1ScO
X-Forefront-PRVS: 0940A19703
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3751;23:WAsmfhzjt3og3jkD6KG3MWgknIi7y5ywfGDtjDMvQ?=
 =?us-ascii?Q?lhUtCIBuB7GWXPKsgjuDEHqzVgGnQwXCnIN2k28Rp/YvK9+KTsWiLIYIYMTU?=
 =?us-ascii?Q?LK13AH/tiqqMUj8Asm+bEeXuGN43hE/eL0P/9hKnkXWt0b/dg5OyCUCYWmMU?=
 =?us-ascii?Q?0JZK409Ox8Ct6CvssIHS8VxcpD2MiyUV0iJxi9EakLX0iiOcTlpJzDVcmofA?=
 =?us-ascii?Q?h+lX/xslRGN2LVQZKq6b+SLst1ZthbyWBNABRv27Ak9rl3uRZTgnHYeDsao7?=
 =?us-ascii?Q?Qzg5E2DSXERsamvBf6bs+oexG5jh9cs5IqsCImIXfUj0SG16SrCncsSq87VZ?=
 =?us-ascii?Q?sopJXPquSIOz5QWN0o4hIgI9z17wo0MCJwuFwkXmQzuhtC4I9bi93mHrocQ2?=
 =?us-ascii?Q?J47dAb+1FGC1Repyc5wSKHY/hmAa3fvXCXNFUNPMVlh/+S6dy07KEfNRU7/D?=
 =?us-ascii?Q?oZHI5hlLM34Nf0dLPTseyOHWjBMTD8eE0peuMWTE/9U9TqMM7wao0g9IhmxT?=
 =?us-ascii?Q?jQ/Z7b+HBeON1TS6a6jfDDLXPD50y5JC3jCXmJfzg/2sIM8ZCwiuCfiJFax7?=
 =?us-ascii?Q?YfYnQn/8ANRnBVUT/2zRPy0fLszMOnP5jR1MdBgMMMnz6uXq/eClFedQh26m?=
 =?us-ascii?Q?X4KhYDK6+IBOW+mzAN9qk9oVOdv8qdrxM3ff5H+GTZAYbcKPm8TYOTpycxPL?=
 =?us-ascii?Q?V1kjPMj3P0BRiagRRdgphpwMJPXGYlXiEmGrV7AU4GWttnlEOUImRX4y64Vi?=
 =?us-ascii?Q?N9xgD2PBroMiqOsRO064rSIambjslz2EMXJo2uGd41zNETjutHcm+WTsRLg0?=
 =?us-ascii?Q?HhVoWe6VxMuB7rofq7JVXVqLrUnyR5yYFJ2GwMAT6wls0VUXwAFNPb31CtEV?=
 =?us-ascii?Q?o1Tty15zXPkfcIbq6SgCThdAT5pHE9/ISxI5LPQZQgeTpzKy7St7UY4Ie+L1?=
 =?us-ascii?Q?9+7EJQVagKRL2ij+xoNe/uqKAloA67ztn5BufB++SH1w1gW6mDsb0ZEt4Tv+?=
 =?us-ascii?Q?MH/4+tEiLFlpQz95guW208KmQqbXHvA3xwbrTo+75WniK/wHWT7ZMyZp+0KN?=
 =?us-ascii?Q?MAfxsgB0a2+zN5axtmd/iXESegfTXDqvzwtqc/+nqvG5sBM7fNfSXlmc3xGc?=
 =?us-ascii?Q?S4u0Meww1c=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gwGQ+ujFX1Nafzum4rSxXnwz1sNpBqzxm+FrRDSGpQZEcSAtCDmfF6kc5RtinmBaCj564UuMPMwB4s3UVWYpMBJ8xnnYk9d4ikYSgVMLBzbSpL85K2qEuuBqE6jvDlQmHkTF9ZrP5CoaMFmNMqRaTNv8Ots5RZjVDS27Y9cjzYAl9gFtkCr2U+IpTILIDtKFT3z3xCTTWN5LTRVEEHglgIAqRk/FrX7TLKhEO5thTqVvriAS3iZrU5PHfdhvPAjbePHfMgter7srlHR1MHDDez38VAoTEpokZmECBXKhutdxLat2C7SsAn96XAgaWmTMrwabWGtP74DKw1Yke5zddTBqEDvxiZgrIunFx+v8c0ezpP/2CCbXhobLibOqwYEP0Vub5lgwKkmFEw1jBpSO0nL7SHit+34UCsVmKRAXYxM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3751;6:d4sFDiaV6/X6IxpjYqtbLhcCaG7Z9y/tEn7bXCtsjOBkqbZuj4iAbX4FbQl+xz3E3VyzsLE5Aos0beSMGAnMXlysG2bZTal0pzQX6ypjWVvEN6ZE8CYmkJPqW5h17Phnm23jJ+HNjra485wqDdM2uImIfox0qfZTP7O5wXvmrqCALS3AGAg+njikHSCmSiKvO88y0+4AfelhPq2NgHgMZWo7AScP4/C8al9gRcAMVfL8ValVDrQq5T6ZsePkR3GiDsUV1E2bpgVlmjn30kh0WeOt3AdAGsXBYugSJhhRu8mEF8L1je1I0JG/7fVJB7JQrGFd/QMmFyLbFxAWh3nMA2ECHpl1xNKUJJGPRP6CyFPV6qmgLQiXYz1QIh5J6ps+IfE3Iei7zJqzWcirVM9TXwV9swzmF4kZJL1WxShSw9KDaNqcYGgHGxF5ZJyqkGEl/BQ0mSmtpayNqCMfCXFW1g==;5:81xh+dFmgn/WgHg0ZHUI4AwP5gsaeLbTSnmwlKx+runDI94WQ1WwwkbZnO/nexMjKI4DHhNyOo8xbJrtFmqHkPpXAeYtr+qOrC/LSFpn8ZcL63fvrAbmZdv2BkLF4FdXwEQ4kqFwj6/bdy3UjtJebdv3sSo+gsu3e+1xaITB0W9sHZZmkEzDmeuYLuB5LKjBdyKKxnbPui76Hqeyaec2gg==;7:RCdZ+v9/nNRAXGaywDq7y2dxJUKpTqdCCgTQGDNkF+NMHgCW+BY7ziVYmOGN8pxj6Rl8hf+G7RgrwT2+w1tDnJ6vGyHO8+5IyWav5KMlxhSf2SzqS1MLxAIgFxrgNzI/OlgIzW2u/WqjJRHMNDYBkQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2019 12:25:51.2451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5656c98d-5797-481e-86d5-08d68c2e3bc1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beniamin Bia <biabeniamin@outlook.com>

Frequency attribute is added with a standard type from iio framework
instead of custom attribute. This is a small step towards removing any
unnecessary custom attribute.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/staging/iio/frequency/ad9834.c | 97 +++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f036f75d1f22..370e8263899e 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -29,8 +29,7 @@
 /* Registers */
 
 #define AD9834_REG_CMD		0
-#define AD9834_REG_FREQ0	BIT(14)
-#define AD9834_REG_FREQ1	BIT(15)
+#define AD9834_REG_FREQ(chann)	(BIT(14) << (chann))
 #define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
 #define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
 
@@ -81,6 +80,9 @@ struct ad9834_state {
 	struct spi_message		freq_msg;
 	struct mutex                    lock;   /* protect sensor state */
 
+	unsigned long			frequency0;
+	unsigned long			frequency1;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -100,6 +102,25 @@ enum ad9834_supported_device_ids {
 	ID_AD9838,
 };
 
+#define AD9833_CHANNEL(_chan) {						\
+		.type = IIO_ALTVOLTAGE,					\
+		.indexed = 1,						\
+		.output = 1,						\
+		.address = (_chan),					\
+		.channel = (_chan),					\
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
@@ -113,6 +134,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 {
 	unsigned long clk_freq;
 	unsigned long regval;
+	int ret;
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -121,13 +143,22 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
 
-	st->freq_data[0] = cpu_to_be16(addr | (regval &
+	st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ(addr) | (regval &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));
-	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
+	st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ(addr) | ((regval >>
 				       (AD9834_FREQ_BITS / 2)) &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));
 
-	return spi_sync(st->spi, &st->freq_msg);
+	ret = spi_sync(st->spi, &st->freq_msg);
+	if (ret)
+		return ret;
+
+	if (addr == 0)
+		st->frequency0 = fout;
+	else
+		st->frequency1 = fout;
+
+	return 0;
 }
 
 static int ad9834_write_phase(struct ad9834_state *st,
@@ -140,6 +171,40 @@ static int ad9834_write_phase(struct ad9834_state *st,
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
+		if (chan->address == 0)
+			*val = st->frequency0;
+		else
+			*val = st->frequency1;
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
+		return ad9834_write_frequency(st, chan->address, val);
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
@@ -157,10 +222,6 @@ static ssize_t ad9834_write(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-	case AD9834_REG_FREQ0:
-	case AD9834_REG_FREQ1:
-		ret = ad9834_write_frequency(st, this_attr->address, val);
-		break;
 	case AD9834_REG_PHASE0:
 	case AD9834_REG_PHASE1:
 		ret = ad9834_write_phase(st, this_attr->address, val);
@@ -323,8 +384,6 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
 static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
@@ -342,8 +401,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
 	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
@@ -361,8 +418,6 @@ static struct attribute *ad9834_attributes[] = {
 };
 
 static struct attribute *ad9833_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
 	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
@@ -384,11 +439,15 @@ static const struct attribute_group ad9833_attribute_group = {
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
@@ -435,9 +494,13 @@ static int ad9834_probe(struct spi_device *spi)
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
@@ -474,11 +537,11 @@ static int ad9834_probe(struct spi_device *spi)
 		goto error_clock_unprepare;
 	}
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
+	ret = ad9834_write_frequency(st, 0, 1000000);
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
+	ret = ad9834_write_frequency(st, 1, 5000000);
 	if (ret)
 		goto error_clock_unprepare;
 
-- 
2.17.1

