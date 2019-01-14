Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6A3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFCC20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="luuS+VoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfANTXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:23:35 -0500
Received: from mail-eopbgr810087.outbound.protection.outlook.com ([40.107.81.87]:48826
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbfANTXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rRCt/Fp2LLqjvnno6HZDN4J5l5gTptrmTa7RJuTUAg=;
 b=luuS+VoOQhC+/ZxluQJB3R/iL1AS/n04bsA5hWbn8FvZnTRLR7otikNJIsqrTUhPJC2KItyCFyZQyhD5C0CrCdPlhlyWrI3XpjbE0Z9JBLi07vcw0QXReD9vrSR2WarjGXdkAqwS3UP255du4i+bB00QfIgMWyeW+b6lZYlXbCc=
Received: from BL0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:207:3c::41)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.19; Mon, 14 Jan
 2019 19:23:25 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BL0PR02CA0028.outlook.office365.com
 (2603:10b6:207:3c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.15 via Frontend
 Transport; Mon, 14 Jan 2019 19:23:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 14 Jan 2019 19:23:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pP-0001l4-VP; Mon, 14 Jan 2019 11:23:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pK-0006Hg-Rz; Mon, 14 Jan 2019 11:23:14 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0EJN6Sd023265;
        Mon, 14 Jan 2019 11:23:06 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gj7pC-0006DT-4A; Mon, 14 Jan 2019 11:23:06 -0800
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
Subject: [PATCH v5 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Date:   Mon, 14 Jan 2019 11:22:58 -0800
Message-ID: <1547493778-22720-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
References: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(199004)(39060400002)(54906003)(16586007)(8676002)(4326008)(110136005)(48376002)(50466002)(107886003)(44832011)(8936002)(50226002)(316002)(106466001)(2906002)(36756003)(106002)(7416002)(63266004)(305945005)(81166006)(81156014)(9786002)(5660300001)(486006)(478600001)(72206003)(47776003)(2201001)(6666004)(356004)(575784001)(76176011)(11346002)(426003)(6346003)(7696005)(446003)(51416003)(36386004)(186003)(476003)(126002)(2616005)(77096007)(26005)(336012)(14444005)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT034;1:zaSwk3BsIqcatVJsl1IGtsh10CnsK5o0fME/ZAAoIkfE0JBhdPgG1EP7ElPYCa3vw1GSEeXH9wgdwM0/aIL2aFS8mJ4r6R65QLNpsAgweCYueMB24BtAZ1V4Fx3pS90c
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eee247e9-a99d-4bc0-8576-08d67a55c138
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:cb3Y/luvyis5FFe+N9CLSvQR0fNRhVDN7wfiMkjZo8MU9IIo5DchR3qypbVcHFzI7TpAoTSxTWBMYrBzWextm5CYLQf1NOIL+o0fe0T/vv1AuEEhZH2sD3v6r0vAYHOxGsKVmuqgeoYiAkW7RIB8T8H07Jx5DH6MEhunAg/qyLqfyxk/kouc6QpbijCRjtFktbTPTfdKr3Lg0EovT78nZejXX7qPXgLs8Ek+4coGk/DSavjkLkggdsU1AC3HgfFu/zHBjLJmc/673I41Wq37O4pkqCNuNVh0YXpr58tP1zYUd2dDM2USskoMMTA7bfv7HXvV9m8/CDVuEUD6dfSsgSXD8MxM+GZbHBXjYSMi7KBCT7dAykL3al4uV52FSs00;25:QJSpQCQ+xcZXY7lnzABFutyawObRPvVfUPc4z0i4arr4jKLT64KxPqUmM3gGabBI7Khnn5lme7UX39OA15AaUIeO5otUi6KNv2HTbrsLjysD4oV5MNe8t7kSY3SR3gnbk00OFaFCojxYl6j6nhfW2CW2l751TQr7oJRu7piFtnQ0EKjnz53dykmp9dHmpzckAet715gmoGutkEG7SVS8pWqH3kRMAShVEjpodUOuEudrNXCDXYv2c0Q6foEhG1QlV0ftSdC+mYgao5Hws/1uu0ADCx1jyJKBgNuS4gsiKbRnIww4hP3a7XPxlYx2eN5jismr9i9FSb5/WT4GEK2vRQ==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:7mweFguGok38ZO7v/13n50j9PyZmCq+MVFQwFQHnc9oopCvZZCUCDlQuPaMgp7les+xTsdoSlrBGDgwb8CpE8owCgfuP2LXABP5YHruWFh3Kd8V/IkZNf6R6WF/C0QWJ4wjtHoaozkSjpq9tH5ZEUyJqsKwpmMNnDTv2znkxrYiCwyqrRZGgvNMuzkmewxauuLLoZm5BqfbTXxn3pU8mEQE1ErpZH74y2om32X1qyxQ=;20:8CL5yzRDqy7FIpYN2glS4Hp3iyXjOM2O7DLgvj8hay8ds4ETGb0h/YduBG9U2h4Ho86uvDtzCMkr+PDKNy+n+9A8DUqpkR+qHDrFoze1hVDYH6MLv3kP4fSiVGcHmc5QPcitnGw7fGft9Q05dEPhdFsjxHlQLkEs2khhk1iy34QZAU3s6936LxlPwz6Qipk/rlBgqz0SeEeBSoeFBdhnpqgD3RGcDtmuqH4im3wptYEjE7JKKEtlo9SFD/xr+KFdH1yvxAy75bLPrHH46POAz8EZYteq2skkXiG16OakfjrM6YVfIjwjOfMEL2FAAVA0rjnajDfzraETq83yGDjPaBZzQn3UjEceiif0l54oePeGgnCIO3IIlxptD6IzO+mQDiJFSrT6gv+da1kJpSpuB37agjgV3/01lDvyfIeoxofM8sNPZHBAgHdBj/xQnKhxtX1kyY8/SgtwgIozwjP9QdqUHsOCB2bUizmQsvrRBKOSSyFI9bC43Qhpheq08ulH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3510133F46C17A13B95E7562B8800@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:ukqDglr7MVDKQkv+CqH3zleZBF+Tb3w8F705hBH1oygL0Kxd3RhKhTELkR1FiVcbkkkQQLc7LqAqYzmiRjd5ALUaQa2m/03ezYxU2q/HdF8+BiQHI/m9xyGbsQInaZELWJRKccE4Pt/5kUO1JbrNIHCP+8RjJ+7PuYM4BG9KBt7rJcYNc/3iWsyNKL9NkpDpP74qxdE34AnBoibA5zaRjDWhLM88IrhXcexfOMhB11f5p/lKgMZnH34m4pTF1kltal5oiSRXSY54ty0Vq6cmT4A3iweOtgKwh/djmv+7rAzTBbMHGgRRbM97R6nRw0fc
X-Forefront-PRVS: 0917DFAC67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:uNW5GEaObPIrKdfY2hQ4DwVrE5WA1UGapjgVt9H?=
 =?us-ascii?Q?fgydGmzZLei66FBWGsk4GjKRKtmcbzE26sVYzfN8+C/WsIFLvWYZKJW5pckA?=
 =?us-ascii?Q?7a+JSS0MQ1X63TGT9ZkF0BXoKg1wxSf+E1yyBA/Lzc3XWWB50hdCR6IbbYhh?=
 =?us-ascii?Q?/rQ4/h0KZK39mmvDP4suT0G9tB0B/oVJZeAD3SONhue6So+MeAExChbIFCVF?=
 =?us-ascii?Q?a6eoYHWcSy8SeRPYZoTex3Nof3DfMFVwRW6ZLs3lZ2RYJluqwwYlOuUunDSv?=
 =?us-ascii?Q?FftcG3jtoU1i1Mie3oga577UO6bGN3SwRqWAEYONtVeTwI4DIzWqpobdrHDa?=
 =?us-ascii?Q?Obnpmz0Ar/HjuHnY0Jn5nJEB94ratZfNN1TIj7bzDLM9g1qlzqTkYX5ctimk?=
 =?us-ascii?Q?qjVyzgLcmtYyw3xUQcZdeg0KDFC8VwLEekOwwIVMOHvcEz1XxDzd5Fa52lnJ?=
 =?us-ascii?Q?43t43u0jli3lODA9gLJHrnaSNLgYK+XSQ6/qIJAh3VQ8SYUHYg4X1QtaRqkX?=
 =?us-ascii?Q?DKpLWN/zZF/ZUBlxZd5bfbH/ZZX0MnbeiaBXiw6B5dBjJAT7u0p0osTI78hm?=
 =?us-ascii?Q?8S5YHz43xVYw1jW/l5xK1oy3F9MLTbfGJGNzmwbbhpNpDj3w8fCxrRjTAL/F?=
 =?us-ascii?Q?1RTdQz4gISEdFK0Y48wUx6BQi20j/xxv2IBJdr6WAhPNux+0UFlZZOWsw+X9?=
 =?us-ascii?Q?Py2KFtfF86Fw3oHZoIsh4eqsM5etOPFlXRZwu7W3++MtYrG5CQ7Hs9e4d3NC?=
 =?us-ascii?Q?KyejkdWusaB4LEgv3O1MscgkxVljW60yR953Ge0qK+Bml1MChxevaz2j6QZQ?=
 =?us-ascii?Q?Noa/q0MJ8QcOmCejRS1eJBtkTRMB/wA1HYUrEW/IAkMoKjXiBOEMjDa+U0eI?=
 =?us-ascii?Q?ZZSJdVMAtzY3tWVD+tnFopajL1nyF+cD1ck4yJQnjNDn2vnTL3H8XaS0yp3i?=
 =?us-ascii?Q?iwd8zE+nNleSxkB0IOHqEa1lXP5/P3iPbbZmFPALXEPTbO0lkM7lIcTd4qSm?=
 =?us-ascii?Q?ZcdgMNdSin2HUHgtNxpJ5pVDO2VYYR2ntpU/OJkl9KnP1l1IRIL8aKfruN50?=
 =?us-ascii?Q?zYzMAJOLSxssvtEPGNrK2lzP8683/cItnI9MAFVWPeWITOxdST3X3nbKshFm?=
 =?us-ascii?Q?T+t8exp9G11aImKrPYqgB42b+iHikRSeoS/wtoMeLDJ4auZk2HBw3b0Ip8Z4?=
 =?us-ascii?Q?jypVyRvSgaWbIx1aao6kfCb3dTvwnUsi/r4Z+pylG/hXtTtCeoIQ6QsNB1Zt?=
 =?us-ascii?Q?eNSw9FowzVQgXnnkr0CzxjoX4u73qMWp1UY107QjhGMLKZRQLLTB4ydqWdHV?=
 =?us-ascii?Q?cqp6eYpQ5Nk5QtOq5/S9V8Jj9dEtQ2gXjUoq33/ph4k1Y?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m7TfqJBj0FlS7F+jpqLhY1f8e90ibM2hK2FnavXP8l8EPxM6EFE006eVNo6QjukpKfwCjyXLSdidlGscX6gqJa4s37sXKySvHGl0weh4GVP+whLV4XqicFZDeL0AS8G8v6IXgFLiRoLp66XrkoSO3Vi9QtS9cBgOflB+Z6+I75MfAKWAW47JX7ReYSCT/grUXpodlVSkXIHN7+eyyH4T+hdmJzB9f2YCVGj8ElpEEJ/pSbsFCbvnc5R0hEYTPY1sO4Y/R5402VHnybV2Ny4cejmql6ZAEjetuH92YPNO9Iq0Zh7P/tqn3ZFPxzAkaRwJAz3E3+t9bMGAPeeg/FzkjKG7MzBDNmO3rERR9jXvYd1Xg6VJ9RmQup4MGj3dCsPAUBET4wS7/fg7rpgz59+Q0/WUZbhl58YJnCO0hN0SAr4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:w65A8r6pM/eUXNofjutHbBLUxNnJ693UgpOhwYeuEuS71qeq2OMgcw40iTzdlLn4fDMUuwJyxYaUyaMVvo44pIV+ifn2Ihll8qhKDnostcxUkMfbEGt+j5UeSWBU/ik4yLg0hMiZJRdUiUXA97MNX4zeNBKmY/YJ5+hfWCSuF/EE/4rsuj0IlEgidRVfQHyLtQi8uClRK3powBbBmbdy2Rt7H2m6gd8/zMU8/kOLvbfkL0phR1tng36h9dmmyK41N3ZxQIyXjyj8xriAxt/ZYQ90Qmsjiv6+zNH3epI9fqyV8Q8j9l2oj1PyMzk5ivW3KPCv7QtaXLKxnLk3muUJ3eOs+MpXKT9woMyv9+bREVuYKnpp1l62ZsQvDf2vk8M0a4TLE2PAkOEHrpPeuwyYwxmAJRUVLx1ESdOj0txZIU/fAkfI0D+t0NTwI7HBt0GDRWNJlvxRVJU1N7VC40ZKnQ==;5:yMaMQWzk8mCy/JhsBwoM6z1dM5K6PrVlOQjjMD318QWYMrmAEs/rNLfN2bSv8JP9ABvmP0VXGpla2znVFMAUL0ngE0BK78RpuiLWxLxPThs8sJMaQ0H1p+tjSRQxvgbo+We2j8ScwXfEMaGWlKEO7DimwV5Ml8fvv9pizXBSH5nO3zTACORUSXkvuXnYUnhFpOhUnqMS6LZb5xMOtyWhOQ==;7:FGEU2rbcnFrpsCHiuZ8fM1eCqgQq3JOHmpRQ2NEehSFRHATjGeMR5a1455m8qx3KtS99FJc14mxrP2ZwC7d+A6fnfa6uAh9jFaJxSckMc0sdO4gJ2ZezPHSJKi14J6LO3z20dCMX+XiSY71hT2coiw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2019 19:23:20.7019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee247e9-a99d-4bc0-8576-08d67a55c138
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig        |  11 +++
 drivers/soc/xilinx/Makefile       |   1 +
 drivers/soc/xilinx/zynqmp_power.c | 178 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..5025e0e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,15 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM && ARCH_ZYNQMP
+	default y
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers isr to handle
+	  power management callbacks from firmware.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..428b9db 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
new file mode 100644
index 0000000..771cb59
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void zynqmp_pm_get_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t zynqmp_pm_isr(int irq, void *data)
+{
+	u32 payload[CB_PAYLOAD_SIZE];
+
+	zynqmp_pm_get_callback_data(payload);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		switch (payload[1]) {
+		case SUSPEND_SYSTEM_SHUTDOWN:
+			orderly_poweroff(true);
+			break;
+		case SUSPEND_POWER_REQUEST:
+			pm_suspend(PM_SUSPEND_MEM);
+			break;
+		default:
+			pr_err("%s Unsupported InitSuspendCb reason "
+				"code %d\n", __func__, payload[1]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret, irq;
+	u32 pm_api_version;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	eemi_ops->init_finalize();
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version < ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, zynqmp_pm_isr,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
+					dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
+			"with %d\n", irq, ret);
+		return ret;
+	}
+
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to create sysfs interface\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int zynqmp_pm_remove(struct platform_device *pdev)
+{
+	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+
+	return 0;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.remove = zynqmp_pm_remove,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+module_platform_driver(zynqmp_pm_platform_driver);
-- 
2.7.4

