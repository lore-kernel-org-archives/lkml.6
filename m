Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD80C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1284204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OC8hMGR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1284204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeIJNb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:31:58 -0400
Received: from mail-sg2apc01on0122.outbound.protection.outlook.com ([104.47.125.122]:19143
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeIJNb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5qv5cnQtCDMeHy5kGtsApVVQJj6IVTP3stNxTAsRnY=;
 b=OC8hMGR/mBXctwSQuCf6NTmM07N/1Ebu0VAEuBQOWnebxHPCawyPtwhtbkotMO8kb4sGROchiNVjB1Qo+M+KsxsRjfEN8tKBcUt+ckNnaA6REXfOW+oHWRoUjT+tUpDmK1LMxwvpAxmMj4ZIeUAgQCOsz4taqfh0r0z8/uUXUpE=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0097.APCP153.PROD.OUTLOOK.COM (52.133.156.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Mon, 10 Sep 2018 08:38:54 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:38:54 +0000
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
Subject: [PATCH 5/13] KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
Thread-Topic: [PATCH 5/13] KVM/MMU: Flush tlb directly in the
 kvm_zap_gfn_range()
Thread-Index: AQHUSOG1FUu8HVgvhk2kMtmOqearVg==
Date:   Mon, 10 Sep 2018 08:38:54 +0000
Message-ID: <20180910083806.65177-6-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0097;6:YlEXgPZD/zqNlVK25ca/ORdr9yUEoZAx15QcAnaSA3mOTiBlA6wKfVlFmwZHVHeKSBVQkj29djNLFwtPwlfWaxV5r/+z/ruwcISytimHRQixRxO2ykG2qxjmE47XPItJZVYYJamH9SUlPdZDQrjSxUXzdchTrXrgZdFFLKN1pU3LswWHgvxmCScHPiZ+iyL00puGLb9mSjOe5zB4w5ixW5RzcGDJfxJX18shyF7S5rG1x+QvKBxPeEFG32DyH7kmQIy46hH9VA10zGf2cW4pKmSubUUPuR2Uk8UqmC9Z3Pu3PTuXssXQ3AdVTtFdwQwoCR4Ug8Xo9rT5MiSsmn4mv89V3IomayAntiEScDuusQeCKpVwi0Y6iU45wgFzHNelsMrFLMIK79ZWwZQMEvHg8LbKrm2gp1XVF3VcgwMnn3d8aPVNCWdrO/wrE0mKVmMwlA1OstJ/Qx2EdgymqGTq5g==;5:OufsM921ZgCl5NgmTARGv1lT5fbZlopcnEI/AEIo65PJDlZTlxiEt31wt9yfaceptEuHDijGkFgFYnVZkMxSsRHSpe3TY2Qy8NypayIhTniEUCVCKNiEK1rnNJ8N5h91skMmEuJhqOxwStOk8hZHZo1CJADxsJzyNj4eU2XTQqQ=;7:wnisSJdcRGUZk7pjIbMSwqbv2DqaNEjr2TFPyIs2vfO+i0FmRlSLSA7rrrPUbRe+CNWUuOyq+PLaK4kuM8Yi6WgFgwcwMzoOxdJ2gbkGAbwNySDuAotE7EZ1GgSEBeYw+XCHPcybGYZn5EgLRsgFdWYHPv/1E8H7jR8I4a3Yytvgsn5yuGm29vE40NSnPI2T4EjBTr2C3LBalWhLUws5DBi7kAP+G9ar+Nm3muOuNaDunlOAAoHy99hbyiOxosX7
x-ms-office365-filtering-correlation-id: 6a495857-12c5-4018-ec92-08d616f8d7e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0097;
x-ms-traffictypediagnostic: HK0P153MB0097:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB00978ABE0A486CF7C8423C5992050@HK0P153MB0097.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0097;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0097;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(4326008)(68736007)(107886003)(109986005)(25786009)(81166006)(8936002)(81156014)(8676002)(86612001)(86362001)(102836004)(22452003)(26005)(2906002)(6506007)(53936002)(1076002)(10090500001)(97736004)(575784001)(5250100002)(6512007)(6436002)(256004)(6486002)(2900100001)(14444005)(14454004)(10290500003)(99286004)(446003)(2616005)(11346002)(478600001)(76176011)(476003)(316002)(36756003)(54906003)(6116002)(486006)(106356001)(105586002)(3846002)(1671002)(305945005)(7416002)(7736002)(59246006)(72206003)(66066001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0097;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sqRgCPn5LH951cTCs9ANTbH2jUvaUXV9fW7lI89ZJUTtcgcqWEB3WTH5ty0QTwo83mKXiN6ZjqKzdSODs3d9fwX2kGKd5+57OMPf7ZUbpIZMnjIlzJls/WKjUc3nISVTa+90UJgL0+GqLtt66fYn/tHpuGlGNODFdATcFfcnV8k1BW8aH8cKZTkkzt/BslyYTVo2eUP9hyipM5nHk22jp/vykqFlAMcAO9HQN3asNm1KgIE0GouHzML+OPyppixFqSD0bke0AFSj/JcAdFMBOzx+c4rgk7EJ0aY+Tw+INfCbVMC1SYMxvnucirDMjdy18vDde1vNqxvwXpDOZVmoy5qAYfqAcQiqWGEfHge7Ltg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a495857-12c5-4018-ec92-08d616f8d7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:38:54.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0097
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
 arch/x86/kvm/mmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cadb6a0b5247..9ae5887c8d1c 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5583,6 +5583,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_sta=
rt, gfn_t gfn_end)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	bool flush =3D false;
 	int i;
=20
 	spin_lock(&kvm->mmu_lock);
@@ -5590,18 +5591,26 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_s=
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
+		kvm_flush_remote_tlbs_with_address(kvm, gfn_start, gfn_end);
+
 	spin_unlock(&kvm->mmu_lock);
 }
=20
--=20
2.14.4
