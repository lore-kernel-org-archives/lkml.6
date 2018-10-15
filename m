Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE4C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hzWPhXWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C59B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeJONOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:14:03 -0400
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:18784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJONOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJrU5SQvd+UnzB2y7BwttsucbKUnhltWgQ/qLUt4dh4=;
 b=hzWPhXWHxNMYnsO72qG0jp3omMq+3cHpRBJsaZ25GpbTYQqwJTpwS+SdqMztcmCGmSdqp9AXxror1wH8kHDV+FWKHVaEuLXvmiHDwvblOWI/kE+Tue6soXy1o3h6uHm0zFC6wfN6y2CLn3aVTFBFSelusHTK/H2YpAr6UwH+upc=
Received: from BYAPR02CA0029.namprd02.prod.outlook.com (2603:10b6:a02:ee::42)
 by BYAPR02MB4453.namprd02.prod.outlook.com (2603:10b6:a03:57::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Mon, 15 Oct
 2018 05:30:20 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BYAPR02CA0029.outlook.office365.com
 (2603:10b6:a02:ee::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.28 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55925 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSH-0006b1-3h; Sun, 14 Oct 2018 22:30:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSB-0001yJ-UE; Sun, 14 Oct 2018 22:30:07 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS6-0001jU-7p; Sun, 14 Oct 2018 22:30:02 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6254D1216AB; Mon, 15 Oct 2018 11:00:01 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 4/6] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Mon, 15 Oct 2018 10:59:46 +0530
Message-ID: <1539581388-23963-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(72206003)(2201001)(36386004)(81166006)(52956003)(81156014)(50226002)(8676002)(106466001)(6266002)(478600001)(48376002)(42186006)(217873002)(2906002)(51416003)(316002)(36756003)(11346002)(446003)(76176011)(476003)(2616005)(50466002)(63266004)(486006)(356004)(336012)(14444005)(6666004)(44832011)(305945005)(8936002)(106002)(4326008)(7416002)(26005)(16586007)(5660300001)(4744004)(186003)(47776003)(110136005)(426003)(54906003)(103686004)(90966002)(126002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4453;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT059;1:tXDyXMK1I4Rzjlri3iMNCWMB+XroTGziDGeRrHK/NXVjdjwYLyVTkYeAAwWcoNN+HX0UCAsCVahSTNzv3zVtd2YWt13FEyT0C6PSuWViWh/zwUa07U/lMyuPuVt4YC5A
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a636071-fee4-4524-c53f-08d6325f4b22
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;3:Kevtx3jFH/QiixXbTEmgYa8/JBaR7IQTXXw4U4ZDGtryFaaPQMN3mUXJMHKKrNJCidBsp8XnIAG4EgWhz/2f5C3R4anuGyh7sPvcLaDl0QmZVq/26yetKlOPLXO0zk9+NItmdgxLZqzlqPunLDkFLZ/N7SGsH/5teC2e75+sthNUvTSauRDwMxfez0sqHDdnRLwYv0Bwy/ZCY+EA8OFHlZx99aie/rsGv7wloyjDgYrwzSXQnlrnLySj0hBNnav1Dbve4C8qzKf4mw3uQEuLvpZRedylGrmnLU/Xw4mmsVsVjtQ3j4JLrtVkDOVYue0pkIl6JAeZurYrJZL6RzYX/4fcES7bqlH3CyNFl2Gmvko=;25:yik/QYmPrEuk/La0ePni5qf+ChR+TUrCc8XsyS49JqBk/ipUDNojvBsi+gZvWWJJ+HrFml/5SAPtNEAwMROq/68G7FUQ2WVzJYP0lIj6N34XhrNzypuFibspvEE0SjYFua1GxyeDnPKwS+IkyCIaqJ/NVF8UIzce5+Swj+HKarSggQJ35Q11wOwOvWoeGT4/63qC7QCn4JmfuOoVmXHfLGfw/UIws9uIWsKY+pdhHrJioIT/03gPGw3xNOaUkheGfs1fcpT6voEgwJTPjffrPCgG7qxtyWgn4DORaHxmp4pxeIv0LKjoGJGtnDTm7+nyyra+PRvIJ5ysZu/1Tcj5dQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4453:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;31:msZ2ZBZpOBO2YHv5ssl2Bkrl23FbeCupJwyboMSGw7fVLQ/rvk9AoyFk9dMWYFjqP9BEiBuJL3vfU6K88bR87fLMhZy9NrfX6DvEaNWd0QVXz9NnGE4GioJ6h3n9hY2b045OnJHfqzjm+WvsJgdiL/pdkk8ehcIwU8u7oKZZnKkmPP5Xb0NyeAuxrYDVC+W/Vql5nRTT+kRi740qX3YcGg02Gw1xQ+Fz68DFw0DvOKI=;20:XAK7R3vmkl7GtYvDxED9EBiUeuTGb4RI8y49YzurMH4wx4xP3CM83nCmjOMH6AlGHryo0IA1Px1qVpUmnid7nj8Gind2v4b+GWgMe2wjWRkxh2YsQhx2tHCR/XHJ+OHUkIv+7J2prDZ4QQJXUqkukFM+gYchtsOSI2tNGL1+r8DMnI7LLpEoVx8H3JAQZWbco1QN5oW6jQltktDk9uqnnHyq+HaO4feYXJp60bYQFAKGAEi6Utw68jPh3KjQxrWJ8jb2JcOh6QvSTe4gXdC1t3L9Qf6YBuPvpGsnvM9SzRwJkk+7QLUsODCgmgXCduH2ZJBmGTu/Au8rb3i2fOBUqZMVaF/isKWUZqJNxwm9vr3hPSzeUYX1DNOXXBIyie4xy8f3KoBpBsPFXkgBBwsShFkLQs+iOvbIwRwvxRoS7EEavpVJlCtEeg0HOPOFKHHi02yYt67MwZve62cdpaQ3KF//yW7iRZJq7md3w3oomfO8kJ6BKooDBEJigHMr8Ouz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4453F41600A432BE5DAA850DC1FD0@BYAPR02MB4453.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR02MB4453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;4:2TKv9jX8/BOxHkJ7YA+y9wyNyMOJg/cjmtPfSVcEN6+VeR4bd71drMfFsY2dlSJhSl2NE6eW01r22TdX6fzuLayC02vU/zJBjQZCRFKeQRRnOLepA7Rtfx/UMyEyw9+kAsNKJD5i/JF5kqcpW8ixLugkd3p/FPVba6K8hulGeH2B20aOYS7H3Qc6RrO/vUJbUP6RgGxLTHAdXNVOb4fW17bdjKxqXjPZGMoPOu4X3v47l2HWdhYoNxjNweFOgjOs4A+H/1ZpFW25Qpu0rGuPjzdq2p8GWtBPz6JUXrlheiVHE/C5frmhQuP3yiDygeXiQdJb6ovQ66c6wwPTka0yKzXMzSrNCrIiGyaGh1R15b+aCi+gXj5prRNKDbzx+sMO
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4453;23:i6trQZlNz1vghYFPpSqlYnfR+6LdELiPb4y0VwDTN?=
 =?us-ascii?Q?FDEtUfEaFVzcJHEE39/K9TPQ7jWGu0eK1vD2z23WoBfKwefrbvrVemfJNGra?=
 =?us-ascii?Q?4dWW36EDk605nDM2VW/gpBh4GHJ5A7PuLLzlzsslOi2phGRT8pY+87TcsOzv?=
 =?us-ascii?Q?2pDAuix4ybyOXNqg2LqeJTiIjFqnY3iC4oIBZzg8FE7/65PmH/j9CKJLG0gU?=
 =?us-ascii?Q?j/9ipnr51VxF3Tu2Ntzqf6cvD+jX3nBSl4mxya/vVX6o5OJi3ux4vtLvx5yB?=
 =?us-ascii?Q?T4UbVuvCCma8lD9TQnz2D/fGAx2QqkglbhqetR5CZyKdMqXhzsJpe9pzKzEO?=
 =?us-ascii?Q?QIEC8c7n2cr3jsV0N0AHDe4MmBKusG5+h/WWiIVc6TmtRpJAgcav0B0U9qyZ?=
 =?us-ascii?Q?GdCY6skZab2aHrfBCJCnkdljqrSnWX5xs2oPr7mZI7fnZ3Pq8iX55FxAXF8K?=
 =?us-ascii?Q?0uwzPS3Nj9DpocOXmAQBWD2sFT3LJYiA2NWX6u/eVcyAxLw0hSg9Nna5YU1Z?=
 =?us-ascii?Q?d370X4j9L/PpL5CvPM/Yo3hChcJY3jaOoTB102aaQR+tfhKHjex40w/Eeo75?=
 =?us-ascii?Q?lV1ROuKea66Qws+UBUTN5cZsb98tN9ICVDJEKXBCoHgxK9xIQUAV41TbF3sm?=
 =?us-ascii?Q?lybr6RCabsm/bLmu84LoXZHZiT5eXTdX0WtG55s/zoYdCNLUGtkv+ik//LGY?=
 =?us-ascii?Q?fgvKu6FVXie1g6N9cV/+SrKxNRMqkQ5Xdlt+UZYtuyh6sdYuGGTDESz+qF7q?=
 =?us-ascii?Q?XfvVrJZTc1bAwDURwxy5wG+JraqjJatCzNeNa8oBzGJkRbqzPijyEHAo5mL5?=
 =?us-ascii?Q?Gy/XB+i+q2+6JtCCDQ7bdooZcUjzgWeLP0pEKMXEF6rO+jP1xVEytrlAeN3G?=
 =?us-ascii?Q?Y4gEi6y3z0ZFhKNcGaP7R+QZaqeLANHEFxDpPuJlj7OyWJhtzvfv4Cn1iyKE?=
 =?us-ascii?Q?W7oVcZeO+w+KdvU0bB2dJuaiqH6QhjxPoGHiu7naOB6Kr9QJxXVS63J2DYQz?=
 =?us-ascii?Q?8d4hZPX25xyzHzvQEdJgO0voWxXIAid7GQ0FgSsL6857htfweus+T627Njk7?=
 =?us-ascii?Q?hgYD80kOlfMlj7sXKknBfN7kC9fbKJIDm7IHzi+XIJ+3S9GUhLMFmyJS9AMH?=
 =?us-ascii?Q?gKHymgB5rpzgdskboYhwjMHRJYnnjWk8h69Qewon4XU3IXKsL9i8u60PQ9LA?=
 =?us-ascii?Q?E1GPRhL1I0l7ul39ZzTuPm6YOMTCQvyxRTmEsPktdi2Jk3PN6AQM5A88ukBG?=
 =?us-ascii?Q?QKWIwDFd8+Lr0S0lmnITKg722wkio4s1VPQatPDSNV+kpjOyEDOZPlki9aED?=
 =?us-ascii?Q?CPA6wIKEDExTZy+wP7w0Ks=3D?=
X-Microsoft-Antispam-Message-Info: fniYxjfZDf0zv3huo68jEjOAC3tIwIq3fcUH2NTvgKZ0GtffsLwME9A1g/Eug28FGuqLs3gpjycRYAKGtciC5KsyYfF496H/P3NQB7YnUNdZ5YYmJEtK6r9d9U43GVH80hCyI3SGJbka+osFFx5Zs0+rY9zF6dlxuX2AilkUZKR+DnuXYUDVdGBstGPM1e8iyuXqmnt/tyP/8/MQGCetwcehBQMKoWZch4p5BDgCa1iPnCJMgfWZF67eMFumEpo1IkL8KuQZB76PI7GDHAYxjMd12GIVTSIQZRkZzbeOchfNZC+hf8gZ0gV1Bxp64Xq27nxw3fygvtU34Mu3xXY41gn07ZmbVNp2LVkMNHJLJ2w=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;6:hi8IQSM2Mpn/pmBD4JkPCWIZ8TpK0QT96fyxXLtu6vHpLi7yvHs1xFXsQO5e9YQYn3bYxyJgEGUtB8mr+4k4RFH+t3WPFmiwH8/PsbmqCT4J8tRMqbj74fdyXIRIZAAvE0Zg4dyChVmX4QZorISiSIxVfuLQ0DU25CxajE04I+HyqY9mRkuuSh39i0Iu7JND/boDqWy5J0MYbwRNVUnNCilexCHO1G4bdCNDMrNnlwmcENZ00wllaeYPdq0Tz9oJItfb+e86hScTWkA/ZW86EXRPbjevH9ttiD84/REiaor0JHYCVkQdGXNOHTLenMI7w13wsW5zsOj7y48x28OzphhtGCbVWlkpavJL3OPPhPpv5BqHYBMz7GYF2FNE/74we+PUU7hVS7tsHf6sIOFhV4Nmn3uYoSuyiePd2rlF50goRZEZLxH5+vUJ+begMqiFkk60SQR5qfgbiyrFxGkGJA==;5:Yj1aGzRZiwUQUdDwNVL6kmB4J0UaGGzgjqGf6x+hGO0T+5S9FbBFtx++yE9xxG9XOef1uxJ3Tr7CehNE/j/d73zII4T1lREy0eOeh8YZT8qo43Uh5rYSB3N9Je3CsonJhv71F7yrWVPCd8nPlq3UAVquoKgVeJNz8r88ttqdJ/g=;7:Uho/yZUxfWaCwUviGp+n4B/KIuHj7gyu5vj4mWTDVd6TTmRsx1ceosiHoQNNbrH6Dmp/TB535pxulsuWxcsru11wq0K9O1U5vzadu50rHfQYxyKVaPChbzvynd3bQEX9U/orD+BEPmbW8nbomN34x9Tk5sWJCDBTubj1OtWtLZlPVCPi9u62h+nCx6P4FTrxCm+OkxeL4X2lijNgYQk0k0Jl8AiZGqnu+9qMfJl8+F+Ki7SpeFG8wizhyleuJUHA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:14.0854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a636071-fee4-4524-c53f-08d6325f4b22
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
corrected and uncorrected errors. Add interrupt handlers for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 324 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 308 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..7c40eb2 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index d1999e0..603c4bd 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -272,6 +273,8 @@
  * @bank:	Bank number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @bankgrpnr:	Bank group number.
+ * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -279,6 +282,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -385,6 +390,66 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 }
 
 /**
+ * zynqmp_get_error_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error otherwise returns zero.
+ */
+static int zynqmp_get_error_info(struct synps_edac_priv *priv)
+{
+	struct synps_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	if (!p->ce_cnt)
+		goto ue_err;
+
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
+		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
+		 readl(base + ECC_CSYND2_OFST));
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!p->ue_cnt)
+		goto out;
+
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * handle_error - Handle Correctable and Uncorrectable errors.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
@@ -398,9 +463,25 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -408,9 +489,19 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d",
+				 pinf->bankgrpnr, pinf->blknr);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -420,6 +511,42 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 }
 
 /**
+ * intr_handler - Interrupt Handler for ECC interrupts.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t intr_handler(int irq, void *dev_id)
+{
+	const struct synps_platform_data *p_data;
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->get_error_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * check_errors - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
@@ -427,10 +554,13 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
  */
 static void check_errors(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data = priv->p_data;
+	const struct synps_platform_data *p_data;
+	struct synps_edac_priv *priv;
 	int status;
 
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
 	status = p_data->get_error_info(priv);
 	if (status)
 		return;
@@ -475,6 +605,39 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
  * zynq_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
@@ -484,19 +647,43 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static bool zynq_get_ecc_state(void __iomem *base)
 {
-	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
 	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
-		return state;
+		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		state = true;
+		return true;
 
-	return state;
+	return false;
+}
+
+/**
+ * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool zynqmp_get_ecc_state(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynqmp_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		return true;
+
+	return false;
 }
 
 /**
@@ -538,6 +725,34 @@ static enum mem_type zynq_get_mtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
  *
@@ -598,13 +813,57 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = check_errors;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = check_errors;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	init_csrows(mci);
 }
 
+static void enable_intr(struct synps_edac_priv *priv)
+{
+	/* Enable UE/CE Interrupts */
+	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+}
+
+static void disable_intr(struct synps_edac_priv *priv)
+{
+	/* Disable UE/CE Interrupts */
+	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+}
+
+static int setup_irq(struct mem_ctl_info *mci,
+			  struct platform_device *pdev)
+{
+	struct synps_edac_priv *priv = mci->pvt_info;
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "No IRQ %d in DT\n", irq);
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
+			       0, dev_name(&pdev->dev), mci);
+	if (ret < 0) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
+		return ret;
+	}
+
+	enable_intr(priv);
+
+	return 0;
+}
+
 static const struct synps_platform_data zynq_edac_def = {
 	.get_error_info	= zynq_get_error_info,
 	.get_mtype	= zynq_get_mtype,
@@ -613,9 +872,26 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks		= 0,
 };
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.get_error_info	= zynqmp_get_error_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_ecc_state	= zynqmp_get_ecc_state,
+	.quirks		= DDR_ECC_INTR_SUPPORT,
+};
+
 static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
-	{ /* end of table */ }
+	{
+		.compatible = "xlnx,zynq-ddrc-a05",
+		.data = (void *)&zynq_edac_def
+	},
+	{
+		.compatible = "xlnx,zynqmp-ddrc-2.40a",
+		.data = (void *)&zynqmp_edac_def
+	},
+	{
+		/* end of table */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
@@ -674,6 +950,12 @@ static int mc_probe(struct platform_device *pdev)
 
 	mc_init(mci, pdev);
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		rc = setup_irq(mci, pdev);
+		if (rc)
+			goto free_edac_mc;
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -685,7 +967,9 @@ static int mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
+
 	return rc;
 
 free_edac_mc:
@@ -703,6 +987,12 @@ static int mc_probe(struct platform_device *pdev)
 static int mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
+
+	priv = mci->pvt_info;
+
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		disable_intr(priv);
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-- 
2.1.1

