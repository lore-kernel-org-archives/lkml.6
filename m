Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC0C468C6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1ASZV4/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D6A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeGRLuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:50:21 -0400
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:26704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728240AbeGRLuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po8zeeSPKnbmwAv9F3cTQOhv7wtiAIWDPFpGUEI0QxA=;
 b=1ASZV4/XuXUgiwio7E/XPjTITjK8OpKjxEIxhTvKeVqcWuYh1NHCXLkULwNmeoKcG+9hjZH/xPfrYgnQ1kmIxocJT3dZclkhzxDtQsFmpz/x+ayjZVYEU06y75OxfslzYHW6AKYxQSpU51iU2Y1wGovKBTJ1XRnv+XjfMgCUnC4=
Received: from MWHPR0201CA0074.namprd02.prod.outlook.com
 (2603:10b6:301:75::15) by CY1PR02MB1626.namprd02.prod.outlook.com
 (2a01:111:e400:5299::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Wed, 18 Jul
 2018 11:12:48 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0074.outlook.office365.com
 (2603:10b6:301:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 11:12:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Wed, 18 Jul 2018 11:12:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54311 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNz-0000up-0s; Wed, 18 Jul 2018 04:12:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNt-000325-U0; Wed, 18 Jul 2018 04:12:41 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6IBCWve000905;
        Wed, 18 Jul 2018 04:12:33 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1ffkNk-00031Q-Ij; Wed, 18 Jul 2018 04:12:32 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 39A881213D6; Wed, 18 Jul 2018 16:42:32 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while requesting irq
Date:   Wed, 18 Jul 2018 16:42:11 +0530
Message-ID: <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(26005)(486006)(44832011)(76176011)(81156014)(106466001)(478600001)(50226002)(186003)(51416003)(81166006)(356003)(2616005)(476003)(36386004)(47776003)(336012)(11346002)(305945005)(126002)(14444005)(103686004)(90966002)(446003)(426003)(63266004)(48376002)(4326008)(107886003)(50466002)(2201001)(72206003)(54906003)(6666003)(2906002)(5660300001)(8936002)(36756003)(42186006)(110136005)(316002)(16586007)(8676002)(52956003)(6266002)(106002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1626;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT064;1:C8YWwj5eMaakuhA5gDlV4KKj1+RPqvjmz7nNg8HUIhgQKXCjhVwOpcifjuXrzcwQUNDsr9XVs87Y37u2mWUtTqm7EjYIheVpj7+Ja7PZxbhGvEjPcMARbQxwOPO4MN0n
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb160196-e436-40f7-b7f2-08d5ec9f64fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1626;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;3:3bQLWOFYOyeCwhIaqkK29hbYV7AQsAz2MtArjS5tx5pKgKTKwYKJApH3XKk/gKBubqRnJeLcP5A8EsmQOjd9X4FPtlrd5S+cupaaNXdapuEcIimAD3+P6VZZakeIYmUiO42RnRVzQ2/CCBkEl4tDGgSRkEehXALzRLIOOlQ0vyOUhz+Qr+przF0hvu1wJNn43r+ddoaN5GtJQBB/8JKxIBww8jKa3ztmDkYzNEzA3lntC1LINUvK+v0JZ+Vkik/tQso3aZv4m7k/ddbaI0tuEq+A9afXav+ehmE1NjD2NVCeha7Ao1JsVId57AvCDcRmtYXpRsG+5vFO8zWbZVHiQK/ZJMQ1taTdL2ZQ9qco7pA=;25:YWoRCyHDHUiqYh6Zc+jgQsv951gfXVUMpLi86K6pKHafa6D/ZnY6ZP1zLbGs64Jxkyf4Rqvg+G6hYi70vIFVJadR5nO28V0qqgcjkyVlbgbIEhPhyxZDYFLaTvjxmsOHPBhnHP7T4bO92kWTQHrVY7LLjuILIkmeoYF9E53RAiXXLeNFBxjYoLWDKGP5iWz1N7sU8JED9PrH4Lpw7jwCjxJSlBEr7bbm9ngmzuVgqurS5z1XtkuZxeTfonh/9xfi7LmNp7Q/H5jCBohalGiEMrG9D86HpssDfR6F/iAmdnVbJZpKfWCcS2QzNUIu0m3yt29lbxhhg6RvBAT6VbKbv8ATcCho34zBgAOdZBN44YY=
X-MS-TrafficTypeDiagnostic: CY1PR02MB1626:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;31:LFq85sKX+i801bQiWCH7uGFVxFSRO1vuEMTCYE5sM4yyoyZz9MNLhJai/rEm9N3btSnBXp+cuo3yUmv7urQISMhQQqKsRMOlCqslPaZRH9lV1JNs2YF2mSDucLrUewm2BTA5wOuymzX6blGcYSu2R9etMmEDcY6D6cRirUQE6XG6YhGgG19Fw/H0Renwtdsd3qcY0tFihghl30d30EaAdUqRQ6ixRExzcDA3o4RsT1c=;20:jYTSe5KeohCBAVgYYwskoEtu5YjOQ67tIra7YICAS6e7LIGVE1IlL/Anbw+OZdlpcRImD0qCL5Uutp0Vx0twH1lZ8YXzoRbOI7eEUvuQO2d7uCwFGOSonMG0W0mp++Ark4XaOEnwIUy69e6qWYwPDs8VxixujqmuNuLF3W+r3/bcYCxcyP6+L7JHE9ZBk+0YJpeTAIq5uUdpu1Vlgd4ra130Iopn2Eht4mA6Bt47AzMBuu1dmsoc48WxXkMDFhaI/M9TIZXmG0Z65bg+jbhRZ0l8xSNEFPUeG6w3c+YkQQEL7HZjot/ODillm6+2RNIEMWSsQEP+W+gPHNntsALDSJTQsCoei59Zwiq1zgCbMH+woiuZ9sm5XfRZ8RUEWhGx14nwycFLitQ/0gilFgGJ9nPzn5TRmOImx1xUsd+1Rt/c3pNv+pwDxjc00WcsgDJnrqyf8q2Pb3wjb0tVhn4QuZ7ZMxvSw/FPKK5eXrnPUdPYt3Mlo9DgaOu1MJPtMc7u
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB16266B3E3E3715F8038387E9C1530@CY1PR02MB1626.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1626;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1626;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;4:066HOZLIfdlnetxlV82HB6SxuUMPdZOKil527eeXmSxjWP4ppsRzihlsJqC8bm9UV8ZIarZ1/KDyUOlmZOX1b8Vz1rDjK6pRX3jbC2EOhJ82VoL3buVio86aoxcjhqqi6HbXPz1oE5hqO9LRkmHcInAcp6slQNNTZkiAbSVJX3hM9mcC4+ELtQS4y3FiLJV4ATPRoQyKHQWvHKXzS3Q6jdzuQm9qCKojZ9tHlVPNAX3+qV2OxbspUce9tt1dDb1bVn12k0l/U2w6ATx8vMsBMZMydXKdGQlZgXIw5TrPNmv6pteh2BU4pIAUYRRWmAN6
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1626;23:fPljU288XAitEHBp1NYp8qmunsY0OCzHAHE1kgzUW?=
 =?us-ascii?Q?Y3Rx9x321x73gJ+E4pWxOdBsqu5vz28rMdrV8mLYwe/pcQJuxoaTVL3tBRA2?=
 =?us-ascii?Q?L7xKHVMcSX9yFYPqRZo5192Z2W4x2YTDbwkhEi5E563xOrNrgrl1OCSBCsGF?=
 =?us-ascii?Q?LmOj3IWJ4RqZtntIFq3a97G7m7A/FJSLI12JsyJZKBCJKXuBu/qYrGsLdB+2?=
 =?us-ascii?Q?IMCGpU49252zpICWJZ1Si88t8L4PKx2bYSI6QFo1yiDLg9UAQgk+YoMacMtc?=
 =?us-ascii?Q?wYkz5neb3QsFRGzGTnCM3ZDhFdfWOFn/0ARCrgVWhonI4P+pd0mGAxNHsWZc?=
 =?us-ascii?Q?VJfF86g+vUOgWq/KyV4kdPD2hfs8m/T3TzyrAUhznZces8vPOp+1ps0xdIXp?=
 =?us-ascii?Q?QyLyyVA+cBTQVTgsZf/Zf5btzuDf+38zJ5F671Q18KO2Tkm+pK9ZnBhe+jfe?=
 =?us-ascii?Q?JPUT0HHz4UO/umGA8AVZp6DKhyuXD48IH734R4cQT11TweWNrdKwj9RdlU+Q?=
 =?us-ascii?Q?yUPxRydAob4fDLAghAOV1S09ZzOJKIqKG/DDm2D8A9R7Wy8J0c/5vehWnNDu?=
 =?us-ascii?Q?oEqAE0RSJBoV/DGzUS2CDcXsI3JJ4m1run0klQM44Oei8Ej7rXK6gCu8hgvS?=
 =?us-ascii?Q?kc4yPcNeb6f8G4a2LCO0/HFpMT2vh8ev0U5h22XoYDqsV1467c+HvBBqGQJ9?=
 =?us-ascii?Q?0E1epzU131R20ueY7e3DTsnO5nSSNbs1LA+OjvYLQSOF1xLJqn4o3U2kPRH7?=
 =?us-ascii?Q?M0Qy14w3iMGG3N8rTzVwjWtwd/80kC7SDtHVOLRDU2yk3goJuC5QuoOMsujk?=
 =?us-ascii?Q?9YvO2qxf9FuHM/U1pTCewm8eQHy+ZGOWTN/hu/7zsVg4598gn9XN/uhwzeMV?=
 =?us-ascii?Q?Xga8RTuMcnzN9xpOq4Iv8JHtIDDctc36RzbSs7j2nuHNobsbaRJbV+zfBdoe?=
 =?us-ascii?Q?QpDzckxWfW2tgdGd2PqLzTC0S5YyWVl2X7rnnMuPmVTIDdXeGQ1GHb3d4s4T?=
 =?us-ascii?Q?oZWksS2NY6vb7uL/Fdh6wHqmjg3ZpmvOT6QF79Im/26cnaLXELn0Kyo8nxlG?=
 =?us-ascii?Q?8nO6itw0y6Wd9qcCSSXzn+VrKvfeVTW4c/CxqHf3C6OMLF03b2/+BC3TGaAH?=
 =?us-ascii?Q?bYWRQISKg8suA8XwKGdl9d/H1MKpaYbj43VJCy3Qh5X8IfV9PM7SAAk/sZpz?=
 =?us-ascii?Q?jzzS6wc1ecWC9Z1r+WU/kPl5FBV7mFCR/ObPmbwitkZbLfzNPsgHJT9Jel6I?=
 =?us-ascii?Q?ky0IuG0u/kACqFOlUhvR7P0qVmSAh9UXV1FthGqnDoxMOyrFpROkPAzEJChd?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: Zs/rNWwP6hvSVyB8RjcULFQ7VTOh6X5ERXc/BFfWOL1qof9NVIF3UVHpVdp+ybGv0cPLSUZ7TDV/zYBoS1Jc4YCBch8FuONZQlNzeP3Kkptw0v7/VKU3Q94NuB5aKaDkXE4wPLppL3wPeaH+gUXK7oyjm9Dxp3ncz62VXAaQ5U4g6wvRQRvlp3EWoEih5plt60hfg4+jCywhk+xA4nIXDYJrnkZWcep2Vpp8m86KXLWJ4n9RL7EoV3qcIPLKmKT8Tz7jSol7O0ggocxByHc0UA1bRz1K4RkaCs9q6NKokzfolv2wx+qv/Gjdj4AQHfpQFA6k1a1aQdrtY3VJNn+YidP6B83s/orPxCh4MzcZa0c=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;6:zNyir+tMj45a6WcbTs2GhM9TgIzRd+g30VfNM8Ozz+ePtBBRm05jJSa6PqRTCAyldx+cZ2DWXyVRbeF189N96AJICCi9p0j3hCLYY+AVyd6hTcBs3wp1aewHWFh+AHWz0PbYhYIB2HBT99RY1E9X/+L8g+HYzIFlwJV4UdnuFk55KYIwy1a+RmV0p50DlHwN3ZtSfJuootaYygEo1+QHgLIJiR5zzd/cmVDcXVC4H5p15Sui5zg1EysLO2px2UtxbFXjaA5yWZRX/j7ZWtS1M2NQVDnMzKx4JUW1bwWoeJTMn1jzW4aIWq0/cVLgagHe7PZh+nLo3SFoXymqw0076Xz+dWEq9NCfkYEoH0ZWJTLkZ1H7ddNjLX3eQjOCwD9jMiUfowgj+C2ol5PrOej5JUqaH4dY0uxg2nvagOlyh1tLPV8j50Wg36N0p86ysTpqUCIWCFQFXMM9jMWdg27+QA==;5:LCGfzwTL84C6h+JFP72LrIjszCn0Hn0L8Raz1QaOGBh0jn2K6WKdCVliGhHjN1dBBL8FR2EDf281Ff1Mq8LEfy8E6xfu6pHAc5moTSbQlUDZqfHtW+bHzmeuLCq0VY1m20R+yj5CpNUdF7qFvOeWM5ejLlI8Hwht6WorOzAx1X4=;24:cp7EK7kYnIW2/QXVN6Zq/pTkgueh+Ulbyv3TQQOtHydMgPJfXU13NLnyk1FZVBCd9lRHGmWvM+zJGpkR3srKT4IsCe9Au4zbMrJ2QIbibhY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;7:7Ak2rP5r0dHosTQpU0WZh/aBVsDVmFRf8qelRtiYoVxToAOiLdoy3OMRLHe9eGrtEQkCg8KvlIlgUgOeZFEUihgiflxgH2B77Lo9LE1QFDJlUBemBVWt5w63MS5KY0ynv0RYsDACg9t/XanwUAajhyHVkfgFEK5DgsorAJEMrBC385857cwslQ3atZfv8NwgG0aHcAEdY/pjwBDL0c5DjMetXntUNvTzNACSyxV1O8ima3Yvp2fC/bfnzKAOS12h
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 11:12:47.8663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb160196-e436-40f7-b7f2-08d5ec9f64fe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for using devm_ functions for requesting irq.
This will let the core free irq itself whenever the error condition
happens in probe or when xadc_remove is called.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 47eb364..7cadcc77 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1229,8 +1229,8 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable_unprepare;
 
-	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
-			dev_name(&pdev->dev), indio_dev);
+	ret = devm_request_irq(&pdev->dev, irq, xadc->ops->interrupt_handler, 0,
+			       dev_name(&pdev->dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
@@ -1240,7 +1240,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	bipolar_mask = 0;
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -1250,17 +1250,17 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
 		bipolar_mask >> 16);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	/* Disable all alarms */
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
 				  XADC_CONF1_ALARM_MASK);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
@@ -1281,14 +1281,12 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	return 0;
 
-err_free_irq:
-	free_irq(irq, indio_dev);
 err_clk_disable_unprepare:
 	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
@@ -1310,7 +1308,6 @@ static int xadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct xadc *xadc = iio_priv(indio_dev);
-	int irq = platform_get_irq(pdev, 0);
 
 	iio_device_unregister(indio_dev);
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
@@ -1318,7 +1315,6 @@ static int xadc_remove(struct platform_device *pdev)
 		iio_trigger_free(xadc->convst_trigger);
 		iio_triggered_buffer_cleanup(indio_dev);
 	}
-	free_irq(irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
 	cancel_delayed_work(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
-- 
2.1.1

