Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FF2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7805222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Me35s4gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393391AbfBNADd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:03:33 -0500
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:46000
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732400AbfBNADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP8tdw2S9QumZGCJScqE8f4jhuqe5clIoQFMo9pTpms=;
 b=Me35s4gpgLHSQeHF0gDNjBZkMehLT3/z01LI9J7pqLrhp4P7IT7F6+Vlaw9e+Mhqvi6cyKjJF2kI0Yx4Azlc7GsJaIUFLYpQIwp2STNsyMcjpxRrj3eTQTDXhSbQ3NfVKOXwA8KX0WQQvpePwBxPj65hTsCG1FIAS8II2H75/Q8=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by SN6PR02MB5023.namprd02.prod.outlook.com (2603:10b6:805:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 00:03:25 +0000
Received: from BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.19 via Frontend
 Transport; Thu, 14 Feb 2019 00:03:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; android.com; dkim=none (message not signed)
 header.d=none;android.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT024.mail.protection.outlook.com (10.152.77.62) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 14 Feb 2019 00:03:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49088 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1gu4Uu-00080W-Bl; Wed, 13 Feb 2019 16:03:24 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1gu4Up-0001Js-58; Wed, 13 Feb 2019 16:03:19 -0800
Received: from [172.19.2.244] (helo=xsjhyunkubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyunk@smtp.xilinx.com>)
        id 1gu4Uo-0001JP-H3; Wed, 13 Feb 2019 16:03:18 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
        id 44A762C7416; Wed, 13 Feb 2019 16:02:16 -0800 (PST)
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Martijn Coenen <maco@android.com>, Wendy Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>
Subject: [PATCH 1/1] staging: android: ion: Add the GPL exception for syscalls
Date:   Wed, 13 Feb 2019 16:01:46 -0800
Message-ID: <1550102506-24731-2-git-send-email-hyun.kwon@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550102506-24731-1-git-send-email-hyun.kwon@xilinx.com>
References: <1550102506-24731-1-git-send-email-hyun.kwon@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(189003)(199004)(478600001)(2906002)(6666004)(6266002)(356004)(107886003)(106466001)(50226002)(4744005)(4326008)(36756003)(63266004)(103686004)(47776003)(90966002)(52956003)(8936002)(8676002)(81156014)(2201001)(76176011)(7416002)(51416003)(81166006)(126002)(26005)(11346002)(186003)(446003)(336012)(2616005)(476003)(44832011)(426003)(305945005)(110136005)(42186006)(316002)(54906003)(16586007)(14444005)(106002)(50466002)(48376002)(486006)(921003)(107986001)(5001870100001)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5023;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT024;1:uLpWcWQBYSPHv1xUFgAL0QPm1vr5Y0ajeAUqoXiu0wEJw6a5QiO7SXoelpD0+CxZk9ABvwZ97Ow61EYYC9R4SNNj5MFgw6QIXJ+euADfcovnHT5MeUbrH8I6cm55ikexkQ+EFSDWeufze2sNXyTNwHI3O9xK2yKuUErAp1CF8uU=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fbb77b4-0801-4199-9e05-08d6920fd722
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB5023;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5023:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5023;20:PcM8t5EvXNu/kcrALGE1fc3s7Wu83dE30zzbzrcZUFN/gmO57vNUsxL8LEZd8WHQDeguWW3LHE660CT3HdX1u6njYbG0c3daXfMMQraL5uFcMl1/EuaWDfYO965t9ImpSm48bad9JMVc2TkioI4GUCqd2to+1qDuFwxCQUK3qlZZuOknRs0i+yXHnddMQX41NjwmzUo/CMHDWzCzboLA12deQTJKwISyBkstgFWmUpu5CmBxvPkLwomfVA3oCsapsyOijgj/2XO9Z3vmGA36ONn/enFs2kXkYPIbuhK1mTiDVOcOCNF3zqj90Vpjo4H2Ivkvzn/+CIVcLX9r+7RFknfAwW6H7C27Lu/a9eRAkIu+jsPGMlvcO3B80hhCy3JsEZ6dyaJkNoZneZn3E/GBIF7K962VQHELdbyYtISMfAmJaGLwHXl7Q/LC2lwtyh4ZPV/FCKSgI2TWwE4iB5xT+5GPOhK3XytEuDvpR3XFfwiwC+/RPjzv5acTDA+FHxm4
X-Microsoft-Antispam-PRVS: <SN6PR02MB50236E04DC38AE35D4316AB2D6670@SN6PR02MB5023.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5023;23:zlpla7CSy9B+5A/hXUubr/T85aLg2CtD/XQHyoqrH?=
 =?us-ascii?Q?3SnwpV4aZcfAUkXSH46sUQ8CtThK2pi7H7hVLionw/P/3t/eUUvfZJkpdoR3?=
 =?us-ascii?Q?KlcyUX2aVHtKqaLFbBJGbQjxplg2W/R7stl37tfmLaSO1tPA1jjQEoKKbf24?=
 =?us-ascii?Q?EbX63vf7MEXHPDNwSfaIbztV7F/Evwoo9lAIgiZzo7j/sT6Rgu1PGYkF3/dK?=
 =?us-ascii?Q?NBX1qyZ/BuJY87DnkX0QTZGgQNsFWPm6K3IBM0TiXJBLlzYVuvtirzmiqpTU?=
 =?us-ascii?Q?jpWhHRXveV7spZzYkZVFbKTWQ7HuOfq+FUFjUnGFLNFFoRVXzz4BD8KwlAtr?=
 =?us-ascii?Q?FxmPnUIt+oEShaii/2ZFwPVxRY9kZpmAXZ0HgMiZATYPQgVZjbCtI7k8QuMC?=
 =?us-ascii?Q?9dNvB+pK/rSiZKN11oCPtdUpQMq77x7x6cSUK7pI3xC95YMzCirsb11oQAOv?=
 =?us-ascii?Q?tPeaSl0J/P0BleRPcYQj+IW4nTyQK9kD5EWOdmDFzRn950FPeVyB2GFNpbyn?=
 =?us-ascii?Q?pTkozBzk26qT+BzD4eK7IMf8JMDQMCeDFNsEsNiM51OrGXfabNlbiSMU5+c+?=
 =?us-ascii?Q?/wEy3AxA4GAeoglI0IJPOc1k07LNbHaj5Ial/KH131Z9NMry29Zt7H9T/yuk?=
 =?us-ascii?Q?GvLJLcWbv1W22yxhsOnunk0JjaFeJpNqIfjW5iiqrQSGfoIpdPlVRzCPCcLZ?=
 =?us-ascii?Q?i+Zbnpc8q6mze/on4k8xJ+y9YoGgjZAOlSK6FHiZsHsQMWk1qSbU3yyEV0Xw?=
 =?us-ascii?Q?Ykw80XdCVLkKljm+4m56sM0bQGhhFoqE0+V/fDrsiSmRSAdG/mtNmgDWv7Sd?=
 =?us-ascii?Q?VIGjsaM1iVGEC+A0iAyGd5mWfY5bFfLW5tXmpKiymwqbT9v7ptx4GjM0dl0W?=
 =?us-ascii?Q?7V4gwtruv/6EGPbdZCbhfvHdlBNPR/6jMestQlVhEOMEEA79ML0vpCZarxkI?=
 =?us-ascii?Q?X5HscS7o6Leup+N2KO+N45gHngfSlnimigei5fg/o2GFrYVlvueLZxYpaiiN?=
 =?us-ascii?Q?zcSpnsHL82RRN0U8uDQipxV18pTr5jRNC5xO9NN37NzJFGCdJiIFKCY+F6jU?=
 =?us-ascii?Q?Vn4wUcm3E3Lr+75zjRENzV/vCAYcWKBDYE1/dDjiGPnS+qkts/zI5LpNLDAy?=
 =?us-ascii?Q?dHZP0THEc3uIUDu0Tndw1xlRmZFJxQOuBgFpy9PzsGnTtJmEgcfH+xV9u/0a?=
 =?us-ascii?Q?XwBrZUcWvpwQhqTlx28fkpAxwZTsw/0aVjX2VERPDssKkYDpXRR7PxHXtVIC?=
 =?us-ascii?Q?NmhKXgmjPAAXNszCsNnVyWgH330540qhMca02sEkQnEe+IP2OC+gOvX0rvpQ?=
 =?us-ascii?B?QT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GannT790iie2HTc1uptuHneG1M7wUK29nHdXK56ijDAlJk+8PvVQk/RaFxl3uT+FH+E3OKwleXLbR0kkymmpebgnfSAR+IW1uuZdhM7hWrGsuBU6airMUdnnZO4zHvoPu/0vHJTmNNQwWEUEBBIhfZvww2YR/xm4apHWtiIsNrwLBz4q8npZ35ThE8/o86AuAyIYDPtVk5jYyk9JRZAEmdhkcIE5Jht51gbMTDPpPB5nTkmmZO1zk3/cX+Rzw6Rx35XiGRAvdyHhkUpcgJqjlpwGtixZIz/vdKTMZPbESUHuHJMM6HMCzpPh+X4nulJbLi/rcb+QQ83c4dfWT9Ocjjp6jEtRsMqvnabbiODxjkEBrGgkXA+oa01zWIJgocZ5LkwGkLq9r7KISCBfrRAOLNRiz8dbw9pV2dzjUJchI7o=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 00:03:24.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbb77b4-0801-4199-9e05-08d6920fd722
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "WITH Linux-syscall-note" to the license to not put GPL
restrictions on user space programs using this header.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
---
 drivers/staging/android/uapi/ion.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
index 5d70098..46c93fc 100644
--- a/drivers/staging/android/uapi/ion.h
+++ b/drivers/staging/android/uapi/ion.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * drivers/staging/android/uapi/ion.h
  *
-- 
2.7.4

