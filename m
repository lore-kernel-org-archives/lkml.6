Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DF5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587272157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bDQkhJsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587272157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeI0KFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:45 -0400
Received: from mail-pu1apc01on0133.outbound.protection.outlook.com ([104.47.126.133]:32445
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbeI0KFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlIm/wQ/SZgqpyNhzLcWF/CMv40EdanX/aX8d6oGa0o=;
 b=bDQkhJsTzoFuzlicChmgYbpdkapKnp0LKemI5sw4gUtUlXBKg3NtE77sfX4zBPYVltbDIspLIS66+iK1iuBGrvMduzohXRHtkjHOTorQcmrqgItDac33Qqne4almGqyHqqWBjthpNmfY7JX9dD2Q7Fe3b66T0ycTBS99UwaGdwg=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:17 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:17 +0000
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
Subject: [PATCH V3 5/13] KVM/MMU: Flush tlb directly in the
 kvm_zap_gfn_range()
Thread-Topic: [PATCH V3 5/13] KVM/MMU: Flush tlb directly in the
 kvm_zap_gfn_range()
Thread-Index: AQHUVhUQ4M/Jq/VbY0i+60xtcKOfTg==
Date:   Thu, 27 Sep 2018 03:49:17 +0000
Message-ID: <20180927034829.2230-6-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:rWbq5efMtsiRlaaGjYV+IWq5JEcU2r5TDD+CC9qGtGTicHN0ujPVn7pyB2zNlIkWPGkAs5sQ6Fdv2yCFnF1HsS4T4g3bhB7pb2waeqJ3KPlvH9kIbDDIyK3oyhPcFDgscA2MhBS7+ztVaka+RVrWWmbznw60CXb6S0ZBhxq6CiWLN/TUXxu2JY9rm/JCfccDOKKNF0mI6zL7hcLN/f+8E52Y17CNiiXoznJ3DcKAOujI1FyDViuBS3ZPg95RuY9EKKKp0GlJmZtr2fbkstvDz+UII/9zjrF4OAGWpq/0YMNwF80+d7b8d2jXCUqK6KsKW4qtbODSD9WMn9L6hkcNit32RKs+fFTxtbAyElciHaejquINWIITms+0KRpuqUByw+O0XGjE+W2bX+NBHLa5xVpr7On5pzqZARBB7/2qz8/Ry470fBc/LQH7PQjNPnt8szbUe5UPAZtdtdfY0YSWcg==;5:6XeysVQgstTUFukl8vVtYxIr4GVtNzkbop3r933SWwWb7VkYM9GxDseqE9C0oYrxcRvQmtPE50KapNZYYzRueAbtFLdbDPgeb2D2tEIHy68xP/p1NTe7jM4J5fqefJP5L8rhQT/J+N2s+4jqk7TZ/LcWQKht9z7okUxuZYdYG6A=;7:nClr6GexManXUbzaXPl0fDW6KnrHsdRs5FvXSrQIVmToQ1NTeu7lY45nY2Q9UQN/IDvjJ6Z1EendETYRQlu1LM1hTA7b8BxSOwSyHNEMpd5dDoscN5SjknTF6+8+K9RX8dbwUF2+TVrHUkxgfaN3jt9NnkaSga1iQ63g4GmkFv8IdqXYZTrS0BfkfzdLYYfup7590tacg6dMutldTUk3LshEOE1QSOMqgFDuysQsSSLP+R/fj8jnfNCgwmrJ4rPN
x-ms-office365-filtering-correlation-id: 411a4aa2-e235-439b-eb1a-08d6242c3328
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0177DB03AB08748A94663EBA92140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NdD8alzHxOwrXplu1B31Oetso6lISqac5Q5FRxthh2eRoIvcaHqcU6rjexWG+PqCO0wPI8kD9iLxSlYwsuoq/imPrHkXudGXa14Lf0WltqHS6U13GyswDH/uBg9K3WMSxnE879yg2LWQg1PN2m1DGPZdCfAiUUG25/eVWOcIo8Xe3UHvJqCtY8R1vvvZTeqBEGWt9kq/e3f+sUTp98uzQ7VOKxJJU03nUrKoPVIADX8SM0YMSwIj7D+8sGbNF88gYyGquL4f67AfsvjjwmdVxPomauITvskb4D2+aBXJoeOeztBsPzWfKqLjWWj7Kj4p3aSTDWYZfqlnXghKUuxFxJNisvdFafF1Bp1wpLAymSg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411a4aa2-e235-439b-eb1a-08d6242c3328
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:17.1311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, flush tlb is done by slot_handle_level_range(). This patch
is to flush tlb directly in the kvm_zap_gfn_range() when range
flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 877edae0401f..f24101ef763e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5578,6 +5578,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_sta=
rt, gfn_t gfn_end)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	bool flush =3D false;
 	int i;
=20
 	spin_lock(&kvm->mmu_lock);
@@ -5585,18 +5586,27 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_s=
tart, gfn_t gfn_end)
 		slots =3D __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(memslot, slots) {
 			gfn_t start, end;
+			bool flush_tlb =3D true;
=20
 			start =3D max(gfn_start, memslot->base_gfn);
 			end =3D min(gfn_end, memslot->base_gfn + memslot->npages);
 			if (start >=3D end)
 				continue;
=20
-			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
-						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+			if (kvm_available_flush_tlb_with_range())
+				flush_tlb =3D false;
+
+			flush =3D slot_handle_level_range(kvm, memslot,
+					kvm_zap_rmapp, PT_PAGE_TABLE_LEVEL,
+					PT_MAX_HUGEPAGE_LEVEL, start,
+					end - 1, flush_tlb);
 		}
 	}
=20
+	if (flush && kvm_available_flush_tlb_with_range())
+		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
+				gfn_end - gfn_start + 1);
+
 	spin_unlock(&kvm->mmu_lock);
 }
=20
--=20
2.14.4
