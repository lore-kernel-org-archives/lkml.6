Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF60620854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GI5Mj9ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF60620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeGIJC7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:02:59 -0400
Received: from mail-sg2apc01on0137.outbound.protection.outlook.com ([104.47.125.137]:59859
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753970AbeGIJCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwHaPkH7el7XOGgSXlQy7tL7FKYMGQBpusQKwZUgNnw=;
 b=GI5Mj9ij7i9uwdR3aOxvE0FsBsuUr6LpSQRlL4uZeC8oZG7K2xXTWXZSeAw2CGGLVplcH0hPSKX2o7Zp/Y3OrLjfTRjEa9ahRjV4vkpo9MTBu/buRTctySAx1EU9e2utXGwjy+YK/4QgEQNvCHPxJctOIzUyRDlKDNCRpVVVM8U=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.15; Mon, 9 Jul 2018 09:02:48 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 09:02:48 +0000
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V2 3/5] KVM/VMX: Add identical ept table pointer check
Thread-Topic: [PATCH V2 3/5] KVM/VMX: Add identical ept table pointer check
Thread-Index: AQHUF2ObcQUYklsGuUOa1wlPU7D6rA==
Date:   Mon, 9 Jul 2018 09:02:47 +0000
Message-ID: <20180709090218.15342-4-Tianyu.Lan@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;7:bzD9pOurnguN7aZMjMelRc08L/xszlZwaHyRZGdcEnsNsZbvr1ENACgXdW70Zcag4XDvmEmr4m4ErMgMpvWrsu1OTAlvTKmc/1d314hL3hRU8NccQkWpzGMq8h/Hk0gPzDx9JJ88Z5iWaPsqvlbT3Sl4r6kCERAJPu+F/4K5KU+OoldotfIezTa2Fo5+5F6bFaJkh1AuywdfgZ94lO8Ehg+mO4+6NHDUY3SsqfXFrUvnhNYemUnqwegef+O2VySq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e0986a3-9b72-45c2-c40a-08d5e57abe27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB00630964165EBAE6377010AB92440@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(256004)(14444005)(105586002)(76176011)(86362001)(6486002)(72206003)(66066001)(59246006)(86612001)(6512007)(97736004)(6436002)(2616005)(476003)(8936002)(486006)(14454004)(446003)(11346002)(7416002)(81156014)(81166006)(8676002)(4326008)(109986005)(68736007)(25786009)(2900100001)(106356001)(6116002)(3846002)(1076002)(36756003)(5660300001)(53936002)(305945005)(7736002)(1671002)(5250100002)(54906003)(99286004)(26005)(102836004)(22452003)(10090500001)(10290500003)(2906002)(478600001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yw1w/fCoW5bjd8KMLVie2xUvWJ9+ckBKY+Qon3G5j/0xZ9pcY3Zbv7lcSI6FlEPM9tStLllrQl2+c6uaiNqfauf2W4bRNiAYp8vQSDJRDJGgiC4T4fOCU9vmMiUfo+lpGZDJHDktGK6Ylu6G38U3gmlmpR8OvTUqTwtBEKg3FAMl3aURlWiGukKf+Q/AxIZ4bN/acOagIDKN1izCsdWhRjj74WDNKo3Wo3CphX/IJxOTeOAtHHAyD/UfuDJimEG+07XLE54JzIK/85GZlK3aD6jl9Ot2YnDdabO+W5EdX3yv3Thtb6om6X6sbCHGaifVVBd+soQkZlzF4rMk6PiHO4MWOUJk8HqwtUZEdJZquDA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0986a3-9b72-45c2-c40a-08d5e57abe27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 09:02:47.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to check ept table pointer of each cpus when set ept
tables and store identical ept table pointer if all ept table pointers
of single VM are same. This is for support of para-virt ept flush
hypercall.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Replace identical_ept_pointer with ept_pointers_match and
check kvm_x86_ops->tlb_remote_flush in check_ept_pointer().
---
 arch/x86/kvm/vmx.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 1689f433f3a0..8142b2da430a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -194,6 +194,9 @@ struct kvm_vmx {
 	unsigned int tss_addr;
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
+
+	bool ept_pointers_match;
+	spinlock_t ept_pointer_lock;
 };
=20
 #define NR_AUTOLOAD_MSRS 8
@@ -853,6 +856,7 @@ struct vcpu_vmx {
 	 */
 	u64 msr_ia32_feature_control;
 	u64 msr_ia32_feature_control_valid_bits;
+	u64 ept_pointer;
 };
=20
 enum segment_cache_field {
@@ -4958,6 +4962,32 @@ static u64 construct_eptp(struct kvm_vcpu *vcpu, uns=
igned long root_hpa)
 	return eptp;
 }
=20
+static void check_ept_pointer(struct kvm_vcpu *vcpu, u64 eptp)
+{
+	struct kvm *kvm =3D vcpu->kvm;
+	u64 tmp_eptp =3D INVALID_PAGE;
+	int i;
+
+	if (!kvm_x86_ops->tlb_remote_flush)
+		return;
+
+	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+	to_vmx(vcpu)->ept_pointer =3D eptp;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!VALID_PAGE(tmp_eptp)) {
+			tmp_eptp =3D to_vmx(vcpu)->ept_pointer;
+		} else if (tmp_eptp !=3D to_vmx(vcpu)->ept_pointer) {
+			to_kvm_vmx(kvm)->ept_pointers_match =3D false;
+			spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+			return;
+		}
+	}
+
+	to_kvm_vmx(kvm)->ept_pointers_match =3D true;
+	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+}
+
 static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	unsigned long guest_cr3;
@@ -4967,6 +4997,8 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsign=
ed long cr3)
 	if (enable_ept) {
 		eptp =3D construct_eptp(vcpu, cr3);
 		vmcs_write64(EPT_POINTER, eptp);
+		check_ept_pointer(vcpu, eptp);
+
 		if (enable_unrestricted_guest || is_paging(vcpu) ||
 		    is_guest_mode(vcpu))
 			guest_cr3 =3D kvm_read_cr3(vcpu);
@@ -10383,6 +10415,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm =
*kvm, unsigned int id)
=20
 static int vmx_vm_init(struct kvm *kvm)
 {
+	spin_lock_init(&to_kvm_vmx(kvm)->ept_pointer_lock);
+
 	if (!ple_gap)
 		kvm->arch.pause_in_guest =3D true;
 	return 0;
--=20
2.14.3
