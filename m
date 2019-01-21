Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A5FC619B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D9220861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2Xn8pAO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfATRZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:25:58 -0500
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:55168
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfATRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw50xk2s4ClZk9xRIA7SCxOsGwJHCnEeNvuT9mFY4tU=;
 b=2Xn8pAO73o/3te0w+xRhzu/DnvW401ZCX3B2xFCNy4F6HuyjzNvhIT8NG1tLtKeUlqC2wwMzSv+eNv0T6HpyUCWDojCf9QkHnU+N/WVtyMHc2MHC9m3XLiKtW7UHe4zmR3xqD4NCzeQtVr2Ge7tk64C3dy5oobx/bLA0smnYG6E=
Received: from SN6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:805:a2::23)
 by SN6PR02MB4336.namprd02.prod.outlook.com (2603:10b6:805:a4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.28; Sun, 20 Jan
 2019 17:25:51 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN6PR02CA0010.outlook.office365.com
 (2603:10b6:805:a2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25 via Frontend
 Transport; Sun, 20 Jan 2019 17:25:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:25:50 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47752 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGr0-0001hY-Cd; Sun, 20 Jan 2019 09:25:50 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqv-0000uM-8e; Sun, 20 Jan 2019 09:25:45 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPdm2019833;
        Sun, 20 Jan 2019 09:25:39 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqo-0000sm-Nx; Sun, 20 Jan 2019 09:25:39 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 3/6] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Mon, 21 Jan 2019 22:54:24 +0530
Message-ID: <20190121172427.20446-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121172427.20446-1-nava.manne@xilinx.com>
References: <20190121172427.20446-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(136003)(346002)(2980300002)(189003)(199004)(63266004)(305945005)(356004)(36756003)(14444005)(2201001)(26005)(6666004)(1076003)(186003)(77096007)(106466001)(426003)(47776003)(336012)(11346002)(4326008)(476003)(39060400002)(107886003)(2616005)(126002)(446003)(478600001)(486006)(2906002)(7696005)(51416003)(16586007)(316002)(8936002)(50466002)(50226002)(110136005)(54906003)(9786002)(8676002)(81156014)(48376002)(81166006)(36386004)(76176011)(106002)(107986001)(42866002)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:DawUST4zBdB5b7JNKNVGg84+nrZSJOWiBOrbjTtLzU7CsGQyVWyQ4VmMs8n5ywnpkHJFNFnbMsPZ5PnOIuKsUcsXFf/tPMvM/1mFwhQvtCR4QgLf9iQAkEh4lCtzdklL4xUTRmOkVTDTuBqhZ66J+n9mE7IGq3qga+XaD7ArUO0=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12b02ad2-12d1-4de7-f2a9-08d67efc5321
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:8OcdL5vIK7L1ldJJD0IPYHwTxV5BS568DFLGZzktAh9jbl4GYczBwIhthhfFsTdZsmhro2IkFf3HMU4TwyqsT2Q7CiVPbsdQhn8eZ86Hr4g+LyBrmM/E6IAb5stFVi4PjsdVNcosgy1RwP3iFVVi/RRhPVfG2mmAors5SJgXMiEd1hctrr5Qn2vDT9Mgapu1xpFxs5oIIuauAF1gsKGcHfDEVNTFULBttjvhxlD/+rVzavK6iWZfGelf2SQNZAlBYYCX2ZnUWM8U9RDVbaCShXNGh1LzHFvY+/ncOTaBqqz22hecVeSAsBHxfzDZEUTR1nZ7AiwNTlXHIQ6y+Hc/HUG4u0QIw+xDBK2XeBdFBel+eVT7e+tfpY2VlcAU9A5d;25:AzpIYl1utyGCzYL5wERp+EeiQ0nUDLtc333avOrVJaVbWOn74EpPgRp2oS0ySRD08GEz1iUEW3JmlZgYSWDxD/2GebzD+HUxzJEGhjteELLqUyap+FFpPoyd38znPudWZQct1PmJPHAa1nTt7UqEp32Wf4N65Mnkn8PxaDgQ27DXCA5fU+lQtTj9iAFFF9VKx27w5UdI4V/wnbjtg9OQfipfqC7N6C+s2ksjiisKzwzVHfvtuLV3xOBi1BpGNHyS1r6zsOfBmhgCgP9G/muJiVJReEbmYwOr7ipPlNGiniKr0mGHpyo/CIjPrOFNv0NLENCvZcgMVsEdniXcpGxdBg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:bzR4Vbqm8W9HOcj6cA6tKQiOJfiyLw1Sdu/pF3D0gh6Egs+Au9EEPzFcZPMRlc2uyP+58WHMbrDsaCOQtQP+7rxIs5OFI3PADAj33am4/sB/ejp33zPKvjqoEmRzhahGTjhmBbxA+v5qzWxUWv6wKfWVYW5BAT4rPYlmHQWVB2KYQZuAg3DRSfQ1rwPwCXKDIS4ZsEuqvHg3rWPAA2VpnWO5B06mP7RInGooHpuQaek=;20:hLJR2PLsiMhXudlw8TtAshp43GLb742KEP48Sb+J7nlax6+0J4OYKP2H7co/KZ0EmzMS+d/ULZ7lt8N4svvZLxTMzOP+J9ZlHT4WVMBW50SS//gc/ZagG8HWWSTVGeFUafI5xriOacyK/g1X0D4a2Are09FAFQwz8/cCtw48frbNVeD34ISAswX0IN3WTAZo+yDiEjvfgb7+TLZ/ZbGHWPLuXJ1my5ywTR8Vq134GV/q6S0aKEV4PXVoejrZyk+4TZyzpJMSLYTnV7wxNwS/p9zOnLmJl+JmhIXI6Mzoic/baIWK3s9OqMFg8BtJ9gL6b9AfAuy7Ginzl6FoeLOgkRBZ68kE730YevgctVeUji2k/pGe8SAtU78ZzQBadvp/By0gUhoB/jWl0BeOzRqwSFikPhS+cCFmsIIJDhqUBNb5JJQGEtyBfTNNBQs4pS0OxK4G9hPmfnFTMn3A7PnapQv8+cXGzuoeEmlSWbq2BndNU0TCeyawld+OnDCR3FTD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB43369BC7CBB44B978ABC5F94C29E0@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:Afn1pCb5sSuZO21+ILoRvJrprloB9BJE/RosK931QDhfFP6IEMJV6OcYk6Y+O++xnpCcQgxZqkiy7lDKav+G8adeDBV4QGKkg/dT+W78dtqxJWBJqBRAZTti5D2Ht8AYEdvUoQ8pMlZBQsMV+xucOUbQ/MiCh1lTwxXbqdKzdSU8ufedDfmS0L8gyEykeky+7o7BvN1h7v2iFfJTX7pCgRgPvRZNCtCtvP8wD5bXsfxU3DLFKc+7LRzSi+hVVN3tZsRhSfrLK/xgsKKiG91hmEm8aoUs0BtVobxv1UAPMlPbaeRk7QQTAXTkR5caXPwj
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:ODoeGzFaid0RPZwJqzV+cHyb1eP3CPjd4HWKcwyfS?=
 =?us-ascii?Q?4RP4zIOdOtwqhoO3n+ob5O8+dLoQvhEyEymlthSk1xyOp+1kkGlDLX9TRFkM?=
 =?us-ascii?Q?5gdONOSWZvZss8ObiZX60ca8u5Q30QBLRj0J/J9wNPDXnuomsZJpHSx5oAcu?=
 =?us-ascii?Q?aPMtpH5STrFsZmbJ6MstfwInk8ZwBQ5gqItkQcyUDeTlc/b1cjztzs23zLMe?=
 =?us-ascii?Q?6vHscnLV8PrkO/DoxXZdU86wzg0V7k9/d4c9xiOcBiKZLFnXnEplY7iUZETg?=
 =?us-ascii?Q?bKFmHbak0p4/DAoqxT5oOimy+1vxV7Nj6QUSDUCKuQy8t4S0AMoXUrjLqq9A?=
 =?us-ascii?Q?Nb7fHbhYPq8NGFc0eZ/1eiu9Q0phXBfu/Q56Dq2ZJqlSNHZZulQwJ+Bo0Bay?=
 =?us-ascii?Q?bGtYN4hWfMu3EXV96RmRvSNPTCQDhr2k6rD0R0xlr92okAt+9WIZk+tCZ4FS?=
 =?us-ascii?Q?PTrK9ftzxTUZOfu6FAiXUDU8ILoVw5yh3be5EwehDWJGv1kzMDp1ul1vdBlx?=
 =?us-ascii?Q?UyySUHcN2ZP3e1EABQjJ3m1iVx32+9bDruHSt83ckby3QsvVw6J22bXww6Mw?=
 =?us-ascii?Q?sMAGW4Uen+n6WAogLhz5rcYjXvRVJoueo8MViywkkDnffm9aucdX22y6OmfX?=
 =?us-ascii?Q?btY2OAYsRa7Ad/Lyz7hgQensLJ6uQDELNmzVcacHg4Ktb4xpLQ23pntqem9P?=
 =?us-ascii?Q?sR9Z0Wv9D7CpFXVJfIUn7geoi9xlC6mVCSIlxexsHHRLntmxMf1T7XFC1vCW?=
 =?us-ascii?Q?npNuQvRCZDHEmAno6AD8vnX7gExmv4H7BMtiGxown45D1NxBnQ1E+gg4EY3Y?=
 =?us-ascii?Q?yyXzMXtgAqkM0IXy5hSzrWp60LxiW3qJHynXxtpMcuZvMr6pQtc+LA5UQ0rD?=
 =?us-ascii?Q?UvscBxpNC9JbH4EB0MEE8Yeu1MWLW7h7lVQWFiQaNThWo+axVOCWbhM5MMJl?=
 =?us-ascii?Q?xxl/R/2G6jlCVJCrzdFreaM3iCn3ztLeMiEiM5ZlDWrqTa7GvrHXHBS4eFe2?=
 =?us-ascii?Q?ZSI6m9E80C1um2zfyoO3QpWv4sj4M8izUGDO/IOFmjOStZ1gD/Xd7DVSktuy?=
 =?us-ascii?Q?h2IF79Dht+UhfVX1DXr/D1lwY9dCsVBlZqquHJ8ALbOYWfHZi0Rrg2YGfTOJ?=
 =?us-ascii?Q?kuZyMunC6PzvkfTieadJiw2BB3Ij97LSg2jy2DVNPcXbLK/0MK8ngAj5C+vJ?=
 =?us-ascii?Q?yMr7yXuhlgoy2De9bsP5nCnFUeaudCqTa0aziT23RrJVxN5npGuzCqYAw=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aVydZWrrb31PhX2iQVgZ9Swh+oenryecKw6GbKhqaU2or1QW4/O8UhqFlXbpLp41nKR1gAIBRGLkIDyudSDAcTdsVUXnPiCXXYmSJi1dgs8/KJwLtzprlt78e85CvO28Ax4sFO9TdP4ePvrDPX5ZDmx/NkXZwqxbnG5QHHDnYVvQp9fKCsV3iGpnz0BpY0Dqd7YvcqEouX5px3hd5sO6F/GKpkDMNfWWTmcoTJFZzfLSd+ae3ilz2cBZ4j0sUaTqiNrp6mAfsoxqA2Q0HUIVEiAPMj0OoIJv1r3+F7V+vbfw/doQH3jRBEHeQ3xNz42Oqq6jOjzWbxjDUe0IXgh4qgflWUVRX4j4f7vNNJNwYreHXEY+KVya6C9wM83NIFACUJZs2Qq8gQgtkWU8vXCnCCJEUQsVsnoTy41h8Y2/XYg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:xbfq88lmGLQhPFb8FVkLeKJ4s+3l4Zv+MLTRFfVg7uVbc4dfkdq+foRJBwurCvIQJXTnPux885Z/AdoDbT/597vjhBnDUvgX7Et1avXTlx9/HpUj/mUfonIIFWx36zZ+UPu1242VMRunCMECbs8rSL/Jk6mqLvMsNspZ2F7AU7yD7mOMHBtmdWCppwOW8UhqqMZZo9RhPYT1RiKams0mTBnwyQjVmByWLfgMzfRTLTEZBN6QoezEEr3n7p/9IYTPkQwPPATcauy8Q+4uRvLahaK2L9teCj13Kr13rH+8V9wL78lZNlV2/BxOLUFqWDftlWN6IJyO6XvKPHtXXXt2JgMZN8KWEUkUAH4JkovUP/YACKZuIvISGtz+7evwTWBVtAFwEUoWb/eJQWzCFzgZzXofVreenoTowpNk1t1A+npMPZLJh65WDgx2LL8xKfLanq3pp069KbqRfZY1TYNkLg==;5:NETa7wu8xV6pR5ANCsT4jljyA9rV/Q90ceuvMl+eL0GpKZAl+0dY1DZnJdFRo9hxdFNlIeE5om0Uakkz2BVMjqwSPnlA3E+nuSWmOAU5IU2fTvHRPlNCSTL/oAt2vrdoLSQDBlKcbzLW6C2zmcPPNTxlqcW974N6aV3rM1uo8ASMgRAGZXaRSg0iIZIvpBuO1HMcgppaBEwAgPDspM2jhw==;7:dlgGfx84AiJ8uZ9p461Hoba0C8nCQFTx3j4Ay8GJuIxf9HZ3d1F4uE98PxjbBSOEI7zjsw2eOK883PKM7t46K7QSuurIrSpB2pRr1nePvd5+8oGZM2956wuZx8i4abZNjz05BOmvVeMOaLu1qgxc5Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:25:50.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b02ad2-12d1-4de7-f2a9-08d67efc5321
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
Changes for v3:
		-Moved reset outputs definitions info into
		 a header file(xlnx-zynqmp-resets.h).

 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 ++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
new file mode 100644
index 000000000000..27a45fe5ecf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -0,0 +1,52 @@
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_reset: reset-controller {
+			compatible = "xlnx,zynqmp-reset";
+			#reset-cells = <1>;
+		};
+	};
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+Device nodes that need access to reset lines should
+specify them as a reset phandle in their corresponding node as
+specified in reset.txt.
+
+For list of all valid reset indicies see
+<dt-bindings/reset/xlnx-zynqmp-resets.h>
+
+Example:
+
+serdes: zynqmp_phy@fd400000 {
+	...
+
+	resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+	reset-names = "sata_rst";
+
+	...
+};
diff --git a/include/dt-bindings/reset/xlnx-zynqmp-resets.h b/include/dt-bindings/reset/xlnx-zynqmp-resets.h
new file mode 100644
index 000000000000..e295fd5d824e
--- /dev/null
+++ b/include/dt-bindings/reset/xlnx-zynqmp-resets.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_RESETS_H
+#define _DT_BINDINGS_ZYNQMP_RESETS_H
+
+#define		ZYNQMP_RESET_PCIE_CFG		0
+#define		ZYNQMP_RESET_PCIE_BRIDGE	1
+#define		ZYNQMP_RESET_PCIE_CTRL		2
+#define		ZYNQMP_RESET_DP			3
+#define		ZYNQMP_RESET_SWDT_CRF		4
+#define		ZYNQMP_RESET_AFI_FM5		5
+#define		ZYNQMP_RESET_AFI_FM4		6
+#define		ZYNQMP_RESET_AFI_FM3		7
+#define		ZYNQMP_RESET_AFI_FM2		8
+#define		ZYNQMP_RESET_AFI_FM1		9
+#define		ZYNQMP_RESET_AFI_FM0		10
+#define		ZYNQMP_RESET_GDMA		11
+#define		ZYNQMP_RESET_GPU_PP1		12
+#define		ZYNQMP_RESET_GPU_PP0		13
+#define		ZYNQMP_RESET_GPU		14
+#define		ZYNQMP_RESET_GT			15
+#define		ZYNQMP_RESET_SATA		16
+#define		ZYNQMP_RESET_ACPU3_PWRON	17
+#define		ZYNQMP_RESET_ACPU2_PWRON	18
+#define		ZYNQMP_RESET_ACPU1_PWRON	19
+#define		ZYNQMP_RESET_ACPU0_PWRON	20
+#define		ZYNQMP_RESET_APU_L2		21
+#define		ZYNQMP_RESET_ACPU3		22
+#define		ZYNQMP_RESET_ACPU2		23
+#define		ZYNQMP_RESET_ACPU1		24
+#define		ZYNQMP_RESET_ACPU0		25
+#define		ZYNQMP_RESET_DDR		26
+#define		ZYNQMP_RESET_APM_FPD		27
+#define		ZYNQMP_RESET_SOFT		28
+#define		ZYNQMP_RESET_GEM0		29
+#define		ZYNQMP_RESET_GEM1		30
+#define		ZYNQMP_RESET_GEM2		31
+#define		ZYNQMP_RESET_GEM3		32
+#define		ZYNQMP_RESET_QSPI		33
+#define		ZYNQMP_RESET_UART0		34
+#define		ZYNQMP_RESET_UART1		35
+#define		ZYNQMP_RESET_SPI0		36
+#define		ZYNQMP_RESET_SPI1		37
+#define		ZYNQMP_RESET_SDIO0		38
+#define		ZYNQMP_RESET_SDIO1		39
+#define		ZYNQMP_RESET_CAN0		40
+#define		ZYNQMP_RESET_CAN1		41
+#define		ZYNQMP_RESET_I2C0		42
+#define		ZYNQMP_RESET_I2C1		43
+#define		ZYNQMP_RESET_TTC0		44
+#define		ZYNQMP_RESET_TTC1		45
+#define		ZYNQMP_RESET_TTC2		46
+#define		ZYNQMP_RESET_TTC3		47
+#define		ZYNQMP_RESET_SWDT_CRL		48
+#define		ZYNQMP_RESET_NAND		49
+#define		ZYNQMP_RESET_ADMA		50
+#define		ZYNQMP_RESET_GPIO		51
+#define		ZYNQMP_RESET_IOU_CC		52
+#define		ZYNQMP_RESET_TIMESTAMP		53
+#define		ZYNQMP_RESET_RPU_R50		54
+#define		ZYNQMP_RESET_RPU_R51		55
+#define		ZYNQMP_RESET_RPU_AMBA		56
+#define		ZYNQMP_RESET_OCM		57
+#define		ZYNQMP_RESET_RPU_PGE		58
+#define		ZYNQMP_RESET_USB0_CORERESET	59
+#define		ZYNQMP_RESET_USB1_CORERESET	60
+#define		ZYNQMP_RESET_USB0_HIBERRESET	61
+#define		ZYNQMP_RESET_USB1_HIBERRESET	62
+#define		ZYNQMP_RESET_USB0_APB		63
+#define		ZYNQMP_RESET_USB1_APB		64
+#define		ZYNQMP_RESET_IPI		65
+#define		ZYNQMP_RESET_APM_LPD		66
+#define		ZYNQMP_RESET_RTC		67
+#define		ZYNQMP_RESET_SYSMON		68
+#define		ZYNQMP_RESET_AFI_FM6		69
+#define		ZYNQMP_RESET_LPD_SWDT		70
+#define		ZYNQMP_RESET_FPD		71
+#define		ZYNQMP_RESET_RPU_DBG1		72
+#define		ZYNQMP_RESET_RPU_DBG0		73
+#define		ZYNQMP_RESET_DBG_LPD		74
+#define		ZYNQMP_RESET_DBG_FPD		75
+#define		ZYNQMP_RESET_APLL		76
+#define		ZYNQMP_RESET_DPLL		77
+#define		ZYNQMP_RESET_VPLL		78
+#define		ZYNQMP_RESET_IOPLL		79
+#define		ZYNQMP_RESET_RPLL		80
+#define		ZYNQMP_RESET_GPO3_PL_0		81
+#define		ZYNQMP_RESET_GPO3_PL_1		82
+#define		ZYNQMP_RESET_GPO3_PL_2		83
+#define		ZYNQMP_RESET_GPO3_PL_3		84
+#define		ZYNQMP_RESET_GPO3_PL_4		85
+#define		ZYNQMP_RESET_GPO3_PL_5		86
+#define		ZYNQMP_RESET_GPO3_PL_6		87
+#define		ZYNQMP_RESET_GPO3_PL_7		88
+#define		ZYNQMP_RESET_GPO3_PL_8		89
+#define		ZYNQMP_RESET_GPO3_PL_9		90
+#define		ZYNQMP_RESET_GPO3_PL_10		91
+#define		ZYNQMP_RESET_GPO3_PL_11		92
+#define		ZYNQMP_RESET_GPO3_PL_12		93
+#define		ZYNQMP_RESET_GPO3_PL_13		94
+#define		ZYNQMP_RESET_GPO3_PL_14		95
+#define		ZYNQMP_RESET_GPO3_PL_15		96
+#define		ZYNQMP_RESET_GPO3_PL_16		97
+#define		ZYNQMP_RESET_GPO3_PL_17		98
+#define		ZYNQMP_RESET_GPO3_PL_18		99
+#define		ZYNQMP_RESET_GPO3_PL_19		100
+#define		ZNQMP_RESET_GPO3_PL_20		101
+#define		ZYNQMP_RESET_GPO3_PL_21		102
+#define		ZYNQMP_RESET_GPO3_PL_22		103
+#define		ZYNQMP_RESET_GPO3_PL_23		104
+#define		ZYNQMP_RESET_GPO3_PL_24		105
+#define		ZYNQMP_RESET_GPO3_PL_25		106
+#define		ZYNQMP_RESET_GPO3_PL_26		107
+#define		ZYNQMP_RESET_GPO3_PL_27		108
+#define		ZYNQMP_RESET_GPO3_PL_28		109
+#define		ZYNQMP_RESET_GPO3_PL_29		110
+#define		ZYNQMP_RESET_GPO3_PL_30		111
+#define		ZYNQMP_RESET_GPO3_PL_31		112
+#define		ZYNQMP_RESET_RPU_LS		113
+#define		ZYNQMP_RESET_PS_ONLY		114
+#define		ZYNQMP_RESET_PL			115
+#define		ZYNQMP_RESET_PS_PL0		116
+#define		ZYNQMP_RESET_PS_PL1		117
+#define		ZYNQMP_RESET_PS_PL2		118
+#define		ZYNQMP_RESET_PS_PL3		119
+
+#endif
-- 
2.18.0

