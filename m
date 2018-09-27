Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A5C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97F421533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O8qUVHUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97F421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeI0KF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:57 -0400
Received: from mail-pu1apc01on0133.outbound.protection.outlook.com ([104.47.126.133]:32445
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeI0KFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd31W+43aHjGiHfnHpwobWKTcStJuSTL6af8Tz8kShY=;
 b=O8qUVHUsYFjNOp8Qw4L1/atDpKftWEIb0LG05Ewfn2LA4F+3gdcaMjAcU8qkS0KJwsCmk3IYLdT+1H1jfqQBTANUpJPnpFXdU3lFSIAwNfBNA7Znv8jkLk8/J6ZU5/Gpfxw8AbJT5/Bk6qKtmBL94GRELl+lNXI/WyfbNJd8QYs=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:43 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:43 +0000
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
Subject: [PATCH V3 9/13] KVM/MMU: Replace tlb flush function with range list
 flush function
Thread-Topic: [PATCH V3 9/13] KVM/MMU: Replace tlb flush function with range
 list flush function
Thread-Index: AQHUVhUfIriDu01PxkmHiJNy81f9Uw==
Date:   Thu, 27 Sep 2018 03:49:42 +0000
Message-ID: <20180927034829.2230-10-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:fgZnPHlwSySoNQJYxS/xJYCE/WzyQswAGb6G+a1pGCHMoD9V42bQv/YvUuJBPyb9iolonmPOSvJ1ClWr4K6ZTAE+JX93Bh2ZVjNrO/ZynDC0w2yi2n43gNvmXKX1qCIIEDjbqyENYfpQnFNRh+kTFzBw0dWPBB6NaQMPQRco6kTjYIOR+0QZQRiSnCIYqD/zR9NBqCI9kSXoeismbtkmyrgwSquzdyHW0r1SuaXyrBZ2iceh3MRp1H4g82Fz2mTBEvRO3KorMeIf2AYHk4dedtjA4FKQ+PJ0Z3Hzbn0jdAn688fwDlJkrh4KWzmHv1d4pwU/E04yyWMVzOTpi4sG8aE5YSXVW1DpqLJnUbF3DkH2iiNqVBRa2nGeAMn7rLUeGY+Po3BWGThZpxLp7aAMK5Ae0viXk5MIW30cEC+76DLs+QhbxUZjJiNrbj9AEDo81yINzf4Y6+ZLH9r1wzYmyg==;5:VqlmSy35uk8qMHm2C7CyhLQ9bOtXkVcP6EIJWRy+e9DIL2I4NPcPienOKECVZimUv0QzjI9q3t73zc/6pZyYGatIhgHV+wQWX20ySoXsqIUlWj8qdclmO1L837Px83rcqYUmdT+X+UjcnevDU7Fp1aULIqKZLine8BFyuJB7PQA=;7:mm6VR2BgDiqBPO94VSr27ptTKv5xTgANfLTTiuXZSXZQE57deCiZTXrMngvkuFkvvN8HIczoQv4zDdhqHPBpc0EAg/5UGZVK3DnD9lqtcw/9N8duaEn/FNcA3oP8wDnj2OgOfYKiXeiGW3/BNQz+nMa6uTD7kGxegbZCLUOwhPznp2UO/IqgyWXL66Eidimyd7844Rsy2fx9xldiJJAtestATrwdRWQ7A1X/bnbhVGtBgKVeqIG/vqh8J6rneZ4W
x-ms-office365-filtering-correlation-id: 2f2b93dd-90fc-42db-d83a-08d6242c4263
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0177E594CD309D0A46BA960892140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(788757137089)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9tACQ0AwKBG1RTa+tQplWJ2zvg99STphXs+fNheE+akkUKUC8Qy0LyNcC2yEpb10Z02jS0Wi87JdbgBSFUiP/egcjLj9N988TO5fIamZPO8Ck6tDL0AM4nkZye/uEVKdDFe3CzewLvNmnuy5i99YCuOIfTJVSBedre2ciMe9iHS+z6KO3B8txNmtNH4igt/ZNhpwZlLKhW5HsLvsQL28ZlcwBxBipGn7u+yLQ9FlTJp3/eJAuSQ8G7UfotZJmjy4oKDaQbzqZS459oMxvBZM4H17WjScRwf1qegGo6HI5KVV9JStro/jDbDlIRKGZsgdpeB/duhTgAP17OFudozUieO2/TczsL7kpNPv2L43KZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2b93dd-90fc-42db-d83a-08d6242c4263
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:42.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
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
index a1cbbc852271..5f3a69425142 100644
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
