Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA362ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4961B21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dKIn2Uq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4961B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJSQuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:50:37 -0400
Received: from mail-eopbgr730075.outbound.protection.outlook.com ([40.107.73.75]:9760
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeJSQug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEclwk9aZl+uNkB6u9frMR+91lfdpA7lTVpLlI8tQcc=;
 b=dKIn2Uq4uS3lSex9T2+KrmNYtg3Wfpin9auLht1Qm08w06CgIoSg4zKuGhazW7qpJ89vY5w5Ylw/LnuqgW0foxnPRw5vcrWRND0gLhwbBnx8RNJFul2FJzYvXWLwdQ2MAPRA4WpNyy+/rsnNJNaNbswfUH01w9ZbZBc4D/UeRnk=
Received: from BN6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:405:60::45)
 by MWHPR0201MB3514.namprd02.prod.outlook.com (2603:10b6:301:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Fri, 19 Oct
 2018 08:42:35 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN6PR02CA0104.outlook.office365.com
 (2603:10b6:405:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.22 via Frontend
 Transport; Fri, 19 Oct 2018 08:42:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:42:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMa-0003kA-Tj; Fri, 19 Oct 2018 01:42:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMV-00023M-Pi; Fri, 19 Oct 2018 01:42:27 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8gMVZ002491;
        Fri, 19 Oct 2018 01:42:22 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMP-00022V-G7; Fri, 19 Oct 2018 01:42:21 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 0/3] Add reset driver support for ZynqMP
Date:   Sat, 20 Oct 2018 14:11:04 +0530
Message-ID: <20181020084107.28251-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(26005)(63266004)(36386004)(77096007)(478600001)(106466001)(81156014)(47776003)(81166006)(8676002)(36756003)(186003)(39060400002)(8936002)(2201001)(305945005)(426003)(2906002)(316002)(16586007)(50466002)(476003)(486006)(2616005)(1076002)(126002)(7696005)(51416003)(336012)(356004)(9786002)(48376002)(5660300001)(106002)(110136005)(50226002)(6666004)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT058;1:ALMGgH6gJasBNgd52DIjfNqbQMf3uhqrZ2Ouyovt47fI9RUJSMf911N1eDQxERGyUSz5+8aILqFPZeiwGNf/Zaz/VCmfRV9Cqr2gzgMDSN1yOSLSXePBi7UwmwFJQYXG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41714a5b-ae1f-4c82-7caf-08d6359ed079
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:Efv1H/z4tYz1qTRh75Y/xTIrM9Hls4gmIjiPy6E2BLZDxIfG9wiJFJLZfnfjJfh01s7U3taGN/pJgwTWeyrBdAtiJ5u4xpCdrlgcy1u6jdVVLJxTevZCzyE/tQlgumqZNa4c0vA0WWLX5xqrDdegSNA+BQPwYxq7TL+UZt3pKzUZRKQMfZn7WmKb6Yr8+/7CNB0HZw1JopZ3vmbWges480NZuu0BeNnIY4jxg+DfukEA5AkP7oy4zQ4J82VSvJUu5CLiEf0enUmtomDwzs7u1rvD3vh2OJSydfWw1Mfd9V9WVB8akZiB/srs/jMwKq1m80cCR+QA7rLN6s2vv3gpJPFBDjNS6vc+tE0Zp0orvWg=;25:2tq0jKFIxxhtRXlwv25/kmqGriMx7BBu6p2TjM6O7DG7pHdiHhExCGjDkVhwCHby5HOzqzirXjPTinFVXpJtOhPwf81iSMitxZQ07hfuUBzV4lPWVzTXyEFG4gcUzfft8iFxWOUX5EJs164Cr3li08rA9EzDiGYbE0MF9cwyGoHYge/DCtf2Vfb/vVc8GUkMVsxYE9gvvYb5kgNMswBlTqajO3KdvCTEIutT8Y8LfXgQp8HfodZKNojwHx1La15zUIUmvrTusyRq1vObIgx5rAec3HG8+NRmaHbVsN7u4wLY1xGZKGcIACBPa4IozYSGYeppPEUMChuezXDl/nsqwA==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:DpJYEx81gqebKY/15XWO3tNIUmeH6oKgQzfsRqNQCOkrhgfxFyG8VGqbgbQqCwsM4ZscgK1LDNSplP580PlX5ic6lKcwcwo7evm0bBBE1kq0jqukKqgS8IcySvAELNMxfmAUPGxzfXvS+/mCbvyy4UBZ/OBDzZj6UHBJMMcXRzRzNPPFrBDZoK7GXy9WKrBnA+UWEk01PnnX9QqkgoQdSh9m/P5bC9RXlUdGw2Ardi0=;20:aav6jvbADs18aEwGkYs0E4vfhHHS/s82LIQiqpWFaAFryTAd/lI9P7QtAP+o5o2NLMjoFFv2f7Tt6x4VCw3x7wuUCCrIAlZXifqHhayLjenv1ePPfpSXaiVSJ4ZwKNVmYQ/O/PA2SL61ZDqh7cwqT9snbXJo4cvFbr2jg+W+hA0YJPwOnqTmhlc9Ufxscgp7RqO4K1z+HwF34OLGZFnu8mk2CFREVQkaDcLPnSuFgkS/UiEeCyvCZYGrbSySkmKnR7Qms0nO1cHk86ICrE16Io50TPIHqUu6PW/CRthvjda/ZWv95aYtxyQxqJmmjEEFZ7RPxtxWCKSFlLKk1ww04GNWJNgPBVflmp7FfpybLyNGMTQKKnZmJ18kJjFViztcg2KRcrNbMm4wn0MFM0f+LMq9dGDBAfd3dBg30vm4x/hL21ac1nHTCw1OEih0H3AuEeWLRXHPL9ZPnCvy9xCJe08HufBW9uSjYsKw2W73M7pxL8PCCNLnRp7AlDBqymOw
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35143677C27A0B8899667065C2F90@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:VFv+itQcgUdH0XaPJHZ5gcRqsMNtS4fXqks3/as9ovUXQIyuEFbKoHFh9CQHEYaJeKuzwkHq2T1GDy7z9+FEEFLcRZJDU5RDYChy1hr3xKS20/ZY09I4Zn4FHJ3b5QhUQyQx1y5tncyUPZG+NrzkDJbM5D4b63ASIlo1BrB+t3a/xwuy0TPEYk9grd4jHhDj0Y+ZLE9nQDzuEOmhE5YsA1PpokMMqD+f4P9DVhRnAzW+hBNFKtVEqML7QiT1AoNX97uiFHObcbglNsAa8ZMUvbJEapwbadFmzZ3yKHq17su4QHg+cpoOwOYaEC5leu4O
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:bi8Z0zLrEa1y3UDwEteFiqC8U+I9u+Zk2kjHkJO?=
 =?us-ascii?Q?AnADIcpRu36JDd4GXqREnprEpjijZCa9W06yUXvybDCQa3GE3ovmf4pNi3D6?=
 =?us-ascii?Q?8idXyJjheyrBs1r0tRul6Ff52t5/KWzg12eEQgD+aiSg+l+gxTxji7ahkN3E?=
 =?us-ascii?Q?UVw/taj3Df78hzx2CJH5nhFr9qgzJTSLuTkzPtWv8i9x/qGhrdhhTvHRrDpB?=
 =?us-ascii?Q?F0YDXQAn9soY9TMdXoZk4B63mhv8FsADzJwiSwglNBoWULDDxA4Ofqle0fn9?=
 =?us-ascii?Q?benbcqY78j/6g275O3mSxx6wCMth+N3XMt+J/ym6IhU2nUQmOCohwrxd4uM3?=
 =?us-ascii?Q?iPdfCnGxIxfxVgYxK+oNU6FJ+cEuMKIbWkQg+ug8n6pSaMlF4haFR5Djpg9o?=
 =?us-ascii?Q?sclgAlXIT/K8TbnZz6inSTmDXjv5cY6RFmg6DwdAVXamgnDqEFjwtaY8kdQt?=
 =?us-ascii?Q?Lsj2fxvMqig5BG+NeO1gCMZVz1RpzFYBhN9HGfG3zoMgqjj2hXNwb7gZwYLM?=
 =?us-ascii?Q?yThnxp2yULuatKGTGOR8Mv/EmjYVw3wT5g98JL2o4hn1djW/zcB6RMVU6Y+U?=
 =?us-ascii?Q?2496YRxmI/58hDM2Ao0j5/SlNc0wxFqi9vv5aBkgjyFr9IeUryIuLx6yVBjr?=
 =?us-ascii?Q?sjOa6WY3PONaqMbMVARWfzcRj8uGTTwNtJluNaiOUUhgvakV9KjcgkoAtXZ7?=
 =?us-ascii?Q?pyfrEaPRACl73t4254bAsvXQ13/AY2HoEh9kPoL+3KaOxhZKvC+VgmMFw4u7?=
 =?us-ascii?Q?9grj/GKaKrZIIbrfq6alsFO3Nt55GdLHOBl1KXMyqc673+pVtO+D7Vyy4V/h?=
 =?us-ascii?Q?dB+Zo/bL0d2qwgzFQgbDOwMd+1pS4AcYVfEknSXpklDkvG+8P56X4WM7D0tf?=
 =?us-ascii?Q?Fo8KiktXGnHx+4s4TPNYHfipfyg20ZqPC//5B0JOeIjIEizGVAWEbzktYqlf?=
 =?us-ascii?Q?lEkW4Svzcd6kSX0d/5OmQlpbVvKmqsuvYETq+BlXsgyscsdg30g5ovfDPgBS?=
 =?us-ascii?Q?Dlu7XbLPtJVcOZsjjUaHIAPeXnoBhgAAdTN1ZX0M18c25Rv5/6JL4lfZogjz?=
 =?us-ascii?Q?cdgq5E2HFG2nPig1NfrCZMCpI0b+mt8yJ/yBE7x2um8wFA6p7ptd2fK3uRVI?=
 =?us-ascii?Q?R+MVOgXAUQfs=3D?=
X-Microsoft-Antispam-Message-Info: 0E3Xz/uHceF8Lm7toz9/+ENK+OlqV7DZaj50v9L4t9OSMin4rwvgFRq7xT98UyHa8Ege9uc8scGwflbYSbdiDiLIhQeUsN4/U4jzjCLxdOtZc7zxMg1yaWrOzRKHLOwrgHq3nOnfR5uInVqW9SQh008jefheols0Q4Lf3i8i+0aUUC9kne5X3G8WpT3Plv/QUe7+TwHyMmXzLl/ZRkvjf4nA4NDVGLcnZFhNUSQ5/P10mUgqWhoQGzO8HPPSRUqlVL4XvBGyubKxvFhe6eosVtzcruCPpOtBGdvZQq+JIdFYQukz1E8cFEt/tSfC7o64/HsAmH/Kodab1yoQnZ9tudzJ6JZqlZfYjGlWERsFEyk=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:T9jCpygbhNOGHKROPa1iP2ICjdwW0ekqkkJG656P3faTHj3S7WlxKkeskvsCo+MufNL9XQYPc80sFQwsT4uDmUwUvWL1g2WY+npcYYMgKqHQ+XbDHcOdxK21wRs0EjaMa+gdeZbOHDbKcQeHeSQmnHGWyNQx068GcXWhLelPJD0FYqiKzshgZ7C5/3uOZzCgGNrOl2vwAveJCGSnXEojQDrH1dbSL+z/qCawFwstFqB22HAdJzRWm6MQJmPYVlUtSF1k6RIllPcE3GG106iZEob4SjmQJ74JUFpniFhEWYwrdYX/o7fYjw/UlxzUNb7RkjBcpiJnOnqiK0WXpd81bDyTtBwpiz4dTJXViknKJUuAosDel9EA4/+HyaMLwZLeQRQLD3AGu87KhnCz9Ww+7B6NrtWPrzQUWVKijnyhk7CswjhZFj56tz6kPN/Al+USMbI4nd8UJmvfgj/5oJ+YLQ==;5:fw0N6qsyhn3MGEicvT3w93ViwP7Dwe4VIg++PlOLA/333NczxM+N4XzwGXW07ad+zm11u0swr+LEQ4Huu+IrJnU17hxpoYLIJye9DIHCn12E1PdWfbjonZdDUGeCEbLiY7h5I69wgRNv8+yG9yMg2PYvuIS4SzaD6FU5PgnNHJ0=;7:/FRbM3PZ772WXQFYGAIhAwQMtVyJXa95V5lDV4qzibaODv2sdyjWtYxjbtujzkW4x3FF65Vh6KPgKTYGf358vKDzQV8i/+uSzjzVPkipvKS/R85K6Xo87kVJnrBMYyMukEgqrWODl2mb8dcBmGTWdsoEif7X7XZ2GdRZqun/WEs29Dhh16gqxD+YMcDQcEJPjSGhYzXp9TxkEHefY54fBoRPdmRUhTSEws0VaCRPe2qCXFPfCUIREfPn4vSeSWNh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:42:33.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41714a5b-ae1f-4c82-7caf-08d6359ed079
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below repo. 
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git (fetch)
BRANCH: next/drivers
 
Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../bindings/reset/xlnx,zynqmp-reset.txt      | 146 ++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              |  40 +++++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-zynqmp.c                  | 117 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 136 ++++++++++++++++
 5 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 drivers/reset/reset-zynqmp.c

-- 
2.18.0

