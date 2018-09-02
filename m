Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443F204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="guheuT0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E443F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeIBRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:06 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbeIBRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsM7HHv4U2HW+HW8G/5SwX7e6+c2Ge4O5V1n4jK/kWY=;
 b=guheuT0f6mIbYT8eyCdNGMqMpATKOWwya86bTs2DdBCuKjnGkGXLmG2GhZJPsid0rEtJJ6GUkzYKJXiuIo+ljotdb8m+lVD6hpIgmyNBtARhc77pbFrahdpjuJD1AgZDRAxDCviUOU+DMqgXkJp/BTaz7/RCKQ73IIDh6XIn/ZE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 43/89] scsi: 3ware: fix return 0 on the error
 path of probe
Thread-Topic: [PATCH AUTOSEL 4.14 43/89] scsi: 3ware: fix return 0 on the
 error path of probe
Thread-Index: AQHUQr3VR1/aeDPn1EK8grl+qjIicA==
Date:   Sun, 2 Sep 2018 13:06:59 +0000
Message-ID: <20180902064918.183387-43-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:m8cdl8MKwtgPaYAM86bFllXrXSn2j1BMMUNb3cLKRR06+AsRn1pnz8z7QL1M6MZdxoQMgE7oYARm0RfT18seAwceLm9pp12QlLQwDgB83oSdNExUQ7XdzEbeIyUXmWXLBkG6WaUr96NVV+onfRKppezFgOrju3LhuFmhbilYmW6+FTNu4MfjzYGNyixLJu3IxZR24GfsQwFro0/lbyI5Vmhg0UAPl0jENW/k6lN99fyOsoEK4XBGHZW41KJtMODtX+0hq4MeEcsFDcsO/DEGafU8PFeKwY5W6ZWWbleaxjW3rlbJTLgRny8EIk9aRkIVE8pb7YKqOiARnELKYnSTZLnWJKpwuxEX4V5lWAwx+Ti87XoZbNwjJw/zqAuA6AuBFRt/i3Eg2g8Ilm+5nJQKxMgPrGI81OtQIFOT8JdiMPRVwasefd0iSKRHJD4ByLUDWjbYZWKPfuVaU6gkKkbIXg==;5:SMD1iYjpe/rk0+1l1isX71LBAH71Bml0u6yYHSyt7gU5C6qtkbmLJ6eW4pRn5z/mIp4kaRV1lJjOF1J+aiqCa1Yr3z7GWf/rjPmSPTRSeiZA4ivhxVcErj6UfxTchr1INHDc7/CCX95ndj5MBwjyOI7zjme0pCD3RGZ05oJNmxs=;7:z+ofteOupZrsWjREonWQkqq4aBnFq7zT1eKz602Qbfvv/LovqJU7PXn136g3JIbGNAtxr7eEV2I0ZA2edlfTvKOvGXQcrE4/rW+Iz90EnfPFCUnKOl+VTog7Nw/tns0X4t5au9nTXa7efJ227CRY81obTLMCe7Nmy11hET/q2oGHjo9pJEqilfBuRh586jwdFAWvXZx4LtUPEVy46+xQ3gOhSoYehykYNMhmuu1OAZvEI+5tzPQiMRukWxPHKheQ
x-ms-office365-filtering-correlation-id: d252282c-b352-4335-8285-08d610d4ff1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB05038FC3359A3A8DBC67EA57FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(4477795004)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: s764PsYyolVGki3iOfgvhMkZhGJjM46ofr3tv34s4exzHi7sPrYWVXTQLMK/7+mWpZI/8/hbL2tlXPpvcAITd4EaNfZjAFys4fpXh4twu2PKaVt59YR0yCl84dOw1VFl4Ech9UnoqYW1cJ/V8R0Dae6KEt+6sZpz878+3LplDTiIdSw2boy5TAP1wYG6V3n8jWc1f7VUcqi9mv9+2vy0n3RAPX7YBFl4erCEP7jslnSO5zCdeZ2BZZMb30sDz50n0a/YnNiwhfP/iY7pRgcc10YrHQpFj4JlEARJsSVlN38AnLNgQfL6d5GwWyXuZQrA8h/ktUWhUBM3156Opci+4ztpjIT42UlgeYhNASdtRyo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d252282c-b352-4335-8285-08d610d4ff1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:59.6228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 4dc98c1995482262e70e83ef029135247fafe0f2 ]

tw_probe() returns 0 in case of fail of tw_initialize_device_extension(),
pci_resource_start() or tw_reset_sequence() and releases resources.
twl_probe() returns 0 in case of fail of twl_initialize_device_extension(),
pci_iomap() and twl_reset_sequence().  twa_probe() returns 0 in case of
fail of tw_initialize_device_extension(), ioremap() and
twa_reset_sequence().

The patch adds retval initialization for these cases.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Adam Radford <aradford@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/3w-9xxx.c | 6 +++++-
 drivers/scsi/3w-sas.c  | 3 +++
 drivers/scsi/3w-xxxx.c | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index a1388842e17e..dd342207095a 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2042,6 +2042,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twa_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2064,6 +2065,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D ioremap(mem_addr, mem_len);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -2071,8 +2073,10 @@ static int twa_probe(struct pci_dev *pdev, const str=
uct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
=20
 	/* Initialize the card */
-	if (twa_reset_sequence(tw_dev, 0))
+	if (twa_reset_sequence(tw_dev, 0)) {
+		retval =3D -ENOMEM;
 		goto out_iounmap;
+	}
=20
 	/* Set host specific parameters */
 	if ((pdev->device =3D=3D PCI_DEVICE_ID_3WARE_9650SE) ||
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index b150e131b2e7..aa317d6909e8 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1597,6 +1597,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twl_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -1611,6 +1612,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D pci_iomap(pdev, 1, 0);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -1620,6 +1622,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	/* Initialize the card */
 	if (twl_reset_sequence(tw_dev, 0)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1d, "Controller reset failed during=
 probe");
+		retval =3D -ENOMEM;
 		goto out_iounmap;
 	}
=20
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index f6179e3d6953..961ea6f7def8 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2280,6 +2280,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
t pci_device_id *dev_id)
=20
 	if (tw_initialize_device_extension(tw_dev)) {
 		printk(KERN_WARNING "3w-xxxx: Failed to initialize device extension.");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2294,6 +2295,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
t pci_device_id *dev_id)
 	tw_dev->base_addr =3D pci_resource_start(pdev, 0);
 	if (!tw_dev->base_addr) {
 		printk(KERN_WARNING "3w-xxxx: Failed to get io address.");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
--=20
2.17.1
