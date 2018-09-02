Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EABC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D032077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a6/94pfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D032077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeIBRoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:44:55 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:27886
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728662AbeIBRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3a8VG0xFJoxF7TF61zt5I0InBxXtPnRJ3ODPR3Rdvk=;
 b=a6/94pfyHQA/NCZSCiibYcr0q5IFo/0j/Ok7YVMSz3x2zuNHLlG3fcZTnDoITUvECCvW5SE8QQPXorS9yk/bYKg79g9utwWgkVIjBHptBjJTUi/VCWuD1hYfGE6zDVnwe0RxQF8I2xsv8zhZhWAUdJlRFaUx3s9dHyr3ycCWCQY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 110/131] iommu/ipmmu-vmsa: Fix allocation in
 atomic context
Thread-Topic: [PATCH AUTOSEL 4.18 110/131] iommu/ipmmu-vmsa: Fix allocation in
 atomic context
Thread-Index: AQHUQr2a0nD9tQ4iPkigZ+RzAilQOw==
Date:   Sun, 2 Sep 2018 13:05:21 +0000
Message-ID: <20180902064601.183036-110-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:eDxuPseflItpIM+NlqzS1vDEAr6Pz6xwzLnVGrFMNmeCGQ4ZF8KIPzajpEmXfb6EQf9JO6HpCX9t6a8LPz5yF6FckRGp8JieE3cyajhgFavmObz7tMGOV23E7p0Zwd7E1dufo56toxkbbocp/SQHW3P3LM8YIaTmcrvHKAGZnjW3RwClnihEHgMWJ0Q9WGvY6Px3+lquiaKMKU2yMn6nU5v6fVsB3qX3HXjxB8alXI7ydK3i4HoXBrRKv+IKnR4oEKiVl859Ug5BJ9ymeRymHNrqfYhXMFO7OhBnRUTE/s3div2sjN9hCG9wika/cAF+9WGgNSQgxMJxrFVrhyrZMe7jfZl962vZluyR3r3FnZFu6lV39XsjGfIPu/67gD+E4dbCAbDPggiuHS3OwZoz1gfltKupauhMn6PYtXtMniJQKUpPRDgYzJeyuHaLqfZz7Pn/n8unEuROe/+gnNN17A==;5:6Eyg97OTfBpwrgCkAcOnIKgI2UNzTojaZwNUy5h+c6iX//tATnQxrc7iPxM3ILv7xpFvSKGeibXRvQSa1DohOFWpMWkp7s7TmJVmdj1MvzelfQtqE5q6FuFCmy0Xvoz6vZKxIvC1MLyfFTmE+rqD2lN2y5/bI9Wmn2nfA6nXNvQ=;7:SfVIVsUvImksFxtRimIDli9W4hi4AzOZ3VMXu2ek1SxCiiqSPSkXI5Mf9CTuz1ZSxQfgSYtyQ0Wh+XFC+fL2ZTQQkCkrnZLvJP35rXzxIYLP5ZrWjczbi+V2gilFk1RnY3VHO+PKSDHhtL9NYnuS8FI2dp/OLR/8Fw7kO4xDnPv2E1gX518DfD9LTonJBX8uJ5J35IPE4tlzFsIWPLA1KuuEmfCt0E9UfUMo+Nh+lotLRo9xrYZO5sS77EvlvB7J
x-ms-office365-filtering-correlation-id: 8b59b1da-30e8-4493-dabd-08d610d4c79d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184A1238204AE1FB4CECB1BFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5024004)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eZeqt2Iwtz9Y06YqDGr4wGqu2Cv3MQpVAFN/l9yXrE0KQVlc4DczSMpapNdVvgUmv8l3YW4bIMthzQ98tzeKlFC/EliogFrt5RS//DYMXeUDSKa1VOmC4h80RZeI5PDlOTveS9n89KFyYKcwNJpVzkrtQ7bwh43OrwRJ6SB/fN5RcnK4R6MeW23K+eZMuf4UkeVGoGQjSqr7G9Y86OnhICaGHyi7RXVUXimM8Q7xvvO0D2iW4rx9BciGNQQJotm4We/lTJVo/FQyGPEbGt0yCNvnUV2IU2VN/Jt9aHf3MkGczCOOxVKgQwFESqJ9UxH6BHBHjHGUwuZTJ+oTI3xHtcNuM5EvmRV1UOnYm7NbjRY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b59b1da-30e8-4493-dabd-08d610d4c79d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:21.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 46583e8c48c5a094ba28060615b3a7c8c576690f ]

When attaching a device to an IOMMU group with
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy:

    BUG: sleeping function called from invalid context at mm/slab.h:421
    in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
    ...
    Call trace:
     ...
     arm_lpae_alloc_pgtable+0x114/0x184
     arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
     arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
     alloc_io_pgtable_ops+0x60/0x88
     ipmmu_attach_device+0x140/0x334

ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
had its own custom page table allocation implementation using
GFP_ATOMIC, hence the spinlock was fine.

Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
does.

Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table all=
ocator")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/ipmmu-vmsa.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e87cb88..ef566b4989d6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -73,7 +73,7 @@ struct ipmmu_vmsa_domain {
 	struct io_pgtable_ops *iop;
=20
 	unsigned int context_id;
-	spinlock_t lock;			/* Protects mappings */
+	struct mutex mutex;			/* Protects mappings */
 };
=20
 static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
@@ -595,7 +595,7 @@ static struct iommu_domain *__ipmmu_domain_alloc(unsign=
ed type)
 	if (!domain)
 		return NULL;
=20
-	spin_lock_init(&domain->lock);
+	mutex_init(&domain->mutex);
=20
 	return &domain->io_domain;
 }
@@ -641,7 +641,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_=
domain,
 	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
 	struct ipmmu_vmsa_device *mmu =3D to_ipmmu(dev);
 	struct ipmmu_vmsa_domain *domain =3D to_vmsa_domain(io_domain);
-	unsigned long flags;
 	unsigned int i;
 	int ret =3D 0;
=20
@@ -650,7 +649,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_=
domain,
 		return -ENXIO;
 	}
=20
-	spin_lock_irqsave(&domain->lock, flags);
+	mutex_lock(&domain->mutex);
=20
 	if (!domain->mmu) {
 		/* The domain hasn't been used yet, initialize it. */
@@ -674,7 +673,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_=
domain,
 	} else
 		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
=20
-	spin_unlock_irqrestore(&domain->lock, flags);
+	mutex_unlock(&domain->mutex);
=20
 	if (ret < 0)
 		return ret;
--=20
2.17.1
