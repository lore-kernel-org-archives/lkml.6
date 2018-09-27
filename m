Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC96F2157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lB7MYjpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC96F2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeI0KFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:42 -0400
Received: from mail-pu1apc01on0101.outbound.protection.outlook.com ([104.47.126.101]:1824
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbeI0KFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITeNmZ2OeAYXISjDP21AamkLIxyv/H1LSW12H1wkMm0=;
 b=lB7MYjplgzd1YghEZ6/yyixzy/AZ3OxCYNCFm4Cgm+Gn5K2BTWUBSH5B9hiW+5bhS/STDiyBGbpQYWzIwOZGxE4CbDPH7X9j6sVMEh2qBfxS2bzh0xfBMEd1pDsoNueKk/awTK7FOylmvXul9boIDWMKvhNzUUI+XZoWzrvIir0=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:48:58 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:48:58 +0000
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
Subject: [PATCH V3 2/13] KVM/MMU: Add tlb flush with range helper function
Thread-Topic: [PATCH V3 2/13] KVM/MMU: Add tlb flush with range helper
 function
Thread-Index: AQHUVhUECOP6CEvTFUiTgVF4Ld5WEg==
Date:   Thu, 27 Sep 2018 03:48:57 +0000
Message-ID: <20180927034829.2230-3-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:Cc57CzojYgjqKU9jmUrPoTUmypImZXEvM2gO+vcM1CQWEo11P5aVr4GeN03TOQxjF4yM/fokC36uAmABPSdaTmV1Vve/1gVkK/3j+oTrPiAFR7ZnFrsASCQA3aa07SwlFAz1jed9tW0lqhatLurNFYHHcsbxkQYMUBEkCmaHoT4zm1CRWvb2yx5MM9ZX8i9dlG0yOb0WHvv0oLTMsgK8+jCLtKb35unrv1GtJnHz26jpGZuu5gWSP/QQTjLj61qoGAq58yuHF2pTd2iGr9C1P47Qes2ycaa064YL61Hnj/o5KS1ltE98oNHNow2DcBD54zWR6lokbI7PKIS/pJ3gIkSoowK2Qv4KIiaeh5uwCzLN/ZOo97J1evfQnWoIrCceWgBjr68QMTYznlqpTk2fu0No4mMkp7inmQkxWakEM6KDBlSpi674VSd+QHB85+Bjg1ylITAD+XLkoalxFLTHxQ==;5:kMIfo2IFiYMHw1CHetcvm3Gd9oYnZHRJflvnzh928aMm/Bf4rgKNkviHPmToGnWOUY3sFjTXWc7Wkmb8O5rflzFujIR3HyiRpM4upEoJwhPwZynL6OxRPHQImLn6eQ7n0aWcJ3ta1b/xpEJEe8JFlZrvDJeICWKqoieZk+WUOJo=;7:BNHblD2iK2aGvGkRcy9RH/xNnveSeihL+JNwcBkjaULHSdUyOXVTpWk28O0e2jO01D4gKv+SGajj+kwVA9uaIr2zfJ4LEuya2BcLE0dRT+G4Xcei4eV1EHGM+6cpTUJIPm6OBHWvGrNPSrE8Hn3obBwv2EpKQYK94s4NvUjlob/B5qv95WwUorwTnfAmyHn7I4nVfDPYye+qkKy2CBGQr3Fs5gQH+Phy4dkvTgkfHBOKrb+Yc5PSTxbC7QlQON4k
x-ms-office365-filtering-correlation-id: 29d2bb23-8ccf-497b-ef15-08d6242c27aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01770DAF408D7540E5F426BF92140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DAyRJhjct2E3yeZJKUDoAOG08ceKoTzFV6PxY7njN8dVS0Iywtvq/73beJBr/eIct1smymTWMnp5jQCwKFoE9KvQHp/UYQ5Ap5omtNQD2jZIcMV9pfiYRQDUNu3t7OX2TVc0e34RjPH/aa2qdRLQfFuakPKx7iODWAG2wpng6Xoa8CJtwroB5Auk7GCgYqNnx23P3+mjt3amnQVzm7bJB8UJ3+8zBpXcNaIg9TKsxlzA6BJ/hQQ/u7ndOlMn9L0SdA0rplS+HOqcW7sX28RS13EMo5pAZitP42ePTElX5d6hHC5sWut227RBa+YpfX+erNWv3AM6wWhgB4ehS9jFCYztwTkoD8hGY+skpUg6rOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d2bb23-8ccf-497b-ef15-08d6242c27aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:48:57.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add wrapper functions for tlb_remote_flush_with_range
callback.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since V2:
       Fix comment in the kvm_flush_remote_tlbs_with_range()
---
 arch/x86/kvm/mmu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c67f09086378..18cac661a41a 100644
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
+		 * Read tlbs_dirty before flushing tlbs in order
+		 * to track dirty tlbs during flushing.
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
+		u64 start_gfn, u64 pages)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn =3D start_gfn;
+	range.pages =3D pages;
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
