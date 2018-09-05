Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB52C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCD42075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="Rxwnq3IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCD42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeIFAo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:44:59 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:60320
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbeIFAo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFpv/29SH/hZevjtmncSX5YVNQGwj9QqESOSpSY6Qaw=;
 b=Rxwnq3IE4zU7lxW9TnXwj5UeX8Fk/HGPQeJGXUjCMjaBMr5mRqphvXT6KEcTAk2kgFmmt/v/AuLGrFa8IqA0uLjTxPuBobIZTeLffGWaERmhxWcp6OqxSuN5bpXb00Nh0zdLJ4mnLL9R7esoIOcaUKaifPYCj2qCdOtUnbPL2lU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
Received: from portal.office.com (4.28.13.142) by
 CY4PR01MB2328.prod.exchangelabs.com (2603:10b6:903:23::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 20:13:06 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     hdegoede@redhat.com, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Suman Tripathi <stripathi@amperecomputing.com>,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
Subject: [PATCH v2] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Date:   Wed,  5 Sep 2018 13:12:55 -0700
Message-Id: <1536178375-31700-1-git-send-email-stripathi@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: CY4PR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:903:9a::20) To CY4PR01MB2328.prod.exchangelabs.com
 (2603:10b6:903:23::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63c262c-2ce5-4c6c-d041-08d6136bfe80
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR01MB2328;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB2328;3:EYSDUeoR8V7vfdO2MFqKeDqnepD8eAP9TVCZSb97HJFq1zk4XTSkI9hrdLdw3mGqKDdlc/0R8FM9I7umwVShXwyaA+Kvi4yJyGhZDyBd8wP/0cE5KOy0yZxv9gHGVYC1NfxF6Ijm/Ak/66SsNwzo+MJ/K42ST2EmoAJqzUvDnhMZT7yNZm1QBXg95fX/wPXkm6bNphvIr2eIR7yCbnE2MbdQGPm3sE+TZaBOd8LT4m/7zQDOirnsLMagF/nE0fCC;25:2AaIV7jaisa6Cj67X5aXHYnlG8pwotgTwSZilG6yTa71s52KJKDg4YrZHD4DF+dDwpbZkP37TpLOtYqY1hjmEEBBIc0FaP2rylIM+yRqPqEUpOw+Txw5jQB9DioSNXaZBfiXupgRJC7b2g2r5Brawh9FmchRcQ7C5gUBGJcOVVlsnCQNAQoroGruEd2006PVJTvnD1B28O4UdCxQveyDJfBdZRksYaqBR51imKlEGHGy64uiaVsTzajDwcZwtdnNuIMAExBdk69OMRfkRz1P9fauPwywzgtQ5GIc+gpeiUJ1dT4dOohCA3DLTIagnqdLK1I7H7pYm9n18HaFsxdhPw==;31:7oZLolX73coREcQA/pQinVWk/7FJ4uA0QygbAJ2zsH7LGPxW5mBQzpeZ5QAzF/5we34jLhRmE4Nm+Pt2og5hWlOJZWixvMWi1AYl/tlkvte1VKFKD42LBN/9Xbjrxcej+zgLb+xTGZRBDAqLyDfjJzRbvgSG2LhUrNOuGBZkSsrUSfSJkYfvTPlgStEixHLQOlfq27Dlozv63zFqzQcuo3S16U698rKK6fRspCst1Zg=
X-MS-TrafficTypeDiagnostic: CY4PR01MB2328:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB2328;20:w+s2SG3ndV0wxi4En1WFzJdscxeoc1UJjZED8C9qw3BLMrDoNQQbCZ6UMtyfNnN9Mu//tklAqcYfMw3O13SzjEtwKVt4ysRO3P2gBw5cItQb+zlNSzHOEs9Ys2F8SMXzBrXB6gIWWYuW1cAGqZwk+vT4rSeY+jcxFYvfK+cDX1s=;4:8wOJ35dz9UWk9Jm6SRYvaBbvCsPcHbAU6xRF3759ZuHSy0zDxuRYnPb0Z3Uvy+c418XYM9IgoVhIxB11mQPv0XBdVgOsMYJtypnn8AfuEZv2UDdQYJ/wEgPSYsIZsPL/n2l82GseStxzTwF26e9oE689p73mH0+TL6M7BeaFN3imcv8KOIoX7WLoYnJBn/zgBd02sJGK1pRhldbsfWrYze9xbvzxRrpgYkIQDMXEGecp0iYA1SzJ/A5oheWdRef7LDcbTn0P4kcE/bx0dxEkUf+gIDB9m3VA0Hbrp62+0OfVxcPb7GHh0hQ2CyU5bW/Q
X-Microsoft-Antispam-PRVS: <CY4PR01MB2328ECE28CF1C9CCE30AA167B3020@CY4PR01MB2328.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR01MB2328;BCL:0;PCL:0;RULEID:;SRVR:CY4PR01MB2328;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39840400004)(199004)(189003)(486006)(53936002)(53416004)(69596002)(107886003)(36756003)(26005)(8936002)(386003)(48376002)(6506007)(66066001)(16586007)(25786009)(50226002)(47776003)(305945005)(81156014)(81166006)(50466002)(7736002)(14444005)(4326008)(106356001)(37156001)(476003)(6486002)(51416003)(105586002)(5660300001)(54906003)(52116002)(316002)(2616005)(6666003)(956004)(8676002)(97736004)(3846002)(478600001)(2906002)(186003)(68736007)(6512007)(217873002)(575784001)(6116002)(86362001)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR01MB2328;H:portal.office.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR01MB2328;23:+FaZ//0JRFIu56WYfvqIMd4lvaspSpa5GlJeCcVbP?=
 =?us-ascii?Q?AN7AG35eu9OOV1zQ2+iPfmjmxXZrWU4X3VYu3MQga9k8koAcyzqFmOfMGB8W?=
 =?us-ascii?Q?zgSxBcDHe8Y8JebyOnbQYuEpi3lRVeQJfb8wc+7M3AuHTnCA7FWVJiB8vw7/?=
 =?us-ascii?Q?2pRW2i2Y2yiWGZi2WgxLW9MqpD1Dl6M/iExZuyTqDjDIXl1SfxwBgQEKYFVN?=
 =?us-ascii?Q?pQ/dMMywCJGutjFth+sR/fmQaSxFzdKYJIFUV1Sie8OUaiXJY9AEo6shYzpE?=
 =?us-ascii?Q?bSZodCuB1i4KbeRsybpQVKKY//gAT0grBZwAUJ7gA9GBXWDxPwLOfqiUeNC6?=
 =?us-ascii?Q?v0oUY/iaGfyeW1g8jJA8wEGhGreZRCH8dmfy2Szi1GkreLqNGZbxx/wyowbn?=
 =?us-ascii?Q?uI5z3v4EngpwCLPOq0rgp4rttd4N/OoYUlN50JAYfrJ6nVWxriqBzWesMKqG?=
 =?us-ascii?Q?NS6icz77kRoIkAykAdXomIKAEc4w6gdcOCRFVj3Zy5W3bD6HbssNa9am/4ZT?=
 =?us-ascii?Q?d8czf94jQZaOluEJ03TzC0KYP9rfc+/j2Dw0PSJp1dFp3TrXkzJGu6ev2gkC?=
 =?us-ascii?Q?FqH7UcK3kHbO1hI+sdYYi1Rm47JG2z+XoespYy2UxfLh9xAyY8KZ2tbkyuw/?=
 =?us-ascii?Q?ab1t2DpVIFYaCgjS4OnjFdR0+5gzg29tAp0thQY8f/0VbHmBG8YaAsAHX4bZ?=
 =?us-ascii?Q?8lhkcoqaxngcDRwDNU83SOqQ9mjLLF1u+BuNl3vtdPE/bFeC+Xq/cTeePkMh?=
 =?us-ascii?Q?uRSHi8TLysjnbjtK2/kjerc9NFiYQcMlm8XFC0OsviNZLNGrR7S7NLIBgk7p?=
 =?us-ascii?Q?OpgbJlRGiZhUhIb6XKq4nMLRlbMgcQpFHHXVMGaI96a/HVErUgjfyDBcgC62?=
 =?us-ascii?Q?F+XQ14Ef7XEb9PJw3pwTLZbOOYO9S7sAF51U4DT//JwpNgYwucMZnCT+wJwb?=
 =?us-ascii?Q?E2692UShKnQPSLCxNWb+UnmHomM2XtAv2uCob3X/o2eyeplt8fXZYWjt+DSd?=
 =?us-ascii?Q?wno0MBHHfiiLOy3aoeAhe5odBwxhiARbpolWr+KTFzvRDD2u8FHWTgCNFKzA?=
 =?us-ascii?Q?3dZntR0Gtg5wi+DpiHwU3OpohigtuPV+J/THp8yoZcJvl0q6hCq2nizcoB3z?=
 =?us-ascii?Q?SidFSuRO7KXKUqL/lrSefyKkWClt/Ndvgl7UM59GxCwwSjD81sjSY7iTyYsa?=
 =?us-ascii?Q?FjWtle80QDlemhvzQbxrYr4D3G+f7G4fSvVXE2MlgZmJhr45/UZJdM6CJN38?=
 =?us-ascii?Q?fznQ94q20Xl7FkODY95u0sFyGn+M4n0GoxxXXjP?=
X-Microsoft-Antispam-Message-Info: K90kPLPovCYd1Mut0ykVb+DkfrfBVTy8p+3I9R5NUIMJkE9H97cc+t5pJCUyeYBj0iiRvri1YeC5Dhi+B04cPGzwuwDQ5gJZna2HZAzATXiDeduolI4awTepTsGE5P73fgz/U7lEEGVf7nojDJ3QJJjbv7OtPt04ZPRVZQCDwytHxO81hZuLlNdw+8THw9fmbPcdRonWCnzS5T2OgCKY1iqgDex7jecBuspUCv7hba2kD5ouC9f3h8Fxv2wjVXPzAkj1XChoD3Vk0288MYG5vJW1+3AP5epna8SNaz1JkIvkNRLilk+eJNyoh3QocwDcBi6NyzK0u88l39w3dGTnEQion4BEzVqr3fDrD3OD8+o=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR01MB2328;6:qNOI82hEZ+aGizhBDIhTZ5efp1p00cHaBUvz8XXMgl/osxG03e8922RkbBKV6kuXY0wz7v9ERBKoARUgwfYurotO4xEa10R/pXytlUB8y3B9S2hjEriFV2pshjvVnsvIBz32hqCRXwiY+fwleX5eLDut/0LhuOeoAwbiF8MzSEX/zeWcNwdSd5ogLm3VgQy/LOwVoMyYq9rGQZM5kueHiecspUrxS18uUmvfB5Es9YWWFuIZEZFXXJZxQWEJyOiTEEjI/2arLHeB2CKGLJsMV8x10v9kucYmzeBYvKr84hGhcGE6kpdnK0c+nL0AgMh5v0b3Ugx/MW+CSk+EaXqp/fn+5mAAvcUjkfpJrXYZtojD+S4cKn1RuBdCFqN3g5Y7WSF8mvexl6TA9VJPPEma4rvLIt/efYWcmAKuAA3QLx2DrpeRyX2duIRth9Tk5iWJINimqMTzLgJkEYkUrBkimQ==;5:BLoqYYwD4nP1nt/HKwZy7O/6j3DtCaIY3zzpbdrbyRJECmNt6jq7/CFVAcxxcHu2aGj2rj2YNmnnxoQ93+u1rkSzx5ZHkJkG4ZDl/5aKsmMbPpEDHL1mpcSw25+DR/LfB3zBaVCNReXMv+xaYVcjCpy2h8CKsm4ZQV1BZmNKwBk=;7:PjohwXy/seS69HV+6+npBLq/d3seuO093Xye2Z9ZvIaQwp+K48e7d4tIp8YlCzKwPKtkbLBHda+HGnTZSmUx5Og210xWN8h9bo3yQ3b36r2tdBkdWJ2s55E1rphP2ajIvV+BkEohcNLKt/JghLMf2YA88TM61oNR2gDze0HNoVmjI/dEPLu4HnsVPRHnYILgekm6YZLkn/dLX4sxuUVZfY8ZaQh2cHW3PeIumYSapfqe//fKh8wTvqYxPKmf/QyR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 20:13:06.7567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63c262c-2ce5-4c6c-d041-08d6136bfe80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Changes for v2:

* Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
* Include this object for eMAG SATA inside the acpi match table.
* Retrieve the ata_port_info from the acpi match table.

Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
 drivers/ata/ahci_platform.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..c3043f6 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -33,6 +33,13 @@
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
@@ -41,7 +48,8 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	int rc;
+	const struct ata_port_info *port;
+        int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
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
@@ -85,6 +97,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 MODULE_DEVICE_TABLE(of, ahci_of_match);
 
 static const struct acpi_device_id ahci_acpi_match[] = {
+	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
 	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
 	{},
 };
-- 
1.8.3.1

