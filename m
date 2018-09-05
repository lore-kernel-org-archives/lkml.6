Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C3FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6262075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="czTy4VOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6262075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeIELi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:38:27 -0400
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:42720
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeIELi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DNE50jDmzWP3ifVbPemY8Yd2UHCztxf5TBZA1Ju4Gg=;
 b=czTy4VOuCA73kLGXyQhBQnKIbkocVMJzezX0yoZasS05OC1VRttuQ0Fv390LA5DKWNdNKPgRvhCvV0jyoPWdpWs0sOCsJrjHuQP7zPa/GxBNFcmjo0V0XZCe/nLzdgo4ACRjIL82ljLdle5P1QhVVxeYWqFjsjvFi62mfhJCrw0=
Received: from MWHPR0201CA0091.namprd02.prod.outlook.com
 (2603:10b6:301:75::32) by DM5PR02MB2684.namprd02.prod.outlook.com
 (2603:10b6:3:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Wed, 5 Sep
 2018 07:09:37 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR0201CA0091.outlook.office365.com
 (2603:10b6:301:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.13 via Frontend
 Transport; Wed, 5 Sep 2018 07:09:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 07:09:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwV-0000B3-IL; Wed, 05 Sep 2018 00:09:35 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwQ-0000dZ-F2; Wed, 05 Sep 2018 00:09:30 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8579MBx024323;
        Wed, 5 Sep 2018 00:09:22 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwH-0000Zf-UW; Wed, 05 Sep 2018 00:09:22 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
Date:   Wed, 5 Sep 2018 12:39:02 +0530
Message-ID: <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(396003)(136003)(2980300002)(438002)(189003)(199004)(2906002)(305945005)(51416003)(106002)(36756003)(356003)(76176011)(7696005)(478600001)(50226002)(16586007)(316002)(48376002)(36386004)(50466002)(9786002)(6666003)(486006)(186003)(8936002)(26005)(77096007)(2616005)(11346002)(336012)(426003)(110136005)(81156014)(81166006)(5660300001)(126002)(2201001)(446003)(106466001)(476003)(8676002)(63266004)(47776003)(217873002)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2684;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT003;1:+bwfL/JpQooh43O7WSq005JUU0EyBz03RJsEaL+XdndrFESG86eGtC/gF/ILuopXp9ZP+HTWPKTFt4V168F4+94+Psiaj257F50hhwC4mHRQqR30S7iIZvjnAKYTMo/A
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f97bc42-6ee5-4df8-1acc-08d612fe89ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2684;3:8W/RHa7Zt9GOTR7+PAl5X+R4sBvFGG/F3QGNsAZsKe1UFq5m825uyyjdaHczrUtWbFHbUOjXTJlIJPwnYxtLa7qmejb96AvhcB8Va8ofVn9HBF75sM5xfaIW10Dyy/suWMyRqLT2QwlkbVEbdTTBAEpGK1lsOx2WRYCAIl1Yc7AHTCoKVMFVFfK3MYpgcfZWVjOdfDcDTND63xFpm8upxPHOBBKn0qf5sYGgpUuhKbxou/6bbnaoASqA4eAta6mDiwEFF/z83+0KVYoaAKyxsVzETA4vCyt8KoxbEV57pF8whPVuhQH238LFNHl5ZYmWVAZSklltIZrlACm4sO/mgd5PFM7XtagUqRXx1YmvSnw=;25:81MxaZS0B6I7nkWWH+MeB+YvNKvf45oA3veOr/Ra5DF67rGImFNUL3tZ5I6+Ii6Ov8iIXSrZXfktG+mTwHh0tU0dWYd5QA4v5INgZY5cbPnRz2LO7x4g5o2Y+ARJH0SefMgE7RVSyezaNf6NKEW2G1HJ96/cr1I09eZdmAuH8tNyQdGlWZa8kvtX1LcD/qfvjwNKPJQtAuHmQakpHAYdUvIPe2oj53XI+6RkrsuGpqm7I4v5+g8S5AGET3NlDoys5vOQxcxnHgr7IGoav+V1TPMt60uL6S83nTP+FZPicS4j6eOQIjyhlrfqlcilTfABVd2PRDjwlTvUz8dTBLpAZA==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2684;31:MAbfaASftobW7QOlRqJ1OnrSl531ccYN0rpRON4IsA8jwMATuRzsYe8ZbTyO/DmsuN13t+LsO1hS5/D//oKIl8EXtLcqVZIoxddyKDCIyi0MhbTLDgHk/NCyeCIKae0EZGvR5Lj1PJBMpI3HHy3X2PGsxhgJuxIYDQbA1taMDTNREu9TERbH79zX3GjB554fT1dBUO/n2exhS9vNUQYepJhcY7MF9yKW96+R6Q6NxhE=;20:qWvurroLd01Y/1W3/ilxjHjTHx27715kGkJ6xTHrTF8k4HH4+HVv1NoDr9WTqXDClUIu4LSK5CNjwLBaA2mfB2C0LfUx6gBysYphmIcZGzHQOi3mxCWfhfZaNrI/sdYVzafNY9MYj2R1cJvGNtZv4iPCgHAHkq3B3bwrplu7BZq2A4oI1U9kAl7zWWmjP0MTCT844jQyeciyDhF58oUv60ncQ4GQKhXEJlQEXNiECt7gKv/9zTkTFG5o69oTpx+IJmC2IsQfo7AXP/ffE1SDfTcNYwYVlNwA4iwQFv1DpXeXNjDYgh29U5rAWlrc6oTpnMRe50IuIa/9jmtL3vfJ44jkV7+a4FMTlxgKytXErOokYbHf6Wt9fBSO94yCq9dgzSULUGclqKBq+lKVz/WngkWTD+MhXJAbzfvbq9Zr6QMUVmfQV9bGTxTtzza2n055MOU4e2DMImvt8GWztrEffETOweRYWkduiOffiHpLnhGbm48rQ6jxdCfVvDpvt6X/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2684518087F846B401B20991C2020@DM5PR02MB2684.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR02MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2684;4:fxWX/AhCeHV+0eSG4XT5sxdbaU8zK1IJxUNXjmHDoOSk0iUhfKhA4gXnBG53NUkCancF/f2luU05NzvOtn3rvEqqHxNIo2qd6G2Jzd6GSlHAeGJmqpvJTxpRycEc32tCUeW9qDpZg5Xd/RVFvqpKEjPTZoPqWWRPfuh79o51ah07msn2WOld3AYismD5CcpmBDlVHpvszdKR8BrNVkXmU7kC4xt49qENRwaipDhLAX2Pi/enpJUWVRldJdMll3fAPJu8qvlw2kiwJQCar5wuD1duSxkRzq5CuCqN7+jzBDkc4Au/evl3/Lwn3PBq76xB
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2684;23:srbR8bvAKLjALzU0Xh24QL4XXlqvPGDtDkPH0zF71?=
 =?us-ascii?Q?7dZb1qNpAwwUan9u+r8SbPUZSJpNDBs5bzUAgNX95QqNUuSxDBcLoBgw8AMO?=
 =?us-ascii?Q?hRny2KgKJrB/HNLZoxAOzxiiFFu845cFkHc+zYEnNLzYtyxAqlKJMVFzEFfs?=
 =?us-ascii?Q?5kvXPX1lQkLVyM77YWKP130OoHXmHcsaie/LrSWoKPoDDmcrGvCkObuVMaE6?=
 =?us-ascii?Q?hxXQ/QyzgllCyKpwfb8tYaOjvJAPzs9iP4KuoXeh/nAA/mHV9n9Hvmuv9tRu?=
 =?us-ascii?Q?ER2mHrWUvkhEIXBNTXAo4OTTV9iUoJu3oqAZm9jA0EjeUbhNixzAhqcbO/nm?=
 =?us-ascii?Q?KaU+KSj7HXTIGhDoWFKmnopkLxA0JLyFYlNdJ6CQBht9OhZ+ONF/s+ItFLe3?=
 =?us-ascii?Q?PrpOp4hP4vrAYmUIxM+8Y5FAmGbng/xCsYTIBB68f01/959kzLygPrTi1EsS?=
 =?us-ascii?Q?TMgqMbL/fprrNflO77OCdDqXkalGv/vuwFrI0XHwg7Mk9jn3cyzuPfwszbj2?=
 =?us-ascii?Q?Kcoc6jlCjidKDqxlxe1P6XphbKcWSPoMtuw7dJhmVgAH2JsKJSzS4h6yLO2N?=
 =?us-ascii?Q?vaz7DT00wKu8SqQMRsaglJINklULlhI/+cikvR600DJT6AG93hxqYytqxpU0?=
 =?us-ascii?Q?RMo7uw3K/ja83MB3UKE6NpE8b1DHa3RZgbilOKD3hCTTvrlsU8v6CPRG57zm?=
 =?us-ascii?Q?gQGY3Nu7Gn1z+F/Iayon7nHhH8Wy0Vjj2wY3NhExadrkS/4XEeKQX6m5EczP?=
 =?us-ascii?Q?EWITaKmjzMFnFGmpbDJhHFvac84a/PCoMnvUS1DCJzeQT1ecldarJizu1iGU?=
 =?us-ascii?Q?iikjpd4Ts0404pHh2zQglUOuG3YYrGYiM5uX5/luUQclOOw/6Ja0CY9FT1ul?=
 =?us-ascii?Q?JZeu72Ac9wYkly/eeRRiuY8Ib8cC6jwSL+EBj0qE+YOtM6yh9I4T3D3HQK22?=
 =?us-ascii?Q?+zGQ7GwwfEXAV7Qt4RKZMOCOtPY/C69RGPO8Howt9raqz5ddOZtp5p+Zbzoo?=
 =?us-ascii?Q?wcEMOdbxgZKd/qdLbOsM4pEqwq1QizdjDActkQed5aiVqdcAwdP1ZfXSmPWb?=
 =?us-ascii?Q?7LLNKXzUAY5lYix56/eJhOt9oz3l847aB+3gaKX/WGSy1UPYoZrKmc9ybIIs?=
 =?us-ascii?Q?YAEwZV/qhT9cBE0p+4xqbVF4qZJXy1rbJapLkDvWC/4WX8X+gSOVA=3D=3D?=
X-Microsoft-Antispam-Message-Info: hBdE4x45Vu7IN9vd/CtCuRbn25FyxWpXgtQWhkTQ8bzpS0V2PYY/ze2iMly/6XeK+3qleDwxdwUXtBmLKXyvVyZw8KQk5GYrOHz1hcU/SJjrZ/2q8oQHXjs9oGPTBaVh5PORFk8zYCeI/UaKj/Ll8oK+luyB9gQEy2PL42PCeHL5f8cmSj16zVqZO/chBb8nuYGnQmt8WkjY4o0+26tpzcTRUy6j5v5ngyMlSpAkd6Rv+2+5fprlpH10zN9MnSqWmxfJRa9RiNmrsdop+5MeBEdVWHB0T/J8NQjnoZN8nbCvGDPvqjL+karUweR73VUl8oHCpGoTH63clNAcy5xUfg6bDhO6aVX3rqCTRgUnKMU=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2684;6:MJDJfQarTSt0WfbtorjN/BtsHkJqzzGDkgC78Xie7qTcS0fQ/WF4s3xJkYh+Q54DoyLnjwFaAG5EU6POC5GDAihIXyF5At+elk5JyiAq3PhhsBRFhg0IILO12iqqCNtb2gjUwduMXYG36J7y37GSkCxnIHCjy4V0HaL3M0wH6C+lMXLBjbWDX5gfXPVPHJRgoDnTa3p9sVkEyTiRBgm/LSNsR89TNiLQEXKM5UKzEU0nATi9bDCLiNQMSr19DVuQuT4A/ay1kRH8gRDypPlnra4O3EVdjIMW5nsD0lebHIkzclC9dAJm7Pn1p9oywQtbPlDbYJFzgpJppA9EEl+mbtwywdkVbuv/0B1CUEhLOJOse3fmgnBLpG8gm9JiY5XlN8oa1lp/H6xaqPFv7EmLI2Se5PuPGSHVRfMJyxchpdRlyhU/fhyyxGsFr4RqGSmJjfPhYAfP2hpuGGV8l7FobQ==;5:7MOA1krh5QwqU5YtyFfn9emuXx1yWUN08egXbup3R6e5f2+7JVmuPiziBzfHSU3SOTQO15WHKpolcWu+j64wuENT+0O1hW0GNK9/kMURT8ii2Nn0lMBC9POGtn5OPclmFos0MlPKkG8RBwiE6/rX/APeVEVgSe8eN7guy46wo2M=;7:A3/4Zu9FHWUETX2gHuLqjsFt2/yhHtlw9jplzcNmAZUraxywrkb8tUvgXQLA9ZOWcJMZs67p0v2rtgLAd3X+B7YjvY6ci2pptjKuuzDHTccsZrXT8ac9Cn9KB+qoyuXnh2PsAB47PrqnoydX7LJuUA1RWFgim5VVKX07E79K8Fqeqntxtwh9h5CCICcbEBsCEKU279G5wbwMEXXy4sd3zqPdK0b7WOEzu7ERbZBOolanrFirH4/Ck57fB2it/Oss
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 07:09:35.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f97bc42-6ee5-4df8-1acc-08d612fe89ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-None.
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

