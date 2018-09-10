Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D58F204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V2MtxN2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIJNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:31:39 -0400
Received: from mail-pu1apc01on0093.outbound.protection.outlook.com ([104.47.126.93]:39059
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbeIJNbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aZePpMCmRkHxNuRGgWw7YGCmy+g8i7o5JGeZIJR208=;
 b=V2MtxN2f5kidymhi3OgY+gHLzLS62Q2ql2B4fJdbEKZOA6f5RnYwV5hA6hsvlq+exlMY6mRwOv7PkVy5a64DpOhk2QIAPXIBCBPKA+5PSNEdRFEJlZnmXROCGP9tdXPlcQvXhamjMyCsHPC3X2r9C7kk0RCwifXD7eDH/vnHYJ0=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:38:35 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:38:35 +0000
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
Subject: [PATCH 2/13] KVM/MMU: Add tlb flush with range helper function
Thread-Topic: [PATCH 2/13] KVM/MMU: Add tlb flush with range helper function
Thread-Index: AQHUSOGp1mkUH3BCxUmkFlpzOr/89A==
Date:   Mon, 10 Sep 2018 08:38:34 +0000
Message-ID: <20180910083806.65177-3-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:NYXemNpXTUCRC1GNpWHX9giPyl82arjP/UdIJC6orQKVO2hdYPnAqlg6nw+KaBVrsY9TuX/5vxmYTGsyEDnnLbJhHxxwIhNSkMiOEIjWUqsBUMqfYn8Js6rr8sjNo/aCDEGZ2UbcHGDY0fkluLxUm7krLhXQpldPt6nx+cxly4ah/ta0eMS/y91kXyW/OQ3PvNUYxf2jWjU8CD/4o9e40SDOOS0T8v90OE+8OaFr2IzFVvf/S4uGMjCTIyu6Z7BZfp5LDtc+MIgXsXde/cTPAyhJB8TC6g6Y+GYIRGJ0uq2QsKglS3A4RSZM+OFlfwICB3CNF9fuB2gDHpPMVxC/aZl16P8g3N2zz/TZxwo2E7XV9p2Ux94ZRP9FSYZ/D2fS/8aLluDpA+Q0Qk2nX+umSpwlFchSW1ZRYUIIKh4zIYX+fAeJqcjWe+K5zuNRYH/8VYRFYp6SAaMmtuMyWjrytA==;5:rhOVjH/6Ng5cZv5T6YuC/OVoEW6EeasDpn6dwTm62efakVMHhS9OYTzNjGXZXsh6pYtOJ/1d3ryzP44I2AbJDOrmN3hL0MzWH4fEtlALX2GYGdEc2bWku+/dLCVOttECKfq/ZjcI38IcgB6iIuzU7KAqjfwd9851TUnpxvH6OKQ=;7:hIgjJn3uyZeF/tcy6rltOv8E5eiBLVpkZMCxT1cBHnnzkEE8Lv8v4cLV6D4astE2DB4mFZbmRl4IpJGunqN05wZnQ+Xrare3QwZ4rEez3u0G+Po9P+a3pPahUX2Z1Jra5cZz+2qTemJkkQtf0zhHbWY/b2keHsERG6Q/mZlr+PMLtSZ9q8V9JEBeHa+4qO1Q0+34QF2AQ3/TY5+9DSIaFEGiXKfESAS+ooiUV4Yygy1BXG/yLYv+Fckb37jyqwE5
x-ms-office365-filtering-correlation-id: ddfe2481-1ec3-49e5-09f0-08d616f8cc0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01781F9E8D2E1884B10F4AD292050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(7416002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u8zKVDwugr1X9IKuIaUc6EnuZQcpOOALjBkcyL2lqznkQvC1XrpV5zhaqRw7o0r9F6zvatz/ONhnDwb5M0LNEx7EP/L8TqOZxEhaLzYXDsjh0GUBAURGS4uxIs4fmEd1Np3AXxkmbCaimzuiARW5oTE6GKTZyZwDgveJeJ/onlw2eKscruuyTLVJtj5eZMh2Q5J80ULitoRHFZVqhvCAtFXEfMFoVkCdbHVClw2IdZbe6bSh+0VAcNSFrJF28M3JSwLb2UL29Y6WbLVQae3u194JaFD6rQa7UJljLQFCQCsJDOLlL0LjTZ+kABXH+sFfd0WSCkljQysbGIhw406D9XWKp37+bqkqd/s/esVJEyU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfe2481-1ec3-49e5-09f0-08d616f8cc0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:38:34.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add wrapper functions for tlb_remote_flush_with_range
callback.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 456d4d0f7eb7..8cf47befc0f2 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -253,6 +253,54 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
=20
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
+
+static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
+{
+	int ret =3D -ENOTSUPP;
+
+	if (range && kvm_x86_ops->tlb_remote_flush_with_range) {
+		/*
+		 * Read tlbs_dirty before setting KVM_REQ_TLB_FLUSH in
+		 * kvm_make_all_cpus_request.
+		 */
+		long dirty_count =3D smp_load_acquire(&kvm->tlbs_dirty);
+
+		ret =3D kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+		cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
+	}
+
+	if (ret)
+		kvm_flush_remote_tlbs(kvm);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list =3D flush_list;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+		u64 start_gfn, u64 end_gfn)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn =3D start_gfn;
+	range.end_gfn =3D end_gfn;
+	range.flush_list =3D NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
 {
 	BUG_ON((mmio_mask & mmio_value) !=3D mmio_value);
--=20
2.14.4
