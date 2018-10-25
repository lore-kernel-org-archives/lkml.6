Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCB3C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983DC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GM4T7jbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983DC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeJXQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:01:28 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:60136
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729323AbeJXQB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8KLbxKIuDkbxFdNGxkvQE5ttGBQaL9mOkFhFsBaTdA=;
 b=GM4T7jbSzfC33lUt90bPpvRedmjb1VlCttArmXcwJGLdYQMJTKpQCCCfcgDopxubddqKtYSJakn/W88hIpThwBZbBSEXWKbjG3iyHu0P/mFQER8EdfLVuJel5pz8f8eEWeMcNKS0Syfa64jeqKGApGsch+PllS4l4ZHaxd0r4N8=
Received: from CY4PR02CA0014.namprd02.prod.outlook.com (10.169.188.24) by
 DM5SPR01MB338.namprd02.prod.outlook.com (10.174.243.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 07:34:32 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0014.outlook.office365.com
 (2603:10b6:903:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.29 via Frontend
 Transport; Wed, 24 Oct 2018 07:34:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Wed, 24 Oct 2018 07:34:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56951 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgU-0004Oi-76; Wed, 24 Oct 2018 00:34:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgP-0005xY-2O; Wed, 24 Oct 2018 00:34:25 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9O7YJEu021799;
        Wed, 24 Oct 2018 00:34:19 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgI-0005vF-MP; Wed, 24 Oct 2018 00:34:19 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 1/3] firmware: xilinx: Add fpga API's
Date:   Thu, 25 Oct 2018 13:02:04 +0530
Message-ID: <20181025073206.9264-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181025073206.9264-1-nava.manne@xilinx.com>
References: <20181025073206.9264-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(106466001)(14444005)(316002)(76176011)(8936002)(16586007)(478600001)(110136005)(9786002)(63266004)(36386004)(305945005)(50226002)(106002)(1076002)(966005)(486006)(26005)(81166006)(2906002)(8676002)(36756003)(48376002)(50466002)(446003)(2616005)(126002)(81156014)(47776003)(476003)(77096007)(6306002)(186003)(356004)(51416003)(7696005)(11346002)(5660300001)(39060400002)(6666004)(2201001)(426003)(336012)(921003)(107986001)(83996005)(2101003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR01MB338;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT038;1:vIX2a9NBtq32JoOCbfPAeQVnTpSf4XvKAe0uGUvBjCKiyXTbwvrADQ3NBSI0IAIDzog87Mb4XI+E9QZvJvWUjiw89t+nwDYsFzI5+Dfn0I7QwOzIA5ZMh/JbVHq/cqbU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5745d8d-4771-4065-0b0a-08d63983235a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5SPR01MB338;
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB338;3:TVdszovouhtxSdaRMXr/j7RWfobuIlBm2V8wSzdBniWMLsPLNvGvYojPjb6KlHqHoOq+iJFkCgtLviHrtpDQrqvurE7tCBZaDCV+LCEOCQXngHATWukwCxRfUXMBBDQCYy9oXg8LaVSx1bw9+eTj+SZpSli6INqfhCDeeW3+9vYV7Fx0365Jz3zST26rN/2D6xfEwpoW79KcjxSH54pxkXAplKfamqadXGeTmUHx2NzmDI57YvQWU8eye0wGlX7EnOWjWWjdvk4XiZNyfYJzeInNGXWCUMZK7cLeBgfxuXgTBQiNiFw0qBgdsRpNGYK0JH1pccOznJql6b5QPX+kZz07ceBU+VMthHgZx1uJP94=;25:lSTGTzQDq+0vo1bBMyAsc2qe+30tcEyBU4L62NVj7LdaTw/L5cwBI0eXtD9sz9UNKEdvuexhFeoMR1D5PdorOzmq0UE0g6y/2651GeXUQZhdo3SEKy0lnplbn9bHtkrR6paDDjAgNxbw9g76vMVgx5u13oTPm8qprJJm135mIhP47tSRS7WZ5mvMMViKpJ0Ogac2sdVP4LqH0CtxDftuyDVLlBi4IwwYfdev+Pc8q9xjFxx2L7td0hI3iOM6M5mVVuWPwJ2PJ93ijktR6QpuSNsZtcIcSG5Huw+bgQrR3iuc88cWx/V7RaYVxj233r8yvfpSgl+Tp5AsuuVtJnV+FQ==
X-MS-TrafficTypeDiagnostic: DM5SPR01MB338:
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB338;31:H0HeJOYI3XCN+cUKz1F+m6SpULwjYPTT5PC40vtFlPRd9m9ojz72nzlun+wt2JGoitmxfXiReMWz0ct7p5qMMceiYxfrfIN8+0V5IMsGSQV7sdXbmtRYUrROMoSpxqprQEL7RWf0ZU2+gHijw6PpzUO6YpAegr0C0p42tswMZLQ52LHfBVgs7HzC+mZQsli2njRUoguLF+6OgyezH4ifvFtOXhHAH8iBfZK9r4qAq2o=;20:JoxxDUhHkRntYtAiWHJkUSl1C7zyPzwcckVlzqJ7Sh5RJVGT1pjpdX7F4AS0kAHJlNWXchZm5GhqjLcjUkA7RHf0wLT+C+nsgqTdlSA/P++0vBmUMOgI+Ndg48G7pJ2dtOCgL9+ZxLj7o+xvWpJNN8ky0wVjVvDSaImgkbc+JoKRhl8QnwgBcebsKD5FfG7hrQgXbwIX2Q4nXZ/LtNUAWRFfBNF/JSXGais2XbK0PzM36yHTOkyCDfwptX0Q6cTH/lJQ2ZNdZdON9jKNWZ7ZIzlSlA7gtuEmzn5Lw+EXg06Z8jee+Szvrbyy34MPW9lEXi+Jh9ZziXgGwrw+rziLk8539BxB7KiKQHSriD3rzvOgrnsUwX6uEONKm3slDLsLFSNXU4BFSHTC98RrKbs47cvn5HNqy1dDQnz/lVeDBgBvn/m5dcwA6z5l27cr6pTM8vOVTiobHxWrPc19x7PyiMWIwGXmIFrQg9ulzBsxaj+17Y2c5jEHowYqZ1Mb57c5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5SPR01MB3386DAB00469A9549C5E5BDC2F60@DM5SPR01MB338.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5SPR01MB338;BCL:0;PCL:0;RULEID:;SRVR:DM5SPR01MB338;
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB338;4:Ljk30I1PCFMAoMjO6YdwPDeo425ViVy1aqEnVsKwcSlmEGqJ5zaAakeuCrGVkES/NajxbxJCaVhF/72p+zqWjFKlNeJR0JQBaIDMmfFmDsRb+ZHKUMyF/s16FWCA/IOB2nAbbWjkfBeAcKPtMjGVAW7ZHgzSZhFY0ycl3hoOyrbYt/RI5tfpAdDcQGstoQt/bD5Zu84kEjU/RiMzbH/brIIkQXhJ/vvqavVvt0It44IgJv7Zor+dqJu+IPtQSH2YdEB8ce5woSd5qw2qLVnWQ3iWPKSjYx1ixmMYfmIMWOoF7Pv4BD9BOIsCQ9a28aOijyNm41eGmWHBCcg2yiWjo+RhWiEpsAuz7JBP+YTaBKE=
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5SPR01MB338;23:6jPh98Xkscm0XeISzdF0HNCfklUIGfxoyKGvTPuhG?=
 =?us-ascii?Q?phYC6AIXOiGHQmKQNssDZgmr5diy/k46Q7TN1t4Yos4Rxd9UwE3Dbl1+O5J9?=
 =?us-ascii?Q?ezxh4+kBPAOqsdEAjztXGvkG29jdflu8i2LtdxWVtsVNC5Ae8Nu4g+pCMqI4?=
 =?us-ascii?Q?0KzzIWA8HfyTzHvXcvKh6tmoZ4g3seKeZBNu8HySxYo4BuLoK27TAdBA4rAC?=
 =?us-ascii?Q?fe7l5iYzDAEBbfZ2sFO9ra+BW4A5KLYaeLO4i2rHfuV59QHFrudb/N+HWYiM?=
 =?us-ascii?Q?l77U5XdRbdxbgJrs43K5gJ6WhKNE++LnYVdG0EztpD5vtuJPKUqsuramRu67?=
 =?us-ascii?Q?a63HMJ4J9w1yZbEYVwG0maryxpl+k7ZE/tuwoziKZJ8NZul6lN6rEgzkDoiL?=
 =?us-ascii?Q?EG3mtGurW7SEYdlEoEBRcK6yUYimt03Dl7s5T28GuW2lotZyNfvZGRUynZFT?=
 =?us-ascii?Q?iX4PnozZuj1jq7dMYIvrVuPPQiiZ6YwB8xbvWJQgOFbOV7XvIoMLfmxdKoHT?=
 =?us-ascii?Q?+sEab8tDAnSnXw+0lqWVJENnv/PLSu+hBX8b0X8d/M1wQhInhMmV+JkcnSTT?=
 =?us-ascii?Q?lVAOie0hudmhU+6jSYbi3VM3ZnEfMZ3v6zD32AxG4S729sYIMJmq8uQgTq+F?=
 =?us-ascii?Q?N3IRJcLCzJqwzOXOVV3MjrYtu8BkGyZj2R/ckIZEU44F5dOQINer7KJVNaCU?=
 =?us-ascii?Q?OsJPhS4qdfUUkP5K5uan9j2o1oQZghO97bzAy4qvDv3p7sfziwDXI7v4if+1?=
 =?us-ascii?Q?OS6beXTfI4GfPkgMDIEfmgYU143t0o/xT68tWS1ao3qzx3xufhOnHl4Aaw4z?=
 =?us-ascii?Q?bZt6/gLxFs0xdD6+goo4pEOgWtuI+jZMfaH+Dx2mX5WOAc6A+3RK1vTUdu1G?=
 =?us-ascii?Q?K7ndMvpfnlKTQRD0gQQwikJOpL1ET1HjiFFNeIrsDZkzhgYcMUdc3mswsuPo?=
 =?us-ascii?Q?YsTanOX9jlKA9f60f2sncPTGLda82zBMYQbV67jZnWimJ6fPpPMbGqMbOiPl?=
 =?us-ascii?Q?kHm3jdpxf5S5uqJ1SBUsaLpKU09nkaV7ZLfA2r3glkD89eWUs8xda02m0/Nw?=
 =?us-ascii?Q?QQPISKTbr7gpLUO96FK+r/jRkW0hH5UpqvFQjMn+6QdRBG1wRm4ADhxUTu/F?=
 =?us-ascii?Q?oWyoXlxcy+RtfSONv5gIOkNJLYNQWw9rUCq8Pj05R2L/5Jb/WrEltPp6JoDp?=
 =?us-ascii?Q?S9j4UcFFcz99V0PHRouQzZqIKGuwMt+N2mcgkcTmxhMO7U/ZXTsw6i/KsmEC?=
 =?us-ascii?Q?hTC4L/w/MrnWN3VW27KiAY4/indhxMQmyvrT8VH?=
X-Microsoft-Antispam-Message-Info: aomf0ZPGdK/IImudYvQ6O/EeMtqv2Z62LereGxaOlZ3MQ+EZSSYJvCAYdGs8nGEJJA0OHXAYVg9uo8whyZnyUGJMpCegidUFYNdtTSoWOxsk9JGvneIhuZg45wIbr5ilNrOz2yDt/OLQVqjqXOLKqL6hpgS64cdR8M6H+jUoeG6u7fmelJ5Cox83C2KAMRjvWzPc0SVeC/CxgN/pttamBPJ6ZIkEiwx/FWuvJD1mySXR9x7w89FtrEw4Wls6G61WPxsysuGN0GZjfpoVO/HAFyy0yj3BeJih5eTIYXIgsZkXufaaiBtEKg5Av8LcnbWheew6CjOyLEnwbZkliAoYgjCrxPAlJC/hwfV1NFy9AKY=
X-Microsoft-Exchange-Diagnostics: 1;DM5SPR01MB338;6:kD5btQvfqswmZRLRaa5KuYvolc67dFV4Zd4kiL7rbLHnmhbE/c4ztq/DMpxQ3RARmcIERVDyV8ImKtDZOCSwTEi+uEPielfH6tYt3ARzG774phOxw94HdgYN2dZQt12EB7To581YVaRXJJRWhYoX5ynvu/yC8HbEU3VOQqGLnYlsW4Gfi290B7L5siubHU6PvTE6l0g01GRMPL7jAM7pPBkdHttQzEHn1Y1gR5WXyuZFbBPx+fZ93SZrDSN8t3+BjMgIp5CRRs6cHIhEZNBVSNEcqREh2IYTMWOukbfoZNwH/NBaf3RIayLlj2NpTM1fr7DMXhjwBrYXHPABkgJBN+W1LRb883pUzIoXewyIb6GM356RkV1aUYDnuhjDmA3qSmrOWimNGpO9AduuVT0spkjVidO+qCDCbFbjWkYKBtZUV9oUuI5kWGXJIbDDdcs71DpGirFcNB6HzXktp9Rmbg==;5:fgdefdED2iFxi5C2JgiFr7ATOVcZbB8vc3kOrBXclpXQ2Fm9cZEIOL5sJ3AZAcJh+aOXXkrC+CfME6y+G9bEGCTxUAwlaowuQLdTQbu+CLZY10hkB8nRXUUvVDFXjHMLrFfFhq6WJGsYZ2qUpqyFDozosWO/jR1N43lpO5RfyqY=;7:Gp1849/CD8PwRxbToVFrZGgxEV5y7htv7gl0AFJkvE0/Bd996P2DLz7ATjZ2rhIbSM3l/uzwmCcoZ82xSubZ2G17IvSD9bhUzxEqLV8WhP3Wa5zNOC/ETs/KeHSYF6hcyjtewPZWSSa3xv12knpEysUpnsNB/Rdt+9qF0PGFh2zBPbr0FchVSNFkn+etOsc32fohOuhzMYIrcQZKiwiH5AbHgy2CnEyZfw/9t4RuOn+Uiy5uCbgqod9diN+ij4vh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 07:34:30.9231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5745d8d-4771-4065-0b0a-08d63983235a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
This patch depends on the below series of patches
https://lkml.org/lkml/2018/9/12/983
Which is got integrated into the below upstream repo.
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/tree/drivers/firmware/xilinx?h=for-next

Changes for v2:
		-Added Firmware FPGA Manager flags As suggested by
		 Moritz.
Changes for v1:
                -None.

Changes for RFC-V2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2eca8b..4a5919448198 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,50 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bitstream.
+ *		 1 - Partial Bitstream.
+ *
+ * This function provides access to pmufw. To transfer
+ * the required bitstream into PL.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value: Value to read
+ *
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +484,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130431e6..0f900b48e1be 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,8 +32,18 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/*
+ * Firmware FPGA Manager flags
+ * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ */
+#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+
+
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -89,6 +99,8 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.18.0

