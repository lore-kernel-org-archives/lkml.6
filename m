Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B1ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF790204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EqShTAqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF790204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeI1Xi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:38:29 -0400
Received: from mail-eopbgr710048.outbound.protection.outlook.com ([40.107.71.48]:30640
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbeI1Xi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imKFV3VqNxj5bOu+q9k1xQJOWWHrIt+yKK5SYhs8o6s=;
 b=EqShTAqgTLkqgeO+Oky+uUOQIK4F+BO4iZ1ttxty3mWnd4/DDZrGJFhaxkUwNROp13QKx9oKy4Pc2MU+MdcJws60qzA/YNkxbV5WrR0GjwMIQkW1rXvra5Tkp31z0Vjynxxq1OUGC7XyJxHgudrNvYuAAtenZAfkCI3A6tO1nrg=
Received: from MWHPR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:301:73::42) by DM6PR02MB4476.namprd02.prod.outlook.com
 (2603:10b6:5:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Fri, 28 Sep
 2018 17:13:39 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR0201CA0065.outlook.office365.com
 (2603:10b6:301:73::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22 via Frontend
 Transport; Fri, 28 Sep 2018 17:13:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 17:13:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40604 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKf-0002Lu-71; Fri, 28 Sep 2018 10:13:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKa-0004HW-38; Fri, 28 Sep 2018 10:13:32 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SHDSPf010117;
        Fri, 28 Sep 2018 10:13:29 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5wKW-0004H1-Qy; Fri, 28 Sep 2018 10:13:28 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 0/4] drivers: clk: Add ZynqMP clock driver support
Date:   Fri, 28 Sep 2018 10:13:14 -0700
Message-ID: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(51416003)(2906002)(7696005)(486006)(426003)(2616005)(63266004)(126002)(44832011)(476003)(26005)(186003)(34290500001)(6666003)(305945005)(106002)(36386004)(77096007)(14444005)(478600001)(54906003)(8936002)(81166006)(2201001)(36756003)(110136005)(81156014)(48376002)(107886003)(8676002)(966005)(50466002)(316002)(336012)(50226002)(4326008)(5660300001)(106466001)(6306002)(356003)(9786002)(72206003)(47776003)(16586007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4476;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT035;1:MKdfgCzWe+mUzgJcWcpkvvDwLlciCUL6bXr3WSbs4Vph+9DgvAvZe5w/rT/7tnBFCkTRp8ai27oPNKRopORiCpGjx8Svz4C9DW4UHUmIlds92rbmappkHGeXO2VB3pXF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da37006-e628-4e42-c0af-08d62565bb00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;3:v2K+MgGy07oC8vM8w0JihvHQjYhh8DrZIhppv5sS4WNQm3trDTlT3EapWGTvGfAHSQjFwxZ9bWZTy+g3AsnjnsNuyM1u3uFxKVzKgoCCVK/p2q3wrdD/qDQWGjHm5Ws8OAULm/TeNabtgDRysDs5WLNnm8MxqjR75obBvrFc5690prSSVfjhTMnB/LDf/W5KNTXuf0b3AIYWHOiINHdq4PUCp3U4W8DsmsbuoiXKKbUd1RiHOmu1DtrDN5GfD6ft+6TIUHNLpSVnzEgyEV+EcVgmBa4jd5zy2ZqndzMeRfjC4KHRgDjIA1ryi1EcoOcwJbeBHF5DNraq3g0eXCcnwUiwOpVikgnLpAwINMdEQhA=;25:cr0t0MDLzJOTvJVcwt8yvz0JQw1YsW1VeDx8yCsj5jkNSTtWFQvmik99PtP1j2sriDFK36mr26daQJvlDuRnQXO+BBLsAM8eob5U+FAIRAEVSup+wDwx+hif+WxF7PAkxOATZrCh152xmIPGtXyr6u7WOcb7vEqP/6llwxbsIj/byXGU999jyj11xnT3nMvB8fjtM7zPXtcti301Gt49Rn8jfLKbLLDeRihqVcXNi/jXi3TLtBbd2QOpFhc3X628NQdiHP0FVtf1FwLEA6QEBuE6BwcFQe/VB843wfb9ZURMf/Baf5Hfk3ZTLqlf1DXi8mlxceHkZOwGF8M2XsZmYw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;31:lSBxUrQuQ61UV6dNCNKEP8OH4ZuYJJjP2pjZWuAebGlVrT+K05bShkzuN8hDUVsUa7D4xTmv7/1axycBjV0nNVRTV9lOlRFoVD9FInnEXbotnAysrozVaniHQZPhWjBq+1V7ytWRjOE6dFqv0MeAOn54aToCRPAeCbwIIxbTE7QwYQwdgZM2/MwUaTGdpnKTqLQfdOpw33F7unT13fhKg5N/k3VA8uvaYPUpMvMBdx8=;20:3F+YuOs+o/E3Q88tNHaJFombqs5TJwmhdSVNY7Yk7V5Q+iW/8yFJrki1HVmnFHpXWgM65eG9z9UESQf5JxuVJm2waN+ztfyhnfgxRcdBwLghUVQtvCsejzPNXRh7T6dk9Mlb9vwfnn/5uUO/vWVFjEF2icEYP5ggUHL47BfEDHCiBSwmv8DflT48A2d2uj2333vCCXjcTA9wjZbL8yBg1BK7RomeeoxHZU6pokkkZqRivTQkY3Lvli9aTOLjEz9ulAld8sQ98I1aPE8t5fgbxp/si7MbM0HmVXBrWgdTPqRA5+4EaXa2C7ovNTSyjLAjEBDn17IgiOWtQbjmZs32rI6pghxL1vxx68TaX3+sAY1Z8LcyRzxCgA0xnrn8jKcvgetY58YStiQfaZ8ycVbIkt8PVYFzpwgjJ4buHtsowMFBBzt6SCwNjb81/DdqLZo8kC0MIY9ZNhtdWG+JOfZE8HPiavsIbVIcdIxtSmYQJFySqGDPNUTCVoMxDVyCtN9n
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB447625C6F2AB068E556EA487B8EC0@DM6PR02MB4476.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR02MB4476;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;4:tyeaJQB3J+OaJYmMYdvLI/TdaVxapkoqILLBD5awGoVHgpmNzU9+5oXvwDg9hndXh0cz5LzuWYB7rGtlKYu0VWYcVAHzTBhGM9rrv+7Haph1PNnEftMg+IA4z68T49Pinf3Tqgx87XRfL3f74j79RA1c5PBvLEQAmEPk90vawdIAvPcuAl4rerJ5gOzA7NhthmSOtJcXAiO5X4YnQlt5QR/uQonRs2ylboI25rmJNgx2snD03pi729taS/DE5i576m727yl5DA9Uy9+P3K1u1dTAyIKdUUzBAyK2jdKQTYp6LzNbR2xX02f/W4fcMsJ+
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4476;23:L6q0EIzxSgXSX19HSMVh8AjrpY4EhMgdBeDKUvPgC?=
 =?us-ascii?Q?KL/xwIYMz9gTv5U318L70MAhUfn/fR5SpeM2QIsWMTeO6QhdXJYb4s1Ko2HQ?=
 =?us-ascii?Q?ANnlSHg29o0zavZcH18+5xiNu6fQXxSMTDZTxGu7ZoKNZ7yxdsUdVBQe8HLF?=
 =?us-ascii?Q?cawhj5nJUvX53d5AC3iwYwX8oaNsNMufo1sSFgx+UX2WrIImeL6bTXGpFgu6?=
 =?us-ascii?Q?8Lk2yCmj8IVYXo3Ls8eUSJVICFmadCRf0npLLs3LUFmdPx849Aanl9+WDgwH?=
 =?us-ascii?Q?vt98xCyp0Y6H/7iA6mRLHmHw2HrpIkuGTid0N8qJlLAorSEf2AOwfrR2X1WR?=
 =?us-ascii?Q?wFDls6Bz7rBiYlHSgJQMjDxrSWlwfA0EkQJVTuRvGbJDhto+AP40tU4msK66?=
 =?us-ascii?Q?WXLj2r3E5mWrTSp1iW0QXQfjWlndG5mhZstrtMB4D7YeYNgsXzxzcJjvoTrv?=
 =?us-ascii?Q?j4YujZh7+J5VexLQILl1BOPGlxSiSQWXflRS6BvxsODQuWVKb9BQzsF8v2ma?=
 =?us-ascii?Q?97jBxLijdj11swBpXhzkWQXVSHVfXflG8HtTHrWdmN9ENbqqMyprdMT8HAnp?=
 =?us-ascii?Q?Px1NYNXw4wmBQo6U6tYAxNAydYSGwsX9nOzYvOY8rAYpL0b/gvypzqjPwgPL?=
 =?us-ascii?Q?3MW/093Siu30lOS9h27ax6ic7in9r9R2nd9KW/QhOsBEwuIumdv6WGglBs4E?=
 =?us-ascii?Q?viBcLWQYSfNQ4tmMH5H7UzmucCx9+a8k6tijmtxso8wdWmSQHhsl1lxrYu4U?=
 =?us-ascii?Q?8YKXgEbQ42htEFO3Sjuvwcu/gUzuIM2XbJce7+RvUeZUtPa+zyst3mZ4DXmL?=
 =?us-ascii?Q?WD8rUryTCREvshYPjh43I9QvEzqm9XU8goA/4KucM9ZiLvzdchvXO/ImZAgN?=
 =?us-ascii?Q?n7qpl3PLqW58EwhizA0wmwstJXvlKVSqE25sHgG+rGXFR6WD1XCh4UTg7Abf?=
 =?us-ascii?Q?4W+LoOL9TQP+dVX0VR1qcp9U5hOkvpcjmfllVJqsvsggqFq2kAcKYv+hRKFZ?=
 =?us-ascii?Q?Pb6FoyGQ3wBrlmC5vWFWo/QeokUJS0hl4aKYZGxNXT2wERAIYu/ss5lWodAV?=
 =?us-ascii?Q?iO7H1kw0C/wqyhzdPmwjpidbzEqUFONiEbnH88Hki4IVjB9hMwUYO8AgwSTo?=
 =?us-ascii?Q?IV2GyP8rBK+tRL8ktxoagVvfYPOAHmwc68YMNbPGtcYhUzO+wG3ViYfFACv5?=
 =?us-ascii?Q?hRPT/0J9GMg52+pmm5LXDA9gzL72sSCSnr0125YjZsu4/FtoxKXVsC7Og=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: SEcf9NKvwVtml0cH9y0SHQzt/+R59j126eVbZybejLaah/o/MHwhwmSFLZUOCjvzSz8ZRLvN7Dw1UxtEtdp7ozs6nTdw+dU8NyDZdXpFyK2sMvyOS6ZNczc4qL2fH8GHSJb215xhR2cl7z3/tKjyb1btb6A1a/JUU7tvr4xSPPDOsiuHgxZhXaj7JP6PGO0tkEL0FbX6hxXcwlU/JAeR9rajBKVdFA/um03DJtZlSkIqXpuWvoXZxevYfkQo1jgpjAqSMv7LnjTgMqsVtTZz6iUx2OdXKZrOobkOijlPHhSaTJDVzg/1NKWwVeaYQjx373XYGgs0a/GAQnotRv5fjPQ5xjFh19dGMyqxs4fP7xc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;6:rlFJmOr0QNLQsalWXQdumaNWZZBtDTK8nSUDFXpYwou2KO0z8u1zLjjsSvqCwXJOAkN+ziTHWAjs3hq3vEELEgeRig01AeM1WpLB7jUi9hD2VjsEbn7h1nqFnsy0Bf8r0Exanw77oVc5xMcIRHUiERqqbYo7wUaIshuGOUmc3GEpqDmHRK4TVV7Kd1p4oNjmYV1JmbJ0XRKy8YOPQAjEzoKPP9lKUzcwzNiSP18gK4AVv3i7R8HfrehFNsrB8E0HE9k0StaquRUItpvfQar6hkEjRoHngI7njFZjfPnQaR0mGPVRecWf3F4Ia4Iu3FVvXbBEFUM2+xktqfYRXAza2q7UYua6+Y9TiJsVP/t3NbiHHdu9WD29jJSWvuiAgv+hrKrLS11D0zHJLbzskgz7OxDWrBFLKpKnifq2dXVyM/S7RLXSF1f7PqayEDhswPKuPzit0AvaF64lggeZUSqflQ==;5:x4aFWP2TOyh9+YYBqrgn9jaXz5cVROmIcDY4tkqXW9xN/gM1tJUD6HgnwMO6kkHQKr6w90LrJQbtX5rJi0Ls6uutUp7Bu9ZmrtxkZQQtG8UtGMBt+6LTF56bTsxjAa02fj4lYAqW5z4EpRCWjZ+NxboWbVhJZ+JJReaW6Ik5nv0=;7:1I7l8/Un+jCv4IABC7Mc2htIfULcWGcsFAqz5zZeTn5nrtqRX9um2ypi7lu74iZ+tFAOcfGtHvb7UVkjc9qr9Eor0U/IRfRvLPhtsJGhnCpTpzNPEhve5RA55X40z8K3mXN5630wqE7grejOOpNX9BVdaMsG7o/KIjODXS2G/MusSwT66rInsK5ft8rrbP28fAA22wdIBhRXDA7hKS1hokjD1S/azkqUMqgcuyJ8f+uRkdmqzzkeMenrr9mwGNAy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 17:13:37.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da37006-e628-4e42-c0af-08d62565bb00
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries 
supported clock information from firmware and regiters pll and output clocks with CCF.

This patch series is earlier reveiwed as part of FW patchset (https://patchwork.kernel.org/cover/10555405/). 
FW driver from that patchset is merged. This patchset contains only clock driver and is based on top of 
xilinx firmware patch set available in below tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=next/drivers

v4:
 - Fixed minor review comments received for v3 patchset
 
v3:
 - Added check to pass only valid ioctls for ioctl eemi api
 - Added eemi documentation including ioctl details

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (3):
  Documentation: xilinx: Add documentation for eemi APIs
  firmware: xilinx: Add zynqmp IOCTL API for device control
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++
 Documentation/xilinx/eemi.txt                      |  67 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  42 ++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               |   5 +-
 15 files changed, 1919 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/xilinx/eemi.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

-- 
2.7.4

