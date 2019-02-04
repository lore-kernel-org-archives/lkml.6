Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D059C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59932082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aY8DD05H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfBDOms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:48 -0500
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:48598
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730275AbfBDOmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcrMB9xH5DG+iIUkeUJ2q36srNbVNfOY6r34mygwN7I=;
 b=aY8DD05H4/roxabqtTFwMC7zNjkJd75fwlff3Hdt8oGbuS/IA4ECfyq7D86ggXDGvavZa3G0Ka1FFtFCP6tbWhumPRwEdnXDizCdj3CUd3x7typmrOZlfCZmIrzRPd63JzjR2C4eEGF2e4P/wbd0pFG9s2aH86RvL5arQFZ1zdI=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3257.namprd12.prod.outlook.com (20.179.105.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:42:03 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:03 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        "sironi@amazon.de" <sironi@amazon.de>,
        "wawei@amazon.de" <wawei@amazon.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH 2/8] KVM: x86: Add interface for run-time
 activate/de-activate APIC virtualization
Thread-Topic: [RFC PATCH 2/8] KVM: x86: Add interface for run-time
 activate/de-activate APIC virtualization
Thread-Index: AQHUvJfLH3USQ1ddaEOiVnANXxnv8A==
Date:   Mon, 4 Feb 2019 14:42:03 +0000
Message-ID: <20190204144128.9489-3-suravee.suthikulpanit@amd.com>
References: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.90.26.242]
x-clientproxiedby: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3257;20:Ssymbn4/WKfwRbu5VLMWrY07bZAMc47igB20PapgB103b6Zr95caAJ98lW7QM6NHoOTTOiMxFUe0CukFANVN73KFkwJ/4MJIgW3uA3Piq057ASMHsCD3F60O6QKxpycgapfg6oYqyXikgYE/qWn/+4R7izNEyDunrwJzYm/fzOuDuP8xhdARMLjYr4RzKgc9uSMy+Ul8h+nVCf0/J62O95wcz9aKVz1pD9yVMjdx8isEiKt0/KUocgINXwsgJLgh
x-ms-office365-filtering-correlation-id: 657e3109-b99f-4c33-1a18-08d68aaeed6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3257;
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-microsoft-antispam-prvs: <DM6PR12MB3257B360F3AB1381BF29E5C2F36D0@DM6PR12MB3257.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(305945005)(2616005)(1076003)(316002)(71190400001)(446003)(486006)(2501003)(26005)(7416002)(68736007)(476003)(14454004)(110136005)(11346002)(54906003)(7736002)(386003)(97736004)(71200400001)(2201001)(86362001)(36756003)(4326008)(256004)(99286004)(50226002)(53936002)(8936002)(76176011)(6486002)(14444005)(478600001)(6506007)(2906002)(102836004)(25786009)(72206003)(81166006)(81156014)(8676002)(6116002)(3846002)(106356001)(52116002)(6512007)(217873002)(66066001)(105586002)(6436002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3257;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybh3VI1ROb0OSjYeQbwmBbLDEyTyYZOP7Vh25ezzK+5VB2WDoowgp6tFXolGGqkHcJ6sUzYHaxee2pYf173aSjbQAFrf8pPG02qdXJveovpyzmmexmf15Z+M3p9XXPkoMD/Xr2FiIx9uCnspSUoicPsxgaj3coCQnffRAs9ps0DmwmjZoO7etVspvEMz6WQ1ZVhv8ApHexbtxjsiOJ7oquxGemQFV6CgVVBjFb9yazatAb9W9WLrLYdZ1kkHG/hoD0+is2feefoedsHW1n8tCL73mfhZihDme7r58PssnXF6F4KVYbkD/iBtyYjsHmHPINR4OhGiWHkfP8hwYGlERv/Z0lDmt1TL3Qm3uPcJsFPKsQi0lW7VZX0ttD+De0wBZY7pTzYDWqVqRZfLs/W8Q6dumZjp5bTE2LnY6vzSSk0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e3109-b99f-4c33-1a18-08d68aaeed6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:41:59.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain types of interrupt cannot be supported by AMD AVIC hardware.
Therefore, there is a need to temporary deactivate AVIC and fallback to
legacy interrupt injection mechanism.

Since AMD AVIC requires all vcpus to be operating in the same mode.
So, introduce new interface to request all vCPUs to activate/deactivate
APICV during run-time.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  8 ++++++++
 arch/x86/kvm/x86.c              | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 4660ce90de7f..05b5778c769e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -78,6 +78,10 @@
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
 #define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
+#define KVM_REQ_APICV_ACTIVATE		\
+	KVM_ARCH_REQ_FLAGS(25, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_APICV_DEACTIVATE	\
+	KVM_ARCH_REQ_FLAGS(26, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
=20
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -1536,6 +1540,10 @@ bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsign=
ed long linear_rip);
=20
 void kvm_make_mclock_inprogress_request(struct kvm *kvm);
 void kvm_make_scan_ioapic_request(struct kvm *kvm);
+void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu);
+void kvm_vcpu_activate_apicv(struct kvm_vcpu *vcpu);
+void kvm_make_apicv_activate_request(struct kvm *kvm);
+void kvm_make_apicv_deactivate_request(struct kvm *kvm);
=20
 void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 				     struct kvm_async_pf *work);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02c8e095a239..e93e2ef923b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7045,11 +7045,19 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, uns=
igned long flags, int apicid)
 	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
 }
=20
+void kvm_vcpu_activate_apicv(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.apicv_active =3D true;
+	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_activate_apicv);
+
 void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.apicv_active =3D false;
 	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
 }
+EXPORT_SYMBOL_GPL(kvm_vcpu_deactivate_apicv);
=20
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
@@ -7541,6 +7549,30 @@ void kvm_make_scan_ioapic_request(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SCAN_IOAPIC);
 }
=20
+void kvm_make_apicv_activate_request(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *v;
+
+	kvm_for_each_vcpu(i, v, kvm)
+		kvm_clear_request(KVM_REQ_APICV_DEACTIVATE, v);
+
+	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_ACTIVATE);
+}
+EXPORT_SYMBOL_GPL(kvm_make_apicv_activate_request);
+
+void kvm_make_apicv_deactivate_request(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *v;
+
+	kvm_for_each_vcpu(i, v, kvm)
+		kvm_clear_request(KVM_REQ_APICV_ACTIVATE, v);
+
+	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_DEACTIVATE);
+}
+EXPORT_SYMBOL_GPL(kvm_make_apicv_deactivate_request);
+
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_apic_present(vcpu))
@@ -7727,6 +7759,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		 */
 		if (kvm_check_request(KVM_REQ_HV_STIMER, vcpu))
 			kvm_hv_process_stimers(vcpu);
+		if (kvm_check_request(KVM_REQ_APICV_ACTIVATE, vcpu))
+			kvm_vcpu_activate_apicv(vcpu);
+		if (kvm_check_request(KVM_REQ_APICV_DEACTIVATE, vcpu))
+			kvm_vcpu_deactivate_apicv(vcpu);
 	}
=20
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
--=20
2.17.1

