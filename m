Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9ACC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF98623F69
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VVAANjjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF98623F69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeF1HkE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:40:04 -0400
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com ([104.47.33.75]:13440
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933094AbeF1HkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D874GMDayWfT1uP+jDbn/NLmI3HhhstzdAjIQb4tujA=;
 b=VVAANjjc2bDCitY1anJ5v5ETrx2ajy2MNZ5tS4ok2FECQK/jgA/CpVxeiTVGxjVu1kX1Isyb3y8IEnozmd/weJeewRWJzFAc3uKpgT2TTuzw8mwaqLFplTTZKHFk0uVoPwcoSgmybluA4fLN3U2YMKpRvvmfwzHGUi4GVPDWbQk=
Received: from MWHPR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:301:74::37) by CY1PR02MB2154.namprd02.prod.outlook.com
 (2a01:111:e400:c5ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.24; Thu, 28 Jun
 2018 07:39:58 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MWHPR0201CA0024.outlook.office365.com
 (2603:10b6:301:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Thu, 28 Jun 2018 07:39:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:39:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRX3-0003eH-Ow; Thu, 28 Jun 2018 00:39:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRWy-000195-Lr; Thu, 28 Jun 2018 00:39:52 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7dl0o022790;
        Thu, 28 Jun 2018 00:39:47 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYRWt-000189-Cg; Thu, 28 Jun 2018 00:39:47 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 8CDDFB20951; Thu, 28 Jun 2018 13:09:46 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] net: emaclite: Simplify if-else statements
Date:   Thu, 28 Jun 2018 13:09:41 +0530
Message-ID: <1530171584-20673-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(8936002)(305945005)(90966002)(4326008)(81156014)(81166006)(8676002)(50226002)(106466001)(5660300001)(63266004)(76176011)(356003)(51416003)(478600001)(6266002)(103686004)(36386004)(316002)(48376002)(446003)(110136005)(54906003)(16586007)(106002)(2906002)(42186006)(426003)(6666003)(52956003)(50466002)(2201001)(36756003)(26005)(47776003)(14444005)(486006)(336012)(2616005)(11346002)(126002)(186003)(476003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2154;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT003;1:/qLkgG59wa11MJO+NUfVzZsbwhebRDXRtb4BGuF0ToEbDFKf0bZ9o88N3wFczZP0z6r4G8oEPQHt4P0zSdZQ4IFS6UFw/UYdn4s8rH3dL3hBDUSKzWOSIHcg70+TwOh8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29c820c8-2787-475c-c0eb-08d5dcca595d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY1PR02MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;3:Ot7XKlHolEWy8i1bavx/EflyyV+SeFGpyE71nugjwNKR8ugRuyr2nVd1IzXuHqrw2Tpjb0gpAp2qEpOUH2PU9xIAeQzy3TlkT7S3XqBtwaC7gmlbw+kXQCploV2lqmnbYPYqvq4ozWSTaTuR/b2/KAnVWTOSuAqOMcjtf1wP6BLt7f+kcVMOK2G1iTmVQZc4s7WKIi0w3casJeiNhROILBZoqB76XygmT6aU7CHyMoMMATGYnp6QZpt2CeGLpwlwCb+qlEX7i4sI4941twQoj5Zma1o3f4PkRexxG1HI+o2EZtkJjaBhOR+L0d3RzqYv9fOc5LqXKzStofnE+XOkoS7xSuPrjEhI2d3EzEKieDk=;25:feWS1/yMV6oifKpb4pgZ8Zo/Cgsjq3Bw9VPSY6UyI/8+9ekLcDY9CRAoZgdAXw2++Ca5RCAdNip0GxL6Lo7W1WEyimhuBQVrfLYQbAEc+OUtiKGzflYlcfvFZ/NOhrityiCF+5WtRuO0/RM7YBIHCseJQsu8iNWtR7ioAQS4s9aKbgq+k3UW3vODp0tagKk04GE1fp7J4F6NHYhcG1SeFY6a7ZUDk6XQqmSF9QhRySjrjcb7Z8fWIo0AREPFP0yfolvdUOmTS3ZmSZYb06HG+4ynpkO/7z18ZY0LUdB6JTz6FU4vTvubtOmgBWzLorWR/E9U+p96TJkL8fKZ4pyvRw==
X-MS-TrafficTypeDiagnostic: CY1PR02MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;31:uCzgBkJ/nbSTTv/cBj6VCumOmaunWNUpEVvPXEdjCfJOBT/9AoY+U0Pr5c7ZAzw7H2z7bn/sqeBaQ8YDERUKOCAEofig1CIK7q5RnbLZZW6zCQJ9CZdq32MBptvVJqn0oGHt0R4d0MbXwJeyeDS53FXOdsyFYsPk76gY+1pInfEJlbS6knblEFZhEsANJKWPnM+jJP9bBIhJ59Ri24k7G9YFb7+HqQCAN2PVEfuHBiE=;20:xoTdPY5JzfnCfYoby/XDbFmn0EfCIid8z9UhwKwWpyFEvGYOhsUPD5abFF4iI6ekDWOvfnNW9dadS9Y3OWm6vwlIB6/WMADZwqMnmV1PGm5JVsdwaZWCqjH0525yZrQdhYObQQZmKRGWaMpWgdHeveM6UZfqD8nCIv0T97F89cu2rO1HIJA0kYFZJeAUSAkPFzmzlNp8OdWj9C/oFL0/3ejFVIIrgUCou8x4aQ/znF8OlyTRZxCgizvAd1qlqQNhVhn8mu98FovPDFJ6KF3qYjRjYnF+ZmMCJ/0MRZuFRSfAWKq9ccb7XDYu3Qi8SPLxPDLa+moJfYlGo9LIFz29pwx61DruBQ44doLqBdEXikl22gb9PUkQGf8W74zQSdJ7BehJ1KSA1FvARq89JrnCMXLexV8EPtdmiqLS7fUPywrHc4Z/UIRMtq5htwkHQ5D9pnQvEIZTnn2X7EdaCgAVdeSgHBFLjxisa9Um/WK72pB8T/FnnZZNNdcDJy3qMZEW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB2154A064C98341BADC28F477C74F0@CY1PR02MB2154.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;4:sm1ZzbE9SQNHlQi9povtGG5THszWhT9nChrNUkDXbJjSLlhhd0D0zJRPvSmViZrZKoXjDxs0XlaxtKWXZiyg2IVh/A9SrxiFSSdWZiQaTbJ7iNouT3LmM4LTSp65Bx+i5K+BRwli1ylsOfmGoIoK8kUx5LwhzUB+73I6aGHYkDmoQK1IuXR7Nk/2vCx+fIzrSsEuPSkRJTY0LHuRfRaqhvPMPFiZv9Jdnf/cWlAq/9ABKBO7pWFINhirC1K5SRp2LwJt0kds9kLQhqG5mI0NqPklKRhl5uFqreiYD53xo77SSqSiwgdNfrnj5wjHK9Ep
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB2154;23:FSQHomUd5n5npcM/1vv8MWJMa3bZKazcTH66wZ5Wf?=
 =?us-ascii?Q?zyGTSBxYkwmUraEsSPwJBFIeBstsyxFaOCfYciaC5AUP+5hU8+5+F+cwjWii?=
 =?us-ascii?Q?/nRFRsKP6LaBFxaZEtnsbtlxfWt+2y048ysPN3O5Jb0SK/d/7MGVjjoK33zb?=
 =?us-ascii?Q?0keiv3YbQWAacMfr2+nexEte0pbqobPHzacJXeHVwh2GcvBgqbXF7qjUIG9e?=
 =?us-ascii?Q?QAI97Bla7yab+Sb3f4WwaDJGEBrPeMeYXk3lSssW8njX+JwK0Kex8pd3577V?=
 =?us-ascii?Q?wm23L8rKk+eU+L/7p5UKhNNCtSEFv2tniz2uSbVdIvQrtes7VsLcAcQhWmh1?=
 =?us-ascii?Q?AYMStv/og7pH5UbrVlOf1IpSaRV/xgjPlVVn3I3ma/gVrkXn59B/jsB27d3o?=
 =?us-ascii?Q?ppU67vHH1X0MKgm3zyfrJOiybCTmU9e9vUk1sBHpcebTsh51h4jqvEC5la4a?=
 =?us-ascii?Q?ht9W3F0Q57w1l4oYMxyLLK0CgkW4Jf9bnqPxf9r/iP8reEOlX2SG9RmDBRvA?=
 =?us-ascii?Q?5eimPQ4qbsKASxuAz1FjQv1kpFi5vsFrv30zlqtzDGFd1IgYPXrFQ0mDcc+Y?=
 =?us-ascii?Q?OAY/BXa9BOOgyNlgYDuwOEn1qu1yymdSaJTkZaTrm1xlhzQBHEjtH5v5WWrj?=
 =?us-ascii?Q?YV5Z3vmwtsfgdeQHJ1u2zPtRKLHSQkqi+YV6xa/fq/6Tvs8qPhnC6ibG4Qhb?=
 =?us-ascii?Q?wDbOIozwUsLTRSP3PjXc8HUIEmTxEGvJtnXEOuxykdcufGPtnJpFR0opqAJR?=
 =?us-ascii?Q?KNnSJAvovi8iW2800r87hzsmt5A3fGd3q9+NcBVe5ZC3e6zJvD0aWKygxdpc?=
 =?us-ascii?Q?hrcbQa2WlGwfiumEpA9G3tMVfG7+c07uwpWM1We94Hq/ySltxxA01fNnYzFY?=
 =?us-ascii?Q?PydRmc/GMa7LFqchdC2z9txm/eEAB1vHEQnTyImLAQSZkwsue/qz/02s/i3M?=
 =?us-ascii?Q?ydoRxZbGjNQq6BQTMnLAumbhG5cDFOmgOSa8PmU8txk6iRQlo0OrZQIJ/vfp?=
 =?us-ascii?Q?OGhs8hIoD+Yk0GM9LcQTjR5X+zs9rm6Raln9bCXHWctMc5dw2SPLRJucPGID?=
 =?us-ascii?Q?frjtvEfGFMGHj3Rt+KcD6JI01WFPUGQ4vxRVtvR0INHUjWxqpKqLoaN7P1Mh?=
 =?us-ascii?Q?QQhkBF8z3ECpS3m4rMI//gwn7MTsA8PeYBbDU/j6mHdNUv5ga99nA=3D=3D?=
X-Microsoft-Antispam-Message-Info: qeRhDR/grVwBMWEckWDRnlCQNrY6u8fP1MJoXcnY4kyp0b9Urk8GEovzGkNtOo83fMb5Jc40jDST3xsg3PzBCar5z+tPKiWr8/5cT81kuhsYA93dlbRx/ukB3hPnakmqf3YJIVajZr8y1R+GUZCOzhcaeF9pPoacdY0a4KDace6xsQrEQbRBOuomfAYkgJu265VAtj4Ld1bgnH2LrIm5RfKb7XRo2EAwwszb58Ezw0fE6dnyJQ2mwH2oNHgrN55n7lp96JYD5cvauvndoCprblzA3fN3LpVZJqFa1odWuad2kRGMsJZVwdMyBe5irFd/JPVuLY/elGlVaNDioOjYN5MC+2SA3iWtBq/vwchCjFo=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;6:zeXYRJNdIuaOM9VrXyO/pCsWVeLaG+vOkQIp73DRUNYWeuy7A0OFh1MAd02Jwo8SYM/I/xaI2SEvdcaSkn8A71AHS2lSguhLvHbqIYCdXmF5geyLOTVthCo5qmlzhx4AzC1P+KHQuapXfp1kTEw5azaerVmjctMboVWl9LcDbGLiar8bTRU8ut+d09Hv/sFvDqnfkEGOFIwyrdK7sr6NK7UNOjAV8uKFuJrgiwdz0aBFKvevLwCJaXGg/bIEMmPD+bYumKTcj/P3lJkJgH3w1VTJ/dXRrs6fcfZh9XqYhGUsGZOKe6j0tRBcYOfvIh2DywetJO21lxhuA6KQmLT7TXVwtdFfCZXqdbvHQpvMPtZ9W12+d3D/kuvN1xv/cat4+k2MksfnIfpinNvxvPhig9TLNuZ2hJX1IoCR8n1dYPcDSPTSqJkkHoqkNRKYnDs246HYQyDLvE6i2FmJD0SyYg==;5:3btekSGtT7km08LwDWuBSCaVXTS/6RBKrJBF3Usd9DePduG9lpbCor28K2HgxARXlgC6BLNE2NEUoJF8AKnNZXUSVAWFglUBltX5BXU/EXUp/XbSmr03wZ7hdbrMzdYPuS6xga8FkV7JIoD5jpAxu3Z9mKu5CtYU6oGmAebLs2A=;24:mwINQGRtLXBiwhhKqQKsmZznz9a+rBruiQn9HEI00cvp6NE16Eo+VPO3m6L0TYEH3IEOwmxsgeZIDPkQuKJgrnJiZCVaugVXIldAKfWlCrs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2154;7:l+DWFUy6Y+ghe/imMPHADpfPea7L21KqpDZM1UNYKM9fHqZWV/McHixyqpjmM+KykuFYXzdVj7vUP/hDbVMbKXx+sxofsrFEQgqs5CQLSfWwg4bfPIFqPWhTdlBRX/I1eXFTsbEsTUKWWgd4yMQ06ajCxD83ePNFr2L2ivmhu0eR84qX2+ER6w7HjXompLwqBU6Z1v4ACfkmQQAgwgp1e/zYuAysgL2OaTCKwmaqLqmzfdhrkGLqU5H7BtjJIKXY
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:39:58.1114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c820c8-2787-475c-c0eb-08d5dcca595d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove else as it is not required with if doing a return.
Fixes below checkpatch warning.

WARNING: else is not generally useful after a break or return

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes from v1:
	- Refactor to make failure path return early as suggested
	  by Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   31 ++++++++++++-------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0544134..51f84f0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -564,19 +564,18 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	struct net_local *lp = netdev_priv(dev);
 
 	dev->stats.tx_packets++;
-	if (lp->deferred_skb) {
-		if (xemaclite_send_data(lp,
-					(u8 *) lp->deferred_skb->data,
-					lp->deferred_skb->len) != 0)
-			return;
-		else {
-			dev->stats.tx_bytes += lp->deferred_skb->len;
-			dev_kfree_skb_irq(lp->deferred_skb);
-			lp->deferred_skb = NULL;
-			netif_trans_update(dev); /* prevent tx timeout */
-			netif_wake_queue(dev);
-		}
-	}
+	if (!lp->deferred_skb)
+		return;
+
+	if (xemaclite_send_data(lp, (u8 *) lp->deferred_skb->data,
+				lp->deferred_skb->len))
+		return;
+
+	dev->stats.tx_bytes += lp->deferred_skb->len;
+	dev_kfree_skb_irq(lp->deferred_skb);
+	lp->deferred_skb = NULL;
+	netif_trans_update(dev); /* prevent tx timeout */
+	netif_wake_queue(dev);
 }
 
 /**
@@ -1052,13 +1051,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 {
 	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
 
-	if (p) {
-		return (bool)*p;
-	} else {
+	if (!p) {
 		dev_warn(&ofdev->dev, "Parameter %s not found,"
 			"defaulting to false\n", s);
 		return false;
 	}
+
+	return (bool)*p;
 }
 
 static const struct net_device_ops xemaclite_netdev_ops;
-- 
1.7.1

