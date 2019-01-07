Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA882085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iv0vO/jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfAGJDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:03:20 -0500
Received: from mail-eopbgr790040.outbound.protection.outlook.com ([40.107.79.40]:42496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbfAGJDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csRD8EQSJz3+yNRBijj1r8Dzg2a0PmBZw1kVu/QumUA=;
 b=iv0vO/jAgyklTEdDv27Uzc66HQ7Q+/LvdJuRtYkv63MUgBYJpRV+wipWY+cPEr3XI/BFiJUU3ucGTI/RZJ9ftIsc2Occd7gJak4k0WpaqKYT3O1DiTBZZzBDlVMzJvih3OnMvOXLQDjnZnu6EXCjFhF0oll1WtwQizE7V92K59s=
Received: from CY4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:903:18::24)
 by BYAPR02MB4328.namprd02.prod.outlook.com (2603:10b6:a03:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Mon, 7 Jan
 2019 09:03:11 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR02CA0014.outlook.office365.com
 (2603:10b6:903:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Mon, 7 Jan 2019 09:03:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 7 Jan 2019 09:03:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoP-0000nF-Jp; Mon, 07 Jan 2019 01:03:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoK-0001lU-Ep; Mon, 07 Jan 2019 01:03:04 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ggQoF-0001iz-3w; Mon, 07 Jan 2019 01:02:59 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 47518800A4; Mon,  7 Jan 2019 14:32:58 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 0/3] Add Xilinx's ZynqMP SHA3 driver support
Date:   Mon, 7 Jan 2019 14:32:53 +0530
Message-ID: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(199004)(189003)(476003)(486006)(4326008)(63266004)(103686004)(126002)(6266002)(478600001)(44832011)(50466002)(90966002)(186003)(51416003)(48376002)(305945005)(8676002)(52956003)(2616005)(81156014)(110136005)(217873002)(50226002)(426003)(106002)(2201001)(5660300001)(26005)(2906002)(316002)(336012)(36756003)(36386004)(106466001)(42186006)(16586007)(8936002)(81166006)(54906003)(356004)(107886003)(6666004)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4328;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT009;1:tAYs9R4BunkUetq5DK7hIPNwB+sYs3N7ojJ1wat2KDaZ+VvxhDtLvrfssghSCrjvIFkQeBgYHiak7Dp44lxvKlFSC6MgxP1KIjOjf+CGq/9wsWHeueMvohEt5Gt2Y5ia
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ae5fb6-f5e8-4bef-0a69-08d6747ef274
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;3:+iRC3LNiFOO58M9UOEHV4tMvgb0UdWJo8dL/iUOEOfn8dGQ3rc6D7BRAM15aG3rdclTFzRc9x/zMwZBYv5XOwhkgI52V9c1JCGCULG9nqDQ6GZFUR6DBfdRl1hxaV/IOvuq5rpRAAITs+cSk1uzUnpj2beYKNz1tZd009cqKX0AdacB2a2266/pWEC8OFvtS4I3zCtyy2+jYPXx/FMwgeTJrgKz9yDHs7EgQnX8Pzb07k3GeysjCwACN4KRJU+wKV094nubEqc7gbopkfTRLl+RzXG09mZfljgg0Qwtm7MxrX6iLM5l29sMiBIV2+ruOqTO6OIIOPw6pDL82CzA17hVicD+z2324rjzsN7lUmQP3wSIDzPjRetlv1zu/nv6f;25:fHkPAqRb4AJFdGJuNQrD/6xLkYGwQSivcR2T66tGiG5O+4+fob0b+lsgLSSwWbVihUvkqGVAowFEoXcalP7cYVb+w36zzAfhlzuNzSfcfosyIWuFVc60bru60c7xuPs4GjTC7k+p5074a3B9GfPsOz4o5K9jIIkOctEjfx1skWqBCg0/VV/foHB7nASU7RdZhe5Dd1xM9pyvonzj3/O2vuLpcBYfYZFUbdOU+p1dmF+OIdTESqquwGkZl/fMJZOe0ad8igArgyOYT9nXUxc8hu7PgPbbJ0Zxb3ksMy/uNr2hKMvJDdG1jMfZazO/qS69thz4pWY7Ce4gkirLny4ONw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4328:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;31:xdumdMmGXx6GZVST30Y7rTDlrbBg5WDL0Z9XiLwshP0u//n2v96CWDVLSRmxKbIboOYpJdxus8y6GhqaArtBiKlLe8XWNgAXb6XS169Gt1JSCi1ei4WH2ohZFNOP4hHmpsP/lctIDgJGYT3crKde7aftFraTYcDKBeFgAi1oBPnVTHeylDMbreJpNdpeTXlL0Kb3g4iN4HT9tNPdvnR7aMe/VuZqvTIl6wE2lSz6nfw=;20:0isQf4r/N2N/jPl6HbAPx+uOnEFcbZbR99+7l8b59/CT0XKbZGbRJNoN9knEL5tQXOfvTP82OT8TeiPEZZj4XnFof6SSKaczAVZ/bggg4C1EHE4sKzdO5T58ZT5p+Y+K3HIesa1MSanYp1beRH+Jh0YxTOffMc0oiGFLEajBXPsxSrOP5ATVud8mU0Ig0fSgdmKstGxPijARq2CUW8iVY+F8Pbd8dulsXUfD86MUEfDEXSvQNqP5hgY74uU0YSZ/Nn4Ypjjt9g7h+J8cayZRwOF5aCt+9E+HGJ857Hqgf8otftvwbWXOytZgbVqwfPtWbvjsvwqHvQPR6mVAVyi2PlHA293wMVmuhMA9gWN4CubYhtQYSesv8bbzxI95fa8fXE6X/Kv5C+wPD4+PXRorYt5CvK25Sub2DTTOB+iUQoADkcfamgs1/mSncgmUtG56MkvZ3+I4rr4lIjUMsipS3xW8WFOFQjKBaJqkfrGHPFD8ieNdl7q8/gSYn/PLdAZH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43282FBD31F2248D7980155CAF890@BYAPR02MB4328.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;4:QozVdzdlWPgko72IGyLjZ6G+XMrZ3bArf9fpuCyEapsJTWhPeySurWczRqXXqRcSBAaSEDTLa/kU+scum3SITI1VmZMWhRAYHWhCEWfX6uzJ8ZeLcCsUPS7xAbLaIYgl12HWuBDcFAI9SLbFnfmeuEOijgeDJJd0xt9r136RK+ch4rkgEj84zluo8ouvi6KE4sAk9+ffBGZRxg2vcB7GWCnDV1WoywMo/7rhWnDlPsrQKHYDHQxCr2OJocrDW023q01k6o7zIdxzxnOJqa3Hknje1ImrWeGP7RurgvSWV4wn9bxjBe/4Gygk4xW+uucZ
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4328;23:7/h62ziBtrU0RJnEQZ/xcBxfyXl6aQ2xvLB80EHHS?=
 =?us-ascii?Q?E4PWSZT9KA2MYK48nE/44TmxlbGDORvFgPKiVJbB3M/cBbBouwu2IF/yAGGr?=
 =?us-ascii?Q?loNIhnm8yZsF1MHLD2MdHHsQD+lStkOv32Kw6jQttIvCtBQTbMJakVQ6Gi7d?=
 =?us-ascii?Q?zCKmWwIOKihQ5vJWwp4E7q9+XRMdWBcIE45JqDFodmnLEbSNi0y1X1kmBerU?=
 =?us-ascii?Q?dSeV518v3DMoRDAUgxESbK4+DU+IpAVSyfdromNNHvh6tphCRZmFCEnJDa5O?=
 =?us-ascii?Q?P8y7V4Yh/rVU0hMN/0XB+zBg/HQmW8MIUux4vwMXml0OWgCuEKCeGTOdQKz2?=
 =?us-ascii?Q?n2l6wTjb93m8UZk/3BT85gSPr6hv4hO86G+N+C+YR52lgFzordOHN3blHTmn?=
 =?us-ascii?Q?ztRx4wooJbKQj3TKcH01Aa+bcw+qqKPu9IBRmdjBGKqorRulbsnRm1cjiNiQ?=
 =?us-ascii?Q?Fk+LJmeGe/BjyEz1PzXm6dfdlBwDvoWNXoolUPR/11XwqWZTqiipWtu0c8mv?=
 =?us-ascii?Q?GAsm2wiilWoaiB3ckD64hnKfzQhnj93JTEj4HisOGARY/EkpjwDyps2S7XqO?=
 =?us-ascii?Q?mPHGgWomfDBQdkM6XTEsrNPN4zFPdfnXmAdQE7HAwKZikYcmhZ3mPj/9kn5J?=
 =?us-ascii?Q?IYJawU3WK38mNXTZVxhGZrns7HimJKr/0j4Afs4/1GbK/VShT0hwaQb7tV1l?=
 =?us-ascii?Q?L8vSkhi8XOpV7ogdcGHjgXaazOVXEJEktvRIM4FwBrqZ7Fu2EJNS6kvX44Xi?=
 =?us-ascii?Q?eKv7aQuNbqiNpDa+uB/mDltFxE/SGWEZwDFqjG1NmY98WXKxKkjD3j0iwjbU?=
 =?us-ascii?Q?ZDkxVdIbfcreWFi2Z4yyK+eA7Q+RNulZ4/ZjzokqYofmQ1KMd0rdyPb65BCM?=
 =?us-ascii?Q?1ZpCEOsdLdebjVKuQZa/nf8mYyYobwlXVuinaerMpqpewyZ2SFTqG+RV2OZr?=
 =?us-ascii?Q?MW4SdMv2ZHbYEnD2rOuo28GgNxV9PLMucCqqq/Tb2uZ/7ddOOWqvtaazJZow?=
 =?us-ascii?Q?zS0H5eHCAl/hh1MGOB7Kax+tYQHFwmU5tF7HOXFj4vY37p6QjGcZznC/Q8ee?=
 =?us-ascii?Q?KMZmw/lyy28MCO1Fhzvq11mwQr9D713CrcApjrcIOit2PaYZX05r28s4w2Ih?=
 =?us-ascii?Q?+TsTJKTNqNBcDoSSKlfV/QXvnIyaBPW?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: v8QBW0r8pbhLg5Xsql3XRGuIUQNbKOMFb/aczt7kGz0u1jaaUlRtWyRJwU2OxNoorZvCG/ATk+tkPDUqqQnr76/1zTER5Lk7Dk4jz5eaGdeo+DIbW+Pp/gDPjdumvXKESqX3DajlQzad+9kgZQS0gRtjg16xVEAoRrmkBX24OKrh25rpSS+c47sDRvA5vqnwJ9qDKvkxpzCvW9FaMF7vfdCaWy9/lQ8sGqy/Qzb3v7vHX27Pv6ukPEcYl8J06l2vym3pmhM7Bv/uPP0VkgZ9FzTeNggcLP1kBKDcNvX12SeBNwlRmtK1hFYwkv5au4i3
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;6:RbDTlYBkq5r1MTp4P/ncbxP6JJrDknrhYuy0bVqj+WBYFxxfkXBKuyLXkzwAggFqTGuGZLEJRyIqiq7YQk5RDsM0Cck60xVlPqyetLPN3Vrmcv0X2K0f5+vgnayzJ06F4hVssrZXgC/8oWibbCUr2ObVi6LfNFOTXW94380XxXmWefxQWb+NO6ZZ2sRZ76OBEVnx2BBiprb19Wzay5DvDUtWseyfxTo5UMwUW28uOFDdhChEL9phRsQlBOlBHvQeomRWdXWLG2SD69bA2DtQwIRaj711X8leA9nyieNGsxciCBCVMCOY9fHjehKhcIoBudg4aHepgLXzNg/aa2yszj+IgR4jnHIIN20vxo0bY2j3OZJ2MYsukUlT1gPm84lyzpXAQDEl4mLpnsIwgyM5HVa9j474+FlUw3zzrGNK1Z1sqBYJu1oz0lnh4ZC7bAkBls+FPymELO/xqMNa+wED6g==;5:hVQBKPyolbWt7Szwfd1YfYPTGnH2ozIMNm04eWz4xeXjK0fBmmG6Lelu6d0JuSVMlP6DsMcG+ZLIz4+zLE3gZPmcKfvZkZdLGwYT7ZLqgJ+3nqvU+jHhwI8I8/NJy8S84TLCNPMgiV6be3BvpXnO5OqqGVSPPh4zU4IMcHlyE5VD/PNYWOShyck265lToecaYC5pG9EQ6AEYcme8TOET4A==;7:VOfA9efd7evNFMa4gxD0BIqnU03vTETaah0DDxwcPUdnN84x6K3G4htCRBN30FUIw0ldhKdUGtgOsUkryTenBJOKPZns7fhcbaQGW45bOyKvo4GT0nxY1mxC950uZ4ZhuUy/ysPpmjUnc4IWT3M5JA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 09:03:09.9865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ae5fb6-f5e8-4bef-0a69-08d6747ef274
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for 
- dt-binding docs for Xilinx ZynqMP SHA3 driver
- Adds Xilinx ZynqMP driver for SHA3 Algorithm
- Adds device tree node for ZynqMP SHA3 driver

Kalyani Akula (3):
  dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
  crypto: Add Xilinx SHA3 driver
  ARM64: zynqmp: Add Xilinix SHA-384 node.

 .../devicetree/bindings/crypto/zynqmp-sha.txt      |   12 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    4 +
 drivers/crypto/Kconfig                             |   10 +
 drivers/crypto/Makefile                            |    1 +
 drivers/crypto/zynqmp-sha.c                        |  303 ++++++++++++++++++++
 5 files changed, 330 insertions(+), 0 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/crypto/zynqmp-sha.txt
 create mode 100755 drivers/crypto/zynqmp-sha.c

