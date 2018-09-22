Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B70C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED6E2154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AFstfk2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED6E2154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbeIUTbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:39 -0400
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com ([104.47.41.45]:19648
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390084AbeIUTbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60u/zbRLh15x3u0WK6gBFle2z4iM895QOwITGO9WAVc=;
 b=AFstfk2EUzRxVRZktmnmN5GwzcG2vf/hqyxH78FWrvRbV2CnEAxBTwdLqvrYvJClP0pY7iEf+rGF/a0mt4VPQB3eoY+srZ/fInzWsRbRXXpo7YpEfSKeCXEwU1uz1W5t+SyJ3MqHmC6c+VJjEXv5tOzzesxoazsYwCYAyqKiZAQ=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by BN7PR02MB5106.namprd02.prod.outlook.com (2603:10b6:408:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Fri, 21 Sep
 2018 13:42:36 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 21 Sep 2018 13:42:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Fri, 21 Sep 2018 13:42:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39876 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3Lha-00063L-6G; Fri, 21 Sep 2018 06:42:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3LhV-0008B4-1z; Fri, 21 Sep 2018 06:42:29 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8LDgR2u014376;
        Fri, 21 Sep 2018 06:42:27 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3LhS-0008AC-IZ; Fri, 21 Sep 2018 06:42:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <sboyd@kernel.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
Date:   Sat, 22 Sep 2018 19:11:47 +0530
Message-ID: <20180922134149.5693-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180922134149.5693-1-nava.manne@xilinx.com>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(438002)(189003)(199004)(8936002)(81156014)(6666003)(110136005)(16586007)(36386004)(76176011)(316002)(106002)(51416003)(7696005)(50226002)(336012)(5660300001)(81166006)(50466002)(14444005)(486006)(217873002)(426003)(446003)(11346002)(48376002)(126002)(476003)(2616005)(186003)(77096007)(26005)(305945005)(9786002)(1076002)(63266004)(2906002)(2201001)(106466001)(356003)(8676002)(478600001)(47776003)(36756003)(921003)(107986001)(1121003)(5001870100001)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5106;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT034;1:j0suDin8v6Wz3FRMzzJPN0KfrQ9m/061yyj/PjeDy5WORpHCoMyqr/Z7XStHOrTEdKqSXq/ceq31BSGIkdL7Kfy6F4YOm5HNogqA0MxmGuX2oiMcHF1zbGTKBwLM/2GB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c7f548-a95d-456c-5992-08d61fc81679
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;3:rZnpVo8mokFHFdx8lh4Z2FCNd1z6xxe5WJqUoIbDvl2sBTYI5GwtgK1jTRU0MNH62+BNxsKYAzYKZHkXNgIb289wjz07jiLRWAsVuNsfxS7EE8wqOOpAjF1i1LB2JDR7lW0j/+85QxNPHsgq6xJWefy3BWrWY/QJ6xdqAfpsiTHJlmGzLSe+iKM6RZyPa51vSaEX5gBTWb1h80eKNoAiGNNtKrKo16aGC3WHCi6u14pEwJPE/20LljUjoT1ZG7jp5TEEy/SAQjlNZBnoONbACMh3IISLHdizjeSPf5w17nur9CxOuryJ/0oyITFgcvita1qXrGP1uruXB14lhudLADrTbeI+/7TZS7j01BsV78o=;25:OJl1ileym9X8kMPFfFndeN8kQK+/yaDJNiCyzd0lqG6Hz3nVCGX0kEAbUzyTE26KRmI5sL1hlj1T9T+Jb3DwdPFVa20tZ+4D1StdDIAVNr2c4wmwnOotdnlJcOvXOPiE751/6Yr1wc/6Ufth//QerKqVtTe26+x8gDIvd2hSyam1n2Bof2ENM2Nt+gpNh4eJYJaX1VKngkgD5Tq/fWIggvec09aordfOWZGCRGS4VUyuEUqu1mUiST1dPo6zhEG57Uixirs0RslY15N54uIgSYC1bWl/icCYQao8SQJebgWG4hon7DwdMWjE56vZ6eprQtDb+dkC+WOQYAmm4X5blQ==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5106:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;31:plZ1LmOzdEIulr2jPlK5xxTtfZOYV6lTA0As2bEw3Vs/uxyW0JUwRJK892mKpCOGK2AHSTi2goAvDpncychl6NBHfhasqPf453+MWuY8KmY+E245+9Zf2rSBqnou92OKrmTPdlWd2C+AU4IClJtU/3fmEYm2qyz9bj+cATxIbMmGroevkVc+58KwMY7ndM0WZyL80TLEPJDFFiUVvgQcvNNXFPpBz/Z8F0+Mv8UQgs4=;20:Y9AQkMXQigokDHRJ+689xqPQF9EWBKEoINegDByiBqOR8xOJ3MjWjdJ0w0MWhowRrynriwJtVBIGDMpuU2AO2Ch17SC2n4BI3wIdtJVqj40VVLlsji0GV4cRiWKUcgJeY9KC8bwI/O3XhBpmaLKpBoVsDtKkgSDhmhc8vO0Iyl2BhSlPrJw1O/4pQXrKdUjaDKIjeRH+LabumlQtKFUTYdhHnmWjR7nkHoSVtue3gUdXwfcpCVnv0Aj+3X7eCRio9ERryIvbNT2Dfl0lGedhdKpAoHFs6/CC52CZdzOIMbrad6qOhCiIi5uPwCesx5hV4T5SWXaqBHK2pwWDkyOIAoFI/M1ONs7BYtVPge4ACmkgIw6GmGpvUESPmlIBR0OnWeirwr8UHVDobphqMsFDe4Rtna+QlZjiQbXZYXSMXxbEubpVjh5I1xgpiLLv8MZA46xgPhYppzTeVoBxgg3NvRAWvXn6wouTfeR+Kn3pvVTyA7bwdxhdpeIPsMQAWZNt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5106A362A3E14BD9F4555D85C2120@BN7PR02MB5106.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN7PR02MB5106;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;4:sLhalcu6MaDhXhanUz8dRNrjS6mCZh9XbbBSz6pzprWujhxQs0THvNrjKiJWZXcBm2CVN4rlTDdOJ9lsa2QQQhpF9aevUZBUeN9pW/VTJX7ekNGspMM6sYrTQ3cBVp2cZEmlvaUl142XmcUMTgILJppHcIWPJ1MW2poXb9E9+LocBMw/YBOxd4WSxb/9FMjH1kHypHJweT497d85nMznc0xejrK3ibA795TXHX7sJ7JyYkhNvH48brE75/SLcvwvCSxnq+f6tnRsiKMwa/VT0n9eYo8I5jeQsRxj4zFQUupXxcfHNbTnQ5K2MuuIBFu9
X-Forefront-PRVS: 0802ADD973
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5106;23:qyut48kqCHJ/439PD1l59wKgTm4Unins0XaAEfIEv?=
 =?us-ascii?Q?FCgJ4AzoZDVH55EwaG6uFC6Y5gRWJkDZ2vJduCVjpc6Lr+5OHyoyOEi3LkNX?=
 =?us-ascii?Q?L2/Z+cCShjDQ6gMrp5APR10tH8vyIBf/KYH/G4D31hokdzmM3P45Unvd+joJ?=
 =?us-ascii?Q?U+mo8kTK/vx0vOturkKDHucH9YwO3hG6tGNy8W+Jd61gbe4GcQC+JUtyb1pl?=
 =?us-ascii?Q?S2GVs21O3JQAOq5Wvfm8AHH9JQ9k+pc/e+En4zc8EDCKFdPKFKd18sPfHoF7?=
 =?us-ascii?Q?spHYObxId0lVmOcpwZXTUNK2qBbUU7+y4K0LykVPg9da96PET9Q9uWGWJSUU?=
 =?us-ascii?Q?BGzu/v2I/pbm3+LqnIRypCLdqdFBPMHFX9Qh1mJhxkJdxXqCu8Odj+g2aJ7o?=
 =?us-ascii?Q?w9cTgr5AoqQEETgNqcgEsccKTmbHqEo0ivVVMawQeMtu7EgmIdHS3cMtPhQI?=
 =?us-ascii?Q?dgeahPqxQ1q/e6YZ01UrvOJ+D9EHGohp0C6+2IT8JSgWP/zyBDno4vkg2tnO?=
 =?us-ascii?Q?lBAXnK7qn1RzgjXMDKrfKCMoN5N92zheTpOulpg58//7mJn0bdcJvXJTOLsY?=
 =?us-ascii?Q?QnGHfkF9nfc3vzyyngM/oZWYl3t8i5OHkrw1EzezsQtoM/bPcAlb0xnP44i7?=
 =?us-ascii?Q?W6DmwuNNlBNt53oMLNI+vrEwX3Gt9R/8ziFHZEDtIzHsHCgbnxsPSHid6nai?=
 =?us-ascii?Q?LPNRk+XXw4sDXYvRCzFeSQNuTKjhRV/9n0v+GmRU49mAJVx257GXBQTP+eqN?=
 =?us-ascii?Q?VeTORPzopWcFck/Z/3V0mrjXkJq17m9HfBoyel3xEZ2ehbYRUsr4AutDwmy4?=
 =?us-ascii?Q?XMtgI+k4J6PsXw5Mgxm8XuHiRbSZu1FcyMqt/5bdG0p1rWFrzgv517oyMvvN?=
 =?us-ascii?Q?mAZ51/pNKuGyHfoGlUSQQrYkkLAYaRYQw4GmrnILwll5SSTAzAChxS8roFJr?=
 =?us-ascii?Q?2ynCTYO9/hvv94JdZVX89Too5RbCg5ReXWNVuXJR9oBIp2K7slkOvgjwiH/E?=
 =?us-ascii?Q?0rznpJoP5JA0h3tSG/ZRGLGf4lpapekyqTmtVFCvOcyOKQP9OVwkwQZOAFSi?=
 =?us-ascii?Q?G6XrHQvNI9TbcvS0pTA8e6GpmnPI2yF69MS94+o8sO5h1SK8CG74ALWDEP2W?=
 =?us-ascii?Q?X0/Q2OmGykjr06F4ju92XJYwn4dovRkkOqrSZJq3YGJDmu7P0UZeUjwu5ts0?=
 =?us-ascii?Q?60Yx35+X/o9QFRZpd9PKc9sG0p9AE76ccECVxPc91LOlDtR8LAtKh7Hag=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: HzJfpzzhRVbYka1/EBrlyzAZ/wTzigePpr7Fx89T480hf/OFSM5NeJfbiOHI1qd2xGsUWQX7PucgaoxfaE1TaKDd52MrU4p6OaZV0AIWgr8JA4qqIfoaBNLkBZeMVxhJVQXhCX9zr2HJUSn0znzvGTWWfXGbHTk/ShYCe/Q6ODf02tzaI4HrKCzaHgn3nSvksGMi3gvRaloHzPRcXhyCKR99VPrZOVnnzO6T3GD5p/NM+Nal7juvYuGI1gRfO5rxwTlgFcLrAfUvyRj99o7gcLO6qFXHee2e7MfFXTUyJnImSG1LcTV2sx9Ql0F14+k8yT7HrNUI9jQw+2gje0yxajRcFSJLEGhYZJGWL8MXNDw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;6:+afywANk5odvAv9sfWZrxzI9zHS+9/bdgJ1KF/F5XjnvlQ3SbU5fZUKa5QJMNf+awTR8IA/9b3V/SxLeeRELLk0EQ3Fw9eIjc7dlVKY3OhEcDOAFi4oaQY1LkyyDOIXCj94W5408zQSDy99B1H9T3YAHNHqJGEVLbwpsOYYP7gR24KRTztg746+VnJ+wGrWqLXSfRWd60Sb7yudxKD5bjgXrHknVsTchc9jLWZItt8SFrN1C/nbQd86RemiYTNFgH2fvqArGWVGNRFmXgG2Z8+W4QLkP/NAOsaI6PlLcBxZBYg6DpiIYv8mktlglUh7K+ul3c9/Y2QujrufkTPG0J9gC0Ynp0QO2feKIBGFGs3fUfgo9iP6bG5rI1NaslzewC6QnN69y5qiR7n1F+Xil1m9WGxYqGGRryL7vqRcpixzuClkGzq9BfDzgv4U1+s/CxFqbV8ae6DphjLDsga5z5Q==;5:+I7FndPjajE888rd2DGFNZYF2mu7943qZGxjX6ayz/JoYfvHoa4OyJznhkFrP3Y7PhstE2WBcjUnrKb94BNoqkhZulqjnP/1/zuE2Ej9ppXuXacM99hLJMOtrB+5yge0Rv9J3sts/+PD/+y9rKbO713goMM1kYrN3hlyskSRGjY=;7:Ze7onm+f//cMX8+tKW5cuPT6o0JjRvuzoa40R+csho990T7G1tDF/ryk4C+JN5UC9hl05ysfWnD8EOb9Tdyxhnbvo3FwX0BwdmvWH/NqZw+5i79Dxx04cQXSS3BAu4PNBeJHREDlquhVgELfDt18ZhhhvCGwK8MrfcNEw68QT58cERAeQLwv83pijNP2AznVyPozGwwatoqc3CoMjb8aeKX8JBycpnKcj9y203rArbCJpMUAMy3AygAOihjMGkCN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 13:42:34.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c7f548-a95d-456c-5992-08d61fc81679
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-corrected typo error in commit msg.
Changes for v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf083926..7a33f934dce7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,8 +447,32 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:     IDCODE register
+ * @version:    version register
+ *
+ * Return:      Returns the status of the operation and the idcode and version
+ *              registers in @idcode and @version.
+ */
+static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a74781b51d..5a49d6f937b5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -90,6 +91,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
-- 
2.18.0

