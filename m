Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB17CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1BF20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wcZBrR04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1BF20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeJaMhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:37:23 -0400
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:7680
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729146AbeJaMhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCw+GaTMVqmwfISr1o4JL/TTrN0d8n/J0II9BuaAQII=;
 b=wcZBrR04+QrcZHcgpF0/282BsQVk2PQU9d6oF0TsiuDeojGqUc2+w3swmZzPqyJNFhwDhe/HSeInpUmy8aFwBbyEti1Ss1tcqqWlx/H/DbKRvboVK+RpHySf50w9G3Xwv0hmE4OJTazqWzO30Sp05AU5HbsGOwLb65XO5b3dylA=
Received: from SN6PR02CA0034.namprd02.prod.outlook.com (2603:10b6:805:a2::47)
 by BYAPR02MB4328.namprd02.prod.outlook.com (2603:10b6:a03:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.20; Wed, 31 Oct
 2018 03:40:57 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN6PR02CA0034.outlook.office365.com
 (2603:10b6:805:a2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Wed, 31 Oct 2018 03:40:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 31 Oct 2018 03:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhNH-00012M-HG; Tue, 30 Oct 2018 20:40:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhNC-0003BS-Dj; Tue, 30 Oct 2018 20:40:50 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9V3efWT010803;
        Tue, 30 Oct 2018 20:40:42 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN3-00036w-Bp; Tue, 30 Oct 2018 20:40:41 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 3/4] net: macb: Add pm runtime support
Date:   Wed, 31 Oct 2018 09:10:22 +0530
Message-ID: <1540957223-30984-4-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(305945005)(81166006)(81156014)(186003)(77096007)(478600001)(486006)(26005)(44832011)(11346002)(50226002)(426003)(2201001)(446003)(336012)(476003)(126002)(63266004)(9786002)(106002)(106466001)(2616005)(7696005)(51416003)(8936002)(76176011)(47776003)(5660300001)(2906002)(16586007)(316002)(39060400002)(4326008)(6666004)(107886003)(356004)(36386004)(110136005)(54906003)(5024004)(8676002)(50466002)(48376002)(14444005)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4328;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT019;1:6ZZCyr3bQ4jh8K7Dz0q1rO59Wph+uvO8Kgst+3qugm+YX39JTfNYqeCXTSTA1ngVrG5AavdC+EY5FV+qljhpZ3Ypk7SjANiP1Kf/CnOnOxNDOA02uqZZICv3Mtr/xRYI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c823533a-c8b8-44b3-cbc3-08d63ee2aa7c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;3:Y/Dvz16ccbH4MW8fWeS1N2HMQLtM1gn7WBFDTJjqfdhXhaf6ckCILAIG8H5rKcK1hVyU63LTHg9GFYmtBbP4XxS9U1dkXteJEI27aSav3dIYqMF8EkpWLmbXAVZz2SkGruDrMFOJXjzOugUEUfzHf5cBBRTbTAfOD+M0OJSDLJwTlCDM5P2x1kr6juTAA11LYSs3k7wEhnqniQhh44RhH2e2GVLUgVi/gjZPMFMhj0h+85GO2CAzsYeS26GKmyLN+bDMmrPcNGTA8QY02rgWVF+QkHBXE5OkkKbRXMmn+skaPDsnZtU9L2v5E20btDycmjpY0oTgI4mhaHQxP2UW1VuGjNXrUbvZ4BAZad0nPrc=;25:/6DaOkSQD8LryOSgRX5BLY4y7fETuU32DoSy5ID3GqqtwTy2sjeb9R7ajvokqvPDvd3aHC5b9jeP/IT7liPXRmb9qGk+dFUZ58qTSjh/MvXflSBBuoUKKb8mYL3vH0rWv+qILWc1OeaUFeEvJZnvJY45fJyc5Jb1Jc494DvRcJXuHArAEI6tM4qQv0oIYN7JGNtF3ZRkF0bbFU1lvc7gLLlts3Tev8pCk9bWwuKPN66PdLkYzT943v0+WFOZEPyWgXOlez/DlnfNd6AJiMZblcnlCqLeepfNQpbUvTd7lDF2i2kgfcCFVHMsIp1PaygsulXZ7SMVZB7E0aiIBeJ0TA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4328:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;31:vp/Rh8aIQeQZ2cclhTaUpmF7uB0AMGQdhoap+5wcD069lzmdCSqLFE/UZEeHux1XzxhqEkfnOexunL+mw+ZuJNWGqYwJHh516oeFMV3bjjgZzXzQ6RaikZikUtUuBpuD5vRSkOg5SLtA76S8dW7FkQs2esPE3gM5YIbHur/GFwGUGI49hSqDDoNXaj06Dt0c5gnru5MZY0fVByWi75hi95fwvcZuOWvq5hxKD8hTYNQ=;20:7De8l9nZfboDizq+CFub18XWoJz28NBDGnL1NkCzuS6TjqOZ0h00A9MLmYeBMz76Z7HSQ546W+L6LZ8U0xM/Xjd0uCHoK8OLzoQL/qwy8TqhfrntLhrpN7aLaFbniUG+VeKdHMtUQBG4oStM3C4mgN4JAXwFgXoh9EUuNzIq8qQ1tZQ5fiAsJks5oNZ18ZiYE1rDUwZISIDLNxZagO3QXk3hTLjrVztp6BVT+wJNhwjVoN+NJxXXJrtx5ZcsDoqwMNsLbbF0WmIrgXo0AT4n+s15Gpa9sbsTnv6CJ4daR5nap6Yl7w3eRAixFL5TlbXT9YPMjZFTIiUvB8F4mhG5P0n7mmuFdskPumq9oREzF/ud7GFz6BcS1+66MxMPtdNQr5GfQwLw4H0gTVO4vGawWTIfd0sLyqFRPZlag9lIDnGvgTD/25g+YbJYDXzkAhJKIl09dGjQaUj4NtudbRxNHcQIIQeCltEUgRkyKXC4OQdh205EsHD2QyqnaPQGYHm7
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4328899B94CB70AEF9DD4D39C9CD0@BYAPR02MB4328.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;4:6eMoP4A31J10OWT7DRlGt5WHBc/Ya+wq/Q16DhUxDNjzdMacWT1Jv41e5RVtD4C9tKMAsw/Aa6MxDYOJ3HxD2vlGYRmiWRAM7iFhxNaeh8M5GoSNQkZhyn93Yem38Zo3OSGcPXWq/6UsK1SCObovTcxp2HAcEZNJVSV9XIWge8+13UnohYsBtjFj2bPrxlU+4fFE0jTpEc3jniQnLjG/jnQ5mME1V94FMq5Sho7A0R4yB5x27F96IioHzdAPJoM6nxexTR6wnQhcD7uMw6CqJGVHPwsDBTFi3EeYSahu1W90uvozMeh5Ubl5vxGKVo1R
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4328;23:wEQgpDinEjMpr8bAUnhSrQoXqdU0516PTTSIGyLB6?=
 =?us-ascii?Q?2AXzB27u9Zwm2ZZZkxwhX9wS1oLTat59UK4YiHu/zrpQ2Cv3HwMrphbJA22l?=
 =?us-ascii?Q?93elGxRVVyPQtE3UH30M5okaqZptXqrxwkh+EKJa9N/nuhHYlYYOK4xBk7i2?=
 =?us-ascii?Q?/Vp1DdNDcyguY6kykNcIjEgzK3vxa6oHe3yjlkHs8OivegEz11xJGRE9cBfa?=
 =?us-ascii?Q?6Zh+xqEluT+ytu84qHYwqDXybKkFFeA970oSaWq2wwPJCCb3r3ewg8FLlrIk?=
 =?us-ascii?Q?uvligh9ebHMsHtqiSpBaxqBsqKBEKfJzEG7xmgOfFg0snTLXxUVEWpaUdsBA?=
 =?us-ascii?Q?x3wYNi4e+RdiWsNmC8GRn8+deI83Lhv5VyZxGn/+xNmbi67/o5Y6H6RTcnNo?=
 =?us-ascii?Q?zWVs/X/Gg8QEc3Rf1ooHId37saTEGeVCEoRRfCatUEapb2Ndzud46B69VxH+?=
 =?us-ascii?Q?UKPasYINrWObCLLGzXysK3UZiIGE15G+glMT1EB1/AThElVoYRv2nW06WxJc?=
 =?us-ascii?Q?0L820Kv4RNrKxFIlYoH8dCzoGdwwNt3uLgZ/4hxQa/yMsgL0igIItZBoLoWs?=
 =?us-ascii?Q?PFjQcev3is0PJqfKOISPUjSlZJshZ0PXUBnPQfz05rRUSGlPsi9Pex9g6D9/?=
 =?us-ascii?Q?9HTRlVqrqECuvHN6VdPYRw5I0MBMcO66ec5O+Pzvpauv8d1sNfpUGtEE3VZ+?=
 =?us-ascii?Q?bkC6Y2Zq9LheEc3Hb2LVoKMvBPC6hKqk56OxfnoapA8cZxP40f6u6fUW4jER?=
 =?us-ascii?Q?Bk1L564bYsDlHsklZz9xXQiOKyAZNIb4Lisaq1NgBIsVA682DqZNP+Aou3E6?=
 =?us-ascii?Q?VknGUnOkBIu5ke0WBcwCdWJBHSz5tHIR3dOGq4ZFN0MYxDbMYbaiA4/i7e4k?=
 =?us-ascii?Q?q+lxvMYFrazCXensHw7WualwebgPiAN1mC392lJUKeQKwyDcw2yJ34wkVzT7?=
 =?us-ascii?Q?Pcya3TABdE8rzvLiiaCZgxK1uaxIhQr0AMLNZnDC1bK+PGtXAP5Lpd4qecWe?=
 =?us-ascii?Q?b/3FABcaE7C4QYeQ2K9C0bcB1go4GPEMHhahcKiRE+5WD1ryGMZY2lH558wY?=
 =?us-ascii?Q?TGoe7Cz6IFI7szrosq3lgij+2GDmEWXtzkjUEZCl6dvhPXYcVSW7/OEHPb/k?=
 =?us-ascii?Q?gmEhxTxCmJi+LK2tErxUbg7z8Rjzb2Ndj2c8JtZW4AkC/rfao9ujphZZ0eQU?=
 =?us-ascii?Q?I2L58/40yk4qsL769i5xyOE2wFqXuoFyC+q?=
X-Microsoft-Antispam-Message-Info: LXQWLOpqWpiwlswGU1k2Wr8yway7IpIedNxGaBg3PcOs4dNI3vRb/0nSTaQkpxvJt+SHEfdqmn73rk4FeGzTfkkx56IOUAWqNLhqIKfwltH1FRZ1vDMLw7eUoM9VmvhtY+1qi9mQKmTgc703uprdJ+ITeGqqqNIGYUaJHnVsiqwx6Oii5cwH5/deB30nEHsmhT04wggAz46hq4jhb2CDx40y2MYySb+6HsNQKdOdxIcFY8BeqJkhg1oGSqU4XNJt5v6mNeeCMUGlM/WzCReLkGP9h8ZrvGXVICl7O9QPaH/Akgq7H30+2zqqHM1zRB0Sq8pbnY5N0EVl0IgYn4THKa6XQ3m28/oJcvPz5RM5/dk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;6:b8yvs67rwKdqjjT/qbQMKqQRvYt/8t2EguIa7woqXT6I2LAzdpif5f6AOLBR3em4Uz/1ga4l7HnFOZvUv6YrTrBr9OwDXPih0fElrJ5GghfktFkNcpoJh2qtodPwMXm9j0r5hLpJkklSA1zX7+5JoaON+XAETHprB+GROyFxbAAB6ePYvy7ePS2zxsDonfsvqhGISmRAu3gXKhu/XLsldA9kHAfRR3HbO8KEZnXoalNJYNBMreI5dKVcAoe/2wlrcZ4/jQ9XsIgDP5jpnVYFcYUqOcqqFbe4lffRjpm+X0UPJIVJa/64x70K2GvJUB9O7rxjfVrCvf1QHT71Vz4TxtKe59+pNyOygJp1eDEskZbxce8F2MtrAuX2gOvUWKfcG2CktRNDDVTfj2aW+onW1foyXwgaOWJWoGK2lOKquZQ2c4PjxtrZwNnbANJbHpIrG1A+RfxV6cEcm52sFnlQ3w==;5:wUUdN1yuQQoGd80K4QjfZ4LCDy85sISPIu55bMhvZwLyGJxdi3OMW7UUEkIeot4dxT2h6famBmbidby6OT6u6YgF2pTC93yBwP/J/3f8L6rm5ygt0TqA6OxvqvclN8KrtVs5zIb7xn0zLL2L7vNqp2st1KfxaXiQzSmJLg+k6sI=;7:tfTmG2wlzNOf4UgzTyZkmUiULtafRWv8ZPb6oYEeNnBvaczFcw/ej0d7xjRrueTFdTmLRHho8SL5EisGfT8StdV+uJKKx3fJSq1wWfE6pFmonUehlnzjBO1Gu4DwNegvGOxDTyFItnNcjYpFwyVi+g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 03:40:56.0527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c823533a-c8b8-44b3-cbc3-08d63ee2aa7c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

Add runtime pm functions and move clock handling there.
If device is suspended and not a wake device, then return from
mdio read/write functions without performing any action because
the clocks are not active.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
Changes from RFC:
Updated pm get sync/put sync calls.
Removed unecessary clk up in mdio helpers.

 drivers/net/ethernet/cadence/macb_main.c | 103 +++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7ae8d731..09cb4bb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
+#include <linux/pm_runtime.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -78,6 +79,7 @@
  * 1 frame time (10 Mbits/s, full-duplex, ignoring collisions)
  */
 #define MACB_HALT_TIMEOUT	1230
+#define MACB_PM_TIMEOUT  100 /* ms */
 
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
@@ -345,6 +347,10 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	int value;
 	int err;
 
+	if (pm_runtime_status_suspended(&bp->pdev->dev) &&
+	    !device_may_wakeup(&bp->dev->dev))
+		return -EAGAIN;
+
 	err = macb_mdio_wait_for_idle(bp);
 	if (err < 0)
 		return err;
@@ -370,6 +376,9 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	struct macb *bp = bus->priv;
 	int err;
 
+	if (pm_runtime_status_suspended(&bp->pdev->dev) &&
+	    !device_may_wakeup(&bp->dev->dev))
+		return -EAGAIN;
 
 	err = macb_mdio_wait_for_idle(bp);
 	if (err < 0)
@@ -2397,12 +2406,18 @@ static int macb_open(struct net_device *dev)
 
 	netdev_dbg(bp->dev, "open\n");
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		goto pm_exit;
+
 	/* carrier starts down */
 	netif_carrier_off(dev);
 
 	/* if the phy is not yet register, retry later*/
-	if (!dev->phydev)
-		return -EAGAIN;
+	if (!dev->phydev) {
+		err = -EAGAIN;
+		goto pm_exit;
+	}
 
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
@@ -2411,7 +2426,7 @@ static int macb_open(struct net_device *dev)
 	if (err) {
 		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
-		return err;
+		goto pm_exit;
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
@@ -2428,6 +2443,11 @@ static int macb_open(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_init(dev);
 
+pm_exit:
+	if (err) {
+		pm_runtime_put_sync(&bp->pdev->dev);
+		return err;
+	}
 	return 0;
 }
 
@@ -2456,6 +2476,8 @@ static int macb_close(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(dev);
 
+	pm_runtime_put(&bp->pdev->dev);
+
 	return 0;
 }
 
@@ -4019,6 +4041,11 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, MACB_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	native_io = hw_is_native_io(mem);
 
 	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
@@ -4150,6 +4177,9 @@ static int macb_probe(struct platform_device *pdev)
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    dev->base_addr, dev->irq, dev->dev_addr);
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+
 	return 0;
 
 err_out_unregister_mdio:
@@ -4169,6 +4199,9 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
 	clk_disable_unprepare(tsu_clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return err;
 }
@@ -4192,11 +4225,16 @@ static int macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
-		clk_disable_unprepare(bp->tsu_clk);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		if (!pm_runtime_suspended(&pdev->dev)) {
+			clk_disable_unprepare(bp->tx_clk);
+			clk_disable_unprepare(bp->hclk);
+			clk_disable_unprepare(bp->pclk);
+			clk_disable_unprepare(bp->rx_clk);
+			clk_disable_unprepare(bp->tsu_clk);
+			pm_runtime_set_suspended(&pdev->dev);
+		}
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4217,13 +4255,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
-	} else {
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
 	}
-	clk_disable_unprepare(bp->tsu_clk);
+
+	pm_runtime_force_suspend(dev);
 
 	return 0;
 }
@@ -4234,11 +4268,43 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct macb *bp = netdev_priv(netdev);
 
+	pm_runtime_force_resume(dev);
+
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
-	} else {
+	}
+
+	netif_device_attach(netdev);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
+		clk_disable_unprepare(bp->tx_clk);
+		clk_disable_unprepare(bp->hclk);
+		clk_disable_unprepare(bp->pclk);
+		clk_disable_unprepare(bp->rx_clk);
+	}
+	clk_disable_unprepare(bp->tsu_clk);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
 		clk_prepare_enable(bp->pclk);
 		clk_prepare_enable(bp->hclk);
 		clk_prepare_enable(bp->tx_clk);
@@ -4246,12 +4312,13 @@ static int __maybe_unused macb_resume(struct device *dev)
 	}
 	clk_prepare_enable(bp->tsu_clk);
 
-	netif_device_attach(netdev);
-
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(macb_pm_ops, macb_suspend, macb_resume);
+static const struct dev_pm_ops macb_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
+	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
+};
 
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
-- 
2.7.4

