Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B2C61CF0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243B121476
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Zl1TcSLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243B121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeIMAp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:45:26 -0400
Received: from mail-eopbgr710057.outbound.protection.outlook.com ([40.107.71.57]:2275
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728173AbeIMApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHCYTuTsJ3Ql9+paE9tylv3rS0TTs7oWAWwvM7PxIrk=;
 b=Zl1TcSLgmzToazcjCHwIimj21hmdMhcUKAKx269+3xJd3P6xOcCzbuy1UYUT+iRLPb2AFoHnB9F8VlW4Oz7JxgBTDjbdx2ym6D5LJPKddPevlwJWVDaju282d6tZGeCQ/qKIVOqnfndbs+6TQNH3yb3w65XuXEtNR3hQ4FiF8Bw=
Received: from BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15)
 by BYAPR02MB4760.namprd02.prod.outlook.com (2603:10b6:a03:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Wed, 12 Sep
 2018 19:39:16 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0038.outlook.office365.com
 (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36154 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0007VP-NY; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-K7; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcwA7003383;
        Wed, 12 Sep 2018 12:38:58 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-KQ; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 2/6] firmware: xilinx: Add Zynqmp firmware driver
Date:   Wed, 12 Sep 2018 12:38:36 -0700
Message-ID: <1536781120-22794-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(438002)(199004)(189003)(5660300001)(110136005)(54906003)(336012)(426003)(106002)(26005)(77096007)(186003)(48376002)(9786002)(50466002)(36756003)(8676002)(50226002)(356003)(2906002)(305945005)(44832011)(2616005)(126002)(476003)(81166006)(446003)(16586007)(316002)(11346002)(575784001)(486006)(36386004)(106466001)(8936002)(63266004)(81156014)(14444005)(6666003)(76176011)(51416003)(478600001)(7696005)(72206003)(47776003)(107886003)(2201001)(4326008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4760;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT049;1:p42Bm+iD0F+sFdFFsPAdSbnoaY0CJmNTnDX/3O5s1Hr+Na0TkP/FOmXB13r9bX510kcccrZyuOaS6HkNsT3xfU5Ysnqy7CRkAvg/pkoOcnHJhVmxJGL4Yw0fVozzesiM
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee7c6c4-089e-487a-6989-08d618e76c65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;3:brUOfjG30lNgBZq19KGXqNGWuL0i8ReEkTwbxY9g5ERW+VAJa1lhD51+bS9T2+U4Ji4i492mLzrNrSZzQ2Bn317I1ky56eBEdVZB52e8W4NLrzVHoc9KAoLvlF26rl26eCF7rmExYECECyp1I92sbpIFwaNlIzrZDlbsxKcL0+HCtynVWX2/68FcpjXhNCgWELGR8NFdqknDW/br/KojT3vyyNHcqK7kDRsF6e8Mh38tViHXmm+46Kc0sd+DhDZ2rE3o+NTlqluU2WPT85SefP3EMWOEupTP8DzkaSbHaE2rvZPH7Vfr2XID4mryTir+MSaQ3O4aeSP3BdXRfxiCCaWfWDYHpeC7NlcpBWgh5/g=;25:9/rCSeIky404/q3A5SwfSYBtNRSkfUTcbrvV8FLkw6cofcngoxDeuxAp+DPrm9FSOPZnqyLodHfYnk7/vOSyegZOocNT01k/gsouI2y4aRdOQlLig39niLAIHkQL6miHy9pHNXX3DeXHtGLOjkQ51JyQwYSEC2awnKKGpaXSq3w+rCLN2k+aaAidUO7BjcLvTtkvraSEVQVSvMgSzvEnkUa79nlaCGrv4c+mUKxZj920ZXwMzjeFx4/hB7pARxBikOBEUt4mZGYCTD5XBDhBFuJv/EIeqa8FBbn2c5XLmKB8DEp8gZkyCYNgButNeJV70dcFx/e3jRcHIwsJ8TCvCQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4760:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;31:JhZHhLAhVzf5sg35OYDol1LzysQ2Twfqbr+/llGZq4Pi+3UEt8rOOzsLxyPpUbd2w3tQWXb0epyaMYX/FvHRzaYCnbDAJRgxISD+6/xjmmdIzX30R+LW4sMsjmchVGQpI2LcQNqGqQ+llRMwdTcHx3FFuY6cqOQE4ZxvGDQhnfLP3a+kiovqjOaOWWhuQTKvgygJ53MTIb/dEBCD80s+sQFHngYD37NTUStQVVaYogs=;20:ti9igT/FDalemzXVJR7//pxQDkjVUVazeXbQJHcCue13QJ76yFqexqFsbkMOeBdOwTwB9mRxfRWvDnUywN1hqMOw8gj1GEGlA7RUw2L5SdcM6OOW7OVh0cHez9ix6vdqdgnkTqg4JpsNR+lydx1PR89VN21VqsuyvCjUtBJVLClPsXV4eXAd/Amqz7OnUP7baer2nEeIm2G6mpjOVeWYv2/bQYTKRhZ5QOecjJC15gRdyd3YaXgRR7hh2xundFfHE12j8sftMtb2bbeIbYuv5I1cFKRp/jfl3ygFtULclHLmSpTkBewynH706vgXJf5BWzj1+zkNcXXssSv7/xM+22WsT4ZaswvrUyuWd1v+TKe1sddx8C3LYMJBLeRLo3MomKX/QqkF9ju2UkqqW/K90kA+y8G7OCNpfCxv9iJ+4AaCMrkDZcJZ60qSZrW5bU4wFba5S0xHllbG0fLDGiXBrf8rrEyDstxMqrgCq9mRk2g/zESae6GTtA9NFftnS8cN
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB476043E7944A71B83A048C18B81B0@BYAPR02MB4760.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB4760;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;4:yRCibrVjtOZt474bGEyZY2xbeBO9zi35rPEOv9zo0p7s0ks/dIY3Pf25MCogU0j6AsBq/VOEY5ktxWMbi/ZITmMBnl96hNBLmUC6B61gbpn1xSO7nSwDqt10OZNnmQvAL4aUyhBxJG+pfs5BEf9tAPWcm4HGMr/m0zKsCV3Q4YO+btPOlvwBZZLLoGHwmf7Jh/ofYwPiU4GYAx9rZfUawg7/BuBVX7pIcQVasxAd4Z8n4nKMTGR5VhYzGMs+bwU7JDpWnzZeeS7nZ2AHQmLONZQ/Wmls0abTjrkOy8gUjM1RoL1NOkLOibcMfa5TCwwV
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4760;23:x/Cc6o3dG9NrvPgna+NHnwZWzm5EK3leztNtTYu8+?=
 =?us-ascii?Q?OZbb+jCIncEkGfej/D2YF5nkh4FzcuhLF2HsYD6kbOm4L2i3Q2+440ih5V/r?=
 =?us-ascii?Q?MFeZi7kcuBuNFwWhBKR+5ptvxcdAGOjHcusFvwytksjbBVoP6FJgIuz4JPqT?=
 =?us-ascii?Q?k8IH/gyTdwUN7OL/yY13uCM437Hnb7RSukNgGetbCl2Bj09r+ynQ8qeMrIkd?=
 =?us-ascii?Q?sAq2Kzpwo10xk65PZMB83vzsYN00Olyo5TD79Je1TQijehVg4yKXpLG5NVUC?=
 =?us-ascii?Q?JwG2cLrPqIDAO0WcVZXjeCvlgfWmYsZNlTb481NQ1pZfRiZTIvw61JE9F/8g?=
 =?us-ascii?Q?E0Z3luFzG7P+CqGT1mxlRYCNrHq+sP5U43Is9LuKul7/r/ThV9CnuR9QNkLb?=
 =?us-ascii?Q?20HCvmW//sCsfP9n8pi67Wt15zuK7/SMMkgqJth+zvd4SnInquRdyuzAWRV5?=
 =?us-ascii?Q?1U8tGE3MvbG41z1TGHE663EQS9gAXJMiS2HkOC6sLRs/AYnrMGz6AMNWbz70?=
 =?us-ascii?Q?/VP+CoIuKI5k0eRbU+D93ofnbIRUBLC2uJ0dWlI/WbwoE0UNgibO6vtENiuK?=
 =?us-ascii?Q?cL8Lr9czy6q1yEvywBrnwpgFeA0xKLBuA9CgVq9QmC6mVDCCQaFBipfniQ5K?=
 =?us-ascii?Q?6PijZ6Jyq5trG3gVkjBdZbjXylEtSAglHaHjYkE6W6mdO4K5wvNUl0xUdSRo?=
 =?us-ascii?Q?ONZg86y7C5WS1uD/ltVSRgRvGoWtjKJsa/MUbBbMJ+DK5ZM2NX468al4SP9g?=
 =?us-ascii?Q?RwqAMjUPfvg6L4ilDbo+bjQvXAk8ga93/nmSGTcgI9Bg8v6hAO5QgihBksnh?=
 =?us-ascii?Q?t9gq54Rb5kqTVg2u9dimZTg15LaXwGUmP2BiiJrUAhXjsnZwlasLxtc55b9T?=
 =?us-ascii?Q?qfrijtC3nM6o7ygbyQy8HVO0JwIf+7CMmUvm3yF0i8sT37L/r6t+aym/WH/V?=
 =?us-ascii?Q?QMCTM/sXt5WBQakN8OVqKDzFa5jEOy2EeOAF50aefrciH8Xv/AzH8vYtZsgj?=
 =?us-ascii?Q?pDC19g34sRLJssjRSS4vYw+Xg3hoLdMA0mwI1OwjmEEp0fk+Lm1LnrQ/TdSx?=
 =?us-ascii?Q?jOCXkG38fdxI7J+UBcWwLbVU8dsl45O360aNT1xKIaPqkfX/JsDCMKORpLdy?=
 =?us-ascii?Q?4a3JBkHknxKb/Q443x1hBugq96L0rpf0VDAx3vsOSoWYzAKa3aXmRKOpK5eu?=
 =?us-ascii?Q?T2/FvrJPdNak9irpYunRmsTZN8oEA7X0dOT7Kb8bv2N8emUxwmX43iY4aj2Q?=
 =?us-ascii?Q?XpZevVMGjZVIEPpzno=3D?=
X-Microsoft-Antispam-Message-Info: IhHzWiod9YmQZModwWabGsfE79f17Kni+YzP2NggY23GYb8JUt0SIHMWKpvDcg22l6h2j+8fEB+gabD2t4sM6mE7t9P8f6oDbwDO/1o9mPXBLbP2wPdiAZg0xHzW6Kv1O8j7Lyyb9D6vsoUz0vKqNHooovUOhlrteEnpCbZGE8s6zPKd0WHETjzq6xAdd7Ku0XLobc4JXe6ykBL/vlK2Aze2CvMkcwqKu6oucJWF7hqO545sNQrjogwAkiimrBFCJwfA50Zx1P/48TIBBAotTRnhm0URk0yfY8bO86jxfiPG6lqX9W+HydQn3xQUB4ZX0WcShead89S2oNxnZid2z0pM/Xp87c0/9U54xlWXBbQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;6:nH5jUXwev/aKAut3k+3BbSZVeOvN7k7iCHidOBnu0AQQ3cmjz4eLvtnuA6eqMq522bRMtNjEqy+5RtwW15fDP5mb71VEuzrAFR8zrkNvxneF763xqdkfOuJzP34BTj9b5BIq+wdF/qBIJTA6tejPp25prJ9HdvWbGBoKUnJwAGFRPmn1bIxCqKmYuzMe8jIm89+jP/stvBkU2c5MlP+ynsEHNNqksf7/71dvCQElbQoJao69gk2+gPj8FrhTlss46xdNKD6u1NDdzsqoD8NBhko+5DIs+btGYqtFOUidbb+ebf5qPWaJGGQeTvWs6oL3kVhhhC+k4bLzHk1sO/PNTqX3TWxgi+6cPYBqU3ldLQTpDGbI34WeFCkKaWgR5aXODkE+VVrEJK4RnpguaZzoe3lnzNo3gqB0LRmRjfn9qBihpspCACmPMp9gA+abKEkW4Q0kMtMsWFO1Coy6m8O6gQ==;5:Q0/mIfEw79nflphLzxLkre4gwNzcARg4CS4c0/ag5nMtmpQfMQbRNROzkyFeMo8o0GyOIDhau8/g7rBcQXVQNtA8ce6uB8LpeZsnYNZRd4HdFYhf12JTMWZ/xBq1dRKUR2iIe6/xMwgRy21cvcgEqozd3Fzktz58a4gRM3ogc6k=;7:WBQDDsO6XWiX0oATYoQBIph9rKfgtIbKwZwngxKKQjjYDNTxurWpRlv/+1kduqFebRTWJdrYwH3r0kNbeqY0D+pTV2w6L6KnwsEZqqx96cgaKwrE1efX7h9qMk0EGnWWHlvL4KthEU6eIR+H9eFHY+WWGZNlkcehVYoYOPFkIBfIFBm2d5WWG6u7hjuFb3SzRjIlyArxfkN9yNgSIHOe+TV8jMBV+qcpnoJ4NKqjV5PpEc16SVithuAd3J1TxjKx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:15.0851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee7c6c4-089e-487a-6989-08d618e76c65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 322 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 408 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..64d976e
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different
+	  drivers to communicate with the firmware for
+	  various platform management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  If in doubt, say N.
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..5bf64ac
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: Pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	ret = get_set_conduit_method(dev->of_node);
+	if (ret)
+		return ret;
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static int zynqmp_firmware_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
+
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+	.remove = zynqmp_firmware_remove,
+};
+module_platform_driver(zynqmp_firmware_driver);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

