Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6025C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C067205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="DPm3gdgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C067205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeIFJHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:07:30 -0400
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:13174
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbeIFJHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCK7LP4ptqCK32NujMKBvaQxXcSiSJVCevvdS8AHLPk=;
 b=DPm3gdgQGbOgRhAsrdtl5TzZWV4DX1BgFLnnOnsHqoTC3N3hj10iKGxvAd9uPaqg5o9vFMPuafFzGdVQohueOSr9GWZyBjkjvL0szGBxYg/+JR8Ed6F2eNJJflW6x+GMPKkfX+n4Y7snkurA/IDL/6CQXgw/US4ra0EDJz2pGGU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
Received: from portal.office.com (4.28.13.142) by
 MWHPR01MB2333.prod.exchangelabs.com (2603:10b6:300:27::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 04:33:55 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     hdegoede@redhat.com, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Suman Tripathi <stripathi@amperecomputing.com>,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
Subject: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Date:   Wed,  5 Sep 2018 21:33:41 -0700
Message-Id: <1536208421-24867-1-git-send-email-stripathi@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: MWHPR21CA0032.namprd21.prod.outlook.com
 (2603:10b6:300:129::18) To MWHPR01MB2333.prod.exchangelabs.com
 (2603:10b6:300:27::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7faf2eff-997c-4620-4f5e-08d613b1f4a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2333;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2333;3:7ft8b4iqOeKDsgCya5+TjFIILEJqoW5qp3eRk4GR7/Ayin3Z2JeyOkbPd0pz1RNL2r4DVxK9l8/fzyKdo6mqlWZOR7ItXdvGWEz+wBdoLEJ3Db0U0Z+pB4YFwVDqdkLyqhUHm2uN4YUbOOOdKaZKED4v9AYxb9owTF6us/ov6dWcSkEONIc7T0hMIGMhFDbp40il9/jmtAIuQuH0ga4PxLD5LeqZu1pC97pwnjMeoTBNUvxMdstO64kYGd6FycyC;25:UPsMpohdmB013vRTDrYLu0/AIX294H5QcNjevoLCQ1Dvne4kU7hvjVk2YjjmOq+V/x3bZ46TIOEjo31DdcEQnHj7qQtZyCsN4FfpYvyywPezVcxNNvRyuQM3/PB2JKRNYtPjH7ApSqhogLOKr+VqXNljdXGjaQY0g/XwdpQJ/9VkPBd1d2SxXdLkd5hAo7z+T6f7GpX/Du/IQTXV3Q0kQZnn/g+ZMTNrrgwCkcHivTeI6YKRFj5ESmZbUrVa88LI27LsA8facQBlAMQH1vC9hrPMuM/0B/ySE1Y7K6wpNUNiB/AY6ndtWft4S2Iq/vWkl3b29sxotvmbB73eMO62uA==;31:lWwXON1CPHpndpOR4lRlO4amnFF50PHNsVig87Fj/gsUTrX5GNFYOMtZXyi69mxblrG6zuAL/pl+kL4Fn2x18V8kNA5l9xR7vKEf2cBQA+6oAipGwHV7Ht3dspJLdNZ0jbzzeL3fIi6nmLMaLlTQpIUEdTY9UvRz1ciZyi3bpMyQdcgFL31ETk2nZuWdRBKFB3X9noaWPqDHWZ8CE7VhkJhywFRJCyw7e3TGQAMo4PI=
X-MS-TrafficTypeDiagnostic: MWHPR01MB2333:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2333;20:NauKjvG1SdLKj19g5tRa6O2eKiP4r3s/IdiMWjAW8SjSyLdBKtWhe5M1tNJdNUgJQUWGZblJqcJsLuj4q4DZTU4ASwpku7cvzEjsoEysT/d+KmjGZn8fysi9vjvA6coJ/OwFSkbM7zker8DLVlFbTnQKk+g/aHeyISWdqbm7NnU=;4:kDlzf+Os3SZxc/YA4tyGsHjzuhBPSd4lCsXqQ80HGlGMyEv9rocIZbwQcCYBf9Oixjo+LSV7HTViQXQK0h15gNvYpf0SJG4fZfisl5AUX5/cmdjWgLHtMJqgWDCfmkdrMr0TsbOJ1MCmoBtuuf9Pdr9LZLDS8PRs2KTcezzxILXMFcl5gZJctg/X5IykvB5K2pXUdXjiUjzurkxo2nN+hSQ0MGkvnr3LXNYbU5VsVEdBzI4ktPgBfyeBjjMI0bb7zXJjwr+m7sZNHILN3ssyZjsuCbDDQELQrquvmpQ1u6PMgt24uZFaPdJXFR4f/yay
X-Microsoft-Antispam-PRVS: <MWHPR01MB23334753106973398EF1184CB3010@MWHPR01MB2333.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR01MB2333;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2333;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39840400004)(189003)(199004)(86362001)(575784001)(6666003)(68736007)(2906002)(107886003)(8676002)(66066001)(50466002)(48376002)(54906003)(4326008)(14444005)(16586007)(316002)(16526019)(26005)(217873002)(52116002)(51416003)(186003)(8936002)(386003)(6506007)(81156014)(81166006)(69596002)(956004)(6486002)(7736002)(53416004)(3846002)(6116002)(2616005)(476003)(97736004)(37156001)(305945005)(105586002)(486006)(5660300001)(50226002)(25786009)(47776003)(36756003)(53936002)(6512007)(106356001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2333;H:portal.office.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR01MB2333;23:rPwIeKubKgNbJGaFToCh2IYS5oaTWvIWChnZ4mSKp?=
 =?us-ascii?Q?WQlfGFCV3t//GvNRot+IlfbYOGqmFKof6OoTk1CJuYJ2E8O0IsXcTL/raTE0?=
 =?us-ascii?Q?o0ktZnICw1v6AI4Lib3uUnVnVEylChQa2j52iEH9Ce2CHHNqj/McZTm/+DAQ?=
 =?us-ascii?Q?7+X3Xa7n+xCDq/wx8kKlYDG66EkiP+CLpD6rtrfCH4vm1jEZEAZX9Wgdny0y?=
 =?us-ascii?Q?RJLDSmCkfzzQtJKu97UWqGCed8uo+kKaIh0u8/zSiiV4d2pyYe7Jvly5mLhF?=
 =?us-ascii?Q?PjXWNdpcVTd7iod/fwiExviQtJW02WK+exsdYLo7KcC93FnnIT/KwQEHHcIC?=
 =?us-ascii?Q?/9637Dq926/vwoaf8J6ApDDvcJGOzoKhi8UXmyRsnBGjIlJYkHT3IBJS9ZNP?=
 =?us-ascii?Q?E9m0bn2p4eyYG57wL8Wld0CBKh2ZSzhx8P+CL7lzM0OoswzVjw2tt6Kg1k1Q?=
 =?us-ascii?Q?tfAHkgSHV/I3rylFeDq/sHdK7fLey7O4ze2rVL1wZpcYaSQKsewi00vtj5PF?=
 =?us-ascii?Q?hqeQMiBNQy9sxUxU7aAs8lWDGqMQvQYKgM/hHwFz5LsMzL9rwKjKb8ZNCT+t?=
 =?us-ascii?Q?4rSEbON5NTQOgR/IjDrq7xv9lxcmtRcDYECfBfLbYhXzPMoHf87sbu5p55LO?=
 =?us-ascii?Q?HNV43oi8vgyIN7MY29oW1wXyz0I2dIL9DmATt8BosTMVwXDOKRHove+8Lzle?=
 =?us-ascii?Q?X/AkmNxeF78Ol9rWTTsPb1RTH+pxcO3dY9yOCLn5p6Q2pfAuABYJf2lcTV6b?=
 =?us-ascii?Q?P9dyXMk42e4Vvwr6yNNeGFrRVsX3uDiknD4PV8CFcp3BiUVdpBtiO/5V2F86?=
 =?us-ascii?Q?RWoNhGFHP1YPlZ6QCjG867XXpTpnNn1yFFpMr4Hv5amr96Z8/HltrAI0cE9A?=
 =?us-ascii?Q?BsrI+p6aW8ByX8VJ2nKlgQ9AChX06w1eiux+NKMwHeSW3iS5cJHdNpJOOHx8?=
 =?us-ascii?Q?+OdLH2IcKhuJ4CzhOHFrmylH5coO+HuhGncgGehWckENN0rz/3OiyHuOg6E8?=
 =?us-ascii?Q?VNewNwwltb48kUHlf6eYqtGd31fL/ucEwi2i7krdJS2gRiIMTxU/oWAoeTyZ?=
 =?us-ascii?Q?bjmMlQCyTJS/CPtHwhyFfC7i9PbEa52MUzl8DyDQwNpQMy9Sl2ERyVxjD5Dn?=
 =?us-ascii?Q?ueKwPPILJ6baMoKOw9Ar9yv5Ttt3ZtOxPYRm9kK9bD7vIfLTUvsSpl/5tG5K?=
 =?us-ascii?Q?Q7tldd8krMvHmqkqddpgSpESLgBWsPvNGSh3dErzea8kGQP1ltDlFKwwfu8C?=
 =?us-ascii?Q?iNCFPdwRVQpxqTSAdaAThLFxPpudoaSINP2fysz?=
X-Microsoft-Antispam-Message-Info: lXWPPwAWOcMn6J5cvGCfuvv5XI5E94ASh8WomY3QQ7RXrzuzi6TS+jtlcZOnN+kQjaB8zEIkuJ70sDMVy+djunW/67z5nksEh0W2+k7WbiJmLN2hD/ZJaP+EUcmnXhNt0UbsHpMWXCk9z0+ksZs8+ltHlgcdeRW2lDerXGDcxYSjmdAoTdHM2Cg5qf40uSdiLGcTX790Foal5+wksMNY1AvWYKqyqqQvxvofaJGB1GAVMaI1Ieh6l4nr9UknnwPRbZa6cpKm4Tya35tXpYQdijOaVT2VlwTuVc4k9t5BTKhFD/w1+guKuxVKsdJ+5huybRmPjdXFhDfxUXYREZx2hMlvkiRYZGOmhkjwUTrMW1s=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2333;6:GgdUKkocDSiQH6k5MoyUBRXwkiPgeTS51ci8rkngFciI/Z1SepQbceKWOamGv5+QBpi5e12rQG65V8Momjcn4j93NF8ZCNVrACJPxTyl1YPSIjYTG3UEkFgv6P8AxAtYMBc4RGewAIfWh5DIMuQZgGwZ0tDQ33KKEOPhWLpmkta/rHI+NPe29kEpgMMQ8Dqzer5Yx/9UmYtrren5Of9NsyGohD/NwSX4DovC86H1ZpkaCkY0s5vcfeQZJJ8Qq7+2glCgE7cvDm2pe2jZmRgAetFGtosNJD/6jvPMAtS2aFn8oQ9PG4azSZ1CHX4dB+L75ZgmmrT/zBJyOShg93VqMXniq/guXllRAT2H/kx2pEvGir8XhwROEiAT16w5s+/bHDpUHiKQjIzW5OI1WV9d/9Z0tkuMpiNrjEzGJomE1IQoy/92sjBYafIYQvj9u6PbbhyElAvUcYKo1FLBmuIKHw==;5:aEb0Bdbgk7XMEAb/cbuqTDb7LScz+XMip9TgXqDd4sP+bmIYUYN51lNM1FQGcdyyHQlPxNINu5GIkATBk0pivMV2X2bK1wIzJrYwYew7vdmEys1bj7od82AysI6dl0JSnU4c2sx9rfS0c+2TyngBqvlTsqKFvqLQAJH+BXF99gE=;7:75qJ5rEDWkV7kN6bsq76+neVxVNKDuAfZrvNbEH+JSN2Wo/n813KbtY4l0mgj4eqNy3Mu+WyO3VbwNwAICJntq4+6EYdjBuT0jr4U75TFMXWWmQ/l0WBpUnndcQqark43rUHbvWC6QOiRXzoS5cPA1RY5lsRnZD7dzHYEoE5g6JIQdab10fvD0ykEaojx/jXZ35xBwS9Ta45hFxBgN2yh0Uuvz1DqN5F0hANaltb9vfjiUIlYMyPsKtLUyF1PYHH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 04:33:55.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faf2eff-997c-4620-4f5e-08d613b1f4a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2333
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

Changes for v3:

* Fix the indentation and whitespace warnings.

Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
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

