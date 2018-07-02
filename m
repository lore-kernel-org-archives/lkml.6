Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E3AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8507925E76
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XMME9/2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8507925E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeGBOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:18:23 -0400
Received: from mail-hk2apc01on0127.outbound.protection.outlook.com ([104.47.124.127]:37376
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752247AbeGBORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVRcogIBGCd8JHKHkjgoTYnBwtFtiYc7LqKBsr5BSzc=;
 b=XMME9/2tbd0bT8HaFd0lul2cRhL6Var6zastdA+ry4ZsppHy6yRLfMmbUc63H8CoJa6fmPIXArS9c3SKFUyA+wyeyWc/JqiGlZHZDAHPxD3s0FRq455+sKljOYpac+1Im90JG9rcNgmqiN0yTZiIcVJ2BApy9YAiUZlYIs9O9Fg=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0133.APCP153.PROD.OUTLOOK.COM (10.170.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 14:17:30 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e%5]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 14:17:30 +0000
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
Subject: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
Thread-Topic: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
Thread-Index: AQHUEg9paY7djkcpC0ykdZ+fV8ZzGQ==
Date:   Mon, 2 Jul 2018 14:17:29 +0000
Message-ID: <20180702141653.88936-4-Tianyu.Lan@microsoft.com>
References: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0133;7:QAzPQ/hbD66+CuwlMMQYoJtAwT7UoWwMqyn/uRsITRA5J45fkB/sbwZFOAFx8Z48AT9C+HHKn2207QJ+pmSDayNontqvw6s8jAQeGZN9wh5oZy+oAiOOg6twtbnGeALBqiKnMfbOe/XNTsNfy2eUtPlzlV3lRDiBFCd4QC29QYHDDFpCPw0voqfBFm7E/GiaqSKLPJyhBlgWr4EHQR3TdbF+nNxxMjrdMKWVgzCS94HA8sFOdo5qLbcf2W7M+w6u
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7ca5497e-acbf-4780-9b3e-08d5e0268bfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:KU1P153MB0133;
x-ms-traffictypediagnostic: KU1P153MB0133:
x-microsoft-antispam-prvs: <KU1P153MB0133C88F6BE0950DAC6DA2C192430@KU1P153MB0133.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0133;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0133;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(1671002)(54906003)(476003)(446003)(486006)(59246006)(36756003)(26005)(102836004)(22452003)(11346002)(2616005)(316002)(97736004)(2900100001)(14454004)(6486002)(109986005)(86362001)(86612001)(68736007)(6512007)(4326008)(25786009)(6436002)(10090500001)(53936002)(66066001)(5660300001)(105586002)(106356001)(8936002)(2906002)(305945005)(7736002)(99286004)(256004)(14444005)(72206003)(6506007)(10290500003)(76176011)(3846002)(8676002)(1076002)(81166006)(81156014)(478600001)(5250100002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0133;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Dyxksi5oKHov5flUQK93FJjhRZ01QIICBXm3XyK2tp5rOx8rbNdxY1VcLOHiARz1riD4SM9dkjA4hXa/55h7wpv+GdolMexM/MiCoRZ8M71OVYuY+4vrtKWF0Fh2IR07CMyAY1MSIYVsQGyXdLa3K9jOAbArFjhmCdTR67nwGKSMlZf7VjWeQvnBvx5n4I9c9rEhCYlxyM3YmMhHlLIu7Fd3tFKBC6u2rKIIjVRLGUxtyWgdso6Q8UPoErDmpN7rioSOGFvVEwni6ACOInKRIPdPMjHOXoVG4nxMi5VCEqQ7COP8g7utorKTJdfGhAHGvydM7BjH4qCon3a3DT30PgtVR4YJ5rJZDuuCuIE9TAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca5497e-acbf-4780-9b3e-08d5e0268bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 14:17:29.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0133
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
 arch/x86/kvm/vmx.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 1689f433f3a0..0b1e4e9fef2b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -194,6 +194,9 @@ struct kvm_vmx {
 	unsigned int tss_addr;
 	bool ept_identity_pagetable_done;
 	gpa_t ept_identity_map_addr;
+
+	u64 identical_ept_pointer;
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
@@ -4958,6 +4962,29 @@ static u64 construct_eptp(struct kvm_vcpu *vcpu, uns=
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
+	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+	to_vmx(vcpu)->ept_pointer =3D eptp;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!VALID_PAGE(tmp_eptp)) {
+			tmp_eptp =3D to_vmx(vcpu)->ept_pointer;
+		} else if (tmp_eptp !=3D to_vmx(vcpu)->ept_pointer) {
+			to_kvm_vmx(kvm)->identical_ept_pointer =3D INVALID_PAGE;
+			spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+			return;
+		}
+	}
+
+	to_kvm_vmx(kvm)->identical_ept_pointer =3D tmp_eptp;
+	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+}
+
 static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	unsigned long guest_cr3;
@@ -4967,6 +4994,8 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsign=
ed long cr3)
 	if (enable_ept) {
 		eptp =3D construct_eptp(vcpu, cr3);
 		vmcs_write64(EPT_POINTER, eptp);
+		check_ept_pointer(vcpu, eptp);
+
 		if (enable_unrestricted_guest || is_paging(vcpu) ||
 		    is_guest_mode(vcpu))
 			guest_cr3 =3D kvm_read_cr3(vcpu);
@@ -10383,6 +10412,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm =
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
