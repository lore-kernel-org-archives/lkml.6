Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BBE20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JMA4XKRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BBE20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeIBRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:22 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:4252
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729971AbeIBRbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBHdf+hbtpWoWfiEzTNZcNI45WFgoxlUXcCCkFi69zA=;
 b=JMA4XKRU2NuFUTDrfoZ/oX6vDAd50FR15VqfsD/SbG5NgaYKiN3eZ/l6CQKxfEtJ1j8H6wT0c5j/X1UBD/P7dM6nbfBJk7BdXMvYmfHK+EB/Cp3x0Vf7XpRW0/iZhM/YVRqcdVjiWMmtkGYPxIah+/fBwG4tWkzDu5TpOHTZlRg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 48/62] iommu/ipmmu-vmsa: Fix allocation in atomic
 context
Thread-Topic: [PATCH AUTOSEL 4.9 48/62] iommu/ipmmu-vmsa: Fix allocation in
 atomic context
Thread-Index: AQHUQr71U52hWcGJkUeGVKz+xPqY/w==
Date:   Sun, 2 Sep 2018 13:15:03 +0000
Message-ID: <20180902131411.183978-38-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:iXCzTwVgV7crKzzmIMaYTukN1YIyISnAwiG8wFYZZYIaG4JYTNjHGrCVwJvNABVJ+XPn/RoS2PP4vAQ7lmSpUz8j1jMGYVgQesE1PQZWwVMR+ejJuzX/cSAnZyR2ttNYHHv7Z6JP4RIld45eRwIlS6d8j6tXJUxyJg3VnIg9shpb0sZNCg0hcXTLW3Zk+uAgTxHzo9fG7m+Nkvm0d5eDPLBm2FF2QNbTt4Ox6qDf+J0a+Aaj/2Vl6wPH8TnTke06ubV6wWXGZP71ZtxkS/IYcHiKPwl+HdzwbJRSy5o4rqaHzGPHWHDgM4q5RhTJt446h4AcHgvfXo/W2NhoB2tVso22nsO71cWLQSStd/sQhvYn8+jouWwxDE+rZQI3xaNy+WKehPxeUKjaQhjFkr76aZIcdhPoE63DUqwltt3VOZX0njEVmxpKV1lxTjYPqa9vpetdbo/wVXXh59KjBcCGQQ==;5:Wv/lSU0g91ml54KNodcYJyDH1BCCuCVTjuirHb8g25DWW7ZiLLqFGQUVuW4Y2llYIlrlbtALAsZhnCVkYJXxrbLv7cpYFFObC1uajKiy8XBdz4tEK5AVoR3uD470tJvljnKDZbAmEBg6JlHJOFun3g0ePZ/8xodyusMUt9J7Nlg=;7:LGRCNvDMKcPvnVrRt00ZveEDcy1We4iaMGPh/m/VMY6jJ62sA1Gg2/bvGQkproKfh2cZtAvXwbR9FZYY9rUlVnFGLwWaL+jrAJOB+EGOFjbuMgvdEJExUaYZ+sJVcgClJF/Vk7RVasolmFWwl5036xze/VXUkVgNFqRY7DNLR6UONF/7xjaVWL/w1tNNg8WcLdRP9Ay4s4iAnKNLsnnM4Eyl9NhmLG8Nfm2rFA553P6I0vNglYrqGFaXCqvt5lkR
x-ms-office365-filtering-correlation-id: 1c391db6-a792-4eb4-668f-08d610d627e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07415945F274AFABFD7D0478FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(5024004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u5EdalYxfNB+nYyBdtwQkP9kjIFwoSAmPx83L7GL+ArSqrULYXFEsD7ijrM3aU1yy1xYYSxKWwt0lZW6uGJf7KRY9Q/40YyHhZ484sZ/GjzQkXA8v1Rta93H1QJT61PdT1svYbfazx/NM8rSDd3tVRoUJyXD53kKObYYiAPR6H7lKcBRXguOdgP2xO/DdPDGqOIVksUMNMXOl4HZ1yx6ONXjmu9lTVX5kmoxMnxe8meUzBqKVk9DF3+ppfuXuTn1VIO4YVJc+r0KNL9Q64E7Ot/rfZ9fFhSFd9Fxf0FUxg7sFBMql0+3SghE1XJGXQ09qCTOSt6Ruatu/V84Oo67AK9GxNOcJnujgg88I878XOw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c391db6-a792-4eb4-668f-08d610d627e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:03.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index ace331da6459..85b5e75c7faa 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -44,7 +44,7 @@ struct ipmmu_vmsa_domain {
 	struct io_pgtable_ops *iop;
=20
 	unsigned int context_id;
-	spinlock_t lock;			/* Protects mappings */
+	struct mutex mutex;			/* Protects mappings */
 };
=20
 struct ipmmu_vmsa_archdata {
@@ -464,7 +464,7 @@ static struct iommu_domain *ipmmu_domain_alloc(unsigned=
 type)
 	if (!domain)
 		return NULL;
=20
-	spin_lock_init(&domain->lock);
+	mutex_init(&domain->mutex);
=20
 	return &domain->io_domain;
 }
@@ -488,7 +488,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_=
domain,
 	struct ipmmu_vmsa_archdata *archdata =3D dev->archdata.iommu;
 	struct ipmmu_vmsa_device *mmu =3D archdata->mmu;
 	struct ipmmu_vmsa_domain *domain =3D to_vmsa_domain(io_domain);
-	unsigned long flags;
 	unsigned int i;
 	int ret =3D 0;
=20
@@ -497,7 +496,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_=
domain,
 		return -ENXIO;
 	}
=20
-	spin_lock_irqsave(&domain->lock, flags);
+	mutex_lock(&domain->mutex);
=20
 	if (!domain->mmu) {
 		/* The domain hasn't been used yet, initialize it. */
@@ -513,7 +512,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_=
domain,
 		ret =3D -EINVAL;
 	}
=20
-	spin_unlock_irqrestore(&domain->lock, flags);
+	mutex_unlock(&domain->mutex);
=20
 	if (ret < 0)
 		return ret;
--=20
2.17.1
