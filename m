Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E652C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6842085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="X/10gzgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfAGJDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:03:13 -0500
Received: from mail-eopbgr790081.outbound.protection.outlook.com ([40.107.79.81]:49273
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfAGJDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh9FSX7gtLcsB+UuG70niE79iyBO0SnAXeS0QFECQHY=;
 b=X/10gzgOeJYAaIP5mv4S7i+TrHKbRyN2aGCjAvC7Vul0zg4ZLNb+xStz8yg1K26V39DClh4j5p2Bgg3QgxtqNWzrrH3JsL3FBADUeBeJz6TBK/jvlQydkFhWYU4RA2bk1FLsy1l89XLHtQUua0EHAsb2fjw4DuDj5TUjWn2lOFg=
Received: from DM6PR02CA0022.namprd02.prod.outlook.com (2603:10b6:5:1c::35) by
 DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 09:03:10 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM6PR02CA0022.outlook.office365.com
 (2603:10b6:5:1c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Mon, 7 Jan 2019 09:03:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 7 Jan 2019 09:03:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoP-0000nG-Ky; Mon, 07 Jan 2019 01:03:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoK-0001lU-H4; Mon, 07 Jan 2019 01:03:04 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ggQoF-0001j2-4v; Mon, 07 Jan 2019 01:02:59 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 51302800B4; Mon,  7 Jan 2019 14:32:58 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 3/3] ARM64: zynqmp: Add Xilinix SHA-384 node.
Date:   Mon, 7 Jan 2019 14:32:56 +0530
Message-ID: <1546851776-3456-4-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
References: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(189003)(199004)(305945005)(2906002)(6266002)(36756003)(217873002)(54906003)(426003)(336012)(52956003)(2201001)(107886003)(81166006)(81156014)(8676002)(36386004)(110136005)(478600001)(5660300001)(8936002)(76176011)(48376002)(186003)(44832011)(50466002)(51416003)(50226002)(486006)(26005)(42186006)(446003)(316002)(11346002)(106466001)(16586007)(2616005)(103686004)(4326008)(90966002)(63266004)(356004)(47776003)(106002)(126002)(476003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT038;1:DR5L3OpZ6ejzg7BRTEQsoQ822/zOIvoaTeevEi5o1G76pO76dGrAbcM1ZRYaRSTi4FHY1BMg9L8w58ni2f030jVu/IUOKT8cTfobVj1qf9ErSvPLH3z9JJpHQ4QytSUP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c4673d6-2cc3-4a15-2d81-08d6747ef28b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:FEJPSqmbTOrKRlR5Vl1hJ7N/S0iXAUrRZfOeVdTwuKZnMAoGus9UUWUYdQovW62EAFwwevChxcj2CnzcZALwyK035SBRRzccR9XgZJVRglZO5gLXgRtXmVKynIcXgW8ZilvqSQNU93ZK3xLC97eUbvqJU2tnD5Z0bEOZhZXi5h56QgejU8McvBBVCcD7XZClOD7kxAat+xskHm4Hog06ts/JnTd6BROPrIPv2o8mdpWz3EqLZEi8IRXQ7MUuIfStjsYF8mGBmMb7w6NteLXqBgEsaJhQdU/vLrX6lK2WDo0qp0BAyvzFyI1764sxSV2OtMEUjE1VkPpwwEeECQqBtI3v/j0RLs+ocfFU1sm0eJ13AutJ3zFWNR+/Eyviv8xK;25:H5mlzVIMLDG+6XW4HJNyYqNHAawlzRAcXKOVx6xC3/oXdIqVWM6QXYeGyWhYgYDWKe4ZHFMN0RsQnEAb3lS4Q217uaE2bgJXeWad382f5TQyJKD0Yqd8m6TMb1g1d+jAhMcmHw0PABZKu4SSGJc3hKe2QO19zTMBlaDtMlbNr5uSSoy7hA2Vs3Ij/iHTS9n5euYm2R+9oz+H+ZgQWba3V/IH9PeAeih5Au4qPbCk+83ITMXrdOa1X0+C0MxIZMmDEvMq7NxkCeGe8EqzPZ5HZmn9GyOuFxkF0ZEhCoD6BGUWsMW8jF20ObRACDqSmXoenmVO05C92r/uyjpBnh+KtQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:acPasuznZRiGDk2g1eG2QubtBSTdlG1fMJWcP9xKvXbrWfzw1Efv1e6eLnwsN0yXoCkEBsWHGoFkXJ8K+TkECWGPrXidMsIIEnUnBh9l1zgfwpHS6iJgtXrZGT/Us/r0xDAXeVYRggGkLE8hiLHE6LL4ZPs4rM1mQgU09L2Zz7Q+bWcVXVuzRcYYvP8T7vVMbABpm3En6LKkIL1ODwjrpHAmf76l8IF3KdW53xQHFDk=;20:azHm1ahAl3c3jOREW41cc6L4g9Eg2JqnDh3UeMFQqRJdVH2mCvYtqSYxaiUh+HDVfOumR/3iYkJ9K5GsGSdoSFiDqUJKwHDrwMyb2kWu06zII+JeciGFZEyh0gDM3oyEC8k1AZcSrt8lnjN9sDB2Ucr1QIB7Fxm1P2gRC4Sefb3VI1A2vvhInFQW/vPbkrptMdL3Rc9OmWn/B9hjT1Ss1Rjiai7P8k4Kgs44p6riUuwo1ydBhApFK3YLWokChcMXv0HuGjATKtBtseMcm2rIp4jq0EkzgGsp6PP2qD6GM0e6qm6qRN/w+sTz6n7LfE8fuv8rD4pD+O4lRofQENabRx6NsI3lytBYpTnfGJhGqGL9W5rfJjeyd8wPMjWC9EiJW5OVcrReGyQfly7/rxLftcIYfWp18v+tINdBA/3RWohDXwO75/ZIXhnhuU3/aa7Ig7hl4qO6C3zd7fMU6d+4j9lJ8K0o9g7WjqvohJJIT+UEuu93KBBOtYgKH/ayKJCB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330E503F455F86B3B016746AF890@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4330;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:WNRiX1L9AsCHJCaZmoIp3NE6aud0fmrpL1DZ8ge8Qt1+tBnbzY83JgqnOkuzf0CPXYdODRXDJgl79cnKFccuFw/Yb3xXEki02BHh4M+lOCqjLQGZNWi2AstdvpzPFWy9gu5vXcbef7N6AH8OyQR1TMUJhDDoYM1QFUGCFKscfakhMlA/YCqCw4d7uf60OnLMisSFeXAxMEhQ3iyMKEWbm4bJR4G8V/xqLJzDj+39Cqxv3NgYZTr+VTYqJze7BqcGsfWoiYwEE1D3vhdyS8teLVTsJYhLd889PAKbqKLdMWZytYFDn5AEfAHV+XrDpMEM
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:yV0KW8tlzLE13N95FWdmwrwj+vdNWc3h052xys6aj?=
 =?us-ascii?Q?V24pXrvTPU7UPAInUToh3WLmKDHW05kivSd/yCDQbW3FyQyj6E3MyCF0XeFi?=
 =?us-ascii?Q?Bq3wUyVUPh+NqI0n9Wb0lnUR7ISBxztgdo36R29MtT1BiWJVdEyflUJJHBz0?=
 =?us-ascii?Q?EOs5hWy+hwcwsFwCtyPEGvCSi4pluPG8H0d1cGFCNR1n6vHS8sc9Ze0/F6U0?=
 =?us-ascii?Q?k/dkBeTYBsXw3FMLmFeCX1Ivp+4JcmGGhXRxyUbP2k7BGbaLHxGZrmMl/+H2?=
 =?us-ascii?Q?WB9VzrbXdmTr5fNW633De3Covk6dgmPPRUxDRiElTlncsescqnr+UDeW2BLZ?=
 =?us-ascii?Q?7wppb971quI/MI+thY2Gz++JlPJANEck9TK0BsjS4Hl/xL/nAAhrZkYuPuAd?=
 =?us-ascii?Q?HkPyiEcpD+pRI5uy0SS9NtAkZg3kK4rjW8NDP2+J9CD8F7KYMSE15RhGMRdi?=
 =?us-ascii?Q?PUlP1u8FGJII3b9k3hrwVBsY8VXsH0WCLN/nJBnRgUPWgwg8arVst6h5mKvO?=
 =?us-ascii?Q?IYU4yrvOffPrQyj50OIgTdMwF7Tw873h5AuCcl00GY0XYDYRMzeQZZhbEj+s?=
 =?us-ascii?Q?AqMw5ru56Y7KRszFC1yr+GBGsJI0+KC3tSQjkq6pvAwFMrBaPrp4i/RWoM+5?=
 =?us-ascii?Q?VOYprIeI7HK7j3Jas4NTXF0BRZWM3VenCVar877Pvgb+wiVE+qAXgkdpzJ8U?=
 =?us-ascii?Q?D2TUXeZ/HNNsnIpEMIhBvRvEqypnmPYC7UDdjz6ISjwhjUu5cVPGAAd/433L?=
 =?us-ascii?Q?NaCBIm0KLydu+RQPAQD0d9YYcxTIMrT1DswFWtpKWW1a/fb+lVz2VEZ0h/Rg?=
 =?us-ascii?Q?XG1WvCO1Hq4fonVwuOipdyIv6ZgwJOi4n/AzlP2UImFTDHLV/t5jKf1T94ke?=
 =?us-ascii?Q?x+DvRoDsiq7KxyhCpgSf00YCD//HW3uWbXaiYSSkBQrgAqXGkANUTbtFuWnI?=
 =?us-ascii?Q?OUV4RcWkA6Cc2avK4mOz6ItC0BKVTl60bptz12jKoIUB4eL9jn7GRpUwD2B2?=
 =?us-ascii?Q?W4EQ+OgV2CHQAOIgINYskJht8WWpYryMifgTW0llXwuNxNOZL9SoMm13oDlc?=
 =?us-ascii?Q?VohFUBxRm+82vNNIUcj28qD9T7szCJhsvcZIA/Gc6OlIPEURIWnlgjQdHzt7?=
 =?us-ascii?Q?v+nABzf4RlPgAn1umIdLhGS8/TyRs9l+Q7tFQn6MP5kSSjpsN0eXctwpgAk5?=
 =?us-ascii?Q?0DgByuHij8oAx4=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +qubYQO1YR4jSXA6cMEAZ2WK/bkkk8D7FtUvgPzxhC8xyepfQAq/QIzRGNrCCvQFMXeQvoN9yf3P4hpPCNxg2+zmE9frlluOPT8SkvEKvZuyJVSutOYLLauZHxeRLrLg/xLIde0l9Zx4mkFBtRQaEj1CNQAWaffRe6J4ksjNGaUPP7SJuZ1k56kZsq3aHTcrLFtnN+pvzDoNUubzanZ07mSSm9l8pYyQC0oXxbGnq3V07KXBqf9RvlkQuBr3zkPILg2kan5h+Bs56nVRfRe28grnlYDmgz1F/T/+Dz799dZ0ei06fQL5D4Kr4XOrJ0E1
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:7ccpERTQ9dipvadLqljYlk7JEhPPmP78RK2rwFcFqkIS+xcmuy2PAINVTXx+DKZFX7scHiz0MDDmMBVapV8vRn13uaCw7bMQEPKh+kXtrFlqO7ATOi02Z8zfWcErKxrctaRrU8kJVa6V0/K9pn1eZx/Ocuz57e5z3eUfzb6QrrEb+/QMLxa4ffZTsYB8pVKqp5Fgm+w++GmPuFkcX2x31MsP1ZMHmtiYrm3afbbiDoHU1B1UhG5KnHe6Zn6lOJprHKKYeqAK3lkmY8Eg/cm7I29eSzucdsG2BAFv+sPxSw7eKKxPYa0lmS07VDxmHGmFRPyvVYek0F2rgB/Z1QRuLGnqfGlcx5GhyEfq6W9JI6SDqT5yYnwXCwBnSpx2Bneu13HTgyNLTVxtOvMevBrwqnY8CW4RmeryqbzafuH5Fg93qXVPZ+1MrTMedc43oxQTSpXUYy1P361WPo+k5KslrQ==;5:N7z+11HXiRbUux1pgUbWoEbGc9lRYhP0bnbOE6ZAVjsJp1VrEkreUiw8P550ygD/C9djmTDwDshjm3wxhkwGTHRXfqSBo8CMg/GY7357trK9N3XpIdzw9n3W/abj2KtUebKEqPSpPbJ6F8RaDVpPjtj2w7bBr0B15tihSnYKgNX4AT8+f4v/i20UONm283F1CrrVUV8j/ENAFIwR14VXAw==;7:bN+g3AvirASsp08AgvNAPnSqcRwVberCtGaLzGoE7NhXBRA8xpM2L7yV76yton7N0gWtdhBYqMAZMxKCua7eYtnhiqsfIPF9TauTxWxIMEru1wJF38L+8YE54FqbVqP2p3dV1gxf9wKwr51mHJn93A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 09:03:10.0599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4673d6-2cc3-4a15-2d81-08d6747ef28b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a SHA3 DT node for Xilinx ZynqMP SoC.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index fa4fd77..a3be330 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -124,6 +124,10 @@
 			     <1 10 0xf08>;
 	};
 
+	xlnx_keccak_384: sha384 {
+		compatible = "xlnx,zynqmp-keccak-384";
+	};
+
 	amba_apu: amba-apu@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.7.1

