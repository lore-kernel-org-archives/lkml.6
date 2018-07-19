Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17504C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1C920856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AUk1+gdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1C920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGSJWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:22:39 -0400
Received: from mail-hk2apc01on0092.outbound.protection.outlook.com ([104.47.124.92]:26688
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeGSJWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5VjDG7UrMqHuqNAjbC5KvsNFMYMMvCWEJzMCcvlnY=;
 b=AUk1+gdG/afMSjAiPLIgKDWdXMCUE7BmP3oA93fs09gUGxGrAMvDCam3B8dysVyKKkQPq6Z1vcrAmPar2djZXurnIdtnGLMzxkRaNRsi9AHFzi6tHGBNKgulbZ9o0Xdo6Z7AFltvqKWWLMYJtvKabB+pd8gbhq84WPgjQn24IiE=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 08:40:23 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 08:40:23 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V3 4/4] KVM/x86: Add tlb_remote_flush callback support for vmx
Thread-Topic: [PATCH V3 4/4] KVM/x86: Add tlb_remote_flush callback support
 for vmx
Thread-Index: AQHUHzwiWAHtUUQv9UaN/Uhiep3foA==
Date:   Thu, 19 Jul 2018 08:40:23 +0000
Message-ID: <20180719083946.121493-5-Tianyu.Lan@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;6:W42OD/f2Vq7S3cbuOPn0YOovQ5TrHfPc1CFfXl3+UFbRRPgz8oN1kryeytogg1Lh0xAU0VWjq6Vooyr05fpXcUOIAoOABN1Bj5z5tk1Nrfmw8RStJpm9uTNTDFXtDHpm0X6ASsPE0kpVaZykn9LYUGPbEht5v/aKQt9Bu19Db8yPCyqOmTQhxX7N6xEmvRrm3WQSmXoYSGC3N23tED2qrhOkV02moushqYokJNBU7g8q7Shb6LwUmAzX/0kD7SRqW+8567C/+GXfILN9oD3wjA0jShuId3Nurfqkfz8uBY9lLXC1eC5ByBacusZy8Qvc4RJfbnDmkZnMh9wX5d32AA2hWkU/Y25F9+jauMnpcepr7RwcD38sgvvJrC5AYG1bza+Xshoen9Dmp9N0ijERCByzKxz6D5oAbLNhtuBdCPuv7Koq8mfx0SAmxOr2y+uKoSLPxSDQVpyukvdT+faosw==;5:YEEb+qjPrPKxboo7TRc4libKr6dBrQ6L9VbMSlr+4YBDX/4G/fhOZ3/mHrAHsy7WwX69gsEryIF9GbABaWSYlXrt2UH1A7HFsRv8aKcvisr/ubHiDCpAxnr67MCKJsQUxB+nkfpknoy8UGuaC8L4mXWzTfU23YZ1C3hOWSHJ304=;7:HjBJ2IpgtGwrg7oBj+ULmFB9JYK1BNfxhqMJTC1F0qCvXHK14INiMXs2FobJPvQQv7/u2dpp4KlSWojR8t/OKdg3WCHS7Pu7a+ZH22I20JJHdsZ48vqMw4HHPfAYzfbEAjS9E9KoiUsKjm7auplHgx08vfz5uuydqzAxctHmkjbRoJiV1b0P3j/bWlUGIAQOCAmayUUuYy5QKgCFtS8tu54z0CcX75eOtjr+Ad/0vRcKDxm+3JCvHbbhl0E23NO3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1bf8a343-090d-413b-3663-08d5ed5344ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB0063C4D21C598B2B1A77A80F92520@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(396003)(376002)(189003)(199004)(26005)(6486002)(22452003)(6436002)(7736002)(2906002)(66066001)(14444005)(109986005)(11346002)(256004)(59246006)(102836004)(97736004)(54906003)(6506007)(86362001)(86612001)(6512007)(68736007)(446003)(53936002)(5660300001)(305945005)(5250100002)(486006)(36756003)(2616005)(25786009)(1671002)(476003)(76176011)(81166006)(10290500003)(8676002)(4326008)(1076002)(81156014)(72206003)(478600001)(8936002)(316002)(2900100001)(6116002)(3846002)(99286004)(106356001)(105586002)(14454004)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pP0OwKVmady+HZXGEowAoRagozkHNXYG8CuVzWslFUAc3LK5tgJVhNKkQYauT7zDaDS7KbHPAmzADvTWbiYVHZ7+uhYSnP8xmrsJBQbwdAaw3mCge7LzKjN+Olzk+RCL3uQJGnRthx6+gjIP42o60OOEeUDUx6vuUvAE+naolkl1WDoX2PI1/0tlvkQrAQYr+k4/1vByItamCminLdJp9Efn/TD84ds+/Jps+Q8uemIXioR7PgRe/Eua3ebG3L3X0gSRetw+OtiYEEVTSc+Fr6bEo4pdEjdAjflv0I1v+wcmFXbcRNgYmKBClyyEOTbPGmaY0A5eE7s+xctHpim3lke0CC8AvjYckwPC4jdS67g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf8a343-090d-413b-3663-08d5ed5344ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 08:40:23.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register tlb_remote_flush callback for vmx when hyperv capability of
nested guest mapping flush is detected. The interface can help to
reduce overhead when flush ept table among vcpus for nested VM. The
tradition way is to send IPIs to all affected vcpus and executes
INVEPT on each vcpus. It will trigger several vmexits for IPI
and INVEPT emulation. Hyper-V provides such hypercall to do
flush for all vcpus and call the hypercall when all ept table
pointers of single VM are same.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
       Make ept_pointers_match as tristate "check", "match" and
"mismatch". Set "check" in vmx_set_cr3(), check all ept table
pointers in hv_remote_flush_tlb() and call hypercall when all
ept pointers are same.

Change since v1:
       Replace identical_ept_pointer with ept_pointers_match and
check kvm_x86_ops->tlb_remote_flush in check_ept_pointer().
---
 arch/x86/kvm/vmx.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 1689f433f3a0..601ee37937a9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -188,12 +188,21 @@ module_param(ple_window_max, uint, 0444);
=20
 extern const ulong vmx_return;
=20
+enum ept_pointers_status {
+	EPT_POINTERS_CHECK =3D 0,
+	EPT_POINTERS_MATCH =3D 1,
+	EPT_POINTERS_MISMATCH =3D 2
+};
+
 struct kvm_vmx {
 	struct kvm kvm;
=20
 	unsigned int tss_addr;
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
+
+	enum ept_pointers_status ept_pointers_match;
+	spinlock_t ept_pointer_lock;
 };
=20
 #define NR_AUTOLOAD_MSRS 8
@@ -853,6 +862,7 @@ struct vcpu_vmx {
 	 */
 	u64 msr_ia32_feature_control;
 	u64 msr_ia32_feature_control_valid_bits;
+	u64 ept_pointer;
 };
=20
 enum segment_cache_field {
@@ -4774,6 +4784,48 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *=
vcpu, int vpid,
 	}
 }
=20
+/* check_ept_pointer() should be under protection of ept_pointer_lock. */
+static void check_ept_pointer(struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu;
+	u64 tmp_eptp =3D INVALID_PAGE;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!VALID_PAGE(tmp_eptp)) {
+			tmp_eptp =3D to_vmx(vcpu)->ept_pointer;
+		} else if (tmp_eptp !=3D to_vmx(vcpu)->ept_pointer) {
+			to_kvm_vmx(kvm)->ept_pointers_match
+				=3D EPT_POINTERS_MISMATCH;
+			return;
+		}
+	}
+
+	to_kvm_vmx(kvm)->ept_pointers_match =3D EPT_POINTERS_MATCH;
+}
+
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	int ret;
+
+	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+
+	if (to_kvm_vmx(kvm)->ept_pointers_match =3D=3D EPT_POINTERS_CHECK)
+		check_ept_pointer(kvm);
+
+	if (to_kvm_vmx(kvm)->ept_pointers_match !=3D EPT_POINTERS_MATCH) {
+		ret =3D -EFAULT;
+		goto out;
+	}
+
+	ret =3D hyperv_flush_guest_mapping(
+			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
+
+out:
+	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+	return ret;
+}
+
 static void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
@@ -4960,6 +5012,7 @@ static u64 construct_eptp(struct kvm_vcpu *vcpu, unsi=
gned long root_hpa)
=20
 static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
+	struct kvm *kvm =3D vcpu->kvm;
 	unsigned long guest_cr3;
 	u64 eptp;
=20
@@ -4967,11 +5020,20 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsi=
gned long cr3)
 	if (enable_ept) {
 		eptp =3D construct_eptp(vcpu, cr3);
 		vmcs_write64(EPT_POINTER, eptp);
+
+		if (kvm_x86_ops->tlb_remote_flush) {
+			spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+			to_vmx(vcpu)->ept_pointer =3D eptp;
+			to_kvm_vmx(kvm)->ept_pointers_match
+				=3D EPT_POINTERS_CHECK;
+			spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+		}
+
 		if (enable_unrestricted_guest || is_paging(vcpu) ||
 		    is_guest_mode(vcpu))
 			guest_cr3 =3D kvm_read_cr3(vcpu);
 		else
-			guest_cr3 =3D to_kvm_vmx(vcpu->kvm)->ept_identity_map_addr;
+			guest_cr3 =3D to_kvm_vmx(kvm)->ept_identity_map_addr;
 		ept_load_pdptrs(vcpu);
 	}
=20
@@ -7538,6 +7600,12 @@ static __init int hardware_setup(void)
 	if (enable_ept && !cpu_has_vmx_ept_2m_page())
 		kvm_disable_largepages();
=20
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
+	    && enable_ept)
+		kvm_x86_ops->tlb_remote_flush =3D hv_remote_flush_tlb;
+#endif
+
 	if (!cpu_has_vmx_ple()) {
 		ple_gap =3D 0;
 		ple_window =3D 0;
@@ -10383,6 +10451,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm =
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
