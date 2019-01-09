Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B620821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1DRDWPJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfAIJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:26:43 -0500
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:64635
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbfAIJ0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh9FSX7gtLcsB+UuG70niE79iyBO0SnAXeS0QFECQHY=;
 b=1DRDWPJM95xGERhVrzzca9zeyYvg6CBymQsM+8vVXBtpso/3TLCcQY8oQSCXn8tNGftUwspB3HLeAUv53/B+xhgF441kJPOdt/JwxJczGSXP3vz7zSmGlKD1YRC28ooGuB70rgesWnkUxbJ8dHdQO4hij4RmhNLwoha2BzFP7aQ=
Received: from BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.8; Wed, 9 Jan
 2019 09:26:38 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0051.outlook.office365.com
 (2603:10b6:207:3d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Wed, 9 Jan 2019 09:26:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Wed, 9 Jan 2019 09:26:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51888 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA8B-0000WY-2D; Wed, 09 Jan 2019 01:26:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA85-0000jl-V1; Wed, 09 Jan 2019 01:26:30 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x099QSAo019292;
        Wed, 9 Jan 2019 01:26:28 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ghA84-0000ix-9E; Wed, 09 Jan 2019 01:26:28 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 672EE800ED; Wed,  9 Jan 2019 14:56:27 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH V2 4/4] ARM64: zynqmp: Add Xilinix SHA-384 node.
Date:   Wed, 9 Jan 2019 14:56:25 +0530
Message-ID: <1547025985-7228-5-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(486006)(8936002)(6266002)(16586007)(316002)(90966002)(107886003)(110136005)(42186006)(81156014)(81166006)(54906003)(478600001)(44832011)(4326008)(50226002)(103686004)(106466001)(47776003)(36386004)(2906002)(5660300001)(63266004)(186003)(76176011)(305945005)(52956003)(26005)(2201001)(51416003)(11346002)(217873002)(446003)(476003)(126002)(2616005)(106002)(8676002)(426003)(36756003)(336012)(48376002)(356004)(50466002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT015;1:T/jeXkcW8aWW48cy31r9+6SbvPZvZ6O/8uH32xjtp3SgCKM0VJS3Jq0MK6CBHZH9hl519Fj+hrXRm1VDXTLQ63SjkWuuWeOm4nK7Wzf2pukc0K5IxJ2S8PJ0vJO6dGTZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87958538-9552-46d6-c64c-08d676148e04
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:sUnrhs2ZPaM2aaWvS7LmqLP2rSlvVowXVFlluOxqt1a/F0jOrhVtuwyqz4bgX69MLjYCGHl5dbME+cod1gv9ruJJ4tvGSXRMoNccWE23jMYKOicjCucezflQOKZmczXcIQzoHAwYndtv7Oc8NRJvOmloIzbXexGP7tXWcOcQULJq/7W8wYnxPezjX2k2KZZ1g15offrYGUXJ9ZsUagIWlHgy3sfX88hv7Ipjpvw6nWuw+oNqVw3bmErxr70nHzMazLZDhRFfo3E1ieQYpyUUWAU834WEIa6DhztatCZPfOEnjTlwYH5Fuj/InF1gWuVpAilp7xJXHtRb59EmQ6MOKEB5lI43CqWmyp+5bAKYnZLRyuga/CLNKnsl+AEAH5Fe;25:Mm4kEuOQSn2OBQmYsDFOxf4gANadXxUJTnaH3lBSequtiRpt3It7pEjgXcqtki02xvH5ufHSCyVIO7IyIk//9ArSOyd8IJ+PslIFabLtzY6ipN1XgG6z5sv+4RuJHqOfnc7ODfn5NN+K4YZKC9x3Z+PIua8aPC4UahgZksIYsfDn7MKc3FVPQphdZ6yMxlBeB7OK8x7QnvA+bC5JpdfuP4Y+jc59RVamOW6305aUG+a4nTFTC1j/TKj6Ff328KATHiUILPLi0+eD9RhzdCqvrzZBTBHG6EEwmoWPqPuCovnhrcYYGZfaQvLlXYx8cEdaInHTBCHw7OWdjLCP5cIZjA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:vP9sh2YXcXRk0knyazkj65T2peKzBVsoHiS+y9kqhT4G6Pc9Vntq0LR3L7yesqD1ghmkG5A54OV9nkG3CuFV3nOEY6lDY5kl/L+m7AdJGbvUm5oYB0DK+59KESJLmoxYybXS/ylg+K4flrCfEi9McQ8yS7hAxBv5GwSqYMFApxBMOq83Mk/jfB0v8D+im/+a4m1g2oEjDiWIOHVrW0DHCm9ylgKdtaYi4MQrtLNZTD4=;20:kU6pNvi2l98lOe16aOCwr+IRkAhkIVeWwlOae+ZvXZES7bwxcWWQD4MGyDHgUWzXjjm7y6gY5XgIRCl1iwJn9msF5R/Vm15ZpJQMd9sv/4JWCLWo4ut8RY5dbrCySQXAaax/FFf1zlg1/rGuoI39wdqW9uKXOcQ5UC9lC+vXvs5/bSdp1rCkrPaKFCneFPL8gDZeyEY0nBSmpxTOTT0awa8mn40ADkXMSI42UrHX3BBMWH2RzISH7zQhnJCBorCwGW31rAG9zgfc5tjtS+MNVLEqAmiFzTR1MOMfGTUiSRsUNogfY9WyR9XTd+u4IUkFANGRZALe6+sGikLYxsPEND14l5YpMKXqqF+yHuUtFFUqNa9x8g6hM3mfP2QpmH1LBLbrglZ1Pbq//RPUe5eNH15aPq3KLTWseiJDRQV5d7zWlSfCCeRCcKAAU8TFMcGbZsvINQlC3MZmkb1sX1kYuy+shW3sQgJ0duysMcM/tTbfZVek9SqR91FJXTFGRJES
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4449F8D2819692C4E277B8EEAF8B0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:s79TstQ8cBZn9STIsES8jiR6TdU22sCbi7OKe6qsPplK8FLu7WNB4yADm2yvj6MK7zg6L6LWutGD3h3GFV4AwJfj81iTihrnpZxy+Sn2gMqMb3BIqDmpwg22pyN4TrpOLQh9liqwQ4D/Tas+OmvjKpwtmPlWiZgAj3njBRoK1jn2/fvtCYazWLFQCBkgVaTaE/W1jwRiY4EmRodqrHii9K9+UL/6yfiuoy47WIANvK20TrEuxJYstprbnXA1aoj23m92+odEZ4vd4EGr/AySALo0HJLF9Ot214V0UwL3RavrbRL5mix01WkfPCL2ECUW
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:vQrV1aUfsXl/PwqrU+IbtdJxb2qA4ar3FgjQj+kLk?=
 =?us-ascii?Q?2Tyi8ZM4B3Zyun2GzzcI5Xhd8Fn+b6XgUVrTg3WsV9G3oc9wHBEp7lVCAv4u?=
 =?us-ascii?Q?lGRlx/zJJOlEBz3xOY/y6vqnY5kqCpUQ0spvAs9wPgVVSj8drRMS0EVjD+MA?=
 =?us-ascii?Q?nBPSF2IJxinLYC4pc0YbnuR3qOy+JTpkC0uTwNX7MEoiEuxJJMQoedvDr4ML?=
 =?us-ascii?Q?bwA6z+Ua7NOCO1tTKSVcIK6toHoSH0KwnHbdIazkOyHsoQvN/swj4P3EoJ9u?=
 =?us-ascii?Q?f3y0s0bhmCkAZ9ZfghSCyPFRZfjBzeskcRxvwfPTWsmzDR6eRH4ZgyLWhOqg?=
 =?us-ascii?Q?2eFVO7ngXG8GUibrhHvTyIALGLDXbQDyrONqPDeE1GfuT+y5ggY45VNyi+rl?=
 =?us-ascii?Q?ycs0yC6+UTE7StT/fFgJ2WrAis3NjGZQOvC0OpwWZ4fRa52nV6X9qa2PkJv/?=
 =?us-ascii?Q?2EfhJJSWRO4aubOzczDE71NVq28gFzDW/9vr/A/HbSIzk3mCtbQ+Z2ZcOOKV?=
 =?us-ascii?Q?0x9UIko+TcX1lBH0NrYtnvB0an8KdkH31DqtBTL3jfoL+GT0QEvsTjPCsMok?=
 =?us-ascii?Q?RdSkl7JZljjEfbJY6AfnDnEzT7bZ3ofN0zzpwnWVngSJh54ted4ZoAYQHpOG?=
 =?us-ascii?Q?GRiR8nxH9KFqvm6NFWNKaBJBG0F7N95j/7cSSNBR6UkTb5c6YDbN82f+O4yf?=
 =?us-ascii?Q?qWWEB+lK60kEyFnQRihSo9N9U2uGEgmmXXQaw/OqStrck8FH8tky32b8O3xi?=
 =?us-ascii?Q?qc8NJwbxn9/vZtJNrpQROP6fW8AZz8Su1ovzh1JlfPVn0jp3TUEHvYmTBUEy?=
 =?us-ascii?Q?qHwDyzIKF/EuYi7P52bBxw5du0h2/vDojxPxI40wQR7oXHw/y9Gwnq1dMxH0?=
 =?us-ascii?Q?CiTNFlRHmvKZB7Pm1lfOajQMzX1u9vvcFCWw6E8qhEzuOSC+Oun/iZODkxNY?=
 =?us-ascii?Q?ZgDWDS3hbTgZuk2XXHdT93sorZqNcEfEIkppaQ7boZYFS92DglVouQlgRvmS?=
 =?us-ascii?Q?gD0dGEJqvIUQmyAbwmBtA/u080iToR6L7mzKe7+jkYRd0gRK1UIZDriBL50O?=
 =?us-ascii?Q?mOMjufdzh6qEX+mTKXPPygUNbGbk7SGzbVjiIo6+Xmn0ump/eIDcpVaqFOoi?=
 =?us-ascii?Q?rBnmqelHd/kpaeW57EkndV+AbvqMU9NM1X9AGeZJcG3zyA6jjld4bf2JMm5I?=
 =?us-ascii?Q?bkTWImziVo9ktXCk9nz++3stkxipXymWXpX?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kJYBWjaGGZRu35Nz7zR4CdocKxr13ndg7eJrtwSwC6P8QRLF7OcGL5TlXyBf7YbQDdWGh/dC9dVGvsAhTcS9w0kFYR31h0XrJ3i8P0/o7fgmIatEEFWFQXBq98A0d0FbIZKnOOI3EmF99PoUOUVMjhW0ijfTtVAGnA5w/toZti7pJDlbr23QYybKJuxL2v9DuLz94giJ96wSs5ocuZ95uzoQv99UZva9mprF+oT3Em9urYXmCuLCSKnMagpnGzhVKmkQktroSmgdb+qxhEyOv/5iw0gnWFOTVhTQRYycw32ZUPT8hq5P+5BVXNi3pw8o
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:fvWo/k4xgYGG1kUP2utQlUXkJESvofCcz/7vfRfYNZJIwwAbbzA0+V4bbjaKqsBaCcxl9QaLdNqg/OSSSIOYre3rlbHbDq0SnOGommGJ/Zc3ISCxJeXZDgfY0+QDmoMiNX2KF4FxnedJVC4Gh0bR4nVPPg460HdZIYeP4FdPZCFpAmO412EmrrBwJOIuE/k4tIi+fOn+5xJztP+M/oXbNlNPr6hA8BovFAzvXQS5IKDLhCO+f2Z6XR38tUgbXCSDpbMOVl6ArTJ1GGPqCoyh5um/PndB+vf8RyEJbv4td1+xmunLUqIYLHd4hal9VZruUFcMF2xpKE7nEgLGQItYywsgzIRYRhWxdbIXOxHV8ltIv8cIy69RM54O9aCfZffjbOpNWE14vCO7Ai00nw7cimMXi91kPcxD+FXBjPOkmUZ0BqYgtflaJitq85TKXn+9IxGzjA6+EcQ8ujxgRa0Gxg==;5:ru3NQrtCZVEUcpf6Fr2b5a/fwPiO1HmYc8cisNxBM6hGFtlG0GGbSZBhi4o/VM/xervXgO4V14PMlkYGCRJ0IPcMeIpI1BAdLwMTApddT3sulkEflcleu3/ITN4Lb1Vx73Bmb8YQu26ij9byS2DtBZMRUYJAunK+oPJWjr2Rjo1zI6n6FLhOOn7vlR5A5KsNT/eUV1NbkOnzr7giVS9aXg==;7:eRttEehK5QU4ZSV48DwyUkwPuqiR36Mfw3X+44JVDIHMSbFn/Sv6oJcSlAQqbHye7U3A4akhUgy8N4kXgseS8x1bn/ufhgrh/16SXGhuF6OobuY/zLRPt0n5J4buiWqgHwTnqUqRrAH4Y/Q8RraBmg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 09:26:35.8448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87958538-9552-46d6-c64c-08d676148e04
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
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

