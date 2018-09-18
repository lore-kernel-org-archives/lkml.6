Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E1ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DD8214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l6dRX2uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DD8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeIRIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:48:58 -0400
Received: from mail-sg2apc01on0128.outbound.protection.outlook.com ([104.47.125.128]:36634
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbeIRIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrCCzTSKTjSLohhy1cGoqzeZNco8LG9h282SGyt/Orc=;
 b=l6dRX2ujGUMWpanJrVwu1CAZEYUlcqSQndYFqStAGCtSVmoSS1ianDTYx8UgEzfcPxE5xH8kWe94OR4Z7v+V2ZEWY+F2qvSazOgaKY9aEMBzh0cvDNTYNslLtp6kllGEL7TH11tWPSOhs6v5GwPOzWTsSXtNL7FwvoJ9ox3OyZs=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:23 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:23 +0000
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
Subject: [PATCH V2 2/13] KVM/MMU: Add tlb flush with range helper function
Thread-Topic: [PATCH V2 2/13] KVM/MMU: Add tlb flush with range helper
 function
Thread-Index: AQHUTv5BJRJv8ZvwJUKcRzk5V3vi1w==
Date:   Tue, 18 Sep 2018 03:18:23 +0000
Message-ID: <20180918031754.113013-3-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:yvFjr4xSbuXRqGOQqvDROn6b8kDRiArw2nXOW0yD2uQgipPai7PY8D4gAEW5HSxfqTYD7loGtOpwbqo+HohYkpUUaKQsbXrFYwU6/XSCtnWeEz0BXNTcdcMb4IUdCLRh/iZNJpQadBnJYfQwBtxtTEYolxg9oeIdQzGatEjk4lk2yHYMFDdQEfPhclWCGMwwKBLa72mie1C3w16R4RC7P0oQCHY5g6tsbpAgO4WPHPo6vMvIzWzIL5XsqG1hwqSV9MAFfU54ZBehw05OqXtJ2Y482Iga6pOpSK0gcBq0Gd5LfHKz77Y3VqHFaQW8iwYLilRW01gWnsFrwlauZglJf0kANTeokrV2mWcbQkYWKEKWddyErqWt8BcTzMP9ICfxQlIRHkno37sNOUXY6Az8PkINe5X3ak71O3zdzJhwm5aAiik3a+yRtDOJFk698T2In4/hUJrS12QIX3tn2JuvXQ==;5:BOGa7WiQykJyxCRY7G0Gwn8J3/HIf5I2oJN4+Io7Gq9lkGFJWxrPdgI2ryFYUwI3q6mY9Hb7dIO6orbAu6Eu61RyDDoXj/aglxRFcU/GMtg9gCzsuJ2XNxeywWYwkCGIC/9+qdPbFPqwltAWLZrFcCGpnWLGYfCmWL5HluyE2uc=;7:5WoCUOGfILRhmX9P4/+RrcLrkl9yfxcEWJw9V7DeoHqcx9M1REmnV8GqZT44nmfboUFyMBd0lCGwWkgTfg/07+UCxaaE0yddbCurKwTmJp8uYBYOHXwXHwmI1qDmwacK+zKQVfxYdmYAFSlI4Eosb7YM4gvPQ2dW/UUVpDkEhO9aRFdsXtuGMN4oDVJnu2PdFkIL+8kDBG6QaDQ4yLyBXiT7tjO8/CZ1pYI73Bj27Yk7H+Et0vjP169NwqoOBpGb
x-ms-office365-filtering-correlation-id: 917c83ac-92ff-4366-d112-08d61d1564a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01800C3A526ADACC19DEDF36921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(14444005)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HQVb6NuszfuIzYJVC2mDYMZ7WpEVyiqnVN403OjqAhoPnHlpvPe8T2Yz21SO1TsiSXTO+ZDYusTeicMsFIHcaowi/nFHIICwp0CVV0863B496a1qhNoXmenO60/NOFi8p9TLxvm9AC4nt4H/roA1FKEG8aDrrpQ7JZJIcKX1bbjsi2s4vU2SFPPiQV/jdVSTkwNYLoCRVe5ZH85yd9GkR/+HGmZomrgZiK8cSlqmFiDjK1Z11trXkG/KkNeub031Oelm/0I7sYfHFI6M04cC52dv2ew3BmOgae+8pe73avogkksHuYcI3UsofUxxKkf1/LHHWGxTBBLdt7ikTPJcUPe8Y8z1Z/8CXlBeUiuA6Zc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917c83ac-92ff-4366-d112-08d61d1564a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:23.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
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
index c67f09086378..ac3b748f58f8 100644
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
