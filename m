Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784ADC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B948208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="X2WfeW9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B948208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbeHARFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:05:15 -0400
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:56176
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389694AbeHARFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olx/U+THbusnFfv0YlLXsFkj5Ph+ZE2KnQqD1XwgYhs=;
 b=X2WfeW9kwvzTUfT5XRF6y1J4fZSLZ0FtT100EGH1YJH2ccPE2dLKrZqYtvLXWGtVC9V4CbqMhHThYriE7D6rAYcEjt1tFvD9MkNmph0eJJKFqQyyHuInmp0JcZs1QsuwKwc1wfuMyctIDsdz55XNVn2wNVn4XUHBH9nE5T33vzc=
Received: from CY4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:903:33::28)
 by BL2PR03MB548.namprd03.prod.outlook.com (2a01:111:e400:c26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 1 Aug
 2018 15:19:00 +0000
Received: from BL2FFO11FD027.protection.gbl (2a01:111:f400:7c09::195) by
 CY4PR03CA0018.outlook.office365.com (2603:10b6:903:33::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Wed, 1 Aug 2018 15:19:00 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD027.mail.protection.outlook.com (10.173.161.106) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1017.15 via Frontend Transport; Wed, 1 Aug 2018 15:18:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w71FIx0Q027981
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 1 Aug 2018 08:18:59 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 1 Aug 2018
 11:18:58 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 6/6] iio:adxl372: Add filter bandwidth support
Date:   Wed, 1 Aug 2018 18:18:50 +0300
Message-ID: <1533136730-32149-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(438002)(189003)(199004)(50466002)(5660300001)(8676002)(246002)(4326008)(6666003)(72206003)(478600001)(7636002)(305945005)(6916009)(356003)(50226002)(8936002)(48376002)(53416004)(107886003)(2616005)(476003)(126002)(2351001)(54906003)(336012)(106002)(316002)(426003)(486006)(16586007)(106466001)(26005)(77096007)(186003)(2906002)(36756003)(47776003)(7696005)(44832011)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB548;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD027;1:pgcM0iR2KBs4Rij5sxGqFIr63crpax4V6VYbDjSVtS2BdwNWNhJF6foIPDzX0aU/OBD3qxSaYZNLpy/OT+W76seQTUJCa3kAp+mBgXU0/jiAV8AZTudCjy0qJ0BT7bX4
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b306dc-28c7-4765-3194-08d5f7c21b7b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB548;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB548;3:Ww8PK4P+fs7/U4s9gaiL7fJid4znZ2o0OfEZOdMQKwbs1H+Ze74QWlaBL4jZ31glzEjaHMco5p6L5go++1RS6oDXeqaXXPi3sW7CXbB/8u/nsg/OV1ImCNE5hsKAKHKSIwrtLeyAnKKsxwlSpdR3fxKg0+qgVARQci/dsgMCJ44VzR0SDyioCCQQJ4Lwjq/4Cs7Y9pIuSzwGlh9TGi0PSSFby+u8qMkqQcyKWyFeW3157eav1N0pbxEmmPt3U3owiOuc/UWDEN8scnIvAt+7bKB7ctkcJqYlwaMzkduGal3wC0cxSDLQ3sGaof6AIPXK7x+WYcuz60aU62NAf2+fWvM89Qts9ttphsJ7yHKGp20=;25:QbcyQeC8k4LLEl8EEbSKh4zmpSO781z6sfbM230bQE3A0bJe/II8vDn8ZgP6OR7UTrLuPfmtztoP0srD3k6f9XZ6AgYyun4JG21Og34Rij5wbaOl6xPDlEyux9Ltxm2qTL1K1JQBC8efkMFixZ2s8Ekw9aw6mm+Zqjwjz9x5CXw73kc4isg3/2AugnaSF9Ce5nAVNqQg3IwHPeEQInQSOamxIHkAxAK5vxTEJOtmGrVkm7k3TOLZUZBMfPrmUOabR/U2ZgzhcrCZ5UkXxxwDWIKLkYhlUEIarIADYx8GjCjHfds84zo/pcb2ibpkYT359ranjieNj+h+ejz2TosyUQ==
X-MS-TrafficTypeDiagnostic: BL2PR03MB548:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB548;31:0KICXh4AIkicDYGM8ZbauAaMfLfKdZTqBua/9ASybxJv55jC+XomtWzr5SWBZnVpCc8WHHBBwL9cUyR1A7k+yTVAdcrgs5DsKt4ip7kbGyjka0iGRIvJz9i0vDDjWTH0oMYKd7xZDifMIN9XKgkP8JviOHztkO72EFDtsvNFFOUrdD0qu2vqD9VQUYfAAC4sMEaO9iXD6gf/qXIOX/PRdJEKXRrmHyE0RtFkliQrGrA=;20:ltbSFpLDZ5RcjzAa0mdQai2k81xGe7aPA3CSHz1jGSjQEysOwQfvU+lf3+wFVQvxOPG5rVlza/DXudsBCZ5zLOuRqeS488Sj0PbzGqwfBSjsLFkdizH91fNO/DK6w3Qsm/jqqJeEGt5iUT3E12WW0/IBwMz0BVsIH49riIUze13/KErtBedb7bQm2HshFCEtIhcJJRBMm5dC0MNawwXFeNiUP8L0O+0oLorpeGkfny16wRJKg9hoMaxu9wfnZzzSDuHn2ZzV5Oulb5rKOu9Do3Yo50u2vgYEb+XGCOQTm0EKbMdnG70uWD1QD2g/hVUkjPsF1IYg/HqR5e3kvTAWW+tDH7wVB9Cw/qhU4Md3RDak9vdyAje0hDNIpnGEGkHQ4WJ5g2iEm7D4tGJWtg7i/d2CpZrhm6tTE+BI3YgsiVHllvJ+CXwq4csVvV+ZyDO1xDGOB9gym4jNSyARGwakW6oapQcm5sHeUs3nWYhhOJIL23CRV7ptT/qLyPoXvZFu
X-Microsoft-Antispam-PRVS: <BL2PR03MB54832FF04DDA438D7C2DE6B9D2D0@BL2PR03MB548.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL2PR03MB548;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB548;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB548;4:lH5198J6Lk9Wf6pWWTawplTb6Q3XjTlqcznq8XahW5fTLxT7D0DTJuJEbf5lVh4zw1FxKmrbaZSiLYUnzYDiVSvv+3+SKA/7S3plTbydD8MspxBYZP7ocoFEreaNghc8vCf/r5URQpA6/MaAISKxt5ogfBfcMDNTKEtY4KlD829149ZM169z9vxKl4SRyWRv9qYAuUJP8f+PIy9c137Vm4WWp0jB+aQnySiHKg3pHqLruLUx2cAt+E8pY3Kg8+T3uR4VXmSyjXaoksVPEcIFBJRg4J/bnmwqRR8OwD5CuWitAYdgwzcIS6D/ijWkeXp2
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB548;23:fHvJLXIqq3q1+UvmPG/n3iPd7ncYV1Ej1TiccGx/k3?=
 =?us-ascii?Q?uPJXRFkasBx9XaFkE3wiMmk2ivNZXotS/fIwB7sqSeI7JM0Kg20H//N0eqfy?=
 =?us-ascii?Q?9RFr54muBFITCC4ADxzzBi7WnfppJzHr3XX/7X3Gb9+/be65SteWqeph42qd?=
 =?us-ascii?Q?MprhYF+sgLLmS5KktJJqsEKP9H1nI2LHbTo8MFlMjqPXelnygJZ9s6C77Bv3?=
 =?us-ascii?Q?8fmXMIRiL+m0x/t323zEIyk5ech/QQqn5p0lHsN+RrGfuGQ2j5o/XFdYdPUn?=
 =?us-ascii?Q?9ieonwsgKMO6HlAmbb36a28YLyRcpUwjGgFpv1Avh1r6T1Xk9x89L0e6ylDp?=
 =?us-ascii?Q?NuHyaLpzToTBoL0OXoi2Nm5gEecRDXULwrrVQy8FgggcGS7PyFprpXdaQ/Qp?=
 =?us-ascii?Q?Xgg3L+8Nj6pCwP4sQT5GmB0MjaXTFv/trdIUv+12WyGFl/+xCiKH6I0+f6Ao?=
 =?us-ascii?Q?MDD6aF3DpNNev05K7eVavVrCw8jIrLdKnxMVzqnTSDwY5B2vtijhLF25tAf6?=
 =?us-ascii?Q?lwAbgKYxz2LldRSeokgsW3oBY0fXD5k8mOkxy4mDSADkOgGYkWg0IcXAd3bW?=
 =?us-ascii?Q?ndTG7Zb+nD74ZUU+jY11QSQb0RrEou/Q9lRXGgX3ZVVimoYdbSZfaYKIkSnK?=
 =?us-ascii?Q?7zLc4l87SLMcCPY3TryAWN41KCEDeIRvXajqR1ruXfmfGlL9ErKHNtyeJDGt?=
 =?us-ascii?Q?fbTgpw9fre74LYFkBtplQozbOVCMXlped5ydvyX+ex4bGhuZkR+eXYzBEEsv?=
 =?us-ascii?Q?lpJrGbgWp4SSJrYIVPHJvbQ25e+zJMt4amo783Ht08E4drIWUSHyE8VFbS2p?=
 =?us-ascii?Q?EpZXpLgdWTQCafLynMzBbRYtjA5EqFkpK0+RszQY4EJWZG3+9byL9iJikgLQ?=
 =?us-ascii?Q?zX65fiMUKy0LZWA58OwwxwN2ojARXu9JjBgN/NqbnQoytQ8OvTZvbSe4B1Zu?=
 =?us-ascii?Q?XQohoSC4LKRG0RohWjaUeJFrRl9mfu+R7NQupdOvyjIyJRT1ZVnWeOqxIwhW?=
 =?us-ascii?Q?fV5aQ0Belf5k14nhrBMwcKXOnfAVOKON9cjO0At3QV7g=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ibl+CJGCGti/erBRLK8B3mAGIMoulIn/TuyRBXiaDwnCCGm0QMcPgbprVbPwo/bYoHlkNzGAp0ueSQ7ZiaGAubj0idmhN041ev482lnTnzzTLuc4Y+s5+qPMDtq/DMrhmt6AZZa5F7Dv+848tWuMu8Cmx4cCIkR1ZueCp/GGVkwBoVfp5FDxmzrqGP2W4JAROeKInNGxRuUVValtrBnalofWoD62dCLGfM4d0HRf/Ececy8WDUDQnzHi7cTJnHVnMytLA1VPjSq6+iR6hBI/h7FUuLVbhFCag1SYZKJMzfMdgxwJ9PRwsDAKN6PRzF8/NCuoTvXXj88ndZrgslWobA==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB548;6:P+r8Kr6UFjewztR7WEWgMH0+f6j//BKm4sqrQccrPH9XSrH8djhz8nuixn3u2D6cq4osYCr+Fwin8AVk9ZNjXqNvizKOcSh+xheC3VXQ9W5e5/wlo0/r0+krNHwMdEl472X4Cb+7ak2wtLctK5xEPfWL8F03gJk+5mpM3aTxfScuZjtbCLvfh2fCmnfIg6VWe1e9dZuXyn9lnUDostD9J6GmHbSRU/Q+5oJJ8wDYNYl/F1JBgb2CuBFY/3Iqv7oXvbUAgi5eH7ogE9W5Fh/glRVnEOd/HoT09BvgD7dlgL2/8B9mR3Bgrr8iBNVQwVaD31B/nfnud2SlcVUWZwQfI6Gckx4ojXb0C3n3V3Oo9HIQhtuIYAdl/0TNNf2VNZB0tW7Ncn8ksivlVvs3/DF4xC3LDyPlN5j+ci6jw50UjC7OlIMH8iXmRT+1kQdVo7pJTWfMC29Qja9Pbv7e/jgHPA==;5:Ys4urz+ZUKjXgNCjyjk3HimWusYtXIKqO53HqN5jkzidFR0i9RxT/q1SKvqFwvUfaZassHk8Dk3ESOE8eqofMJnpGb1smXl0DDe/g11ODMPfML7OcWXTXAmYMr5nyFIBifjfMmwxPPhp2YcGDLqKuzpwzMgXB46QdGRlHkEZyuI=;7:zlK4kTldZU8KIGFfgB/51Ow1Y52FxRZ3QV7eYgAybtY6QNmhluh8Donku1N8V0F1YvwYBZCbADs6gjkNuadDfI0qIwEXQDwWC6v235ybJO02A+BcrkaXZ1AhS4Rx51pmeuU0U0CPnxebreWpT8chN+HYcLAOhwgcZQITYMeGa0H1xoLuV59fd6tRMcacJk9SY1/vYh6x2HKFkmvpQ7BpxrJqk0U86V5FUqNJtiLuHQMkbs+cqYyNLphL9WwfS1sd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 15:18:59.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b306dc-28c7-4765-3194-08d5f7c21b7b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB548
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
Changes in v2:
	- nothing changed.

 drivers/iio/accel/adxl372.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index d9e4826..5c55bed 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -195,6 +195,10 @@ static const int adxl372_samp_freq_tbl[5] = {
 	400, 800, 1600, 3200, 6400,
 };
 
+static const int adxl372_bw_freq_tbl[5] = {
+	200, 400, 800, 1600, 3200,
+};
+
 struct adxl372_axis_lookup {
 	unsigned int bits;
 	enum adxl372_fifo_format fifo_format;
@@ -218,7 +222,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -668,6 +673,9 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = adxl372_samp_freq_tbl[st->odr];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = adxl372_bw_freq_tbl[st->bw];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -678,7 +686,7 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long info)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int odr_index, ret;
+	int odr_index, bw_index, ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -710,11 +718,34 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
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
@@ -842,9 +873,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
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

