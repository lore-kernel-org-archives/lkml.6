Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84308C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D9D2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FOE8llOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D9D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIELJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:09:59 -0400
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:46865
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeIELJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nYqESsuCPGWfdDU22qIiRLmysA6EKd19Ewc7+lo/Yc=;
 b=FOE8llOrH4aE0mXAaaWQuG5UzKwULVMnL9IpfjlP6ChWgVjNZV4La2Zf5f59Y3I9cZbd4TQB8iGxBVITzVWARxU+gbohHGvnIJEWCO/K1ZgxSwKHEBjFtQ9FWxlW2Ri+8AqFQOZn5vUKIeeUUlMUaq5A+KSd0s2TaiRQ5DaSWcM=
Received: from DM6PR02CA0021.namprd02.prod.outlook.com (2603:10b6:5:1c::34) by
 DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:11::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 5 Sep 2018 06:41:11 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR02CA0021.outlook.office365.com
 (2603:10b6:5:1c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.16 via Frontend
 Transport; Wed, 5 Sep 2018 06:41:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 06:41:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:38348 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRV0-0001Xs-2b; Tue, 04 Sep 2018 23:41:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUu-0000v6-VJ; Tue, 04 Sep 2018 23:41:05 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w856f2FS015813;
        Tue, 4 Sep 2018 23:41:02 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUr-0000hO-Ty; Tue, 04 Sep 2018 23:41:02 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
Date:   Wed, 5 Sep 2018 12:10:42 +0530
Message-ID: <1536129642-7049-4-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
References: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(438002)(189003)(199004)(478600001)(50466002)(476003)(356003)(2616005)(63266004)(36756003)(305945005)(126002)(8676002)(9786002)(336012)(446003)(81166006)(11346002)(426003)(36386004)(47776003)(81156014)(486006)(48376002)(77096007)(5660300001)(50226002)(2201001)(106466001)(26005)(2906002)(186003)(8936002)(110136005)(7696005)(217873002)(16586007)(106002)(6666003)(51416003)(76176011)(316002)(921003)(107986001)(83996005)(1121003)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4937;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT006;1:kRGMopOdDwbhHtSRec7ORWk2ankpeKAj4BXQKy/CdMtD972qqBnmEpMHKtHwj6whpipdxActUntRWN51OcgRz2peQfEL8q5JJBJB8EGcmSzW5FW+dkmDctwGqiq7EYzm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9661225c-3135-4992-b956-08d612fa914f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;3:bktQ0wWLnvazuZ3sdkNUWuxMwbeAF9rXwpYU/ed1sjnoOTiohBbAiaPpEbAyA1PGf2iWaMYGZmcurm+0nIf8blqZrhD/5Bn7ODJ4oUD/TR3BYbA0uWQ+4326lsL0gipggsXHw4ck0GilGLAtVb/7YF17M3Tmf6G62pobljaMVQYL/t6ezF7Afal2oYHK9jTTxPKkKpXJzaH923xFu5I8fSp5CsQNWqTpUjRe8gTFf+CCNvyUsf5AWkNOYweo18iEpen/962kyoOIC52xUmN71kC5agwcBp5LsCOXQ1p8uRrPC4GK6od8KYnGy5BTwaIWcDO4ZGioenEtylwvuKf86Vr2VjVupofGZAlx5NggSeA=;25:ix8Xs15INwRevmc7QkwWonpEZhntUT4F/vdyiSdp94fkRZ+27g6gga1gYRIlC1nOHybUjLFKZh8GsSbpFDok4+l7anP3uGPJTBdr5dFiiI1BpWcwsjzSdbLKhdpSVB4jjcTLYn5VJGIX8PC3tbbnJaJ608Dr7IUD6XdzDUMvDjWmWYkTqtwfkFpFPaC5z0n0ZZM8sIDe7RLfEvpAmh7wd0Vp6JCSP2oAScAwFoT7O9tPF8fl8XHs+A6nTC9on5N7FZ1XEM9i+mtMM9Mf5tPI6auzRNsJY8/P+hfMuSGZG2IES02ByzSGECDR0BG87wS1wgwY2a6lUIUwFS5sK0CXbw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;31:dbfYgABh0cA8behCqnQyP7MHE2nNzTEP6yMJUjFtlWJLSFd6OiZASgdDXMZ05lOXVR4icYO4dCHZAdb7MTWXiKU58do8fSvDYYfZbQ8hKmuv2EQSu9nIxWsjzW8O90NUFt5bz9xDVkOEKOV1Ck20PNxhWve0uehDb9n6WyszVto0UklfM60bn9ktZ2JFEmHIOPGo455vjr+a7957QoevuGLsS1uLVpvBfoqC5mGyFJQ=;20:DtEn2Kv7CruKxCYSuPirYSmMpkU9StXLe/ZY5IeNcoHTQvYmr9IHdH5lH8TgCF/9ff4qAenC6aHDyZ/qyiZdvBxAXio/inbEP/giWpEmoF1dK5ihfA2aEKFzRMo1RrOs29hzg07g99b9kF66/mby2Iklc6mcz5sgCW3Mt/weXwfpu+PL3P26s2JFju0FBpYRuO0jKFu8cQw8551VnaRhabyek3b7RZAFp88YYMX56qUCFNY+PGhJvIFBRymexzgq4RPyEW6PvnhB8i6GEpsPLxEmnug70UQRubna/YVwCeVcwMqwaj54eITeCVdEVLsfT2R5qzM+rE7FutTv8QUrDE1XNDBoTHGLGgFcg+K/OfNGD8zKXYiEO6R+qA0vHqMOpW/di4FywPynt0XhIg6KS2r8S6cs28QfOGHSKVKyNiCQVB1D/U2+WDPU5XewSnW0RCtZd4e9W2839w9UFf7XdxvwWg0W8reGlpVX7G9zSJcH6kj0USK5ZbFMbeWeS4V0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB49371F57D1DDDC8569813B85C2020@DM6PR02MB4937.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR02MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;4:6I7KNrD474UcJV8kQdZ7WM0WMsPYawiX2I64DQY5ULhph40KL23roRCAjGi72uj4Vc8zpAKS6bReapduKFgXTkifueKM8+XcwvFdQ0/RKefzPlo1EgPkQ8LXsh07DpOA5SkKKyk6SSF4a3cqxi+gFI9oRd8KEwPf6u8RuNW6EnssUsA1qPyhRPmVBqUDdxzfwx2icWSZJejnY+gbATyOWqxKXtEgkha2tAC2ZrtV11rGypMRasNvVEHAT0H2bFW7tUs26qBVQT6YZ63YsRDTFao7IpvWswDe6nQ9WE5KAh+YaOIbuHwUDIDGHvFaSpEa
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4937;23:/Mk4j+JrLf9a2PYborVmCWueqjvavrfM2J5/6sddv?=
 =?us-ascii?Q?qZvIHm2cgjUfYW8D/NKD1g2NfDTRNpJVjiRQb7PnoZoSUFWJw2iZ3wXk4/35?=
 =?us-ascii?Q?POrCCVGmoZoif0tBJibvsLvVKpXeQD5/tjZXcUyowsXp/oF7t8gF/06fyloa?=
 =?us-ascii?Q?YZ/LQ+Gf8Qh014cPQqfQKqhZV3ZvnIOUOsp2TYBJ2Lfkuce1Z6PEMI3eSAxI?=
 =?us-ascii?Q?kCWFMLqp4JSu1/xR3EMehbZNXxnYT3nI7edfrM+Qtqw1Kbx9rBTF1aeG0LPN?=
 =?us-ascii?Q?PNPUJ2iUVgUVz1VA9rmVfXPnVofp+fllT63wxb/DO6d8MDJou+Lm1//gnFKn?=
 =?us-ascii?Q?doshPIOSolsSXpS14kWNBd0+yC5xKQ2Cb/YnzX9gDcyHosZvx7+4EeCq/Sv6?=
 =?us-ascii?Q?kJQo6YqaBWlwJPgKokybYBPwDaNOUqJJyH2wlNkrS4k2E7MyV+boIHiAGkav?=
 =?us-ascii?Q?QvK075oDFxYLYxIUIx0/Yf67RjAMWtjBUHWThKFEDHO9cO78QN2fvCzxOz4n?=
 =?us-ascii?Q?zpwt87gGYuEZKoPpGPe8QsTvPLFucHsyLykSHccmpxpzuppF1d3vjF9zhhCj?=
 =?us-ascii?Q?mtmYhWj2vRap0CShLDwZ/kfXcWSp2hhXF/GlR55ZQE63iKeR4pDNrgU7mDoB?=
 =?us-ascii?Q?evUgRtyZzGIigQQp+lS5E5aTvGI2DaGFEYoGfSK0r5ue0zCu7QpV65vhve36?=
 =?us-ascii?Q?VlvAEP74iP4i7AyFhAo4z6oMjv+Hcn8B4rYNfXID/iqtXaAhxRjolsM3OnFe?=
 =?us-ascii?Q?r9p3K9+csj4V6vSDhe3Gd8Q18MDC9Pkj7uqFCkPSwrthjyeHFprTtxGXo/gF?=
 =?us-ascii?Q?uhXulljk4OO0CGXet1zyAynAX+1bhoMeIXpITlbuw/gjsj0tbh9eWSc4+S5w?=
 =?us-ascii?Q?LIFW9yyaLh7OIO80YR3/eiYQS4dwIDutPA/6LL8ugwzqUFWD5s0SlZLthbEJ?=
 =?us-ascii?Q?YAg6E/TpAAhHb0bMWhNnWPYK5rfko0rJfoWd1hmglP0iNHU1rHB2aVn+NTW1?=
 =?us-ascii?Q?4/K9PzqshGqwYSVrB56bPxnDpUnL4/FNTyM6OUgCi7P07H3QoI0USddbxCNU?=
 =?us-ascii?Q?5QdmEPyKc72SV7ieMCS/d+lp1BrtLwCpmq/byTeh+maNaf0j7Th9RR1p7Syc?=
 =?us-ascii?Q?Cym4TPzNotCJb7Jpt6vhs48Vq2FhmUQWJP+HUpmfm9hALUWsDM4ihXNfOKM1?=
 =?us-ascii?Q?0m6l7fghxxkp1E=3D?=
X-Microsoft-Antispam-Message-Info: eYQ0BeGzCEi4qSFxWQ5pUFv42EKaaNyLNB6nE7+w4OFlEWf5D757dSFalPfDgYKO9FlwMJmm+MItJFVkrkIPEeruTnEfIPfBKtjj62xZyJv0iu6TWPt6O1eYSwdU1myp/8P9hR8eCdUAK4DUgsmdIQvb5W9VLpgA2B+MIdJf16pM19j04Lnfy0vcv/FPrWGhPfSSYj8rLu2AyKJ9u9KnIeF0KHB9YNqNH5KWjGHVxylPgf3xC0X8N6uCB31A9jadiTfp8sNRaqaOAC/4aLW31VP4saIEDbED25de8LJVSoXJKCcviBTZ1S3N8bwvsK/JtO4tlQwORGA+J8sc6ok6W/tTJ3R/t7Pa0ccIpmaF4/Y=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4937;6:xgyTH5Kz4wb5J3TwcVx3ZEY8qqIXJFXNdl3w6HOEoUyzEhQSXpd9zKYuE1KxouJIEA+CX+DIqT4jKbamwM2maFQSAO45Ie1dTCJQPDW4oiVst/vqKO0fnhYfE2JcWNXuATigynWlb8OJSAHRBwV+/smFXpMTzKM3YtRAnwnlihF5G0Mohzani9U9d9ONxmw3KbUoqGGHHudVrakuuOq+VtRz1ttV1GDx+KxoXeamkMnLwKA0eQNtqFxWXPVaNVBKd+RJy2gk+dhpdkp7bZmrMk8KLQYy8BkzwweVxtjch9elScZU3VB0eJbcfrJ64rSUV06MyeUJKNhLfT1fNmsJW9D8eNPslE2Q5W/+OwfFQL+uCdhaiGt66K8XMzEOW44j63NFi81dSGrW/aNutXCBNYFg6fFqf4vqfx1K00nzeUaXkrbk4ctaDa+8L6N52UTS/d9U7Ezitc6YFaIHmcUtkg==;5:qI7492/oq6zLx5bsBk5+HvHB9ydmv8wdZ1fKQ4ThEuGLZ4ekDTMHg1BBFCZ/+gM2ofs/NO+/9FbMarEuVIu4YUlBL4sFHaruVO88UZGngMY+A+MHS+evYPP8Ov1vywRFoymsD+X2i+7wMXjNPWjpcDqfx8EGbiHcZTgtC+MtbQs=;7:fVRTDwPkXkGmDLBuAQ0aTorGjrn5XmDTXdHoBtiJgFHGvX6R1tKXqfKfXDGS1CVDtABSKnFX0r4AtfKBIdeAMmriD2OFoK1pqxzr6kN3MbzCfY0Uk1p4Jbv5CCJz3aNntAEfHJ6qDphy5d+0efX0vU8icGyWYHVZKLM8qGp4dsAG9wxhN+qweQCg9FgkeqNb8vMyPEBtmLXWt1AOyXwZTUWS6maEPfPCeVbLfRHhxRIOsHxHdDTOdajUFO2BVk56
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 06:41:10.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9661225c-3135-4992-b956-08d612fa914f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Moved eemi_ops into a priv struct as suggested
		 by philipp.

 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zynqmp.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index c1261dc..27e4a33 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
+obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
 
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
new file mode 100644
index 0000000..f908492
--- /dev/null
+++ b/drivers/reset/reset-zynqmp.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
+#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
+
+struct zynqmp_reset_data {
+	struct reset_controller_dev rcdev;
+	const struct zynqmp_eemi_ops *eemi_ops;
+};
+
+static inline struct zynqmp_reset_data *
+to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct zynqmp_reset_data, rcdev);
+}
+
+static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_ASSERT);
+}
+
+static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_RELEASE);
+}
+
+static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+	int val, err;
+
+	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	if (!err)
+		return -EINVAL;
+
+	return val;
+}
+
+static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_PULSE);
+}
+
+static struct reset_control_ops zynqmp_reset_ops = {
+	.reset = zynqmp_reset_reset,
+	.assert = zynqmp_reset_assert,
+	.deassert = zynqmp_reset_deassert,
+	.status = zynqmp_reset_status,
+};
+
+static int zynqmp_reset_probe(struct platform_device *pdev)
+{
+	struct zynqmp_reset_data *priv;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!priv->eemi_ops)
+		return -ENXIO;
+
+	priv->rcdev.ops = &zynqmp_reset_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
+static const struct of_device_id zynqmp_reset_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-reset", },
+	{ },
+};
+
+static struct platform_driver zynqmp_reset_driver = {
+	.probe	= zynqmp_reset_probe,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= zynqmp_reset_dt_ids,
+	},
+};
+
+static int __init zynqmp_reset_init(void)
+{
+	return platform_driver_register(&zynqmp_reset_driver);
+}
+
+arch_initcall(zynqmp_reset_init);
-- 
2.7.4

