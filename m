Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3DE21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fdI8D8pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3DE21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeI0KFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:48 -0400
Received: from mail-pu1apc01on0101.outbound.protection.outlook.com ([104.47.126.101]:1824
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbeI0KFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWn3OjFm1SDY0RBhmDl7X1XJODHOyWHhhzddtAEdGYc=;
 b=fdI8D8ptgeMmYA2lULVYv7tuRd1fwf2+foYaB1qrxkMG75WFXqFqhLn5k6fIIGVr5/PaZGGnkgIdDvnaHXN/YRM3da+zhWcTgZXyBM0Hp/JhZDgYTa0Y8RWJd1NqTBCH0WvRxGl+TrAzPhB+rwBMnRIXOXCT25nH37manZaNlvw=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:04 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:04 +0000
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
Subject: [PATCH V3 3/13] KVM: Replace old tlb flush function with new one to
 flush a specified range.
Thread-Topic: [PATCH V3 3/13] KVM: Replace old tlb flush function with new one
 to flush a specified range.
Thread-Index: AQHUVhUICV3G1y3mfEyLLbdslRyf5A==
Date:   Thu, 27 Sep 2018 03:49:04 +0000
Message-ID: <20180927034829.2230-4-Tianyu.Lan@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:juefdeoZgsplgtKxdlsXLa2M1ViUCU3TACuq81wl+Hj+Z02E2km4l15T2aaWv1m4NX1IABeePigjpBHH5ALDB7GrM1ZWOeR9ouymUyuYVgae/0kg185zDvh4z4KmcOPFT5vY+2frHhHB9HNGn8xj9jPpUZLBtpl5ts6DjjtLSDBx9sFTcS5tQ9CA/wnUVCpRvppeCp49tCfSxAN/4o57n7dKWGSGIToaUI+ZBLTnCw4+dgbgVfpzMI+4+gEl5HUcPZYYTA4kMOKFolCkc6/HPa8WizN0AFP6jVyPNZ4uJFanGBpi7zlmxAKf6I8qgGUTlWtVMKoIvrYHofnS/uSW8PwlmM9DAz5JrZiZBb3C8krwSTCmtQrwyqEto534XtMwabvi/wbY2jiO05jjqA/ws6C3qz57mAQoI5EG8Z6HhI/QtekcgrPI7iZnZGMfGvDVpQdcnbFXLBupcv3dFkhZIA==;5:w9RTvFJewAUAc5IpcOWFQeslseX1QswOYh6B8x3jzbO+KIGHF6k8MYPM+pcIP0qQ2WzT7/BQ26IyNuSC9lCPCA1QZrpWla2Oe8bq41V/xk/ZQBo0knK/GwgoT2i3iUFf69xD1RY+feYmxplFmJna84kiTuyKQcQehGiaRNIPFDg=;7:tqs6UIgifR3HQzS7979AewUM69H9Ye52ymBWZTxWq0di3h5pD9qt+8p6kNKBUsgtpjADonmktSgS6EIpkmfV+dEC8Valcpp16bozSy9LC9ogQyp4yJPWROYHAcC0vNWD+aq7VrvF4N30jYKY1Y9keS/NWef5YegwWbuSg+ClZSx2Kv3oa8w+pxY/9J2HzvSSDqweBtTQaWf6PV0DJJIwkiUnn7N77r3AAONsWnJU6WKFWZBf146tZpvHESJf2Ajq
x-ms-office365-filtering-correlation-id: ca3a172b-a221-436a-5f1b-08d6242c2b8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01771594BA778E08E84116F392140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(788757137089)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Td4dYGIVhd27gDoM8TKxD2Hj30c47ryQcfVxoW2B0Eh5krgmiGktYpBYSeLAU0ZlJ+wM6s+GjFzyJdyeKadQZbCNFcmtkeHh+vQOj4GpYQyWNxJZYrBbzh6CnCtsYzJflFIrl+XrJ4n7aq72nsizaCjPTmPQDKcKGHYrazRY+aXPia+y7UtkwNrRsYZOuBZK9vJvnPV25KaUYfHm5gKuK9hIf1PpGuqBXR60lfaMdR9hRdWJO6U/0E/YKzoilEhWy73wRMd8IT9N9gNdhMUwUmMfYjLCXFnO6Pbl8+nOprWT58UPCGBglvLBjOsa6MdeWVk4RiOX0cMw0/LmbWatcSSEhyxkxR0ZGU5Z62rhPN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3a172b-a221-436a-5f1b-08d6242c2b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:04.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to replace kvm_flush_remote_tlbs() with kvm_flush_
remote_tlbs_with_address() in some functions without logic change.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c         | 33 ++++++++++++++++++++++-----------
 arch/x86/kvm/paging_tmpl.h |  3 ++-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 18cac661a41a..d10d8423e8d6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1482,8 +1482,12 @@ static bool __drop_large_spte(struct kvm *kvm, u64 *=
sptep)
=20
 static void drop_large_spte(struct kvm_vcpu *vcpu, u64 *sptep)
 {
-	if (__drop_large_spte(vcpu->kvm, sptep))
-		kvm_flush_remote_tlbs(vcpu->kvm);
+	if (__drop_large_spte(vcpu->kvm, sptep)) {
+		struct kvm_mmu_page *sp =3D page_header(__pa(sptep));
+
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level));
+	}
 }
=20
 /*
@@ -1770,7 +1774,7 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct =
kvm_rmap_head *rmap_head,
 	}
=20
 	if (need_flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
=20
 	return 0;
 }
@@ -1951,7 +1955,8 @@ static void rmap_recycle(struct kvm_vcpu *vcpu, u64 *=
spte, gfn_t gfn)
 	rmap_head =3D gfn_to_rmap(vcpu->kvm, gfn, sp);
=20
 	kvm_unmap_rmapp(vcpu->kvm, rmap_head, NULL, gfn, sp->role.level, 0);
-	kvm_flush_remote_tlbs(vcpu->kvm);
+	kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level));
 }
=20
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
@@ -2467,7 +2472,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct k=
vm_vcpu *vcpu,
 		account_shadowed(vcpu->kvm, sp);
 		if (level =3D=3D PT_PAGE_TABLE_LEVEL &&
 		      rmap_write_protect(vcpu, gfn))
-			kvm_flush_remote_tlbs(vcpu->kvm);
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, 1);
=20
 		if (level > PT_PAGE_TABLE_LEVEL && need_sync)
 			flush |=3D kvm_sync_pages(vcpu, gfn, &invalid_list);
@@ -2587,7 +2592,7 @@ static void validate_direct_spte(struct kvm_vcpu *vcp=
u, u64 *sptep,
 			return;
=20
 		drop_parent_pte(child, sptep);
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
 	}
 }
=20
@@ -3011,8 +3016,10 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *=
sptep, unsigned pte_access,
 			ret =3D RET_PF_EMULATE;
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	}
+
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH || flush)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+				KVM_PAGES_PER_HPAGE(level));
=20
 	if (unlikely(is_mmio_spte(*sptep)))
 		ret =3D RET_PF_EMULATE;
@@ -5621,7 +5628,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm=
,
 	 * on PT_WRITABLE_MASK anymore.
 	 */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+			memslot->npages);
 }
=20
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
@@ -5685,7 +5693,8 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	 * dirty_bitmap.
 	 */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_leaf_clear_dirty);
=20
@@ -5703,7 +5712,8 @@ void kvm_mmu_slot_largepage_remove_write_access(struc=
t kvm *kvm,
 	lockdep_assert_held(&kvm->slots_lock);
=20
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_largepage_remove_write_access);
=20
@@ -5720,7 +5730,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
=20
 	/* see kvm_mmu_slot_leaf_clear_dirty */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_set_dirty);
=20
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 14ffd973df54..708a5e44861a 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -893,7 +893,8 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t =
gva, hpa_t root_hpa)
 			pte_gpa +=3D (sptep - sp->spt) * sizeof(pt_element_t);
=20
 			if (mmu_page_zap_pte(vcpu->kvm, sp, sptep))
-				kvm_flush_remote_tlbs(vcpu->kvm);
+				kvm_flush_remote_tlbs_with_address(vcpu->kvm,
+					sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
=20
 			if (!rmap_can_add(vcpu))
 				break;
--=20
2.14.4
