Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377E4C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DD720651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5U3BVuAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfANTXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:23:36 -0500
Received: from mail-eopbgr680067.outbound.protection.outlook.com ([40.107.68.67]:45657
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfANTXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrJg8WuU4Q5FHv+Mu37FlEw6dlRWX2QSWzPFzlLmDbs=;
 b=5U3BVuAMZPpFyFSr/4cpovZrbZ5Ev0p6HaXvQfOVIe6WlYomnyhPr1i07xFhDGCAbNhglPsRiLBaeX+ww4tTsyf7lOTw/TyiMgXNWl5fi//kirUF7ZKV6ci+CDbggLexwgjk63ucM+OVoD1K4OnseNpeuQlKJXvMGjM7fkHuSx8=
Received: from MWHPR02CA0046.namprd02.prod.outlook.com (2603:10b6:301:60::35)
 by DM5PR0201MB3509.namprd02.prod.outlook.com (2603:10b6:4:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.18; Mon, 14 Jan
 2019 19:23:25 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR02CA0046.outlook.office365.com
 (2603:10b6:301:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.18 via Frontend
 Transport; Mon, 14 Jan 2019 19:23:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 14 Jan 2019 19:23:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pP-0001l3-Tp; Mon, 14 Jan 2019 11:23:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pK-0006Hg-QT; Mon, 14 Jan 2019 11:23:14 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0EJN6Z4023263;
        Mon, 14 Jan 2019 11:23:06 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gj7pC-0006DT-1b; Mon, 14 Jan 2019 11:23:06 -0800
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
Subject: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power management APIs
Date:   Mon, 14 Jan 2019 11:22:57 -0800
Message-ID: <1547493778-22720-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
References: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(199004)(189003)(478600001)(126002)(7696005)(486006)(36756003)(72206003)(305945005)(9786002)(11346002)(426003)(446003)(48376002)(8676002)(26005)(77096007)(356004)(2201001)(6666004)(186003)(476003)(2616005)(54906003)(51416003)(16586007)(110136005)(316002)(76176011)(44832011)(106002)(50466002)(5660300001)(47776003)(50226002)(14444005)(7416002)(106466001)(81156014)(2906002)(81166006)(4326008)(336012)(107886003)(63266004)(36386004)(39060400002)(8936002)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3509;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:zkkRvIH0v7L6NjIrcR5bfJ/NCaWxc1pnsd3m1HzHypPcfNRaYQem4Ui6I8nA3MsEFwkkAnz46Bs9jyI7frDG3VPghx3BwHOiyrMOo8CdZOTQTxf2z3KsOxaTFnW82LHw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1888bd5-43e3-4157-dc64-08d67a55c127
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0201MB3509;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;3:76oyFUONiBgF3e+hlXeiYwkJYQGxsGvmJatm7RdlWxS7QNDybr2C1UjVLdTF1LO+phKJfr0u4SWo2rgELj1H/6hC3HEJ2ZejmCkDZ7GO+JfLazXrmXJSi5PEjeyvQeyMVDba2sEGd/NdD0BLfw6xtwE8guPUH+WAXXtbJ4Ibdin2aO97rTRuRnq+R9EOaK/dQoe6JwCguywIiMsKTZblV0cCUBKyNVu8YAonEK2FF7kaLMbs5X8MBBh0AgAAVUsT31ivHwZhK10dwHseCdQbNekNbfxZgkKOnLeiv73iEe/uXUFOAuRQ5Rc//Nmu1M7hjv5Y/JJaiQMIuW/cekmgVNwVw1tvkzK3EQoqeyaCaZY3za9NkRJE63Rv5y1Uy9FZ;25:hD0Oj2RkJA4DKahBIPg2TecGXM9QnseUrKIBSbT1poowKPiEft46X6lYMWZzl8ra1dp6+iHtdUeBqdBusGejdBawR8mLHVy5voeOGaMH5Mwo5LZE2udNIzki6Ti/hEWM1aC4QjYIbgExEOQfxyD5kGAXVq0tNdinCfwxtgzNL5xZ4N/ZCYARZ5/w+jXEOwpZq1AZSywH32nZT37VLBYGwNeAWhb4lLBoVL4j7RGyXXslfnvow8Ri+JR7X8JQIuWS9YPYtoD0anvSOLVwV+n/8rfgtQ4J313Fc9J866oDaloOq3sds48SiXQiAzBii/g3AS7C8vT91+IA7xxYZ2XHJg==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3509:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;31:VU9NvErFOGagtw2ME5rvpcP3ahLLUUAmVXSO3R+k0R4CTX61hhNSQ8JtgAQHVlzdbsuiznrlheP+7wtcJB0FzsEiBpLeYpYIoq06uCdALEcRIN/30/uUKVvHgWaoaiZd6oZeQM50bL4j6CvTu+cE4IDyxx61QJuDT8wzVrb2yH+r1d89PVoGddIHuBt5LKSk7p4/xEZ0Tr4qBQvGGpHme+6i/7uTXj1K0EeYi6dW46I=;20:8P0JFFvWEqBW1iXEIu6R8wLb7zABrKFHSTvzZiltG3XXIBhCtx+rOgdn5mCsF7eoBKBuhRlf6D0kXuiWSK1mniT5bvC8UC3DMUz/uLp0RoIMrYBiP9dvnC2u45l1OY0InEyq1xufLYPfDml1r2WGTxmjnxdb/aAx2PE5+alZYWlqa9JZl/XFUxZLXdg57tTzEeJazNZeNIwQO0scE8gItyFfgMKBqiaV8S/+D7T0TV7YgbZYWRw2T97J37lEjY2AiIwqt7foSiyp+5MpK/5kRb5SMluDucNYBxlz827954FWdstD/9VAnIWT2yj3m1qWMDHCtDG1FBdXtaaZIu+zGf//pNPD4jUHlXnDn1Z/mXJVZ0ErlvZzNdexmQZtLYq/yCiqm1s7xt5u+cGEbMkpNkzIUPlwSIukLOSm4JYYF1S2CkScLUfwHTDDFj9ee3Z8jadTTu6V5yK8OT3Q0ndw2FeObVBZkn5mnB84jUtGsej/M6UyUDB4i2h1JXVRETun
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3509D19BD9A684B59B54FB19B8800@DM5PR0201MB3509.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;4:CdlABoTq92ZdBEDlcOitoE9qqsB5PXDgPggL9MdDjrCdoaCfl1gPLqW+aAbxxSC5xDLYr/i8ophjM06D3fnnWat2YSaArAETHkfoA1Humx56c4WUFtO/scm1C7y54uPJRyPHopl06PryaZrwvNV9C8XXdOyegD93gyIHzxtKX8auB6lkPekFXNRM4aNxzfjclkUvj5OJZjU9owiw8iq1gX2Iv3N8QhN+BI9XI8vEWkI+OBpJVp58e5etNBJEaw2ysJhzc4dROpHypL+59ih7d0eA6/oh7e56pwZyuxJo7qHZTPt7bIhUxxFOJfi9+L3a
X-Forefront-PRVS: 0917DFAC67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3509;23:QUQG16IJBdsiLCR20hbxOpc/+EwaFtGSCEQQ880?=
 =?us-ascii?Q?IsS+91ubpR9NtuYfn8ib2ZEa4cG93rlPZDtukZiwqxQo9z/kiFqUx5L5GrS8?=
 =?us-ascii?Q?qFZOBttAa0EmJ3FQIAZDmM8KaGgABhcSeLu2Z30WLVQKltoN73dGSduf0mCb?=
 =?us-ascii?Q?85SbVJGOAaynICEzbo0YhP9qbrNjOoVHnqbRKtpBCuX+zBh/suQJcQ1ZqXy/?=
 =?us-ascii?Q?kDOweBwRtYJlyOltZhAlplF6wUbfkxDijiD1uaGk0+tFUDyPiNeQbkTi/DYF?=
 =?us-ascii?Q?kI4EjhBJdoa1WWFDk/GO8f71lf4k3YsNEYKgLOVMk+KP7+EN5+VP2fXn+S5r?=
 =?us-ascii?Q?eRWwpgm26mIAdYTmRPaWrQTFjoskRFkKPxstDRArG3gqOBte51F4hNgSPjrA?=
 =?us-ascii?Q?mjdycFGyNnCZWBukcJCW3DL0NYwWT5AseBafvGqP6AcGCrRTyNNz+jdgMhlt?=
 =?us-ascii?Q?2M+Iv/BEX6z41qsRjqS9VImGURTzYsWhayuurdRjWPC1Tml/zhchTYjwc7Ek?=
 =?us-ascii?Q?sYghHKMsOKbHN8fPlERoSbYyB3YwgHOuyOTy48Yn9UhNZu/9xlvoFiYsFlf+?=
 =?us-ascii?Q?TYaMuxqhZHIFujNVzHPpUpRVJDHkpwIXl/Yw9DiTR+2XVr2A1Vz9COGmXIRq?=
 =?us-ascii?Q?BN3lZmgQYwQaGQbZ14Xoy6Rmm72SKLI2ySBjNCuiy1NMCDYF9U190a/ALqOW?=
 =?us-ascii?Q?50p/mjePpxmiVB1QTQS7WfKX0337qFWD5W5t3/ePVk280x5KOwQ6J9c562aD?=
 =?us-ascii?Q?jL+agmpqM2yV31cqUwZqGuZTORLeyxm5czIivFwyy49GbJAwIve3XRo7qOaN?=
 =?us-ascii?Q?FNp98L/AyGueZ1WueM2C4pjjGlewbQfG9pLTDX1w1FFDLBCK6Pq67BCogOQV?=
 =?us-ascii?Q?73nTtS2PJfFW0+lb2E87FAn4WFAhLNXKCA8H29HfGylrot6D1jemERDxNth7?=
 =?us-ascii?Q?HidoOTRTVP60DItw38OraSwAtFTHVGTXiFHZCTUwQk/LOQTrsUb5x5Ko16Ni?=
 =?us-ascii?Q?VBW+7UTFsXPuXnxU1WLto+DX5X12rnEnXx2G8/Zqj5hRnFqlwkgvxMBR0VUH?=
 =?us-ascii?Q?7KsZ793e/QsAOtwLUs7puqcSJ0uFceAY1k+tYKMwFndBitSrUmb68gaWph5E?=
 =?us-ascii?Q?xOYolEQ3QcTPXdMoP0cvzQrCpwufUbevK15fVAx6LRJQgsP0zHq8O5DCGGIL?=
 =?us-ascii?Q?IKcbfxvh44kCMpd7gQZVQi9IvgAQr4NL8sdN7+x0+0RiD9uEw/8h5zQ/IS9s?=
 =?us-ascii?Q?SANOb1RWARScmWo4C9OxbkfcZyuG296gegd7vKoKS+hQNt4koKzNd2HPC7/z?=
 =?us-ascii?Q?Jyg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wwp9tCeb2GQxKuLMR6xx9tI0DnzvyZxdWirC71DcqLfcHmf8Lvw/I6CAUJNuKHoJavsyqM/AAmq10nbHRjpkXe7QDbQbi/+6Amlo7sAqq+kBKl2Ofm18sqVYt8Us4Mp54f70wYXrhqIpmaWmJxtFt8FfCRQaNf7hoKwMCxNOQyqZ8lBZCYpjBw8ZwggHMbDLBuGmhiOpgnua0AS5IvHr1Rb8m59RO9FIU5HOPSl7FuBE1rLPSswJ5O85l/8xcxj9hAzwa9DfHx5cAfzxure+YdNm5IE2q7D3umzwQNQtq8Z5wB20oJ7VUkegibM7Q9spK5ueUKy6E3em+CNolkV7PgYhFKUV9mf6vTvFNgRHNbNCLb+hHX+Z5aLNMEZ4mWkAB6xJQi2NfvMHDyUYLhsZqkQYewmddk/d+B06B5gU8Lg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3509;6:WX/3fZEpXzaurS0BL0b9UKixugL6VcOzqI/vhk4WCi6UcM2zDubMBWkfAWHjtzj31PX8XjUtoGyMN7+VSpBbgn8REZNXSd/jT25o1Hxyz/4L0o2RtUYsZLzCSQeex9Dgu9byWoFchbfOzPA16oQRf98j4AsvuZW+uSZ5sV+r4CJP8mX7UHxoKK8CEseQq9sU8WvaFw1HnIqWvDgAlNaPkMdI68+DgnadQr05F89O0WtAvjn2UpvUL4w48v1pSapqknnfIT0Hb4Iqf5Q/hCHQpoHBKmV1P9aSaSPtOYBwWbp+atzGjGmoqBPXzxzt3GGcqhwygpXK9LVSCBFTZrdyxG0mu0DSw5UrjzWJAZUwd6C/WekqHV/XA08K/w2yKwn01T/H5AtsVuoeypobfRQsj5D78fiVVQW/N8Uz1wR9q5OTdv8zNapPgXN3sz95yP90hmnH8jGU1oB/aiJrLLC/3A==;5:1NUimQAzdjSdr2bXOkFXT0YHfW2O2jvcPdPb5AdvHPWhgjkG1WB1ApIvc1rkQISv0dkHkVhUhH3u/hSQ90sKtqNJK4mFcrgMt1EL5cP4CjvjTtWeU1Vrew/pGuBfST4rHUOz9S9A5OeG7GK6Pc6cTB1HLppLZPIj8+CplE6YYaMSTVMctIv0JU5a7gEJ9Rhsuskx5l54XMcywO9RBME4XQ==;7:AJpB1CXpHv3N1iC0vmlOSyuZgcsNQDXmaAXAcXJdPGxd4nYqWqi5id0Oxvf7XaZ+H3Tidx+tW7dNjPIE+Vu42prDp8N1Zqk0MBwXLjBnfQLFmCDMXVmAaKzB2DGXsz7tl+ne7ZwTjiy2XvaLQjgKAQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2019 19:23:20.6395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1888bd5-43e3-4157-dc64-08d67a55c127
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to set suspend mode
and inform firmware that master has initialized its
own power management.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..c7a3b6c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
+ *			       master has initialized its own power management
+ *
+ * This API function is to be used for notify the power management controller
+ * about the completed power management initialization.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
+ * @mode:	Mode to set for system suspend
+ *
+ * This API function is used to set mode of system suspend.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +467,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..1424170 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -28,12 +28,21 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 #define PM_GET_TRUSTZONE_VERSION	0xa03
+#define PM_SET_SUSPEND_MODE		0xa02
+#define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_PM_INIT_FINALIZE = 21,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -73,6 +82,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_suspend_reason {
+	SUSPEND_POWER_REQUEST = 201,
+	SUSPEND_ALERT,
+	SUSPEND_SYSTEM_SHUTDOWN,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -99,8 +114,13 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
 };
 
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4

