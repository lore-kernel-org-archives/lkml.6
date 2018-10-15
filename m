Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB3C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192C320881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EiPLrM0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192C320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeJONOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:14:15 -0400
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:26944
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbeJONOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMxgXdpaNgAtH53DtPuEZr/rZOAcaWNlw0OvpH0MhTY=;
 b=EiPLrM0UNqnMxqo6l8MTAmUYV8Ydt6TKtDTA8vDHylMQAkN8yeqO/oW+1CynPfbm2BqB5cWkUyPO/U58rZ7AvB8QaumStEe05QumcU/BQV2nIS+Q5hkKqHS1QRDJeqwp6Kwf/E0XEGrzaWd7/hAk+rxR3XoFFRHdu/lzz4Wcrd4=
Received: from BL0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:207:3d::24)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 15 Oct
 2018 05:30:32 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BL0PR02CA0047.outlook.office365.com
 (2603:10b6:207:3d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSU-0004Ya-QL; Sun, 14 Oct 2018 22:30:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSP-0002eW-L3; Sun, 14 Oct 2018 22:30:21 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9F5U4br014255;
        Sun, 14 Oct 2018 22:30:06 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS7-0001lg-6O; Sun, 14 Oct 2018 22:30:03 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id ACE321216BB; Mon, 15 Oct 2018 11:00:01 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 5/6] arm64: zynqmp: Add DDRC node
Date:   Mon, 15 Oct 2018 10:59:47 +0530
Message-ID: <1539581388-23963-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(72206003)(2906002)(486006)(5660300001)(426003)(44832011)(2616005)(446003)(51416003)(11346002)(126002)(7416002)(76176011)(26005)(90966002)(36386004)(305945005)(336012)(476003)(110136005)(52956003)(4326008)(54906003)(103686004)(47776003)(186003)(8936002)(6266002)(50226002)(8676002)(36756003)(16586007)(478600001)(6666004)(316002)(106002)(81166006)(48376002)(2201001)(63266004)(42186006)(575784001)(50466002)(106466001)(81156014)(356004)(14444005)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT005;1:ECpiXTgU5zHLj715q80AqUC9GCVjePqAuK6TphFm3vmV1UKI7NrhRs45zMHtjDLis2+j/6janrDjX9hfrwxAh2DdC4BuJjm0aiYdClaGpVQslRj0sWNVieVPBBq0AC1v
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a12d8fb-d809-4518-9681-08d6325f5301
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:B95DEvm1ceq92cRUP3fnCWjM+EWuwlVjDpm2+ksiYb0GBV6S+sE+8aS6VDr6CtPDKkVFEcc8tHsC2USmS4Wgi1jD5tKTKiVDL9PrYuV+7CtHWAo6QUikD7kfK3lqGGndx991cdhCj9YJonIr4Wv+L+6/8tvId4q/3dxJ322WbTxGUJ4oJ5OWOqk2UU1yzTYrod8udcopyseAI3DrL07brTzp6CZrd8PM3KDCNS3whqsznT+l13b2kcdGa8ehIK10ni55oDoireTVPUPafYuGXhWDGKLGDrDF36Dr3E24kCYztpfXWS4UIaAq9PPdjarpzHR+ei3RoAf99BAuzDzbfjU9yK4sYQYtq3lfkACuQnU=;25:MX4IY3/QT8VkfK1vyu9p3R4if5QnEVYS26JLKAguqID9OdhOw7DanxGG25B+elhDl0qRC/WcKNwCAA6EiQ6xO3qX+XBTXHXhv4ELaQ+ZZjygImXNsyD6owEZanvRA5srzGSx/TlyoyB+iJ6V8NSM7VagxxVRN67QLwSRWKy/53f+wtNvJejFR+r+CJOtL8N/318xx9P/3N7mxXIaBCVvAtBmoKJNIP8y3WYZEmWMEl6UbbJQyy/wkFepUzYDhHFsO//ONJy4BWMtehuBE561P1bA/Hw97N+X4wHnJ9fsSgeM1wVG+7X3JK7krH7eijHyUdzwnhaMTaX6eEJAEYRzLA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:QugWpsgFKRmgZKrw9zX7msJ4XCmz6J60Z3AzDkA994iYYefVJ7ymoHJcjVe3wsfulILFHjeLCYyIyZo98hz/vTaF24pk39OSVcCJbdSu6OqMjvdvWn/8Z+ASQd5h6qJBgwEMAryHIgHbj5mzR8SYbXwMlNsXSZutY61Y829F+CzgpGg4jh4SiZRvoUM1JYhWY9jcWbDJZxdbBhrqb5CjE8dDNGHz6q7stG4n7cqNytg=;20:+iZo1TwnxAYHVbd11fZP+fF4j6qIWFR5YZBKJmN/5KBsXIBKK2V/puRFTK5tyf4/qbACzZShDUloinUpd5f9dYGOHkprga6emhRNc39QXXFSwhKo9IY+q4e0qvyEk0kecQrHapT5K59i7I1ONj+B6gp/VdI9tZOByra7Fa+r/pc9mpBWYIlAgdxOSSis05xpH5Jd6EaqLAIjqg+fG0WRa7HrHDq0nvKbFD9VpcatWhU2/SqC3PmkL2njNGVvm3u53x9EXT+WdZ+0DBKygNpYXpX0bOK5oQJ/gytbG27ieTUW4Eq7NSKD+oC4kzU2HcIfFG4y2WfJMX5i7t2vmilKUqOv9iOA+Z9Cdw1xs/RF/Rbfxh9ALCIwCptO5kYm4RMn70TV9yGntudJTBk4eq8IRhANrnp2794f5fqAkyQ/zBlfjstCWqqBRJn0IONSgi2QMkEbSjdcMyPRyJeaZSMU9tTTV69dGVagmv9iyQXQ0y/07xaWElkifcnSKPjbLNE5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43260EB62B5D7D104946740DC1FD0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:H7nkjBFQGgP7MHYro7OO4tmTJsBW2dT4aCcySjWkI3DQe26Ofi3oRbcgUkThKguxFYxWFTBOwokCsAlepRwKF78jcvqh8SDEFkpcou7gSAcy0qFKPLUbTfdr2PCxfdlHD0ZGMKtNCjLP9FEuiggr5/Je6iDKhsLqQXllPef883tyc9ByJPVTBUzPCdBsRLA/5jbI7J+pDfoXPkilQeBtavqifPVWSqWUoeDzVLX4hiHmTPVOEys67UF29jCaMTHL/ttFgezbmkMjikbW8u3naCBlAM3FHWKjxB3+QLaEUFkkGksxWPcBH+5euasmItqr
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:Woc05y44nsp41m+4idMyYanr0LElYSdtHUe5BK3u9?=
 =?us-ascii?Q?LebtkQGO5fIX/PPH2FB5GrtlgO8rihpdkATqY2WTiG0Qybw+KUr+D+Lu42F4?=
 =?us-ascii?Q?9w6sFmo91rSZsWb/UDpSH5C5cxBdlt8KQwatmgSnF9TnKtJu0LStmfu5OKNr?=
 =?us-ascii?Q?HOfyKMwRFKT2bHP3SN/CBAUA3PG4ecrNBDqmyo0vK11E/uKFDV3SdK6nngfE?=
 =?us-ascii?Q?6foEOgL0Bw6n7ayfk4v1+KlUCcSPu4O1JnEmbVPG9e81ctNiUE5XomXD3iN1?=
 =?us-ascii?Q?tzAj2N0w7Aa5GhOd/jeh6grqGmM73uT5Nayow2uOy7/+L29i4tg2lLLNh5wP?=
 =?us-ascii?Q?pnANlY8kdKXyvzMe4yllpeSQBrtdvvHADPs56QvXiCs6+/9nADn+TL7cMpc4?=
 =?us-ascii?Q?aIApAXdGxPCW2e9RGwqPty9129QmX4XMfLP+g6jVGHzNN6b5T2sdv8/Rg4V3?=
 =?us-ascii?Q?lR/QZ2TCV0UU/ZN/YcXY9bwCkJnzTUYQQ++swnYsHUqb0IlZiMrejlbpJtsz?=
 =?us-ascii?Q?hwCel6lGzt0LDTeRC2r77ye/Wdw9w/tQeYiyxNjAlM3n6GxpMkTO4y/89gN0?=
 =?us-ascii?Q?fn9ipxbfEu/GrPnMPOCCFsFv8lmhm3/bZFBSz61hHMaaOf51/alg+7wdPP2z?=
 =?us-ascii?Q?brY/XpqZUCyddfzBv6N7UH9ghBxHqQVQkW1DUVq6r3HT3S2FUvzDSIvPA1gN?=
 =?us-ascii?Q?bFMP+xO0PZQ57AuacRaySJGC//QZV3iG/V4rWX+vkFlKyJOaMMKfMUW3qYH0?=
 =?us-ascii?Q?w/9avgBdG7lYLoxTHLCCLvAvZCB3BnuYyvztb5Htz9le2wBINFUCn0cLhU09?=
 =?us-ascii?Q?i/OKd2b7LzSr2fI74xJhxpTcUsot3TiA8oIQxjEIGQ12p8gxk9eMQ3DdgMo2?=
 =?us-ascii?Q?S95MkygoOpfg/7YKHK9xBM25fJb7bgpbIhUuC1iWjvstooxLDJzoLZTUoses?=
 =?us-ascii?Q?UzOMydUNLEdy1VmntE9v8aSpBNSAspiapU3MoLW4A6HmHhJCHnDYC4N8WU8I?=
 =?us-ascii?Q?H0MJOG4bM7g86HUvRtprMOQeBSXODzUiRDZ7LkM3ZkNIQBrUUOFxfDSg8Rj7?=
 =?us-ascii?Q?dnf5M8M4/hWGFLLkPuZV//e42vzZ0IfiWbtIEONdnvZlLUhZ+3D3SXerAFik?=
 =?us-ascii?Q?0zucs7VSyFZuiM9lHW12/L6d+/ruI1a1aAxpGdVTAXJa1Kyq8hYLqlam9/J1?=
 =?us-ascii?Q?9QL7EooHgG4iV/t6uj/1Evqvqc6njepaFFQip+V04KY5eEbcY5wtAKF+tgrP?=
 =?us-ascii?Q?CJVHX34v5fG59IarYQQAtwt16qMBFtO6y2H/FT4?=
X-Microsoft-Antispam-Message-Info: LOBwqi1H0gSH4aHLdVFAskeCJAo7wHRkkvlbmA45m5wvMz25+i4b4c4pL+jY0Z72wdP9zeXllTVpJcCEl+OCq8QFheYAiLDDbMu5iyPSSYTjbHEKyOtJMN3Lo4Jz7LCvN+TdxNKQA/EdLfGeW6waT1+mgcMqbL4BMCS0mrXkiqw2FxLTgm76VvPZ/K9rG17GffqjlFLE+IqYPZGhPcHoKQvaNsYi1onm7Pj2Ju0YUGNp5GHRo6t92FJLOAQc8k+4K/dbdJ2JlXs0wKffkvU8QMuh1S9uQDNcK9s5it+RBR+Jpbi/c2RJFsamXGJmgMAD2sX0rk3gqgnPBls9YuorFpZS2pfkYmckGtjqK8KyNLk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:WgUUKqqEOM2H6bWP8hyjyG8PQJHVmJ+jFcsHpsSD6VOijziwAmFwgY4YS65zsuZXxXeQ9+eQHr9ZAcmjBc2581u3yFv4jVZ5NM0LAvOKZGfMxoraRvFHVf3OMApg4JpBk5WAhAyiGLbMbBFrFHdq0SYTXHYiP349eafXpvnTZnaQpjPBb+1C3hHOiSgaOWdxLf+Z+kK5/aA1XW6MXei8RBjTN56WDtjijESnmNs0A4IbYD3h0X0yfzgJZJBzBGLmPbuHIQDxpswMsHl18FkOjkrenfaacYj/7AsYEjAVOsSIEpsTSpdk7IVWZKI60bw6WyMNJbYawScMYIfrYvZ4eBHj+zUoq1pbSV3m5X7qhaMorK3Ba1Ifo9QRj882+pYdiCNH9Ly5UEuQa1Y/KwHQLKWrvFowt6LI1oE2YzvPZTUFRUpAPm7Erf+l3Rhrfo7BGL/Oi1+fvhEOUNJr7F4TUA==;5:6fecbVhh7POnD1pcjK2ZoXoL3j5Ddkz0jsTq8JZwvglInJsrgRNTTtQiNAhgkI8RlNxKJspCvkgAL0wwOt3+YBWS65MAFdbDG0G0elu5xPzP91eWgM7gJzUrydVrLk+CtS2Hf0yxxGgnESVuvVewsvyDkgDdmM2HtFUZ7zt8JEk=;7:1+QQZtPFrYURNofuGEAsUFxTLHAAGRQhWwA7ofp6TRZUmWJySZ6+7Sb/8fX/d50VNNoT9atPNUmawPtpCIqaULbVIrN2HBPa8HF5OfwfFL90vqWIMKceeb0g7Rpc2+OuovM+Mj7tUnrIuU3hihDLsxqThnWlSXVc5nBstu6BGWhx45yfLmGrmKFDOsHgN53pmdpmwdF2Sg3ZXYxUhnHSuuAbcDNJudu46/zkmVQOGqGCrEGHhWcXqReatr9if/iC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:27.5084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a12d8fb-d809-4518-9681-08d6325f5301
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ddrc memory controller node in dts. The size mentioned in dts is
0x30000, because we need to access DDR_QOS INTR registers located at
0xFD090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..a81d3b16 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

