Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3318C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8557026D5A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="L0i72KOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8557026D5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeFZPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:47:11 -0400
Received: from mail-by2nam01on0109.outbound.protection.outlook.com ([104.47.34.109]:49811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752155AbeFZPrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X3a6v7PesVD+Di30ikJABoOUMFVd2uoXKsKrh0v5io=;
 b=L0i72KOijYZhDCJ02ynTs2rkDNybz7MGAiteKhytihFKvr0q0ApoYWmf0DsDVUaRBySDScmbtjOqR2BX2bA+J1IVg90nW88+RXRq1kAD5qm/Nwiw43SU3ApV63M8iZ1qkvTN5fiN5u5S4ljw9CXRoak/8DAJAToZOeD8LF/QkeM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (59.174.248.170) by
 BYAPR04MB4357.namprd04.prod.outlook.com (2603:10b6:a02:ff::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Tue, 26 Jun 2018 15:47:03 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V6 1/3] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date:   Tue, 26 Jun 2018 23:46:45 +0800
Message-Id: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.174.248.170]
X-ClientProxiedBy: HK0P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::15) To BYAPR04MB4357.namprd04.prod.outlook.com
 (2603:10b6:a02:ff::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c88ae6-02a8-4be8-8261-08d5db7c1212
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4357;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;3:jzm/k2LgKEhqmcpyJEMOjGt4Ym/oql4FdQFtQR32dWutHFBxdxjz7t07R9ZTtxdroFkSyy/fb1ezu3+KvsxITRsLGSpOeAiG9UcbVbcK7EloJFIBkC9TymITs6bB3Omuibe/WGpetjbaof+r2HBAc+f0OGzQuQ/UBouA8ESC8nxQCGFvOXj+ojWWPNyUwmCLjHpdgscCGz76e/Z+mXwplEYVXmRNbItAdCqKqxxls/RuYrB4LPo7DdUybZXKGaX7;25:HcIZ8tXplP+8qY130pcILo69/l99ZggpGCVM3VjQFA1tN9q4N06/BeJVqt3z/qLm9Mo5aYkodHqJpPCalRxDcxkEbivRewFVxIld3LkBms7spQAw9gQkJLRa7imIhGpwlh4fn4lB3FvjsEeK9k535vFgZOMh0fkl5DJZ2gj3mnbCTvHNBmmScdv4eNn4++tRmIarV4UPAC21arUNMyTXylHuJXSx6Wi+aXaGM/6JCdhZQaYIW9OYalcUZ2UfeaUTu3DSFhxitENzT4894xqUJBY7S5ClGiNdZIokiLs58Sv8Stn8wvwnQmCdcSMo38e4GUcQa3aTL05v7tJSre/C7w==;31:fwmNfWynRQnYpzsXSoSESQfW/wDKj3w9drDRp0niky8ke7n/ctYwwHT2gGIPsbwAht3Wqv0c/zGLCYhuRKcPzKd3j00aIfsQPoxyUYUNHQAC1fOXp752F4zt0Zkq646AGu3GVer3K8oEYfnlipTErbnHNeqPKlJ7K/NAiSnztU9U7fZIXxjF7sydcp0X5cnrJGfCEJCMJtZsqEkO15Tf5S6BVuU5vjgxWJMqlqwWvF4=
X-MS-TrafficTypeDiagnostic: BYAPR04MB4357:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;20:V1neowHCN0ArCeamjrnQvcuQmfvx1Zk9eIVHFr4UraZsK0FB3h/WDKpADPXIfqfQ9LAgnNUc9t6u1sWd1sU9rYvcw5Kc7jE9YxJ+TvUDgzsJEZhcyp5Sfg1d9/9dbf8mBJKAH9JL0jbaoiU2jUb+UGb+yiGvmw/aORlg0zdJRpyXNKAca1C1mVH8Vr2ug1NmzhKNUOHOGICgj6G0OXebVJZIDVJTA5/5QuBZHyH4vaBBZ3NXOFLwgi99l6WmwjtxZp7dOAZjYe+DXuCFU3hUjzbbecOc3pigpxK8AmgD/nj2Hc4/dXsO/STzMctmo0+EItoLu4/dEXIzJyJGz16uOy0yHgk7xjgBu0qjW06RjQ6R/jIXtLpkWAthg1Lck0DlRt6yhXAtHW0lh3V7vq2mkqDO93UvdYlvlDFljV7ZvrQ=;4:P9wXiGaUkT16OX6Wg41QcXphkLu6iPwEpVql1hgOQi3acklJ7LUuK1gIyr3mc4jcve4Yf26wf8mksUlE0QqhUbSCM1BkHjAhK6qMdXe/KZjlgOnGERILAXMi00y80qWdk27P1LDLZ5QHQZQl+W8+WeBc+QI3dNFhZ3G7YnPcFkzVOmTf5f22Gp+j054C1STXmVWHYqUvKKNx13n8imfUbXzGGUi4BPMa12nlbdRvJ+v1RNrVG+eUf8qyYJuL2j73KJ+ypUOkRaRhmH6L2Fn57hKgDnyLuVmJNxCm8+iUZqt/ygdxO4O2AskcobTUnRNY
X-Microsoft-Antispam-PRVS: <BYAPR04MB4357CA4CE07E7B851B40A6F0E5490@BYAPR04MB4357.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR04MB4357;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4357;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39840400004)(396003)(136003)(376002)(346002)(54534003)(199004)(189003)(2906002)(86362001)(1076002)(6512007)(4326008)(53936002)(25786009)(6666003)(186003)(107886003)(81166006)(68736007)(8936002)(51416003)(6486002)(110136005)(52116002)(316002)(50226002)(7736002)(81156014)(305945005)(16586007)(8676002)(3846002)(48376002)(5660300001)(478600001)(106356001)(105586002)(26005)(50466002)(476003)(386003)(16526019)(956004)(2616005)(97736004)(36756003)(486006)(6116002)(66066001)(47776003)(6506007)(14444005)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4357;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR04MB4357;23:xwtB0TKqf44mLjKeL4fJB83t4vZPB+BIMMOJ/qLQ1?=
 =?us-ascii?Q?pjW2j316zkeMCi2eWSKYwF6isBMZXPdfJieAWfDo/e4uFT8kYP3nnevZRAqR?=
 =?us-ascii?Q?TRB8ZfaLGe8QEqRdBlHwu3rGtYnlpZm53AYdxv7r4ljRHW7PzGbTMRla+17j?=
 =?us-ascii?Q?5CURzjOKy19cYv+X1VsNONGh55bZnCjGzN37ASqnR/6QVz8pUW2qhvY9Nep6?=
 =?us-ascii?Q?2D0oYSkhSP7nXsGchFKBBUurTvA8mHFrnh9Dk8p1+DU7OuRit7ruyNKiHpfR?=
 =?us-ascii?Q?ADJS8rbr9fkeUEYnbYu97Zv0leN7S5D3UuLlDJJE4wUdRtIOl3ceOfz1qgVz?=
 =?us-ascii?Q?rpCyhKIwxO09nPrbeZKkjUSMHa3pHNs+XVIsauqyDWGJ7ztlQXxj/tbGcoCq?=
 =?us-ascii?Q?H8jiS6AkcbMLTNMeefCff8XrEQg+O/Fm0jng5WTSkAHYNyoG0k/Mc3s49gaG?=
 =?us-ascii?Q?ca+O08u0ZsHSY5ae3vHdPb25mLXahabIwEAEe92QbFRciaC0jOW20hQI87fZ?=
 =?us-ascii?Q?mz+717UlW4clULZ1xjCF5fS87vAEnb2KvmfYuHBEoJkdE4J6+pOyMcueJpoC?=
 =?us-ascii?Q?HQ6wvPjALl5O46BR2CrgiLYP1MUxTSuATpelC33YiuB8wTBcVO8Dr4dIanR6?=
 =?us-ascii?Q?lVmmj8w2/UHdjgVbTHv3ZA3ZY0UKxO7o3O8n7H2RVfmm9pBU2vlPf0TFhapJ?=
 =?us-ascii?Q?vtGj/14Q+/gbvrad1p8daJ5Ewm89Eh0JB1AWv7W88obGmi0uKZWNrKCMudTF?=
 =?us-ascii?Q?0WU6bDz2AXzX0zucoyulx/GyTzffgmnbplAww1ruYi5Rv6VJqTjLzWe4v4Ho?=
 =?us-ascii?Q?BkSgvzLMHbGwj/inwhgwi2jEeqqJPgdx4ZDbhXX139cqvJCMAEuhSgYrqJFa?=
 =?us-ascii?Q?GUMvTZi9cxcZ8IGMtUDonPP+zX40S5kvFj9vMFBcp/eZH4wuraZ2jjaRIAFw?=
 =?us-ascii?Q?gIBUC5J/51LIBuybe9U+WbeF3BNjxDYlZSioAL/zY4NLpCur1p6POpAD01f6?=
 =?us-ascii?Q?aAEVBFD1X5RKvR2J4uvDPZi2Gpwzo0TAbyk0UPJ8Fb3r102Xkd0JhjXfzp8W?=
 =?us-ascii?Q?Q/Z4r+RUoY/0k+ct35i2tqh1VZLpE6gRrHVtdAasTo9/2IJuI/h+biqH4v5m?=
 =?us-ascii?Q?266SfwGUJsSEtlicXcRfMHBt7b4rybf6bfVTR7Ui07ConwsExUCvjuXutCH5?=
 =?us-ascii?Q?yhH5SnWeFZVDZHAKSiA8Unmu1oZbqs03Dv6ZqqfJi4HWm7Vm3PtbugPLg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: EPVHDEDV8z9ul+9TVmZREroqj6LE59BSCptwOS2Rl0DKZN3o6t32kX5vRlcrWrKGtxYtcCOu6uRxHBXSFEWwM1e9XdEIBYvsgSTFHa7LVJLmwHU7+LAMRZ4PnD8JluXXa5n0erpY6koaIRPAGwuc8E9cDVrDRGI1FFVCKIDsTwdv7fBkrd9Q30TycQ0kMaqgYHL8f/T5OPHAMoG0UIWyYvRgw3DLyEZ48fTz3rfraAzbSyMzbydisXw8W4CzlagGPa20oQoKxVzMm+1BrVoYhfFT0Lhq49pm2ehMANkrx8tP6gvsiiYr7WTf1Wnp98Q+O8Sor9ahr/DbeAnoZxx1/z2lnmxn5ICOHHmUxI46Gu4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;6:fB4r7N5QAffm4kdF8ZD8z6oAp+R8yUpc339X7fYnxkAaIzOBvmA9DfBmLsoc2Qkg2DMC16KN+9PB5cEeFBC4ZQVfHAP4zRLobUeUDT1cdDccqVKgaKAQSZ04Ux0X75Xi++aOL1irRfNuAs1jR1wInWoxAXqq3Thc8NXrsBMSXl843HQPnSwaNI+qnluW4Ei5ZJUw1fJEoMCS/33ZkhWufWonOBrEXaQNrrfJVeoC3AqPbqnBowCtTyH4koXYH1/8ffHkvvmQVapG4FfZ220phlpqBaAkYUqcbMCDFHUOxzKuzOTPRzajDnMN/gtqfPif4k4a6j14B0ES/unBWGLuKKc5VsQ7ejEsNlUsiSNLmnPKp3kmtKLIspteb/cbVV075S7HdvnQGuxtpu4tE5Ukw/F+YQu5WMMR1XjD72qp+YPmWhMHyC91JC8JHl36oLaIwkmDBeswEZoTmppHzQ52bQ==;5:x54FeOwjM+mSs+67EgfYOIOy+Mw2xXCZIQ6cvwwzo4jQO6BJM3Q0CQPnbwOC1z0kQm3znCMRwLRi8HJu0KwHZVocD4cRhzOZhlpvZpI3yrHjKrB3Bqb+8Gx0MRqbW83ffJXlG28+CLirVqR0KEqOeEOSXsLDFbchMZy6NtccE7I=;24:FwLZ41pT/vAdFalzp7L+iB0d1djPkkRi/itCgb6CH0J0OvFdwirdk0iXvycSPB1c9eDSppLnSQe1GAhplynGUaB7L8XuAvriRzoXWCk6ofQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;7:0BjNL7jFzRqFGR3yNMwGVIc6F2bYaclSMuSrueDEMqZvfCyTdWIvxkisuVKO4bY1tfTR0CK/21ZAXa0vSDxyzpoNj2SyJpo/uH8kf4SRk+AfO/kSdH35ZFUVaMx7n6apt/efaE9jp0ONGmwpT8Yty8bzsF4SYx05E3IcIhHy5Ma1EREXEypK9v6sgE8NQ//9q4PkXsoW3UDYompMkAiSK6QkYlp+ML2jIwY5b4340DEcwkSRivmKBjPqxfUgeb74
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 15:47:03.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c88ae6-02a8-4be8-8261-08d5db7c1212
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
fixed output voltage, bios can set o2 sd host controller PCI configuration
register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and
direct use 1.8v singling voltage in eMMC initialize process.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V6:
	1.Move change log to correct place.
	2.Change HS200 mode clock frequency from 208MHz to 200MHz to meet
	Specification.

Changes in V5:
	Modify code format to pass checkpatch.pl check and add a summary
	of what has changed in each version.

Changes in V4:
	Skip SDIO and SD initalization when register 0x308 bit 4 is set,
	and modify some typo.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
	process if it is set to 1.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 555970a..94cf3cd 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -3,6 +3,7 @@
  *
  * Authors: Peter Guo <peter.guo@bayhubtech.com>
  *          Adam Lee <adam.lee@canonical.com>
+ *          Ernest Zhang <ernest.zhang@bayhubtech.com>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -39,6 +40,7 @@
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
+#define O2_SD_MISC_SETTING	0x308
 #define O2_SD_CLK_SETTING	0x328
 #define O2_SD_CAP_REG2		0x330
 #define O2_SD_CAP_REG0		0x334
@@ -184,6 +186,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
 	u32 reg;
+	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
@@ -197,6 +200,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
+			ret = pci_read_config_dword(chip->pdev,
+						    O2_SD_MISC_SETTING, &reg);
+			if (ret)
+				return -EIO;
+			if (reg & (1 << 4)) {
+				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
+					mmc_hostname(host->mmc));
+				host->flags &= ~SDHCI_SIGNALING_330;
+				host->flags |= SDHCI_SIGNALING_180;
+				host->mmc->caps2 |= MMC_CAP2_NO_SD;
+				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+			}
+		}
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
@@ -293,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 
 			/* Check Whether subId is 0x11 or 0x12 */
 			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
-				scratch_32 = 0x2c280000;
+				scratch_32 = 0x25100000;
 
 				/* Set Base Clock to 208MZ */
 				o2_pci_set_baseclk(chip, scratch_32);
@@ -388,7 +406,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 					       O2_SD_PLL_SETTING, scratch_32);
 		} else {
 			scratch_32 &= 0x0000FFFF;
-			scratch_32 |= 0x2c280000;
+			scratch_32 |= 0x25100000;
 
 			pci_write_config_dword(chip->pdev,
 					       O2_SD_PLL_SETTING, scratch_32);
-- 
2.7.4

