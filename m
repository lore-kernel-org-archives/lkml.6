Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C4BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DCD22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EEPapDzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DCD22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeKLWQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:16:19 -0500
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:23520
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbeKLWQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewPNmnwJ5iM2XQaie3reByXSCBGTSPGnN2E25FVr6Ak=;
 b=EEPapDzch6PwRTfbp3gRANRg5ETpEBei75Z4ZD423CJriyzKOy9kdUNh+IGXOeIgXexPCeyPNO93VGYJ/wC5UQA37ND89smnIW0JVBIHmg510vqlAyenBG+J5wLaniuKQZ1qq1QHkXq34XquqMEODzknnV0xnbUMbtntNmRwjSU=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2748.namprd12.prod.outlook.com (20.176.118.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Mon, 12 Nov 2018 12:23:14 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::9da0:57ec:ca4:8b1]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::9da0:57ec:ca4:8b1%3]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 12:23:14 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Wei Wang <wawei@amazon.de>,
        Amadeusz Juskowiak <ajusk@amazon.de>,
        Julian Stecklina <jsteckli@amazon.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] svm: Add mutex_lock to protect apic_access_page_done on AMD
 systems
Thread-Topic: [PATCH] svm: Add mutex_lock to protect apic_access_page_done on
 AMD systems
Thread-Index: AQHUeoJ79/wMfPe91UKWDtZmjbe/HA==
Date:   Mon, 12 Nov 2018 12:23:14 +0000
Message-ID: <20181112122255.128953-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.109.129.36]
x-clientproxiedby: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2748;20:cJwiFxrEIHU/KqAu9eXRAfvR+CuH50nO+J0vkmPAS9BB1S1/w1R4fqFiQpfhKjJ9vcDHFGEo1VdH1OGr0qOCqkQjHWfy5Wvy5j1g2s+tpccA4GohlaFkObt3xginKv0vyXNiB5e+KBnb3LrHBReimzkmKEhurFE6RB9gjGl2NP7wj/b68bDvW6SFpi3ofjMoKxYOt4jih8dMwuK8DeVe0z4H83uTjkFuC5ayZNrZSMUyGKwoFYZbRlXLX9dP5EA5
x-ms-office365-filtering-correlation-id: d3f3655a-c39e-40db-9140-08d648999e44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2748;
x-ms-traffictypediagnostic: DM6PR12MB2748:
x-microsoft-antispam-prvs: <DM6PR12MB274899CE11B2527FD84FEE3DF3C10@DM6PR12MB2748.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR12MB2748;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2748;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(2616005)(25786009)(305945005)(316002)(106356001)(105586002)(8676002)(66066001)(7736002)(8936002)(2900100001)(186003)(97736004)(5660300001)(86362001)(6116002)(81166006)(386003)(3846002)(2906002)(110136005)(54906003)(1076002)(1857600001)(6486002)(99286004)(14444005)(478600001)(256004)(476003)(6512007)(102836004)(14454004)(71190400001)(2501003)(486006)(26005)(71200400001)(4326008)(36756003)(68736007)(6506007)(52116002)(72206003)(81156014)(6436002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2748;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XsZV9DOYrzbGXFawsc+vaW3YsIPL8KB2ewQtnYRPZzjwf2IH+4UV0BHYMFtl38jo1k5BdORxSfyiJbNuGCftAG7EfU/qTcaoaxTkgHv8aNEkTeWhUPWGCcOGSUWhhS5dOcxkm7Vdk5QV3v3kOK5Wy1Qeb/WDf0YJkUHzFmszWsgOKmoDRPmCMIz21AEPwtHsBeYoFf/RiToY5ceorX8tWI0oohe/QLAic+uvrhEV7b2hpUctqhiXAtao+WHzX0IxhL/ffuOBtuBL8KzHIgRpo4iTnPVNEaz7cZY1j+KSP/829UTOSATZPAr4jz+ctRKxGnZPlx04uC+ge5H4ceKx4/rC3W9ZUx0xlvK6mV2RkWw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f3655a-c39e-40db-9140-08d648999e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 12:23:14.4665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wawei@amazon.de>

There is a race condition when accessing kvm->arch.apic_access_page_done.
Due to it, x86_set_memory_region will fail when creating the second vcpu
for a svm guest.

Add a mutex_lock to serialize the accesses to apic_access_page_done.
This lock is also used by vmx for the same purpose.

Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Amadeusz Juskowiak <ajusk@amazon.de>
Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index d96092b35936..8be1718fed1d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1658,20 +1658,23 @@ static u64 *avic_get_physical_id_entry(struct kvm_v=
cpu *vcpu,
 static int avic_init_access_page(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm =3D vcpu->kvm;
-	int ret;
+	int ret =3D 0;
=20
+	mutex_lock(&kvm->slots_lock);
 	if (kvm->arch.apic_access_page_done)
-		return 0;
+		goto out;
=20
-	ret =3D x86_set_memory_region(kvm,
-				    APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-				    APIC_DEFAULT_PHYS_BASE,
-				    PAGE_SIZE);
+	ret =3D __x86_set_memory_region(kvm,
+				      APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
+				      APIC_DEFAULT_PHYS_BASE,
+				      PAGE_SIZE);
 	if (ret)
-		return ret;
+		goto out;
=20
 	kvm->arch.apic_access_page_done =3D true;
-	return 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
 }
=20
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
--=20
2.17.1

