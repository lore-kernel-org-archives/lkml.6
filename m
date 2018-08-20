Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF7EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E556B2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="RW/218Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E556B2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeHTSLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:11:11 -0400
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:63900
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbeHTSLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWbJhfuFsHc8AQ6MdrN0rabkiObnk7JOlyeZ+LVBmiE=;
 b=RW/218YeWQopRCPrp/qXPYBOuvs0ocKPnN3VUHwrYRA51hfSmSzrr4l49WtGvnOOQh/okk9b/vvIYT7E3qWsJtKqnhePflQS/liwJHNlaEQO+VMQETzAHnkU7Vux32YmfDD/NJYJIKRf16Ji/RH/C8Y1ROHUfzX+ucP/bUrTxD0=
Received: from DM5PR03CA0057.namprd03.prod.outlook.com (2603:10b6:4:3b::46) by
 BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Mon, 20 Aug 2018 14:55:10 +0000
Received: from BL2FFO11FD011.protection.gbl (2a01:111:f400:7c09::187) by
 DM5PR03CA0057.outlook.office365.com (2603:10b6:4:3b::46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1059.20 via Frontend Transport; Mon, 20 Aug 2018 14:55:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD011.mail.protection.outlook.com (10.173.161.17) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Mon, 20 Aug 2018 14:55:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7KEt9Q6020645
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 20 Aug 2018 07:55:09 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 20 Aug 2018
 10:55:08 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/3] iio:adxl372: Add filter bandwidth support
Date:   Mon, 20 Aug 2018 17:54:55 +0300
Message-ID: <1534776895-18983-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(438002)(189003)(199004)(72206003)(106466001)(53416004)(478600001)(186003)(336012)(476003)(2616005)(6346003)(2351001)(126002)(77096007)(426003)(8936002)(2906002)(50226002)(26005)(486006)(36756003)(48376002)(8676002)(50466002)(5660300001)(6666003)(305945005)(6916009)(106002)(47776003)(44832011)(316002)(16586007)(54906003)(4326008)(246002)(51416003)(7636002)(356003)(107886003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD011;1:na/pVm6eaJvWM1Ebu+K728OeJ3spAPY+fWvBZbpuKNfa//OnAIXFQU6UGWFhL5lYv2sXHEKCDH5JPLo07pNWZMMOXmQLkFW0De2HEVnakEL5fKZJ1aS+xNQmcAxcyBTX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b119ae2-1381-4b89-d357-08d606acecd8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:dYNq0DS3JLdQUW5tFpGfhRSXnVDNyXwH9Q24iOvfdUfq9Vshrw349C85hCPSvRJjm8/K/UxOoyUit0Qyy4M2dO7gfZUzDX+FJ+UYBOCCpN7RVh8oR+YvZ5DDWfmXR1l2DNy8Ah+ez1s/Q8AkOgs3tONUzaHKnPGwzkhBqefTPj5o11sdKWc5fHp4TozBjYWRI3GM8PwlQ1ClntPw6oEKp2hVo/NgZ4VwwnL6DR1p/wC4MlF1xPVPyAticPpStVd5NrJYqnT0wCGj9GDhisab9pkvu/362W6q3CjVQuYOqGI2aFxZxzuBftvFsL2wZmTo1HDoImcdlRyzTjxWDk2Lx3Wn5F0AY8jWSfrV4P/NeoU=;25:zuvalW7W+cbE3CH4vHE539XTPAbr3TKSvIAJ5Izo4HI3LYQw4ABub57ifZoj9Cv2lImou/wOPAvL4G/4vkD0V9wf+jpLrm4a5K9Bsd/K8VcEr58rwBQ5x3D4Yo7xc674jBz1bJsdb5yz5szFk44ryjzVYpJjrzZPi71JEF9Z/IZbMWiy6EJN2KqCnQ3dHMeagtVn1T/eKA682nn0seszIpVO7Qrp/H29mME/pxiSIVXD2VzG3XpIIziisIneELBT3p0QlSKINZBjrQIJpQ3D1LQMqtLIMZW+ELO32jLDgGyVcdY3xD24953nFO2defePI+KiqR17HzSV5+O386QYgQ==
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:2XcJxmN8VKffg68P8g9LYixQh2lG4X2tjKUm79CTmy0OOqXFTavvKwUYF9kk1qsQeHkrXrhX1vmnny5ZTu4pE3gJsD/4xBx/O4Qg56TYI+m6BtJ1V4ma47uIw/WWtd6ufYSpuT6/uLuvOED/uHxNGsKk9J/kB8L3NAgb191yYBgKmUSY14JAJED8cFG/l15R49kpX5qOTxOnkFnpHhkhSwun5YbzP/j9/hv6UuIqspo=;20:ZX2ZOg0yBosS0BBT1GL2EFRXjVT9wOMOEtEtWml4pPw3MwiI945qmvk8xahd84/UX5q38CdbC8jmWRg85v9kYDtEKJLQ+8zh5gjq180/be+dSzIbt6hvq7GqgTKgf72II3AFEFXEdxTK8gSGjn+rxUBhO6nq+to3lzxoK9AA5ltbeTyxW/zT16Uc6p85gqWUCbS94+w78hv9AQGz3dE1+7erqhcPLjI1ut3xneKPI6rcQ49AVEjjj++Js9u+dtdAdxDEUl6v1GJKEdpyEvT/uq2sRsAzcoiUCpRa+K6CWGY09a5K1bTnSsIUisVHT6mLjmhNk28dKl1M5r+fDmUU0hBwGsYTZAPUeny8/JYVkWtE30UTKIeFPTwf/SitAVJF2YkhLxkvSiBmiP2ZrFaWor9qKXoeSUJdgR6Gub7d2SvUyvhwOOxrcs+4st4gTPqOcqEuuIIk3QXN1l2/ySEfh8h3wbFdLpwXu1ohC+Zc1MqMGxAeEcB8p6hLyrHv7I67
X-Microsoft-Antispam-PRVS: <BL2PR03MB546787D15492B662AA493D49D320@BL2PR03MB546.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:ZXQVbcwSnZ5JbwZrgfwDnyL+vnDRLljbgYknRGhxyapxY4UmFGtN69zpu9F9PsDSA/NMqertjeBSlC56htQdfrwAe8oV5F0fYH5VxuPXNvC2Y05838rW7p7O78/9ASfxJ0vj1kf8LCNcutZcpW8dPLQ6qLgg+ePURLDJZbLWOhGF3imCl7VJF8Blkco0We6V3PWJ2b8hImIY72KmJIdtFwu8sowQap8aTYhaehA07nXVifgexYnvlwFtGT/NZEbUUmsACbeliHj6xiwfIZ9UGGXU3ZjBk7QEGKc31OzIde+u254gSmDxvLA4sqS/LmP1
X-Forefront-PRVS: 0770F75EA9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB546;23:V6gMFU2RO2qyDO6JljuEZAvfzruBCVa7/BDTE+ix84?=
 =?us-ascii?Q?yGCv0IeicaEPbhUADdEO309SIeke+jUT7/E6+AUNIiz9uMSHDyRewy38C6ZK?=
 =?us-ascii?Q?ULuJ9lKobuBYe+jLkGjNrz+iIU/v7Sd8rJRyuOFLJ8X6O5Dzy4Uw6qPIMgLt?=
 =?us-ascii?Q?iorQareU4rpBoYCdXS6lsp25tu89KJ8RNN3pDzR7vAmGSW9OZ/NJY5DxHp0J?=
 =?us-ascii?Q?EH2Mf03KPeUjtHLjyBPQIwgJwKb7b7cYp8SrUWmfUEmMKrtxfTcRulJw1eEu?=
 =?us-ascii?Q?iZzL0qH8A3OJ6GJed2SlPgi3lQ/CgXFEIbqJfhDLHy/gHjODHHuIWP9YHSGy?=
 =?us-ascii?Q?F9qASlK8+kuFXY4nz3zmRv3DFY5dFt8pK8to9F01WyFQdy3e2wfr0ZdP/HzZ?=
 =?us-ascii?Q?Um16wW4X2XRHESgLxaCjUtp62XY2ofbRFh9mkgOGEp5DkP9z90J3A0nn+04c?=
 =?us-ascii?Q?Qu8n0As3p4D2o18S4DKdrvfRwDARtLPXh1husAbGlwS+c4mroh7FwncYH/bH?=
 =?us-ascii?Q?FO/PSAfit76yXFnOnjM4w+ti+//05J9ThKZYzANDjSYydFpg1XaSdrADBjyk?=
 =?us-ascii?Q?/VGrR7xDmMRQpAZpgLyRbcSXmY5Isu7S7cDYGzn/+DsZgAtagAI7z02Sqllh?=
 =?us-ascii?Q?UvD9TcF68FnLCCqaNr2k2KYkaKid4KWcFUeASOHOBUbrF+hwIlu/YWLZ31lN?=
 =?us-ascii?Q?CrloUXmz8uzeDy0dS5bydZaQvWx4JSjyXQAAihfxFqYQfdd99QkJAKtWpQ++?=
 =?us-ascii?Q?e9CDFaq22cY7gT1rVsPmnO29WTD7TpiZJ+biq8vcZdx27DZrua0Nl5UegkJ9?=
 =?us-ascii?Q?FJMQ9RSk4CMuKjr71zBPBA5rC1NwJlQWCBb504n6xl0uq8urjWPNryDsI0lt?=
 =?us-ascii?Q?3+RGMplZZb2UEmCiP6sf2X6KrGXp+DopU8AwFqWq7NAaBEeHZJlnsf0eEK9c?=
 =?us-ascii?Q?b0fjYxizLKE7c1YVPwKD5KCL6CCtjjjlNEn/48bkG2/3R2vDMnJuX5pegs6W?=
 =?us-ascii?Q?fhu/hirJYRLzDwRo5A6M9QbMJZEBNUWXDIogaIIAZo0Qk+xBAIDTVKX7zjH8?=
 =?us-ascii?Q?qFtQs=3D?=
X-Microsoft-Antispam-Message-Info: LRQC1h14nbWcd41Q+m2ppPmJI6/ltvQnXKJ82hxJa5xBnEjkBJHI/VnIerGSHvcMm6TtvL4Xd/wHYzsV7OY6QzJjVgrL5J8rNcjlGZyJcmmN7UQlbKxB67gBB80DMZd4bf07mkuC00TWSAYGrCSbXEyxPu/oPMiwuhH78Ouamh7YIhEmpQCh+lv9ko4HZtxviK7oJljrXTjHjO8svh2r/+bAliaePrRthTCG80OA5j4bjTyFxRia4dsQzkHzmfNCB1UON6QTVfN5nu1aZmr2+GigTmaXvHHsNE1EijmS8LC83jBivbnXTZGf5O0XgX5oeHAtCR4znUxED7827+zW8XpqdNBaqoeljBGIB1wxWio=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:CHc9ZzccoRNehlVR8wJH+K/n7rznfZPGaUzmdrinmjq4VTRXxcTzcKLShiFwhNAmpBPaL3ZT3oXezMSmjBcAwS+HoAFmHHOYuN1ADBtJ5DxyW30rHXptHikF9MTwKzsFYecKowGdXeF9XS3BMS5mhyMtSKvND+PMOm2ItIt3yL4qv2BjPhUCURGY3ZY5LvBYF77Fbe7xwB0dKgCCmvLWr1aiHfMKYfUD3Xg8wC4bxD0tryKl1JYlONFEWKPSlfLM3M7ypgeQMt3+3eTzm6FfLm0r/g/eoRRwe9z5K4pW9sEamHDPyNNZyLq5oB8qXM+7ZCFKrNjAn4tvsIhekcDLXGLAUTD0ScdSSyVvEaRHkl/kaVK9lCFVsP1vOOqQKnRqtWjnh3glMaz2XXj+uV6bdgvztVaGe96MpGcoD0CurxBuTlpYM9H8w9iItTgE+2/KxkYE9I/RxarTG90+402AiA==;5:kUvGVL67xD/A1HQ2qqGXpzyoHUbDso154a7KA5q1M+IlznG9ddf3/smG4+O2MX4uocfhsHCrBkYvD/L4/dj3AZhIAB7bIBt8VcgA8U5tNlMGOb2LcboWSCGEamuBd3AsYYN1wfF0Jbju/5h0vxAr3P4M0QlMlbeNdNbDyq5GE0g=;7:+SLKlO8brx2Sv+gCbiAq0iZ/PKQGtPe84wOKwPIprwp4UGpT1u0ifliLgw4OPb+c9DsMNqAMXGIvPbpRQraQPNHX8DWX3a61x5JnSK9GY1OVZTf7gR4/JAf7A/KfWjpKRwZEAAnMVCZgS8LVJ8lwapMmQo0rkaAK/6Zv4AgrXtOwB/0FyucGlBaO403jQy7EqKjYX2NsF8nlE3+lx55QoZCWMYWBxbZeLUNacXMyflN5IiZHIJKfhDk4soGZb688
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 14:55:09.6185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b119ae2-1381-4b89-d357-08d606acecd8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the filter bandwidth. The
user can also read the available bandwidths which are always adjusted to be
at most half of the sampling frequency. Furthermore, the currently selected
bandwidth can be read via the read_raw function, while the write_raw sets a
new bandwidth value.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 6281e4a..fdaaa58 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -202,6 +202,10 @@ static const int adxl372_samp_freq_tbl[5] = {
 	400, 800, 1600, 3200, 6400,
 };
 
+static const int adxl372_bw_freq_tbl[5] = {
+	200, 400, 800, 1600, 3200,
+};
+
 struct adxl372_axis_lookup {
 	unsigned int bits;
 	enum adxl372_fifo_format fifo_format;
@@ -224,7 +228,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -648,6 +653,9 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = adxl372_samp_freq_tbl[st->odr];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = adxl372_bw_freq_tbl[st->bw];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -658,7 +666,7 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long info)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int odr_index, ret;
+	int odr_index, bw_index, ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -690,11 +698,34 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			ret = adxl372_set_bandwidth(st, odr_index);
 
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		bw_index = adxl372_find_closest_match(adxl372_bw_freq_tbl,
+					ARRAY_SIZE(adxl372_bw_freq_tbl),
+					val);
+		return adxl372_set_bandwidth(st, bw_index);
 	default:
 		return -EINVAL;
 	}
 }
 
+static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int i;
+	size_t len = 0;
+
+	for (i = 0; i <= st->odr; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%d ", adxl372_bw_freq_tbl[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
 static ssize_t adxl372_get_fifo_enabled(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -838,9 +869,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 };
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
+		       0444, adxl372_show_filter_freq_avail, NULL, 0);
 
 static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4

