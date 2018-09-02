Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A2C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFEA2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bU4lJRAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFEA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeIBRjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:39:48 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCnozvWOA1NvNzpyc7gsVBLd7+U4WHowFJ6akzDPN6w=;
 b=bU4lJRAXJMhOIRurGIyi7ygyOM9CJKFN09VIM05zSEKMLUwe4w+rAslLS6FNYUg2qSRo5eQvDSPWjQnv/pzXFRNa9x2YVzb0WvPJ6kBFqG/R/xsVFrEbgt/TssDgjYKF9lMX2n7AFpFYTKJdh57maZSD+2G6NRN6Imb3KGqPGfM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 24/62] scsi: 3ware: fix return 0 on the error path
 of probe
Thread-Topic: [PATCH AUTOSEL 4.9 24/62] scsi: 3ware: fix return 0 on the error
 path of probe
Thread-Index: AQHUQr7hLcuWHKfYtE+qtS4txvIj8w==
Date:   Sun, 2 Sep 2018 13:14:30 +0000
Message-ID: <20180902131411.183978-14-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:hIKMdFxBGMltzXdOf2ufJn90SqO1WI3p6aYNW5MxUQpe3I5BdF8wRHpkkbbQOmqaoL6g+aobGWW+/LHhFnDNw4D44sxq+ISvIPDvOcB1UYJOoN/mj7p0M2qndUuG3EDYJq9GnPY7CY4OJxz1b03fZQJ6gP7mtVCg3dFwv4BHnM1ArgSxcPMRgXoJLMTE7Eotfh+V9QRrNwclBYg1Gc0mG8t8C14fkXwpbaYlgQKlVb9vx9sJHmRLDwVqb8scclfOD5sBWc4c6OLbYDZxJBmuMHGmr8B+vun/DBiTN8UY6SpJQJgXlUZ6UXm7dLkzYmmPDD+mlKwpCc06z/E9cu5akx0n9ZtDaSq13i0FZkiLW9olFX4WPrXB8LUCNFuvlZtocd1QI8Zp2eCRQ8NJzZJ3lRNt5aUrxSjHgzobDtOV053EoTDbILR+wBqgE5s4Le84qQ+SQu4o5og0AmELmXSD9g==;5:tiOMDY5QdkhN80UDPRKRpdS887dyGzsBhtRJULS3xwDp/5F5NoCnNIhoBZanynPRHrQ5907JAooi7szZsOqQmyMpKV6C1QLfPz/7LD74nP1LVC/I79CAwNy6+BAsjC7iAe0oLLZ1ydVyWbE6kzOKktayzokA2+IY61VzvuhzSps=;7:PI6KDJnT8yGLDg9Fo5E6Z0XVUX64zG0X7BWEivjfi89NpKE98W4WqgoYbjzEyGS6mjThGsf4smA4grcwL4o9M0wmPXZuLWOJkFAw3QiaR/B4siNb85hwSrrs2OAJWiqPTWrrusRp1L8u4EGQIGd2effGKzlOY/MAQ0P/Plq2HNZjiBJOsQ9PJVtMYWBy//uQYGqXipbeqfGtVtaPfjVHZsRMMooxCYkJXdzQTIT2GSmru7mu0WoId+6fy+aFhtcz
x-ms-office365-filtering-correlation-id: 7838aedb-1bb9-46c0-9dba-08d610d60468
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012020441A94834438CF0C70FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(4477795004)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FqGZ8fIplLG4m9umm2wl0ENiXdUlG6XDvHcAznerYk/bJOBRDxMHoeBN8h+K/Q4tC3YXtW9NUEAoZeP6Zgtb06A+XMcv8A8mM21eEvf+mFDjjIL7Ydk7efWAYOi6OvgnNRQ0+gQhAMt5kvjyi8Lmt8WHdqOJr8HuBRXqr+1eIvY6Hvylkvyz3nS1hsJW/NjNtIj0FgvybY7EfDhZwfeEJNFbbM7/3MQB5HoZSyP3041VqckrGDNxBO1zFnuD4yECvLsGJiKA3+s3sCmLPVYY5cgWTyLZO5/8TbnjahjBpkfD9Vc/A84FU0yj2/L8MaNHaXGPC/YOWlYg3P0KzGJ6Jf7sJlU0Hnf2KjxStUgkDcc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7838aedb-1bb9-46c0-9dba-08d610d60468
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:30.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 5466246c69b4..b78a2f3745f2 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2045,6 +2045,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twa_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2067,6 +2068,7 @@ static int twa_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D ioremap(mem_addr, mem_len);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -2074,8 +2076,10 @@ static int twa_probe(struct pci_dev *pdev, const str=
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
index f8374850f714..f0a5536a9ff5 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1600,6 +1600,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
=20
 	if (twl_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to initialize device ex=
tension");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -1614,6 +1615,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *dev_id)
 	tw_dev->base_addr =3D pci_iomap(pdev, 1, 0);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ioremap");
+		retval =3D -ENOMEM;
 		goto out_release_mem_region;
 	}
=20
@@ -1623,6 +1625,7 @@ static int twl_probe(struct pci_dev *pdev, const stru=
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
index 24ac19e31003..0ee0835d2647 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2281,6 +2281,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
t pci_device_id *dev_id)
=20
 	if (tw_initialize_device_extension(tw_dev)) {
 		printk(KERN_WARNING "3w-xxxx: Failed to initialize device extension.");
+		retval =3D -ENOMEM;
 		goto out_free_device_extension;
 	}
=20
@@ -2295,6 +2296,7 @@ static int tw_probe(struct pci_dev *pdev, const struc=
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
