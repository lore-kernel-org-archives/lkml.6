Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E947AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807BB20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="PgTVYA2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807BB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeIFWmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:42:09 -0400
Received: from mail-eopbgr680093.outbound.protection.outlook.com ([40.107.68.93]:7951
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbeIFWmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZloFLKEQBRMTpou18EKWZoR0UY/Ma6Udpy+X1tgiZk=;
 b=PgTVYA2m7o0Pk0doBvY5JcRbJRYUZGbIyKfpNpgJzeR5Ns7hfsdGf4++0U6xWFFOTGMpRWAHoKU9bQ9qhWWASz4bbTujVT/WbzSIQZspyDtCXwWaIkLlrIoUjLSPLfKHGQZZidIO2Wv17OkP32EitzBBlqwa0NBtuwJsljYjMJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
Received: from portal.office.com (4.28.13.142) by
 MWHPR01MB2335.prod.exchangelabs.com (2603:10b6:300:2a::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 18:05:24 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     hdegoede@redhat.com, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Suman Tripathi <stripathi@amperecomputing.com>,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
Subject: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Date:   Thu,  6 Sep 2018 11:05:11 -0700
Message-Id: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: MWHPR12CA0039.namprd12.prod.outlook.com
 (2603:10b6:301:2::25) To MWHPR01MB2335.prod.exchangelabs.com
 (2603:10b6:300:2a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 806c95b8-b0c2-4006-1fce-08d6142351e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2335;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2335;3:UeuJpUQ6nNnu+keMb5aSYiUe4Kk4dJu1xhnnMUmtTwKq3M0NgHq0IC0Rxg+3QyycgRPI+4ZMowoH8eUJyOmexyWLc7VZ4miZqYy8BTg8xbGXvIAmrtFmpM4JC7BF9WCui1oLHD+qO8ZmXzIfnvmV5k2IlW4QmBdt7JjQzgDTR+BwgBWKGuT/I6V76bogrGiGCP9t/7ix63fbdPc6uHZgmxPxPToqpEU8q7TaFRvGR8WvVdwUe4sYwRIsoUHUKaju;25:vBOajUrx+7rOnJJMfK4uK9U8XmJFdzuzzPk6nvviHDUtCydfLe7QuNAcAs5fU8a2mpJmL5eZr1CBk/ghAdc1hfQeUhacCD0AhWHkNEUvuvzfqqgKAVGsOtDejYsZgn01hajPiC6xvvYld/T9cTt4w9Z33Y8na/1DhwvRHdJhQGuqjNibwEMLExOSTAn6ghHiheeam5M0tgn9iXfVrqC93IexFAEADjydGHGmIba5csGpecVKx75yo2of93jIJUyVG8CR9c4Xzn3SjZk41SzavnPxqYw0eBnFkFZj+EqZGCYttuwK0lt/SLC1EODIWUKhsjUfggZ/8gJnFX/NgjXavw==;31:OBj+6SBn8WQX0MyTHLdjNXkhdlcJ6luw/pupMAAtkn0u6CmrTGM29/niEpo9lADvdHLXHhujhj/lwyl80kze0zykYeHs5UjIhY8OJdw04ev6maxcC7G/Dk38ChXeLEhbyvkNxiIlyRcpZiZK1MNOypMH+NbLWbQo4BqUi6pgPMoi8u4GD9yiBIpTkkR4ae9q6Zh8nj569/MoR0jlq6IodI4vAgiI5KiEsYUgh6cdLTI=
X-MS-TrafficTypeDiagnostic: MWHPR01MB2335:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2335;20:a/j2Khs7jsJgyPgCmxPhOyE1vILzM9YsHWzxKEhNiKco2Ft9k1qWHcpQC9GdwDxcSWsfh5j1pE22wCOWcjOrR2gKbD7sjBVunoO8C78lCz/21VBxZ/sC/SEgF3nnDDkLn0vxLL7TbF0SKrSEJx7JlEAFxACbVd4dXpr+z8SPkZ4=;4:5jXe/if5hNXj76cIztrBotisfxlBIs91nuouJS9sMRBrfXYVfy2Vtnfe6YxwoI+IkJxafnZFyAMiSWM0UNXgJkT0JRxaLRsd26tan7yw2zZBDCxkP0DzU4NO2yS3GX2K3K+DBFnfYMS0uTl1oxcgY00bLa0OHOYVKOnjVHs9P/64FvROtT8y3n6Nj+H2nAB0e2+oeMPbzZPEcRbhjB+fCXpP2xQ45ZrkDPOge22t/C3ZXPfrDnTVvAU5VkCxub/UHOE/Xg01zPV5U+m27MdA7wIftJJNc8H2xC++McJxg6nEDUizCgiCf9RpXZ4englw
X-Microsoft-Antispam-PRVS: <MWHPR01MB2335E8F8999B3B750052D63DB3010@MWHPR01MB2335.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR01MB2335;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2335;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(366004)(396003)(136003)(376002)(199004)(189003)(386003)(6506007)(66066001)(6486002)(186003)(305945005)(486006)(50466002)(86362001)(575784001)(478600001)(48376002)(37156001)(2616005)(956004)(476003)(52116002)(25786009)(217873002)(53936002)(6512007)(14444005)(7736002)(26005)(5660300001)(16526019)(51416003)(8676002)(3846002)(105586002)(107886003)(81156014)(36756003)(53416004)(81166006)(54906003)(106356001)(97736004)(4326008)(316002)(2906002)(47776003)(6116002)(16586007)(8936002)(69596002)(6666003)(50226002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2335;H:portal.office.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR01MB2335;23:GYsJSnFWnGsH3Cr7QsidynafSxh+DH0XIumVCLtCW?=
 =?us-ascii?Q?F+yt059/phnWKVapxsgYmQO8GA+bTcxRm+NQEMH5025GkYN1Bg74nvr+xB9Y?=
 =?us-ascii?Q?DxzRJs6n+OmKCOa+l5PPaRCiZTGTs7fKVwPnR+G+7wW+mOk7wFuhM6093lUa?=
 =?us-ascii?Q?C5m0Ipq9v35oZwrXq3FplgV6SF+jJi6chkV71hwM0ZZ3JKWvmIJVXYi3NSN6?=
 =?us-ascii?Q?UwGTtJonBQqQEtpAqPVGdVrTwXiDthm2IC8lkLiDbsrVaN5x3oJ5G23CAFhT?=
 =?us-ascii?Q?PIAa6Lam/ZTePvTW/+rupL1BKdXB+f6fwCovqY+mfAHFnNbR14T+lJpYsrkY?=
 =?us-ascii?Q?hFkM/mTKveMWi3cRkMml3tyTcNHI2Ppn99/paKx2l0Myj35oKvWzH6svvmxC?=
 =?us-ascii?Q?TNHT2DXtOaQsXKvphv1dhAC/FdNmjlZQrYT8Hg1DqToTxsIrpYw0JFvXkfHl?=
 =?us-ascii?Q?uhNy1GbwWT7r6Xmqoxq8yShc/vEt0AhHdlqdCZomY8ZFZ6s1MN6bCLo+JRhU?=
 =?us-ascii?Q?4+mcc/bGU+GbfxYLcMzYowA+OSCgaQcsPu7Pb6Gx/L1C+BSKOKvm+hmlZpi6?=
 =?us-ascii?Q?qvkDi3bWRXlcDzKgUwt5XiSy80xdLIuGaRFoLpkOaOlnX1ydUDo9kGiGMW3D?=
 =?us-ascii?Q?gzuv/8ZEmmcmFzQT/huV7v+soUcIL3JprIsyUHUr7XRt9knmYBj9QovdHIlx?=
 =?us-ascii?Q?B5OHc+ALFdJx6arlRGgVw8EN+dUf5EWEXJatto5qcP+gjpN/Df5bKk1ONVwY?=
 =?us-ascii?Q?q3+KylL17J1p6BGHZ/NZ39WHE6VbsM99od56tfGD+6ocXnA8mi6xHrih6rNa?=
 =?us-ascii?Q?fzlxrqq/0bDZr7yth6psH78hGLGCoD2elx25opxcASaYmcv9afpeZaiBsHuI?=
 =?us-ascii?Q?FO+XPbU40kyH70/WW3OCQgrJQAxb09jlYFW7gEnsO+zM/BVe2dSfyTtTxruI?=
 =?us-ascii?Q?WLyMzVw4A1ejSsXxP+Gtfn/y62KtHH9x2b1FlI1nhyNsxV+MCa6RQ4r62NHG?=
 =?us-ascii?Q?bdzUhlmL/6C6mjDAXIsW1Mz1GlGzyuFrw5tWT5AzdfRB2RgI9D43x3DYOXTz?=
 =?us-ascii?Q?Vqxza3hMVwVxNJpgKdhPiLUYvqnD47nx649V6rpOXe6f1lpPOQ6t+uU7TsdU?=
 =?us-ascii?Q?dgsZKkTbrDhXMA6D9ls0+RChSqTSROqwrCpfaq9Lkq+Tv6rj84LQbsqntZ4q?=
 =?us-ascii?Q?XymTClg14GNrgokAftcb5YnWzw0tURYU/992Y/RhFWu/LVngk+QiaDm5BwCi?=
 =?us-ascii?Q?kdW+zBzLVIUrqNrs3gzLagM57/fGFWRKdL+vXlQ?=
X-Microsoft-Antispam-Message-Info: Y4hBnYVaJKjq14He03kWrSQ5PmnfkEjrETddlc0NLLqhk48PQpowqPRFU441Rywtgb0vrYHozy769JKs3h2wLCfxkggKld0+GHZFDM6Ogv+YXrZeB1l2dh0WtUl5MZl9spH70aesA58PZN3bRHNv834wK7bEkIpNy0vj+PJ/snkZObWbmK7t4fHVB1cepDxvoZAoVXeCz/ZBXC6hTQgt0JVsA5XiLNrguZxy4lzdnqosxD5BeqfEGVOo6WPBharvIdiIF6OqEsIsB5RU1sWefyyKbMFsZOIsi7P5BVVWfdU1ZNZr2+sq6KiwQfLR2zliCXhvW3wLkSfcUbD+2ZDM33yaNM6JvGXsaj3u/FH056s=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2335;6:8L21HYAgGMoYPA+fMovI309Iuwm+vhYNCVocyL29l79bYP/xjehb12POjwjG3BW5RUFL0uyBjSdHHiQ9yDWkE91hu4P9HJctPRLTz/RkgsY8i/EgHDrk+kqoIIVAK8U/VfV7/ef0OwfHZoj6bywOvY9pt5L3FU2HkgpL+bBChr4imlPrSnbq24GYt6vtA5xu26zD1psIWdusqIyaVLrNmyXapnaBCmrRPl9QrPjgSNFF3oQN2aQT5ZKCQBqQgrNKYOaaZmNDPFnEWRsxu4bG6FpyRrPU0QUVMbDglHtGs/rk2pQ6qXcFksAEEsIMgNcuSY0/nDCyWLHLMkph43m/QPxcrser2pulcAB7I6omeCMuzEdbO6KhabCV7xE7DW/ygFX9jbXoxPM7bvCQD9d1iaMobpHyh65XeWB3CNmm4MM3ZoOTe2MWUOC7GxO5vc65JSnpblYi8UTXuVt1YNw3cg==;5:iobshiK+2uFv/xq2eQto0zayjDjXFxhmBw0T+3ExT+uMjc9fnV59vDGoihFtPciBvZXYtvabS+VM3BAKVkW9D2QpmsoTgxZKeZ2a5z/oU6qmJKtYIAEuqP/OIExKQhvV9rXVHRIPeRTyRAYYR9Z75f4s7cCFZ8bzHf1krUO8xPo=;7:ZDT/imDNnRW2+xG4ZFK2REar7j6H2Ek+6Rjc6UGjsTPQkiHd2X6+7hfI5WydU/4G7AssBwoCQM5Xb2/khtXCu0mGWFwGuzruSrewlIDSDuddGmTBEk6+xs53GoSpsNRipfulwVrJXLKpaUBshIPQ4IchHnUPGZmViMQSCqTa+8LoKMknMnKyXX7M+E/KxFIoEGglU19bc/eQZAR+hErazbWcPkqE8P4o5HE2thfU9Pd0CI5NmDjr5j0xxehLf0xd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 18:05:24.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806c95b8-b0c2-4006-1fce-08d6142351e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>

---
Changes for v3:

* Fix the indentation and whitespace warnings.

Changes for v2:

* Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
* Include this object for eMAG SATA inside the acpi match table.
* Retrieve the ata_port_info from the acpi match table.

---
 drivers/ata/ahci_platform.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..9ba283f 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -33,6 +33,13 @@ static const struct ata_port_info ahci_port_info = {
 	.port_ops	= &ahci_platform_ops,
 };

+static const struct ata_port_info ahci_port_info_nolpm = {
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_platform_ops,
+};
+
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
@@ -41,6 +48,7 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	const struct ata_port_info *port;
 	int rc;

 	hpriv = ahci_platform_get_resources(pdev);
@@ -57,7 +65,11 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

-	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
+	port = acpi_device_get_match_data(dev);
+	if (!port)
+		port = &ahci_port_info;
+
+	rc = ahci_platform_init_host(pdev, hpriv, port,
 				     &ahci_platform_sht);
 	if (rc)
 		goto disable_resources;
@@ -85,6 +97,7 @@ static const struct of_device_id ahci_of_match[] = {
 MODULE_DEVICE_TABLE(of, ahci_of_match);

 static const struct acpi_device_id ahci_acpi_match[] = {
+	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
 	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
 	{},
 };
--
2.7.4

