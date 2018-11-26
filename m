Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F860C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE320664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P1KZuxjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CE320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeKZSBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:01:39 -0500
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:37920
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbeKZSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLCAZHHPXnCfDkSJGZC0OsOE5Xm59cro7yzJtFBNgb4=;
 b=P1KZuxjx/IvejYK2chcpRSJxq/Zx4i0Lb43hMg6s8DfmhJ3foOSzRcbLAMe6rHqSTFChUl1jgXmNr7QISTvhW/wdAqbreARLK0Lm4lPpf5EcEphGkZI4fUllsb+2XIvLy7LHA9UNZkbiv18YIojqyWBQ5tDesF0TnWU5RPoEt9c=
Received: from MWHPR02CA0010.namprd02.prod.outlook.com (2603:10b6:300:4b::20)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:57::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.19; Mon, 26 Nov
 2018 07:08:25 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR02CA0010.outlook.office365.com
 (2603:10b6:300:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.19 via Frontend
 Transport; Mon, 26 Nov 2018 07:08:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Mon, 26 Nov 2018 07:08:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB0K-0005rJ-DY; Sun, 25 Nov 2018 23:08:24 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB0F-0007Iz-BS; Sun, 25 Nov 2018 23:08:19 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAQ789v4026430;
        Sun, 25 Nov 2018 23:08:09 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB05-000758-8G; Sun, 25 Nov 2018 23:08:09 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 3/4] net: macb: Add pm runtime support
Date:   Mon, 26 Nov 2018 12:37:51 +0530
Message-ID: <1543216072-9623-4-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(48376002)(50466002)(478600001)(47776003)(63266004)(51416003)(7696005)(9786002)(186003)(77096007)(26005)(76176011)(2201001)(5024004)(14444005)(4326008)(107886003)(39060400002)(106002)(5660300001)(16586007)(316002)(2906002)(36386004)(44832011)(356004)(6666004)(446003)(426003)(486006)(305945005)(11346002)(2616005)(476003)(126002)(54906003)(81156014)(81166006)(50226002)(8936002)(336012)(106466001)(8676002)(110136005)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4454;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT011;1:5AGp9QkoUqk2Sbcy4Xh9tkI0RtXaBPJHT0Cp6EFJqkIkaJbBx8qGb3TBO0WywLq0qJIs5Msn4T0DeRjy3S1WM8/xq9MampAK5YTjmXldOyHJnftqR4PcxmMeS7lfTEM2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e60f50-2cac-400d-0a97-08d6536df54b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;3:WkImjEjfGanspR0r40xDZnH+zqlY7qEBlLgJBcWZbwWmTz+yHWk5fuAOAJmAYPobtDtgdRq/avoeAwu2W0pbq9ABV2dYbcEFMBeXKFpXCSkxcjnmrKNV8/3FMOweJJOjKqz40LKmMNYLUfF5JYalEwI6b6Lf9WDS8fIUCvPZUmZLnMn+44iE5OPyrAtcgI3FhUEvtJIa4Cmbw7cn22bz+0z87hDaQVu2x+YCnxiisv8nifmuTtPxYkQH7sgIL8CiUlKdBQieerl20TRjT4fosNLbBJx0pebYLf0lcnoUCW1Rm0TAAyjBwDIgA/UZ93Lx9/T9F+C9t+4jtotO7erIIlbtDmzs9T1fEvdoHo5O88E=;25:p0TwMgxuKCOGvyrLPFVOT4BduJBzbE0saNLelnQOtxHSGg5vgBqolMWkJCiUNOYAvLyA2rge1tAxoKewHIFfveb608ymvkkK4hamtcrAkKf0qb91UiK4w78t+1K9x+OZJAYonJCU2qfv3SbV1Gy8jj8uUM8nMy9JE+w7ZXjtJJKyvX2e093n9l5gAw/KWxQp/oR1Fv+Q15p7ex7fhviYNqPDpoaOgzu1QBM0CIVfyhW02rucjerQZHBCQxn6ivhzvoG0Lqm5p5n49yfUNqyODODtpxK+vnQvzU7IZVpBDvsBgvjruB10r+oamqwU+gqSNl/mK5m+myhQ66zgDweq6Q==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;31:cvzoYyMntn6gBpREQSM0/b9oBV+6/zy+X+WnNACMRj1KZjZyonm8oYAJ2gzW5xLdUu/lFGLOsUkPqG3jqk+0Qvj6/DN6w0ZNkK/3agEF8CUvTVRpRhRirJojSf779/q2nH6LK/o4F5tJ4YRf/j3RW/zFaJxNNK27b2PZzhinirXlJlPoMiWH89hsr7nCTZbBanXJ4D4F/myEw78N6QTaJFNcePOKoT0Osmy6jGjO5Bk=;20:qjaHxfLQ7h8kpMNM/QLmHKFqPvo4wMKEAZiRj9usKPqW+tAIGB4GPrJdbUw/3fo1CR9dLU5JMFWh/pdQgWZo5FcdaSbTe5bHflgr8V9bhtfhv9p8flQ/Wf/BGfkXG40mZkNh18MHyPzGpF/XSgSUS1uSB02ZwjTqTGuQasw5QOEuDv9lUnEfGwPZ18Vin5GG7NlcJ7ltyPewWDfMz0gSuJL8UIWymTB7GK+KQyeNDHtoPsCko59kMcD6KLs8mSszVBua6WKM5eDOT3iblYHwjMTfswGVAEk1rZrr1C1jIu0b9Unn9RhktO65NxOf8/y9J04OsW9PYVIrSlj0eOrF0W8xO5lD2MOfB7SgBtk+fFTv7uvz6GnNZbix05+g2gNq6OZXgigQJVvkf6eZlB8lI1vZR84iUKqqgHTvpXcYfqL7NZDR17cbCgwDQK4VZa312zaaV1lx1btq8p5T28ZdVRpNV7O0g4n1rgpWhfhZAUJwYAHp6NDIm1cP6UCIGwmt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44545A222FB8464343DCCFE8C9D70@BYAPR02MB4454.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4454;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;4:WBUcIv952Unul2limS1mwdM0ImYTF2kq/xc/6VuOeOoUEXVjRT/R0ilXpDVmixZ4dtE2reuFCoinpSj3lX9ylvKowfkRPbhfggGj3xFxz6/vDbcF7LT+d7b0MYI1Fi2Z4oUW7nVpbiPe8GiKZmDByH9WDBMrKKiPoa+QVJ6YLco8SplYM0ffsGZU1o+CA2/XZ1hsoRPR+0gK5W4NWU4/0ZegA8HFWOH/ASeyJz0bD6pHolTcy7wG1miXdK/Ls6vtECgts2EaRvE+JiFjHX68KA==
X-Forefront-PRVS: 086831DFB4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4454;23:bwz0EP6k6SvnX3+Exyl+mvkperbIYlCg/2gD5w4GL?=
 =?us-ascii?Q?w+6IMi6ByPX7HSVPU6yq6RF62vMozfgF2PbQuO416CeHDxIgOV7ByZWclZLe?=
 =?us-ascii?Q?GM4+lTkhhxG2syf/2IOktT4runWvRwtt7vVKaG7rApwW60Eil5hQ8U7St4M2?=
 =?us-ascii?Q?UDHyZq2XdClEJ5NvIH8GbqmzlF7vyvLTpbJG4XpA45KYq7GoEcWIFkyha5dy?=
 =?us-ascii?Q?NUA2HxtOrFYAw38b0z9nxOtVzLgc37MMYhJn82etNz38gzH7teUZ/YKGNkiT?=
 =?us-ascii?Q?WelKq0bZ8TWIFZ/4q//KVzsFB7D/izprlju14gankvQrek3odREShaFyoB2T?=
 =?us-ascii?Q?H74PsXFUZTNKMulLanHSgZOwZYj8EUD1iKCt92yGQ8HojQZ1myJSZkCO41A8?=
 =?us-ascii?Q?Sf+3YGgif7tFxQMn8/dfn/rMhXGWLsRLYtBfKqWnwvos0qDEXqvEFBUeWtTf?=
 =?us-ascii?Q?l10jhpUr9kloj5IXkjsFI1CICF5TbuNoLia/tDyxjHRq1nND4vgwazdVnuUC?=
 =?us-ascii?Q?XXsC9FuGNk3mZOrYJOSDL2UXx8mlqBXjYrpJ8nROWP38G2Rastpno8WxcMX5?=
 =?us-ascii?Q?XRYzCngJ71hzUDlYCWSlz+CDlQTt1AXdaTFN0OWP/g57DBbOHzmlkTdraMjk?=
 =?us-ascii?Q?LvDXely7gi2GKJiqr1Mo45E0RiKMIfaeiiaqK2NsB9XGQb7wrnwdyqnMs+ZG?=
 =?us-ascii?Q?tbGnO7fdF12QvA912BeM5z3eGNPdC5FxZNloQbmhyxlNYsw5jWJV4L0mlYzY?=
 =?us-ascii?Q?NyYoIu5CUoZ/ET2pXHdIckHjoAFKb1A6AICgXQGW1aoeYMI3i34mPj8vw6kF?=
 =?us-ascii?Q?Po7XA8uer9j1CioG3s/zwdcajS9MMe9L5U9Vvkcd3HeX8YZc03n0/zVIdp++?=
 =?us-ascii?Q?uYW1AcMNoGsN8TswlHFrCN9Tyx9T8NAMBIu4lAIIDawziKTNs8u5e9UHZJUP?=
 =?us-ascii?Q?qJH5DUpcEwKOeFnaDlRFQ3q8Ttm/YJSL/dkO2H5EcUjrrqR8bM5K2ZOoB83F?=
 =?us-ascii?Q?xNPzwfapOtlnnQ/QD5kN85s+mqgk65CiLSADz5exZxduisGzAwkfed7H2/ee?=
 =?us-ascii?Q?3EymsI784PyvcdKcFjFctgaSoCIk6/M2R85dTMQhpuQVu6lcu7Zu3rbh9aX+?=
 =?us-ascii?Q?nH8DWFwMzhmkeuR5rIdq2K5KyBpAwE4GIM8GB4g5AD9ErxGhAfYy5CAVR82j?=
 =?us-ascii?Q?XN3Lu4qHau75RfmcIc9QEDECGSuWpRJvI12?=
X-Microsoft-Antispam-Message-Info: AthmzYjqx2aK4Z07oi/YIjEPkyqItcnO4IRyE7sxWDfnEHbBdXqnzmVEipfe2Cg2Z2FbKIN6QgMy2bjI7qQbtR6/DiAW0VVbEYoO6Zn1/osHOGmqztsKJIEPhb7gwtftAqCTZ7InmuaRfH7ySMv0eWxPTfXVRcGE11GcII7GpMNPCCYGMth/B3sprGgQp8j9Ms1QLSgyTPS8ZErCwMLh7aDbBrY4qDlH/YF3MfrENaasoeeg5AKZDbMvQQXG96nU26LC/EtVFghd6+f+d3nith0BCBVsK+Q4aZ3gRW7XgUe2rTwbw2o9pMRDu+zjmh+9mPEVb3qUao9vLGF/hRVW2MX7+/ic8ZIX9xrZC+SxswE=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;6:TgzWHDiBpHeGXatcX7mMaRR/UasB6rXTDLzjdOW8un55PnfqDQuuSunSzUzzWQsV8hGYWoNuEWCUzlAd0IkoIyilZbVqTFM8KyCnWwElhfU5r0Pr7OZ8kxb5O5Jbek7lmR4wV6f3Hmio1I8B6/uSTY6S+GhAyoq6brvfREs9bIICnztCQT84b3Dyfd7aNgl4Vs9FE3crMP85yvkAV6zqosHZJpm6r3Lbuzc/56h9uy68C6RghocKS0PsBS8yCYnZ9YVj2tc0Lmtw1XJWA9DxHV2+I9aBM7P65TcwLh3CT1hfoR6ACGwrB5KWHsqVSwmqGAvjnQDTQTioX/lAxTfVHTGz5ijyaQt2JOUlgKwYdz5PPNzT1hJeyT5l+X352AkGtecMKyWuPCnk6jPnyWJxs8VR4DwuU16hjpAAMW1c8J3+Bt05XIJv9CBGFNpo8oagDcIye1Dm0mNfdb3eduHh8w==;5:3eiyRC9gqerIjE+XfJfgcUOL1C8VyLdGlxny9RrTLV9SO5iQBsHHTrwgCRseBy3bmlIgzBAITQOO/XyIM5MRlrHglEd0QYiE1KSgec2Me1YPepKlpDYfkB1jQ1luUbRBf0CzieSjbt7KnUHagigGUOz72b2Ta9F3t2Kd6ARASC0=;7:Vzsk2/oPgzu8JS2J7bV/es+in/b+Ke6Vs3/of0Pcgaxw/g/SzlSdqhj0ntrdwkijtA7EG8bwlcR9mSJ3VuHsbF5da2Fvo2Ti/BcApSnoj179P7toR2tPdYNYAHH1Zfog7WmbUYexvpiV4haAS1iAIA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2018 07:08:24.7786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e60f50-2cac-400d-0a97-08d6536df54b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

Add runtime pm functions and move clock handling there.
Add runtime PM calls to mdio functions to allow for active mdio bus.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
v2 changes:
Allow for mdio bus to be active

Changes from RFC:
Updated pm get sync/put sync calls.
Removed unecessary clk up in mdio helpers.

 drivers/net/ethernet/cadence/macb_main.c | 121 ++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 32453d4..4b85ad7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -37,6 +37,7 @@
 #include <linux/udp.h>
 #include <linux/tcp.h>
 #include <linux/iopoll.h>
+#include <linux/pm_runtime.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -80,6 +81,8 @@
  */
 #define MACB_HALT_TIMEOUT	1230
 
+#define MACB_PM_TIMEOUT  100 /* ms */
+
 #define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
 
 /* DMA buffer descriptor might be different size
@@ -335,6 +338,10 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	int value;
 	int err;
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		return err;
+
 	err = macb_mdio_wait_for_idle(bp);
 	if (err < 0)
 		return err;
@@ -346,11 +353,17 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 			      | MACB_BF(CODE, MACB_MAN_CODE)));
 
 	err = macb_mdio_wait_for_idle(bp);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_mark_last_busy(&bp->pdev->dev);
+		pm_runtime_put_autosuspend(&bp->pdev->dev);
 		return err;
+	}
 
 	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+
 	return value;
 }
 
@@ -360,10 +373,17 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	struct macb *bp = bus->priv;
 	int err;
 
-	err = macb_mdio_wait_for_idle(bp);
+	err = pm_runtime_get_sync(&bp->pdev->dev);
 	if (err < 0)
 		return err;
 
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0) {
+		pm_runtime_mark_last_busy(&bp->pdev->dev);
+		pm_runtime_put_autosuspend(&bp->pdev->dev);
+		return err;
+	}
+
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_WRITE)
 			      | MACB_BF(PHYA, mii_id)
@@ -375,6 +395,9 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	if (err < 0)
 		return err;
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+
 	return 0;
 }
 
@@ -2386,12 +2409,18 @@ static int macb_open(struct net_device *dev)
 
 	netdev_dbg(bp->dev, "open\n");
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		goto pm_exit;
+
 	/* carrier starts down */
 	netif_carrier_off(dev);
 
 	/* if the phy is not yet register, retry later*/
-	if (!dev->phydev)
-		return -EAGAIN;
+	if (!dev->phydev) {
+		err = -EAGAIN;
+		goto pm_exit;
+	}
 
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
@@ -2400,7 +2429,7 @@ static int macb_open(struct net_device *dev)
 	if (err) {
 		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
-		return err;
+		goto pm_exit;
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
@@ -2417,6 +2446,11 @@ static int macb_open(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_init(dev);
 
+pm_exit:
+	if (err) {
+		pm_runtime_put_sync(&bp->pdev->dev);
+		return err;
+	}
 	return 0;
 }
 
@@ -2445,6 +2479,8 @@ static int macb_close(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(dev);
 
+	pm_runtime_put(&bp->pdev->dev);
+
 	return 0;
 }
 
@@ -4008,6 +4044,11 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, MACB_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	native_io = hw_is_native_io(mem);
 
 	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
@@ -4139,6 +4180,9 @@ static int macb_probe(struct platform_device *pdev)
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    dev->base_addr, dev->irq, dev->dev_addr);
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+
 	return 0;
 
 err_out_unregister_mdio:
@@ -4158,6 +4202,9 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
 	clk_disable_unprepare(tsu_clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return err;
 }
@@ -4181,11 +4228,16 @@ static int macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
-		clk_disable_unprepare(bp->tsu_clk);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		if (!pm_runtime_suspended(&pdev->dev)) {
+			clk_disable_unprepare(bp->tx_clk);
+			clk_disable_unprepare(bp->hclk);
+			clk_disable_unprepare(bp->pclk);
+			clk_disable_unprepare(bp->rx_clk);
+			clk_disable_unprepare(bp->tsu_clk);
+			pm_runtime_set_suspended(&pdev->dev);
+		}
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4205,13 +4257,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
-	} else {
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
 	}
-	clk_disable_unprepare(bp->tsu_clk);
+
+	pm_runtime_force_suspend(dev);
 
 	return 0;
 }
@@ -4221,11 +4269,43 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 
+	pm_runtime_force_resume(dev);
+
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
-	} else {
+	}
+
+	netif_device_attach(netdev);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
+		clk_disable_unprepare(bp->tx_clk);
+		clk_disable_unprepare(bp->hclk);
+		clk_disable_unprepare(bp->pclk);
+		clk_disable_unprepare(bp->rx_clk);
+	}
+	clk_disable_unprepare(bp->tsu_clk);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
 		clk_prepare_enable(bp->pclk);
 		clk_prepare_enable(bp->hclk);
 		clk_prepare_enable(bp->tx_clk);
@@ -4233,12 +4313,13 @@ static int __maybe_unused macb_resume(struct device *dev)
 	}
 	clk_prepare_enable(bp->tsu_clk);
 
-	netif_device_attach(netdev);
-
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(macb_pm_ops, macb_suspend, macb_resume);
+static const struct dev_pm_ops macb_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
+	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
+};
 
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
-- 
2.7.4

