Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94785C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AE022360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LohOOUJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AE022360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbeKOBAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:00:20 -0500
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:58176
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732760AbeKOBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anieExL9+RG2xshNg6iSfGUkR2eEyzzy0FpN6yLw88A=;
 b=LohOOUJPJ3hRaP99qnWc0tbDr3vu7vOF08YBouZ2ftNCxJtj/7sBzSiYyy/fGEbFQxg9twsKnmCCTMFp3AEJuO45fCdnoGf+6O0XJo/xJ0v35x9WRxgQULAdU2OT1tsYVG49OdCZW3unlXZURfMxV5hpymJw2kuIwfFujxq+9Yk=
Received: from MWHPR0201CA0025.namprd02.prod.outlook.com
 (2603:10b6:301:74::38) by BYAPR02MB4328.namprd02.prod.outlook.com
 (2603:10b6:a03:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Wed, 14 Nov
 2018 14:56:31 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR0201CA0025.outlook.office365.com
 (2603:10b6:301:74::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Wed, 14 Nov 2018 14:56:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Wed, 14 Nov 2018 14:56:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45657 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwak-0001hZ-4f; Wed, 14 Nov 2018 06:56:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwaf-0007wV-18; Wed, 14 Nov 2018 06:56:25 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAEEuKfL014654;
        Wed, 14 Nov 2018 06:56:20 -0800
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwaZ-0007nP-Sk; Wed, 14 Nov 2018 06:56:20 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 3/4] PCI/portdrv: Check platform supported service IRQ's
Date:   Wed, 14 Nov 2018 20:17:57 +0530
Message-ID: <1542206878-24587-4-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(438002)(199004)(189003)(26005)(6666004)(7696005)(54906003)(106002)(50466002)(6916009)(106466001)(16586007)(50226002)(186003)(48376002)(77096007)(336012)(356004)(2351001)(2906002)(76176011)(478600001)(63266004)(305945005)(486006)(9786002)(426003)(8676002)(2616005)(47776003)(126002)(476003)(11346002)(81166006)(107886003)(81156014)(36756003)(4326008)(316002)(51416003)(36386004)(5660300001)(446003)(8936002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4328;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT033;1:LkHccUCvLLjjR3asr2DHGUs/Lto/ZBmFHDrBSESkHGj1tRYcYwBxQ56ADhpr8YH/bvdxbsqTWV7/MsZSmHHV7454RtM1MpcBTKlDRLfqm8OFhIV846AdKVPPLT3hhHrG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42d08af6-88e9-48c8-6ee0-08d64a415cb3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;3:zHKW4zEVjNWu8sH8i5TvXMhQvvKdxB92mCohPHfO7RFj0bqSLn9NvdHGYPkW+/PVHpcUhZEagsfiaJXbfacrfWd+MhBLcSmx5uXmZtwF7TxaqPjrh2voL4yz+SDzV0Gt63ZUSmJmkpMx7k3gV4j/NFd8LEzFBCdAF9/H/ebJilbznZAB7AEIVYUCv97XshSSSIv9DaLk5OHfZR16ZY9Wrxi8O446gJ7eA4PNRF08eGuahvJhNJjW7aUOfbaP41IEDX2zJVpzE2rsf6utTmMYMK46R+icw8o1rAaRctcpPhYJCOtndfQh+vcf/GxC1EsmI9jfhSvd+t9ItevhEWssRJBwdJ5hAiqJg1rK52N/PPQ=;25:kEzeMPa7TByIQlbnXAc1peAzSaasN9i6anfV/uRoOoK2I4g+NQuWcaCnTw/UowJrwbfQig5ctQdFWBtMoEPf3zAujpJNasOIa1Tlsmr4jRGC+etQd78906nbSk7wVMm0LN9czzf0Z2ZGzfv/xhnQvtf26Uz/PZDTvZR22wPi+CDV7Pnjo0aL7Jd8g2YnwHDXpku1OKH2mAaJMEvYU2GMhy3tzUGTTvWXqw4CcPUJPb8qX2CgilLIyI4ufLtp1GZv0jXENBkgpraeaO9foH2b/barkXRebFRXPovKULg+y1kHYFB+0RL5Lo+xDEIfTW1sAcPps9gePj7N+gdPFOF/2w==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4328:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;31:Y5ysOhOoLjgLCrv0afo0D/28pdNHKbJrYvHLbEpJDACigBbeXDyLjDzi8auYZNjtV9Uq4/q9u+H+GhBIPMXh1KqyU8zUfYMlM8SRhgvPJkzKoOU41j7Vf10o5GjciUftumS7bffaMmxDlVCBvDT2AL0SirWFc6zPW9IPxiwV6BaS3DR6KUQy2/kCKsL4O2oNFKwzCp1Qp+1gIoIe8vGY88MIjbGXCME60V4TPqk0x5k=;20:51Nlsys81FgkxLSHTZlCneRdJz8jfnPf4T8sZ4SBp1syulxgQ12p79Msajp008n0fven9W8CpUiE2CfRaAuZgjNX9BA/roM3LGYLgwCvQzF86pHJSfoMd6UfbNuzn7dne/pX+dateLeJ4RCJtfoemQI+IwPDag7QYACnBGfbzKsfphFDbDa2qeu2xPxlw1m+MPWGrjuy73IVVrlsdLQMf8wZjIfyouuPbmO+BTX86kQ25FdxIgVwEdiRlS5VjuvR0VFRHX4I6zbgd2G+7X5upqxpyAQNt4acfoc9PO5ZWj6mJuqkS3CoY9xDvnmFZeFVTdgE+lajw5d4B1YtK7ovTBv81GcY8yUyNHAmodmsZ2SfdMf0offluoe+ndEkRVwZdIu5E3Z9IJPN0iJSVaQ/S4eqyCzsGCRvjvlDzR2Z8ddqJGMdU12k4FZspqQuuVfsuL0q74RSevSDKJUgXBoesyiE05+hl3iKJxNs1zbDpaDFosuWMQlQXWzl7nsiKXug
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB432896553DA4642EEBBCFC3DA5C30@BYAPR02MB4328.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;4:Vz9BsVaTjCuEXMb6ceIQOvLNAT0mi4jB0U78EATRbAmziDUw+uApDieElFR+lUuTA1O8iloxRmVwLTzBmzgt/0704QoyBpi2uV0U/fTVuaszMLvxhAwEPX5KZoAjiR8g4R8DcJ5o3W8zwXMhHuoL6ZuELZDrzKSDbnDdSpeMN581Ziib+S0wSw6d0iXz0NgykVIEAAz3fein2N+SFRb/E/Ap/GAvbXy1AD1fGzuxrVG/X0JFCuirwJYZ2OipNPCFD/roQ+jW6wsTmLqt6IM/cRraoFJcgmU+s5BqOkiCMGoM+7F9bvA3udQSdKk64Hm5
X-Forefront-PRVS: 085634EFF4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4328;23:WMamozrjIw0uZ5Ujh+LqM9LwPx30Doau0IIT506p4?=
 =?us-ascii?Q?Qhy8dDB2o5pgpc/1Y7TK05nONNMZTtAYMY9Trjr4/MFADjKebJNOEbey/2LZ?=
 =?us-ascii?Q?TOK+6Rn6ZQ8t65hOadqEk2ZSyB+rEjbHKgFy4FXGqqd7Jj1PPG3+u3UhoWYS?=
 =?us-ascii?Q?iDhmgRSTmC5bLCUhpZi2vXEWnhheqmC6hTu4q4YKMZ+PmoR8vbsdUPKiPXHZ?=
 =?us-ascii?Q?ymIXeIKqHXvSDs3iVSlaUEXo/fSy1uhj9CiL4dbOgpbLuxBEEZKLkUOGXKts?=
 =?us-ascii?Q?TEQ3nO584ZgHF5PVF3QzVU+yzKfk/j6QjBGp86/BkOFL5jNWaUTsMuhfiXtT?=
 =?us-ascii?Q?ZlmZ/jvhcAu6aD0kYu1ufJSxs3BXOmISytrm6Ng8u8vutabXCSrUShT4KQM6?=
 =?us-ascii?Q?Zi97tGaMtCAQnoq2aNZN9GefOtwsuePoZy70nBhBtiJd5KcqWj1XQgx82jso?=
 =?us-ascii?Q?utiic0kmu2Bcq23THYbKXTsWDzqVHV8UVzVmvb6R2kTHn4vyM6rsJhYDIsC+?=
 =?us-ascii?Q?7nVLtUXGA68APx/oiGL6UYLQmu1t1MRAgwUPzsuO5Ju61gT7FXn2IrU4z43a?=
 =?us-ascii?Q?AcgaHECUniILyWOTTnm9KDezC7AX9+smCGzbt8GUnqE1mBBflp+l8ik+FaA0?=
 =?us-ascii?Q?mEw7qHOhDv/a8RlLrhPzmdE3ZB7nVwWZI35g4E9KbRFO2Dk3aDw65u9ydgTu?=
 =?us-ascii?Q?L9iYS4zf096Zxb8mb+LE84GFUrnCP0sri2CteUwch9/Hevy/VOecejovPJMm?=
 =?us-ascii?Q?mzBCVUHQakowdIik5RJBJbGFc1UuOxzgEfHPewefvKMlNwEMPHh1pN++yV5k?=
 =?us-ascii?Q?Vh8MWchAqM9WDx0T+x/8T5itsHovc7R9+O0AiuGdD163ZY+Y/AHbbULpOpGm?=
 =?us-ascii?Q?cxnS2Ayhel6AT6ffvjfYt1OFL7/qhVj2FqCtdQgGdJsjvavxyjxysD5plgBC?=
 =?us-ascii?Q?Aifd/pU6fng1+1jtRgRh2TLsxgZYy3nxxlqNiZBUZNnOpYNww40xFyAk1QbU?=
 =?us-ascii?Q?sfdLGFBEzecRn56VWZx3JnRYXZzoxr34BjCvVzJbDEyAqeXdfwoPnDrHQ7+5?=
 =?us-ascii?Q?455AQTxns6e9k7okZt5bdA28RbzfFFdMSDdbqg10Cbk3JKpWBHGAmesr7O3b?=
 =?us-ascii?Q?T1SU4qSn8RRkgZkjoCWqgME6V3xAFkivHFcwOocA000ni7JG3we8Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: Gxl5mmpd2RwefiB3iGg0i4MGzq2z0PJ/EIPQJIKK3b8TVY4PfdzJ7RT09Z5m2sFc8MD6RO+MiMGrP7Sn1aKDmjn7vhN2pv+FY/cNymskiJ6wXG7k4n3j9sF7YA2MCtbHBcDo7+otSR+dRaKoAxtt22BgrX76ie4dL8aKlieIqlFSxXc46vY7wq3yanGt4vNkImUNrCRYYDccr2YTbPBTNEGO1hGFGbu2P2ZVtJrE9xES4dr+nRydk8MeDqFcVNGSzbwbcUSfAhLOnqCakGkD8tDWyILriHOqP57xT6I/zAv86AikUWau0291A0H1rqR7Yib9EPb2I4Ok1i02aDrfA6LAcJaNbztDO8/+VAYwJRY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;6:ya1umA8cD7vkI9P6ncMoaIoLIsoQua5zfaaPwyV8Y27Nbgy1KrKebs+sX9NdcYQKH2XBPLyy3qCsJDk4mybzb4X3sKK9WKKy/B+N0nwzelnD9jQl6jGNDTQs7Es/RVPssiNBbWSYA+fNjNCJe+6oqEfb/k4CJBveuX2xG2vX8u2w8CL41bW+gPxvs2bLtJGXNJ61+8vCiY0m96loOlrq51eaGUVwZGTDHhyg7UJ08SsxGgeZ2BQhyZBZUKiQNlLcQBsrJGCoGHvy0cpvbLkvds0pH6UscU0yI87Xnq2sxoRKHxJhHXaxv2wnyCwGaYaK+GjWe25Prnzl/umShMcOK1uO+kTTWt/3hUUpUzcD3W2v4Pl/r94G7+6fBnA6hMxa1FamQ3G861LSaT4aq4AXBSFelhPEjLwv7qM4NynG2AM9wPQ3oqgKsZy8p1tEIBdwIfekGOPMOT9vkwnGhxqvnQ==;5:Y+1KUnlvlADxkUwKX4mUZnPS1Vxga/b92Bz7cLBBuMluogUwj5MivRv9nCPEDdKAHG1gjDxPrpET5KasT+7T0ONMYTCRoAvnzGLS2MHWRpa5WswddLxKb8LwFBxgqKt4JLGsX0SbyjRRDPy0nhoY01GvY4Bmqw07h7KEWvm1RNA=;7:WoxeuM90dMKLK9WQY8f4anVVcEhb+lLXU+nViY2EXfnVkWcgMFmrWGpu0IPD27VYrDULId7CtJuN3C53Xsvb+1AVQAiaf3/o8/QT0gf/qh60IAghMTHJU3FIz6HGft60E0n2eashCQRYMiM4Rz/J6w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2018 14:56:30.6534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d08af6-88e9-48c8-6ee0-08d64a415cb3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms may have dedicated IRQ lines for PCIe services like
AER/PME etc., check for such IRQ lines.
Check if platform has any dedicated IRQ lines for PCIe
services.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/portdrv_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f458ac9..8e37beb 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -330,6 +330,14 @@ int pcie_port_device_register(struct pci_dev *dev)
 			goto error_disable;
 	}
 
+	/*
+	 * Some platforms have dedicated interrupt line from root complex to
+	 * interrupt controller for PCIe services like AER/PME etc., check
+	 * if platform registered with any such IRQ.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		pci_check_platform_service_irqs(dev, irqs, capabilities);
+
 	/* Allocate child services if any */
 	status = -ENODEV;
 	nr_service = 0;
-- 
2.7.4

