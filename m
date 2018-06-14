Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46334C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE34C208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m5ffhnjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE34C208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755502AbeFNS3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:29:47 -0400
Received: from mail-bl2nam02on0088.outbound.protection.outlook.com ([104.47.38.88]:43139
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755319AbeFNS2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86xRIzoPoIxG+CVTjruS9kskdmxSFLFEsDjWm4I6kTs=;
 b=m5ffhnjlME/SL6RKfRhA+OZp5g8ZkMKSYvYnw++SSJ3oyu6KA0jyxkiEc7wJW3twVr+qdf4179j5IDvRA6IB/H+7tBWAZOmtj7dD5DBr3sRybWo9nLotj0MeLdX/ey0gVE773ngZKjX7w/sUNe1SCsAPumr0pt8z52NGhY5Su7Q=
Received: from CY4PR02CA0037.namprd02.prod.outlook.com (2603:10b6:903:117::23)
 by BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:56::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.17; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR02CA0037.outlook.office365.com
 (2603:10b6:903:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41090 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-0000Al-UQ; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-RP; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRtb2017079;
        Thu, 14 Jun 2018 11:27:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-UP; Thu, 14 Jun 2018 11:27:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v8 06/10] firmware: xilinx: Add debugfs interface
Date:   Thu, 14 Jun 2018 11:27:38 -0700
Message-ID: <1529000862-11510-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(72206003)(336012)(966005)(2201001)(106002)(81156014)(48376002)(81166006)(106466001)(36756003)(50466002)(316002)(16586007)(6666003)(478600001)(110136005)(54906003)(8936002)(36386004)(6306002)(8676002)(2906002)(76176011)(305945005)(356003)(9786002)(107886003)(39060400002)(59450400001)(186003)(426003)(4326008)(50226002)(63266004)(77096007)(5660300001)(44832011)(476003)(446003)(47776003)(2616005)(11346002)(7416002)(486006)(126002)(7696005)(26005)(51416003)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4343;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT015;1:yKT9kdruHpTwc+vWm4kXy9NC1otWTpItW/2lgsOYBoQQiatB8EAVkKydtNYeXnvnTCjIXedYqPMsassN3//VGxR3kFNQrANQyvDeOG69Whx2Cem6Vgqi2gfG5u6/4I+6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd68bd0-7e6a-4271-df5f-08d5d2249616
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BYAPR02MB4343;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4343;3:Ysl1pPlYaQXjcKHISO1yuVyqgU4kmSexF84ttsTAB2nQZm6ttw0FhFFYdiMkailwQ4/jdFBXmQbBAOSH+lDpVnJkkgU0xNLXLMqyMu0HWS6s3t8mpg2ggrKenKmHtRfVBIY+faj+kXNk/ZdjhRXlULNK2hPoJWhxdvrRKSfr5arv7XQD+DuL+E6kp2QiLPmlEJzKOWlpBDf0EAJaPrOxHti96TI3lH1IY08RRxlR28B/p5ZGUkA5uNRknvCpXAYxGb6QhXGzjYuNkg7GGEB+Udne8enZTr15AjdbH/90ESCzz4p6ENtHP8Vzv/9QBzmRY7I4jEqD2TA0NFd+Cmy9XoDzf7g+gPwc4ZYCZ+zRvMg=;25:jbxAJZP8SkgcU4RKEgHTGeOgRu39GLceyyb61PFbiMUG5Kb7n2JJ8YdZLxLbbofB0AJ9xaPEpjPgu3qWwVjS9GjFFgcKgpM2lkGCGWyD6lITj3a+IjeK6ZzZwpXkWfk+UKWe88dcQBYdJx8Rbw0/Cx1ZnUy3OQ+JXCdcG0krJivcpjQC+gkNAhNVeDa7+K+DD9lIXCitR2we/EMVAQ/0/uT4WzxOn85rzDi3rp5Tre8wceAV98pCM+uv2XyqTVr+KmrWGmH1QJ2Lzek/9a4gwF45JEGL1/UXwzjyU3/gDkaIVlc0RZhtY6i7MSkJXV8BgxBQnMZ3CPz0ab7zNb392Q==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4343;31:EBSax7UTxI8dPon+ui+6WbiCj/jDCKXDimajiQGCbjQLgwis8s7XKa3nB7RziW1I4izu/lGlo1BE/gJR99sXmc0YGhOyLpb94++yLjRQC2jFMSIcu/jsnfWLORtpIa5iirzOBniaHyP0DDryCz8Fjp+PofUPGZFTyaD1TOn7H/Cmw/xMoeC5GUOJNiInHZykTeM1LuqYZkOIlxGInSbbQgbBwFr4P7IWUK9/gy8PGMc=;20:8OpDRAZ6LMPuZPZq1a90+KUtgmOi6ovXBHn56MIUDsFmZpuryGKmekvhSZExIrTAKMxt2kCz0Mvu0k6r+gwoXifIpHB7qQz2v6eyp+6DM3ovQh81cM3mAWt+pm56+0YVaHS/WJ9zmTZ3N3iVZyMnxIW2k86UGk3b0gTpqcDVPQNSIbkIIH7rFFD1hpfpnQ8oohp++cWXJ/9tFSg+dXfxYhPE6B3zhBp1tKknfIM0BSIKbhZICTCiza+83TFYo62ADv7XWy4mzr+SvZZ1DheNy4jsbb1Fj9Vl6NSxSCjkKfg4CC/EL7BYwwNgw5LwqIGko4S7YkjyI5hfCGGKq4jJT2/+1+OZvWBt1sAuD+jL2LHfqrPEJXh+M6JEOn3eHJRB/JrnLQrzboHF24fi4WoQU0vpe+2M8qT15rjfQmIhy5QqgImSODizucHx77vgdnW89d1Fj8pDY0wKmEj4WXu8BZQX2RWiPZstNONDpjzqMRYRICbgmQJx8Z8Ge/c3Camt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB434329EEA63E9689FEE925EFB87D0@BYAPR02MB4343.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4343;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4343;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4343;4:wlhYJsyMhn2Sc4y2aTxC53TPq4KqxPs+JyXsj6k2xvCtrOukdlPRPLsAOBD2c8k/3My90oDO2Hg1gmShidnprugNDuXgNV5M3uHIw5Zix1Jv3v0dKdWK/sWxcCz3JQK/3BlY5Harc6U3TsORTOd0uB6t7uDvrdTJsObmYpp4cxHQpzgI9kPREzfMUzulS5zL7wjt7Z2yAuCTCIHPRN3hwfIWuyJUXLywaukPcedr15y8I+oXVnY1K1BfBjKXAY+AYHo/S7Fh2+A+w12vO9wtQXm1AwgTAYv8P8yRgE0hEojKajyq3NmA1s1NqMPh77F2DicjW51VOuKHKPQHEn52VA==
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4343;23:Yduk3sp9X2hfHIvAQaW7xtOiyUtOjuRVzz4t1Yduk?=
 =?us-ascii?Q?q0fiV8GFinkFCaDj+9vC02XCflTr7+xvXidSu670/x3cmeGNURLe3K7NgSU0?=
 =?us-ascii?Q?wY2shc16VWfKhNvus6OCJerJpkXrTLnX99MHU7bFFdNyTEzMUSoQv+CUvz91?=
 =?us-ascii?Q?TC9yicNAUU5H0c/4Gi1RHuDMju7SdJV6jRvVTdEscU2KiDR+aL+wD5rV2Jho?=
 =?us-ascii?Q?1rI1HdIq8ff7qhrVUvgo2FSpM056HLvzcW1N8fUncODaz/taCPR2pOagCsGh?=
 =?us-ascii?Q?y19ENEivWJL33XOCdq33E87R08l6sDgP9wgUHR6DubVkinuvX4tCLa4BkfzN?=
 =?us-ascii?Q?Q22f9/Ag/7xty7Y1PV5ff4TkWapjoAwSLsvHfwjCL4ZwmCmjXzGScZzlntOZ?=
 =?us-ascii?Q?SyZIpcMf3moaTjyqi0+iCRzJCHGl7/SveaDGSoqPcwf3r0NQS9T0PVgWwkLv?=
 =?us-ascii?Q?6EJgBFu0fIkIjC4JNvlDh9pSZBkr9sifJEN7WVgijk3YXJ/vi30dM9hbyDoG?=
 =?us-ascii?Q?XblW+I7s1V/S8nVupwVzBXaEsd3TrQ+odd4MMCipGNaaqDxORiSF7bwYbXkn?=
 =?us-ascii?Q?ZLgdevi69D0j2PVXxd/0HbtBFradZfalYLAaGqz7IohjeTZ0rOwUqvIULeQC?=
 =?us-ascii?Q?68DPYydaeT6J5zNN5zU594+eTmlprZfr4NqBMhnisdmD6zZe302LzHdRINPH?=
 =?us-ascii?Q?WqeSfPifTpYsE0vRCPMWwHMSXcgy6WmoguQXLMTnrb4nHAgszUBqR6+g2wkb?=
 =?us-ascii?Q?TFgsjEMBWpun07oozOqpXRZrSTtxrOHqiOTeEsvpwMDS6Sy60aFerHAWE7Fk?=
 =?us-ascii?Q?jJaEHbEMRVcqL+7vht7ILIL1cpiwTwVGbC0j+d6PzF8bwJAxh0mHAjrlT+xw?=
 =?us-ascii?Q?ZdbW97iVD3/B/Mk0cdiP9XvKNM0OCua1GQ2Hvt8Z+wnDH4ZxZRNjqh2P9E8G?=
 =?us-ascii?Q?xlFLpL8i4hB2HaTWSLjHSMz6ew9gXV+kTdWLEz7Ag7+qydWrXAwvsz2I/CT+?=
 =?us-ascii?Q?miMxBzGlwHp7RzAxWrKhIl2No7sUstvGid6be0OqOnK+rFu4WRetfXJKFJIZ?=
 =?us-ascii?Q?wEEAlOu38aWemK/ZYnAylwQW/+XtfDb+UEG+c3BK/3AdoGqRMUDHHucqf4E9?=
 =?us-ascii?Q?9pdOAbDb0iW9TPYrsmLrlshP8q5TCV0o1uqEtzwHmBps4BtN/JtM3fYcrVQT?=
 =?us-ascii?Q?qTluoY4ueLIrs5/5299i2WV+V/tSrFueXlBgbJEqGqpHKVbQQ0DV85RcSncB?=
 =?us-ascii?Q?Bmasglfveu6Ck4ZW94+MrsDb+plqd55LcZrevAkOAeLCsDjnPIsLjq9y4626?=
 =?us-ascii?Q?veEcElX86emDuyQBAHt1iYdQS6vLCSVhG24mTqApyPoB6nkna9uBXUAkLZsn?=
 =?us-ascii?Q?ZqlJQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: S9DXlqMxD7C5T1LivX8a8YdN2QIy/382GLzTNOZmCANoVbBitIfvf3REPZGYcOPRaIOwrLpZDEeQfXucG/1Nm5OiBIoQ7P1QGO4Rj3FyifJbqadYaxJOO+upyXK6nKZg4ZS7AwAmG88MAEwcMRLPfLtecFSNdOpSOVEfpZfdO7rYeh5JBHoDw5yddDOsRQrl
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4343;6:l/8Qt5C7OYdvKrAEIXMAm7kb0+vIYPIVkKO0h3HPgUgPxh5nOzQRajvAThtfDKZIy1y7oaXfmm16MqKfNGQD5KH5+LPn2aLpa99gIFdwnM6u26N9Cn0jAMhm11QiOIOY42tVxTrmMyfyY5+2Rs8RjWSho7y4yjJkRWpH+W/ZCKVz4KogU76PRwhu9SG4PEnHhVja7TQI5qG/vXtckO0+IP2yu7Jm7vmqlxTusfkjasTsy8RepD/8hbDFMvk27iyhxcfXvQWvFthKOSvISvvDbv24EaD3MJoDQpiYMoD3YStxEu0MmfoQPgyDrol1BHqptw098xgHxoeEXcNjb30JU81ZVOYDSEcCf1EbJuMmk+tYYSWw0//q/ju6YxM2v0NQEUQAMHDIeoqwX+R3RGTb16jT/0IkXx3QHI6NX6SVdj0uaZuw/mCmKNsobW47VmMQMcgJUpCaF4dtb4Bkoj4Zew==;5:aEmxADjbRAHZZOkVC+LVj2A+13YKQLReh8GO9+eVGl4GXKOYLaNZBqZpo0Lc8ogi0822NN2VEIA7DsDavSedAci/tEaHgYEnNVcDwu29tVUUTd1GExAh9l1GrIWsK0J5nx22Rcc7sEBhebhLT/KagpbVjj3Ko/vPhydgF4zmXus=;24:FBPJDlL/zEfgok+aqsgzPoYSn4qBG3glrjPdRuPKAFnPI825wlLCB8zf4MWGqemr2fko6R16+LXcFgHS/xbR9vZELdSRbZXXLy7SMIjJrTU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4343;7:MMQB8/A1JppBSue22eRJf6H6RL1xaVAIdqg41oskfJE+VynnouCk0IrGJKwWr5SzwI1vTDxOg1WE/FZoKbcthlzl2jMyJeuP+oE6If47T17TMFe2PAG65Ov+X87/jvl4Rbi10eYTG0nRg5MYYIy+EC6omygxKf82UsGnzvcEOAxOuBtR1jcniwr9m1DnQci8v18QUX0X4XBufkPFe8hTn6i1hhWvaTH5Mhz3jqwnWGlNXgeR3mEUWvfrMfTzgPnq
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd68bd0-7e6a-4271-df5f-08d5d2249616
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/.../zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Add basic debugfs file to get API version.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   7 ++
 drivers/firmware/xilinx/Makefile       |   1 +
 drivers/firmware/xilinx/zynqmp-debug.c | 212 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  22 ++++
 drivers/firmware/xilinx/zynqmp.c       |   9 ++
 5 files changed, 251 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index cce4e4f..10faa10 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  In doubt, say N
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  In doubt, say N
+
 endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 29f7bf2..875a537 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
new file mode 100644
index 0000000..4800366
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
+
+#define PM_API_NAME_LEN			50
+
+struct pm_api_info {
+	u32 api_id;
+	char api_name[PM_API_NAME_LEN];
+	char api_name_len;
+};
+
+static char debugfs_buf[PAGE_SIZE];
+
+#define PM_API(id)		 {id, #id, strlen(#id)}
+static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_GET_API_VERSION),
+};
+
+/**
+ * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return: Argument value in unsigned integer format on success
+ *	   0 otherwise
+ */
+static u64 zynqmp_pm_argument_value(char *arg)
+{
+	u64 value;
+
+	if (!arg)
+		return 0;
+
+	if (!kstrtou64(arg, 0, &value))
+		return value;
+
+	return 0;
+}
+
+/**
+ * get_pm_api_id() - Extract API-ID from a PM-API request
+ * @pm_api_req:		Entered PM-API argument in string format
+ * @pm_id:		API-ID
+ *
+ * Return: 0 on success else error code
+ */
+static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm_api_list) ; i++) {
+		if (!strncasecmp(pm_api_req, pm_api_list[i].api_name,
+				 pm_api_list[i].api_name_len)) {
+			*pm_id = pm_api_list[i].api_id;
+			break;
+		}
+	}
+
+	/* If no name was entered look for PM-API ID instead */
+	if (i == ARRAY_SIZE(pm_api_list) && kstrtouint(pm_api_req, 10, pm_id))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 pm_api_version;
+	int ret;
+
+	if (!eemi_ops)
+		return -ENXIO;
+
+	switch (pm_id) {
+	case PM_GET_API_VERSION:
+		ret = eemi_ops->get_api_version(&pm_api_version);
+		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
+			pm_api_version >> 16, pm_api_version & 0xffff);
+		break;
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write() - debugfs write function
+ * @file:	User file structure
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
+ *
+ * Return: Number of bytes copied if PM-API request succeeds,
+ *	   the corresponding error code otherwise
+ */
+static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
+					   const char __user *ptr, size_t len,
+					   loff_t *off)
+{
+	char *kern_buff, *tmp_buff;
+	char *pm_api_req;
+	u32 pm_id = 0;
+	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	/* Return values from PM APIs calls */
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	int ret;
+	int i = 0;
+
+	strcpy(debugfs_buf, "");
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(len, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	tmp_buff = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, ptr, len);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the API name from a user request */
+	pm_api_req = strsep(&kern_buff, " ");
+
+	ret = get_pm_api_id(pm_api_req, &pm_id);
+	if (ret < 0)
+		goto err;
+
+	/* Read node_id and arguments from the PM-API request */
+	pm_api_req = strsep(&kern_buff, " ");
+	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
+		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
+		pm_api_req = strsep(&kern_buff, " ");
+	}
+
+	ret = process_api_request(pm_id, pm_api_arg, pm_api_ret);
+
+err:
+	kfree(tmp_buff);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read() - debugfs read function
+ * @file:	User file structure
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return: Length of the version string on success
+ *	   else error code
+ */
+static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
+					  size_t len, loff_t *off)
+{
+	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
+				       strlen(debugfs_buf));
+}
+
+/* Setup debugfs fops */
+static const struct file_operations fops_zynqmp_pm_dbgfs = {
+	.owner = THIS_MODULE,
+	.write = zynqmp_pm_debugfs_api_write,
+	.read = zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:	None
+ */
+void zynqmp_pm_api_debugfs_init(void)
+{
+	struct dentry *root_dir;
+
+	/* Initialize debugfs interface */
+	root_dir = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, root_dir, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..3303b37
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_DEBUG_H__
+#define __FIRMWARE_ZYNQMP_DEBUG_H__
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c764d6e..83d2699 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -551,3 +552,11 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	zynqmp_pm_api_debugfs_init();
+
+	return 0;
+}
+device_initcall(zynqmp_firmware_init);
-- 
2.7.4

