Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8ACECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nu1hy2RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6F221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeIRItS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:18 -0400
Received: from mail-sg2apc01on0113.outbound.protection.outlook.com ([104.47.125.113]:2560
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729164AbeIRItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Q935IKhGzOug1WFH//rGmpajoWJYb89PUWEIn9i1c=;
 b=nu1hy2RJmACUNMVKb0vpbdbmpAcg2U9OCV+z48yWuv0kdbL1c0fBwOMyDq91IWnBrBINkrAgNwEn85P3M3IAiQUtnyOp55NIfyGXoxqtSkex7ErgchcLnnYEl82GBLK+tsTYcvYpCJXGoNXVrxLNnis/5pZgGEWn7Gx5LoDw5jU=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:43 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:43 +0000
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
Subject: [PATCH V2 5/13] KVM/MMU: Flush tlb directly in the
 kvm_zap_gfn_range()
Thread-Topic: [PATCH V2 5/13] KVM/MMU: Flush tlb directly in the
 kvm_zap_gfn_range()
Thread-Index: AQHUTv5NmHeozUNkoUy20Y293SWjhQ==
Date:   Tue, 18 Sep 2018 03:18:42 +0000
Message-ID: <20180918031754.113013-6-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:aHe831mWm9+BjJKZG1R3GbMSVrqTFjbU3vz6wlLco9ptv9iBp+mpPp6ILZSwkUY090GISFjw18yJnqo4+r3JEtLt8wX2Kfj71V6OqWwKIeZYarZVf/Hzl0pujVaN4B+7O5uoyIDDbQUAHlXuORjphZAfWT5nzkIhocM4outzL9wEGNA/eGAGswzN1+NSMxcCiFIkAv2hTlfh4Zfdtyd5ff+R4Ts+mY01CQgp2YJK5WQHs/pk8IdQXn/J3V7Q5dB6/6bdwYNb+nBfMqDgJudrn9N4GPZo03xx1m2fqepcU15hRYEzYczX+BB1C+tsB8Ykp1am+SGXTF4GHMBV5N07H/e8OWVvmPR+E4/ic0txe4k+qlznd1OumwbqljeBJlF8tr2clwQEjZs6fTVyMuH9AdMcGfCEFyANOL2o7m0zLxHJ7PBvNUMRfM3xmlX2djN/bzpK7VFWkXNmKGxkVoS5rg==;5:G10AJB8EmfpRbEztUdZuq9DQTaMfY9kosHRK6ng+qGCmAf5MFbaUSve8rF9Ido1evFp3UjOMfdodo+ThjKjgps/+9dKST2gq7xYMHVnirWAaPlu7fsQOuv2beUwrPvTw0lL0nxIbFgiHxBBjILL1+Mj0iop84lu6DZvyjW5LjyI=;7:mFaI5x6Ltqtezcxh2ESKk0Ap4VKWzq460Q17kN8/SERZ2WDTC7t5wXNx5vOgJ+VQ7lC1J8Duwkwk7B/51GBDoA8sc0pcWLTpYj34ZXX9eNre2+x7xWS6geCt5BOnc2lywV/Wn4K7ZNphtxbm07GSiu90q5XJ/8TDEQ+uOuZRkOc3SU4udkKsBodMZNCVcB9KyQ3Nylmk/3se+EKHutO41/Ng9nv/fw4712sXyVjQGbPRPk1DJ74voUh904Wsxu/H
x-ms-office365-filtering-correlation-id: a2c43930-c377-4ee0-2cdf-08d61d157029
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0180A2BEA04A860A24F53F5C921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(14444005)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9TfBSbyW1fPtd4OoM1RtbhegD0p375UzmPZCb6mZYxsUe20STt+NDqBAyXG3anMZ/TEeP7ULyFhT5uNw+Mxsyqj319fMEb/26zWKCBu/iRIJ1VT0UGov5UHRJCngLNpbO71HB/pJSlZrAfs0aJdqINdOrrP50wsll0Dz3PIbhoij7u/VKK7venu+N0a7uUpvpoCg/W/IluIialt7/lBpEgaT4XfuNLdKM6SoiV4uJZWH6iqtwrQKKX+LE+X5o4hVSGQo4NN0m+Ikf0VwW85toRW6bdX0miWNpslfDTrBaG74gMKnUtvyXb6l3stHqh70gJEGSD8PIj7ZPjdFJGdn+6CB9JJsf8zsKg3Lz7p6+Ws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c43930-c377-4ee0-2cdf-08d61d157029
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:42.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
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
index dfd2a0710417..56538fa6c017 100644
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
