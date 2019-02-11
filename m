Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE5AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DD1214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VG2wRR/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBJQRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:17:54 -0500
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:61192
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBJQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 11:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv5knTgtK9RSsc6KBM4lBYLMDIpgtSlmpqh7Ir5MlDQ=;
 b=VG2wRR/o5vkZQhbc9u/zDZdqf4jjJP5t9RXwNx0UGViEdaGS3PsxUSsctnzbenDJjZH4tuCgr8RkpVFql6Um1LJpHjJ/EBjrUVi25L5tZDBY+7hlGGdXcx4m0cCsNPKNcnT/aTU0lSUN6shNzXBR/wMwVBSL+5n1PZxjSbIVnFo=
Received: from DM6PR02CA0044.namprd02.prod.outlook.com (2603:10b6:5:177::21)
 by MWHPR02MB2656.namprd02.prod.outlook.com (2603:10b6:300:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Sun, 10 Feb
 2019 16:17:48 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by DM6PR02CA0044.outlook.office365.com
 (2603:10b6:5:177::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Sun, 10 Feb 2019 16:17:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 10 Feb 2019 16:17:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrnf-0003eV-0R; Sun, 10 Feb 2019 08:17:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrnZ-0002e5-TA; Sun, 10 Feb 2019 08:17:41 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1AGHVCv017356;
        Sun, 10 Feb 2019 08:17:31 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrnP-0002bk-0D; Sun, 10 Feb 2019 08:17:31 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Mon, 11 Feb 2019 21:47:54 +0530
Message-ID: <20190211161754.23902-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39850400004)(2980300002)(199004)(189003)(1076003)(77096007)(305945005)(336012)(48376002)(47776003)(26005)(2906002)(2616005)(36386004)(426003)(186003)(476003)(126002)(486006)(2201001)(6666004)(50226002)(478600001)(16586007)(356004)(106002)(316002)(110136005)(9786002)(50466002)(36756003)(8936002)(81156014)(81166006)(63266004)(51416003)(8676002)(7696005)(106466001)(921003)(107986001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2656;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT020;1:D3frkXSp/I8qLNkiVW0zXP7sGxIw+owN4FKF+irnYepMT0+t/cM0mXzbTWxLhkeRE0WqdFf6myaq7muFBp5kuUvEtKlyFhVbFMAycNR9TC/SiXf5Wd/cm8SzRAgUg8BpYfG+FwVzw5Y7/Nf0rg5vIb/IwZAIfglaX1sF/Ox8BpU=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2deaffc1-4481-4f6c-2ed1-08d68f734c06
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR02MB2656;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;3:6QuxsNCKKpkUe3vkJoVwOIlAzcpAx8j1bJ90GEF5o6oud1HjNFWL9CQpNZ0JLoFSO4ZTOd5aDJAYzmlzY3kDlXrJn0PPz+qRPhenUrVgnhfFM3WAUS2TU2gHZrCzbiB+jLon8k7jD7HZBFaeM8mgf0oz8cLkOpLPl/4Nm3ZMtMHrSS5Ib1pxAUEcs0SSDnuNma7PejIqxLR6C14zMmU36Cq3r6r7PzaNh+eFVYe4wDpa9rqh+Jtt5k6hAJbotIKBlFAEFs1KuXxixeBwRYSBrGyUcG+z6z7CKt3nml9nmK8KMvzeQQfGBI4LAa/VhUUAXe+r+rCvk9fJVYtnMv+Q82LZM0oDzrQ2F/FeXe977cWX+VXSLFZQKZxtXO/wzHfQ;25:hG/N2Ig7xL5xHQi6HKsNBXMLY78VvANkdC7KwfuSUECIqEGXu+W3mhpmMSkkEd52YajVMIPuYNWDOjZ5rolSg++xzreTLvLV/8zmffuBDv+nTHSvXDWpsjqmqLAm/BjBniPrLGTXBBWJ3GSvQ4d2g942/FYSDSfdfgN39UOVVse7bgyIwPi2EFBMEn4SV9UNcaEMMf2sphS9g0tY96f/1pRTI1IVEUILYyaqvrVmsff262KXplmdQqchw1dnVoMqpiL/zWd44gFV+TZAjYT6kR3zIbPV/I5YNlamR0Om4CV6Dlxk6JUpBU9YJZMasfN8Ht80IWMOs+8xRjkeIBtAAA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2656:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;31:gg3sIHoWum2a9McHNZTFsB0r2CMbJPQzLHvuYqA6dcuPVyom+Isuntknm3F1HLTyVOCgBnADOiyaMKhMtJOF3KJ3TzgrWwxHaKbINa60mtNwyHBSHYdpvBmHkBILmoGSnL15BBhYH2WqiXrd/C3Gtni5zNW4sciOcT5K5t/x54a9rsrrG+kKhF77jVuj563KhCE94pAOVjy5yEfsWHlf3B28EQcLAHQOGJKTOZ84vHM=;20:coy7HNe3TOzVUb+fTjjrbwe44EXJuU3HTvlaiZRKnejL9NTpVFQmUORzUjn3ucOazqO3dbZblFOjJhlF/Q1+A2/RRt8l+ut6TnDibOJTB/3yJK2LW+ehVW7Yu8Nj9L9wVm8IYNL9oF+CYggainynnx34pQ9hvcLkd9TQozHrunlh1NlkYwxoozn0TrDodz8BeewGFAHEGOL/I/EmBS7dIiHCi+/vpfHBzuMQ+UbIb/2i/eHk9+IKuMry1GzJzpVJgr9dwLDnapaH0nRwdFC8asLkN994N7asFm1Gs8VkT0OBuLIRJYd2TIRhjHY3oTOi4OLOoEDu37Zb0X267Nn3m53l6mAEZI/uQS86b8vQZI8bjFJuBKk7i+JzEc6+BKbJEGbyZ/l1zEaTiihaK2ERnZs9P5pEjqPv8CQLsQ4Nf8XAAtJ9DkW1CLMgJke4UWf95Hw+e/SmKlqLatQWx85qpiOyK6sNnhMOINGzQ6pUEOd/yHMFFpWo76E01waIDJzc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2656468485657BFEBAF411CAC26B0@MWHPR02MB2656.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;4:AhGqXjx3qWvq2sivghZrxRWa794kIO9u9KUghKgLpr5vzAAMH6wyL4j6FYn28n0pC+uyLPUIjQ4gZXKsFEKLagwLMpd5q5x3sV1+yauzhw2138euTxfsoGSrDqMcOZYGHuFZJICCXEM4mYpSgF8QFK37bG+ZEBeAqNR6MhBk4SbDR7M1HXbDUk9XsyRv+MTHvnKtZ/l5KZhjGkwfLyerogvfjBJ737vGE13nAZplJpDlhRYTB1+iknNQkl84GeCIfSx7y4QMCRmKeBV4h8Obvfca27h+zbxRiTIx+1wWaFI=
X-Forefront-PRVS: 09443CAA7E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2656;23:OS6NnuTMMwxapMY12RydzxHirrl1Gs9ggYLXb9Hod?=
 =?us-ascii?Q?6EL4t2pbKS+Aqpkq7zbEZPeCvFY3IvpMcby1LTRRCnNmSFlZXCi+lV99kc5Z?=
 =?us-ascii?Q?g0SLfsZWkv/EUiKxEnenBM1Sl71iwUCX3dpc4G3pUngaxx/RVJP7vgFM3g0v?=
 =?us-ascii?Q?tFDTbNenjwAcDJINz8WveyJWSoJ+vLG13mXyhxn14XB4jR5icvkpsETOA7B1?=
 =?us-ascii?Q?eL/PfXSAvEMQMDxo4fXUxo/SABn6TAT9ggjftA2fYXYJuh2yAMIpVuOko6NM?=
 =?us-ascii?Q?YcECzb8hwrYtyasYlpZJbGkwTJRyDA4DPDx8I0Ua7MWKx6IaOfHRRxsj2kL8?=
 =?us-ascii?Q?E3nfh1161NBJtvYpoGEpMHcqSof5I93Zz6zvNhKXTOugQ3Z5qLA0GUetIrAp?=
 =?us-ascii?Q?vpje8o0eVmveRcZ9NZhiOF9gOppnogkA5R4OmjffSPo9qMSN0cLX+27IUpUn?=
 =?us-ascii?Q?FMtSbgcMmrH3QJmgjoWiZnSGkpeIx41Zgpw0oplqD1jKkkXEGBON7sswWdKV?=
 =?us-ascii?Q?mom00HH2qJi4l8AlrBnaJ43hZEZyjRAMKn5Zvh0CmImZEJHgBXruItsKVmNm?=
 =?us-ascii?Q?eh7gELIfsYIKbh+WDVupvNlIVAar+GB8bJtyltZmcVCJzbNFM3FYU/K7LQLU?=
 =?us-ascii?Q?X6G3N0t8j2+e/pWlvTux07kprsX+UuBT0KIJdOvdeYzr0sA8LIZDjY1WfEoU?=
 =?us-ascii?Q?7wWKwW8qwYUQx2h46i+GqZajeKKe+vZOXCAo6APi9vyTJkImkTZKWvLXBPyj?=
 =?us-ascii?Q?jS1W+VYe0dpc4nDiT7CCbdhIWnqj08X6H7iFzCmzSpHPdxgb+iD39gzG6VFq?=
 =?us-ascii?Q?LF7QQm91R9TFFX+OygarX3YFpYlNVbz5AGsAErMTI2kF7b0E2Teo+3ws24Bm?=
 =?us-ascii?Q?pp0qhUSFkhH4L8O+yESGdsrCQu/i9v7m1/j3F4Tc4Qa+LC1SqWAKN2AW6vdC?=
 =?us-ascii?Q?RzZWbb2YDr4ig0an1cI5GQk0o1lY42dO+tNv5ksZoX1T0ct3nvQkyn2He3W3?=
 =?us-ascii?Q?ejNCYWaoUsvZflejuj9Y3LQyWiP89Y7UfqKKDjKXmWlQ+lmmOdkApSE20ybP?=
 =?us-ascii?Q?yQnzQU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ld89NvrlNc9WdBXhTNHPEcvxczQNdEFj/UAaOpl8sh9jTRqpSVrNdqXdIiIHHP0dLCMMeuun8xXNzzabQ40Km6mtHB6LqK6Wm8kFFx7kS/rruNfFnr4OxzruWwCGUTsGHsKRDAWPrx8aCFcyoE008rsudDLLOkYSvyr9gIdbV8aYEhHcpFkCCbE2uFVynjd4tfOpsHwlsWZqY3hRlhTMtXi+5aUZxuNvsfRE1BKTeaUwX1XTK5TYsJ7tGH+fC88Tde7JqWCXfnyCCFjp8AlReh7M6zlUoqseUuZxgTjHnUHhxclADHnx07Cr3UXSPSmoBB3OsdC627LdrmWZEjfrGNtb/ls05t8Fw3zh2tbvqOOpbJz+UhDucIdkyYvETe0FRBNHrIfAkzNPz+gt7v55Pm7cCfDG8nXv+EjmffW6a+o=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;6:2I90VXpZSkIc5slO7WHH84ZriJa9ktWT0fycYlCFePn3FVa7pfgEq1TSKc80IPRNdOPdPtUyvwkwG+Z8jABHYVhxRsSBHc/878JHl/td+h359fWwx7NMknWjYa9LI7EspHfkJzD2SIgdl/9LHrwtiQbtDRXgXoffbqXkchaG/q/AHQdOy/tjM3hvBn3/if6lIAwkHOVntLj17T2POFXBtjihbw4mKg3GSyZAbvSNn4DWCoTYPDo9cEciOePt6iFQ42famYD3IjWyU7ol2xxQH9KP3ipmVDA5/xwcR0jYvbCIBG+EnBcHyay/+uKMkgEWtKfno2lwe8WlVemjrvmvLXK90rsgIjQCDZwLzbRWcksKE7iG+7RztSFdzau+iUAN7oiX3wqTAFvoBR9dIIni3lB+gVXtDw9ARtR0UCGgn9ZB/BjWaQ1+R5oDhsWd9G2G9tpfP4kQjkeskC/xuBOZeA==;5:FzD1UTKbnxd3SI5GBbVmP4T5EZcVWTjfUtqLEsxSSK1IKvLwLaRbzHYl0IQku/bVF3dmW0kSmx1x5GETkqhR3QpG5lgQ2TG6vUcSXPDki5gzFQcqP1isKCxDGdEdJnpRPn2tohBvkuvY3UuL293taZsmmryjq/SdgE59UyvXefcLamu3muJxXDpaDEkV7RTYlvYmThD4MLQemVtTSDvm7Q==;7:JlMIdOfKwB0E/lL1MCtw8gIHd+MmoCB5U/2sIkzmHMXdBNxPxBrMeuJkf2l3QS7M9Ylbsg2+rbALMX5hCGHOG6mf6ElYnAJK5Mubd4Vg5Jra7vZjs5KQLwIY6mxD8HgJ/h/DE+Av2AqVfgyGI3+fhQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2019 16:17:47.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deaffc1-4481-4f6c-2ed1-08d68f734c06
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMP chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Created patches on top of 5.0-rc5.
                 No functional changes.
Changes for v2:
                -Fixed some minor coding issues as suggested by
                 Moritz

Changes for v1:
                -None.

Changes for RFC-V2:
                -Updated the Fpga Mgr registrations call's
                 to 4.18

 drivers/fpga/Kconfig       |   9 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/zynqmp-fpga.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..9f17203 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -204,4 +204,13 @@ config FPGA_DFL_PCI
 
 	  To compile this as a module, choose M here.
 
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx ZynqMP FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
+	  This driver uses the processor configuration port(PCAP)
+	  to configure the programmable logic(PL) through PS
+	  on ZynqMP SoC.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index c0dd4c8..312b937 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
new file mode 100644
index 0000000..f40c3bb
--- /dev/null
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Constant Definitions */
+#define IXR_FPGA_DONE_MASK	0X00000008U
+
+/**
+ * struct zynqmp_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ * @flags:	flags which is used to identify the bitfile type
+ */
+struct zynqmp_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
+	return 0;
+}
+
+static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_fpga_priv *priv;
+	dma_addr_t dma_addr;
+	u32 eemi_flags = 0;
+	char *kbuf;
+	int ret;
+
+	if (!eemi_ops || !eemi_ops->fpga_load)
+		return -ENXIO;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
+
+	ret = eemi_ops->fpga_load(dma_addr, size, eemi_flags);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 status;
+
+	if (!eemi_ops || !eemi_ops->fpga_get_status)
+		return FPGA_MGR_STATE_UNKNOWN;
+
+	eemi_ops->fpga_get_status(&status);
+	if (status & IXR_FPGA_DONE_MASK)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops zynqmp_fpga_ops = {
+	.state = zynqmp_fpga_ops_state,
+	.write_init = zynqmp_fpga_ops_write_init,
+	.write = zynqmp_fpga_ops_write,
+	.write_complete = zynqmp_fpga_ops_write_complete,
+};
+
+static int zynqmp_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int err, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration");
+		return ret;
+	}
+
+	mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
+			      &zynqmp_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	err = fpga_mgr_register(mgr);
+	if (err) {
+		dev_err(dev, "unable to register FPGA manager");
+		fpga_mgr_free(mgr);
+		return err;
+	}
+
+	return 0;
+}
+
+static int zynqmp_fpga_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id zynqmp_fpga_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+
+static struct platform_driver zynqmp_fpga_driver = {
+	.probe = zynqmp_fpga_probe,
+	.remove = zynqmp_fpga_remove,
+	.driver = {
+		.name = "zynqmp_fpga_manager",
+		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.7.4

