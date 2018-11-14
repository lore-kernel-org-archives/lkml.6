Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7146C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2521582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lJPLClNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA2521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbeKOBAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:00:07 -0500
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:27680
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727885AbeKOBAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=541Qjfgih89el6xGl24hGAYpExOnlYxm4wsXCk2IWdM=;
 b=lJPLClNOchmxAPd3qvdZgXFW8cXv+Gj/wIid4mzwwgrz+BQuwpDTmglaE+Z6ge3Z12nzwuJe7y+NaIrBI1V3BoujyRDoGu3V60aAziTkBp2+3PkSMpH0F++joJLTzgfnY023sZD1ZP+532qTZZH4aVkqj2Qr6xIaKXHV7apiq7E=
Received: from BN6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:405:60::33)
 by SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Wed, 14 Nov
 2018 14:56:31 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR02CA0092.outlook.office365.com
 (2603:10b6:405:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Wed, 14 Nov 2018 14:56:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Wed, 14 Nov 2018 14:56:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwak-0004ki-AV; Wed, 14 Nov 2018 06:56:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwaf-0007wV-78; Wed, 14 Nov 2018 06:56:25 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAEEuNcP014658;
        Wed, 14 Nov 2018 06:56:24 -0800
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwad-0007nP-E0; Wed, 14 Nov 2018 06:56:23 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 4/4] PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
Date:   Wed, 14 Nov 2018 20:17:58 +0530
Message-ID: <1542206878-24587-5-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(6666004)(356004)(2351001)(305945005)(36756003)(106466001)(50466002)(8676002)(81156014)(63266004)(48376002)(81166006)(2906002)(8936002)(54906003)(6916009)(5660300001)(316002)(77096007)(50226002)(186003)(16586007)(426003)(2616005)(476003)(486006)(446003)(336012)(11346002)(126002)(76176011)(9786002)(107886003)(4326008)(47776003)(478600001)(36386004)(106002)(26005)(7696005)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT005;1:fROJkeivkLcehlZxoPzCmW+g9v3g77v6hM5FOo9XvoPJWGVii5H4Ox7RYoYVyprFgVCep1DWwHZyXnxVGQExWWuHTlxAoTSkPYZtjn99qmAfsKEy6DgqJ0ahlKfMqVrM
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7ecc5e-e048-4c5c-1159-08d64a415cb1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:+unW03epwuVq6BthbVGQYzGFf5eF317PJHRI1dsPLz5QdJnogVeJX8ry1RddgEyvIENPnKM2d83TUuW/B/abk9njIfRO462zd0MP1UrSWs/p30IsuNO4ZRQ5FEHOe1x6yjUoTn1K8b6+OB7qhBQs+Mp4DFbqp8RO3R5yyn6Io0qqw77tD38iWKZbGrvaJC0hIppQnu8vTZEde7WqhgEaN6gCY1TvV1ryG6mAeHAN5iq4DA3XYCaLVNhxVqrK2c6wymXksXfe+yTIjXf41hvtWyuPpd0b8T+BN4KiWiOnmXjRWE6rm6kV+eClNsChtoVsMG4xceeWyaULaKDzhENFnSl61rr/XfIVuLZUX5Xi7Ks=;25:pKM5b0mwTvWFbThl5Oc4O9imaw9JNa3hMSPr/ySVDsfOOZIOVuXGbx8z/AK4bP7YSaKNJ/Pgqpecj0UA5BVFuunZRQy3WJlDooN1kX/1N1u/lzza7lzzTSYcqh0wGaaoKjOBOiw6j8+5MfWJd09zUKBtYdeyTctLVYPkUBHkYc9lNRwUwsIh2Y2SHKNkt8icQQbm5+GAGqm3SKGq1OrtdUV9x8MnLJvL91Pzk8Ycku3Fgq9KR6Mzt4vjST8dc5ku3miC/gdify2mh2AflsRHZ7vDE7UyEpJXVGT+hXuoH8g61yG0iC+9lxtezyON1qg8iOy0cOyo9uPPfJPV6yiSPg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:AD1cfCeVDePXCU701BTgskbopysYaEPS6NBH4f/Yl7wlxZHYU+Kgw9IfRpA6rDa8cRNtjj1OxRqdFAS5cXHIXVDMeVKvsrnf6tEvgI/MoYaDBA5PZgRBIZdR01TShj4lStmXSEM/PQyk9W4wPaa5Ycq9kuU3sViMOJe2kS4md9yo/gMyWop9iE6WW/Cf3KRIf3hzghBom4Fvpgr1Lfqb9PcZ/NCdqpnboR2EFOKJn7Q=;20:p6ahcAeTJtRIvaeCWgKTP+XFPDuUadGNxrbLhdIRF8iO5ARLtoyoxEdVO0Kbg6PKtMQvNWnS6PVKmvQNtLn7G6b06onRqrlxczxHx7oock1XvcmS184RSW6RMQfzdwF8OjR7h/mxaO2QXQFp8JQNSkPptzraD3BcRnS6EzQ/87iM37nLRpljYtm9lU5bnfhAla5dIpWxqxrTG6S+An+4uf4K9RvbeWnigQB6MUpzJfvRZ82LqBL8pHdjfwrvUHmVabUtJnB4UJwsSg9Ze/nqPXI7mNswAbxRBvGP/me1PbKSljRqKQIr6fKCevPapjx1k0Dno8yuI6CIF0iEZ+wDelITcGuoDE9lo1M4NKqiGl5V2/HbrKIo6HsCCNVq575G88RRsWMYUXOSzE+yUZmTls+gObU1aoRYMh/8kCaiH0mnObqsQHtOs2aI1ja5UYWqF8ZTTlfTPFoycwolx/pajQU3cTk4msxGjSCfUbczEAARSg2xq0irCJICu/jb+g2v
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4464B701320E75E202EFE8B1A5C30@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231410)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:5W6iE+9E6QPaGfjO3FJfAytIJgRoPDKUS4dvR18RBdcBI+994HT1R0Yntv3a0lobdoEQB5EhXwhDPecXSnJB8OL+/FTZ/Gf5H1n/k5RNbTW1Pfbl5CvX4HAiYzmWyC0mPaEz52SjcDxWU1Qvey22DSJDYfwYwQI5HXUMKfeP0g0DWPIzWtA3cSq7v4SCbOkiopHGvQM3r94C1wgkYjP1wDpIP+6GQREVxU1G1vVOinhoClUgClOl1HmsXDRtb2+HcKLWmdt9fWgz/eWI8/afXNuK9N3cbVka97f0DpNrzWkrX0+0R78Y+tK5sQyL6pQu
X-Forefront-PRVS: 085634EFF4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:h22f2Pk7/Z60pHgl8osv+mfpfJYrW8EaSXx5UhJYn?=
 =?us-ascii?Q?x2Q7zTxIJf9xn34r+QqLW0ibbY4qRRpunxMfMjyVkDp05G5sLZb+gRq7WH/x?=
 =?us-ascii?Q?RXO2dgCxJz9HIXQH4fliulJduxRHZibz7ujfMz6/TDc9Qz+NDOgCOLwq+LdI?=
 =?us-ascii?Q?9GSz2/ijb82TUCpbCtYm8koabxwoDK35vfnwhnAbL29lf6eCmAsB29mmDfQ0?=
 =?us-ascii?Q?nK2p4CK0GxtTtEpKqLod86kcxlbQjMVIaolA2uQThxPEAjTXCzMCrLNVM6TQ?=
 =?us-ascii?Q?TaJJRTvcyTCJX4qKHRgJyN4kT0mkRBDVlGahEvvAVLhiLmMXTA0tdYxb7eBb?=
 =?us-ascii?Q?ziOtrI3N0Vk7O/VyC9/YOdo1Y/KKW0vZZzOQuEwNW3XAQXiEJo5m7pQM6RwO?=
 =?us-ascii?Q?KPhOPUZPZzPLvnYxnKuQDUIca0SaNILJghFFvVdHcxMVxcn7uH3+jXP/cu92?=
 =?us-ascii?Q?CR4b4VLOL4ZgKj8Sg2TKhP232/h2tVBa10ETMnFawDJo/j3yikIqAD3d2As9?=
 =?us-ascii?Q?K9bH93gpS2rMv/D97XjqW42d7jvnaOENf1AiIfww4LINaZeBit7DsIQcNYJ9?=
 =?us-ascii?Q?0fM57YCkaPYq4z35JWlNYPuQKINjF+03XWXQkg2E+CgdIhj5Habc2PfxLNr/?=
 =?us-ascii?Q?RUvTJI/+pgfUzo3/7c9YOt51NkvPfOURkUJV0At7twt2mzjK2CCsRz+iAjeq?=
 =?us-ascii?Q?hf3wjovDmLgJZW+kfQ0MuBAwkonEDbNglmmlvacAneATu0P8s5v52FAU+v8v?=
 =?us-ascii?Q?AmX0Q4nGalj1TdR72Yt7saqnaDYT9+InxNL+3IMbapN7c6EybclQEGe3gDPR?=
 =?us-ascii?Q?zKSRTysMI2c2KeJy9llLNUSLxxk4L+Jt40FtceENOZ2Kl/hiQPogdyENiIio?=
 =?us-ascii?Q?3EkPOv3IC/J7PT8JSaBMvCMo0jwSk66aKS0xmtBOYsCYsZnVCs7h6yh7iBFq?=
 =?us-ascii?Q?7jQ5FPYXxGboijEJDokc2UH8gtKKT/RnVZIstZquVup42iXHLiiMsai5G0tr?=
 =?us-ascii?Q?EVKbv0e7Yrm5lTOKlDaYBPHYSyqR45bSnvCDOWMlGymWu4vYfj51kKOwAmNH?=
 =?us-ascii?Q?La8MXjZjYzgyxilTfEhEpYSyTECI/KVJQYkIEoajKU8Z5yFNDPrEFiPv0Xvh?=
 =?us-ascii?Q?T/RcofBVvg=3D?=
X-Microsoft-Antispam-Message-Info: Y6q990/VIl5EQq5biQ+B9NJctTcPzhRsqE8tIaVF/rsJ0G+Jh9ZK4/287LNgGj9qTx9mU63ocUXjiI+P8OkgmfP9vjToIWdsOu0fLRd3fBcZ3Gj7vvOYhkA3lsDyJKMJLfURq0mWzbcSLpSE/d2bTsoTKU6CeIX821tbReIXknLNXyq86GKcWPOkzoEDJTDGq+G8/BBVV7jHm/3wtVPTsqF2pJ6c+gS04b79BaLIgawck6Ar08kDIgnPTLyWvzwOrxu1qHYZUuhQCQbWkAEjT+v+DFngBWN0qjmTS3XFxAyNm+GSROEnwte6bGbEzRnsWaZ62ZxsiiExwM4SBhoHBfiAguGjPLiikqEyvu6rrzg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:WjtBO+v2rgV3qbYHMiQIXMe2MOhvUSTcLvAMGGlbUAKVtWp0SugCHq9wDssPmh0Be9oNmIrFVNUWQIOJvlXpDXa7FPz9wFJsJ6gVjP5eO5yTicpngX0tqsjd8SprrB9sCLar7ANww4POZvl/9viJUnasLTrORUlItqgCFlSCHDBBFFyunzzrEN94ki8VBM3EpwNGUoDxhriBEHWmbqF0vNKrO2gnKldzSmG1d5pdtwUoACA5rndIkZlsA8t9cDeENG7Jqh4y0mdu5F0uqhOwpdhvEGoRf61VvaYIF5K8NvgryWCMi/1GMYtFPRxiHDaCPXCVbHlCa2/Sp4safAy+eXxmZ4bWZOB35TodH+2pf5uYVi9LP1Z8dGrMjgEqUp8WzvBVdrF6uUF4pQoVgqsDnoibsLuix72oV8cAJvjZsYtLobvviBRs3DAbHovd5L235sTj1sOG628KWwjVVk8p4A==;5:z/e0T7LknZtq3QBVIvl4sYMM2gS3hWKrMp7jFzOXFS74bfutk2PSbO/1xEQBRFBbj0EDgzF5xzOTICEkQAcciCQPNJ5VwhFsVrYsy3zOBGpyuya2Q8KPCm59IqDVZXK4pz4ZqtGS4aYI9baDUDzDF/SQ8BQmhPc0WH7dFOqUsv4=;7:Oa1A4jeD1AMB8J3TN7r3ktCVJTYjl2hM64i3hw93WGkcDorQHIyOEM07RjNuQlORT7rk9QFgNYPjnk9ltL+g5esiPa5loH0kFQGWbhkRYloB6DxKXIXht0DJE7QxNLSo1aZ2BuiUW1S7jKg8jQFXxg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2018 14:56:30.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ecc5e-e048-4c5c-1159-08d64a415cb1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nwl_setup_service_irqs hook to setup_platform_service_irq to
register platform provided IRQ number to kernel AER service.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 81538d7..d22125d 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -22,6 +22,7 @@
 #include <linux/irqchip/chained_irq.h>
 
 #include "../pci.h"
+#include "../pcie/portdrv.h"
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
@@ -810,6 +811,16 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	return 0;
 }
 
+static void nwl_setup_service_irqs(struct pci_host_bridge *bridge, int *irqs,
+				   int plat_mask)
+{
+	struct nwl_pcie *pcie;
+
+	pcie = pci_host_bridge_priv(bridge);
+	if (plat_mask & PCIE_PORT_SERVICE_AER)
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
+}
+
 static const struct of_device_id nwl_pcie_of_match[] = {
 	{ .compatible = "xlnx,nwl-pcie-2.11", },
 	{}
@@ -871,6 +882,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	bridge->ops = &nwl_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->setup_platform_service_irq = nwl_setup_service_irqs;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
-- 
2.7.4

