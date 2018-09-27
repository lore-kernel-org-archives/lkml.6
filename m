Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C48C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EDD21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m0HVR14u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EDD21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeI0KFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:55 -0400
Received: from mail-pu1apc01on0101.outbound.protection.outlook.com ([104.47.126.101]:1824
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbeI0KFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H40/HFw3vu8Pdb2jXrnCfeniIcjdRmxM0jghpD1REZs=;
 b=m0HVR14uniNiP1LwIFOq7e310DwCR/oEl4xr9Qu/mlVySl4d7sdCxpWpVgm/ZJXWv+cngZh+3jt2NFd6ppq0NLkCIn0WTxnq6HVOJHtuLLNtuR+14TV+tcHw9FWoQaNyyK01Bnqq3m4CrKu1R8jgS/RlkgSD9YBuw6Px5xec5Rc=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:36 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:36 +0000
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
Subject: [PATCH V3 8/13] KVM: Add spte's point in the struct kvm_mmu_page
Thread-Topic: [PATCH V3 8/13] KVM: Add spte's point in the struct kvm_mmu_page
Thread-Index: AQHUVhUbLQO4yITFBU68l8RtowtXyA==
Date:   Thu, 27 Sep 2018 03:49:36 +0000
Message-ID: <20180927034829.2230-9-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:5WzOFRmpqwwxhRS7unzrP8OIEyvzRJnoPBQwgsT01kB1IcXC8Xt4UCCngEZQrh39eR7B800gNfcrPJbzmdQL30O9Dcv4smm2N2GAlWwdS7QUtSubGby7tVSiRnpJjCPsv5XbHcSSUp5SsFX2Q9tLfMCYtYgsK5fWNLh8D2Ej8CiwFffGgxJclTnsGpG0Xgbo+7jXFLxBIHOiiFBS92/9LP+kaua1c9QW++adkZ1j673i84WkB3lroG8XrlQstDtHlVOBypcN4eku5RsIsVReKSqtYTB4L4pFeieMTM0Ps0YMhVLLzxpQcTnPzvIyTjOqGowzvwvRIsFFKpxzVMzzxRJMUVQiK5oE5Zg12Maa/MsByT4Ni/pmTdbkhQBbVK8Jm6AV6zCjuyLf7pJ5H1QFsnJmXzruqPygp/pDPOpxV9nrmjUN+kQG9Tp4F3WsHg8IZlS0uzzxJYGgagQfwJji7Q==;5:g3+li2QVw1M5X1Kb4GundmP7Pwt8oM1cSI/U/v1uGqUgfe8SpNVtgz3d0DZSxzw5uqaEoPtb1wT4bXHSRLFAVXOWzJ73+fyZvg2gJ0NfqLGEgA7Jy5hRwlHHBjnK1g8M2ID3MATXlzAhayq3I1WMZ5izWQp4J6Z6SebsVwsX/Rc=;7:q73XiYoiFif4kiLVElvLRe2Arsn6XIF/asCttJUgLJzH88KT42+y8HwB5eiuvDrEw8A5u4GWQ51j3qKLREFIOwqIKgTPqtqKdag4Gh8epxxlii1H9lCg5bk/uebcqRE+Lizt0DoKKxwElAr7aLuFAuIc0BirVOUdR6oAucw6bVy2E8YlTKfP+5PUFBqBwMzEnacfZHVNC5wvGvnVZJvnnv6xbqsDK/LGmmqb25i5ndVmdXn4se6A3zxmwhv7U7Nf
x-ms-office365-filtering-correlation-id: ab13eca7-55be-46c8-f271-08d6242c3ea0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0177285A9B71A078A2B728FA92140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WdzYamWbKoApDkEKnvARSaiu9y3aFLvFgTIjSzahTY5PExWt16ZoTbjkwYtyhWm1XdBr9IJPybw6NXyOpR7dr0T7N9JKTrKSFecF5Go2mMdT4tHtbPoQ2vcXMnHaNcrkjkXvgr0aHPqmtSA6VNsgoolAuDEAfUBlxg+IME5ykI/ryOiDMXE2+1JiTHJ3kW9oy3wM2rSAK4S+X3RqxS0gv7tHnoMVxyqdOtBPwYCwvdWQW2pW1smRbyrJ5grKd8C0pcK5ng15E6xH6x9TFs7PXZ3mp2awK2e0kQ40RaoYYYNLbZJTV9s6wQWgeyD2Kt4qTtK4DdhKez5b4kuCRxAa8Xy+i4svgXVZLHRBRzzoTQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab13eca7-55be-46c8-f271-08d6242c3ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:36.3307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's necessary to check whether mmu page is last or large page when add
mmu page into flush list. "spte" is needed for such check and so add
spte point in the struct kvm_mmu_page.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 5 +++++
 arch/x86/kvm/paging_tmpl.h      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index c96bc4cbe4b7..d42d96e637b5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -296,6 +296,7 @@ struct kvm_mmu_page {
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
+	u64 *sptep;
=20
 	/* The page is obsolete if mmu_valid_gen !=3D kvm->arch.mmu_valid_gen.  *=
/
 	unsigned long mmu_valid_gen;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7c508c4bd204..a1cbbc852271 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3162,6 +3162,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int wr=
ite, int map_writable,
 			pseudo_gfn =3D base_addr >> PAGE_SHIFT;
 			sp =3D kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			sp->sptep =3D iterator.sptep;
=20
 			link_shadow_page(vcpu, iterator.sptep, sp);
 		}
@@ -3599,6 +3600,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vc=
pu)
 		sp =3D kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu.shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu.root_hpa =3D __pa(sp->spt);
 	} else if (vcpu->arch.mmu.shadow_root_level =3D=3D PT32E_ROOT_LEVEL) {
@@ -3615,6 +3617,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vc=
pu)
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
 			root =3D __pa(sp->spt);
 			++sp->root_count;
+			sp->sptep =3D NULL;
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu.pae_root[i] =3D root | PT_PRESENT_MASK;
 		}
@@ -3655,6 +3658,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vc=
pu)
 				vcpu->arch.mmu.shadow_root_level, 0, ACC_ALL);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu.root_hpa =3D root;
 		return 0;
@@ -3692,6 +3696,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vc=
pu)
 				      0, ACC_ALL);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
=20
 		vcpu->arch.mmu.pae_root[i] =3D root | pm_mask;
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 708a5e44861a..5cbaf7c4a729 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -632,6 +632,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t ad=
dr,
 			table_gfn =3D gw->table_gfn[it.level - 2];
 			sp =3D kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
+			sp->sptep =3D it.sptep;
 		}
=20
 		/*
@@ -662,6 +663,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t ad=
dr,
=20
 		sp =3D kvm_mmu_get_page(vcpu, direct_gfn, addr, it.level-1,
 				      true, direct_access);
+		sp->sptep =3D it.sptep;
 		link_shadow_page(vcpu, it.sptep, sp);
 	}
=20
--=20
2.14.4
