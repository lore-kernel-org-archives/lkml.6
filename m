Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06489204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EKF0UsnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06489204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeIJNc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:27 -0400
Received: from mail-pu1apc01on0106.outbound.protection.outlook.com ([104.47.126.106]:19124
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbeIJNc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlCMoqUN3Fg8KeJQAoC1yE2dFIwS/tond5n3Mr5yzbs=;
 b=EKF0UsnOscjjR7/xw9BnJOL1olsqeQg5/4nUj8hW7ksgjZmROmQfzCaG5V/9wZ5Cplcwtafv8EAUHMfKizWKjP2tx6I/mzi+zvF+5eebUzvq5tieWvoJXcnTnLdrJxDawOtPZBUGKQ734CofiDJvc/AqdEesqq6vXE2xq6gvnEU=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:39:21 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:21 +0000
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
Subject: [PATCH 9/13] KVM/MMU: Replace tlb flush function with range list
 flush function
Thread-Topic: [PATCH 9/13] KVM/MMU: Replace tlb flush function with range list
 flush function
Thread-Index: AQHUSOHF1cM0JIDZzUSWG5gMNx949Q==
Date:   Mon, 10 Sep 2018 08:39:21 +0000
Message-ID: <20180910083806.65177-10-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:9/49qBsoHQUS/23Cr8l6QkkXhY8COtFSh585sTUlSkabrL2eFax3IMzJGl/KX87GEc9BpQktYANlOB/frxAGZCZ8PDaZqO6OM7ohU5lnx6rJUy4QHU6L/HgrSQCdRT6pHCtp7OQ4XfRqRU15LgULVzIzou7ke/PUYKIigGTtyWhbjSlwatH/MJ+bqV5+zgp1r6n0Qy0ZO/YbRZDwOlSJUtFLCe848zpv+31h1AIuN5GNnmso1lAvYiWIeq3qxkU5281CyG0n0y5O4N22+RvBy4aimopwRHgvD4o4n7tCD5+HKAG6EMAlj62DvkJ6muLliKPnlMy48EiKjLDRclkrRjZYXNoTU6YjARKWM2AaCSaaaVA7QHceQK+e28R2dF+EwI1GXh5ReWjStup5Pr1KA5v7CUVee2s0DcKjVrFAldNDs96+tXCnmg6xdUXdHmbWd9/0XaXp4slGShmo/76aVA==;5:pDSdIsCgrKqLc4/nLBahsLm9jYEyGEFm6uQEW1u7dc2Z3H6iQkhIQnzh832mnifGYWOlwiLo8RXHsJY8XC9fM9c8aJ923DqMHHw0Jr1poxCq4Ad62iSmCcje/2coekfwVFhuQ3was8GYhs90rIvVSTUMP4Typ7qMZMJ8P+ntkNE=;7:MeGtjmFtvetJNUMcJc/AQSQgwwFmf90AnnVuUWP9DZHJmVXZzamtnFY9+NX1/r4t9GOF2oEhnPwhxBlj0s/o0Ofzvfk2/hzTkGthb6jZwMzABHPPJCyWwr+KIQKAZHcYG8tZ7n/wBSH538rNRccSFxIpVh5GwHtBGKZQZaPMJr4Qt+tGB98o4/p8lGaLaav4+npL0WuBKH9Y2YOpiFWvNCklzslCq4Qr8WWLgtca61ChsOikDAzsiBjpzVBlKNl3
x-ms-office365-filtering-correlation-id: 93cf1580-a617-476a-945f-08d616f8e7e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01787128A0DAD6D3792720CE92050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(7416002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4OkXb+q06uybzr7m/BkDkj05HXBrcYvQw3j/4cdl+6JT+dBvmCBXntGAKlwo/DFsJxTLn51LG1Zn1zA9FuFymtV4Pt5jdTcI2op5DAO0uPZ79Xml5aJGBRWDtUwcULl5sMGpfN1jT1Q/6GX2JgufkCmRfK0xglYwx+IaHonsSV57JDGdXtCip6dJtXgfIsYaXD1zN7ZxtYYfhTCgUGeNzeWT026swxAL0glnPw63lCs7IVhk9gefYJKde2UG5wUjoyb0BShDdM8wASoyPCWk9c1/3jh/1Tax354BPnyWX5GK/pbcPTjEOnKUIdNt2ES7yyf9KpAW9eEgC3MqzP9w1aFafn+SqmC4O9ZQ1T8cWhw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cf1580-a617-476a-945f-08d616f8e7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:21.3268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
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
index 73e19ce589e7..a071da797a15 100644
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
@@ -2373,12 +2380,16 @@ static void mmu_sync_children(struct kvm_vcpu *vcpu=
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
@@ -2715,6 +2726,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	LIST_HEAD(flush_list);
=20
 	if (list_empty(invalid_list))
 		return;
@@ -2728,7 +2740,15 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
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
index bb8c2cdf70c3..aa450e0596a4 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -976,6 +976,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, stru=
ct kvm_mmu_page *sp)
 	bool host_writable;
 	gpa_t first_pte_gpa;
 	int set_spte_ret =3D 0;
+	LIST_HEAD(flush_list);
=20
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -1036,10 +1037,12 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, =
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
