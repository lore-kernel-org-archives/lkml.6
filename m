Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3162087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JnnUqQJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfA2UjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:39:03 -0500
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:64760
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfA2UjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rRCt/Fp2LLqjvnno6HZDN4J5l5gTptrmTa7RJuTUAg=;
 b=JnnUqQJtGELUwhFmxmS63KTDI4k3x6apZcZJ6CZ2llilZG1zFJIP0iNpUWrPv0RbCm9kR9cX5NJkgYX6TPdcVLCGvKIphyv9FBn7Le+F0/5B7Nim2LV5IebHf1QONQdXia708enS6uLYAqp7T68BZG6rY2ocgvw78//CP1I2DI0=
Received: from BN6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:404:5f::34)
 by BN6PR02MB2641.namprd02.prod.outlook.com (2603:10b6:404:57::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Tue, 29 Jan
 2019 20:38:54 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR02CA0048.outlook.office365.com
 (2603:10b6:404:5f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Tue, 29 Jan 2019 20:38:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 20:38:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9l-0007iq-47; Tue, 29 Jan 2019 12:38:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9g-0007aV-0S; Tue, 29 Jan 2019 12:38:48 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TKcaWK008060;
        Tue, 29 Jan 2019 12:38:36 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1goa9U-0007YY-Kh; Tue, 29 Jan 2019 12:38:36 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Date:   Tue, 29 Jan 2019 12:38:21 -0800
Message-ID: <1548794301-30483-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(396003)(346002)(2980300002)(189003)(199004)(4326008)(7416002)(356004)(6666004)(54906003)(106002)(16586007)(110136005)(316002)(39060400002)(76176011)(51416003)(2616005)(426003)(486006)(8936002)(81166006)(77096007)(14444005)(476003)(7696005)(2906002)(186003)(11346002)(446003)(336012)(81156014)(126002)(8676002)(305945005)(26005)(36386004)(107886003)(63266004)(106466001)(50226002)(478600001)(44832011)(36756003)(2201001)(50466002)(47776003)(48376002)(72206003)(9786002)(921003)(107986001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2641;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:KkTLsWd84p66RDItUqqnwBz3Q3NL221wnVGB8aoMnXKqyZiUB62cieZ/wJ9YrMytmOvtvPLgcR5ifC9elNBN9CU0lZAjNrEo6/d47jiIImcQVlssF/gYOSi7P/bCc7OUoKYPSzjhbMS3tM5mzCrYbLPfe4nFV0IcITvhn0ce5qg=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a74f6ddf-8c1a-4ae0-cf2f-08d68629c8dd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN6PR02MB2641;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2641;3:5bE999v5Fua2o/zE6jVZsf3qG068YQpg0MY4zvZiqETIt2S0DUGfmX8ctxZ6jaL+MIHMSTBxwlsU6kcEKOxR8CN7ScZZ3Ioao31S52psppMJls8bim+6sv6eHbyZjd61cSLLbpc3AbCg7qpBXQRQFZxb0iz8o688o9MUriAa12YDKen/rZcboGtzHaoi09/ud2rp5nki4vfOWyrxYE5UBwBtBVryQatIKCngeu6UJ/7DB0qN/3AlHcPJmvTi4Dr1AdVq0CIDlxyYtfgwCJSGT6Au+V9np/AMzSpfO/4ltZK4kVNN3yHwU/ssRCmQSIbdY1++CjSF2ibIBVcyYqT8GoTM8xQVx75BFHr8OzouBDsJJhKHRYYlvMOLNgE24LG9;25:J79yoQy7JIkQMrA+UadX/xqrnt4pWRYJFZj5LMyeYrrfEVRUtfYt0/FnASwqocDmqZS/TILbRUPGnOWgCeiERYbF8Me0zZNLBC3X+Si/nD4+8hY1auoblNnHW4iXoIEL9D8v0FscrGsd2u1dLqbnj4CKHVOPkC2gdE0EoXDOXgaH/t9/h15BrBFDmpMSVGiMc95weTR4uuiW/WVJrFumGPuWijZXS7svNX4T4w7OBOd0geeI86zs/v+M3X4qdeL9wD/FPdOdOP623Lx8mG85OaO4K5h3VpRa6Ub3CnsLOvLcqiAB7Xia7FVIjCkoWs37a+35+Swctjdm+/E9TX06mA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2641:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2641;31:96yCPUtz/j+z79bBoKVHGM4r8XYSTt4+Fs5lwHPm51Tf1DcTyIPLByyyts9Sj/8u1lODXJUjcIihZ+XMfzo5m8tshXci/mZgTd5vdtNbj3Z0G5ztcNLKJ1HMpki+dNGB/UQEFR2EHTY+CgQUvoJ+ulG9zBgHD3FaFjcPx4aAMTmuBRcNxuK12GxpwC/CtIYA/kA8iC5n5eJgieNygf+z3AME88hAQ6+qV7AWfH/JvvM=;20:ucmTrgiK9GPjdOhPC+TR8B5ChAnic3+uMGSJ/DwyJxoT9HXBu/2zzhYzMFTVm0qlkGRb3iHyEZwgQstGlNofaXefnFS1+f9iL+d6dBcMh2joHrI1ccwtMblQ2K81+y6ecKz6Y+h3Yu2FGVnQPC1uPM6SGwoXhDp/6HbpKuEFcqUYZ0orV/CH2I9LJMpdTBGfFrZ0IXgckcMHLCwlOyKetdHqI8a4qzgHnYBhyWwkZWZvuLrmX2tIgAVpb0Wk0wB2OzCGTgO6fcfogRFrQH91nolH4jHIfNtvQDwoQ/nbcrmkosZo8iEba4Q4D5PBrg/PpIZlZAGSKFazM7tyNfmbFYIuJbx4jYPsP2C2PMMbmoY2YiPZ/I+NzgoQ+JNXZJddFf08+1dlVZKSsTM3idgyFB73i+PAPYu51VyYVUPKmIIx+iNTKGgEXvVwhM84wD9A3IXqiP69KrqbAb+ylz8u9kjn9IZLh5n4tXKupcpCPXjfLBrpJvEOj6jSETIQ7pDU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB264125D5BA91F6BFDC93A267B8970@BN6PR02MB2641.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2641;4:EYDlqCXpIFEWJcXsKqK0GHu4JhBQuX+uH5PT7LjCk5tpAgRUJf2CwgbwCC60+9nKbngsL1vKtTdgsp8bs3SOOjOHhdBysBTWVTf4QML7q+WOoyhPTrCJ1IYi8pMEARHQ/lWxR0fi6ON7epQyO9qIQSGiKZo7JBq4JuHhDvq9WK+qj+vb6niEHocjx22UDlbirCwQGCYP7K5YxuyhHcWK8trci9n6nWhaqoRafxUsI5DVVaE+4pTJC8zvLXWFxbGl9jiOR8hOigtgVjCTgyzzAOTZ0en7XewayYdeUFeVldNouZt8mQeNO3XLEKH2dN5c
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2641;23:j2zyJJohW1+FhkYWQA1ZjTbwaF8T+nM3pvHR5kUze?=
 =?us-ascii?Q?EyblVhq5DK96v2vwHJ8+JCJpUo+TIXSDq65YB9ypHVCp4eoeBJBcaNx38sgH?=
 =?us-ascii?Q?jL0RJOdUPU9TrdU7oyJ/EsFFdar5SJHu/aoC5I2XzLCPssnYJuec+8CcU+ll?=
 =?us-ascii?Q?3V0dYki4zOrWpTyJ7QzcuSBF35MUt1GVykoXVUPuBydVl3Qa/NXcDGPEeA1k?=
 =?us-ascii?Q?ZRIqeh8m9xlmQnzQnbC1f3oQdJWX0/6cpcngFqpByrv71hGphBqTSehpMBvc?=
 =?us-ascii?Q?8XpHeRAHCp6UrBCgqsYW6BfvigkBVyarkKHfHehCan1/wf539XvRmSfXcazN?=
 =?us-ascii?Q?yYJW3dfMf1xJpaLkPQ12/Y57FePVcS4W+sJ8i4SjwEVR+tqiQfmTlCZyBs3p?=
 =?us-ascii?Q?F1GeMqjQkHmSpyQ+KDs750ccEuSwzu1zFMNyKj+bsLekboI0MwYL0MFvLSPt?=
 =?us-ascii?Q?vV8JybNSrHkgx3uNe0HhgHliYS+Z8hihFnjUrdKec8Z+/XesK02nwcLzpal5?=
 =?us-ascii?Q?kFFV6uopTMbt6PjhgV4hdqAOkGzVhFKPrxrcK2m/6yeZrVddXTKsJqAdYgnS?=
 =?us-ascii?Q?LI1yESnaHv8ZvRIO2jU1NWfhMAcUoVHvMuyA3lJA77zZk4joagTkkjV64w5D?=
 =?us-ascii?Q?SZyBqW1wBkI6LVpjwH9zOmgT38OAofQHtwBFCrg7tQeMKiDj9bOutzbxE7EG?=
 =?us-ascii?Q?Pdn4Wb5+7QR6767NioKPEt2jXKle7qnTBJPeROl8A/Ba4CVc+3IVHQ3W9pat?=
 =?us-ascii?Q?e7rG3GKumE+uqPQGku3adbxFL4a24Nm5ijFmrh0O5MLhACf+sdK5+0XOO+XD?=
 =?us-ascii?Q?QppvO17S3Nm+VLEFrvVBU/CRT4WITNBL/bu0Jz5+7XspKe0Poeq5FhJMuPGa?=
 =?us-ascii?Q?rN8XhghbBxzUHijMKayGjc730U7cIoeov/AVijrWq2a2lrt/aXIA57VUqL0O?=
 =?us-ascii?Q?aGOPexYXmsFcTaGTi71Nf27JhNrbiN/Oeb6npaFJdmiwyStX6+L/Hq9TBFog?=
 =?us-ascii?Q?+Vrezm9l69c0PnY3qtAum2vI782wR1G5nJACXzzs2l5TNsYM6mryC4wCeOCy?=
 =?us-ascii?Q?NTplUDvlPRpKE8/h1mv1/XitFlqMKCsjz7ZC6Twgl/nCXhCaQHY1vlb3ukF2?=
 =?us-ascii?Q?7nkqa4CC/4vj8iD1Jt3ffb54DOABmcTJrmEre7tnocA+te8hsS8cltofn0yf?=
 =?us-ascii?Q?FylV4t5msL+V6tMmdXhZ/uvhnVbDLphmTryeTH9sJgk1gCMiiq6yteuvTaQu?=
 =?us-ascii?Q?MJSVcyB8e444sNdSWti9ieHcfCpMThu+eDVK7VC?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bz3zmq7fg0HEQy9UG/GDyLYSkF0T+5/8NndDE93/SHH0x1X+CXHbO8r+xkgfukmaPQ5m9j0mZBLnT4NJ3ZBxWbB94uLoHYxAtzYhmmvUvtTPSnvuQsDyURApYEectV8CBUV+Dqb3q7er9368vZKrhjKEDaVFAv6/+OjxcT4A9KHsyw8x0v9KO6g3H5Hi+9aS5loNauV6aAGybFDiI10l9sqXptiZOtdiOhGBk4dlvpyczGSq9l/gafZhQpmljIWRZX7grmHp/N8LVhbiphzHG8CIspr0nRUkrfoIUkHcGkRZrMr1wqXJIESuwv8j16L9h0s1Ltqqd0ZL1I3wQp6ZOpabBQ9jmFuVd4yeLxz+JIj596C5NBjM9IiORzEb0XHzTltSg2ANZcIcg30pauelf9ov/wyZxZt54HQlqonM5zk=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2641;6:gySsulw7fQ6uZ4cfQXGEpi461+lsK2su/DZFbI6QJG4nafD/AoqGysNIZErKmzlQRWNFuopBsOFZpqT8YY4Q8dFdBfKLsosNeVMZHrOKvwD3KvyqPzCVfBYH1HLFVqHGyf30c7PqpW2Fp8GEcBTsVyl0tOvX4JjoxeS/bxDyH0KtbAJGJmFoUvLWV3tL1/AUi6HGfIA1Cd9hb6KVTJdp9BJsoMnzoCGCHITFGb3aA4Odg2WIMUtcgWHEozG2YwyiWzi7KwcwAaULkKkuS56w7BmTWO0MztkMiObS+y0O1G0wSs5W51gRIzktqcya4VUNAERLbLqomeHk0+m7jwLIvxW3FeLCDXAesXc3wZwAFtb7d9w05IGqTyy9KNpAi2wcYSUgfTbG+4hjIwkGf64YHoTuYvQOM3zzegB0sBSLsJcxh0IokbaePNiboyP9oqXcK7P6HgOI/V07tomxb8sLCQ==;5:/oPHUtpuHc2wuE4o4wbqUqze/M3zZqiD4sqw8z73oZGK5hT5jcowc15jnbSfIoyLlJLWDuPQ5mjYlhmRDkzHfWZzmxigJ8G5Ifrlm62J0cWwlNzbh63syaihzgVo/LRWwtY7/HS3v1guZAXTT5oQV2kvlN+Xd9XXWtFuPWNRkQgzCHJZVv2NbNMEMQlxtHQftDoewwF/hdiT1J7nHCVM3Q==;7:EEmDtb5vFmsu4jOXbr96APcZtgITyrMYgnEoTZWAFIgcFeFPFDucKAR6PzVGNaUTv4R6xBi9/BO8QjT+RUW60g8EAEFLJvOeG0reARHwgQeuFf9XvFL7i7PmG4CI7MlYtt4RT6tmD8HxPZBFR1y4Og==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 20:38:53.6010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74f6ddf-8c1a-4ae0-cf2f-08d68629c8dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig        |  11 +++
 drivers/soc/xilinx/Makefile       |   1 +
 drivers/soc/xilinx/zynqmp_power.c | 178 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..5025e0e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,15 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM && ARCH_ZYNQMP
+	default y
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers isr to handle
+	  power management callbacks from firmware.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..428b9db 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
new file mode 100644
index 0000000..771cb59
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void zynqmp_pm_get_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t zynqmp_pm_isr(int irq, void *data)
+{
+	u32 payload[CB_PAYLOAD_SIZE];
+
+	zynqmp_pm_get_callback_data(payload);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		switch (payload[1]) {
+		case SUSPEND_SYSTEM_SHUTDOWN:
+			orderly_poweroff(true);
+			break;
+		case SUSPEND_POWER_REQUEST:
+			pm_suspend(PM_SUSPEND_MEM);
+			break;
+		default:
+			pr_err("%s Unsupported InitSuspendCb reason "
+				"code %d\n", __func__, payload[1]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret, irq;
+	u32 pm_api_version;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	eemi_ops->init_finalize();
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version < ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, zynqmp_pm_isr,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
+					dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
+			"with %d\n", irq, ret);
+		return ret;
+	}
+
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to create sysfs interface\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int zynqmp_pm_remove(struct platform_device *pdev)
+{
+	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+
+	return 0;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.remove = zynqmp_pm_remove,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+module_platform_driver(zynqmp_pm_platform_driver);
-- 
2.7.4

