Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0151DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B50204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ICpJY7Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B50204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIJNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:19 -0400
Received: from mail-pu1apc01on0137.outbound.protection.outlook.com ([104.47.126.137]:7968
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728188AbeIJNcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrqirFxiag+wAWlhcMkuXw0H1kMaTdCAkUrqwnHmQiA=;
 b=ICpJY7MxxYU4nAoWNAAbGnWOwQQMie1Wmr/+FinKh2CZsgDhOn9+OyvdjZ+AKcYv0uFDLegCYPwtzsTeI+gqgIA42LXQ67H5XwhsIh+Cml2v33YFMWKtXNtDYlg4r19N3DjWhjrS+dcrKMxQyuPT4wQ8/VgMbsifERR8feNwGNI=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:39:15 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:15 +0000
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
Subject: [PATCH 8/13] KVM: Add spte's point in the struct kvm_mmu_page
Thread-Topic: [PATCH 8/13] KVM: Add spte's point in the struct kvm_mmu_page
Thread-Index: AQHUSOHB8Si8ewIbrE6dBzLK5kakQQ==
Date:   Mon, 10 Sep 2018 08:39:14 +0000
Message-ID: <20180910083806.65177-9-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:y26+GutfCCwNkZOUGdARbQbDSb0jTyRP/L62dlXPBVbyVFEqZc6iCAH7QCO2T3kNUNZuUA4poySUOJKApjKRW6HGuKTEnzi4bX+OQhHpvitbtzABrpIIWD7qZ6htre65vs9zaA2CihVxscVy1fNWUzOYhQySMKa/67FPA67to2BvQ02yun9UKl2COeFdfw5IA1dDQLQqQtzfzcX2nFOXDjzpmrXz3ESiyYyAbNwuWMCXGP4ktBQihmk8C6zOd0yKabvGwcAB3q3F8zz6aGNd/XS0NuGz9vHMLV+exzREyIc0/U1F6KJSgUsPT5javOEcid0DEv6gmLPXKb0bsBjZsNOHRy0jxs23MHl2EsL+RhPjJ5uvu7xbsQ/k4tbHYxhVikvK2FoYtTiBfTXx/fKo5aprCFzGZbRnp7RCGzz5pknOP1SNImJoQMZ851VKeyeXB7e4YgAyo++faKN3B34/7Q==;5:gP5Qn8niHFKDetvKk9sfivRMx1PHOJYFWwVt1HPH9C1s0B7Gm/F8+cunxFx0tiuOPi3Dd0AKNF+1/CHtw7w5r5I9A33fl4jnzkEk59pQA0njIIA/dg7wsvkYKt1NNVtjnQrVd9tt9lR9cbMG/IhJ516vpISv+FDuoOjGVMoByrg=;7:FuN9RESrTBoVe/cA9J4dfEMj11jgI31vRTRql86tBn9qAt1Fz0tRHMZJSRMRmw2724R9w/47bb8fVd9yXomKz/eESygpstdVPgg/SscpowpiHwiCtIQa+uB9Cyvndh5jCQ+db07fWQTvZh7qKPMN7EFvytqDDk3UMx7ePMMxDGf+cWewuoh6/Hr4s6wzMyElpUAQpqecATUxGkZBQXD4lHLcyEx8VDFGP/ZgHHLN58s2xPvlPuM2+FYdATt5SGsG
x-ms-office365-filtering-correlation-id: a03932e3-f979-4bc6-2f05-08d616f8e3e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01782A4BA44C4189DF77820D92050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(7416002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8C732zD6WIajG9sVYG4UZah1N3kl61/BUp9xksoYgzvgN7zebVWSzhFdj+xVRdUuGunXsev/Gu83k4Q2/aBuJjBEwHXcf5Kl8OEgi49wBoXAUrd22lQ/JQI0VRnVXKua8BY4kjQ1drcoczRXUTmXSBubyLtxvdoH/v/8FdB+zfVJOkQlbLjh1Zf7PZjieHm2tRxC2u0Hg5Dx+QJKxggV75U9Dt+sW85Qmv6XiSgGtMlG7ShsmYnxh/cMWKglp6bYTJKjJgQPYnev5dLD6i3PcALzKn8cNUAY5tX5EL6s6XQ5Tg0ejB7iW2+cOCVgVEVkj+8w4qP4/W0WLb425WB2R6nC7pp2BLPF0wijQkZ7yAg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03932e3-f979-4bc6-2f05-08d616f8e3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:14.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
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
index acdad302612a..03c7290f4187 100644
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
index 167ecfbab9bd..73e19ce589e7 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3167,6 +3167,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int wr=
ite, int map_writable,
 			pseudo_gfn =3D base_addr >> PAGE_SHIFT;
 			sp =3D kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			sp->sptep =3D iterator.sptep;
=20
 			link_shadow_page(vcpu, iterator.sptep, sp);
 		}
@@ -3604,6 +3605,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vc=
pu)
 		sp =3D kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu.shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu.root_hpa =3D __pa(sp->spt);
 	} else if (vcpu->arch.mmu.shadow_root_level =3D=3D PT32E_ROOT_LEVEL) {
@@ -3620,6 +3622,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vc=
pu)
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
 			root =3D __pa(sp->spt);
 			++sp->root_count;
+			sp->sptep =3D NULL;
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu.pae_root[i] =3D root | PT_PRESENT_MASK;
 		}
@@ -3660,6 +3663,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vc=
pu)
 				vcpu->arch.mmu.shadow_root_level, 0, ACC_ALL);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu.root_hpa =3D root;
 		return 0;
@@ -3697,6 +3701,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vc=
pu)
 				      0, ACC_ALL);
 		root =3D __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep =3D NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
=20
 		vcpu->arch.mmu.pae_root[i] =3D root | pm_mask;
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index f45f1a5fbfe8..bb8c2cdf70c3 100644
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
