Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7236EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157902086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="WCdy7Knz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157902086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeGPGyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:54:17 -0400
Received: from mail-sn1nam01on0107.outbound.protection.outlook.com ([104.47.32.107]:24096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeGPGyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLG50IjySjigjLE0TsR+w5S9hIrZEdKDNJuCmhwy0O8=;
 b=WCdy7Knz4A1z/zM0IuZBKt8fdJ5wQ0nxjr9TKcPXL0vMV9w+Y1nfH7fZZ+H+xhUgMAc0OIgknUw5PY4zYQ0LLdbLRk264q54IfmhCAmQNpkPM7dXNFM0d4HGyS6rOc0UXA4VLZxD2aawe/wvGgBVPkJ0PW+wy2/X/zV7neGALPQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (171.82.0.134) by
 SN6PR04MB4766.namprd04.prod.outlook.com (2603:10b6:805:b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 06:28:23 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V7 5/5] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date:   Mon, 16 Jul 2018 14:26:55 +0800
Message-Id: <20180716062655.24703-5-ernest.zhang@bayhubtech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ba1f750-9d04-4f6d-1c1c-08d5eae55724
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;3:wZt3V23ARcKPcmY04h8NSG1PXX8JKHd4zZ/m5l/8lbB3wFV45GfAPImQ2nagB3TGp2Taijv/rvoAbSnmfWRjM2m+vneAlhYJMGLpHSUIdT6j3AOY/rdGwqaIpINLvDBZZdM/y6bG74lzARF1DfR0XeA7hArrLctGAiHaCeAA/vmHkgc30DDcs1Zpv64tHHLeG1Wm5lijiPVaMhl+ztuuICYfRo3lFIekbZK1Gvtt7tugPu4MzlFpu09EAqFiIxhO;25:5gmaeJTjWWge/JtTCGmuzB7AAhDqwVTnDoOApU9CwRqmUHPuehq1KF/0JD6p7G+pO/rlsZh3LMUYgDZhU1VJimJ+r9G+0y7SxctQIb2fm6InTsWcSP+Xcs8HY+oAML+f0kGMYm6apynvVMu0tFRjNx+qVNzIyqWggpINrr+ZCvLzR8ivvd3kogw5LFtmhv0F05CutUorjPvZwPRwQ7zsltGYae4JZf3c6aSAcGAOFyt6Z1s2oE8N4+7KZq+kZr+/jWfPyxam7r95FasGCiYemEuq/RfTmzWvK4t2x4KESa5rgiwNqONKB2+W/sbW2LIarl7koTGIVOx28TOjzwX+ag==;31:rQUdnPhZhIcc36g/jTUY1nCAc0mH2GDdURG8KSXGVtp9ebNPzVjfB+dqN4PjjP4TTFGrgVIJyQeyq5lbydlXToIpkmQ4DaQ7/8xj0/vpSpa5o7WKxK/Z1g0MRCtoAmbpbFbmXslbF4wNinnxt2dx1wSsGjYbh0ouy6Vl3cZChwQpWFp5/IxdYC4Rw86gcb85pC27TosYwYhczdRTDTVQQ5utf2hHSiLSrhsXi8rcboI=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4766:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;20:uugarbJuxO1ERkDATtpRCxzmm0yqMYZ66gKoBpLouwi90W5Eu/OP6uuDgrBrMvY/Z8WFME0l2AdslGzXtQYuScXa5bkVzQdSCHqnF0fhz+TbtANqofoUCGxjvlbpeUkPRbVhpKUkXQYa2R7xF1n+BEnddjN6qbPhno8//ob+y7hTMwxe84mezT/ph3QAFuDlTw2XrE76/Kq75XAa51GQZBEKAWjlp5GC+kvkyHXiAegTBq7hI7c2j0bLNfFwrnmtgXPtkj9dcFwDZc898hyWknK0JcCoIRuSM/nIVzPgw7pyBYejgLl4OHnObf7qLx5aIfkoM4jFWTJM4GYeTTe87THoshKsRXSZt7Clm1PtD4ohOLhD5QHs0xom+tMaB6D3p7NaZtnlu98L2lfta/fGL1M8rMS75jS9Qr/+4zhQoHo=;4:0Xyyt+C5QRrQFAWGK68b4Z6ZcL/nZF7CgU2xZlC6q7WxrfrD02o7kPw4RGAvXVq5IsN5/CzdYvxU6sCpwRHvvfX5+T1LHmHhZkH7ShTCTE2n7g405OV4+P211vLxwdFi2J4CEs01tq8eUInMUWikGSHMocNTyxQiMdH/qoTNOUp9LHGyUf/wkxcxUGhY40Jmbxg16M5j2Ot1EgJNiVxvUeAQh+Ky4ImyS9P4E8dFfcdM+OTKekXXzgQJ8wDVifwGADf+fKhYpiUCijtu7plsWA==
X-Microsoft-Antispam-PRVS: <SN6PR04MB476695F7F5308C22095128A4E55D0@SN6PR04MB4766.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4766;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4766;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(396003)(366004)(346002)(39830400003)(376002)(189003)(199004)(54534003)(2906002)(97736004)(6116002)(305945005)(50226002)(47776003)(105586002)(478600001)(106356001)(66066001)(81166006)(3846002)(8676002)(6512007)(81156014)(68736007)(5660300001)(7736002)(53936002)(86362001)(956004)(2616005)(476003)(11346002)(446003)(486006)(76176011)(386003)(316002)(48376002)(25786009)(6506007)(186003)(26005)(16526019)(107886003)(50466002)(36756003)(52116002)(1076002)(6486002)(51416003)(6666003)(8936002)(4326008)(16586007)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4766;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR04MB4766;23:CNEqJfVv25qGHliDbFjy2pDdZgai1eiVTqcXLqlG6?=
 =?us-ascii?Q?7mUu/IqFB9cFSqwNRviAOHDet37Z3/C+LWb568wvq13C1k6LkX0AhWx3M9w+?=
 =?us-ascii?Q?yF210SmSFIZH6AeCr/ci6nQRr6w/PzOIFNu8sYBxtZFA2J9fZ2DnJ/nxk+v/?=
 =?us-ascii?Q?x1t590B3DkAZ+3AAxyu9ZU0JVpKdQmZGPtBHntSd8rdMAqKTeJxAkzClWywa?=
 =?us-ascii?Q?Kk9pDrC83e4fYOvsEwB+on6vqLV2vfweezjtGyQ/yDHqTvd7iI85u8X+bYWo?=
 =?us-ascii?Q?fz0w3KMmbK1VRF6zatR84I/W1IHIHdnDBGV0e7L9CW0qV4DfSbe6rh9YPd7m?=
 =?us-ascii?Q?e4DFa1C5Mxu63J2Dw3ffczk4TUtf3bAyYBUklQlBYA6QowvciWcgfI1nXDWp?=
 =?us-ascii?Q?qZdbJKHnt6JseVF/nwnC/2m5N3HUrbTqA+GRIZ8U6tJNJJsj8l3mvsnTtlm8?=
 =?us-ascii?Q?MnqM5J1uBh4UIJ3mngZS9LdkYX50vFa5MLNx1bsYSTm14JBkAsuEls+xnXb+?=
 =?us-ascii?Q?6AtEOiUFP2MvaXjeaf16h58GW9CiweTIeosl75zL2sS38e/rd2lgBXKDsEEU?=
 =?us-ascii?Q?TpsPaZsjBKAXrTrwvMXOHv7c84ha+y+dxufXAosG2e/z6pSv8sRD7SnxogAc?=
 =?us-ascii?Q?QXEvHseBVMf/f8lTnoDkGGb5qBqtdtfItvE5pVOR46jp8jE6Pt04g0OQo0Z5?=
 =?us-ascii?Q?ZZIMiSW8g/4vqo5+sKCT6Etk0RrYNecYmqHH6XJ76TEdGEOLbClB2BF0GyCG?=
 =?us-ascii?Q?7KlU9MMmXm001jdbbEgJ6iOo6akPLJV65TIshfIeHEHWTdrzcr+iuNbYaYtY?=
 =?us-ascii?Q?fr0k9oJSeSW399Oi83WUxRuTe7i0O3joqTYVTssYfyPsh1PmpiLGDvDzG1Y9?=
 =?us-ascii?Q?OTVSdPETUdmt5oDsyIjN1EOJCTIpMtbFRMhKYuU4nkwlyryKHPGXhsZuVK6v?=
 =?us-ascii?Q?lUCDXQM5R2+8nTs7zFjnM2aFQJMOmvmdQTAeUHEK4kJrDeYQQZ0XI9LWlx1m?=
 =?us-ascii?Q?aX3nhi2OWsMuYuT+ptkS/yuP8yPl7kHO26ism9/5M5gv03TjDkqVvE7p1L89?=
 =?us-ascii?Q?GUfRcOPSxR1ToCA+NLlFgG6gaGLe7JyYEkkEGJFlb488H7pC0kZchfiFwpBn?=
 =?us-ascii?Q?7Nq0Xv/LPXOWWOBeDteOiN1FkpzPIPeP6XYq6doVZ5VgWRzdGdjGiwLPVlSk?=
 =?us-ascii?Q?B2tMQTlwMK4sQnhLhbXaXZM9sqraQxPHvxtKGu9PU8i14ojVQEyzb4u63TIy?=
 =?us-ascii?Q?WPmWnbwckCdziJ38Ew=3D?=
X-Microsoft-Antispam-Message-Info: MfIS1k4EqRsXkLZaBhIBWXPkc5OazXJ64o+RN7u8mIUh+UOeVwe3EGCRhkbfI8pY2fMdjVM5B8f6d0GDIlrT1IUNYCj7w1VPy6zm7GSVprW0dUAOmwMe3/A+f1IyFtDaVtnF/sd/OnQRz0w5xBq3QE9//t/Vk+Lm9jatbQHKPPlJQCqnjCPMv22xOn1Nrrp560Mf2hssmHBS8XO7FM/5baQ+bBkqKQSXVDFwAbZ8tLGA8XwsglzMqkJwuGqLvj/9bIJgs7t44LFTGYz5K2Mm2FnGTfPMwsHB0qecr6FlOvK2VGmWQuWiLsdaMU7fgv8pZPeplIGREZREEQhQqSvVBFkVTM3W6IOMAo7zav7MjsE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;6:osveo/d5j2OLyaeMz5Qy4r8aeauGKkBTschE62HjPivVO/2fx6iCfX+qUEuQuZO289C9wH/Cd0I6HdVG5RVgTmCnzxbHPRqdUh0DCKxYF6DwMhmEVn5AjVD2lF6/lsNFbYX1hyx/+0wUeG4LsXSD52OhINe2gi0s4IyGjmxIG8IZ8XmD6WJ0Y1SoVUfLoEgCJShmWnp8ilMRl6rskij+azZT5GZneCpjiaZ3O0jWO2T0l6Xnj6D+YMpGJ8Y1MtpSMkdR92WMO23z9VM0vUpZ2t0pDUVdduO5Te8G/V4vlh2mbj0tLcBBe9N/LHECIgGvI3ehHGEtp7mHHsxbsXxnpecxHLaTuV33DSWcwNlCPKYfIP23r60b8s9hEftIjA9JJlNRdLo608m9BZmo6BlloJItHZfGb9XwQiX/TqC47mC04oMBSTgWhxgF7Mth7vxOsGN9gzLIbmjhhMD788dzfg==;5:VPq+fC2UjBhEl8oM9an26toCB7BM/UAI4YUdQojRBigV2QDM5UTlqLl7mYu5bgPtuUIPw2vhY214cU1U4WYgdxR6+gFVjJwgBuTgYpX3xWccUvEyRB0P2+pAUMwD/YSZhejGW3g+klCX1HTwfh4hoJjBlVjTlln9iXecA/OQwGY=;24:Ldgc60xt3K3wIjCcEJbe3xlomC05j8k/xtwckVLXOes/qs6U7vyqLRrWZwXpUAGlGEmxLnvjD8M11UvfsASMmtEKPbAlD4TfxWEMkuV/u2g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;7:0VLIAfRGAX5LPB6ARxNCJiFR8CHKV+Sdz2C7R1aJcH0dhOTDyidzhAoHbYXXV/TciiUfoGPrhAGRrhZIgCy8NdQAzxVM4noBW6fJddhNq2IAedVRuqNuOdszLAVAMHgbwaQRQNItnq9yx0JcvXk/L+tOsoCZOCVmLVG9Duaz2rjPyJ15UQvWXkTAug+dKzeBzy0yXK6jL/haTa+jzXtWheGPhU1XIYWI/C9r+ftDrH9hSinLQI/7Nfddnp7VQxQ4
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 06:28:23.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba1f750-9d04-4f6d-1c1c-08d5eae55724
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V7:
	N/A

Changes in V6:
	1. Move change log to correct place.
	2. Reduce unneeded pr_info prints.
	3. In function sdhci_pci_o2_probe_slot, remove using local
	variable 'mmc' instead of using 'host->mmc'.
	4. Make the msi enable code a sperate function.

Changes in V5:
	1. Because pci_enable_msi is marked as deprecated and should not be
	used in new code, use pci_alloc_irq_vectors instead.
	2. Remove unneeded CONFIG_PCI_MSI macro check.

Changes in V4:
	Enable MSI interrupt if the MSI capability bit is set in
	capability register.

Changes in V1~V3:
	N/A
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 7747e8ba2e3d..56bc71763956 100644
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
2.17.1

