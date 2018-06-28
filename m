Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3E23F6B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Q/5qY89P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF3E23F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeF1HkJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:40:09 -0400
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:3657
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933822AbeF1HkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCIOfudqmCYmvVMf2TDApFlfIKqr2oSUTCnqi+aclU0=;
 b=Q/5qY89PvSHOyS8VaVLBIDBAmpXTfh0ouA3nIt/bmtLF+YJ5zD0+71RHSLKyLRBStQe63JauG8tJREu7OSiDNDxm2DeIF3PoLcwB5yi4PJ7qpXDVLSKB6EDn63oaX1IvUHuILQtviGkD8/BkcMEceOUEA0gzDa0fUJ55UHkAXVg=
Received: from SN4PR0201CA0054.namprd02.prod.outlook.com
 (2603:10b6:803:20::16) by BN1PR02MB168.namprd02.prod.outlook.com
 (2a01:111:e400:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.906.24; Thu, 28
 Jun 2018 07:39:59 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by SN4PR0201CA0054.outlook.office365.com
 (2603:10b6:803:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Thu, 28 Jun 2018 07:39:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:39:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34908 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRX3-0004OD-L7; Thu, 28 Jun 2018 00:39:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRWy-000195-H8; Thu, 28 Jun 2018 00:39:52 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7dmHP022806;
        Thu, 28 Jun 2018 00:39:48 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYRWu-00018W-Gs; Thu, 28 Jun 2018 00:39:48 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 9EA09B20956; Thu, 28 Jun 2018 13:09:46 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] net: emaclite: Remove unnecessary spaces
Date:   Thu, 28 Jun 2018 13:09:44 +0530
Message-ID: <1530171584-20673-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(2201001)(63266004)(103686004)(52956003)(4326008)(106466001)(90966002)(2906002)(36386004)(14444005)(26005)(476003)(48376002)(50466002)(186003)(426003)(305945005)(336012)(126002)(110136005)(16586007)(47776003)(2616005)(50226002)(54906003)(478600001)(42186006)(5660300001)(316002)(11346002)(51416003)(106002)(486006)(76176011)(36756003)(356003)(81166006)(8676002)(81156014)(8936002)(6266002)(446003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR02MB168;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT049;1:OEACoIRbN5EhB3bK9/hKfHRG8Kc+xgdNOwnbDuhHQfiwOmvhEQv9r6ZOAuOluT+I2S2rM8lx6/sA6LTwb3botSLKrMz77WiOnHcHe2jLs4tXP2BDzFgDEsnQ0eI1kAHG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b24b96f-1ef6-436c-3a3a-08d5dcca595b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN1PR02MB168;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB168;3:mnDbcIzf+xeJj34RHIsDjzIMe1dv2uCA/Wzsy4yQJ8m3zFZufkEMWRUQQlgigUyQGqBcBp8wnWxwPyG25NPCcKF5v1hXhdQQjC25g2YMlZtlLjdeHhgf/X7hAAl9KtVi/q536mDH1IjNh8UUNwTIue6isBr/BLs/gUcCAcKDHM47h/pPqbBEmy78r2PGbEqmZ70SpQMLeIIQqdnOl9eX8Mhfhy5afTr+eQkF/RXwX+3eCvlJSlteS8bbLk94xgAvYctrfonQ46NdFUY4k9ysmmgKxcg05qyMlipT9DJslaFhDmJnlPrWJqwDHSpligL1gZoy8ip3KW6Xth2zLseem/oBTjDsr6ZzP0t0ezAmGgc=;25:0jhOZfT9vElDf08ap3126I5VyAfmCBCnjOLru7MCx9Tp0j3irWrHYlv0bM218zwGn7Lg5/KI0nTK4bPh1H5vTO+mlsK+5jHNonEb2oeLq/CkuOO6LOydyeWpaNs6eB67qn12k5xzD+H2mR75RO0ECWoWojeYezaXkO2Je1M/Eu8UxMLDU0paHTk0/quC55Sv0MVJrL4yZFR9ZH6sbOLUzkUD6t6d7YRQqgjy52yOx0xsatpSzMhYTa96oMPnqPu3jSI4YcUmlTnH3MLfR8lbt4BTjss4LzcZSAG429vWt7v8OwtWiibTiyZt9Q7HPuysmM6Ofh88SJTSI9qJdHletw==
X-MS-TrafficTypeDiagnostic: BN1PR02MB168:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB168;31:M7i/VxdoCfuiTp5kUdSC8iem/A93Ux93lOveIcIMJN4rf0ZA7le9RckvKzbZXRfixcKTB43EYIxx0bD5bVZU3dbrwWMADnjf3BqAHNSJdaquYdv9SosXQOFPPpz4Tf7qEBFQZpxQY1Y9Xwq0dDQx5WuE0xnGv3q7J5e3UGrl//Uu8++C3hw2vH45b0jAmyqfg1E7ab/btSkRhMdImv2pEEp38y4Es87GaPkY0k2mY+w=;20:xl0PG8Nek8X4HfmSGTF/K8LmnVzerzZmOYbsztGHNi5xVYeonesh3+RMVjXwSboGbrJtlJYXrkzpINiw1sNvc7/l7b54gmIBijFymSlP5gt1ozebelUXcf8rdZ6jV4FnETGwheB1mE8yHIJKghYqMoyW4EmV2ht3ui3LxryNa0CUyr2yBWSE/p2vS3Wpll7gEM5cmT1ixG8ypGjrPajeqb2zjNifjzfVKqnWQvOTavHs/F/xXScHFgNzTO1OK5lzoqs9dUqvmW+CqVJ/Ff2CJDexm7J78chWKlnnT+l6U9sn4cgCJb5h4bRt1LVSsKvraNvTylmlT347ww8zXy/QWXTu79YuyUVxJoR1+sD51tkdPoWMGdPeDH6EHDrsX2IVlwYx1kwzsQenPJ4zSMp9F8BTrRUv1PbuF924PcIIpbbGlwcbMG3gC7SWiRO0hbZAGjehaxsacAO1MWYMEhJzXvM3uhZk0PC1rT11y6JZQS9FaRNYIFPQO2aZThbKlv2H
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR02MB1688BAF93AD9B6B526EE58EC74F0@BN1PR02MB168.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN1PR02MB168;BCL:0;PCL:0;RULEID:;SRVR:BN1PR02MB168;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB168;4:Pc40yiS5DAcBvniMxwztNvChjryMh04GloSz8f3VxJIGnfgoKAGoAcZNR0M2S9T/M27y6Vk6gvgDDX/Nb0Yj5xHTMQssR1FMDXa5UBbo8fGWrCEV12XRCqheb+lwpVRFqyHfDH2gXalWXxKYTNOpWhEYpkHxDSBv3lzmtetXj3zZn03s90iA02qeQU2hNf1yVENmp/PH0T0l2LYMfxgKcZu9i3NqVZUDN0GybG7zTY2e9q1rAr3k8yNnwbTtWBqp7GHFPc32V9mIkf8FwrsNd1s5V7FNqEFNEyvvgLBchT3gPGPI7DZx6d+vMygm0VBl
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR02MB168;23:z+UkiIm0snnIW7X/1qkJvFXh+o9WTw700kDxazDTqT?=
 =?us-ascii?Q?WsbyMruQUjf8qDfCkHb2n0h0oXAtzhKJ3rzo1yRWfSm4RSHz3AOnNTSw+5UW?=
 =?us-ascii?Q?hKZB8gnUZxtubRnJBqQHW42sX8zPOIt8nDUWKrf20hR52mmBZjDTcAsWJig/?=
 =?us-ascii?Q?KIGqXKN6tpe/l4doftKUjNz+fhzf+U6gDiwVRqczjKpEItX0kGrwrzRLhXSZ?=
 =?us-ascii?Q?BZ9cQJYpebOEC5LUQUPlZ0+G+G0edD3EjptB0YRKdby0z4iPBgUhdFwUaIFK?=
 =?us-ascii?Q?ev1u+hScZGWksb/hYYc1amY7tHALtgvWmT5BnsQ8jLYWBu6sslCtokWmoa3l?=
 =?us-ascii?Q?A9WLZIic6ie3SV4B2KV9WFS46x4RwGhWSSYGYEO8FepuTqApUrucY7dvHboO?=
 =?us-ascii?Q?I7qYsTpA2wHo3krhD+vGLe2Vzy1JBp0Wwp6/6GloXjsjXII4FYdy/TgNYyDX?=
 =?us-ascii?Q?7a4iVrwgjTKeZ31rf8SM6eWqDFiEPw5lJOQK3xsmTQVE1uesDQmjRT1EMM1+?=
 =?us-ascii?Q?toEYXotIGHEtxDH2TDM5zDsuTN2BS5abHlX+xA0XCfSsJGwn8UoqQ7FFaZv6?=
 =?us-ascii?Q?qK4l3SWC3SX+sVzPbuBwbzfI0sbD+isR+A0/WRLF6lRHWibPAVApk215o4s4?=
 =?us-ascii?Q?GHV0X+WM6yasr9b8pWCsKzMwCdEG0BRKAXdk4s35cl0WMCNl7rTeBAfKe95R?=
 =?us-ascii?Q?/aJDBTMcxeY5wg39MmpDKZV5usPnSRRPCvNOLy6JG1s5qFbD4MvW1Z891tXw?=
 =?us-ascii?Q?pzc2gIqSmDwVBHVvVKxuRElnASs7SlJAJ8/zvycQXlkQgXY8IALBTkDdVEB5?=
 =?us-ascii?Q?0tTMTdvgS4brXKgSa0DX7LUhjpWEVSEYagv/73ktyCD6x0Hn5biT6F8LYe0p?=
 =?us-ascii?Q?Uq3N+c5vOeJHSl3asHUmuTNouuONpAiNq3LJIokn84Cvnt8z2WQIt4tCi8UI?=
 =?us-ascii?Q?txzkbIyafTY/o1zQIDYaC7VUFjobcC294jYRj7GA2RptcREoCWZv94fGn7HM?=
 =?us-ascii?Q?J/OjAOgKdGvh5KG19oW2GmAJHn7k9+At3FLzkqh5qFITR39sYteXlb/ofN5s?=
 =?us-ascii?Q?pE2KGvUn63Gqp7o9dAqYoUvynCfRaNDMyyZumaEpV87Oj0vT+RSXZndub2SY?=
 =?us-ascii?Q?yUrTltF0c42UGav1oxtQ1h9xRsUESitW/Fkh9nWRcyFbsFrQWpop+71aXB2r?=
 =?us-ascii?Q?bN3uFm72iVEB4=3D?=
X-Microsoft-Antispam-Message-Info: Jcy7pZBRvTYtjnjxcwt3qONiGZ1gooFV6k0wRQ62V3r8XwnZOo7vdV/cX89LDYyMnPlzu2Y5rTdOJRNLpl8ChJk44uIwPYz1+upRTaenwtWsRVOVqwXoo4YiGrQ60d9u1meq1P/bA5Qz/5/+hMNK7XZkCvRJ9jrKwd/h2KTpZLRgizY4fJ1/yP53wB6iL1+hiLwf5iP8dgHBp9+QfIi+w+xRlGtxsTGE/fDngLcSvVKAH+5z4LFLfOqP1qRIv68xXCEEnWcRcvG4hwoEpKR8lh5wMJi3/oumWzjvnH6f6gcLyJ7qfLZ2V9s8OgSrtHByj4YqzJLY83a5A6gJpctboXmjVgD+DiELw0dGYTNIkr4=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB168;6:rDKX7p29KgR2nIVPQHhGX7kDUAPlRv1NN/Qa9cnn3OEUgVzH37G8TdGJssFszDix9XpUwOoXkfmZJ3SN6Z5A5g7Fbf0O02V36I6DauDwHeefXKM14vv8zQK+p+fVPauWpMuXUyBaR8jKi4D2Ii7i0ICJh3aYx5Z8Xw/eD30w4t+/dPNwIMjQMMcuPztZNQC9VVHD9Ko/6eIyNr9KUZl5SZSu2CvKxYo/u0OySrbYeOYSgIVHvwFn6QafffoLusBHr2Ukp4DB8FJofoj3GKft6jD+Z25N50VtH3Z9SBqs436hnZnYIZKw5NgQbkj86dO0NlJBLLCiTYG6LOLVeBQv5faxH2rFn1uzLAGN8jCjfAcID4Ey+7BK2IgilDVXCrHou3B7xXJ0/ydL5wZ7MmgBNwXyH5npHa1JzOch0Ye4endXBdVu6Bz9F3kqQQ7zsv+lPY5vewiojtznQ7JTTkCiEA==;5:JsIFbE7pd5NtUk/kCgPqlGIijEazeAtE4F4E1BEhu7FnMkdmZoN+dafDkQ+sFvSz2ENAFzmiIOmNx57hM0aOWI+XuKf5q2Y2t+alPtyPaHLFgIYbS1bQEltZHGYidhKUOmjcjKDsG7gMzINToOMFmsmKgb75L9fwnSo02cGcLyI=;24:hUeBa2jYUARvOwO35w9yLRHrSFzXBTgqUIQ4cNxkfsedGudld5g2QDktgjIlwYznzC0kIOWqDwKEelTsvA6+680Hh7TwAWS6ApJzW2jaPgA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB168;7:n3dyNLUkcD8oQwQ08vz1Vr1YELEOtHQM0GzuLLfJIVcUoN00V4PIoczZduMkqMaEymKVsLmi9yR9IKCx2BaHpEZzIxW9IlwfRlx6wI7g/AU7xZWU2iFGXW0N9Yipn2PtuxOainLhOn3+MGavRA55FR1E4lS4zmt0VImG/Y3urchk78Qn+v62WPhTKdYQ0kxZkJlFrzdT9gIkqvLcMIKWyL9JsU5ZohY2bDNZZ9jj1yFYNEsjswfeq+HB0DThKaPO
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:39:58.0636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b24b96f-1ef6-436c-3a3a-08d5dcca595b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR02MB168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch checks-

CHECK: spaces preferred around that '*' (ctx:VxV)
CHECK: No space is necessary after a cast

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes from v1:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   27 +++++++++++++------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 59f4ab8..8b93940 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -95,11 +95,11 @@
 
 
 
-#define TX_TIMEOUT		(60*HZ)		/* Tx timeout is 60 seconds. */
+#define TX_TIMEOUT		(60 * HZ)	/* Tx timeout is 60 seconds. */
 #define ALIGNMENT		4
 
 /* BUFFER_ALIGN(adr) calculates the number of bytes to the next alignment. */
-#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32) adr)) % ALIGNMENT)
+#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32)adr)) % ALIGNMENT)
 
 #ifdef __BIG_ENDIAN
 #define xemaclite_readl		ioread32be
@@ -239,8 +239,8 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 
 		/* Set up to output the remaining data */
 		align_buffer = 0;
-		to_u8_ptr = (u8 *) &align_buffer;
-		from_u8_ptr = (u8 *) from_u16_ptr;
+		to_u8_ptr = (u8 *)&align_buffer;
+		from_u8_ptr = (u8 *)from_u16_ptr;
 
 		/* Output the remaining data */
 		for (; length > 0; length--)
@@ -273,7 +273,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 	u32 align_buffer;
 
 	from_u32_ptr = src_ptr;
-	to_u16_ptr = (u16 *) dest_ptr;
+	to_u16_ptr = (u16 *)dest_ptr;
 
 	for (; length > 3; length -= 4) {
 		/* Copy each word into the temporary buffer */
@@ -289,9 +289,9 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 		u8 *to_u8_ptr, *from_u8_ptr;
 
 		/* Set up to read the remaining data */
-		to_u8_ptr = (u8 *) to_u16_ptr;
+		to_u8_ptr = (u8 *)to_u16_ptr;
 		align_buffer = *from_u32_ptr++;
-		from_u8_ptr = (u8 *) &align_buffer;
+		from_u8_ptr = (u8 *)&align_buffer;
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
@@ -351,7 +351,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 		return -1; /* Buffer was full, return failure */
 
 	/* Write the frame to the buffer */
-	xemaclite_aligned_write(data, (u32 __force *) addr, byte_count);
+	xemaclite_aligned_write(data, (u32 __force *)addr, byte_count);
 
 	xemaclite_writel((byte_count & XEL_TPLR_LENGTH_MASK),
 			 addr + XEL_TPLR_OFFSET);
@@ -448,7 +448,7 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		length = maxlen;
 
 	/* Read from the EmacLite device */
-	xemaclite_aligned_read((u32 __force *) (addr + XEL_RXBUFF_OFFSET),
+	xemaclite_aligned_read((u32 __force *)(addr + XEL_RXBUFF_OFFSET),
 				data, length);
 
 	/* Acknowledge the frame */
@@ -479,7 +479,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 	/* Determine the expected Tx buffer address */
 	addr = drvdata->base_addr + drvdata->next_tx_buf_to_use;
 
-	xemaclite_aligned_write(address_ptr, (u32 __force *) addr, ETH_ALEN);
+	xemaclite_aligned_write(address_ptr, (u32 __force *)addr, ETH_ALEN);
 
 	xemaclite_writel(ETH_ALEN, addr + XEL_TPLR_OFFSET);
 
@@ -572,10 +572,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	struct net_local *lp = netdev_priv(dev);
 
 	dev->stats.tx_packets++;
+
 	if (!lp->deferred_skb)
 		return;
 
-	if (xemaclite_send_data(lp, (u8 *) lp->deferred_skb->data,
+	if (xemaclite_send_data(lp, (u8 *)lp->deferred_skb->data,
 				lp->deferred_skb->len))
 		return;
 
@@ -620,7 +621,7 @@ static void xemaclite_rx_handler(struct net_device *dev)
 
 	skb_reserve(skb, 2);
 
-	len = xemaclite_recv_data(lp, (u8 *) skb->data, len);
+	len = xemaclite_recv_data(lp, (u8 *)skb->data, len);
 
 	if (!len) {
 		dev->stats.rx_errors++;
@@ -1033,7 +1034,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	new_skb = orig_skb;
 
 	spin_lock_irqsave(&lp->reset_lock, flags);
-	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
+	if (xemaclite_send_data(lp, (u8 *)new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
 		 * current transmission is complete
-- 
1.7.1

