Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E055C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B14204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oGR2r0lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B14204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIJNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:31:46 -0400
Received: from mail-pu1apc01on0115.outbound.protection.outlook.com ([104.47.126.115]:51269
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbeIJNbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYCGtYTNlgMIcTDqv2WmrRhc0PsUfeqR3BnL9Cl5XSs=;
 b=oGR2r0lkvzIzclJ+s31aFGV8Q3vbGXJTF80F5CCuaYfyiSW6OV6g8BBLNKqywbgfeoPzrCylUFd+67yFvDobJugsrhIvtC/6LHB7/dLjDcXwqZeS23rvwindOcZ56U/tL6tbET8kvEXaIj4kYDVGNREGBaMz+M6OT587Ip33His=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:38:41 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:38:41 +0000
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
Subject: [PATCH 3/13] KVM: Replace old tlb flush function with new one to
 flush a specified range.
Thread-Topic: [PATCH 3/13] KVM: Replace old tlb flush function with new one to
 flush a specified range.
Thread-Index: AQHUSOGtQQZiGERAyUaqx2+A9Wqsyw==
Date:   Mon, 10 Sep 2018 08:38:41 +0000
Message-ID: <20180910083806.65177-4-Tianyu.Lan@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:OvzJTht1wY7+yusj93PXKPzO6392wK86a+LEP6kiED80p7MC5yLlsNupRO+z/NCMkG71WcH68Y2zcG9WvBkYIZL896trxbX3S5j4deLDUPGH1ci3edwwOzUcLQ98Rq/IU2pqX+L0w+oydtpkmt0HD5in5sLxQhUvM9aakaSsVqq0XGdjnHWydB7hGhVzgQD/CWmmAbRNjk+dHh6bKxUw1M70XICisK5VKzIide06Bar0pToxcnlAj/owF++AOIriYw22k0Hx+Uskwrc3CGiD9g3028xI0bGQb68UIcCfUGhRcWQSjbZBphFTZCgIZNy8+zfz0xiACAuK85vIcoUwmy7BlImtObG6GGwjax2SDBjL1klCWb9blnJZr1rztozFEEXIZgPYE/mC5RumSqICVvHYtzLdI/ohVfMvGuVcdWE/FThXlz3Bfj08TojSmTZYC7/DKHAziqVVE+RBUwZEBw==;5:oDn0T2wY0L6JOamnPbiRfR6lzcsxEdA95RXcDmag2Osn3QQJOop4eRBhERlUpftLoVu2ViLx1TFDKoCeC0k0onOhLTG727d45iT0aWJSFEfKiSnLYHpTsTIG6BoaT0y07Ou/O2Xb2wpr9LkaC2MVqDsE2BoFmZaPCKpSCbUD7o0=;7:HCk+ka07/q9Q1aEx3LSc05vkjAoxbeh/MK/Zy1y7KSAutt2HY0cpc8WnzdOM0qGDOwHW2gvnoslpOBqv6nCfVmApsG3sdf7/+ZhHufNgEsRcV0tzOKQ9Qm79/HmZpKWZno3KDSkSOuomQOLS8JNHnZDa4HTrE5rBwQsE0Ai5cVwyXDAr15o++oDVa1qWn2zje8BNjO0evBijZGHy0zeHeBOAgBGB2gBU7sOWEnMdm/D/5+13o5FwRwmC+TKco9ZP
x-ms-office365-filtering-correlation-id: c014a083-2de1-4ced-de6d-08d616f8d003
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017825EECA449F231E6D44C392050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(7416002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3OhMPLkzNZA+DY/IVVIbKASy/JWfW6/oNOe9TcWqGh/JP16GNezQkrdOOF4iMjNv8JiIbxk4tUpOEiqQmYLopekXS8LG4wQfjk6FsgGin30SxDE7XTpdL2kQ3mmIt3D9d+QWKXStv9nyMzRzm2r4cORHJqRXr2GTofKKqN0d5i+AEDWoiiPsnEqR1HuycaZ8i1CwIakEGP8Cf9aS+xgrjD/5z+D8M4SVoUlqOK5cabsFca++o5Uxqb0L4rA0uG1lGwibKIcKZFTDuilKfc68WKvHjG0hqE+5ONd11OkW6BH4/vKUzYIOZMUcZNmmjc9yoEFXF9p6SeB8WZ2v3tJqHEDCTYUB6adIjBPCxp6NdWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c014a083-2de1-4ced-de6d-08d616f8d003
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:38:41.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to replace kvm_flush_remote_tlbs() with kvm_flush_
remote_tlbs_with_address() in some functions without logic change.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c         | 34 +++++++++++++++++++++++-----------
 arch/x86/kvm/paging_tmpl.h |  9 +++++++--
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8cf47befc0f2..0ee310bad2c6 100644
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
+			sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level) - 1);
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
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, gfn);
=20
 	return 0;
 }
@@ -1956,7 +1960,8 @@ static void rmap_recycle(struct kvm_vcpu *vcpu, u64 *=
spte, gfn_t gfn)
 	rmap_head =3D gfn_to_rmap(vcpu->kvm, gfn, sp);
=20
 	kvm_unmap_rmapp(vcpu->kvm, rmap_head, NULL, gfn, sp->role.level, 0);
-	kvm_flush_remote_tlbs(vcpu->kvm);
+	kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level) - 1);
 }
=20
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
@@ -2472,7 +2477,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct k=
vm_vcpu *vcpu,
 		account_shadowed(vcpu->kvm, sp);
 		if (level =3D=3D PT_PAGE_TABLE_LEVEL &&
 		      rmap_write_protect(vcpu, gfn))
-			kvm_flush_remote_tlbs(vcpu->kvm);
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, gfn);
=20
 		if (level > PT_PAGE_TABLE_LEVEL && need_sync)
 			flush |=3D kvm_sync_pages(vcpu, gfn, &invalid_list);
@@ -2592,7 +2597,8 @@ static void validate_direct_spte(struct kvm_vcpu *vcp=
u, u64 *sptep,
 			return;
=20
 		drop_parent_pte(child, sptep);
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn,
+				child->gfn);
 	}
 }
=20
@@ -3016,8 +3022,10 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *=
sptep, unsigned pte_access,
 			ret =3D RET_PF_EMULATE;
 		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	}
+
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH || flush)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+				gfn + KVM_PAGES_PER_HPAGE(level) - 1);
=20
 	if (unlikely(is_mmio_spte(*sptep)))
 		ret =3D RET_PF_EMULATE;
@@ -5626,7 +5634,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm=
,
 	 * on PT_WRITABLE_MASK anymore.
 	 */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+			memslot->base_gfn + memslot->npages - 1);
 }
=20
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
@@ -5690,7 +5699,8 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	 * dirty_bitmap.
 	 */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+			memslot->base_gfn + memslot->npages - 1);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_leaf_clear_dirty);
=20
@@ -5708,7 +5718,8 @@ void kvm_mmu_slot_largepage_remove_write_access(struc=
t kvm *kvm,
 	lockdep_assert_held(&kvm->slots_lock);
=20
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+			memslot->base_gfn + memslot->npages - 1);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_largepage_remove_write_access);
=20
@@ -5725,7 +5736,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
=20
 	/* see kvm_mmu_slot_leaf_clear_dirty */
 	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+			memslot->base_gfn + memslot->npages - 1);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_set_dirty);
=20
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 14ffd973df54..f45f1a5fbfe8 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -892,8 +892,13 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t=
 gva, hpa_t root_hpa)
 			pte_gpa =3D FNAME(get_level1_sp_gpa)(sp);
 			pte_gpa +=3D (sptep - sp->spt) * sizeof(pt_element_t);
=20
-			if (mmu_page_zap_pte(vcpu->kvm, sp, sptep))
-				kvm_flush_remote_tlbs(vcpu->kvm);
+			if (mmu_page_zap_pte(vcpu->kvm, sp, sptep)) {
+				u64 gfn_end =3D sp->gfn +
+					KVM_PAGES_PER_HPAGE(sp->role.level) - 1;
+
+				kvm_flush_remote_tlbs_with_address(vcpu->kvm,
+					sp->gfn, gfn_end);
+			}
=20
 			if (!rmap_can_add(vcpu))
 				break;
--=20
2.14.4
