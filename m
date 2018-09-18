Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3AECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9839821473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iSpp0AUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9839821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeIRIto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:44 -0400
Received: from mail-sg2apc01on0099.outbound.protection.outlook.com ([104.47.125.99]:64384
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729423AbeIRIto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kmv8OvPaim2lfAazx49HhV8tDVf9WqFEVAbmq3XPkg=;
 b=iSpp0AUmXUeaqOSO0LF/xEgZWvNv/9R38C5yP4HTNPwAwL2ykr/1dyebwmpsgfCfG/TxqR7l148lSoVhxGCJZVCQx/kiSQlo8c1TRBGsHti9hO7FwShlZzO0paTj/28hC1jSl4Vw5zHHoK6/9/LBTtbms/A8fuROYIrMuTv+HxI=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:19:09 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:19:09 +0000
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
Subject: [PATCH V2 9/13] KVM/MMU: Replace tlb flush function with range list
 flush function
Thread-Topic: [PATCH V2 9/13] KVM/MMU: Replace tlb flush function with range
 list flush function
Thread-Index: AQHUTv5cEo2SxfeiQk22R5/nK31APg==
Date:   Tue, 18 Sep 2018 03:19:08 +0000
Message-ID: <20180918031754.113013-10-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:FeeYfVrj4JYbzNrPd6pOoysMkHuFbwrxkPBQGDyH6yKi0i/Gqn8yQoj83Hu8ZFUARNqgQZCz6Gs67corq+Sf23wbvqgqFdYWxg/M6rpzsSc1W8LinKiCPtn1xR/LrkM7DeLTXHdH2hnm7ObDsiNJTT2ng7z57n16P5ELDNy4kOMqbJDTjZvz3q+ZkqsHFr/InCUPhuZ5OTW6aG2VNHuyZ+fXTlzyVwigchoBDZqqtHILRQwZsT+a8DKYjNKMorza/6SdZXoKePG+3WgbE1TCWoKkkBqcAJoLg1SgXr9mg4YQpx3pPvVBam/xMtP5bpL5jJmAV6FTfLG6ntalu9IBrJhFfJkV/F2jjtEdzbmea3SSeoRUv+oTd7YWF88BgRBJW3WRrVxlgbb+Brx7PbId0yP7xYYZcI7XES+AaXkukfKQwnVBYkHwp3sppX4QKWMxz74/pRL+V6HcCp+gWYXOqA==;5:9KxN8xZ4DWsJPuHUAt+C1lcGcWAknq9TpRYzKwLLf9dl95E/KE6lRdkp9uozX+aXQLYc5EKgYS/Rq2Z5vxgoxqNSF52lJbdC08ktzruXekvlnjUEI5CIWnKLMmmrBPLfmefhYbC8ew37OR0lPd7mStYWRnyXMZY+Qr7gxxWp3NA=;7:URQm2m9wm+MeTSEc2r4XAQUGAXOySAr/lUasYCpC30IKiqwxVUhl+FFfcFaLWvaa28Rzpf+94s0bGXgBXCuOiJUpTBikYx77Quzn17Z/NKP0Q/ifctYszIAPkfSDc8rnqgwDN2ypTVD8vE4EfKnn61Rs1GEshTWzs2iEsVqgqp1KVjN8lcMMJpHcVVvnizUs/5A4395TU+RQaan+pi2WMXOFJCmcKcUxp14Rok0v4+uSQmytQPDin9rsLdcojWBs
x-ms-office365-filtering-correlation-id: 862b444e-490a-4771-befb-08d61d157f81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0180EB35A8EDA5F8D175DACE921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(14444005)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7PGCyjB9waDTEEks9ds2CuUNBSvefMUTHUZg3lGuuayGrYlJZx20H0cq9Su2tgQ6gkDzQWyZI6RyjM6uy7ZUAiQv1MlhbsapIhmW6dnXLoQi7RVfpGfA5nep/wzqknR3sGieP0j9b4ed8bhQonUrISwk2y4R0vNBW5/T1pmdw46lseF4O4NMTp00gi3638WyGDNWqkxZWF4Mc6ZDVfRRdiMgMfAq1RhegkqwMCObpJellsrJhKIb2ss5RNh9pEBKtm+qQ/gmUfzTZ4HNUsvvpFj3lWFqiVXECv2vi/SA3lwmAYg+WyqJxcWqMFc1Nf8APMuPH5Et/iNR6lm/6YAhUJS+/xeXmkOcs845CvrEQxg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862b444e-490a-4771-befb-08d61d157f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:19:08.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to use range list flush function in the
mmu_sync_children(), kvm_mmu_commit_zap_page() and
FNAME(sync_page)().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c         | 26 +++++++++++++++++++++++---
 arch/x86/kvm/paging_tmpl.h |  5 ++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8f27cb8c3989..0390e67715ee 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1092,6 +1092,13 @@ static void update_gfn_disallow_lpage_count(struct k=
vm_memory_slot *slot,
 	}
 }
=20
+static void kvm_mmu_queue_flush_request(struct kvm_mmu_page *sp,
+		struct list_head *flush_list)
+{
+	if (sp->sptep && is_last_spte(*sp->sptep, sp->role.level))
+		list_add(&sp->flush_link, flush_list);
+}
+
 void kvm_mmu_gfn_disallow_lpage(struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	update_gfn_disallow_lpage_count(slot, gfn, 1);
@@ -2369,12 +2376,16 @@ static void mmu_sync_children(struct kvm_vcpu *vcpu=
,
=20
 	while (mmu_unsync_walk(parent, &pages)) {
 		bool protected =3D false;
+		LIST_HEAD(flush_list);
=20
-		for_each_sp(pages, sp, parents, i)
+		for_each_sp(pages, sp, parents, i) {
 			protected |=3D rmap_write_protect(vcpu, sp->gfn);
+			kvm_mmu_queue_flush_request(sp, &flush_list);
+		}
=20
 		if (protected) {
-			kvm_flush_remote_tlbs(vcpu->kvm);
+			kvm_flush_remote_tlbs_with_list(vcpu->kvm,
+					&flush_list);
 			flush =3D false;
 		}
=20
@@ -2710,6 +2721,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	LIST_HEAD(flush_list);
=20
 	if (list_empty(invalid_list))
 		return;
@@ -2723,7 +2735,15 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			kvm_mmu_queue_flush_request(sp, &flush_list);
+
+		if (!list_empty(&flush_list))
+			kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
=20
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 5cbaf7c4a729..a5f967e81429 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -972,6 +972,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, stru=
ct kvm_mmu_page *sp)
 	bool host_writable;
 	gpa_t first_pte_gpa;
 	int set_spte_ret =3D 0;
+	LIST_HEAD(flush_list);
=20
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -1032,10 +1033,12 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, =
struct kvm_mmu_page *sp)
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+		if (set_spte_ret && kvm_available_flush_tlb_with_range())
+			kvm_mmu_queue_flush_request(sp, &flush_list);
 	}
=20
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
=20
 	return nr_present;
 }
--=20
2.14.4
