Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47EEECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCA02086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="mmmwv4Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCA02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeGPGxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:53:37 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:49633
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727647AbeGPGxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EmeGFXcUZzWJVOspMA/0dXHpy4uA8TMoAw0tQmXB6U=;
 b=mmmwv4EgZYk3SUv2OYgt9zA4c91ZTpPZ8dcuuit8WN3R9kpWz0GtvXS6igF1JiRIT15HEqLX0N57jV7a/iBnteHoQ0GJIjixWinEYaxWrAwcGShtMHxDtmx5Kelpr3zlYDxfb4a3USXT7T8r/RdHmPDN7LAEZ0ksNxHRatqxyJc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (171.82.0.134) by
 SN6PR04MB4766.namprd04.prod.outlook.com (2603:10b6:805:b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 06:27:41 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V7 1/5] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date:   Mon, 16 Jul 2018 14:26:51 +0800
Message-Id: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.82.0.134]
X-ClientProxiedBy: SG2PR06CA0180.apcprd06.prod.outlook.com
 (2603:1096:1:1e::34) To SN6PR04MB4766.namprd04.prod.outlook.com
 (2603:10b6:805:b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1f1fd3-7433-40c8-9623-08d5eae53ed2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;3:23G7QcDj2QTMBW9H0r5APhLx8W6Q4xcu+95gwPM6MtfEjNdEQ0hJgcYkKgpN3qAdce2N8lwTsfxK3Z3YQGWy9fqQRYbe/gcsGMCjXw6CbAy0ps8H6hi0M5JwGdqT3JhxsNi6TnrU9xKVDC84C+YPOOl+wn6KrG8qQ5sK9z8MGgcUz3/jIWsbpM9Babji2qT3a8+VWtOF3GUt/OIsmVWtVLkJqpPkPbO980FZh7CSOHykyhrTQIDQtM+pCC7pfC6b;25:8qo1neAhT8IvuUb+S6+B0WR3WYn8lRCaiW0RicMVkLn69IH97BvKc9qCOWo8UZdwwF0/wo8k4XPjCfiXliGl97BwUdg/LsXeH9tz2bDUpkrdhMr2xxOZQ6i7VjdqS9Mw92/VqpGQm6Jx07qaEq5Mp9Fr5KonCUNXan1lBYRN10Eb83leJu6hYpG29wRtccqtvIiD0GGcyebW8k3fdmOQDp9YFU99brSepbF+fEBq+EAb9mgZfv7Id7eTC60kWIiL3RxcHy5NdmShcXrB7Mp2gZVXwN0gIcY7vaLrfy1f12ZYmN2HkEGH9etndXSrRnYpuObRYeP184nfrRizGEODkw==;31:fbS1RbLGQuQShc+8Yp9bQXiu9tmTyb7V2GJfd4ZPTJLyN9fmDSCd6rXVTwYBzsean9+XIbYuAYHA19091p05x8Ks0X7jFr9LRIN3yMdX2u/vYKh9MuHM5Zu6I1C/Lp4HGtviOeSEalVrSROtIyrMmD1KOTmuus+/mXvQLayqIng4Z62yMsKJkqyJV/ZEQ4rXz4gib8FlDhnwq3me7LjVn9FVF+wkE99593oDFTkaOv4=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4766:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;20:kTAtriY0tUT/vnFDV03lWR7Fi/E40V1eG9qisGNxzlQzHc9Fovdv1oykXyPtV8i860LB/T4cWJfDEjN6kbaGKSncWzlHzBBzrnYDTcyszSVwAm3REnLCtoOEJraXe8XN5CPIW2NYOBKV+v6E4hDi/1qda4BpkTVjLGoP0RKTlsaoH+kaJqadwMbu1/lx1N60HgzZ3Qst/sZyRImpryRPvDbFqpggTN5uYNAR5rx70PAiYoUFXm6C1VULTUVCookH7HsMoHdi/1/Vdgf7ybT2BG4shvcypfBqDW+NXSUQJJXVWFKWgomqjSeRNElLrOV+vLmAfTH56qhyD6APZZWmR8N0qY5Ir6YLzLz0CIk24PfALN80srbPBvLIVlj6LTXeZSJqBVSKMCaorVHRQSxv1x1YgALDOh+M7OXBG6RL2DI=;4:WcNc2LGGtxK4PpX2P1KmGxPyIvg/Bep43CRyqtV3lx0KBLf/ekfhADd/xbbL6QG5H19EEUt0aQ+gIWZgRYUy++fXnPWGXgybVkcAr3Pe+sT4gjyJ9Ee0fyZBKernztkws7JGZND0F4beDCimc9JtStgXhVl2MvZESU+Wway91gIzwg3Ii56Sykk+waGc0AV2LYwkkLp/O9BSPVL1fr8lPPRnUWdG8UKdRiWkd5h/kn4Kk7shre5RD82V711ufoxtVWIhzjxSI/Ijd58t38XW1kfYDtSEQpsLcTBPRoNry4kpqpC7mDSP3u/yyn4F4X9R
X-Microsoft-Antispam-PRVS: <SN6PR04MB4766230B01A740DF089F319BE55D0@SN6PR04MB4766.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4766;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4766;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(396003)(366004)(346002)(39830400003)(376002)(189003)(199004)(54534003)(2906002)(97736004)(6116002)(305945005)(50226002)(47776003)(105586002)(478600001)(106356001)(66066001)(81166006)(3846002)(8676002)(6512007)(81156014)(68736007)(5660300001)(7736002)(53936002)(86362001)(956004)(2616005)(476003)(486006)(386003)(316002)(48376002)(25786009)(6506007)(186003)(26005)(16526019)(107886003)(50466002)(36756003)(52116002)(1076002)(6486002)(51416003)(14444005)(6666003)(8936002)(4326008)(16586007)(110136005)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4766;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR04MB4766;23:FCZBG6A6yzqB7CQfA2l8lKDRr3DBmq38s2WKHQCQk?=
 =?us-ascii?Q?eNoyyq+h1k1UrvXTA9g89lGj/galxmemaAJefYiMYfEiLtf+xgFF9/z7SNlh?=
 =?us-ascii?Q?fWk9Gn0OYmiZttf1GnIpASG8HV7002zibhqDT80AuAQdJvJiM7jy9rNAtMok?=
 =?us-ascii?Q?jjgffapcC1l8zsuMBp33KdEj1jM1VI5zkMy3iT3BnnUJG2tYTFRFE46qCU1C?=
 =?us-ascii?Q?kJDVyib7ythWLbptut/Qbt6uMWGP0iMEWMthRrqiNX+yS7uXCInNCagvF4Tx?=
 =?us-ascii?Q?CVYTDaed6Li5TzxR3/hiq2JD1LaKolgV2bOAsjo94pCzhsnBhx6adFkdCYp+?=
 =?us-ascii?Q?xJh4wxEo0a5mkneWfHDy3cKTPUXe920JMnkmFVtObEmK2HDQcDejUKfRcdB8?=
 =?us-ascii?Q?xZhHwBCt3o49TflumymRD9XATiWVdRf39KngfLjkE6p5K3Mvh3GuiCOCZ1br?=
 =?us-ascii?Q?YQxjQRIBxGZsz/nXLnVurGgcIvefVXvkfmnRNqI/aZN3r8vOJarqx2d2RWW5?=
 =?us-ascii?Q?o9Nh1yklYRd0pQc2Gp74z1FkrZBUi5m1E7+NHSBVKzdWjQ239Nw0B3SVtWTR?=
 =?us-ascii?Q?roF63nD2ypZJDRbPign2GMrkUnWDgEKHg/JidIaemaN7MuLiPMoQJo1PztML?=
 =?us-ascii?Q?ENn/YOcbmP/Bg3O0xPjB4dB08Jqbv9PSbC1KrKJDTBqepCGsmL3XVkKVp+Ej?=
 =?us-ascii?Q?HJM/T4BLrjevoCQylvBQo2Sev4ZuL5u+kutG/A2Tz3iffQUr+EttJkGZSb67?=
 =?us-ascii?Q?KPcalI5vHaFKbC94IGgpJLkA9lh9b5Ehgk36CKSpLSNN6OP51DqkJXhHLEv8?=
 =?us-ascii?Q?7dMszbmJmt9qz08ks4MxGydHDkgWjWIyrZPgeOHt2AVsCygzG/UiVz+VnU5x?=
 =?us-ascii?Q?1jjY77VkRtmGr3bpN+ekG8eJuLJjiGCcRUHH5c6S1tKiZdsOMvmn9nroNvGv?=
 =?us-ascii?Q?7QV1wmodQPoYvwkTKrzVobbM5a990OUfOrT/LRxGwVgUj6D0EGsOWn2asr/p?=
 =?us-ascii?Q?Jvp0zug1Cmi11pbjlaYt33Fl20oi0WlqB/opvHWLyDT9J3p/17A9Z0+gug1I?=
 =?us-ascii?Q?z+I6eWSr9UgC0lO033fi1X4zbNPDRrTRqgjLnzGgfT//8I9WL3QzDIP/bhwC?=
 =?us-ascii?Q?jQmwfdSksFEiQKxFuHdjg6nxF5e8pti8RYP/logHOXSO/yuEzWPsTglj6/HK?=
 =?us-ascii?Q?ubzmtig65cNB+DPQFtrp7vMEMyA5JQsr1b9Xr78o8qFiOxIPX2J1EFs7A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: a4uvVTxc0Ytn2Rq5ccdimXNFfhfn8DiHCtf6vz4esbl7vGN0VzHIuyKTld7fdabJdV0O35ehIpfG5QEHliTDYAD3zGGbOaUUyyZUrCNlRp4yq2bsBGBFK716FZrv+/AMmyF69Wb/rhkd7KiZBi452oaRbChMmjMj8nhgHR8JMNudfpVE8e5MbwAnKgtnnIOkzyCPlPdv3lXTpVP4BRjqJrKxGAXi1XBDYmogYray/7OqlGVslSzdpaIp7MZ5ncrPgABn72JOrBk5HnhIi1GEVzaeDa9eUwC8gLtg9ixN2T6va1vsge4d0n2tBUwNe5WiN2IsI0m44qpL71r7V0vUSnSwZiJ0UrykkC7JUieNGZk=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;6:CnshYCvB4ACvdSCmKu+i7k0jJlFnDeMM9Z1+jU9zNDFUPF+D32DK3/OIKorgwMqvVwPHOBzXCcXS8KbO2Fvb8gCRKumvDU5NKBLyyv6JS8U+BEWc7xGJFLx4hwBFyaFcRMcKAePVppY/241DGrrN/B5nZpkiFwA8aHcVOvsi9xjsUWlAZ8ssEAZqN7xQZ8MrMLoel52a5rrTtoBMbaqatapSYn2Pv6SSjWMVBft21SNURBLgOG3Pdjj1wjI+le7955xWODvBc/rejCzZdwEjVAFIT00Urg+FkMFi+l68Oy9XnYK4dZYoF4N3b4k8OpxfMSeI6w00+o/MMOrA7Xi8Q4iwHFCxBKIXgBAzd822WESLmG2A2w7g0qg0V17dfhDYSz8jlUZVjvxov5//xAKh4A1hXE1Ghw7Bo9V+HktW7zY8xux6g+LcfQcOfuo91gsP3FnntQj52pBcLTXvRFA69Q==;5:dt59A/foGnCpNFH3bnBbUYXnwJRiJq/74rvkjbXDZj14wmsOyDMnAKJFvPeVGBVIWvEjJmMGK1/juMrBJCxddyMCd6B3OYvVqZSQKyOaBy7PtxvtjTnwthS229uzz02cknlJ44YqUW3RUvjhm0UxzGITUr12e9TzHgX5IX5fTcs=;24:N5CFjSbd6Rmman4KQAjn5YPfYDHseOQIP9gGpHFOmk9LakVkxe36Zg7IIC47EDarkfkPz55FBjvtq/5SAM47P+Qd72gnP5jyxIYB5217K/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;7:9YbRc8kj1k/kgnSIK2VKOtn/D4Z/CIW8NUGkvF9qSaOt74adFR/3elLdOfxkEKltX+BAErYLmyEZtSs9bwQUjy70hGjbNEfTUFdVFJF43PpZE9UoErKVf5j6K/eiIM6hJikK8UTztHExO4/mGt8+xrNj4lgCNMwbZPilm0uhoLnKPJXnhj0UpQ0RqhqY8SMgSRYNgQg9O3V191SvZ5hCdl4/n/xTzHIzon2uutfCFNTJemiGN/hDcl9HjokaBWff
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 06:27:41.7618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1f1fd3-7433-40c8-9623-08d5eae53ed2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4766
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
Changes in V7:
	Move V6 change item 2 to a seperate patch file

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
 drivers/mmc/host/sdhci-pci-o2micro.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 555970a29c94..ba59db6a126c 100644
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
-- 
2.17.1

