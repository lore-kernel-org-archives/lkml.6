Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C6ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77ED214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fDBj47Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77ED214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeIRItj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:39 -0400
Received: from mail-sg2apc01on0137.outbound.protection.outlook.com ([104.47.125.137]:1824
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729398AbeIRIti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/UwvVIprPOzynm3r0UcMqWEkXYflSAIX0YX8blZhP4=;
 b=fDBj47Q/CW4A0Ki09jBV4nhJwzlqcwsU4n4EE5YuvlztAgqpIlvgcc7L3RzCeFhq8DM2Sf4de6cS9jqk/R1wjVWrzzvXRyx8d2uUibSW7r8C4aXBjVhMPbCAjdb9VzqpUfVnVSLagtQw5cUQ8SyH5NWuE7d/ynb/DXzXSlftOOs=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:19:02 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:19:02 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V2 8/13] KVM: Add spte's point in the struct kvm_mmu_page
Thread-Topic: [PATCH V2 8/13] KVM: Add spte's point in the struct kvm_mmu_page
Thread-Index: AQHUTv5Yjcsqwk8Jh0W575QE6PqQKg==
Date:   Tue, 18 Sep 2018 03:19:02 +0000
Message-ID: <20180918031754.113013-9-Tianyu.Lan@microsoft.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:2Ybs8O/HWWzK+IxpsHRAQqaVNnI/WwO9jrsb6fO6bknNgMQEwmQNNipGzV2hXuijITfWrOk8HPbQZRAsQmNeH7tmUxkD6nfK6sMqV+fMMF3Ba/CCKscydPcjDgpjNlQF0IEnOtFgr0wDAHpfGWnPfLTOY2vhL079J+SHewsQGRoROpOqaI5ppLDkb8HD8usuHBx2rps7S7DMVRDHHTeGJc1c1Y7QqL20SLT7TCPLB0mSeWUF9yj1EiOOUj1cc1ADZ9lYidQzPPqyHi/9HvTSaYa9/6qhPlVDPX0CFp5GcNaLm1q9QF09TzpcifgD2/qPj4IplL4dYrjxX0WP/e8vrg1dApSdtF1qIfGXaIIjGhpnsdMPpKLczPK6ZKlXidRb3RFQN470ooUX2TcZ1MAsP4K6v1wHa2q7RL8RQZGgA7zM8q5hKJO1CM9MaRIyTyAe7+pkkRTO4n9Vv4KgSiwDrg==;5:78R4pM1fSMic2NGGOqorCJnKF94c6Boi8hjfDA9DRva0iGtRk6Kl85TDytjqF0+DLYxMoLtYulg1FpU9yhS+SFY/z3jxTHKdEOwbIC/jNpw8gTUfriovcTvFf1Ab2fHZ3Mv5Kh/CietVSPmzmqgduvm2xc/cnywPBVTo8BdOG6k=;7:u8FTqGKjT1j5IKOzqc6HBt3GEzaO5QfqO8yVN3MEQaPRgJsp787LhWU8kaBaR7AHr384KaqmJInmqE/PN6mGjAQq0ujD4HrJygh//L/RrDhfEZcqz21BsD2/5Ct350pSmmbJpQBNso872U7VR+xVZPPDiS1lSk/NSbS4FvSj9k6k+ZznIpo1oemVLXyqio1cdNclAk0P+4jSryc9FKuM3v15k3l90vI4Pd0XyFQ+c3Bvd3JMECI/7UshY3Of1NFP
x-ms-office365-filtering-correlation-id: 5a503a90-96fd-4be9-121b-08d61d157bb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB018098D240D1A9ED6358766D921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(575784001)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(14444005)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T/17i9SV8IEt9c/gwj0oSFI2ajDnKmjtYMwSaAchIykAPW3H5QwUSDFJibmBYSTVAKtHdD3gSVa26dS71XOmSHd/vjqcyeI5pyNQsKYSFOe62ItAkejnpQHajVfNKIhnKBHYyhTXVY8dzjCMt2/M/w76VrcACY/y3X8uE1/Xo0wiX1/aW4L3ZD602z9FwexFiylL28J827UDQCBCHo2SUkiqMyEeBWJPQzvKzYG6dbHb9sIVrS8+T0KBiSl4QRSPYLWTHy+pasGVNSuoq+WeQZKZ24LExq9V2+semdyEowl7l46zHfkTb0ST+wAr/9xTZA1f3cmmP4202NoRGOZ3VG/iskKw06d1h/OUkSGxM00=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a503a90-96fd-4be9-121b-08d61d157bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:19:02.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's necessary to check whether mmu page is last or large page when add
mmu page into flush list. "spte" is needed for such check and so add
spte point in the struct kvm_mmu_page.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 5 +++++
 arch/x86/kvm/paging_tmpl.h      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index c96bc4cbe4b7..d42d96e637b5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -296,6 +296,7 @@ struct kvm_mmu_page {
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
+	u64 *sptep;
=20
 	/* The page is obsolete if mmu_valid_gen !=3D kvm->arch.mmu_valid_gen.  *=
/
 	unsigned long mmu_valid_gen;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 85a81a62e0a7..8f27cb8c3989 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3162,6 +3162,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int wr=
ite, int map_writable,
 			pseudo_gfn =3D base_addr >> PAGE_SHIFT;
 			sp =3D kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			sp->sptep =3D iterator.sptep;
=20
 			link_shadow_page(vcpu, iterator.sptep, sp);
 		}
@@ -3599,6 +3600,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vc=
pu)
 		sp =3D kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu.shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu.root_hpa =3D __pa(sp->spt);
 	} else if (vcpu->arch.mmu.shadow_root_level =3D=3D PT32E_ROOT_LEVEL) {
@@ -3615,6 +3617,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vc=
pu)
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
 			root =3D __pa(sp->spt);
 			++sp->root_count;
+			sp->sptep =3D NULL;
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu.pae_root[i] =3D root | PT_PRESENT_MASK;
 		}
@@ -3655,6 +3658,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vc=
pu)
 				vcpu->arch.mmu.shadow_root_level, 0, ACC_ALL);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu.root_hpa =3D root;
 		return 0;
@@ -3692,6 +3696,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vc=
pu)
 				      0, ACC_ALL);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
=20
 		vcpu->arch.mmu.pae_root[i] =3D root | pm_mask;
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 708a5e44861a..5cbaf7c4a729 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -632,6 +632,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t ad=
dr,
 			table_gfn =3D gw->table_gfn[it.level - 2];
 			sp =3D kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
+			sp->sptep =3D it.sptep;
 		}
=20
 		/*
@@ -662,6 +663,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t ad=
dr,
=20
 		sp =3D kvm_mmu_get_page(vcpu, direct_gfn, addr, it.level-1,
 				      true, direct_access);
+		sp->sptep =3D it.sptep;
 		link_shadow_page(vcpu, it.sptep, sp);
 	}
=20
--=20
2.14.4
