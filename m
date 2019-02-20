Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2313C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2652086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ZOKNwHCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBTLJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:09:27 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:39680
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbfBTLJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p500lZABO4Wcdqk8Q1eECS3U8T3QPHnc46ccXn2coI=;
 b=ZOKNwHCgNuk6kcnS+YdwaeT2ElYgzx4Fn59N6PBKtvGf0mArS24dWJ2pVfS65SC7vw5NvFW8lzFgUo0XXOw+rEQMuJyoQaW49L9XtoXcUcf+ZAAmeaZo0J94n3/TRcVrMXJWr2E5ICJ9f/1yM/ewssNdxYdebEibjS6js+lFRog=
Received: from BN3PR03CA0107.namprd03.prod.outlook.com (2603:10b6:400:4::25)
 by CY4PR03MB3061.namprd03.prod.outlook.com (2603:10b6:910:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Wed, 20 Feb
 2019 11:09:10 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN3PR03CA0107.outlook.office365.com
 (2603:10b6:400:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Wed, 20 Feb 2019 11:09:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 11:09:07 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1KB95Lm003311
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 20 Feb 2019 03:09:05 -0800
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 06:09:05 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] staging: iio: ad7192: Fix ad7193 channel address
Date:   Wed, 20 Feb 2019 13:08:20 +0200
Message-ID: <20190220110820.25580-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(316002)(51416003)(106466001)(246002)(2351001)(107886003)(7696005)(426003)(48376002)(4326008)(478600001)(7636002)(72206003)(53416004)(126002)(50466002)(2616005)(36756003)(6916009)(336012)(86362001)(486006)(47776003)(50226002)(44832011)(8936002)(26005)(305945005)(8676002)(77096007)(5660300002)(1076003)(186003)(54906003)(356004)(6666004)(106002)(16586007)(2906002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3061;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0700cc2d-c6e3-4117-610f-08d69723d642
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR03MB3061;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3061:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3061;20:P9duPs6mXEAEl+OFmUjk1KNFombeu+sAjwVmBuDVQB1via/aJ/SH/RG0geyAmmOyuSWrB60DHJcgRRwhn3Zxmz5utEvyrp6lwtXtAaL1TWjCHKtSvNI5Kk+OxriVhm4e23viES66ObQm4zaAMezTj2gNIWOW5sh58a6FmvoUVaiaFrn9wXNAdGQ7pCZ6Qu+rHDQTowR0hcAh3aqDo1dkY/qK5K1Y5P+Yf0s4aEdr1ep2gR2USScyqACRU9enQluJnvXnJUl8HYFPpM98tLQ4b3h0zzl9ojvlQtwi+yzRiOBsPgsn87ndjkts8mdfTrqT2hDe6mEBdOmvRT/Y23edR6NHjo2hSOdMyiAJ3GMhKgJkpa+mGAynerk3802tBqDeBbdiBghgqTIENeRAVygmErYHQk/SPsIVOc5QxNSjEc1BlUpBaEXivEg+BDlehqyv1WzZP1Kx7e+rX3xmJHfkl+u8xLx1lKPNOUbfE4vnq2yXlGt7HOz3jA54nXanl8Gi
X-Microsoft-Antispam-PRVS: <CY4PR03MB3061C5139669E23335F37EED817D0@CY4PR03MB3061.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3061;23:d9c/hXwZmTyTtk5Gmode0fTEuxRjoy2JnPm7D6xCM?=
 =?us-ascii?Q?5sSiLh0EhPxrV7D7bhlUKghPHRmrr3bdZPK3GPri43RTthTxcfpxMQzp2kXX?=
 =?us-ascii?Q?6r9ULbjo9BlDHHfQHOYfIvEDXwQFHlr28JeCaFYsdS9h8bcEBa/Nu2oLofyo?=
 =?us-ascii?Q?JMk/IKGZ+ZjNeZefh6vru3PKgifPuaUV2BFGGokzTByqKeORpKGR/fjmSMCD?=
 =?us-ascii?Q?1eF+nAFtU8nXpj4l9WQLQ471UfOwIlgcCjsDnrQoo6Zn1/kqXyvqqrpEUM3C?=
 =?us-ascii?Q?T3Refrq2Hb2TDAyVD2LD3Y5/98BwgbwoVpl0+rfAAZLus7FS+xwFxsD+4G9k?=
 =?us-ascii?Q?OB1wuFSOEc/FTJcaB//Zf7tTnbx7MB/QzBl72q6BQ5rH4R5OlZxWNPcM/7/1?=
 =?us-ascii?Q?C0Xrbys4WwiPzht6QoYALjA79+auDvjJoYRTfL6ZsqYoos3V3yV+LmZ6ZGA1?=
 =?us-ascii?Q?bwJlWdPCrbL5Rfqj5L09MpVlKnIiRzA02eL/UPPlzMeMrwi19iGUsASWRbEP?=
 =?us-ascii?Q?jYL9cx6jo4/sFQ7JM14UYxH1j3DWk+OE/T0LnjD+i0EowlkyRmtiklI7p64m?=
 =?us-ascii?Q?/08H2W3T5M5hsAtEVglziTgoLD7AgjSX/nqF783JIOJBNFpqtHuYno5ehaGm?=
 =?us-ascii?Q?kM5tW65dp9XNXTszDja5mY6zvJ1fTMjSlUVIKhqMaiCy+aaj9XSWUat/xrhr?=
 =?us-ascii?Q?U2uw9wOXjAahvoOY+3ood+btKpNRNNQF9q6D7ABXRHj2rx0znxqD2upk8EnH?=
 =?us-ascii?Q?mXVdhQ6ZrLpb4AoJC8j7cK4KEUj9hd98jDri9YGbNbkl7s9jmluv7is+1Yql?=
 =?us-ascii?Q?yKcajjIVd4iP2npduM1JgId3aReevuXi6tXsnWCAMA6L5e/l4nTxvGlS0tNM?=
 =?us-ascii?Q?cRZevms6J4RDSd9CW8gIbd0a/FnSJZwnbHfOHuZ3XGu5WJOToaay/xV5k08J?=
 =?us-ascii?Q?HfjMA4PTIC8kXYOMMed4ncAKT9rMyxe8OrMM645WzwKdVJZKcgQ/vic2NjZo?=
 =?us-ascii?Q?k+gZI3pgExR+PXWu3n+dNXc+WYjFfbfPdIpnZE1yjSJU1EGVTJT11pTCag3s?=
 =?us-ascii?Q?5oLocw=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CySPnDnl/FFAyDbPKiuHI2KtkmjpEz9HeuN5WNnRC8LI//JRSFnGIkA39A8YBg0yGiDu8FwBQmNjUkMtOGqQPlDp3QeBedYMjpDCsT0olyyJoqopBby0qJDQld2I3/A5otOah9AfFdPmEql/RUOfRELrJ6WqM+adisjGATEyJu/LFu1M/wSuhmQXvHwYFM+O15VYD76JQM6OkAqCBC/0wph2PyjQXFcHbB7eXq7AKqRbbnko/zIvUt3sYp8t66FeIS6dgtOZHFtRZYtMsf9xPNiSHMJDwolydJJM+0HR5fxofoP2N8M/J71y8qTjDVgDD8gpvhR0nr3RhVcJ0fCmbbcLf9Xtd51LBR61zuS5o+Ap9Wuc09mL6IguIBXZV1T9hHUzRgkreCP1qTwg9sb+0NOzR0JWsNMbZAnayrzr9qk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 11:09:07.1669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0700cc2d-c6e3-4117-610f-08d69723d642
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the differential channels addresses for the ad7193.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..2fc8bc22b57b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -109,10 +109,10 @@
 #define AD7192_CH_AIN3		BIT(6) /* AIN3 - AINCOM */
 #define AD7192_CH_AIN4		BIT(7) /* AIN4 - AINCOM */
 
-#define AD7193_CH_AIN1P_AIN2M	0x000  /* AIN1(+) - AIN2(-) */
-#define AD7193_CH_AIN3P_AIN4M	0x001  /* AIN3(+) - AIN4(-) */
-#define AD7193_CH_AIN5P_AIN6M	0x002  /* AIN5(+) - AIN6(-) */
-#define AD7193_CH_AIN7P_AIN8M	0x004  /* AIN7(+) - AIN8(-) */
+#define AD7193_CH_AIN1P_AIN2M	0x001  /* AIN1(+) - AIN2(-) */
+#define AD7193_CH_AIN3P_AIN4M	0x002  /* AIN3(+) - AIN4(-) */
+#define AD7193_CH_AIN5P_AIN6M	0x004  /* AIN5(+) - AIN6(-) */
+#define AD7193_CH_AIN7P_AIN8M	0x008  /* AIN7(+) - AIN8(-) */
 #define AD7193_CH_TEMP		0x100 /* Temp senseor */
 #define AD7193_CH_AIN2P_AIN2M	0x200 /* AIN2(+) - AIN2(-) */
 #define AD7193_CH_AIN1		0x401 /* AIN1 - AINCOM */
-- 
2.17.1

