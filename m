Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B6C26D65
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="feVGnrN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B6C26D65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeFZPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:47:34 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:45236
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752469AbeFZPrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goPUO82VbV9lMT662mTV8JWIAzZ+1MyO6qoRFAcQNLA=;
 b=feVGnrN/GvoDuqsScB7EhmUYACDZdYmyBZXJFHEq2DeDkXF1tYFcvLaW16BwB/ySbVQLUPyDgzWXf/5e0NGVmHJOrTktq90rE9FwL1E1c+C7DRFNr+tO0VGD3HxxoNBfIFgKqGKPcQESPMH8FMqztD1qtU/cNO2EBTkelmp4dtI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (59.174.248.170) by
 BYAPR04MB4357.namprd04.prod.outlook.com (2603:10b6:a02:ff::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Tue, 26 Jun 2018 15:47:10 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V6 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date:   Tue, 26 Jun 2018 23:46:47 +0800
Message-Id: <20180626154647.11623-3-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
References: <20180626154647.11623-1-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.174.248.170]
X-ClientProxiedBy: HK0P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::15) To BYAPR04MB4357.namprd04.prod.outlook.com
 (2603:10b6:a02:ff::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5516c17-157c-4d80-b6f9-08d5db7c1644
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4357;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;3:e+CgAIwaEw72yYyHd1soTppox3D7W9sKBJaabF2v38PM31H1RSuOZX3s9syZyGL0fLvc7s7jx5mEI1Vi1EmXBJYf1yygabIJR+6DYniczQwnhyXAYnD/GQPXjnxNcURHO2n4ilgTyPqXjr15rAC3wbBaJTTbu54hMiLNKDB3kS/Y5xPiGeQAHcR4sDGBryj7cr/2MoSUCi+PqfphBtit6r82uz05nkyjR0ysVYvxnm5UmYieT72SUTN1e8E5Ds17;25:Wj9u7356ZlTWa4XFOdxfnCeOgQbYVFAk8W1hEtIuOTQwb6q4tL2ZnHsodcMW1rmS0TBQIqRsO9ej/UYpDuQAIJQVN8bgAOJexRxMfBkI2LMxvMmyraqJxTAYy1+MVsfASDXo1Od4+dqPxBZUvHsv8LCj6kPi9vAuepwJ9R1aOq0h6YxsROzDcsRQy8F8UPNia3bsa6qXoHl6uTVToPTkMysHFOBUqmmqoMEnmJNewnb8pdP1oMqn6vaGF77LTnjtPbmR/hIuwCTW2VgZqu7T5WY2L8HH7tTjrvsVF+NFKP69G6V5Ea7WlsL45wao2pLXiryWtMOmmdZRDA+WGvvfXg==;31:A1KZsDnTUSTv1+qdRNlTxI1aCwy/WhgYVRAzcke+8bGG6YcPcVV/HxCCAdX97P33+iinTIU9h48+XZuxHxXrHkrok2wdD7SC2OVCp0c/notSnOYH3j2DIyc6Bv2N+28oPqkTFWRZZnKNHjNvP4xQW/zeBDEARq7+bhRpLG34BNZjtaiDMMnF4VKALEqdySUqD5NJM0Tj/dotIa8Y5pkd281RB9jwSwn3AztB/tUiz34=
X-MS-TrafficTypeDiagnostic: BYAPR04MB4357:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;20:gg0K3xKQ3Rvp71gkK7ti7/ngkor1zqIR7YYdO9WMs73IfUTE4K3PFTeQQPZGXtOmLEOEXnNBWG0YpuqHT4xzUWuj5cY+z0iRfttBK3jCuEPjw+qSkGDyBjOPA/sOpDKqYhvdKhwdsjlK78hMwR2yqEkCIq2mnOi91MBHGvYNp2gD5H9amgxUxHZMPOZbrc4cJnWeZAVkghEsvc2gfxXCTfF8Ehy+qK3SDb1gdAL0qdFKVWDwwFripNbhGIl65TPLV5lovyAC7Qiwr5dKOq8Dirnq5IAalZCO5eBX9giVhRwLfaI7TZlC5kCNOdJRjmXfADRNAbhhkmFmMjXnGJNCf5yHWBco4jck9bQPw/yq3HZzu/C0PR86Y1OekJv3v+bvshkyT13wDM/wOk5cMfc+XS+S+Q1vAV6R/t9ZvKZAHHE=;4:80ebIleIOUjMzbJeEgH+JXErCeu+fA1Xgn54rIa47FuZACqpJTzESslk/b52uCqHvzX4RsgZERAy4u/wWMXD+dKNkglKXjFPN/950i1+OUkdETG5YsG5STXhkRDQIpZDwG2TB/yzKIMov2FADoriE6vmA0pQgD3Qt7i2G2frB6PhNZn62tTiF0Qo8ElqSycykIgtosF+RAIiPfCBTS6/mQ+SNeBSVAvIpb0tjrSpO3f8fOQKrPT3zpkatCEN7wuiGjVXM1ZrYjovia/Dt+qoTw==
X-Microsoft-Antispam-PRVS: <BYAPR04MB4357758154CFFEC35BAD3AC6E5490@BYAPR04MB4357.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR04MB4357;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4357;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39840400004)(396003)(136003)(376002)(346002)(54534003)(199004)(189003)(2906002)(86362001)(1076002)(6512007)(4326008)(53936002)(25786009)(6666003)(186003)(107886003)(81166006)(68736007)(8936002)(76176011)(51416003)(6486002)(110136005)(52116002)(316002)(50226002)(7736002)(81156014)(305945005)(16586007)(8676002)(3846002)(48376002)(5660300001)(478600001)(106356001)(105586002)(26005)(50466002)(476003)(386003)(446003)(16526019)(956004)(2616005)(97736004)(36756003)(486006)(6116002)(11346002)(66066001)(47776003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4357;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR04MB4357;23:zPfhLTCIXxH32qLkHUH9wAxzetAOVIy4xLvgw1oLx?=
 =?us-ascii?Q?Rviogb0NL0Ruc/5ZMbxE5LnASGcN0QQexvArLN4jCqJOotvfgpD/c+w2q6BB?=
 =?us-ascii?Q?L+zRvhJWdHQ78zoRMSh5zxwXx6nogl8S5taW2E8+y+ihpNyxe0dAlUZL1TX8?=
 =?us-ascii?Q?D/U7VEuGGnhy6/Ikg9JQtH8LFY8NGaA0Ay7VpY8W099tda8MaasqsC5ZFdx1?=
 =?us-ascii?Q?bti5sfGbJHQoXc39xSxboC8m39qoCCTZl782m+UbdADdmFRScBi9KcTsLK8/?=
 =?us-ascii?Q?hkfq7mCUEgQrTCNfL/E4/66sEQpm7mpY0O3AhIkw45bA0w3zkc53bZBh+KUc?=
 =?us-ascii?Q?Qcl+x6w0N3d4lgenCfAo9cgq7ZLrWsHucZHsCYgvw9Xi2q0anguJTR4NnT0L?=
 =?us-ascii?Q?ux5GUmqpl96uL5TtjU8L7PFZC1z6cSjHqDKTXJkyMRz8fqvk2zpB+u4/wXx8?=
 =?us-ascii?Q?Gl6B9e+uJlSe/7g6NDahpsX0PTfme1mT4efuyHS/i8Dl9jAiuC1+QU657Ov5?=
 =?us-ascii?Q?Z+W2icwBk/mK0dKWLELs1O6HnBa6ne/kHckq0ESjiXeHln/M3sdwWsQbrM2d?=
 =?us-ascii?Q?TgxALCrIi6E0ngA99pWOHcvKaPTS8dWc6HKP5qC/BMUOOW2C7Vaf4W+7eP+y?=
 =?us-ascii?Q?aq8avR6OGThtH7+bveDudBco4sEJSvRq4H3ZR4D1kYf04Y8jN6XUavLf8csW?=
 =?us-ascii?Q?R6Jc+ez6h9fFL699uZQiqSPG7GsRZAUH8o1WophIGHFflW2Vlrf7Uh51VrFl?=
 =?us-ascii?Q?d/DpnXeS4eIR476KlmWoTkm8jE9KKPbpWrjLGfgjtpuP8Ku1rHrJpIlwkJPV?=
 =?us-ascii?Q?uhlthy76Ij7wpyrbBTW/o45a8gUaOhFv9x3VdlaXYNc2wjGqYpDWC+5CQdbA?=
 =?us-ascii?Q?maWYsOx6ZiaLkaIunWIzvuoWaCbxZmwz00eNxJFhFhJmAjlXeaY6aQI/bwNA?=
 =?us-ascii?Q?NbAsRSFIN8ZWoDQj64OKLl0Kf/9S/rWHgveRyMOrTh5TnXCeqBIG2Fo5mzKH?=
 =?us-ascii?Q?5s/dkAl+nLFz50IVjPzQiieNd/hZbGd88Oe2IHG4EexD+RMpen4oNOtzm7dw?=
 =?us-ascii?Q?oN7/NwHP1vh7B3MxiADoKJflGLb04C0uxJMFjZ61j7IkK3DZAq9h/cQOaz7v?=
 =?us-ascii?Q?2Ctc7zWevcdWElFafXrNMwKviB94MrsiOEt8BML4vmnWixuCGXGgk43mc1Xv?=
 =?us-ascii?Q?q2nsSn30m9W68H2kcbMllFvBlGxR8Kj6asS7hHRl5UlHcjdA65IR6YSLlOiB?=
 =?us-ascii?Q?ZFmZ5ov4mbO/wmNkbg=3D?=
X-Microsoft-Antispam-Message-Info: eYDhQ2BrHzxz1FC/zwI77/D9MZR7bcPjKUBeWeINUztuCSx0CcAp65gbPl//O1gKfzLtoQdOhRN1elQ2ibcDRI4Vk9UuBPbZZQrhb+ADXF0cV7Bome8rZOMfOD7sMvGFNrlYns40s0EF60goL+DTHx0LPnKN+XndFJ8ceIFrIgUGB8fuX9aLmVSGsO5hLhrSI741H5eY2WxrBXjRjJc1j+mrGkF+tLTMrT33ICQ2I9TKkS6/6czFTwLmbSF8ZbVxG9PvXljV6qxmNXwnK2wT3iSsFJ3XJTDQgGXWqHICBLkAijJF0sPpJ1CQdaQRAW2k+seMzWX7hTyQ7nnuu26h5w5iqEiaSHO8Ck91H/xqfS0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;6:y2MC3VFQqX8scUS+cZG70R45ODIVtv8JU/3Lgt2I/W4TIRZhiCjq/2arKwHY6eGv9HidizMrb502Fn917AxzNnk+ot45SEQTijRtD4yvLprQH6ZNrdmfHtyvt9FLfRPCROlV12sy/RacSbE2VIypjY71nKA2dtdLHek3FdZa1ffutKLtj+fEv3PDZ6ub12EomImATsWA5YRVuj8pkc5ZOJmdXOCWQyhO/SlouKOAHN+hGdC4zNVegY8WrXolYn3w1m0CweHw9VDXDel/lBMmRPXuIp2rlhn1MEy6n8E5noEDvmv5drTiABVC3RUul6tqTcqqL38i4Aa3HKGP/GAl0D/Bvo5do6IEIbrwF1IIsd7or2G0PoLk4+9WAxJzVb3vt5WcTsvVT5nAKb5hHng3+mqU64417W097nBF4Q+fuWbLIuO2d78MGeIZM6QufSRIWcQSV/zjb4Ez0UnfqiIJ5Q==;5:e9A5fo3JAd0xpVozCUGIAzuXbQf6zrDT5DqxVExRX9/l1DLeUZ+TTlk63SnAidNuSMpWkeN3hpiim07wwOggq8Ij1CxaYtNtLWV3QXLk7wKHTEAQWIaLq8jeMwye/n8KyT9xT9Ij9tm0SyET5s3kJINSQ9C+f0GN2VAui/qM6uo=;24:sc6N8JVC+vrkdFLC3uFTzJ61OdzvIJ1xEXQ1nObrCazFKyeaid2gOCP5NTEk6gDzjSGmGHP9AedVkpuNR2LXcUrQxMnxrt6afbQ+9PNvs7I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR04MB4357;7:SvZW2skt+34May9EyNvEfVxOLuDdg9mVNixmnNzDprKxeTA1hDA0s0vY8kKaWRHtWftmLKRmaWmiJ/6pjcm0hBlPKImr4FEWppGcY6pffm3RisMlnKb84pp1fESf6Itrdiuz0bv8EupFVDx3lxIcchcC3EJK0OQyShtFX4UORMWjaETX8YDRFs7EGc1PiShbd0oMeqN/Gno47ReaVXKAWX1THKNVAg4DGaj7xkl336rWWUtlRgaMaP+cqh4tVPUd
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 15:47:10.6990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5516c17-157c-4d80-b6f9-08d5db7c1644
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V6:
	1. Move change log to correct place.
	2. Reduce unneeded pr_info prints.
	3. In function sdhci_pci_o2_probe_slot, remove using local
	variable 'mmc' instead of using 'host->mmc'.
	3. Make the msi enable code a sperate function.

Changes in V5:
	1. Because pci_enable_msi is marked as deprecated and should not be
	used in new code, use pci_alloc_irq_vectors instead.
	2. Remove unneeded CONFIG_PCI_MSI macro check.

Changes in V4:
	Enable MSI interrupt if the MSI capability bit is set in
	capability register.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 7747e8b..56bc717 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -260,6 +260,29 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
 	pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL4, scratch_32);
 }
 
+static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
+				    struct sdhci_host *host)
+{
+	int ret;
+
+	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
+	if (!ret) {
+		pr_info("%s: unsupport msi, use INTx irq\n",
+			mmc_hostname(host->mmc));
+		return;
+	}
+
+	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		pr_err("%s: enable PCI MSI failed, err=%d\n",
+		       mmc_hostname(host->mmc), ret);
+		return;
+	}
+
+	host->irq = pci_irq_vector(chip->pdev, 0);
+}
+
 int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -279,6 +302,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		sdhci_pci_o2_enable_msi(chip, host);
+
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
-- 
2.7.4

