Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CBECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60EF21473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H6tNYQWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60EF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeIRItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:06 -0400
Received: from mail-sg2apc01on0114.outbound.protection.outlook.com ([104.47.125.114]:34840
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbeIRItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLPTbSTW8/9yHw7svnw2v5SB09+LrVHG+bpFeLM9mmA=;
 b=H6tNYQWDua8ZqrE37Bg3Sd+1U0swrgrXTrrNmMETPBvaATmX9Tb8ypD74AQysxqOQAY9HD5anXD5bzNMFKAnRtHBbjAa70efc9GkD266TVvCqickJpbXzUF8Bwmqsnu+ZK2gkIpktz/n06mBcGpfq6BI1IZCGRDp4j4WoePLsac=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:30 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:30 +0000
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
Subject: [PATCH V2 3/13] KVM: Replace old tlb flush function with new one to
 flush a specified range.
Thread-Topic: [PATCH V2 3/13] KVM: Replace old tlb flush function with new one
 to flush a specified range.
Thread-Index: AQHUTv5FKmWdVZ1KR0anaBCeU4uAzg==
Date:   Tue, 18 Sep 2018 03:18:29 +0000
Message-ID: <20180918031754.113013-4-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:vPEkpejAytdZRoVFDp87PaHfFEPizQhwy0lS5DiTcbEJjKyHCB6v1tRdtgN3ESnvQSmF5BWyYnk7/GCuMjQ9WOcpZKY3ECbbJvBZxuaTXGjPjJvDIuMGAvVSXmAWHXD1XHc6r4mAKYCkPJoRRHR02O8vK7igIKmoynEjnK4PFCvJNubJdCwIN+jyTRwfx79eAClhLU5ak3uiZfBxd5c2K3Lqu5aFRSykjb+8GlR5mV61NRZHYlNZka/+8xZMX0ybaswIMp3qGxUG2e+6Kdt0xtHExuuBB7FZkQiCX6s2WT4Cn3GhtWkS245P7NVWK9erpeZnPDb9H8lllBlCjgiBp/k/jfNPdoM3vl/0nfxRwYEa906yPSDBlV6ikJI9CfsrALFmMmJQsDtm4S3uk/5Ex3Q5cT7hB7sKpRJlBmRMsl4ESet+45x3ZM7rErfrZMR7BPOci3LPSHRfPclkVh4Lvg==;5:hXwOli0lgSkzVsjRSPe7raxKQBfs7PZrFaTSgtHmrByjrZNox5z8g65R2iIxpVPxFY0wP5vU6Ui0bvoCTTmAfo/ypm7PCm6RXqaWpxQaSC6Kx/Od/YqINLlcUoAcM15ZcM2oH4B72cFcgC5ubgQc2iAAaGtyAf6pYQrijW+MrGE=;7:h4fImxgZ1iViWEqxU9AxROGuv/JazFzr0TodUCof/WY8UbJ1a0eaB/q1KctKpdkq2mG+c8VBD5V4d5Gkh5Pctg1YiQ9hwb3GS6ciOFUs9AHqYcwUwUPuHLc+dYOFojRD9sY4fRadmColhLDaYf//VrpX9kp/DDvpWVRlui7GgK1eGWAgKi3O7M/ltqnBYegPy1I1X0Wz+WK+LGKJdNwOMEleodV54hj1rNqvHez9C7WQqPMV01ZQWzYikF9Mz3QU
x-ms-office365-filtering-correlation-id: 8bc5b595-65e9-46fa-1a4b-08d61d156875
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0180C3332ED22556A6238486921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(14444005)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DlUOaYrLrm2i/rfiCqj9JYozvJNSA4YwosMqjze+g18pCkH5vE3nz693IVwrku3BHAyoR3bUVMhBv/J1WqmYxGcEtI2P4JKuSaDzWMmRrSTjjvWHzbO/p2BkdNYDJw6LSqOma/CS4idnYZFAOweBgfQB4DTLR0wYg2xLOOvtceigzKMO6fc3Cdx/mCJkZPIncJe/etFY1nBMNdCd9jZ6Zwnw440NAbblvKCemqQgbyOq8b5ajUSF6mvdnWfCF5tEHBMNX/QeD4XBsPMTqsKeM8Wlyw3lASMM9kquEUT5ymsNWDewvO62G31OcwpYK2ocId3ajv1R4X3R0zmwt0U7JaJXgaD814YkxlRHNzrG26A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5b595-65e9-46fa-1a4b-08d61d156875
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:29.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
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
index ac3b748f58f8..822e170881a4 100644
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
