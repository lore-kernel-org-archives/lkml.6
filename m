Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B6620892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AAddY48v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B6620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeLFNZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:25:12 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:5536
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728939AbeLFNZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxmWIgX1KTpdRGbQQ8wz9F6xC8Ru52OPDzEpC0mEn8I=;
 b=AAddY48vSd6LV7CHKvOFmIF8FSP/sg5G9/uVX30Q7aNAtZneQVGcEvdnUT8fqNdB02NYQe3Q28vVqyhUeFbuKa25Q+duk+tZ36UYK0nHQOoDSG3TLUByqK9SI/22zorRP5CXrjnVEpAMA0tQqNTDIRa9RqbUQZcAOQQ/eeM60Ak=
Received: from BL0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:207:3c::29)
 by SN4PR0201MB3518.namprd02.prod.outlook.com (2603:10b6:803:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Thu, 6 Dec
 2018 13:25:04 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0016.outlook.office365.com
 (2603:10b6:207:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1382.22 via Frontend
 Transport; Thu, 6 Dec 2018 13:25:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Thu, 6 Dec 2018 13:25:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gUt4L-0004sf-5M; Thu, 06 Dec 2018 04:47:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gUt4G-0007kA-2I; Thu, 06 Dec 2018 04:47:48 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB6Clgq6005234;
        Thu, 6 Dec 2018 04:47:43 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gUt4A-0007hn-BF; Thu, 06 Dec 2018 04:47:42 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <mmayer@broadcom.com>, <f.fainelli@gmail.com>,
        <ladis@linux-mips.org>, <treding@nvidia.com>, <digetx@gmail.com>,
        <d-gerlach@ti.com>
CC:     <linus.walleij@linaro.org>, <michals@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v13 1/2] dt-bindings: memory: Add pl353 smc controller devicetree binding information
Date:   Thu, 6 Dec 2018 18:17:33 +0530
Message-ID: <1544100454-6357-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544100454-6357-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1544100454-6357-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(54534003)(478600001)(2906002)(48376002)(966005)(81156014)(106002)(5660300001)(106466001)(2201001)(486006)(305945005)(2616005)(446003)(11346002)(8676002)(476003)(126002)(50226002)(8936002)(50466002)(36756003)(81166006)(77096007)(4326008)(426003)(26005)(9786002)(107886003)(186003)(110136005)(16586007)(54906003)(316002)(356004)(6666004)(39060400002)(336012)(6306002)(47776003)(7696005)(76176011)(217873002)(36386004)(63266004)(51416003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3518;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT013;1:oHWEIr941HMCeMV9J2cVbgg6gT3iLiZypotMetVIqyGQ+BbJ9q+c24ttRQB7jJb4kJDNZDxonetEZAGyYNVZN6dJCp1jefTonjXeO7Uk8Swktqfd2gErlLr9NTAYAXcy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642b6e7c-58bd-490b-78dd-08d65b7e3b85
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;3:ppPAak7lzF7+Ux9wVr4M1ebGNOYRzR0EVYI6aRGpFsH0yw/xxcC5XqBc+P87gFp1Ji9gRBkrcD8f2hJ3cX1svyZ4x7WHI/DHiq4v0hm6UG7OcrT6j1iXKVW3JeK74JA6Nw3zezTPrK+h4SG1NIOPxBPLkE4JMNHGCdf1eoNQJVFtmBknteaer5q7RP1z7GpV4qToUk4TZxri7H3tsGoj3lQ2cD7C/omcEMZtEVYTRuED+XdKGiCP3BFeok1C9MCkpAb61HX/MlE5NvLFu/W/XfKQiUUODt2kNUgIuVrTE4K9bqwO6Hvg2bsBCdagIn0KtUkXuiHx3VcoPWa/9mgSge31tqH1IGLi+ayI+R5/bsY=;25:RryiJb2oi5SqUq4f8fY+xGSZICbMu43dwGubByrTw9hf74+w+AFEKScN0tDLwrUPIjew/cUSz43qFAIrq30ke6TBYYbUtblDe7RDjiS0DS54sMX2HEHhKz8AJvtiPAdfrXDgs/CILSCcOE9X+ZSS606UvWr22GBQ+jompD/vTgtFkL9DKtG9CeA3wS1Z6plnTPA143p0GidOnHKS08A8u/kvRIxYf6B3A5cqr5RNhWX/Z4NQSk58i9k/i6f4GVwR++LNHWpeVqsmM37YUvQuArJBZsU8j9Z3dEWxsJLTeq5Q7WlhNw0nA4GvEcMY9YzwoahhrWPOjbxUujz/asOl6w==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;31:c30IvqgNYBg8V3H8e7wwXmJDwB977l3ydAfI6pcH0sUuJAYCeHlUCI2mtKSebgD2jarGmQ4DR2TEgDJNg/5HPV+5mRi0915tdEOuPOt2RGcbCkgspxpv4kp1CSgFvfPQ5V7v4pnB6n3HXSPrF6gPIxQPaMnRvsCKw3+ahKKgLL9blIdeTfb9OGDRGcz6NAF47n4bmm1X4MeEjVSAJnohXYQqptCzSVO5AvU0l1Lvjbo=;20:jcUThVn8NDHPDeYp6QnNsYg2VFFZzYW6nz1D2GVh8VAAFMzTWxMnwjDv++Dwnv84UvcdhZsZLwwfZqWHudI5lzJVsq7Fd98Zlue1mIAj2NdcuVYOTDYnRJfuejQkZ1ThYGDpd4jdbqAwz/yrvJegvyihRGgt+iT97RayQvBJVR4dQ0GxAZBcl75cJp0TDqF/aIFlZbgRXRCg0YowC073NVqecnES7bZh1XnVdA2pYDk8DKqNGhwTlMGiXuNQrx5h3SLBKxr8i5rbU6F5DUGMo6Rl2PHuvXOLDaPjYamGRbE1zYCLhiake7orrDoKplY5NqLTl595rYeHPjDxc3gNjDI+L7qqfzo2n1rNe8xvy6ahh+bv5gPL8NF7Qq5cwtBR6ZwKhwxNKDgsR0Iv9wA8ds3ZNzr1h4V/IiQAEj7mVNxWxPWxSox+XW+f7z7kxoaTKwT/YMLJKksbiYaT+h37LYpTKOaQS4LTu+kIeOaWNPfs/jCj40NsUAuqfFD1J2uj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB351838B96B3F2A9EA7483B2CAFA90@SN4PR0201MB3518.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3518;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;4:3yu5SuwIpNs/k/9nFwNb8iIJlbRscr7TTtRhL6y/cT5hOZvZFLTIBuoz+uDpXud8Au1m8F0Zrxk0zRe3Mbnghg04EJLbBCMWvh9znK4KoOEa0EEOwtqGh2IsoHIrcC8329KV4GYz4F65INuSlISCM7aBFPgYXgKMttp9dmBr8TZG5gWkpSUB1i1RfFNGWvbQZTA5OkklbWQXqrBy5GBfIRoT4WJFa2CafUWae1hQc5h5+Qw+dzP6LTg3VdRfcwHqDlAY9R6fu3aTEgqmlWFRwg==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3518;23:S9bWozssQEWqiQTD0NWVxKiMCa+Dc2LorcPj9NQ?=
 =?us-ascii?Q?9RhrwvNcTwNzyIevj0VlittCxbNZHimJZ/fLmDU+rrweQwX3cFbm+vHJKZpr?=
 =?us-ascii?Q?snr1w6qct2vWzIGYjfoTsUoLAPu8OYSIfTqK1PCaMomvRYtKw3tj+cre1d4J?=
 =?us-ascii?Q?WTHtMVXAkqL1+gUyQhcP8XkvEz5e3XUzdD9l2qxPXbmeNXR/deijJJdJf3+6?=
 =?us-ascii?Q?xxa5gOg9QNPIS0NXguczlzX0iHljIlKdWm4lEJIJT5LMrE0VKvdhjQYv/JKH?=
 =?us-ascii?Q?b9OyysbDSQWebRyDgyCesgfWaSzErw1DPPgoZkJdQMlkuoAiErl91DzatOvZ?=
 =?us-ascii?Q?ezXYISzpshIW6+/pSa1rJr3xCRQ0Xd/Y3sLK1a8eqd4H0tu2Q0WAM1k8mNIL?=
 =?us-ascii?Q?tdmO1xw1MJZKrm2kD9eSiheB3tkBynAhogz4Th74ympxylgYuWQ/sB/bEAQ9?=
 =?us-ascii?Q?99cJBiIrGx3MC4CB0U6VAA9d6Kh3Cs+/SLrlTy/6CaQz39ezb7Fz4drLtGtN?=
 =?us-ascii?Q?9x51JneK0xxOsIilS+kBycZI4o28l01p/aUswZQNHq03WklYvyWXfunAHQNm?=
 =?us-ascii?Q?MBPPdippNPQki6SX0OEILMlsXGFnJd2N+FEj9MiGbHmGfz/rFqI/IYs1z0gA?=
 =?us-ascii?Q?1Vo+N2oH/SuyrawYYFld5xw8ryr8vtTafkAgeapUfPNY3ZgIPyTtCqyFJ/qb?=
 =?us-ascii?Q?5Tdk386bLc+6nImzoHXiPMSw2PlOEupYit1H6QoBkikY5d2G3z3FgA6XFYbV?=
 =?us-ascii?Q?PRDVRCkJdKtJun3MFVI4Yh64tPAFsDXuJ0151QBugp7jvGcSiFOuhG2DUURa?=
 =?us-ascii?Q?mMSexAr2eNeyvKiYIDHfz30HWGc0a0icqQuGqM2G4LCiU2WEBNYICrZo02fX?=
 =?us-ascii?Q?xqrSrDWHOK8mvi6SXbsyQSqDhtgyb58tE2v8do21uAuzZ/ab6zunxTh8zG5H?=
 =?us-ascii?Q?TpBuBoHJDTofjQzmt9yW6lkTimHFCpG6ejI209eXSaXmyi3MpOkYE4CxUoYF?=
 =?us-ascii?Q?1Ulcegj7K4gf3l2bUGjoP02sJ7v8rQ8kE5rXFzjmz3OUqKb++8EGYELmkiMc?=
 =?us-ascii?Q?5bh3icOjb3tEK48v7xq/F32bOdmdWGBPemLp11fhsvjxHd6cejCbKWRAT/3o?=
 =?us-ascii?Q?wCg3+Ey0imNAL7aQP9efxGfVR+Q3H/rNeneNBwbZD6oZ2dfK0rm+yAaBOBag?=
 =?us-ascii?Q?ftIQP3/j4LXG24VQtdkQ63bTjwW9F8m8BYvUYR6YxTvyxBXBd2i1sIAvw7g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: kMDDMOIgBHQzzsvEjLyc2D2B5IOkwM/iSJF/fS7Pws8Rxq+MRJTAJuOyN4aHa/nsdYcXvrwG4oJkrS9v8E2JGafTiU4FrlpLbH8F3/O52cItYlWwvEEfjonBvkV/rPZudKEcda0ptThb4aadQMYPAp7I8FoCSo0uhnMWU86CUYAITot0gEHMbhg7iT6WzAlB8Q9f7H8pQKD4xHy5OU/Q0MH3Pa7cgcY5GVhXowwEu5XA7aTgAwfrkCDCZXIgEnUHh0TmI7OgP3vRpIf4XO/nzQL+Uj4JqOwTO8YlwFPPUbQLm0Fiapvb/ZBDiG0HAVPieUe3o9UyJlC2qB3/d+jrmr7K9oH1bxe0t7ZYDm29AAU=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;6:rQWOevpMkZEmW/7Wadw2kRDD7iRFKqujS8tBEX81kjMMEU4WjSkwjronxv3zxB29mNh9bX+h8owLnSL+6CW5/dS4fNcizV+7XL3+6GY80H/AkV9k/Hqz6YG4t2YN2/BMUyfmGEzl4Ij8UbpenPNgCi87CZlPbQu6JwHUYRkHxtMskzukbfYlPCcNi6+LZ1UcwTCRDxh1IJaYaAmn8CJVEU2mNiKFRn64uZBuIv2cvl66cIS8hUrTRVFscOITjbp4OkEVZoTr6bY+oPcoAa+cJJLoNaw/kxUOgD9SA75EwVPofH+IKwzmZUrk6AXtG2tXTd0M9HJbB4ZYb+GdYWTj6mWp80fbAIh0ugrTYk/LzI3ADFDHh/dVSSeuOa3PFFDQ8gk3wPror+9vCom7FxnynnBbj7qkrvdaCxlwSPniClAN4iP7pHa2N1+Z2o6m/YHDpQ0g7Ws9sSqbXlsUHnBDuQ==;5:R/8xNxGBz9qhxszXchA6MYJqEHvZ5erCkO0WA6jUuQ66vm0f6b7XaOQQiajVe8sAVZWg3r6Hr/U9zOLZYP1dmgLaobNr6ls+hjmsBvA+zJSzlENL4NeX1EB+BlBVMcP6hKdxqa1j6niV4VIt6K2ss17p0Jhm1AFCfusBEG0yqwo=;7:O7KvdrIl92v0Lm4psBXBpLD/4FvCFfpjnN/ZhHq5putOxIJ6ii8qJTErYflPp8e12Hx8ZtaObf+3cgSt3mHljha1fvvuH8AEeVnXo8SJKJftgOFQThhZu+OimH4ifQsR0ICLuUzq0tIP7pM95uvwpA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 13:25:03.6176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642b6e7c-58bd-490b-78dd-08d65b7e3b85
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pl353 static memory controller devicetree binding information.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v13:
 - Added change log
Changes in v12:
 - None
Changes in v11:
 - Changed the subject to dt-bindings
 - Restuctured dt binings to represent peripherals based on ranges property
   as suggested by Boris.
   Now the new bindings uses cs as first address cell value similar to atmel
   EBI/SMC.
 - Added "arm,primecell" as compatible to the existing compatible property
   as per Linus Walleji
 - Changed "aper_clk" to "apb_pclk" as per ARM AMBA peripheral documentation
   as per Linus Walleji.
Changes in v10:
 - Corrected the typos like "should be" to "Must be" and nand to NAND etc..
 - Removed padding to describe size-cells and address-cells
 - Removed timing parameters from DT, and added ->setup_data_interface() hook
   to the driver to read the SDR timings
 - Modified label name from "pl353smcc_0: pl353smcc@e000e000" to
   "smcc: memory-controller@e000e000" as suggested by Miquel
Changes in v9:
 - Addressed below comments given by Randy Dunlap and Miquel Raynal
 - Typos
 - Added extra documentation that explains the HW ECC limitation with SMC
   (Comments given to v8: https://lkml.org/lkml/2018/3/22/23)
Changes in v8:
 - None
Changes in v7:
 - Corrected clocks description
 - prefixed '#' for address and size cells
Changes in v6:
 - None
Changes in v5:
 - Removed timing properties
Changes in v4:
 - none
Changes in v3:
 - none
Changes in v2:
 - modified timing binding info as per onfi timing parameters
 - add suffix nano second as timing unit
 - modified the clock names as per the IP spec
---
 .../bindings/memory-controllers/pl353-smc.txt      | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
new file mode 100644
index 0000000..d56615f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -0,0 +1,47 @@
+Device tree bindings for ARM PL353 static memory controller
+
+PL353 static memory controller supports two kinds of memory
+interfaces.i.e NAND and SRAM/NOR interfaces.
+The actual devices are instantiated from the child nodes of pl353 smc node.
+
+Required properties:
+- compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
+- reg			: Controller registers map and length.
+- clock-names		: List of input clock names - "memclk", "apb_pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- address-cells		: Must be 2.
+- size-cells		: Must be 1.
+
+Child nodes:
+ For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
+supported as child nodes.
+
+for NAND partition information please refer the below file
+Documentation/devicetree/bindings/mtd/partition.txt
+
+Example:
+	smcc: memory-controller@e000e000
+			compatible = "arm,pl353-smc-r2p1", "arm,primecell";
+			clock-names = "memclk", "apb_pclk";
+			clocks = <&clkc 11>, <&clkc 44>;
+			reg = <0xe000e000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0xe1000000 0x1000000 //Nand CS Region
+				  0x1 0x0 0xe2000000 0x2000000 //SRAM/NOR CS Region
+				  0x2 0x0 0xe4000000 0x2000000>; //SRAM/NOR CS Region
+			nand_0: flash@e1000000 {
+				compatible = "arm,pl353-nand-r2p1"
+				reg = <0 0 0x1000000>;
+				(...)
+			};
+			nor0: flash@e2000000 {
+				compatible = "cfi-flash";
+				reg = <1 0 0x2000000>;
+			};
+			nor1: flash@e4000000 {
+				compatible = "cfi-flash";
+				reg = <2 0 0x2000000>;
+			};
+	};
-- 
2.7.4

