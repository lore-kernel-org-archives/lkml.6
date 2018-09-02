Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ABC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C3A20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LMxkupyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C3A20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeIBReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:34:36 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729900AbeIBRcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+gx2QQYLtEDA6Q+/HOABZuoJgkA5Vrnwv/y0kvL7kU=;
 b=LMxkupyAQrEojYoSAD/5jyB0dwu4nIIrGVWlmrD4fBVNYJMeHjZMF7WSbzskSfXRHJqqLBshzVdWY0riLASr2QU1mPVhMDHVXACg3dctn4pJQy+t7OUrFrrDsuP1h6gWG6Gvi/VbdJ/1IjCfwAt2i3xJlQDKQntKteWI1iI84hA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 34/47] iommu/ipmmu-vmsa: Fix allocation in atomic
 context
Thread-Topic: [PATCH AUTOSEL 4.4 34/47] iommu/ipmmu-vmsa: Fix allocation in
 atomic context
Thread-Index: AQHUQr8jU7E9TTY8Kk+FCpeaRQfOQQ==
Date:   Sun, 2 Sep 2018 13:16:20 +0000
Message-ID: <20180902131533.184092-34-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:K7qfekGczuLFTA0f1ozN+tyNkuN+gWYQCrHYaps7VFJ4LmyWk8XGVW66wYW1HeWQS+/78uSkSsqiuKKyaqM+J0xgEqeZTuaALnYWU8dFLy6TeoBTtJa9nWZUOOShriEojqAxzAkQppPS3cLmGVgnsTcg+c0odVidQ0lXe2qZZSq/oje+mjod8Mv3Cmvf1L/OaAAXnGxn3xQVC8vdpOP+A1ZrFVRdlNWypC7ghNMnKQ89z8RitT89O1lNxyrw0isoDC+BtxJghPdK2g9G99NgyxNZUGMZWlOOJSrfMabFeV7/EJ0HRVezrU0wdMeEhRLjsOkgjrPPd1eU4sttyFVX4tEUt3L8bTwdsV/4wQbJvU2k1dRGGeBQZRPt2eIOzeZsPQ/uUWbKQoIuxpvWLCwEkUdlK1F4t5vwadJluPdqFe7HEiuDKfVjBHhLcpJ0WtjPoziMMNcvZc41UykmcH7zCg==;5:11Fa8fkNwN3Ocdx++Rrh1CvLE8VmPqfzVJgWX5UgcEkFA17WHUeR7WeUUVX38SNTawliWYyOmSvar/XL4m/BCj3cAlXI4kuV9hq12v3KCHgqsFmz1moLLTTaRhqPmUrVvqmlekhQt7WWosf4dW4nzvMInV76+f5w1hMftgcy2Sk=;7:MKOPg/S5uDO9Y4L6NHz47rD7uWNKkfJxIZJwmPqUyJHpeNtbajKi4byMWDtkA10+F6i15NHtPUwDAf8wrsGfjV3+r0VDCLwDgbwg5FUdUo+lJHTaxDKQJzhmMDvphZmekDGp2nKSY5A2kmd7jwOSWBKYop+DT0qnqZspoE+C4pQyX/hX0Dkus8ptSy7dvdz/rbseo9k+qXNUPxzqa361dvXXTNfghvRsy9VeW9NEZa62dsGPLAByKfiRGR7/Dtu9
x-ms-office365-filtering-correlation-id: ef564338-2d69-4027-1018-08d610d64b3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167699C38F95EC2650B1340FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(5024004)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BcAAHUx6aqSHkQ/RjYiDxcvFpJmbIpzKHWRONIyK9RdQAyzx5RnOoSTA5D50D+2ADkBhd+hPrdFhzXsjjFp4GFeEp+msXdj2/9xt+VSs/0kAI5VRfJmse2FkSXKK2P7Lg2Rf7HKxaPqTW4Fa2SJdzpSggqYlzcbl8L7hztdPgupqFpRrEBC0p6ydVZFayCzxlpKHrORs4MVagYxjusMThHT4qeEVJtUuao4to1+1+4xdc60yOKoP3siYMPToH9ip1zn0CAtzDZlM/lKMkoJ/UayVbYi5v42l9pNX3gF2+X2SPqxkgFkDyfJubVh9kaCHLHHi/YrBb17nnB5ZJFuYQcUvWNBNbiUSUiZBPDcdn4s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef564338-2d69-4027-1018-08d610d64b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:20.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index dfb868e2d129..624e7ff76166 100644
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
