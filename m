Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191FAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4242086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="Iivcp2aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4242086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeGPGyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:54:11 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:38544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeGPGyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfQcKmZx33Mkm+P5O0IWtyxo0YRZlA8FSzZMYep7EcI=;
 b=Iivcp2aUcwV6ybvP/3IXf1NQMmD7CW20QkinoAUxzXqDvcdnU3NOfawdK/toOtbCX8RHjIQT+xYXAd+lV003NV0o1ahpXER7gsE570zi78l0XrO7G4tPwBPJ8SYljQt0lFkYTo44utzHIxnyW1xmR5XM6DFa3u9nKO781FkeWiA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (171.82.0.134) by
 SN6PR04MB4766.namprd04.prod.outlook.com (2603:10b6:805:b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 06:28:14 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V7 4/5] mmc: sdhci: Add support for O2 hardware tuning
Date:   Mon, 16 Jul 2018 14:26:54 +0800
Message-Id: <20180716062655.24703-4-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.82.0.134]
X-ClientProxiedBy: SG2PR06CA0180.apcprd06.prod.outlook.com
 (2603:1096:1:1e::34) To SN6PR04MB4766.namprd04.prod.outlook.com
 (2603:10b6:805:b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd70d8ca-371b-4ec4-9873-08d5eae5529f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;3:N39vNKsHSroI/EPI4qWBn/cjeL1uOrdW5RC6+hQ/wKynALMqaH0rKOLf2AOBtzcYvELpKraIf833+irnqCu+1SW1m4P5Es7jMYjdfTwFu5cYNQgwKZfbzTpdX4EqGbnSsaqqGIF7tWKBFnvGrfCu3OfXBMggA0gmEO0HRwQ5COOj9H6vJBT6ISNl3qup6Hea6Jf6hQi2GfVMqeLyxMtWXhOlSnjH458zAwMMugyzCtCIl7P2Xf2T0vDZLleSzVQS;25:oPzydXt23GZD8eutSu7o0+vAhMzZt1UVWGiN1H01SKUgIxDGR++/yT+8ie/fDhlJ3hoM3Kg3Gn5S9GnH/TnhXg4EJbeD7UqshFzy4P5MrFXgME1MPnfLi6a433Qk/7s9Z8BcLpdQl2HLrCaMU4OV8JyeSr4wPSLjrkkJJQXtjo6Zf6Km/JqK/q6mkbCc9dGrp27ttv+NPURFJazQPDrCkLYSP+5K/eiQuzgy9wYNCn1aPTMR5MbsAQHmpuaamv+iI3AsYajJfI9+LJ3QdT9hbZXmvTHeYeQoZdDdZLC64i0LOig2MNkkSR4eCVjKL/cPBAdeksO445B5oXHy5s+R6g==;31:kR5zU/S3uBFJRH0VxOJ/OUR7FKWYMGC5HlsV+l34WQy7MtdH/K9+ZmnrShST/gnTdcBTEla7318wHM2NJOQKIqAuHhj5+qKHk7q/j6PZ3so/53RKAYN9roV2pPkl+R2KqW3gw/H7mEthwZG8/hasfqdfyPrUv6AQcmoufFlrnsR9//5aR5rDnoOIZnG+pstAhDzbsJaklwK9Mgp9NpR3uffCEYJjzYeVQtVVRoi+cPg=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4766:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;20:ftQbVGJBjriZXSh99O6RFvAxVPp4F7dRpY1xkBHZwA/KoqCHJ4FeNlvrTR8fkZKjseCKapoOeeXVs5kxmWW02UnLOT4di7oqV7aL3sq+Ct7vTfoRLRS5IeZVT3Ud4lUmi+6zUDx+remOoLMOr7DTyGDCSzY8b8Ck0uQfhtkrIe94fGUjUyo8QjBRRPYMrmBrXqpSgBxgnKk5GsD50W7BrLbeVMX7ssz3ApQJwQY3b8ewst5LN8PxOu7k5BnB4WizXBVJIG4JpjB2UG4tdI1e5dyesQcjoIcRV/4aXpI2lAmdmhUEldc9IWkao+rFh+v7I6CR/n5cMwqYO9TVRBdPsXh0ZLK+Jb/or6eVG77QKUit6/X/Fc3S4ISFWOVXK3OO+YMwSrlcCQpS94ySTC1XqM4KZZGhm97g6UZD/FIr93E=;4:OmU5ajNDpYSG4w6y3M+Pvh/8uIP4S25Nqfxso/eU0tVylW/h0+nJXkNfSw25ilvH6kYlmnAwZ/6/vm+yXrZ+ZozMdCBPRClvndOWQVR5lwuXpMelwwTa7PYTcypD12wXatTdRLhtCKJK8QGMRYiOf++niT0nJyxSHQVCpNOVuNasmcB40dCAIZY5CkVu+7ar+CO68YKJC71zOc23iwCjgjaeboLf7d+KD+zcQ6AwbczBeC7jNHKZvXh1vgeqzGP4vUb8FBQB/w7VX+2GdC4Z9g==
X-Microsoft-Antispam-PRVS: <SN6PR04MB47665EDA81BE79F1BB45BE92E55D0@SN6PR04MB4766.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4766;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4766;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(396003)(366004)(346002)(39830400003)(376002)(189003)(199004)(54534003)(2906002)(97736004)(6116002)(305945005)(50226002)(47776003)(105586002)(478600001)(106356001)(66066001)(81166006)(3846002)(8676002)(6512007)(81156014)(68736007)(5660300001)(7736002)(53936002)(86362001)(956004)(2616005)(476003)(11346002)(446003)(486006)(76176011)(386003)(316002)(48376002)(25786009)(6506007)(186003)(26005)(16526019)(107886003)(50466002)(36756003)(52116002)(1076002)(6486002)(51416003)(14444005)(6666003)(8936002)(4326008)(16586007)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4766;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR04MB4766;23:DSn6pRvdl+3kkX19katZT2Xh4LatnrqW8iC6o1Gsh?=
 =?us-ascii?Q?G0ko2A7NDXVk41jVHVJ7daNgxAYZClwnzM5o1sm0oIuYYvj501d9KhD19Pc0?=
 =?us-ascii?Q?y4JkkV2OYBnXB9CtXryujy2L5upwHrLccSgyMi41l1eUsPBU/og0wzhU1G6q?=
 =?us-ascii?Q?c5E6HUtsX+ddFFz+KPVZDmhHcO9fWLgyjfpLNyCOYw65GbtTcCpfCzx+KZQi?=
 =?us-ascii?Q?J9ZzK39sEvhsEbQdkOfJtq+3oXcwOV9znwTRJCFBnzSeBQCYEOqClsb6e2Oi?=
 =?us-ascii?Q?L0bmpLl6d7EPfMDy2yVz9JztSs5hL7ll2Ktz/w7hVvMgvxAgekrzfbZ24FxV?=
 =?us-ascii?Q?rDUPdhAflNZTE7UQxZ8L42GoKR6oI3LeEZUSP9bErUeFx0l4bMQ0uk+eYztN?=
 =?us-ascii?Q?4fY5YEYkM30NmJHmxmI57oZUW3MVL7Unl9gsTDSYXRg2YnbjM2X2w3HaYD4D?=
 =?us-ascii?Q?b0MhuVWHnnnUvIp7UI24Qcs3kKVCNJJk8u9YbgqT/qzRioiPmeSVLUgl22ZA?=
 =?us-ascii?Q?QaueYjMWBAN01NVooL7R2WTimmXIXBm9JqsAAJvORgLjRHw01ka1Xers18/T?=
 =?us-ascii?Q?n8+yNrhrZFtOT3ryt7VcIz+4BqiwUFzMRcUP+H5xBmsq84gix/A98p+I6zHh?=
 =?us-ascii?Q?u5JfhJCI/Kuv64VcGA+32NNYbKMU4IX93y7Eo2fHB1mlKRSWtjobwW018UJe?=
 =?us-ascii?Q?zQ/2jkdDYfmhGRc+oyseqnIfxQ3UqBsky/aEF5S91v/QBOk0z/0Y5jdq60ua?=
 =?us-ascii?Q?QQHHa6XNy3hVdDK7BAeG9i1RdHMGQIGKrehifayW7+cQusJon4d1UEsDBibi?=
 =?us-ascii?Q?eg5OPRmpoiGsn2ljcrBacZ4916p0AvdXb6QgM903kBa/JCUuWEkJtOVu3/tu?=
 =?us-ascii?Q?qcG1ChkQznoRNN3tUyPSJHMTot8ldoWIs448K+lyYKZUUgPUCnNYiFKY8R9H?=
 =?us-ascii?Q?RUmtWljX51bsCL574mTYAOzURfRvTcrpDelRpjm170ESoTmVBJYaJKw3GH9K?=
 =?us-ascii?Q?RE8vj5m8cryncNW/EZBrV8vBFqvRCiPT83lgn1Fxz3q9OtVQdNW6kfJWRemB?=
 =?us-ascii?Q?0Jswv3+KhEFTaZ+gxsB/BeBF2Z+sborVEtOlL0WNY+S6Ztu3CExm5eDTDxDC?=
 =?us-ascii?Q?19Rbgqy/6RlQ+4XqPuRDiejHkG2UWeIgyCLxD9OLIFdKOXTaEbzY9vkbaa8x?=
 =?us-ascii?Q?uq8MI11p27IKaBLaka6EalatCSgr0esFtIslvwCl4riTv0eh700sVfXXZr96?=
 =?us-ascii?Q?5yaxnd9/7if4+2GJNT+epYdMMEcW1LEuAPSwqKL?=
X-Microsoft-Antispam-Message-Info: d12xoSrTbP+3CG8Qk/WPNeckQK4VgOEDGgeMVDeIpcQ9XLnx4WOz/siF1WideV4s3GPwu6dadkSPOkdmjPmDDOzOnbqdosTx1PuhWLxAVDn/FCXRJ8yhFMiDNreEnJkUgNRYXWi3euCjRllK85Ws6Xc5+peVsFzX5+8rzrrRDmbu4nwtLjJbYUvolRgYPJIrVnAeDh2yS/8kZi0JY+DOmqRjHmSMfd/U2lsfvF91rS6Bg9luLVFlv+3s5wnACBqNHmFGgw2k7vwehZiTZB6Pelsm0L2M2vypcRHnBcyL2l6b3YRQpBBw91ymICe8h5uhgaGn5jUXTmZzjqGL0Tctjq8f8XrBe2hNVzOMJI9ecYI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;6:KcG5dKODylYNYUJ0WBOIAI9vMGN3Itzg7zXpuKop40hRHTTdrFIsufejBvmZXbSUaT8TFMiwFtu66W+q76MOCf7ozyiMzCyYGhssc0wrMUQ85/DUeaQQh9IkA2ts1eUfXmKdqHoHqBiPXOsGCYWdJCl38hwGLaV00v0xzPyYMbd9FEUhoM5Qbhr09PYXCBQyYfOCVuy3H/Nhop/UcLpVhhJdME1mB86n93M6js/5ZatgN+okYl3Ycui1LT3dEGV1QowlQAxq1Df2HmJ1HE0KH76MrFTVZdwcPrC0bMipXuPIXRKshsrsPfDumqMxo/45CspoeY+pwlNBlHsDngxe1aXNeIS64XnFceAN3nqPm/y93vK2teIJli1pVIUsRYxdHXazPt+Zt6lhzBbIRPuHbb7chaTtjJ34jbhDHzUU803CVkDFQqSDW1D118v2RodR5fMRJMuVc0LfOPS5EkHrHw==;5:1eTu7EkqfAkJrNKvlx1+ztUrkeF7ZqWS4dgCmFKil5TQiQB4Scmgtn4k3Sl6kLiMdbKrbau8VAvRxVuK33gEBCddKeoZyJtuEzV12GhN+O5PZOiI2KPQvPG+4o3Z8om47cJ2bAb4wQRyMcA3KzEGWKoJNUavCqCSyRaLtdub2PE=;24:unb1JfFGCyJ2pvbQXTkRTfJvhRInweg8shcxc/lz+jgW7jy80uWO3jK22jtinbz8H0qlz1+t6hbysIMuao66CgmzNNziBmE45fHXg3l8TK0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;7:ouRk3I0nCsoxuBI+jQ3eapECv9GN5vSmRteJqGnZhM4Y0xN227enJDOdALqdaaU/lhd3AvAwNi5Wi1d7G9haQACl5qex1GklNLzZiT5dgwdskUWcnrGpgv1ilcnnzWf4yrmyb+tKqnjbqbcW6764YCIg20+uD2VcJM0fYfI+hOyVHCoqiW0uMOEUHW0LOx1Ebgwyu6qi8QYldczK319qJvz7R5fqUX6gR5FHwYhBEWtAY/stZnF3B2AsFZ0zzv5X
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 06:28:14.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd70d8ca-371b-4ec4-9873-08d5eae5529f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware tuning function instead of software tuning because O2/Bayhub
SD host controller support hardware tuning.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V7:
	Move V6 change item 1 to a seperate patch.

Changes in V6:
	1. From module 'sdhci' export the symbols 'sdhci_start_tuning',
	'sdhci_end_tuning','sdhci_send_tuning' and 'sdhci_reset_tuning'.
	2. Remove local tuning related functions in sdhci-pci-o2-micro.c
	instead of above function exported in sdhci module.
	3. Remove unneeded braces in function sdhci_set_transfer_mode.
	4. Move change log to correct place.

Changes in V5:
	In function sdhci_o2_send_tuning, mrq.data should set to NULL for
	cmd.data has been set to NULL.

Changes in V4:
	Patch V3 delete register SDHCI_TRANSFER_MODE write operation before
	send hardware tuning command in function sdhci_o2_send_tuning. This
	is a mistake. The write operation is essential for tuning command.
	Add it back.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Add many functions to execute hardware tuning for eMMC 1.8V HS200
	mode, the hardware tuning procedure is based on O2/Bayhub hardware
	tuning spec.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 81 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c             |  4 +-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 94cf3cd75dd3..7747e8ba2e3d 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -17,6 +17,9 @@
  */
 
 #include <linux/pci.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -55,6 +58,82 @@
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
+#define O2_SD_HW_TUNING_DISABLE	BIT(4)
+
+static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
+{
+	u16 reg;
+
+	/* enable hardware tuning */
+	reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
+	reg &= ~O2_SD_HW_TUNING_DISABLE;
+	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+}
+
+static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+
+	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+
+	for (i = 0; i < 150; i++) {
+		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				host->tuning_done = true;
+				return;
+			}
+			pr_warn("%s: HW tuning failed !\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+}
+
+static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int current_bus_width = 0;
+
+	/*
+	 * This handler only implements the eMMC tuning that is specific to
+	 * this controller.  Fall back to the standard method for other TIMING.
+	 */
+	if (host->timing != MMC_TIMING_MMC_HS200)
+		return sdhci_execute_tuning(mmc, opcode);
+
+	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
+		return -EINVAL;
+
+	/*
+	 * o2 sdhci host didn't support 8bit emmc tuning
+	 */
+	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		current_bus_width = mmc->ios.bus_width;
+		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
+	}
+
+	sdhci_o2_set_tuning_mode(host);
+
+	sdhci_start_tuning(host);
+
+	__sdhci_o2_execute_tuning(host, opcode);
+
+	sdhci_end_tuning(host);
+
+	if (current_bus_width == MMC_BUS_WIDTH_8)
+		sdhci_set_bus_width(host, current_bus_width);
+
+	host->flags &= ~SDHCI_HS400_TUNING;
+	return 0;
+}
 
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
@@ -215,6 +294,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			}
 		}
 
+		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bcea179a8d70..1b3fbd9bd5c5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1029,7 +1029,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	if (data == NULL) {
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
-			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+			/* must not clear SDHCI_TRANSFER_MODE when tuning */
+			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
 			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
-- 
2.17.1

