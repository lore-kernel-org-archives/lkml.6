Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367EC208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="wXcU59L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367EC208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeH0Wf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:35:59 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:19149
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbeH0Wf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88001YEz9NMUTgkfWn5bBm0W+CgE2oX6tEQrgsi9azM=;
 b=wXcU59L2MZYOQROO2aOfZYR/RB1SModOxMnLN73mzWRZcQe4nq0THTi1tGNWLwmy7TNpNY4UfjGGdfxdh6FRI6mKZ4yQXvnZWWWobq6HfS65LPVEic8TxAVQOpaigOdz8Q0Mfm3kUSc7hJiuCbcIcV5ZSLBeqqkAz4lPyP6BXaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
Received: from portal.office.com (4.28.13.142) by
 CY4PR01MB2326.prod.exchangelabs.com (2603:10b6:903:23::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Mon, 27 Aug 2018 18:48:05 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     hdegoede@redhat.com, tj@kernel.org, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Suman Tripathi <stripathi@amperecomputing.com>,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
Subject: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Date:   Mon, 27 Aug 2018 11:47:53 -0700
Message-Id: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: MWHPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:300:ee::17) To CY4PR01MB2326.prod.exchangelabs.com
 (2603:10b6:903:23::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72952b16-09bc-4f84-4e11-08d60c4da076
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR01MB2326;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB2326;3:MsRZYrGuPleY1l3Wsqf96FswE6jwdAJNSsPsRQ/bUySsniqdrEzEH8NtnxFZqfwyo86Bw8V5XuA0tLt6UwB1vcIPnbMw+9p+4lCh/FYuoXgQTAYIgVJzwHIcMkk+3IvuHSwMn9mu61fCm7M/5SiDD2vi0vxKZkmR3/l/5HYz0kUrjpKasA0LGixgnCebGGsoRX6Qfb6Rnl9kJft0bbb5xNoONv+DJqL+R/4RitXp2oahFo1WWzh8Og9lAInsdrki;25:JVb9aBwjZLsFIf7mSX6cj9O/C2LEhzKQ57caqHOMQoUKggytDjJDhLJXsnG4xJnC+tHxfdHYxeddDo6/LPnJhdWJeOzUmkSbMGExb184Wa53ItLDoy66l8lzvqcVWkxvCM6c/XtHMxbdozI0jKNR0CuiiLGiYWGdBLq/PugcBxlQ6d+UAmBGNOEN6QFfiGxZueAUJb8/sJ7PrUrDZHBMY9mfcemn+TDvjsLiTUwl4+sv1HB99vYkdKe53pws3M4YSew5qdHxje8qrI7RWRY/BThwThB5LnHUqfnzC/FHbrY8xkhOUB5UDUJTl1tBuC1Oe8nvx2EK7gJ+imaNwhtKoQ==;31:V7WCoHZsK5H8S/ERQgcRi3N2OFqB41LY6YjohlsWGrPxXqf6eiOSauWpV5zAaUkdGjminKSMk3MGEtdexJ2BdtG7vcOTxFMqSHiqzRtQp1kVxHwdAP3WZ/52PeuzYZcWbsx1basywrWwnSz3KEiZ4R2QQnWEZzjbwZRIDtepRExYPPVersrMkebNdgEpYtafvcQ9HE7tDa99zZ0svFiLYPFmC64ZYYCH1HnsIDmstjM=
X-MS-TrafficTypeDiagnostic: CY4PR01MB2326:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB2326;20:irHxg+/rYGI+ez2tS+h1YpWn9cgYrqVGxZPPt1/yNFNbvSOIDZRnya/YDKIuRMOYU03v8SDQynErBdMLMH9Y9gNhyUOJeuESxKKZd/DYbv+xo07Miy+fOj98HiLkDHp5I6EXsc/owkyiagV/CXdAY/OVROSKRWsQfmvFDgtOMzU=;4:QTG8RQW9PeFXKpX1cW6Y5Vfdv6wZAWyKXuWZO75b4znTWSAYKrLAapY7+k4O9uF4p+Xcmgiq33MiGS/Qj7zqxAllOQEausKIWmyV/XYRzVQD9Ddj9y/mgDwB9rXYB+0PF8UplEzLy/XSNow8K50J1Fy9tPUC50TRo+neGo+3W5hfBTWYYNrt7Rcr+GjzsZfY9kRCJF7MJokyG06Os+dp9Gjbd9wZf6015tWfKHdtJX6FHGhtRUY3ORlLyRMjGM9L4WYFHLfJlINvfK47FvUtvg==
X-Microsoft-Antispam-PRVS: <CY4PR01MB2326F8526C75C3E30FDBBD84B30B0@CY4PR01MB2326.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY4PR01MB2326;BCL:0;PCL:0;RULEID:;SRVR:CY4PR01MB2326;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39840400004)(396003)(189003)(199004)(486006)(6506007)(386003)(476003)(81166006)(68736007)(7736002)(8936002)(305945005)(6512007)(6116002)(3846002)(2616005)(956004)(186003)(37156001)(50226002)(36756003)(8676002)(54906003)(53936002)(478600001)(97736004)(16526019)(51416003)(81156014)(5660300001)(106356001)(217873002)(107886003)(26005)(316002)(105586002)(52116002)(14444005)(66066001)(48376002)(47776003)(2906002)(1857600001)(4326008)(25786009)(69596002)(53416004)(6666003)(6486002)(86362001)(50466002)(575784001)(16586007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR01MB2326;H:portal.office.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR01MB2326;23:og+8K1l+RrUnQ0EKFEqOZq1fAVNhEwnfi21wU6qnF?=
 =?us-ascii?Q?yzD307UyDX2sDIJ2vF+CJzxR44w1x0V3U1LYAAvsIwi3Yo5+UGc5b7yE95+L?=
 =?us-ascii?Q?9HsRwtO+e6In4DzIPr+rKa7iMZd6mKOeJHhlbvFbedtX10l0os53YRLvHd/L?=
 =?us-ascii?Q?696r+vrDigJIIuDcEnbhMpO0QUP0M/Ovewq6yy1v31NgXA7hkdbIprm2Isjg?=
 =?us-ascii?Q?fU9YnoOV9n0s/JDuFTtRny5mKEoszc/k3j53lbdkMO6x4U10JoybcTRqjyMY?=
 =?us-ascii?Q?5LvoVBwPXyQDnygwRWRRCdCXCn3eoyXpfz1OGdfQgJA2vZ7KuBB0nMO/mSxP?=
 =?us-ascii?Q?10Pmk31d6Qanld4JZvC4u5vzrEgRRROZDePMXGr6rRaCRxF2rkOy3m3fSjJb?=
 =?us-ascii?Q?/V50t1/ACpg8Augvq5rEu6MnJkm/Rw85Lh1JyhbzjchYnyyTYEaxTSCfDK+Q?=
 =?us-ascii?Q?vYu2yeYdMNBo7i6UcWJn8AePeaAcuKMBpVyukT1xbGJyqHmSXlFZ6PPoEi+B?=
 =?us-ascii?Q?yKOzxowf1LrqgeBTZn9QT+xzUrKHO6KJWosF8pmWJqmr0/PGPkhmZGT4pd/T?=
 =?us-ascii?Q?NJedX9F41mFx2C5IjCWykjx3FT86toRHDTktLhuRyYcdJ8a3oOnP6qZSApun?=
 =?us-ascii?Q?H2Yot+DmfaTu7UxA98eHWapgc9XEeOkaiJg7qGJ21cma5vxhesA1byd+PgXv?=
 =?us-ascii?Q?BT/4f3FcARgwOXQehit9SwB/9RUQhwliG6oNDOzM/Cg6MQJGbEEOiSiVfeQb?=
 =?us-ascii?Q?ONCX0LBfBOPQ/hCOV8q0oCEF7S/Xu6DiH+PSBSjRUBlJz0Glka18E6polFNF?=
 =?us-ascii?Q?1oxDq7e9raRNMCA9+ffB7rYPIey483pkVHdw/ERr+MbKPyMDgkU843U7gqNE?=
 =?us-ascii?Q?adv0WklIWRHC9RUXRTiETJhPKxAFkw0PHfIuVIpvu+8O3G5dWv5pTBJ4toLP?=
 =?us-ascii?Q?OcEmbJmyj+LNKQ2ddLAdtnFfZIJuocR33KSHXqw7L5CM/LLVtFUT+yuvYRhr?=
 =?us-ascii?Q?koxQqDENjRFdgonfyVQvrvYVlokNclnjC6SPbcoG0rSPrfnNq+2uKD+foTPd?=
 =?us-ascii?Q?4A51hyBtOh7gNMAQ3hkCfP4IxhdR1NIRkPTMmFjmBcRMDWtV3eaKr8X0Tf7w?=
 =?us-ascii?Q?79Y1Ho8ycTdFVRExqhDVxCC0sGYNCtaUHm/1osnU4bqZeRFsLJqQY+8D6ErY?=
 =?us-ascii?Q?JFV1uwfWvT8tcx+Bt1+ZAsWxOo80RzgGRbx4CWAQ/n7bKSmEwlL6kc4g5Iyw?=
 =?us-ascii?Q?xOQdp6A7UIVvt/z3fomt9KpgXdVHvSjogXJPBLRjGzBO14xnU4NmAf793JmF?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: kqFfkchjgY9+20DfAugTuvbmPk/JOZUEDZ8y2sEhZaPwmYgDeR2NSt3XIn52NbTFMhdF7o+Ckr20n7LzIH42uu47sIhZI3rOAroQ8ktnxwXjTp4qSrzfTTlqjhz3sqYeLkHJFfRfHZj27LOGsTT6e3HGYaNpQ8G6B6hEYrNaYIRAvHiALTdF4RMrJMeg0dVg32BlMFizHjVaTbpX0DWeothEXfalbPGpmn2Mr9unP8tCOTO7HAt/yvgJrUWKLXyxunuV4xOyhNUr3d4NicD5oeM5FnxP4cwpp3XghGtNKPXFq8UJ3WwE0vv1p8R6Clb+ntfndirHmtHVJ/HX60OtEAyJlYIduwactkv3YY4is9Q=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB2326;6:0ogWgYO21RQCvBI0MahwIOMOC+4vUmGGqAQHy5G4DmnpE9uS3raDRpTbiKuMptuYu59H53/G6slMTVa8gSZbyAYoOTHHO2T5n9BANP3d8KhxU4tCDLOl/raxtJyLwoBr2TUbhcEulHc6k6hIEE8ppqHwwBZFRtspuTOJhj0Q0p2gidpfxArTf1zD8tWVPbP9Y5QTg9H7MVLtIdBLIIwQ+VocGcLcZ1DoQ7Pn0JcXTNaRYZh48Iguc4x16avVfmpx4VcBSz3YEqsnFB8IHJdmVWt/1wxl/DrrK3NVUmgQhSvFrDacfUnoI145+GDPMxyDsze15K/+AUrJboOJe0+90cQg+kxukY/kz6Sfx8Ya6exEVWfZv1RaZ/BsZcr5QLWGVbSF2XAXJFHAR4p+dWVb3b+WWTry3ca3eXaVvDlIjLjtji+0FpdCUUcbcRgA1VeXI2sYAEFh7GU6UAjYC1HjOw==;5:clDziGF9SeGJmhHKyV1A5PAFS63ywK2aWfWLZUYQqd6nFIVR++MECX4HKrTmCZjlzKbo/Hn2yO8wLF6mvNh7VsOcqVkMCNuH3Sd4rLoVp+VeijlfvhJbNwuYeKr42a/lw6k6e/cXO/NqFPiRdPCdDaMOe0H7gNjd39m6Oj/ZK8c=;7:9dZJHY1rra63xmXOZ1S5OEd5H0BtkSMluYT/UeyMWKtnTbfuvFSVBfr0/YayMXTJUR+xgKZmgKjzM5XeEMIIRDoeFDLNNpZa/W9WQIfmfWgXCU7pQkdSZLIatcWnvbnpjYWNIZLfbPsRwUB8FBXsCXrcEMhOb3Qk/Mbo+tmgNjI4V6dKxAhGwkc770v3nz4L1Jfovczlc3TuVD3SM+u4DPkMt2CtBx3IytpDYOo8jGkfZ6CCga+8GV6VH3AMqGjU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 18:48:05.7689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72952b16-09bc-4f84-4e11-08d60c4da076
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
 drivers/ata/ahci_platform.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..0d0233e 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -26,7 +26,7 @@

 #define DRV_NAME "ahci"

-static const struct ata_port_info ahci_port_info = {
+static struct ata_port_info ahci_port_info = {
 	.flags		= AHCI_FLAG_COMMON,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
@@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	struct acpi_device_info *info;
+	acpi_status status;
 	int rc;

 	hpriv = ahci_platform_get_resources(pdev);
@@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

+	status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
+	if (ACPI_SUCCESS(status)) {
+		if (info->valid & ACPI_VALID_HID) {
+			if (!strcmp("APMC0D33", info->hardware_id.string))
+				ahci_port_info.flags |= ATA_FLAG_NO_LPM;
+		}
+		ACPI_FREE(info);
+	}
+
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
 				     &ahci_platform_sht);
 	if (rc)
--
1.8.3.1

