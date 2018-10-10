Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B884C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TTO68lio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F34A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJJOmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:42:51 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:9844
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeJJOmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEGxkS+OTKWeLcmRnt1Y7njNf7hMDaN7YbpIVnOcZmQ=;
 b=TTO68lioUbB1EG6Pp+ecxQCNHBkSVoXkSD7pfGzadvHALTzS81iQMNxAylSYOcEICE5ErzkdxvCkOXYQuHmWUt1K1OCzD30wB7wNKlzxVMVYiOAjUSvuLriQaVefluSPoWbOQPRIDAkiwfwmEnbRIvu5S8Aq+tTCrp1q3icMKLs=
Received: from DM6PR02CA0012.namprd02.prod.outlook.com (2603:10b6:5:1c::25) by
 BLUPR02MB083.namprd02.prod.outlook.com (2a01:111:e400:811::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.25; Wed, 10
 Oct 2018 07:18:55 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR02CA0012.outlook.office365.com
 (2603:10b6:5:1c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Wed, 10 Oct 2018 07:18:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Wed, 10 Oct 2018 07:18:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43485 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8lf-0003YK-83; Wed, 10 Oct 2018 00:18:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8la-0001CM-4d; Wed, 10 Oct 2018 00:18:46 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9A7IiCg031653;
        Wed, 10 Oct 2018 00:18:44 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8lY-0001AF-Bu; Wed, 10 Oct 2018 00:18:44 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Date:   Wed, 10 Oct 2018 00:18:32 -0700
Message-ID: <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(356003)(5660300001)(81156014)(15650500001)(81166006)(8676002)(8936002)(50226002)(36386004)(9786002)(50466002)(305945005)(6666003)(106466001)(2906002)(47776003)(63266004)(48376002)(54906003)(316002)(106002)(51416003)(186003)(77096007)(26005)(110136005)(14444005)(16586007)(44832011)(4326008)(478600001)(107886003)(446003)(11346002)(476003)(39060400002)(2616005)(76176011)(7696005)(486006)(126002)(426003)(336012)(36756003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB083;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT013;1:6Hq3gSQ/mvrGSr7PZLngX5C4vV14+RTxFTRfET03HGumHeOT/6Lx7tgSpZzN5pagpvTSXTZedklPXzofHBK2rsJ1cGe6NzHmWjWBSauVFVv4vKqt/SkiuR8Q/A+1fLpo
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e86375f-ce3d-40c3-b9ef-08d62e80a2de
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB083;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;3:24vI9rDQDgMiP5ONca1TvxbISVE+Ojg8s5SJ1IDdB6+atiSR9UuNUP2r8bzDprIXCi4GWcZL+RKW3OdEDg89gaiNAYsKyB4MYVVeW6m0mYdosXLjMeRQzzsVlGFoZrnwSifp9MDZUbgdgUwSqYN4cz62SucyejnQ+NdK6whKu16z8FgxvML5hj+PCUq8ukkRenhG9yKq4wMm6E35A+/0rz2iiDC0EC9Pa3zEU7t3A0ZmlPtPh1FQOGRntgY/ymqlhdAV3Jdq/dVfGgJhP2+hRSPjASR8tAIKHXVa3PfoCnyRg3maj7AFVZYoLE0hdmjwJFv8+xcTEJAIcfsrFxJXKvmj6VvdFcn7RSRLxi+49Wo=;25:0lvbrXimwETNn4f0Wx/e4JWN7AOG7GTjvS8qbUeaeT6qiVV8kM98kHv2uTT7MB7tWaT7KOywaXW6/2JGKaaZ792kUcZcKn2x/61jLbhvACGR3OBG9xCimvUnxhAMwdsl/kQSVIgYbfSxtKu3Mopi4cWgVwM+9sTmxodqSf56/GMCmNRZFlh9T059IYsd2edTHqW7HXjrYTUcf3mqINgqaJ94wALsGP8LGKecBm3jLVYjmw1pHNAx1YqrlIGoeDErkKO50UX9+/XxX1KU6fNJ5U1GHeDkNAj5tdL1GDuwGeU2p2JJM/NGjcU9pscUklwqN5H36ckAms8Os9yhVlvvf4UpCIb8z4gtd5jms/B58cM=
X-MS-TrafficTypeDiagnostic: BLUPR02MB083:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;31:1TfJetfyr5WpmwaQt8Z4l63/VIA9/lQk/GKZ+ns4aqxJK+Fe3CyU74Mue7BFY0WVrCZd0xoydv/mzNYt6BlpPgP8jVAGiyfWvsnjgNZqf7Y2pSWVcW3vG09KS6GY9wQqeOBBO43GupunMXJmf2L+/rBctP1RTuxkNUSkyOkBzmLt9S+X5upVRHwZGwGk53D21pOWOk8Gxf9/gkqLhVQPlvvJv6dMVBc3GGzAHIAxlDc=;20:eDeN+H42CnAJBqHlGBC0cFgi507CeAy4bOtZ5VyFrJO9T0adQ03APjvfKzDwnzW+kVRp2BuB8WCJIKuC2JsA8fFBMHMciGWabI/aAMvDeU8UsmJS4/r8cyL4GFJcu/Dci6igwyJ+/OU/FbYWcf9Q2O6DF3RxX9wkyjI0FLW1sF6Cl1sWAWvCTjfBPtp9fYr30uBMROTnxeLXdEl/3PyLxv1OLy4MwqLVefZT3uAD7Xn4DdzBVLkp+tXwnTuwBiqFnK4VkxRyUMtV1x69HconnULt0aqOiwagPcH++4oz2ZiDOoHaSSsMcOhClgWydt358p64S5l/GELbP2whZQeJZxPpLua/48oa/OSMkRv67mWIVIDCl9+/1aeeV2Q0HoIAzeJmiVx30ILuqYMLBwdrLSnKZ/Avqas1gyUBVCewMqL+z/9HbEQH1IaVfDbm4M0B/NJFRSomYeM8XBgL5AbVD1BtmfxAVUnr7vpVJRHegDfPrKdqD9l/PI6fsrbO6gFZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB0834A02D5ADA582407CBFD6B0E00@BLUPR02MB083.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:BLUPR02MB083;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB083;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;4:IdqB+skndS6DKeF+lLbyipq+7zLnyaA2MUu7oW1DRqkTBkjVtlHsIIRCBG9WIiaoT0UpK9HFaOtps6MmucPsw3xHbrrtAac19R62BhwNwIWb2p4pqKbP0b2kHUpgBongcSdiE5dlox4HKiopCYCqmk2fN3fnszh7+YzTdBU5eyhw46x84NgnmyGcuYfkBHlRx404FOIFFuNsb4wblZYd1wgxao1iez08HWGm+xACnQlbH1+KMk9uYomepcOjzOe3LOHIrVwA1XBtIgbiV8hfvaKFYR8HmhuKqBuWr+o6Sx/9xnnR5bPwmVnMg2ZRAnKh
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB083;23:OKEGAcp6o8EKuYwNnIwBybUwuzQDAxEtSTow4xJLk4?=
 =?us-ascii?Q?A/+ghzoZzN108WS5K+4MqoarQhRyeug5mU14kMnKQo8blCkh8A1ohoYWgzwP?=
 =?us-ascii?Q?DkCsV3UaT0NjDv3sH6YMIHS6ivdBT7I41F3zaPROggIm/JG3vdZpuIHWDRnU?=
 =?us-ascii?Q?SdVOxWH4KOi0gxRxsoxyBqqfBVTKBFaH5TutXBtAQVG5ihdgfvk+gD4YUksp?=
 =?us-ascii?Q?MTY7+ENQ6Sdm5etM5FFOMQUgfJRUHIM6i1ZgFLpSFRyKA8TW+vV25irnrcCU?=
 =?us-ascii?Q?T0XINW/M9nzo7MVEMTVI23bgE3p3C6fhjdWeJNYWK7XFWA28qeHbMGin00Ol?=
 =?us-ascii?Q?SOTPzt+VCha0siwxsb7oMoQzd8d4FwEH6b8QYmGcdSmLGCItTK0NcGBcH2l/?=
 =?us-ascii?Q?riJQ7YiTOBlhGjZm7FPkHoUoWO9L51aLXe2PLOGlb2GJPlYGkT8Z8/V0MuDr?=
 =?us-ascii?Q?YVaiXOr51l/ID6qH6e/HfgddSmntvRxAE5i+DP01K/a07C/zW35jB+XzCVDc?=
 =?us-ascii?Q?XidBNNseABqGcswo3TXS7YNgFvvzFnLWra3F0U8s2HG/zyRp+SB/VdFn5cx1?=
 =?us-ascii?Q?DHKwSind8SOGc/5JgjZed6+Fuvb0RTZhQbGwroEH6NuR5l/tU9+i8msCsDX+?=
 =?us-ascii?Q?r6Yf4ir8wJtYMHpv7W3s+xqZS6QTMCAuyOLL4UDMHAdlGyGpJc4AJ0UmDNw8?=
 =?us-ascii?Q?Nf1qXntKpSZXW8BRzqtc5Yb9rizt3MrEN6Ksgm5/6akt9Nc+to8tdVUOTO/3?=
 =?us-ascii?Q?zCKG49Zx3qsmCJp8JwAvzYT4y96A50LS99bFY4Ja45gacKCnJ4tClNVXNv/P?=
 =?us-ascii?Q?ln9kl9o7OVkzAUt5KqdAAyfIY7u6qE2iUBKyJegli/Y2uPSCOCHUQOaTGv06?=
 =?us-ascii?Q?s5r+CAx7I3FoLdzMRCC1c7Fp1np5KxCNCl0L61FpDhZW2JVKyMNwNr7zv4/R?=
 =?us-ascii?Q?XxcpOWjbzFJPIJQ9CPria9Vh6v9uUi2frzD7lUsBFX7NjrL3R4aeae/E7IZa?=
 =?us-ascii?Q?807e5OQINnhdTszMz5BARy9fmXvSOCfGfS+8VTe8o9+c70wJqWfiDuoKPLX9?=
 =?us-ascii?Q?od6yPBzYHVmVcigZ0ffL3MHY2XGuYjky8WUE0sNEbe6BOEZeMADg4jt2ekXY?=
 =?us-ascii?Q?jADV+LSvaY74gnSHx9Bskfz4KQLBxD2+wunzlquCO25UfSKeUlaBTWuLkKWm?=
 =?us-ascii?Q?JgkhUEjScmr85RZgw2F7inpAOjaDVdYl3aJu7A6Bin2tpdCpASt9BA9Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: J8YOP0lZYalHB8OEdfSrNui+mDXQ2YjTJ8QX9dTHF4gEmuVyuDa4BNuFWOsJ9m9d/T6T0mY7Un3grqvQ479R5nzkY6SpQu5/DKfTANdYnFq8F90jkYFwcWO317PKHIdNbNv9dAV/QyKGOYI6GkKZ3B7szSzkVdqw4+qb5rO5dTzLO9lUAgxXPPnQWu7W4wGuM21GHZ8QoyCM9cVJEtoR2XNb6rO4VPi6dIWkfm7cStvrYsU+sdCy4p0Y89KcpLSqEnlNCJh7qEq224GNg7O2zLKekcFqxiSzAXQjxjoAodUYqc1m10dZ+ppd4NSl+OxcqGog2k6UrQr4A1v4mqJHQNN2MZ9K0WItAdAmBLHF4BI=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;6:o6DaVBAqd4vqfYuoaukqi3zZRjUiAd/tO1cTbDYVA4mfDLnyd/DpFYnyAWfiUH4CmpwVF/PL5s8WANLKLAY8r3NMr4Xj0uDmmo8Ecfk1GBgXfqt2PFc+PjlI3I5kSk26I99QiN10KQ5tgrxQyEAmAVJf2zhy3jCy0yF9VM9RbTGbRL5q1CEcpHm4mOEFyE9c4AZYtIKEg3DbJwSJC89+9y212MOE3Fu6gIHhhd9uejC8y8aPwS6xoAoTBSVDbzVUpQ6+EJOHeEvLpHdJr59ZxS1cs6VFskf3eMHXC5ep5pZZXo1yRaGm5i/9KcnCRmswkIJDAeXVZjINXqZnh9V/Axzfof3tfx+fUGMKoA0j/aV6OlDdo5slH++RO/kgzqPoR5iKGs3SXIkPfsYAGnRa3MtyqESbjbWsrhyggozabeVAMBuTCA3cGuw8MicWpBrXJA6oXNvzf4KWKRbyazX06Q==;5:hbz18iRe24OI+s/jaHnAGuXNHKq4dbHPHn1fCGzjQB1G3AZenJdOrPfe6ORbE59YN9XBS3wDat8Lp5LSoo7FfN/o1I7DMV+x0Egev6V+nj9mxILOKngZcXSbbovHouSknu90HEDloTwVL6VLQeQx5JUZWWN6Q54h9rI4qrQB8M4=;7:eu+/iaj8cRZuc8xjFN4a/m8Npc9w/Vic2EHYOxATBeK5QxVRgt2XY2CBYPJ/+jRHufxW5bKGbjqjTmesgBZNGzrB3DAjfGe76yJ5EBxRDsv0dO2kfRwGqzBiOg5bHcPs+wmt5s5EuFrA9R8ROWw2CJ2ZupuCeOQydYktnz/2eMbSVI3uBnq9uVLbUNQjmJVkcELp76WPOMl68IEgiPBlo/kwa4gxTdM7JIA0F5r7LwFymflP08D3dB0InavKOwaV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:18:51.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e86375f-ce3d-40c3-b9ef-08d62e80a2de
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
in ZynqMP SoC used for the communication between various processor
systems.

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
---
Not put "Reviewed-by" as bindings have been updated since last review.
---
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
new file mode 100644
index 0000000..146f2fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -0,0 +1,128 @@
+Xilinx IPI Mailbox Controller
+========================================
+
+The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
+agent owns registers used for notification and buffers for message.
+
+               +-------------------------------------+
+               | Xilinx ZynqMP IPI Controller        |
+               +-------------------------------------+
+    +--------------------------------------------------+
+ATF                    |                     |
+                       |                     |
+                       |                     |
+    +--------------------------+             |
+                       |                     |
+                       |                     |
+    +--------------------------------------------------+
+            +------------------------------------------+
+            |  +----------------+   +----------------+ |
+Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
+            |  |  Registers     |   |                | |
+            |  |                |   |                | |
+            |  +----------------+   +----------------+ |
+            |                                          |
+            | Xilinx IPI Agent Block                   |
+            +------------------------------------------+
+
+
+Controller Device Node:
+===========================
+Required properties:
+--------------------
+IPI agent node:
+- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
+- interrupt-parent:	Phandle for the interrupt controller
+- interrupts:		Interrupt information corresponding to the
+			interrupt-names property.
+- xlnx,ipi-id:		local Xilinx IPI agent ID
+- #address-cells:	number of address cells of internal IPI mailbox nodes
+- #size-cells:		number of size cells of internal IPI mailbox nodes
+
+Internal IPI mailbox node:
+- reg:			IPI buffers address ranges
+- reg-names:		Names of the reg resources. It should have:
+			* local_request_region
+			  - IPI request msg buffer written by local and read
+			    by remote
+			* local_response_region
+			  - IPI response msg buffer written by local and read
+			    by remote
+			* remote_request_region
+			  - IPI request msg buffer written by remote and read
+			    by local
+			* remote_response_region
+			  - IPI response msg buffer written by remote and read
+			    by local
+- #mbox-cells:		Shall be 1. It contains:
+			* tx(0) or rx(1) channel
+- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
+			connected to.
+
+Optional properties:
+--------------------
+- method:              The method of accessing the IPI agent registers.
+                       Permitted values are: "smc" and "hvc". Default is
+                       "smc".
+
+Client Device Node:
+===========================
+Required properties:
+--------------------
+- mboxes:		Standard property to specify a mailbox
+			(See ./mailbox.txt)
+- mbox-names:		List of identifier  strings for each mailbox
+			channel.
+
+Example:
+===========================
+	zynqmp_ipi {
+		compatible = "xlnx,zynqmp-ipi-mailbox";
+		interrupt-parent = <&gic>;
+		interrupts = <0 29 4>;
+		xlnx,ipi-id = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* APU<->RPU0 IPI mailbox controller */
+		ipi_mailbox_rpu0: mailbox@ff90400 {
+			compatible = "xlnx,zynqmp-ipi-mailbox";
+			reg = <0xff990400 0x20>,
+			      <0xff990420 0x20>,
+			      <0xff990080 0x20>,
+			      <0xff9900a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx-ipi-id = <1>;
+		};
+		/* APU<->RPU1 IPI mailbox controller */
+		ipi_mailbox_rpu1: mailbox@ff990440 {
+			compatible = "xlnx,zynqmp-ipi-mailbox";
+			reg = <0xff990440 0x20>,
+			      <0xff990460 0x20>,
+			      <0xff990280 0x20>,
+			      <0xff9902a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx-ipi-ids = <2>;
+		};
+	};
+	rpu0 {
+		...
+		mboxes = <&ipi_mailbox_rpu0 0>,
+			 <&ipi_mailbox_rpu0 1>;
+		mbox-names = "tx", "rx";
+	};
+	rpu1 {
+		...
+		mboxes = <&ipi_mailbox_rpu1 0>,
+			 <&ipi_mailbox_rpu1 1>;
+		mbox-names = "tx", "rx";
+	};
-- 
2.7.4

