Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61652C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137A021479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="pIDXCY7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137A021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeLFJLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:11:16 -0500
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:31616
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728245AbeLFJLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFQYdvt3P3vcjUzbWrVN9s6XVYt1Na2quepBDhRGbbc=;
 b=pIDXCY7RakH9MYigVXRvFsZ1wmCl5rBWpSx/BQc1CilsW42vEu9C0LZtXXMFjlu4xQUI8QuWad8ftkcoNAa9fiXVz1BeS+UdsTiYTEuLby6P7QgNvW9cGrnEf3s6e9tXOjIXtIjzpWaBBfNnYhPFnFxScql24TzE5ayTDYZNcWQ=
Received: from BYAPR03CA0006.namprd03.prod.outlook.com (2603:10b6:a02:a8::19)
 by DM5PR03MB3132.namprd03.prod.outlook.com (2603:10b6:4:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Thu, 6 Dec
 2018 09:11:11 +0000
Received: from BN1AFFO11FD008.protection.gbl (2a01:111:f400:7c10::160) by
 BYAPR03CA0006.outlook.office365.com (2603:10b6:a02:a8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17 via Frontend Transport; Thu, 6 Dec 2018 09:11:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1AFFO11FD008.mail.protection.outlook.com (10.58.52.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.13
 via Frontend Transport; Thu, 6 Dec 2018 09:11:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wB69B9kn032403
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Dec 2018 01:11:09 -0800
Received: from mircea-Latitude-E6540.analog.com (10.50.1.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Dec 2018 04:11:08 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/2] staging: iio: adc: ad7192: Add clock for external clock reference
Date:   Thu, 6 Dec 2018 11:10:51 +0200
Message-ID: <20181206091052.7644-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(478600001)(6916009)(8936002)(305945005)(1076002)(50226002)(7636002)(5660300001)(426003)(336012)(8676002)(356004)(6666004)(106002)(107886003)(72206003)(53416004)(2616005)(36756003)(476003)(126002)(16586007)(54906003)(486006)(4326008)(7696005)(186003)(86362001)(246002)(51416003)(14444005)(316002)(2906002)(44832011)(47776003)(48376002)(50466002)(77096007)(2351001)(26005)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3132;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD008;1:CVHFVYDNM1mrPa9JJNir/0wZwNB0I2Gd+RiX1XVJXLBP+wLCZ/l5CKfQNB6/Ux4hUmx5UWuxheaWJc/W8ZzE+Rom25em1C6fZSQAHz7gZ8ZpelrnVIA9E3a+1H3cNU8K
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ede5c8f8-a0e2-4343-56a1-08d65b5ac35f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;3:JCOWbc0+UVDs/thi/BrYK0VG5hrX617d4EjwFQUsMGG4NO26r4Mrcpc+K98Swgp1pXHYiaMZ0V4qnwdvDxqiuYsoza4sluIZsOcBMRKVrJ18Rtrl29WdQ/6m42gNsaufLxa23qffpIpvLAxkpUSzbr4qmidTfMCg8XShLZk2EF5u0xDW2a+MSkvHdg0o3QrX9YLNNj25jJmHM35/cnST143j6fQB8XqX86U0jWS1JI4lEcRvDntXgU9TlrYTUvZEQvGjuZE5twSuFgmYljANkuZvSMAGsJga3kGgkNq6b55YLnp/Vxhm4HObndJ0VMXlPi01yXitZEO/42BmEAuj9BHxLNS8VAeizm+EeqDJLNQ=;25:Ho1Cw3Vb3y2rKIlzICOBDFgLOL7XSprlJNZnQ7IqlZU3gknbrkHN8hx2KuUTNg+1oz0z+GNgFC4jE3rKFeH9djJBDMK1BlU7HkdjtycCeSVIZcP8htQC9T4bF1PeVlnxiQgImKty32+A9o1Ojb+V4CqCagkpifenejltp1LMiZe0dP7TxtO7fNvjvYvyY7OvSA9nh9CQB2D91Q9m75/GpvqTmLZNEOxgIETcpY2c3aFOqXunZhioKAmdP466VjvNp2MCZ+BTmem8ynB7aWrhjWaAWKIE+FDSItVSB3Um3Kcabq+JA2biZsdYOLLX54QphlOdBkAohXgUXHYT9Ylyjg==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3132:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;31:niBEZ2b7TeMtg8Uf/y4V90H9zw1upS0I1vorJNvQj7ZbsfMZI1GyuDvDX6N+7io6qmGsmRuu45NvLbokRFssKnUGXx6khc3T2iD6S3lP2X6QEJ2gp0tCQYkSoZ1D7nMoyaR/S0aXpy1eitovdR/YiYSTq2TSWWsW/L+e1JBLOA0MVZQE1FE8G8MBv6JSkKRmUTDjmyaoHwpoe8PM3ZNu9EYqzkfdJlNOBr+StLkZkUE=;20:HawZhG5p+BRXs0hu4ix7jI5VWwuKUQQVYla4tCmVgU0kJ4r16bwCml3mmMNa5xLSPUM1ZCAbUVOFXsmw7W+qWbXmIkMlOuXq2X90zmp9ukpuwXffKZ9Hayskw+c8bNFNGMqZVaytJf+FDjaMH5BNHdMx2womTq7MkEIu/VL6isGEboOZvblk170RudTfW7wdJne1B31RLGAyUVkbR7FiOJOdvIPBSwTpefD/YURs6kVx0+tlTbzvzvYxqllDekwZLGyHP5fI6W4nxNt49xZTiyKv6MSPHtBjMNbZFDJrin9rOpN1YKbX3hjrtyBSeP6xhdN+SM0fbTNt5ViesxWddMRg6vmRxyXCGG1Es2z1CXK6vsVV7QD64z7liqAJEx96E0mZhjPksPZCXuOtdgN3KTdYPCibHcZKHJDk8IbT1tIppPj5ESDsLjh2e8yb4hUIniuGQ1qHjnrBjoGG7aFSghS2flvebSjK3QrqL8xcQurQgUXnsKyyZssXohS3RQtX
X-Microsoft-Antispam-PRVS: <DM5PR03MB31325E5D17768638AC0E660481A90@DM5PR03MB3132.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR03MB3132;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;4:Iq6I8CNZcJJnaUgwplCMTW5rWVPHg7BDC6ERHRlXTHoxOO49rwWbfv8waf8z+1352rxmbP0RDNj3yZGhMB0FTR/He7aFSEvEGf6Najc8i8n8HgU/J3QJeg3kKEgfpuuONVcC/Yvjm6A1cQ3MfsEOMrjje5lGEEOUDVDB0pd9v0kL3akVg5qvO+hRwgh0zRC4Eryfpib7yfQUQ6fQ6nMI7I1z0nqqmpjfOwHs8rKbgEXHMqiLpWhzgJgo481otsh/R9F10rnxMdSVBIZgBTgz6Q==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3132;23:Gl+SBMsiPE2xW+ic/nOjjIFx2WMls5k9NJchElKy7?=
 =?us-ascii?Q?pNfTtzsmBuPfnxDSay88aXOg8ZYtAiuZEz5qB4WowbGdvVN5wLMnl0IM+Zbw?=
 =?us-ascii?Q?JgnEZo8/TQrbaaXpuiG8PbUt946BsjQmSY6zwBj7mZ0Dp/C/aMVZnsYNlK1q?=
 =?us-ascii?Q?7X511ZYFekvalGrKnxrOe3ofIErt4tLRXj/lHisnXxTHjG20dAMEqzYdhL+V?=
 =?us-ascii?Q?2RCNkiC8TpmOnb4aqbV5n6ft0/wU+Ot64tZYsydXo9F23Bs6e0VY7VDxZ2rR?=
 =?us-ascii?Q?NHGHQ+sStwZ9ViXgMl9gyZ8i/0grWpbi/3BLSqUNi+G2tPqL8oFSGg8bM6xG?=
 =?us-ascii?Q?ETLo+qJDNBdZA+IhI4+OBiBhvXvOlvyoGVFAt3VgceOJt4P8rqI8//RDjp0J?=
 =?us-ascii?Q?877uOP8voLunkYouoFzG5K6+ahNHf85rtAKiUIZzVnrLQF0qrcVSSzfsh64h?=
 =?us-ascii?Q?U2BIXzsN4C/gH+sDoXipDiSMzHQMfMN69os8zfqBzajcfZXh2Qg9KQq8d2S0?=
 =?us-ascii?Q?gCtZWDET3Po8vbmtQvFMmDji7ZVGfw/CNeGQQiVoVX4eGOOJWnWUjbLmd+iC?=
 =?us-ascii?Q?/ovVGmVk33sxo/Zqg+JUf66J+UxCRMVA/MCbYhNLZOihA6LNS6mFBTfrJAAT?=
 =?us-ascii?Q?kDQgutntj+WZwacmCWRggUQk18yxg2xRfnnM1JMCfpACqqpG4G2fE5fyQb9/?=
 =?us-ascii?Q?KZsz8CItw4rmyTQuq90spqHZ1weIjyrtrLw1T4hxOhsAMy9uYZS/RIjgebkO?=
 =?us-ascii?Q?rur3yxmaTkGjej7sK15TVPzfMlt4VxGLlAlJJaydzCHL0cJqPj//KeoyLz0I?=
 =?us-ascii?Q?CKiDVhiMoxK+g7Zui47LPjwg1NYcNPtg75aboIrYSMtmab3MKvE/jC9Hk1DB?=
 =?us-ascii?Q?Fj7pR8aejI15NYsDp07V86lPdpRxCOk9AjYk2gc8JksqwnbQCEP7iWoAah5I?=
 =?us-ascii?Q?KiUyzcnYLjUKLTkxR5QzD9euoKVuZNhQKGUk+vlosFEoDwOrztlr+LcD8ouo?=
 =?us-ascii?Q?flNuJHiKwWk9fF9Cnio9aEN0AvzVBXxJydJyhsQz9gCY1S05vczNHgsBwtIn?=
 =?us-ascii?Q?9e8lKRtyiZqF5o5PLm8lAmSJ9HC?=
X-Microsoft-Antispam-Message-Info: YTteSsggqygAjhL+6XxpMStOJWIqc/bns4yJYLuSbyawhWMgz8969gJ3KU0/HcEfNk/jZOLoJEz+YGswvtyH09MLxUXEX8u+TOq8lmDcJ3Xj4RQ+ydHmt8e5pX43f191Oy7rsH/pU7Z6BNoTIjOz/m5Sv58CAxUy7nEkn6UQsperbrNGGEPTGX64T+PXDWpPt/aI5RhGK2fgHd88PLThUJjEhLuellm43N2KlNUsg+53HpvYUZhI3y9arL0Bg583dvaGNfx17xjIvC+LZEsZOMhuQh5L5KUukfVYiWDTgpYIPUXlC8+qQRYrb2VObBbAVeww/BNBwsQ9YiKXnaL6zQT4qA542tMp3HXbELxIuUg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;6:hYZfIJ64Oth8zD1L5xKLEqbYVnx4roJqHzLTbscaZLlBMwid8mb6jFh53a/11sbiA+Ye7v5TPpxA6DZpFlJtPQ1LSzBf303IhJina/ezahvTX7MZaV58mKBi/SmJUYj6tFRO79UNa7PjkTaLOnJrbuSLoyW0yXuCXKLh6qAyPCy7p30C7FD6T2IXw5I8eEwixLkMnQtirK+GfKV+lCPtfu+tvnMMYwRYt9X4Q+l/wPJS1sWxnsxfIScvp/1CAYjvrMQRwSjNuZa1IVyCigAhohFSTlPsToE+7DgJL6VDkbkgGMSv6Orc33HmFjuPaTH+o3CkwXEd8A88YzAri/8Qj66a3oJKBUu5xji9NQGigQQMQkyVlekAUxM7G9YpOxCkbLB9zjGOjVlnyntjoqjvAQ+jlQeUqdhOoznnipZbedz8U7oa6SZeHxZGGgcDRPRWoJnM7YTOAg/TFU4cUGAIzQ==;5:i/59qmQHH0jzq3DkXwvrdGA1WtPXBOaKK6OM6PgYMGLGXqX2yEv9hXiM9j8gxi1Q0F5Uerjxvqmlaye6AiiSXTsPh10kM6IWeqOVbaO60hRrz0XV4zoX8e1VFiOSqT1UWrF8Gk/uJefqV1ltsdnbhRVyrPVR12Zi7Cs1xL4ZMjA=;7:7azyvdvRYANQhJUm4YtqxC8gwi9zlCz5UqmtM1skGZLj4rpN4DW4mUBP21Is3INwxX9f7mA4tc2HB/Q1Sazt8JcWH/PBKNiBodqpQOONt64p+2dlOE76vIajpaCPbzTdofjLOIJJOc+C1MZ2+uG6Ig==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 09:11:10.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede5c8f8-a0e2-4343-56a1-08d65b5ac35f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a clock to the state structure of ad7192 for getting the
external clock frequency. This modifications is in accordance with clock
framework dt bindings documentation.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 74 +++++++++++++++++++++-----------
 drivers/staging/iio/adc/ad7192.h |  2 -
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..8a4e6ede42b3 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -156,8 +157,9 @@
 struct ad7192_state {
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
+	struct clk			*mclk;
 	u16				int_vref_mv;
-	u32				mclk;
+	u32				fclk;
 	u32				f_order;
 	u32				mode;
 	u32				conf;
@@ -165,6 +167,7 @@ struct ad7192_state {
 	u8				gpocon;
 	u8				devid;
 	struct mutex			lock;	/* protect sensor state */
+	u8				clock_sel;
 
 	struct ad_sigma_delta		sd;
 };
@@ -250,28 +253,8 @@ static int ad7192_setup(struct ad7192_state *st,
 		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
 			 id);
 
-	switch (pdata->clock_source_sel) {
-	case AD7192_CLK_INT:
-	case AD7192_CLK_INT_CO:
-		st->mclk = AD7192_INT_FREQ_MHZ;
-		break;
-	case AD7192_CLK_EXT_MCLK1_2:
-	case AD7192_CLK_EXT_MCLK2:
-		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
-			st->mclk = pdata->ext_clk_hz;
-			break;
-		}
-		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
-			pdata->ext_clk_hz);
-		ret = -EINVAL;
-		goto out;
-	default:
-		ret = -EINVAL;
-		goto out;
-	}
-
 	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
-		AD7192_MODE_CLKSRC(pdata->clock_source_sel) |
+		AD7192_MODE_CLKSRC(st->clock_sel) |
 		AD7192_MODE_RATE(480);
 
 	st->conf = AD7192_CONF_GAIN(0);
@@ -499,7 +482,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->mclk /
+		*val = st->fclk /
 			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
 		return IIO_VAL_INT;
 	}
@@ -546,7 +529,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		div = st->mclk / (val * st->f_order * 1024);
+		div = st->fclk / (val * st->f_order * 1024);
 		if (div < 1 || div > 1023) {
 			ret = -EINVAL;
 			break;
@@ -625,6 +608,42 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7192_clock_select(struct spi_device *spi, struct ad7192_state *st)
+{
+	int ret;
+
+	st->clock_sel = AD7192_CLK_EXT_MCLK2;
+	st->mclk = devm_clk_get(&spi->dev, "clk");
+	if (IS_ERR(st->mclk)) {
+		if (PTR_ERR(st->mclk) != -ENOENT)
+			return PTR_ERR(st->mclk);
+
+		/* try xtal option */
+		st->mclk = devm_clk_get(&spi->dev, "xtal");
+		st->clock_sel = AD7192_CLK_EXT_MCLK1_2;
+		if (IS_ERR(st->mclk)) {
+			if (PTR_ERR(st->mclk) != -ENOENT)
+				return PTR_ERR(st->mclk);
+
+			/* use internal clock */
+			st->clock_sel = AD7192_CLK_INT;
+			st->fclk = AD7192_INT_FREQ_MHZ;
+		}
+	}
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK1_2) {
+		ret = clk_prepare_enable(st->mclk);
+		if (ret < 0)
+			return ret;
+
+		st->fclk = clk_get_rate(st->mclk);
+		if (!ad7192_valid_external_frequency(st->fclk))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -672,6 +691,10 @@ static int ad7192_probe(struct spi_device *spi)
 		goto error_disable_avdd;
 	}
 
+	ret = ad7192_clock_select(spi, st);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
 	voltage_uv = regulator_get_voltage(st->avdd);
 
 	if (pdata->vref_mv)
@@ -720,6 +743,8 @@ static int ad7192_probe(struct spi_device *spi)
 
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+error_clk_disable_unprepare:
+	clk_disable_unprepare(st->mclk);
 error_disable_dvdd:
 	regulator_disable(st->dvdd);
 error_disable_avdd:
@@ -735,6 +760,7 @@ static int ad7192_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+	clk_disable_unprepare(st->mclk);
 
 	regulator_disable(st->dvdd);
 	regulator_disable(st->avdd);
diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43c2611..3be3ee269ed5 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -33,8 +33,6 @@
 
 struct ad7192_platform_data {
 	u16		vref_mv;
-	u8		clock_source_sel;
-	u32		ext_clk_hz;
 	bool		refin2_en;
 	bool		rej60_en;
 	bool		sinc3_en;
-- 
2.17.1

