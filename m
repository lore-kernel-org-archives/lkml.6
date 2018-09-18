Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728612146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IlaUwmkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728612146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeIRTSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:18:53 -0400
Received: from mail-eopbgr730058.outbound.protection.outlook.com ([40.107.73.58]:43947
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbeIRTSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KWEJTDEwIwN0wfplW1MM3SPYNLjNTkk/hMb43parzY=;
 b=IlaUwmkj8/qHQNol3xyCqiQJWzBXf39Y8BqKpyzQoozrOoITpk0cYMZoYSfl0KzuG0oD6lAnkh4Zyzhdc2ZRTq6oguqSRcfqCVRzE43I5IHY2i8+uWA9NRCxEVKEA8Qqws2oQ83IFgmFUgY6wtJyJAFXQ/fmfXsNNeeC43s/Jg0=
Received: from BN6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:404:5f::22)
 by BYAPR02MB4472.namprd02.prod.outlook.com (2603:10b6:a03:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Tue, 18 Sep
 2018 13:46:08 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR02CA0036.outlook.office365.com
 (2603:10b6:404:5f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Tue, 18 Sep 2018 13:46:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 13:46:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45754 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKM-0002Aw-Rc; Tue, 18 Sep 2018 06:46:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKH-00022u-DR; Tue, 18 Sep 2018 06:46:01 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IDjup8005923;
        Tue, 18 Sep 2018 06:45:57 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2GKC-00022I-LJ; Tue, 18 Sep 2018 06:45:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BD6C712142C; Tue, 18 Sep 2018 19:15:55 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>, <olof@lixom.net>,
        <amit.kucheria@linaro.org>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/4] Add auto tuning support for ZynqMP SDHCI controller
Date:   Tue, 18 Sep 2018 19:15:35 +0530
Message-ID: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(16586007)(7416002)(36756003)(81156014)(81166006)(106466001)(63266004)(50466002)(48376002)(47776003)(6666003)(966005)(50226002)(8936002)(186003)(8676002)(90966002)(6636002)(2906002)(6306002)(51416003)(106002)(6266002)(44832011)(72206003)(26005)(36386004)(5660300001)(4326008)(103686004)(478600001)(42186006)(2201001)(217873002)(52956003)(316002)(305945005)(54906003)(2616005)(476003)(126002)(486006)(426003)(110136005)(356003)(336012)(921003)(107986001)(5001870100001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4472;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:m0yENfZBGPPo1JiVIxLAweP6ISX/6KD5Nueb5t5xQYmVZ4Gv5jnqW4LtH8WNrvnwc4ZuPt5ZMc1HLLtLlrMbbx7pJa7YAnwTHUr6jRbR8CmoDwIxbPTWMM8eMSEVhyqt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8ac4a16-d554-4db3-4592-08d61d6d1604
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4472;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;3:tXT6DJ1teyHse6p59LfHBbKBsEzCW5Br26y9U4r9ma7mlqjFmbTEjjupvvXT3MGvsoJSbCF87W/p3gOYgqADIqZJi18k3EgSVAYWTKVTTnJWbYHpmG2ANZyr6/NhRiyJKYNkNvF/msP2i31OmIeCl4I0wSSZEPq6ztJ51E1G0A+5t60igaxHHvdzq7Yx8yUAVInig0un71rrGW7lKrwLR+HgU/GVUilgyrLK/+P7NA4Tx3cJJ2Zgt+TGUxL98mh/zO50pyxmkbG7nVoFAED7GtbYUqjU792qyT7+BIlcb7F5RrLdxL5IrFnXGA5CBK1CfzgEXk9al7yEpUS9JFx5iimcgpX1FK+pFWaEUhS10fI=;25:t7bI66AGCaoQzj2pgdimHoUqgH/GfsJQTmazF2Dwq5EhRWL2Ao6ahvcPiFDwBmBflz8dklN/FTtr81fjF/wOJYtZu50tlH8gh2sfVGeWmhk1soa6UC7TZO1aaZPo4EpCMHk7mwfuIg84tbGnGALSR3BBoGfrADy9Bi8UIKkYXyZK0RiByT+Pz5BPoHLD/FViX0pX5rIIVCmROFGfs7PYx9tNx6YLay7wI+mo3XJ5xQ6yywEQjPKJN/FBchih7pzb1wEKvuDoN3sWJkIxlNA0edsVNEJ2QwTOMA4G8ds1IC8ULTdv/XRpnUnZiFd2EUPjTirrtvs7vbbfSCTa8sjY1A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4472:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;31:Up27m4CEwaoAK/et/Q2i2hE8F51trXNb1J5p5dc80D+rovkZf++CSj0E3ElHgZFhK3pkqrEff2HlMptzwRkjdlAjiJblfk9uX6r11bUuRtXrXa5LIFxFCoehBF763bFhODQbMFCcDLT+d0x5MvQd61ZiIR4J2J6a1fhYhc5PKBKLBlXmLqA3aR8N3JttVinR4ftUe2CKo71MPx1urTQpXT0iPauQUB7uXt632wL5naQ=;20:PHjq3binbeESw6IpdrsliWrdyWmxBaPyRqG4qM8dEavUdd8AnXPBlLTdY9aj5HS0sjoVA4hjIIDEYnmiliWSBxeUdiGsDp4yZgXuI1Muo6F7+141bLjS1uLBobgVc67KIOngKJx1x9zF5MQprPHjl7c/7SW5XQdRYMicurABXHpRF5gueKNiY+nh4rFL1lhcUa80HL1V3ULNCCG5TztRsBAmKrejAy5O2gpr4IDaOYHIznB3+A5VtlBdUDSlfWAhZJKBkWM9n0oFNP44HrWy/zy5YE3DlGDjQV8JqklL9x4G6NdbrRqQASVZijtQu3t7rY5ygNJud/JZhs6a35nHq0TJdhz8WSrDwNqKCFAh27X1wqfMATQ8W0wMuilPgXkPdcX5ZIWhXCuLIbYq1u6pk0b7wE7BwdVsIzkizH4kZJgVPjjG78NTx0HJuELXvA3mlqURdvC4FDcda0oDKKV3KQ16rPv0DmdB1XBPRH1KibLXHyRI08KkZxZ85RmBhEIq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4472AAA04A98B37EEF91B1ACC11D0@BYAPR02MB4472.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB4472;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4472;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;4:O+Q/cMNL+FWJxUv9DDaQTBwpVpyG5c6y2h2IyrSP36TNZDXsthP2v0EMnsmbR45rJhblEchmo5kRj9r/k7caM5ad6DpswGLAGPSOl6aYZBnykyGwJNIq/z0IaB6NSnrbEpdHJPk/rCmqUyLQpudv8qChz8yjip/vV5l8HqwWVm9wZiuW8cJBC8X3GkwbNn3cmaaV+Wvsxbz6dclK5xhAJfUNZCJminYnm+iaj0+BabZo0N0yfvP2HJ7E9/L7IE5qG7VBTgUpTQhhV2axhTm+1A==
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4472;23:RxLq365lY4TnWKn42S6+uTgZWjI6onZY8Gl1ZmgCr?=
 =?us-ascii?Q?nJwe41phHg4YbABMyOfL6k6cD4H+V69P0gLO+N0fvB5oIQGUWE+LJnzSGvwu?=
 =?us-ascii?Q?Vjb8O0modX1awifE/X/mrj0vOvp5m6UZPGkds51O70mBlH1EZRxPyQM/bf0o?=
 =?us-ascii?Q?i0zDU2RZdehR6zcKOiMgf84jXp5yWadHyDj0Okl+HcgHLjvQuCq7clsGfCRQ?=
 =?us-ascii?Q?g7Bj2rDogSAPSBL4TUt6yUFP7hBwb6Hh9G6zHwAAYoF7dZRDZFekVQn+PxxS?=
 =?us-ascii?Q?GG0rUz5mjGE9dYvRNc6s5eT7G2LEJLCxF4JLgPRa0ZjWpe6v5mA7l0r+SKQ/?=
 =?us-ascii?Q?5WIHuRGWmXu/XeKKNu4BiDoIN7YN7C/AcpY9LJY5AqXq/0p5/3XyGS8A7aop?=
 =?us-ascii?Q?UHw9STAnUsYS5rtOKcjvFGNomak8DxtJSozzRwlGKWuwG+oVdLa+IrVYaHxJ?=
 =?us-ascii?Q?hDDZKEcpyL2pGWjhZkjYiUp6SA5WtOnvUOG2pOSgD/lNW+vfGP8puI7X61QK?=
 =?us-ascii?Q?RLBcMRG8gB4odHFg1YVArNo1OPw2L8S5tCQ2pbJYHXOWKfGdpeq7/68WoJiD?=
 =?us-ascii?Q?V9jquc5j4mkys9wxUVhzoNhuoYvIO73YLz7uK8528OC5PnEShF0runWsox2m?=
 =?us-ascii?Q?Fabru35SWNtgFCNfCGyYkMCfE5NShtU3M8wzFZYnsn0+ZbVeBE+48Be4KOdF?=
 =?us-ascii?Q?rYcIp80+NZ7QXTEtZKz9y7r5bxHB0wt2RP/8HzQ/b7i01ZZIHO0pgvrAW5T8?=
 =?us-ascii?Q?BzOLwxV4wl2oP1S+YMOzMplUS/O401D4UdxGhKKFukRPABRCKSS2YtQzC3jd?=
 =?us-ascii?Q?V/T2D3cFwiuP+XhlRDfJKnFHohHozF4Qg2pxz9m2XO52OP3RWqCbgJ1J81zy?=
 =?us-ascii?Q?aIfw/RNBST1eRke/S9wX81XB9zO58AYEfGU6rAk3HAmYmHZg1e2doV11WCwv?=
 =?us-ascii?Q?AyhWbL9RPJun0YkX9byUBiben4gciFtIsycUVGkhq0yIA35Mxg1rg++tKBUY?=
 =?us-ascii?Q?iwEQ+TFuffVTZkDRbNCB5qEjb9/oMOvxtEJdAyo8XhGw9Hsk0W3mdgXy/HQh?=
 =?us-ascii?Q?gYInl1ZUmjnl1X8eSmDREpWy4Ty2pHsxVg2QYc3X6e7ZGWKmvhNfL9U+RxcM?=
 =?us-ascii?Q?ZqfmTr+KZdtvNX7B4Rd3IEKaDpqjHvJ87qXo5cy+jKY0rbNp0fYfPseKtTmP?=
 =?us-ascii?Q?yVxR5jfJKt31RGSW99h3ygaO7tekyEqSce7rdMLHxrUlTzAOE+roOKs3uMPZ?=
 =?us-ascii?Q?yNS7h6OL2pIexG7zFbJD1pDXk1goy0uz1dMPWCZ0OfedKwbCT0LaNUcPex68?=
 =?us-ascii?Q?zb0SPIhG96nQGaPYvoYrI6kMq92Q2ADnAT4npdB+t1X?=
X-Microsoft-Antispam-Message-Info: axMYyZOwKp4NioQJrZytcknQURj816Rn4ekVflSzhM6fV8cQ/XOzUpH1Uu9bsNyEw8Sw01XXhGjNG39VyzOWE2/7I44BGOhi51CP+mfduX2yxbSCeiWUStuGkikA3jMegLPZXcLxQYGa8480TEeitI6Ws+reSILNl6Tp1J5bFdI46m+czQ6VEeU00Uhaxj5qO8hWU7drYh9UBQU1i7VdxFbAa/LfjUcp/WHK6DN5Fo2qirNrMI8h3PpI8JpVZNWKpfBe4sRONVamrQPWuIhRbBlB1ucOzCIhK8EEI5V83OY+g9InnY50PsBIN8mHmgYX7R8p+7k6+ZdCQaZLkGpw4IAsOEQJZd//v9B2MshxFho=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;6:Ojq7ZBxaNxtmoQVkNxisjtlp3XGfY2gF3OWIT9bbuo3YjkOP5UIG1Ik8nkHtLFbCvmDo8k+R1jef+Zg/lOXYQX3pjhJ+lzw8BfrGyvfpWprqZ4TVu36DJ4h93Hv7p+v4yMUXxGecvN/oUFvglFzCp82Rg1256a+HZ14ZnHdVgVfbyCYXe7B+O17glk+VcV5BY2mWPu7SaxKfdYS2nzBkCPb9yvbuszLgFc1J0fuLjJfOvnZDEMhmYVoN5FMGCTKu7OxkirmLyXELbJzugy/9eYSYBbqKiKFNkRzz8LdRwH5dQlDaPU44k3ag4bhHY75rWrj7/zd2G2N9ObwdaorfpVJhKJwQDwNM8TbodHLdt72XrJrlfP4kPReV2+azerjpvk3PgKTjGlKx3QWH8+q5iKyxottsMH425VlpOdGxwml9q8/5Qnmuv38zOo96yCuDwvEO+pDvCcw8AleWxlJjLw==;5:40mz7TK6A5VxCnIntZAgKnvKwgNF8fau4ybjxp1JrQquJDNRK2mnxWC/C5FTUMcpN0Y9WEXXTEoVy9+e2TykQH0pPFh1d86Cl+vBarMH79bQMXkm4cmon4B6MU4zUHLQgBHniP4M19lkx+AlRrm8RE66et27D8s167FXnXSpOeU=;7:7QqQqQtU8685i4yaEUCdpkSoYmpWbXiI7bcOJsJOWZZNf/fHSgfiQtpt9ZNbYTA3HmnDpzksc23loPGysYtag6Xd5pyqUKisJCRZ/jEp0GDrtlhxuhOEjaOnp+P42/jfnQYMDuFr4tpPSECnyAm0MbOdLOageT9koF52sj+uLZlcgxz3TgczLvDiRP+MBxPx4BhaIjU0FIvnsnV6ahMYXam9VZjuHfwqA+14IKbe2umPOcmGaFV0BxQQatRiDX7j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:46:07.2679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac4a16-d554-4db3-4592-08d61d6d1604
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Manish Narani (4):
  firmware: xilinx: Add SD Node and DLL Reset Data APIs
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add auto tuning support for ZynqMP platform
  arm64: zynqmp: Add new SDHCI compatible string

 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 14 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  6 +-
 drivers/mmc/host/sdhci-of-arasan.c                 | 83 ++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 12 ++++
 4 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.1.1

