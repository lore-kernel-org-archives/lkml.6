Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87853C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C08E214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cDGuS34N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C08E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbeHPKDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:20 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:41504
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731283AbeHPKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PveYODpwwELo4CW3bYLOHJ6uFoy8G3HX72dCw3VrX+0=;
 b=cDGuS34NghesvoizpemvD2e7+PvXZlWRcX6wdA3/CWs+jtYc2Lwm5q4qEDdNuMlfJYamiD2WpI1Ek2iAxqMpOKtFKeTdSG+lfZK4hwzECSUFtLHda+7GYt91SGXyse0Fy14Z4JG9LBDsJAvlx8u6BIvbrmjCD7iNBNrHzuPxmzc=
Received: from MWHPR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:301:73::27) by DM6PR02MB4332.namprd02.prod.outlook.com
 (2603:10b6:5:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 07:06:53 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR0201CA0050.outlook.office365.com
 (2603:10b6:301:73::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 07:06:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:06:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50032 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMt-0007Hd-DP; Thu, 16 Aug 2018 00:06:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMo-0000wH-8U; Thu, 16 Aug 2018 00:06:46 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76ec9005047;
        Thu, 16 Aug 2018 00:06:41 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMi-0000pj-RS; Thu, 16 Aug 2018 00:06:40 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 0/7] Add Xilinx ZynqMP R5 remoteproc driver
Date:   Thu, 16 Aug 2018 00:06:23 -0700
Message-ID: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(16586007)(316002)(5660300001)(110136005)(54906003)(106002)(50226002)(486006)(77096007)(186003)(14444005)(476003)(44832011)(2616005)(26005)(126002)(4326008)(107886003)(336012)(426003)(2906002)(7696005)(2201001)(51416003)(63266004)(47776003)(106466001)(6666003)(6636002)(966005)(356003)(305945005)(6306002)(50466002)(36756003)(48376002)(8936002)(9786002)(81166006)(478600001)(81156014)(36386004)(8676002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:KsIDvI13tAHLeIn6Zgib9Nesi0inBc22oYpzYx7uFTi9iYgLcDmnjdIm6JwDbXCA+7v67pdhXA3ZR62rqlkVZIosqwDempxVR/SLvqWqyt5K6e4heBncsC64a82HkMgT
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b34ca7-6092-4eaa-dd42-08d60346d7ec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;3:TPnAF16+Uq5Fr16PfxpMQ8+I2t/MgNqzE77a4BFA9vrSikCbb9cvZjavqXqkbRJOdVb3zwozvfUW3Tf0FMCJCCIZsGkBUotTTZpe05al0w4sJqtgUE+xUOeQo9K3Vh4M3e5nGKv0E8rO1SI9LCZF5zrsjmCpcZje/G0jBEUTlKNR4fcEESnEZCCzl/2C+I3K7iA7wBfxdvu6VjmucpcNHuVIVy4GbVrFOOfipfIiVWlfkc/ZztKPHS2z+EiB9GyCkWei+vV+cEKcP8tIsjIXfnhLtoc8N78F9y2J5Y3ZxGtZ6itAHfApsN5St9m5dobDdCjgIYYT74IgMiJvo9j+Vln8UvtP8axObk60CAWtZw0=;25:rawMRzVrmc4fbAxGL9faUm+jh3OMvXKgMjSdkDHqutXUyVmSw8c8OPOwcwY6Ew0MEgFImwxFmTD8ko58clbSf2+KPf0NLD/5njHQe+2SO97NuJWwRxCG5w0ENQrFZisNYZ38gn1GJeOOEw4/jMSDv5WZQkLJa1S4ylP6v7m6ztj8x+4ZpG9fCw48W8nV4EWweykfonhumIBqHSQk/y0M7mPaM2DyRhC/uFmfcmahOoVFUiw4JZJdoPZHzOOi6tTab5k2RANabytdCYm4wJN/t+ITAWxEx/6bGE+KPW4+bI1PyPiY3Vg90cdgu4UnW0Ta4CHH2QqXu+bnnR1Mijqjtg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;31:xmAlb1POzYHh1iT0QzV4mMHPa1+qmNlezEkuEmLMwzo9eMNNglQS87ArEH7eEMIX6ITUogC4aRrk67SMtqBTOdDjUcUuJdBfgDubQ9cb7pr2W4sfoze11WrUmeUNEsysTaI5CijOc0tV8AaOcFwmT713NYuPRs9FbLISL+DK8/WFTwH4ajDc61WJuDpGyVkGqaga/T7XOOYPVMSYZT24S7AjOhlLSngm1CTAHNVTL2k=;20:1HKiqKSpsrelg3TcMb6HcaOkkZ8cdkxCN3eHkUNcKiVA4lz9/ZoU50q8Ymw8KbCkPDiniZE1CIXtuDdTydHANLXAUjbRdy6UkCkKh/VBgJpgfzGRZ/8/9igzLyX9KixOT1D9OaVxniT0qS2hNF/jVBq/q4xpuQr5uXx2Z2xmb0nLlOipKDViHAwjthhfCu5LdK2jWAeGoP9TtRycUO74kdisJUiyCf5l5VTpbQEfJkQG6RHELqxcRlSofgR4f9ZdEAx17Z2FS1gcRXonS14NShFd3ZlPXA8OdBYeushEKNLVQ7wXVlXEE5mdHYhwxx1b4IuBeMPbYhij7qoxqv7/Jjjs30oXjPkOr5djHa7dVJMRZwbBWnlVIC32yDhHEPVYFLY2oNlvNj16bXhpvqdPVfyz/7NCBxBh1AfI9YySTUOP6MMG69V4z4ph/3RbbDTZz6eGFbuOg4PZuXZP/eLGBz1D69b81rVVkNAnC+makyT8e9OpiTBXM/c9Xs74c5s/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43324E29CE40C425797157E8B03E0@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR02MB4332;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;4:sP3kI8wQfy6KFOj0ebNl2D1c53E2sr80bH759qWer+eAwKLP3JUpe4hNtzT4dNnjj6kESjraeIKzqMTB/MBonl2SIpYnazPEr0Nd9kSsBMHRSyQzBmuSxZZafFIz2FKFHp2jlprdoDMh+TYF0kK/A+JD/MZ4p2RRiFG1w1Y/SQUqTrLPfPs+q/MUw/PijEPTYsgUYS316saDjTGyRwbv6s7J7GQ3OdcQgCaC8dzdWKiUhs6URNnhTQbOEAAqfW5Rq6csz5/lWfNNJKaceqybuQ==
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4332;23:rKNYow2xJxcU5aUZgKOONRHxosNAx3lP7tP2wKfB/?=
 =?us-ascii?Q?+m/eBKJcm3gysLmhg4wMjkOulhWn4wZbVNT2ITYNYm0BKsBRU/cKZO9k9bB8?=
 =?us-ascii?Q?rW5YAxf6UEA+izz3yh8MXmpbR5dvJmjSANTj4u2zvFKZz5+JDwMz8QsRUy/o?=
 =?us-ascii?Q?n7mxmXu7FLnc5pq0N5y3gGeWJVJjrf15oOkvinQbDYx0Zej5TSjocWL6IVa5?=
 =?us-ascii?Q?YqyfcCJy8mbGJNvd04vXvoIoQmt5pRye47IWSjZGE1aQ8rVIVEd3Yxgnahrd?=
 =?us-ascii?Q?OYg+kECtdGjvi/604vA/bVQUajeRrCe6VRmlCl6gyFSPiWqZjYkaaGwKIEhN?=
 =?us-ascii?Q?ifXWXbaM9T7twBNdas/EteM0wdLOnXiW6tb+0ZIAd2Mab8uVAx+0+3EoKmYv?=
 =?us-ascii?Q?DGbKvgbBRAvfeOZH/UEF7wOvIJGSiBZiOPWY1ZKuNvzt6YYRxcjcMkXVd8J6?=
 =?us-ascii?Q?sBlVbD+/3lG2gms5L+/AXc1qLNChPLimX6u1lIjxY4b1RrkJ6dp1Uqm1DHPW?=
 =?us-ascii?Q?h2qLexslO1V5ZPEuZ98ochWubwqF9ivWqt+UZgdS9Fy626bKDJPn0alxA1la?=
 =?us-ascii?Q?nqhAEvg5zt3catUEM/EvfDVOtzq45qdrbmuMKqWnzj+82NXtmIxJznRR5otD?=
 =?us-ascii?Q?J6GO46mPFCB8xX7jEtNhjaG4+TzYXuysUK4+C9vuhVcNNVFbrI4lFBo2/XBO?=
 =?us-ascii?Q?3paiSbXdz0iMoil86yhLnTSEiJKj944pso4n4hNvLcpJliiG73XBsH1eahmI?=
 =?us-ascii?Q?56U1QoDgXB7uG0ZUWfqkEl29CZjwcPkeyE5L1dm9/3xX1JTgpPHDdUSGcGXm?=
 =?us-ascii?Q?0QHrsTUl3zKD03Xc8dzuRoJXqYjexbBXtbmeh7gbm0UFM545OcoAMZvdeGEp?=
 =?us-ascii?Q?f7DOwO6dgwyKBFBaWpT2jZA7kQe8Hx7skgis9u7pve3A6XbazICNy7QASMGw?=
 =?us-ascii?Q?MYgo6eMH7b80tj4e6cGJeNu9ExkyJqsd2XcqpOkRRsE7uz95irp1r5/Ll4ci?=
 =?us-ascii?Q?R2LTNPeWzg7sjXCjMSrwMFVh3S7IPh57dXwaCbJtLTyFRaMiZOeHIC9XzO4b?=
 =?us-ascii?Q?WSP0TEFVWoaA2lMLCuPWtiOosxlSsRIkBGed3bjaCer3T7BuJbw1K3TP/duT?=
 =?us-ascii?Q?hBkupjA9EoBuFP8WgeNJ/kt9atDMiyVLBVvGlxaUJrjOzeBSc8OaAsqNFep8?=
 =?us-ascii?Q?wdL2RxDhRt2tKE=3D?=
X-Microsoft-Antispam-Message-Info: Toc4mSWFyrWKe4SyghNbJN/+1Ouqe1tC+GVEHVTeVmyiX3heQdoxS0dweVr3p7QJo0ODznfL8FHdHPmENvSgRfGD3LAZmBaQjvbSyIXhcoUcpfTgeqKgj84KK9yDXaGNVyQcQOlMpLn/D9atkzsJhepKxIdpsXl7y2kAAhx189URLxeGvRVgTr684yZl67S3Bie13P4E1Zqe1vnRbnmalxAXTD25uGbH3Uo3+eOp62VkE7vCmQhk7RIv5hrb5asmX1jBL5Bozmn7ZElEIlz/Hbo4JGFcc97sBpm73yBhZ9NLPiZdwOzOLsnG7sMNzpmJ7lVvIakZj3TgFi4SFz/E+FUu5qK8QenWT/qsZQAlNII=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;6:eQsKniRyIiL4oNglFShB53xZPGM5KbCwVQEjSN5gKDhvn54XA6ygG+ULoN1l0q2LJlcPsjZ/r9pWYyMvP4NufLgr08EAVnPFntI/o4eUFq1z5O2Ku1xVf+3ucWO0jFMk7Uk7yBQOJgR21HLjlaBTazMU558Jk+LpnXddUYRI8J2u92ANlhLFjuuLM9sWwC7tlYMkEksJRfirr3rBVlZ31rlwwQnWmZjFavh4tw1Irfxsd4k4nZ3G37MiiitV1tBkdkF1ASJArlx1k79yHH40gEMKMM8NINdyuKUi22opL6g758MM4JnzWY2cZyzUEkVhg3PD5Q1PLn/p/avoC63ToCnVydXnC1VwZmbtJW0f5AIcb5A32MKP3BJA0Mvl5Ops7n6yVmuw3KO7iPMriH9upOsStKSXAYpPubKnLXB6XB478kXBJHL3wa1UB0FD3cuc2DYMV6RzvzkwtPbk3wRPCQ==;5:L0Sf7oVZRkXHX7mv/FwyO9OhtNsav6tn8gw4NDYJJmLFzisJKq/UFR5aXGy89+U7ytTcOoIHZqnTbVYX3zpU27VFtCTOl2kMaKIJbaSQpiY7bxVcx+bUeGHj+jB9Ue8XG8ow3C6KfZBi+YGLWb3kLOR4SZYJ1+ZC/IWvaEKpUiE=;7:0IlG54OLeYMmOH6N5uyxN2W1tha1QZnOHR6kQRKOyRpvTeAr88yEd2vxYQbF10UM3kFut0vOosbEF16pFYUtTAnEES5m1wXVDcWnzT6MkJLZjxvNtjvnqau8Ja8nz41CGDjRuFfgGVXDTr2FewSkUqygx00Mo3Q2iigAlPcggWVOU9FvJSvQIyD/lL6wDk4gAp15QFGlHGdjdi8x64AjOcP6QcPjUuXORKFszwckBwJx/pjsZ9vWxJdyL1e/CN1Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:06:52.0058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b34ca7-6092-4eaa-dd42-08d60346d7ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are Cortex-R5 processors on Xilinx ZynqMP UltraScale+
MPSoC.
This patch is to add an Xilinx ZynqMP R5 remoteproc driver to
enable Linux kernel to bringup R5, and enable communication
between Linux kernel and R5.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

Wendy Liang (7):
  firmware: xlnx-zynqmp: Add RPU ioctl enums
  firmware: xlnx-zynqmp: Add request ack enums
  firmware: xilinx-zynqmp: Add request access capability macro
  firmware: xlnx-zynqmp: Add request/release node
  firmware: xlnx-zynqmp: Add shutdown/wakeup request
  remoteproc: Add Xilinx ZynqMP R5 remoteproc
  Documentation: devicetree: Add Xilinx R5 rproc binding

 .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       |  81 +++
 drivers/firmware/xilinx/zynqmp.c                   |  65 ++
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c          | 692 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  43 ++
 6 files changed, 891 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.7.4

