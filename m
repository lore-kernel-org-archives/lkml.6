Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81212C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FCD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r96k/1Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FCD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbeHATBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:01:09 -0400
Received: from mail-eopbgr700054.outbound.protection.outlook.com ([40.107.70.54]:48566
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390055AbeHATBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24nzfMdNwRVkjQ+gIcRdply1bMWPaXvgWBFCsDHhLKw=;
 b=r96k/1PvjfB6DiUj+/9NQbDcmy2HsBU7fPLNbvNbQEKoswmrheOi3kX5BVGtKPP8D18mGq7+zdC6gZF7HUz32xepOG90XSReNtT+aPGOxbPMx4zRNQXgDaASbqGX8P35dtn7xS9rf4zF+yr9EQI5PxkuYaNKGbEiyXBTGFbRLQc=
Received: from SN4PR0201CA0062.namprd02.prod.outlook.com
 (2603:10b6:803:20::24) by BL0PR02MB4449.namprd02.prod.outlook.com
 (2603:10b6:208:45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:50:05 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0062.outlook.office365.com
 (2603:10b6:803:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Wed, 1 Aug 2018 16:50:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Wed, 1 Aug 2018 16:50:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuK1-0002LE-V4; Wed, 01 Aug 2018 09:50:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJw-0004uj-RL; Wed, 01 Aug 2018 09:49:56 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w71GnpIM001636;
        Wed, 1 Aug 2018 09:49:51 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJq-0004rx-MG; Wed, 01 Aug 2018 09:49:51 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx controller irq with AER
Date:   Wed, 1 Aug 2018 22:14:49 +0530
Message-ID: <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(106466001)(8676002)(81166006)(50226002)(5660300001)(476003)(305945005)(36756003)(126002)(478600001)(11346002)(63266004)(486006)(356003)(2616005)(2906002)(81156014)(76176011)(51416003)(4326008)(107886003)(48376002)(106002)(186003)(54906003)(7696005)(77096007)(110136005)(16586007)(446003)(9786002)(336012)(8936002)(36386004)(47776003)(316002)(26005)(50466002)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT030;1:71d6wl3DXobYy4kuCBcXsRx7RWrdMQl1TSMzo0mZRU+ZW1GbEUOH7e5OYKipWbL0jzfRRlP5GWvfAVqC58SU+yIA116v5ZQsEwZC6ELRfnmKutvgUiRDVl1hPNSk9zL1
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b532f728-c342-468f-e1a9-08d5f7ced4b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:BUtZIitqc3EpM6TAVn48VHDNvjDdxkF22UnXodjd6jU2UPy+5ynVFsodT4bjOUzRX9ApKzyoW92qK6QLZLmv2tBuN7+inv1TRorz/yHZ17OeAdv3LyO+ZY4mwAVkip8xya21YVgRki/ebzcg8I2hQywpuqilqMyzU9iAWJ6J6d1gXtuuaFhQfixats63qXBoIm+dNEG+HBePGMjJNcC6ZpDvKT+r8b+R4NVBb2fPbQza8cW6Rhy3t6ehEcUCsBOnGXfHOhdavQrNLFTIzjEa20cqVahkknD+R2YuNfePXLLv9iLSGgENRM3cDifds+XGsSKX8X1ltQTXx4vzQyN4h6n+CjLFP8el7gvsKnYKfR0=;25:9FBXreKS7AZ8W+BHJtc7uV5hyHxqJoFwC6qvAExHntkczL12CjK9lpl32WLhn/9EO7gqXgDjT+vtGeixZLx8rBOu9xGb+I04w0zGkWgAC+2/zkhZ4FXp0StaM/dP/MTv9NQNVUww7ZJEBsD3ikzzESpLpXCebO2xRiEQ3sHn4XpA2kroMUYNYPeKoGU2hVcZHeDbfemMQzug6LbVrC3hW9homCqE95mvVzWwaykLRXOcelUEbFxtDfjfU3YRYOPKxtMc/WvB/5TAMNW6KLHlfBH7LXR1+DC2xXJE3LfaXwvXTSE/e3qsPOiVHhLaGP0UH2TuWvw1cRcIF3W9ZujbPg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:i50rATyzMQq64P9XobKQYGvgWiU7k7lIlJZeWYeKl6dN5oHfpfWgreHOvH2L4jgIDZxvPuanF9oL6LmC+vsTTDqvw880NpezlqoK8/291K788MdGLifz1VMMCYJveHluOR38DR5WCwryuxE5+PeKwbXqgfAG3oUJ0q5+Cg+GVpBCxPnB4aKXgildheY44no8S1l7+qeAWLdwMtIJNJTX07c63ua+91vQKE/p0tZDd0A=;20:LLmpsudSULbYhvBCgBMEkD4YI1fsYO/50pu0G7YZ8d0FHXr2W0KrWe1XaeSwnFihQ+pTMuc2Xx4PcWy5PjxdyRinC5jtllJVx+KTGFryKxHmgNIKEJt8CZ8wtreUNubyJNSzZjfcqyK4rz9FXRG94xs0tbG0WlIgFARcOgI9gmXTE1Vyxu1PJ4jJ20iWEoL+cX8Tcgx8CiZyvW5nCRXBlTb2lngLqzHBXRsn4iabjxroi5IKJCZnR4Mll/9F3istLeqMPBoSmqBSErEwmu3w627naSsxKMC0K4dxtz+NrvokYGaUSizNn371XQtakMUl9rsEid62NqAKd/YjFZ328f821y/RGx+FOwo8jIMqj5cyWGrwPF2820uiWrGLMLHuXcKIWCdngTnGymwpUYGp+xsdFaxauYjcWTeYHKoNTlA44TJaKSvuJRKmiSEayTBBRjcdEvLuR/rsATSd9lZ0O5n87iJCJii51qKI/ka3X5oLKt9j0Wh1YRKzpTekJo3n
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44497F196EF239DDDE66ED62A52D0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:hXH+bOFsVoYCqhM1tnH/iZJLni8d4OrZJP32poehq2ug5yL1z5Nt0MAv2cfDTQo6rr+6DOlTAkT10n9A3jZpD3OvS+iRFrA5BUeXnY8O7ZkY249KztXNeRB3hZuQPofORuZSdX/g+/yGluN+JHAR9iv35QGs43FkXs07Xzo1sw19ic5U9Zc0AgPFdnmVA6IBGaT3tLn3Oarc6KwLV91tkV/7mZiIOtxZWch75SGMVdToOYyCC83YyDxP4TmET//SK6FCDKI1SdKYF57QM3ELrnNcYBfPHa73rBC77+n3N239otU0rajql+g4zjogioF3Y8kYvhRgqKmz81tBJBL7Ys0ZgRFA8btj+y0xtTeNGhY=
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:YY0LtyXHG2gKBTsSv8Agn//4AdO23/9cOhfPKkdBR?=
 =?us-ascii?Q?1JOuYOgF2r08IF/wmTlvmCGbrfpmWSU47lRl/y5q+VQK0S3rRClgamrnZq0/?=
 =?us-ascii?Q?nax+tKRCUb/Vx9MD2+APjGQnriLFjF+520Ck1zPEJBPxsExoYsiUe1g4A1bE?=
 =?us-ascii?Q?eNXWTofes/Jd3tLSVkEB1R69wEkRLl7ePsA8bRIeFMRiEriCFNjm8ofGo6L0?=
 =?us-ascii?Q?kHdWsCuKfSQsGMFOBfKJI4/q7Edw0USLst77i6ZautrAiC+HM7QIbbA1XBxl?=
 =?us-ascii?Q?IOQ+Ms6CoLencRtNyUFYl4N+Sti90ZVZHjinDPPjumjr8efl54e7aef/iW4x?=
 =?us-ascii?Q?dx1KtR6Qz4u3ddZ2wW/xjT3yKaF3thcq3I3T/Uf1sqflER4KztmQKCHUXshc?=
 =?us-ascii?Q?SYNhrI0Q2IIEWgDSAu8K8NepxHZ/n132TjAz2z/v8zRG9kMacpiHdtKH13LB?=
 =?us-ascii?Q?5wcszSZZvV9egb1++EK1Chegw6eHRmshPsXEU3q8iqZBl4G8V8rzf2VxoVzr?=
 =?us-ascii?Q?XebDWRomBnDn/rHG3+0SPfCbesbarKfFsfP2IrwD+7EpvGrM6HdR17BSr3Yw?=
 =?us-ascii?Q?igLT0meFXKM4W8nPkZ4zmOi61/6NiFEMkKFWu6LY9Vr+dFFPrhy+MBPsOO7k?=
 =?us-ascii?Q?KQHCMB03R4FEnhVD3KghXo/RV7XNY1iCIXvvZJ7MJy+oXC+Ob36zMUgOCsDM?=
 =?us-ascii?Q?LmiLLKtGzN6TNSltuDhaievITJJ3/fRgm3pl/ck347acqKHMXetVX+YoNYNl?=
 =?us-ascii?Q?7TrCX+BITXw1OwpvNpGKEmd4fDWjRaPuA8x82rMTdLhzwtj8wpTZjgJ7lrjL?=
 =?us-ascii?Q?It1qJr+G6z5Vh6f9TSfVjVcsHoFOjRLi7lmw+SEr/jg6xcPbwF/bhISH2Trj?=
 =?us-ascii?Q?clterKkN6e68ZWTxPqXOsoisZOwVb8tQb+74MWkBEWfXIwsO4TB9XrzE+DG2?=
 =?us-ascii?Q?dkNxl+Vw60Is4YYFKQKUKHyD0npuzwp22ECRpsz4c2kf0vFtCi+GRxFsro+9?=
 =?us-ascii?Q?V+RgdlMQNDXWa+0nm5C/JgGZp0FQnh4rOHY8hKrsIN8vP+YchrJIVq6xo9Xg?=
 =?us-ascii?Q?9EQHg09weNOL5iJ4q/0U8Dbi5MT?=
X-Microsoft-Antispam-Message-Info: MEzTbWbCdEh7KyM7AL8wTXA60K+YEjuHCUBIAn7twEebAY6huW1HK4N+/b51i//xkFIX/ia9wJfbUrZyPK9fl1H2Zt6Ha145KN/v270a9voYnhptMYlebmZ8q6bwOZ1hpyz7T6Hq2jq8xsq4gs5+HzTaYYSxVC/LqRadZYaI372/xxQ4euYzIMuYj1ck9+aPOntf5BX9gTIABtL914HruScjfI+5ubReeKzbhk1SvqYzqbydhsyTqNXEBFqiTdkd/vO8Wq4P4M2V+MzdRIS4PsIRStB0YwqX3Sytr6pfi2CmtodtJ4TYhFmOit4TmdLuUYmlNcNdSti07DrsJpp5YU4+jLqDWlsoiHK2KRD6qRM=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:WNIH1eXtl5cL6d2RYypuZTUOY/ltXKEpd8OcuA3mI3z0b+sUOPR71CZm17wB6vd3RA3ytAEnlgyJETm55GtPwoO1+WVnmJyPq4ISaP8LuTSSK8/cYtNm9WRDXll8RtZUbQJZvgb62EvKPQ6ETVSdr1XF3XZUROJvWCa3iZ8zih9kcWN6jC0vCd4NJohKW3/MiWdPHeM+JzwGl7wIV6GaueTRzQclVDs1B+CsgM91tN9vDSycic/ayaBkSzJfR8vl8HH4ZYeV3aQt4HEjwarIFLkjw973I5AGJXK/l2bO3zSuxe+Dt5scSYQXe2A3QqvrRL51uORX6fn3Ip5ywA+5jyA7nJjTC+7qYxYst9XGP+2BYk56ZSxpGwEMNWp2PVUHyuiaoHT+tixFzo2zYyt7wFDYD9GWvRhuBJmOGULeGylgY8alAakMZAmekZCyNO1zQPSG4ECFWz7X0dSUY0htvg==;5:pxjSUXtkfeoPziINIEKfTuMcEq8vFhS/BwKqBxPicc3uy6VGXPL3DAsGVTRc6mrdoOXCsZCQgq69LGrypxQA2wUYS2s3BQa7SiSeexmquyVxcgN3Xv2AsZL6R3weCWQZlPrK4uqYNfjPs9IeytFuPZK0j9ri6uptJgGJ963t6NM=;7:jS8xcgKitLN/QNn2I35hyhN1M9qtgA2tPYewI6mKPEjo44a7eSsMVrItVKXSQE9vIGcu5NlQh/OMw7M/iJSBRq/YAEqlGglDC6ajmkpt29nJxRYfNwOFfRT5oHBORzJpST1ok5h+VjJDQRM4r5effx97Xv/+06zqXNAb9n51yxeypiZFfBPgbskmB0Y1JNhFoyfn2tGslrnftvzYifIj2W35yJL/FSnX59xait0TYfyA/8i+Zj6lwLOuvIJ+n3dJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:50:03.4814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b532f728-c342-468f-e1a9-08d5f7ced4b8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
Error Interrupt Message Number. The controller has dedicated interrupt line
for reporting PCIe errors along with AER.

Using dedicated controller irq number for AER which is shared with misc
interrupt handler in pcie-xilinx-nwl. This irq number is set
using PCI quirk.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/portdrv_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e0261ad..fa9150e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 	int retval;
 	struct pcie_device *pcie;
 	struct device *device;
+#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL)
+	if (service == PCIE_PORT_SERVICE_AER && pdev->sysdata)
+		irq = *(int *)pdev->sysdata;
+#endif
 
 	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
-- 
1.7.1

