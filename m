Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF12222414
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZQTDbj1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF12222414
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeHJSPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:15:48 -0400
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:19900
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbeHJSPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qwHBlGQWEgGgbuibNm/2oogv9eT2EkZpa1U3I1FmkE=;
 b=ZQTDbj1dQNB8tQEz5N4B/5vD2pon0v/Komi0yM+7UUkwqLC6/8l9U6Xhrzj8sXkDlXpW/48XqTx3Dx3x8h7uAkokBC6tY/8Cnh1UvPymP/e23CaH0DPuD3sxzC4zC8bzWhQDutGrgE96541wlTkyOcmY1dU54iOEUNhIbkt1h8I=
Received: from BLUPR0201CA0030.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::40) by SN4PR0201MB3518.namprd02.prod.outlook.com
 (2603:10b6:803:44::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 10 Aug
 2018 15:45:19 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BLUPR0201CA0030.outlook.office365.com
 (2a01:111:e400:52e7::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.20 via Frontend
 Transport; Fri, 10 Aug 2018 15:45:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 10 Aug 2018 15:45:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9bI-0004wI-79; Fri, 10 Aug 2018 08:45:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9bD-0006uk-3P; Fri, 10 Aug 2018 08:45:11 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7AFj8Aw007910;
        Fri, 10 Aug 2018 08:45:08 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b9-0006kA-GA; Fri, 10 Aug 2018 08:45:07 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 4/4] PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
Date:   Fri, 10 Aug 2018 21:09:40 +0530
Message-ID: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(107886003)(50466002)(305945005)(36756003)(47776003)(486006)(77096007)(26005)(126002)(2616005)(476003)(4326008)(186003)(2906002)(11346002)(106466001)(51416003)(76176011)(7696005)(336012)(446003)(63266004)(426003)(478600001)(48376002)(110136005)(16586007)(356003)(54906003)(81156014)(8676002)(81166006)(106002)(316002)(36386004)(5660300001)(50226002)(9786002)(8936002)(6666003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3518;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:h+F/rlrwwD8c2AZiDCGUWG7oBR7BDiTQm26qSGpQ7R+/biQGtppE3ZOkXRh8GGeO94nEqSmhHxOTRt9KANLMRvkAbG+eD3DzrkNA656iMHQf5LuiWzzx/H2Avy35f0zt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da58ba00-d572-4f57-d3df-08d5fed845de
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;3:TWomFYLOm3nAotVBnDYN9Y+nSdn0ZrDsRmhR19wowKfD0P0Cx9svZE3G7blAV62hscAhMBuF66d1lm9OeBl1i4KAuZeXyPMa9wsVf2QG1Q3OiXzC7xlLlYLmEKKgO7jiV7rbIIwhP18TmLBiTTptpDyzwg39IkkTUJmLIu2EEFyt1K3lYo3xc3Mh3+uaZFiVosxH2Q++xTtA3zSZ+KAlItkTtxPccQAVWXC3G1S20nbXZIcrvb4FiFxNJ54slEdV6btE+di4gXjxhwC9xZxv6L/ixX1+r/qNhypwxeTAsWpNMBwvyVo2PxZDPhibmL5m0UCrdGVibipb8ZtfzRroVrTzdEUpjWcjaBxgI+12CWA=;25:1ueEQ4KkoRxta37wK5LK9t/Ae7ilEbmbPjnXIfcK3Iu799PbO4MFDTmEctdOBnz8IkcQ4Fbudl80eYCKD1Fb6MMnb4TBoLxvl2NKbVxOGzO/yyRSXR4faTGsxvpg4nmuhntvXGPwDpRf7T0zufYLCh5w6Nwk6yH49/Nq2y3Fxj8fdMB9oyk/lmMsQ+eTfVqR93VkBjAlctIBD+pjCoZNTc3G7B2qhYq5cOdMdJ6Bur2eY4XaXZdVsdPVZ8LvdRbfmJSWLOJf+mKBn/sYS+OEJwEmcKnvQo3eFddoaVQ2hh8O/LN+ZNK0vPGE99vVs1X4u+Nvtruedx+KpKT2PcnPCw==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;31:no1ULoG8PViFDNBE8Hw3b/Craui7ir/OqjQVEUDAt+n25g9aYbf3mwpUWrUIUc6zupuK/6C5HPpKUvRkPExU2X1mdQkolf9Dmn+n3V0JqY/f4u5gJ9pgEWnyTwYs0w/p7CPFI+OS5FZECaZYEIcQv0X7JLLQjH36HGj4qhNA2syHa/2lPwC3rf82K8zqh0dgJXPMINWSfCd39c2sVK+z8HGcGXD4M0U4TOY6tuv6Uhw=;20:zKaM+nbTJufyE6/Z8AGYvsoOG96lRDPNNa5LJO3rHpzZg3GJBgSf1PJ3cV8Xz2GtoTThcmdyRg+ibflnLe19pAmsSb6QigV+Vo7W2arAs6CvkAIjBwFvJMYBw+qws8mxFcfD0Au0SUpImQi8wE4WqetSE2xCo/0ljPYrswkxsAx6Mtxmpc4N0eqYIBTn85wHyphyFA84YsiN2NjbTLpWtEUctS45u6JEfCYzsV2a7UZgqMyYdCGnDpvju00zXMnDe87ghOmz9ETvqHx8BwH6nX915qd4vvjOrNZPTSShBbabCAxmXiQl1ltN3+o3AGw63AEv+SfzzOtfVuBnP0GmcMXVjS1TilYZM3d0HJqzJ0X3H8NdXJQCAAu++TWdlvOBeV37EU77kjxU7qk0kR1+V5IAOUgu5x0BHNWcZDXOqtTXFSXtUrI3lDkzErPuncfGZWX9BLWlLMB29E8JvxfwFlkJ+Hm6JmyYjaAQU/DkQLYhJDnS+uoICnV5lGng8XUJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3518F4E9F817FE23C6944BF4A5240@SN4PR0201MB3518.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN4PR0201MB3518;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;4:fuP1yZUPNr6fFiEExgpEapGR9CvZ2ou1LhCV+dxsYLjDkXZi/AR/0POfFaphHtnslkyGn17hPGfX7yHv0M6yft77W8PSk4LfMdxl3TeYsJTbVvcqTfGm3A4w78Cj7wbdBXHDN7oS3V1RIJRi0RHymMq937juy4S9oWRdMy8k5zu3FMc7sSPVRijcgVZg/8BQ0rQqQJnkayPmWrknl2BuH+3YHF5k2LEmg8VPwYCfUS+CnQPtJKAzeA4RHzwQW/o8ypAXNAZvESbWHM2qUMohzTfiHPb2obbFwLpJrRaQazXPfcECteVaEfTcKqUX35fz
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3518;23:P5i/C6hfosHi3enox7fJVaJngQMSV/a1fvAz0wp?=
 =?us-ascii?Q?EEUnGTPepJbNdrMIVH9+CBHJYA/MTSJqjkaNYGpa5RSf8hIoFbMwYo85c6HW?=
 =?us-ascii?Q?SIs1VN6ruCe7IpPAuE0r2QYgV/UaL6xLQF5x9ffwbRxTmYTHwJasxrutsXYG?=
 =?us-ascii?Q?R3pnA/zaVzJiF2UOm7lUW5tXLOwv5AgwVJ9gO95KLz5JlzonV9XL/cd2Ol5j?=
 =?us-ascii?Q?kUAzpuqR5m7mN2las++3dbLLZI2wsPUkUerxggQ7Bhsa53U1XFjVG3YTGzda?=
 =?us-ascii?Q?TuDU/+JoGSOPGuJqKMr7lMIOfxrWe3eJlEjLjrdk+tp5MLlhyXBY/YUNaN2T?=
 =?us-ascii?Q?n4SFhconZK4TDu8HuJudE7mL4p0xlBGuwV3eHg1zBmnmPGJVWzbg5pL3LT6j?=
 =?us-ascii?Q?WTKLYFCeqgdIjhtfc9Q6eIFz+/wL8oPdfAU+Q0deMYskhC8NNjxYRBCZWcqY?=
 =?us-ascii?Q?q3QnbVKtOK1v9IjRxELFfPpWhMYxm+ID2W6pY61XSoFL01J+eanTkzIPACod?=
 =?us-ascii?Q?7fcwjedfv9NGVQ8237fYM1zcfu6yNNHv4TBIbg3B/LBbuYSgDuoU3zv52YrJ?=
 =?us-ascii?Q?9MUzGu3yV/JWjJcP9tYUBd6PIWlJCmA/W2dvG/ZD/uE0Kukwqpdd5a4K+V/g?=
 =?us-ascii?Q?wB1OXegXHN75y5iD8zZJ3SDAAP784ffo/kN8/AJHc+7LEofR8v1p/LbyHqsz?=
 =?us-ascii?Q?t3QBwAlHkalDATz7tIQNJ6toQxK9AxqgFm2Y0JZVGWwB6RCZm/N7hbq1fyXb?=
 =?us-ascii?Q?aO+hjsA4NHB+DM/bX24CYbjXnDX2VEGmr4Amx309rQJAfh/v40Cl+/45qPTF?=
 =?us-ascii?Q?Mm0VQxV1Mp2l4v/lgpGb0d7w9VPg4R1OBnGOtkGcGFDPerKIGPdlPYVstZbN?=
 =?us-ascii?Q?rdsq6GdNvaKISTAaSGGzmh79zRGagRIShZOkQqecKEuSVzWkznNsDz3Jm+El?=
 =?us-ascii?Q?8poKE6ZVdusRmD0yKxcVfxADRyFY4s14CVl+I+LCG3JOPXUTtUfkt/Gj9D7c?=
 =?us-ascii?Q?U5/giei+fvCA/szh5GTugAcylgPAj6V+Yeu30uO26uI/HGLCnBnwTovJIBcd?=
 =?us-ascii?Q?5umx2KWobY5caNiQk5PUGOyq1NGJzRBgVZVSCAwurefqk1d/wtQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2m7tciZB564Qgamty1F11lCqb0c41WOI6+m0EloXErkMVilnpSWUVw12p5p7xzxzRYPaQy9UuwctI1o+IVZZwZge9aa8Vvx0/U8MAtFmZZ8T4J2Dd58Wq+d1hoYeZalufVx7oL0Nzjf7fhb6/tEIDb6qRz71pv/NWjj4P1d8Y7ml/gC0gaHV1t8HJd6L7Lt6BkzJNc6EEfLMzYXyQYuv/iHsfY8PXd58piZDHOtnicDnbU8CpH9s2iVjtoB5i4H/uBemmLloJkPTUWcaQftvKFJ+OmT3tY6BwGSEuashpGmYlUXHBLtmXgk5TICL7Okp2v5X0AFlxRuNSvKOwYo6EsWSlgasxl1jYD3rg4JGSv0=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;6:lGf7JzUziIJJEdphIm1xTIZKPWBKQA/6pYDFigf+qTvDNyrp3QUDZNY5YwUn9NU5mno/kobLWQg3FfBemPsWjU+4BMYxNF9EI28Fi01o1WK8nkyqMn3u/4iFMKIR2wFoR6LLk4MQZWATBPUg2YKEQ6Ge5QBW8Mwhz+ftRYk9NmzMyiiO/QxbDwdoYS459iSU9P6vozEbB1VcZv+/UR0iDeUcmFGFlIvmWy1RALmlSRXdEDDXkU8m+PUSx4LIXMokSygXSFzAhOVhHmBVDyc0JIXo0WkLXPE4EaPa+iUYobX50BB8paNtFng8wfFZRvbJPUEq2gp9cftlgBFN1pV2D3v8MHSnobG2uS3O1jBdhfZ8OzCo5qnSt1bgrILSNPffKwMcBKRdiJExelu21o+uo/YOwRKxaWog85guw50z4akvjbksxOPdxE9dlTQw69pJiASwKs3+YbQtBD3c+gf1tQ==;5:wRhqTCiNm8xV6a2CR52E8/qGS7I0z+sQKY7lxZWAhGFMMbZhvmV3N92M5bZ8YkxD/6tS8oS0JHKbU3xKcA/G6cnSBuZ4KwfvOwYNT48E1ZQmeMHOT2NHxsR/2lDqU4TUnsfUF6LbQcOoUnJyZtpeQmFQxSICzaJkTaI8Z+03KHs=;7:vtYcCKXjkNtDJkNsTadN1TdryUdRN7qdxleYDnxkVKWjEQlVKI8W0SXqqUzXQ92h+bFuSpJZFSaSuDkkOsy9LrMsIgducVqzxYlxofbvep6SPxMjlEe3fv2f4o+iZ0eCdU2X4IhbeflvRVKx1rEKcfGXNswA21bxiX7/Dlfq4a+ilkYCm8kmyeGyyBWuMCS2ZhhpAqPBj0uN8L9PgJ3lw2Fz8A0lc4Jm+G4J7F9GbKkt+p8DLTdpaIhwvtSEYr31
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:45:16.9852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da58ba00-d572-4f57-d3df-08d5fed845de
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nwl_setup_service_irqs hook to setup_platform_service_irq IRQs to
register platform provided IRQ number to kernel AER service.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index fb32840..285647b 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -22,6 +22,7 @@
 #include <linux/irqchip/chained_irq.h>
 
 #include "../pci.h"
+#include "../pcie/portdrv.h"
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
@@ -819,6 +820,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	return 0;
 }
 
+int nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
+			   int plat_mask)
+{
+	struct nwl_pcie *pcie;
+
+	pcie = pci_host_bridge_priv(bridge);
+	if (plat_mask & PCIE_PORT_SERVICE_AER) {
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
+		plat_mask &= ~(1 << PCIE_PORT_SERVICE_AER_SHIFT);
+	}
+
+	return plat_mask;
+}
+
 static const struct of_device_id nwl_pcie_of_match[] = {
 	{ .compatible = "xlnx,nwl-pcie-2.11", },
 	{}
@@ -880,6 +895,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	bridge->ops = &nwl_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->setup_platform_service_irq = nwl_setup_service_irqs;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
-- 
1.7.1

