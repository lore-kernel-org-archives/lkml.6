Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7857BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E662098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gGbzUD5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E662098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeJEET2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:19:28 -0400
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:51152
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeJEET0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT5jYhOZRx4yUvE7ygLZU7CPkNtNN+wry6yIbMP9uQk=;
 b=gGbzUD5XnHR1RM5vWvOPYFFnGtGFYfrRJ4o2AfCp5igQJsnUPJIOuUwTIRa30FxvWyshTc3za7Dih83X23apXzcXFc+n+0fVW4MXh3LoboE4IU6bE4JCOQoznQ3kMChtsrd/IxIew1Kqx2yZU2F6xVKXXRzRJnlZCeIakwbb27I=
Received: from MWHPR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:301:73::42) by BN7PR02MB5105.namprd02.prod.outlook.com
 (2603:10b6:408:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Thu, 4 Oct
 2018 21:24:10 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR0201CA0065.outlook.office365.com
 (2603:10b6:301:73::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Thu, 4 Oct 2018 21:24:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 21:24:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48223 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6J-0004f9-Rb; Thu, 04 Oct 2018 14:24:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6E-0001wm-MI; Thu, 04 Oct 2018 14:23:58 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94LNuad006254;
        Thu, 4 Oct 2018 14:23:57 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g8B6C-0001w6-Rg; Thu, 04 Oct 2018 14:23:56 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 3/4] firmware: xilinx: Add node IDs for zynqmp firmware
Date:   Thu, 4 Oct 2018 14:23:40 -0700
Message-ID: <1538688221-9823-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(438002)(199004)(189003)(2906002)(81156014)(7696005)(106466001)(76176011)(48376002)(9786002)(14444005)(50466002)(47776003)(6666003)(50226002)(36386004)(51416003)(2201001)(72206003)(5660300001)(110136005)(63266004)(426003)(39060400002)(7416002)(305945005)(476003)(486006)(11346002)(81166006)(44832011)(478600001)(4326008)(356003)(54906003)(26005)(186003)(336012)(126002)(316002)(77096007)(16586007)(36756003)(106002)(8676002)(2616005)(8936002)(107886003)(446003)(107986001)(921003)(1121003)(2101003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5105;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT017;1:zyZFSwXRNvWspjL2gcRRqWFw1CedLaWwoeplHnas+R+4RAUd0D51UWTob8/9g4thNRTtczP+rei1AcMeALRk5SW7aluVCVCZSKXFIW6wjA0t8bxIXM6HzHObYROYlIzK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2409841e-faaa-4a54-4546-08d62a3fb8f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5105;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;3:e0Hyi+u54LCYs7Dl8wpqrVCkZsd+esvBQMKbqsklgnyyoOhB3kqupFyGsr3G0DF5qgcsu9lJOsia5YAa2MnI8QkaYQhH+U6ABqkI5fOx83B2c3nj0PA52ET9XkL9PD+kgCClYxs3mmOkQMtxnHJMN6KpNqqaxwxyKM0FCgYsXQesAtriYIMej0ZsNkDAH9mxwqGOBHS6juh8gtJ5pTBDo7NASZwPC7hnZYeazbBPuJExiehP0eEMyYV0NWuVxXoUAe0CMUZb1T5uyb+8LpvrI0CuRlT4N266TkCzfMX0t/sGn1E8tHBku431wpdHphvzSK+WWq5PkWONETDyGPAqQur70LWFl4EE3LJObAKw3ss=;25:2uE2oIaj68wYqeBRRz5/8Oviq8VpFDpGVU8aSAlSShYQKrhrgQ6ldFignUBYsaCuBHwCekcLqWlyiiqf3UVfcvjOb6MvukpliM04SfLqlRkUf8pm4ggg51576LUfaRSyZgyGLelo1wA8rc9Rw9plxqzJevrvpmZ11SflxdJrkmR++Dzp9WMNRBtH3gMnCoAJifH4/6dCXl/7fxJfxnP8usUKKcnsxHqL/G2olQAE3Y/1mM6LkrLaKURcbxdXemR1rPq1E0oGHIU0g1xuixONG5sv3+C2HYYlkP6L3vQk2cxY7jA1Onnqsn8iXEAXb0+n4VJaUhrpfEBvPlh549YUZQ==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5105:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;31:hAjVZZeWnWsl8i0RrqWl9OGDGwbZDxYCIK7D0uu5nc3OTkbjngIP0Qa6Xk4U4atWsFUqlCsVhvz8ay1Ar33QHyuVY8SSH57qLX80Q745rKpORaHf9z0OUKHlzKaRUirLizb3AThzaK+Q2/bKAzhRwOen/W7aLdRtdC2Z/eQsAxz4t3Uniy1HoYLxyM+EC8KyF0vBZ2jW1NI+GKdVDh6+tUshpKHlwOeaS4uV/hth91U=;20:Sg0HxFFvPJlH2l+9wX/0UTpVRP0QYYXg63soi7cyfPBGxBJpY+2yq1jXpeyuaVU+l3duuJ8q+5AuT5jrCZ58DrGPoiWDHOz9DITUgNqpOZEBKj8cGB1g/gfD7nn7pSgjYrVxmryESZMzCuge6yDA6psW1jyQg7Cj49amZruIex4UJR09reizvHk03Xr2R2G7hT+ZzkYtww5V7D25vuC29TIEXqz27NNCIvBCaoXSHWN4mLY1UDYQ5DsdXiaPg/HsxhW+xyKEmNQJVvH1GQZxp+qza0nyf479efoAZKsuoLryMzpTOQfRfInUvHf+rHZwylgnYWdBx059ruaXSiGnecVpamleyJ1Y5i8m7Ft6NCSmGU9ZqpmNHXJTJRyNAh8HJKo/rEoEO8NbUx0zHYS6UuVVe29OInjwPo4rXI70JXGWA0O9lXqbv4+Idp6epDLyga25upR0GdopKO1lcKzWP+NUNJtpeMMA8k8VLSQXlSmmqE7WNzDwjp8x5hRGQc0C
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5105373A7796AB4810073763B8EA0@BN7PR02MB5105.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BN7PR02MB5105;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5105;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;4:dW7TDWPWCA3VyKNjGuLfZlpzFLKMMlz/PPMLqspYrSMAapjpYqhglacGCYN2tE/vBhAVloU2RYoNYwDht+427hygx5uPFC8eJRmE+q1Lqr5bUzHLLvk/KPQW43qEJqY1JpHel2ADxowpfrZxL+UaA8WV4wbw9EWrKjlxTfCBCNVvKmswep8uEHe2+HtXVMiOGnZK2zg6RmVb8qiBemOloBZDL5Of8VGUGoXYqp8Q4pZj+IpE7TazGb+4OQ89r5jIONWaoTV1kp99ecZVNwwhRrMiIP8SKKAvi0ePdCHPdB+TpeAvV7ku23URN+b7RltC
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5105;23:YJ2kcUWjfnD7zDGGfFTyGk3sXa7DUDt6PUvhaT/KJ?=
 =?us-ascii?Q?5pTA5mlmhg7lFAaYVgoNSRkn0BiQb0ihHM9Kl/yveF8otij9AKYr4kDqBMZB?=
 =?us-ascii?Q?C3fn/iiDKyG9wTCD1RA2bA3FqOCst5c2e1+VYMuf8IW8X2noHvmSAypyP0kh?=
 =?us-ascii?Q?NvlCLuuzBHHWQrjfPeQe17tbZ8jDf0Dc8qX/jaeWoomxQZXPezyup40CgIVZ?=
 =?us-ascii?Q?h2bILTYS7eTq6bJWNxCC5DNzRx8QtbA2WRlu5xSMg7b0yZaN/S/c5qRiLkbE?=
 =?us-ascii?Q?nhrveEKw9VVx1++Z4CjDgtasShg/aezDRZ4dnNvPPRRIqcBxK2OCdm5W0Cg4?=
 =?us-ascii?Q?qprjn2vyyG+6482Ll3Etv1HB5REr5O8r9OvlxfneVYke5ZS+/DMYG5ZUq+h0?=
 =?us-ascii?Q?dsO4H1mlvVXBfJYmQenOvYPgxD5SmexCtD+RN41PMNi4ApIRZ54VgVoXEO2k?=
 =?us-ascii?Q?CYT+aYbvck80ee4bg8368qzDgxppw9D+oHiepAaPYGdPCJdH5RNoakk7usmv?=
 =?us-ascii?Q?gJUqgfjb2lBxvR4pDdditYcp0zr+IIovIQo2mKKM695YW8ZLfA9SqRHPP8Ec?=
 =?us-ascii?Q?BgnUnwNLI/qV+xvp3/BjRcGQk4ov7ooTVkvmfaxC34tN0n+0wGFylwrwN39k?=
 =?us-ascii?Q?Oi48VNiqEIVxUAkmbb2vk5E9uv9grbgJ9i6affe6zQiMTVDX/lxuBqXXIBdB?=
 =?us-ascii?Q?AA+EOLgNEErdAPul5kYSN+JVDiiEzl5mEXsZz+jWZrRd8VM8X+OnjyLEUnmn?=
 =?us-ascii?Q?eGOYbYE6Mu1WJfTYhM3l/VtAU11oYeGlXP9xm6c057GpeNib0X57DlzOpnRY?=
 =?us-ascii?Q?VLPUJ4CimN/PWHoffyo2kLOEVpp+xNynmntlGSqzbVBK8oEP24kDM5Xi2EyM?=
 =?us-ascii?Q?nmu2p4pJ8qMCCiwoFiooTViFFRYBxx5rq6E7R58jkLRD1gEAL3WaJr8Pg3v8?=
 =?us-ascii?Q?A9+VkjHB2ZEEcBItPJmlAT0Ad2fYOw82aStdThcln21FvNy1srj5o3FPF2MJ?=
 =?us-ascii?Q?EswMbWOd+P5WNPwU//w6so7baAXe7R82Ehey4GnIQTlYR0Y1LpAG77e0EEZJ?=
 =?us-ascii?Q?LWBZNvVTUNuDj8mhDYXCiDnR3tRGx3SX+DMnMOTK8bLnibAikJZyVd0DBMKx?=
 =?us-ascii?Q?2aAIDgyMZCqyR1tTZevDpEr9zRp25r6NMy3+g/8FlGib2xsR/iqrxqoG44iJ?=
 =?us-ascii?Q?l1eXpFcA2MGo21fQR6Dbm7sIAaOe47XoVbd1ewa7VxjqvdMBf+QdycyYduwl?=
 =?us-ascii?Q?IMwDjThs2ryzOcIxTGZfFaJnemJsf1JyQ3DWYr+2uVCKfCPIBI7Rmdqbn8Cn?=
 =?us-ascii?Q?aTJxVXgtPP/UAhf3qZ6dqevAoOlLCoGMBNIavxqKuYH?=
X-Microsoft-Antispam-Message-Info: /rZc+4fb+rDB19zT7R8WikRiqhwRYbdzETUeXlQ8EoE3ZkdNlyrNWDODUyPTqeq6SjhohjV3Sx2/370durGhsLgg6/5AEwa7s6dYO/xebHuYOVDvUKWQWQEZdiKqI712qutHt4U6hGx040TK8ZtYIFlC/5SjWpapbJo3eI/PbrNbHf35uRben9Q+WObYK3W2o2nKJe6evgddFsRxBTvFSnotKhqmLHm6AFL/NaDbX07856euPdNUaJiBYeCq01v66qUwp4QE7StHRrk2glZM18C0PN0Lqf/SRafad6qdMr7Ppf0h1xSSqtn8Lgs1SgKFAYofMA+LXSbuDJUSB8tLWZWqAAl67eaXL1vewhUoVMs=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;6:1qNJzV5MVgZcXhwvXGmutzWQ022a474fFK/zy6cBcHb6aw6Wd3T4A5gDOOg/yUOZK34X9Az6REOwrYO2tbQwSjoy0ZA2KXKEN2+qtRQek+TsBLnO/q/vR2iVcYdMo8endtVu6Vf3AAvel4jRD0dgH33IyOV1+AfLRaJFL+54IwGixWdG7+zirwzS+tJqcE79Gyc27wD/JMCiS+/30dQllallRsIhmbVdL7AX8wblLCsnBi87wJYjkgUAM12V/jjgpcwfIR8/zCdeNvsxBDx8MllfrPUSZHriTiGrGJsXP/YgKmJGRLDiFcW9Eb455X0tWVnPML1Uf1YFSzZHTuZuegCW9oAGtOPJjcufmea3tQanejhAaH7DFIC4122D4Vt5kfQdr01JFe3evtc8BlqtNwhAQTWNp96QzF9grleUoH9ocIUINarzl+ePsnviXgtVOjSeluf+7eWgH5i3W19rdw==;5:o8IITfkYHbTPQ/T8eiSnaeeBhfhKZfccnaZOSI+4lNmjmkGrhc33vJFY9SDatd+/WHmKBzoMyOPuF1aiQTyd0HJ5oj/Y4VSktRLIbQwqIFF2hDt5pfwEy01RT9+k6AmZZkxmA+bQya5rIUyY2NixfGsdCwmVTNKWFbD7Vh7SRHM=;7:u+V11WWAM6kw/GhkAnInjQ5D9kLEUhvsd4TLUrbLuvN38nlVIXLhwkLs5Uk61X/2oJ/ip8o2A7Gi7OM5YkMUE+iWcCZiQulR4iBBqtQpMb/CyYquH4Rn9C3PzCOEjPMi/p6tkOmj7qPZVsP03wtYbamoeXMv8R3i5+5GXCpWvkD9ll8QiTsb8N05xbwRSn9OjYuDIpk2MSu9ilY3+7MWTNCodN4LLpgEk2boRoOT/+3J2tHB2dDwG0pryMzUoGqc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 21:24:04.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2409841e-faaa-4a54-4546-08d62a3fb8f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Xilinx ZynqMP firmware has different node IDs for different
peripherals. Add node IDs which can be used by any driver.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6998f7d..14bb780 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -40,6 +40,78 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
 
+/* Node IDs */
+#define NODE_UNKNOWN    0
+#define NODE_APU        1
+#define NODE_APU_0      2
+#define NODE_APU_1      3
+#define NODE_APU_2      4
+#define NODE_APU_3      5
+#define NODE_RPU        6
+#define NODE_RPU_0      7
+#define NODE_RPU_1      8
+#define NODE_PLD        9
+#define NODE_FPD        10
+#define NODE_OCM_BANK_0 11
+#define NODE_OCM_BANK_1 12
+#define NODE_OCM_BANK_2 13
+#define NODE_OCM_BANK_3 14
+#define NODE_TCM_0_A    15
+#define NODE_TCM_0_B    16
+#define NODE_TCM_1_A    17
+#define NODE_TCM_1_B    18
+#define NODE_L2         19
+#define NODE_GPU_PP_0   20
+#define NODE_GPU_PP_1   21
+#define NODE_USB_0      22
+#define NODE_USB_1      23
+#define NODE_TTC_0      24
+#define NODE_TTC_1      25
+#define NODE_TTC_2      26
+#define NODE_TTC_3      27
+#define NODE_SATA       28
+#define NODE_ETH_0      29
+#define NODE_ETH_1      30
+#define NODE_ETH_2      31
+#define NODE_ETH_3      32
+#define NODE_UART_0     33
+#define NODE_UART_1     34
+#define NODE_SPI_0      35
+#define NODE_SPI_1      36
+#define NODE_I2C_0      37
+#define NODE_I2C_1      38
+#define NODE_SD_0       39
+#define NODE_SD_1       40
+#define NODE_DP         41
+#define NODE_GDMA       42
+#define NODE_ADMA       43
+#define NODE_NAND       44
+#define NODE_QSPI       45
+#define NODE_GPIO       46
+#define NODE_CAN_0      47
+#define NODE_CAN_1      48
+#define NODE_EXTERN     49
+#define NODE_APLL       50
+#define NODE_VPLL       51
+#define NODE_DPLL       52
+#define NODE_RPLL       53
+#define NODE_IOPLL      54
+#define NODE_DDR        55
+#define NODE_IPI_APU    56
+#define NODE_IPI_RPU_0  57
+#define NODE_GPU        58
+#define NODE_PCIE       59
+#define NODE_PCAP       60
+#define NODE_RTC        61
+#define NODE_LPD        62
+#define NODE_VCU        63
+#define NODE_IPI_RPU_1  64
+#define NODE_IPI_PL_0   65
+#define NODE_IPI_PL_1   66
+#define NODE_IPI_PL_2   67
+#define NODE_IPI_PL_3   68
+#define NODE_PL         69
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REQUEST_NODE = 13,
-- 
2.7.4

