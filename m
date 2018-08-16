Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7340E214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pYR8PD0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7340E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbeHPKDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:23 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:16096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731283AbeHPKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RdaEnYnZvpamD9U4mLYUzFDRVPimdMuveAovnvC6qg=;
 b=pYR8PD0wT8EvhotbzAMZIx9bz9sIq1NOTQc8ZMeb+fBy+N42cp+GScz8DlLqoIdyJCIbNqlmrT1X3Ik3lGnXhJGgfyN3ApsPOKl/12wLULeSL98BB9C3GB8C0qViNtdgTCdxQ1nF0kLaxjQ0M7MewCt/nFteJsPLGNFgBJuJO2k=
Received: from BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41)
 by BL0PR02MB4324.namprd02.prod.outlook.com (2603:10b6:208:40::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Thu, 16 Aug
 2018 07:06:55 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0100.outlook.office365.com
 (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Thu, 16 Aug 2018 07:06:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:06:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50029 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMt-0007Hc-C2; Thu, 16 Aug 2018 00:06:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMo-0000wH-6x; Thu, 16 Aug 2018 00:06:46 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76hC5005091;
        Thu, 16 Aug 2018 00:06:43 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMl-0000pj-1X; Thu, 16 Aug 2018 00:06:43 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 1/7] firmware: xlnx-zynqmp: Add RPU ioctl enums
Date:   Thu, 16 Aug 2018 00:06:24 -0700
Message-ID: <1534403190-28523-2-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39850400004)(346002)(2980300002)(438002)(199004)(189003)(426003)(48376002)(106466001)(186003)(26005)(47776003)(76176011)(77096007)(44832011)(63266004)(2906002)(81156014)(81166006)(8676002)(50466002)(356003)(336012)(305945005)(126002)(2616005)(16586007)(446003)(6666003)(486006)(11346002)(476003)(107886003)(50226002)(2201001)(478600001)(9786002)(110136005)(8936002)(54906003)(106002)(316002)(36386004)(7696005)(36756003)(4326008)(5660300001)(51416003)(6636002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT020;1:HS7uarpD7kCbW4GW9faustyA6/yFHL0IhzC1HcpUOB2iuacur58murCRf2k1Y+bGLWY8vx1I2vCFHsHdN17Y6jMQZ5Bu4qv9HdgiSw3pc0Yfu2V+X7mB3o+ru4wpX+Hf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b3b790b-6dd4-4214-b1d1-08d60346d97c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:ARyqHLyEmODIDt/vysYJbQBWFhuWzqMVZzmRBuFWlLaN4VYGvbVbGzMb8NuZYdUWlR42HbVjk1gsCWVycq9tx5lDdqZpJ/3buRBRgFEd0LUW2fSsItBCvgK9Fan6/596PX+9PYIJNhne8ywb925h1BLdPc5EttMx/Uy0llnZU0FBeLAlIlipcemrDDUIcVNlrwJapulbffvneQWb02rxEfe2j0PwGtjGcXnFEEm17lRo6Xf5OBSKo5UzCSz0KnIr60RwqIOpDLhKj3lgUpaT3nAOQTxzJlI2Wg2iOyLsC37zuvpw+ReMltSCuRQzTwRlcsB+/Q74iSbfiP5ERj3UPOV0Y4VJzHuIjwScfNia4q0=;25:92ifwg7qfllfxgFGbkRUjRbLiV9QKgd2f2Y/TyKw4DfFCdoqL9u/JNdqzdfDU1DXiV7NtGl/GkD0ZWGyHMCyi8GQmVMQEGx2KubSlFNtxV5Z5FXE4taDWUeMslbR8UqzgD+7pnHFQjMnhsXf87W3TZmOrL9ZJallEeoy4J38tPqv97xfK+du1iIknN+sDjqj0U8XdRvLEBDAs3ePnsATPEn0lAUBu5JXu9QFMfPqDsyGX56P4HiNbaZokzWOBIrpY37O1BTy35hPymae4SM1S2ouS3+iClBli5HwH/UdA6G3D1/iEBubYAWg4UZUW9q8I6Bbc5kGgYT6fVc6VtDHGA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:dirw12JmKqGJQl9q6OwSeywaN6qiKVg5JXpjl8bBfQCrzLy06OJeivy/vFnROusYFj3tkUWPcyA8W/2dxDzG9AvB0VzlfrhuPqWjNsOQpo+WYW89EQ+KU26F6ZLKsXS+A12HIyU5il3yQ/KhVneYLHRRYUoJcBzdBh65IfSRIfWYkban/WDFvBOxyuZLgViSOAZNux7RV4JyBLGdyghfsmpQ4Ps1TlQAoArersA0S10=;20:Gitr11EuvzVzhMCntGCthAsQRZHffpI5MY3VIGl9L+KsFGI0GZygcJtBnWkhaRCLVXyPkqN33tWmPlpQ8Stht2v+IYonlz6zQ3pIdiiThs9aUb5/cZL9cPWpacWGfLyzB+o0WJvOpXHL9WN553w8xs+nebp0mWgowKmpWrYRUtxSsKm4Qko2b27btYuVlaLalcVA45WR4vFAei3T8cUJS4KUIYv5IADnM4opu1Lup+QeQBNlRnoqP5eR3Z4CothRqE64wLLeZJODjy5qIBLGk+73PrpWjBv6kdqmdjFzSEjq7q35YJH0VdWrsbNy+C61ahsJ2cDUmaMfuJXoe6ODUDPwSi9GxJ2iAd1UzU8EYsnX7pfXZl5tnc3VsqKq9Y8XwiGGv0k+d97MdSOnTdtEDzNk8Q/IUqLGxMXR2HDWDXO54VLwInoljp7j0B0xZ9QVORWuS9atm03F2ht/oopXnqzjARdtBHjPyw+DfMPnp2qMp6CN51aM7u+wb3n2P3V1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43241C89F1A88CDA03FE3695B03E0@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:q00/ry/lZ8a5/AZdkMyMJbOYXbRjTUQGTc6AlYWa5p17TzmeHE4trwj09VEX5GXj1Vj/O2zXqJPZKLEQ3ay45xXz84fHrPefT3Lkohidjh/AIOIX33cZk0eQLdKm8hWm8lMV7wCAtExNYEoBHCRwXitfyfQxR7m04bE4qRpcD1APaa508vWefF6iBiKL0j3odGUBKTYTtZTyZcQyKUpwtlFZm7Tdib+PjYvJZrgRtEoNDWf6hNbfdbrQ+TR5X+q+WKAjlWZO+V2yUvkR+klSFLOqZPNW7IKxNjpGnSXUpFj1qyjlysl7Y+3jxZ7nYGrj
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:nyjYqwVh+aLk5fH9lg+yppLbshWWv9BmscNFpk4nr?=
 =?us-ascii?Q?3Z/GW1qjxhg+5MZ32in1Gz0GBIJdVVEMsBhT7R2wNXCWyzGnCCn67IAESHxs?=
 =?us-ascii?Q?aIoZdhEsDlIbzakLxFMwgPWWchA7q4Yj2PWwUDyLiU80cjOk97xfxkDcNQZs?=
 =?us-ascii?Q?6HRna45NgwyMAAGe0F1mhF4SpV4DLe4CbfZC+ZJCV5TYbNQsIO4lfy6YusWG?=
 =?us-ascii?Q?vFkg5ivtsvgaSKXZjCLm1cMjINXz8LJ+OlDmUwm9jgJANqpI5B6oF5ix745T?=
 =?us-ascii?Q?fg1oCVSW3q+E0+k4GaX1aU+zinxJmhk/cd+9JvnJdLi91w3bOG/fK/LKj7jl?=
 =?us-ascii?Q?UlQAkZ/YGReRImS2HpKns+pIr+mES3Q0UNAkxGdm3T5KTkHwEE7wI+U4nydh?=
 =?us-ascii?Q?1nEROQCrAXKIJm5C+9hh3Su8ASg9Hjm08A8f+iVSnrXD/44tJxBs89JttVqC?=
 =?us-ascii?Q?cYCc/mvIq0kC3CMlHIeegBm0+QJhRL+LZmgN8tHNzL5KgT59QI6FstbmBZlh?=
 =?us-ascii?Q?HmhVAKc1/DYQhaL47hAfW28eAGUo6AH7dNz07KEP8/g6iDANJHr1Yk8RGtrS?=
 =?us-ascii?Q?4amq/ha4As/C2l/EJy4iCj1MiR/znMpNmk3TVeGmIKR2X+B7KyAK+FQ6aso6?=
 =?us-ascii?Q?TrHImu/Zc+187fTm9MOklFNHzqMhvda+vtmxFIS1H4z7WOCjhibo1n3sHkV6?=
 =?us-ascii?Q?ZK0CbDwHgssCb9UftQYGRc2TpAD1v/DreVvrcJnh1Oz23RQLlJIVMxex73fu?=
 =?us-ascii?Q?spKQP70kMs1FAsJ9G55KqtXM02ellAg2sHTf/1tfRyHfHwft0Tshz7Bkzl7q?=
 =?us-ascii?Q?leVwrJ5f7+xPlfhuw2q+8p9fhSkaZkxXrmK/RleztTxTDa7WE8Hq1J5eUYqR?=
 =?us-ascii?Q?Cw1Phobsfnvzev/NXiS2FYdiVpOo5rbabel0qsPHlFLb590iZk1OLzQy3R05?=
 =?us-ascii?Q?0JDh2IUZoaA7a7b2yU6jCC6cyauMBMeoooQxNJBUYioK5M+pjO5v8NTfv/X4?=
 =?us-ascii?Q?RNJtV5zYIe7QRrsz30AoXnMGyUKK08fmkYXnDeOpmOh7gl1/QvB5n/YODnjF?=
 =?us-ascii?Q?/zdEDitQgSCu/y5kYrk3Svq4rv8KCpw+waIzAJ/COR3OehBi/py5PYeBWoZL?=
 =?us-ascii?Q?6n8PcsshsuhvAGXx4wt8uf8+4T//TK7vwt64XuNjzqlR/Ck6zOBrk9ce0n0K?=
 =?us-ascii?Q?1sbSIScN03gpDefy3013yDypdEo0viER/jx?=
X-Microsoft-Antispam-Message-Info: MllmhJTdeF4ayfnaM+hf3Gk5HHi7QVY25Gm322aZSqofMW1oVvQEyYqGWIAE7rl9TnxnIxKbERcz32TBfEcyrf/RTOeqxRTQCEli3jNiFlv/z4WPRefBW2a7eaZnrs2kzKp1RU7awVq/58MRAHED++9zVagH7+7JkxVKcIAd0GkbKsvrhlfI67nummhWdGPLMZ0CKXYklScxAMmUDDeOJ3iGUCmpsT+JKHELvDR3WY6/x2EYQb42+2NRBJfDp3/DEeDJdeH2s4KUOXy+x67xRGoQ7eYvjQUJyUQ2ikmbBKVczkQg0gC2M3bl/t6uJsB68w+6o8LZPFQ+cZnVkKgLqRJHe58A+f1icYZLXSPgO4w=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:iI5zpr3NQu9Sr8WaTisaHQzeJ/oc2DqFCuGnyYeg49/JnBYk0kCNhVWLgDwZKBOFmWJXVojzDz6S0KpxHh0hmJ+PjfIrBeJbJ2rz3FIHDjVBu+s06LFLFtwwogXZDGaHqsVkVARWPTe8tH+iRRRYrohI8cRB+7ugNpYZWXAR9JCz+fERLu4yFEsJ+kpQualyzoCKFm41wIz1/QqJ//TPMNpNKjN/uZWYhlTEvxweXf1YVs9H9+g6VBsKGS8oxuAiZ38kgXmye637wmRuN6+5OhV2jMgjUsoEsf2ilUbGTlh9g7OxXWgn+xk/XXkt6bHXq9YmZjJAJKqtWKP+Fwmphml/sqQqh7Z4dDhKl2+ZkK8Tn1Rt8qb+S5tkqjpub5l9ZOuOWOJi8yYeFjGk5qu4FOyBaoQF3SCW0Ukg9i5PorzrKeio0XQik1fXJDtetJlEjPj5sSlQka6tMWR6yGmQSw==;5:3nTJvhhZJ4yabQK5bI45S9PQJRM1APNIW2TEm5URQ+y8FXpS5Xd8Dn3AQykfj9XwZJipc+k1ZuwYzJmbhIZYpFnQUewrFVMj8Tlu095yKwvA+VQOxsnSbooR2F9RQ+rxlQyifMG38HXJX3pNoJnPYkHiS3ovgQDrXY9yfJsF7e4=;7:Zzk9BvkTr8pn7Xk2OzEUdcrhyhgMbucEvm421N2CjwOlB2hUY8+fMvJ5OIboFBqzRZcB09ZwAbUBl4i2hDMan+qIWnrQe+c4LdYqqWziPOs85fu48QOZ06YiqUoWvCJSIbZvP2URbiUhElJjERVv5fzXDc4STLg6sPErcrfzsn2ds0lAgK5tgI2/lrLwxsCgcE7U+hmLU1NzJVCA6cD3qXqQt5IddnHDxHZvQeazFPH2UifMVoMD6n5LNhG4NClo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:06:54.9050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b790b-6dd4-4214-b1d1-08d60346d97c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a3ef7d6..9c4258f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -59,6 +59,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE,
+	IOCTL_RPU_BOOT_ADDR_CONFIG,
+	IOCTL_TCM_COMB_CONFIG,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
@@ -75,6 +79,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP,
+	PM_RPU_MODE_SPLIT,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC,
+	PM_RPU_BOOTMEM_HIVEC,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT,
+	PM_RPU_TCM_COMB,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.7.4

