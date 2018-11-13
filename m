Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0068C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710ED20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="O6c7YvS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710ED20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeKMVSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:18:31 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:52192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732037AbeKMVSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtLjkenjzaW7hR4QsPYbH+iZ2My4V9nF+CGKzwqtfjE=;
 b=O6c7YvS/3EuwBNQK4jstoW1Gqc8ZLNM4SIqNwMbn9wlMe95qjjk1n0IE9mvrNLtiNfQzIQKeb5QPHtMyl71VkkZXpGcUc4kZTG5oQI5zwesXfI916cp7z4+RE5sCWNcn/v91P8svUR5l/7xwAs11knkumcPv5kwVbswQduJ9AYI=
Received: from CY4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:910:4d::39)
 by BN3PR03MB2259.namprd03.prod.outlook.com (2a01:111:e400:7bba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Tue, 13 Nov
 2018 11:20:33 +0000
Received: from BN1BFFO11FD008.protection.gbl (2a01:111:f400:7c10::1:159) by
 CY4PR03CA0098.outlook.office365.com (2603:10b6:910:4d::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.20 via Frontend Transport; Tue, 13 Nov 2018 11:20:32 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD008.mail.protection.outlook.com (10.58.144.71) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Tue, 13 Nov 2018 11:20:32 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wADBKVYJ025335
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 13 Nov 2018 03:20:31 -0800
Received: from linux.ad.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 13 Nov 2018
 06:20:31 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v5 1/4] iio: ad_sigma_delta: Allow to provide custom data register address
Date:   Tue, 13 Nov 2018 13:20:24 +0200
Message-ID: <1542108024-3307-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(7696005)(305945005)(7636002)(54906003)(106466001)(356004)(426003)(6666004)(336012)(48376002)(2906002)(72206003)(2351001)(2616005)(50466002)(6916009)(246002)(476003)(186003)(77096007)(4326008)(16586007)(106002)(44832011)(36756003)(5660300001)(26005)(478600001)(8676002)(486006)(47776003)(8936002)(50226002)(51416003)(107886003)(316002)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2259;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD008;1:kCzXBghqwplAjTWX3biqUylVLGgcVbvig8ktTqP+F4VOx/lYydqkK3wKQW5NxSFcSyeocpXq1bTWK9WbE7lVMRoqwbXoSERfE6uZ6VlFPBTndZI/Bln85+sixHXWGRqA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01539506-6215-44bd-f98d-08d6495a0695
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN3PR03MB2259;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;3:V27vPEXQl9bCOM0FVENaNH5Veqwb6s1H3i8txJfZZAOGujn7G0G0xGLIXXbZ7Ib+VDy23LG8eb9GQokADJc9FTMfZi8+Hb5Sx0ZP90g9i5WiHoR7TgE+4Nuppryo6XD/317IzsgfzdH4IdPqJVONolaz+ZwYo0tbArE2m1ZoL5oKwVM7DlTs96b90W53TvIFe1xyexIpeKAL5i9wI9rRWlQOlD+kJc/nl1dgVR+Lf18Hh3/EBFTWssnaCXR21Ih+hfbrEl41ZUlyIeJbGlGBl5naBv5DevZDhqtmLkZwZ/PX2c3vktdPEKmVA7Xy4X+qdq8+cLKbbqScIXOdC3xobArU/hDyloXEgi3/Cf++WuE=;25:ypFuTriMldzdyHa8RlbpHnZKW3121LVdg/dUOSwJlhw7BQYWJEy3ojwm3Wt/0FQfm0nL6kFkLBHCeCRuhCXiLnEihrOSaCokeYduLNu75s5qzREz4CpU08LSsuXqWb5SghbL374vSvSVd8i8FV8WXnY8DdJsKBycEVLzgNJiEz38Byd/uVvlEIP5SfUXexuCbOWaKb+tkbaAh73Vq89d6oT2Znlmdzh5f1+7hLB5FE0m1EdtK4lAHjfeHWsCfY4yIGgje4SCDlzASJ7tEI1Oem7nQPMMaJVLPg0ymkFV/aOnA6lO1x6YldRZbRemTj+dqn31DyjPHDa4tqYhtoYIB1zIWRuNEIuGMurPW02+Ho4=
X-MS-TrafficTypeDiagnostic: BN3PR03MB2259:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;31:+cGa5nMpThkCRD9C8iGWbBVjKyg+mFf/ouzvZTfQ6oyPEawrwQhy9vnByR28imHBaoVKzRZeN8YJK7yARpNH9awgEsLiWI8jATNRhmBORgJfEfIeFAaMV71ztxmOU9wyjqRNCSaZQSOAan8xiMsEMbcLdt8IAZb7FbDmPz4RyqIPMdW3jM0O3URO9+OqWhH2HvsUDK1Xup6ZeeBpCayXJrVtok4l7E2CEwVYXrTv4vE=;20:X5FITyiNNw2KBPCC2lYmL9joU9XkWCUcRUzuRK6jTiiCYvmMFhTPte+FcSb0e6bFlk0GWN7L4Pm9E2uhkaD0k3sOCCr71/oNsNtLU6YFVPM9u/cj1bv2qos5Og+VggZqJ1hWsCsdj9en2UE1c/kE5BdODtwFpbk/eAxGk8SsismtLgGrWN8F7jsPwUiXPYwsn4lSSsv/cPlNDOfJeQK9B2dY+Ay13Hwjgk8gYTQJucb6qN6Mfy9Y1K3m8eKfXVb5IACraxtYGJqZMeS2nSfBuZkv5HML8OD0p/0EHuAbMw0Je+qprzXD/sEFhJ5CHplL/4jP54FXL5sUNJRhIYPqUN1XCH9GWbr6mJBro52aXK6alOuJWyeaRVZG/rCIBPspzwc52u/0HuV1OoA3OTM8bbMquep3MaQuRy3Hq07ZK3GtDyNb8nTrpV31Ka5RqR24xhiJdn4DTShw4EIUo2qdHE5w+GUSA9nn8021+Ir519UXOA4qNxW61Y2iRmVFSz7T
X-Microsoft-Antispam-PRVS: <BN3PR03MB2259AFAFBB548FB35E43B9059DC20@BN3PR03MB2259.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN3PR03MB2259;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2259;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;4:GDNOdgJ150MXJGLqspxh84aZcWdjb8YukqcfyaiTyxGxQBkxMZ0UkrQOITcvF0qYrfWpW3aYIdqDOkqFcT//MPMyALgcsOGBeAtNGi2zxPk2GW3cMFOCgDAxgzSPVngDpVXWCHtyIpd8EWlmbf2TyKPqC8WpGVvoML3Uygkdb/UczY8ZZGJUys+Iy2fYpVkgScXt9CAI+/78b1G0we7XiKEglhiNIHQNolcqGGFywlvZLMtINj4LXrAi454pSFXLPVOOiXwh5cC9b7OhtQZl7Bh+TYruMMB+r87bZKVUfHeUkPZNsufFUOoxLMWtkxaF
X-Forefront-PRVS: 085551F5A8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB2259;23:6LdELqElt81HLuaJqQU78O7CR4O6C5ohr+NG2WGsG?=
 =?us-ascii?Q?bntDpLf0RHvSp5wVexUMJ8vf92eJmpSYz881etYe4xARLGmR4ZOty4jXCF3S?=
 =?us-ascii?Q?ENfCfasyCUk8AyD1pHVi062iR8YN9hlyyrUPoTYBI6sXuAlUeMSmED3dZwMy?=
 =?us-ascii?Q?sPKQ+4tp1MytljhxizzodRmsvyysh5Wl784prMm4rbOzqtIyryrc9XVadseq?=
 =?us-ascii?Q?lFYtfl7w6GAMzDJRcO5BUmuBYap8MqxjKVyIQMzd767lYKMaAyCo+ByC3a34?=
 =?us-ascii?Q?PdN/RIBVy+dzoUneovoCF3Jvn/MFkqGmLUOfxjXY3v1aOTDVI9yCn1VEG/7o?=
 =?us-ascii?Q?QhKVJlxleRvyx+PrmzadEMMA3dX2FOFcsxkP0Zum9XJDC8bkTbt4I6rwgty4?=
 =?us-ascii?Q?pTt2yP78RsaLL1oZjwlCwaqjUDXX/4ZafSR5OOvnrf4h2ON9PYutYUhHi10E?=
 =?us-ascii?Q?CY/pPEzfCfTtFLzPjwHe7pDsJrOn378q+oFOb8zzaPEIJjTJiDdQU13kzWta?=
 =?us-ascii?Q?6GI00Tjq1msLGtVlVHZqV3GM4Qd2RHgrLCcTeJaJnadRbu7gNLb5++18OQuJ?=
 =?us-ascii?Q?lZKuVVls0hbGvPPaulqtzwbpzqSr2sgFrHbVWV5thxMNob7CfmVNVIxAwIcR?=
 =?us-ascii?Q?d1cxWym9jH7RRE3xDqAj+oQaoAxG3R9cAiSEVERcldvduS6b/Ema3SFWfayD?=
 =?us-ascii?Q?jG+ANSwMEDkP4amzgeCcmjJ/Bjser75ZuhIoqeo3yEymRt7kd4XyWw9NjDdl?=
 =?us-ascii?Q?yP6wIxybEerQEKO8v1NUVzqXFSY1TOdUFmW8TwfOQGmxesA0aUvHis/n7/xt?=
 =?us-ascii?Q?o47HjEQDHzz5WpOfnYfyQlaRXcy3YMwstKumiZ0gHu74ZXTULb29eqlECk4q?=
 =?us-ascii?Q?e0nrGeLkhXSA00mUo2GFJkVy9DWweFNg2eFN6XSvaKbShuvju98ILQALF27j?=
 =?us-ascii?Q?Zti5ubqpX8wZdk1qs/J9M1H366rgId2Yg49rqzRsHbAftZrCHHYmjmooaSKD?=
 =?us-ascii?Q?29r5uKLkmPa5fdSR+n4hfq4?=
X-Microsoft-Antispam-Message-Info: zyvMt/RjMrTfh1jn+FiAHA9pQcfFHpHeBJdUSZkSxcEiKHmf5l00KM4juufjuiySMvmegGU9xUk5c//bQz7Qt5jvGUX9Ckn2IjYni4lSAkKv+mv8ROc8hfQde7urhAFZWiDFkm6BHZmA0n5xDJ9Wtpe4l6D6TA+RvAWdzRTap0QJMU8sWr951XSu5syZefWiZ+ASdCOrLMJchPdhvmryr6JVd6N+oItcctHwmncD0U8hqlRJrPEuTJ0+eJcU3A6gn1y+/DKi5bgjS1lySpiXpVNNwI35wuZFV7bLW9nGDHvNyuFhK+5A7T6o0z84q0PXksEcL1MDHoPtbyuq3SBRHxBb+pjdDxbGFrOMD4IXd4w=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;6:2UIpivUQ0/lES0/DVn8xBOoHPu1gDQKSJe1qj9Euh4bSLeTOag8wveA7OaA9sY3siTbX6SqxU30AWkUXj862nOsF8g4PZlByS/tXTSDoKw9WEIteXDypitHbxuNEtWvQ1lLXqQCbZRxp78UynZhpVsjR5PpqfliowaFoMys1l0knlNpWWo/rj7IQ23HTbWpiAVPMi8Pnh5/pQ30oRN8+HNm1qzjSnt3zHxYRtSQvqL9dX2jUB2XAKcOJWdIHqdE+7rF8C0IOD8prQqiWNSYAXHZIZaZqRtQXmpbuikizc3zEj6vpVBTfiuRBp0/W7OZUBlF4Tz7yCy5Zw+MCqLK6z/WP4AvF9sFhsMlWp5iY1FxMhTLGau+U9SxdiQKhCtvVfE4lJZVD3dAguTbCFBmsdW8J2k3TMwjA1mDLOdbvOpFB3T7eeIIkzsVDIW/xC0TD8hQPM0uPUl2vaXEp/sBoZg==;5:jfRSht8h/W94X+PuojP0U1zEWf8T2VdXpUMCQTdGOEjuwq3Ic1kz8mAjbibg+wcC66hfHVdUBGZn9Wk6gGDPZjnz4qnpFpJ8rxx/xpbzcJ5NswRDQyUj2S8BbZgqgjSixBAmTqzlFGm3epggeUd8Wc2qsZ1PIHvd/ph3OqdpJXA=;7:2fsMKLBkQA/YElPkdvbfrbrcxQixs9KieJYYtaV/YvNDwtK8vPJNiI1kdE3l652uU5G9ChjtBlSRxm7eoI0ixnT7F5PZ38wD+Ps2czgCMVB/4TYHyfVngbGxDj9uQEYY/57rqnq+ip1i+JKXsGq5ow==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2018 11:20:32.4629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01539506-6215-44bd-f98d-08d6495a0695
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some newer devices from the Sigma-Delta ADC family do have their data
register at a different address than the current default address. Add a
parameter to the ad_sigma_delta_info struct which allows to override the
default address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added this commit.
Changes in v3:
	- Nothing changed.
Changes in v4:
	- Nothing changed.
Changes in v5:
	- Nothing changed.

 drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fc95107..ff5f2da 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -278,6 +278,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int sample, raw_sample;
+	unsigned int data_reg;
 	int ret = 0;
 
 	if (iio_buffer_enabled(indio_dev))
@@ -305,7 +306,12 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto out;
 
-	ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_DATA,
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
+	ret = ad_sd_read_reg(sigma_delta, data_reg,
 		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
 		&raw_sample);
 
@@ -392,6 +398,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int reg_size;
+	unsigned int data_reg;
 	uint8_t data[16];
 	int ret;
 
@@ -401,18 +408,23 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 			indio_dev->channels[0].scan_type.shift;
 	reg_size = DIV_ROUND_UP(reg_size, 8);
 
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
 	switch (reg_size) {
 	case 4:
 	case 2:
 	case 1:
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[0]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[0]);
 		break;
 	case 3:
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[1]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[1]);
 		break;
 	}
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 730ead1..7e84351 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -39,6 +39,8 @@ struct iio_dev;
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
+ * @data_reg: Address of the data register, if 0 the default address of 0x3 will
+ *   be used.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -47,6 +49,7 @@ struct ad_sigma_delta_info {
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
+	unsigned int data_reg;
 };
 
 /**
-- 
2.7.4

