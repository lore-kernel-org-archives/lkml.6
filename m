Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD2C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ED320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bMkr6JiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37ED320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeFTRm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:29 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754722AbeFTRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XedcTPD808pHUpIO3MrfgUDaIqwgzyn7xAyBqGwkJNY=;
 b=bMkr6JiSrVbkotT289J/0l0DyH/gmVO5zYw5EwvB9DJux//ny2FnvQH2BgLSAtgSqLSoOgdNqU+Iel8Nbml/gl1i/ogZzitFFutQ0UmMEALwvGPCEm3z6JcUACJdWTmLtM/ktIq6GNSTg82es+CVnqcEaYefblzbWc3+rVMj3mw=
Received: from MWHPR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:301:74::39) by BY2PR02MB2151.namprd02.prod.outlook.com
 (2a01:111:e400:c506::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Wed, 20 Jun
 2018 17:40:58 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR0201CA0026.outlook.office365.com
 (2603:10b6:301:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0002P9-G7; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-Ca; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHeg4u002474;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh61-0004hY-Uh; Wed, 20 Jun 2018 10:40:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v9 05/10] firmware: xilinx: Add clock APIs
Date:   Wed, 20 Jun 2018 10:40:30 -0700
Message-ID: <1529516435-7315-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(7416002)(36756003)(7696005)(81166006)(81156014)(77096007)(8676002)(16586007)(486006)(54906003)(76176011)(476003)(26005)(110136005)(126002)(48376002)(316002)(50466002)(2616005)(2201001)(5660300001)(36386004)(4326008)(39060400002)(107886003)(44832011)(106466001)(186003)(478600001)(2906002)(9786002)(106002)(11346002)(63266004)(51416003)(446003)(426003)(305945005)(59450400001)(336012)(47776003)(72206003)(50226002)(8936002)(6666003)(356003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2151;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT022;1:7VMfX173QROX/RmTBxtpDQHIVEQ/z/R70NW2zYaVy5v4dOTMcI37qn9UQVfuOtaJWbwt6dC5oYl79empTfi7zdVZeLBMAz8hHO8+5rYgykZPFGkmdeyKJXxwCBYnVYog
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d8dbb8-6f37-4bd2-830d-08d5d6d4fb5b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB2151;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;3:8GnFjGpoSXTU/f+jd0KY+bwjRY8ExEcF3H4jL8jP0+g83ha2rjHHv7BXgyt4eC6leKgG7dlcTEg0iapyAALXPqV9v++04Jbi7zy98QKnGdHOnG0qtiHAMyX8fzyurt6OwF/YvZMPaKq/Chw+7FbnN6dQENO7zLV+fRIbRq7JQT6hTp7+qjt6SMdq8acVcYX16jfQeBf7eoy8LyuE831cUsufMU126ojEFbgvnGAGdafz08Z6p4pMTdR8P8m+zoXf2yx8TDl6agiWoXuo8aNAOd3pZt5f0p5BRuho2U1wtCutM6HImqZeNKMMxotgZRYHmAad965sg9iN36TyH9CUt+dD8lBIJQxOvO0tG7cWQRY=;25:NgUhWAbHxv0N/rvesEy0CvjQ62h/tYEJ04P8X2LFZRkTVV8ZIJNjilil+L7QCe9biNLKD5fnj0OebjIkjxnRUuRkatHIixVuvKBcJyqu/XY0pcCiOw8MTc6dhKCz1UjemCD4xmD0RfLXBP28nQai66vus/MbMnJk/5uH55Yrl8n2xUhbksnHMwNwHK5mNPZk9VAmooKYZnqoBs1d0vOSPSpseKQG3BMD0+Qzj4rn03Mo6GtZFp6vrgDLWEEoYjs0nRnoV4ZpdZvq32/pn9jiAJVMqjUtKAm1Yk9tMx86F1EGRR8pi6BisBDZ5G6hSm2AJX2eDiC7EO1oSwn3Wm6Zsg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2151:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;31:rcUiOZUc5tvzo1y/R6TE6bjbN025aHkVsp1saPJE80/cL/TpaEZ+cHbbzuYpDmIL4UVlsPpqOYo8IYZXxpOfBFcLOk0T61D2nEVL8HJbyWAPnJPI6UNfniye6+GG960OHVyZhqI7534TIp2tfY8MX3rWGzRgNa1w/jHViF7dS6Q+ayqJZs3Hq11/YTVKs2bXn9gxVAvPs1vuct6nN/aiMiPkK1F9g045oETW54NCrS8=;20:0g0nPLbVuyhk3R6NHcbKPLE8Lh8fZwA12dqwKnmFbkDzhhDlq8FFYizuU7S7FsNTCnP+hgBFYFaGTP7+nRm25Uq4OOEVSgQyo0qlY5mUdLQTzBroY/mStw+bWuUhX/Kg54UnFC4a1hPkZTqiik+5Z3/AZfbpNz4TwtFs/NrGL/48DO0FtOiMUqTFZCHBJOGGy+IgD2sOlUhPXwNge3lTm2o5BoLfN6BINDGlKhfPo3DBMfp9yrSK5XxnajIaOYjapa5SdXeTzAJeTScU8HPuLGgM7YsMBqcJuK+ybig0K2BcirnQ+YKLXkOD1JigY3+MicY+SFNTv6vLECHXOokWTCM0oPY4Z0D4kedMPuOe27dqjuI3z2WGAk8pAykO1+52+9h0NetAfoGJ7Gv9J/U0VtW5cWXz1JmRU8QpQnJjqroaq/gWQBFZXp7v+gQLlvYvr4Z7St/qb2UoDxQ+S5tPcwsYV/TSPP4ENZgw+oApSWD5Cedq/iFOg4aou+bOnDk/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB2151ABB5986BAEC4E2F10520B8770@BY2PR02MB2151.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB2151;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2151;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;4:9VcUjFBxjRmxAUtJosMUr5RBEkBLN4CLcxvjOfVdDZovNX/7jRmvhDlCahM7vbANgd73iD2NAjxrssaZ+SoEIGSjNmnYmtI2vCTK/Sqclubh8ojmWbpUICZZq42v02WD2t2rtkXgcclhuqFf8u/hwOXBzmUAZLoOWQB0596fQFXfus0ui0fvafMdCl0mpXmsPtf0ElZYt/4sbkDFq+WPMsY9zB1B1zfkW/LX4L7mWdHqDwTrZ44se6kxmlzUnm4qaGA2YLvtmVbot4C6ceEn3LUko96fsmuSrpiE3M6cYEeED4TQGyHVbdrsYPllrNeF
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2151;23:uuJx3IeS9kP+5p4y84MBneXzg+RFZCk1dDS7+TMOH?=
 =?us-ascii?Q?RRTPPOFZ5kTYiRVH4CvcraJ38pWebFckvrs3ydBV2CVofYnMDYfzXaTXOn6E?=
 =?us-ascii?Q?RfABZGJyxVMEGx7BsoK+OXAWE4b2SI+vs7/cGAvqpJA/DxkD3qzwqkZ1UKd4?=
 =?us-ascii?Q?2b/m1eAbkMHPBaO53GM3R+XWe+J8trap2evY3ULRK8Y9PeGypBuUYgUCcaC3?=
 =?us-ascii?Q?FscGUhGlMvjsRyI1bjjVCx1dwJQJvxCngwojj2Xex9kQwO/EVnPu5QIh0dMb?=
 =?us-ascii?Q?oSDJ0n38FJwALhhFXab3HKYTE30QlTIiA9uXXw9LQlcrJ5pkTkuon0vHUpYF?=
 =?us-ascii?Q?8Xixlk1/0W2JiRLa3Ji2G0/bmABotGgn6dsiNwi/tPUi9kO29j72mR+jTcgi?=
 =?us-ascii?Q?UHrMT/9cCVoOlHNnihnc3BkEWCOKcl74j2x7pkVYcE2MvnzmgsKs5q4c5DUo?=
 =?us-ascii?Q?KijUgk2JW1sM1N6jx3FX6dxVFWT0DAIFfSBsDG9Fwhsy6hLpUG4sHpRboj5R?=
 =?us-ascii?Q?7uAzMbY0s/otlI78ph1OyD35/ROdWjUhFGuMz6+8M3txgn8F0+aFI+rCCg6+?=
 =?us-ascii?Q?v1mLLhDSG62vHEnz6O1XwKVUX5KUOUSxX6Q/xY11rvsXKjDtkxPEx5wNdLaQ?=
 =?us-ascii?Q?joOE8K+KixmGTLyZTSL1c2Q3MPHSsSt1t3uBY74BdhSVlMEACqnyRv/S8EJs?=
 =?us-ascii?Q?vjSKwhbW3DRDGPp+fMsEYzMMzu4hOe+8OtmSEbRla1RqF1QPblz33ilRoFM3?=
 =?us-ascii?Q?8oeZXvFPGJuy1rGccAZ6uh4tq6xMThL2pRlTYACr2/FZingJ8B20zqo78JiA?=
 =?us-ascii?Q?is+6OZ/2/qv9ipZORZEzpvBwlvt/nBBpNlEDqC76IJeumL027EuYj09un4W/?=
 =?us-ascii?Q?m7E7pz7lJ9HSeZ4mx/upj3N1siaJZVzqDKPzcixoiHiPqOpd15+SQ5iwbE0c?=
 =?us-ascii?Q?kuXAgxMPw/pz7sNsR+7ds71EEudb1A+6tLYRlCVKNAlXhRZ9rnOzkZ+qxX95?=
 =?us-ascii?Q?h4ya1+v4JB5ZZosau+31qUtj1JVcuEqmI0aIZSovlLv4zFSU9PTw7uWRqWrS?=
 =?us-ascii?Q?CeciveftTG1ozLWkZTEZrhYSv62pfIud//IQySn6Usw0qLYdRRHCv4NuGsLf?=
 =?us-ascii?Q?vk8QE2BhiexYIvr1F1j2YfCkTvPBEnQrUXvK4bfLz3dPxrC3On4bU67QObLx?=
 =?us-ascii?Q?v/ulvRyNWHeuKXClFs9HH23xHGJxAhTNZneFqxQDajdnA0FMeS+VitmGSfE3?=
 =?us-ascii?Q?AUAZQJm4LAE+N8b8HR173y5/X98iN3ymyVeiB+R7kLCtrp/CmjF7RAA7vJDh?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: kbnA5duaZKhJSbZ5yR9fgLUh68DZASRCN5tVOMHk8qKygEUgzBUpyyI6OgAtKZnxDW20UTXSaoBrnEOxQs9XJT5bTcXlJdCmdUKewM1we7N/wh7Qc5iN1yz+iDi1jcv4tU5CWuo74IoIioUG/yVsNUWC4Z5nogmEcyfa0vf0rRX7ZGOrQoGdic1p87Ioqqm7gbaz98uNy1YpaG3dw81EINTZeDJOD92nrfPh9NGZJ8t8XPPu7qcTXGJrxAsp0Y/aArAF1hSwKfbRfgVUpvxspkDNmS7EsOZE0mXxCVvcb6waq9Ff6wAhJQ1VJ+vCwCiKAJImoVXmpPoEtNypSWz1nw==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;6:VR4y6H5LtaUr/N7cZxJiEXuzLD+R1IcguzfeJ283Q4GSijYVpoe+kr1K2GO5isijaHyIhy+ZxwtRXnjtZnqGmpfiAd3TmM/1doUSqrt5BtuaCP6COQ/3cEXmVChvMRBndoXhV9gCYf9LXrVgefyeZ47g/c+fxujp+JeYYUbtdgGG6Amw/THthyOBaCeRTNllbB7SW3/FypvcnHb1XuwLuTy4kLJt55GVdQVZrN4h3sYUYUvXyVf7bw0c4QZ+zm7Xe43581IjtYVzvgFkUEE0FGqJYEuEcKNPtW8B4Wpr3AX/kSFoS8rKINp54k3MgDMnWy9Mqkuxvaa1ltWxb4MzADAfIwSZl1zNKV5GbBPxljZ33CnYBynTFm4pyAIncH2/1Mqh8GX1WunGcxfR2CjOREW/yY0COaTM9fdfcG3TQ7L5A7T+toE1fO9VtC2383OXq5+n55c786z8k077+TGmHg==;5:19rtfjeShp8G4PpweavLkM5lo//ipqCoDZAkpalVKY9mdI6iZJkropsiwgDd94Z9sDAJWKb8H07rWHSwtIZT1cc9bK1K4mHp67YQ9f6/vJcpxeonlq6IV/jVbyyTgYpgBnj7ALS6jadKYYUQaIlU0RF/XhNj4Lkp3QUJ2ULTP68=;24:SGVzGSkjfuRVvCImAOEBL7ukfvtZDxNyIYKiOU/lsm3mTVYkg0QxAWBkqWEbOOZljJhpUaCCKhaksI0VpzvyKTX3VN8wmQ2RY2RBqfQpMaU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;7:IrLPzV20GRhrVhnR7GwrgcdMKlVblwWftzPqZ2R8HcDPFVgabXL/irsrOKMEU/nde0OZf4Ox7hgQLl9w0rGoaigmIsodgaSWbnq5XJQ2lPziBLO+C8m+mmzir9zvRkM55R1nP1Zyp3E+xG5YburjCAPiML3FPCZElcYM/+ths/n4BWUY840Jy7qhaXePLfjnVStaPHpfAM7gZiWyQpcIiXx5IDGVYHFFVhKmqFyfAjpIJQjvk1DP8zOpHO6Ojz6Q
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.9720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d8dbb8-6f37-4bd2-830d-08d5d6d4fb5b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 86d9bb8..c764d6e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be 0s.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   rate & 0xFFFFFFFF,
+				   (rate >> 32) & 0xFFFFFFFF,
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 354385d..29fb352 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -36,6 +36,15 @@ enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -49,8 +58,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -71,6 +92,15 @@ struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

