Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FBCC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8790D2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bmxDWrUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfBDOm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:27 -0500
Received: from mail-eopbgr730048.outbound.protection.outlook.com ([40.107.73.48]:14502
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730351AbfBDOm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv2yytBdCDR1ZtRINL41cNiNPMgODA6tmig9ciJPIzs=;
 b=bmxDWrUsAeLDa0GhO+DWMwAXFhfsErE87mriUfmwOpH/uYnTTmcDP/YyVCCOr3Har9HE0rvmb88v/itBkF5pno30kMNv6N0yH0DG87LFYejHGiMAGhOeldsZVPzwM2JQeXJObr8r5lePlXWWqN0wGrZ5UCHPa8wCt14/k0+x+xg=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:42:23 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:22 +0000
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
Subject: [RFC PATCH 6/8] svm: Temporary deactivate AVIC during ExtINT handling
Thread-Topic: [RFC PATCH 6/8] svm: Temporary deactivate AVIC during ExtINT
 handling
Thread-Index: AQHUvJfWnMOuJrywUk2hpLtg20EkxQ==
Date:   Mon, 4 Feb 2019 14:42:22 +0000
Message-ID: <20190204144128.9489-7-suravee.suthikulpanit@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:we22niNVflpRbOcVf5/C1fJLE5FCv10hapZ49oKcYBw3RM7jOqW1d61mam2PqhLhgmEaYLVmoPfOVXv/ihTJZu4j78v8Rs8hj/9MaGr1mnjW3RAuud20DrUnpGr7WFvTwB85BLddWqH6/if1G5aMUYFiBPkp4Ab2RGMUjnvwasF6Yk8uSRlWmdZbLbc2CvXPO6MHkFCYy4/fIfuUObrIaPRKKaifPmG0JP0FRLqv/aFJWbPVbgrb4NA4WuINs6JA
x-ms-office365-filtering-correlation-id: e5853ef5-1543-40fe-da45-08d68aaef8ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB3274B001ED1EF2D23490BB86F36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(14444005)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(50226002)(71190400001)(486006)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(11346002)(2906002)(446003)(7416002)(26005)(76176011)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NiqZHkatq8vb3Tn6RGyzLMwjX1D9e2SglfoEtdaoxJfQVW9HeVtmT1Gu1OVtmqOnbe9ihQ7zbGxTmJsgP91WODVVGQ+/PMhaPa5Ng12BDe4+X8wflpo9+Cwcpml4peaaQkjg0Eo/ZhSZsPAM2oU6MZiTNIcpoY8MnyjrtV2qSfXjk22q1dGtQ3LCOh47/iWadX2tnkpxMqCHmL5wLZakqnipC6Xm0uLeVTz59Q0Rn+15DNnJJamiAbp4XIpiKwAc3JKkH+RNjSh1UYlJkuR8GOsndhMgbSV+1fhMF0NuueLZtmdaQAwygASQHoySfd0YlC0OsTSJL29v8I2I5hsqm/HWD76gQKIsO9ItKmZTMRuzo8WHCQlo8b1bpOxeIez2TvG6JdiDNfkNI2Dpm4J8KFIMOiDEZlZriLyEy4HayE8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5853ef5-1543-40fe-da45-08d68aaef8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:42:18.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD AVIC does not support ExtINT. Therefore, AVIC must be temporary
deactivated and fall back to using legacy interrupt injection via
vINTR and interrupt window.

Introduce svm_request_activate/deactivate_avic() helper functions,
which handle steps required to activate/deactivate AVIC.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 57 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a23b1e77acb6..580ab40ba207 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -383,6 +383,8 @@ static u8 rsm_ins_bytes[] =3D "\x0f\xaa";
 static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
 static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 static void svm_complete_interrupts(struct vcpu_svm *svm);
+static void svm_request_activate_avic(struct kvm_vcpu *vcpu);
+static bool svm_get_enable_apicv(struct kvm_vcpu *vcpu);
=20
 static int nested_svm_exit_handled(struct vcpu_svm *svm);
 static int nested_svm_intercept(struct vcpu_svm *svm);
@@ -2085,6 +2087,9 @@ static void avic_set_running(struct kvm_vcpu *vcpu, b=
ool is_run)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
+	if (!kvm_vcpu_apicv_active(vcpu))
+		return;
+
 	svm->avic_is_running =3D is_run;
 	if (is_run)
 		avic_vcpu_load(vcpu, vcpu->cpu);
@@ -2319,6 +2324,10 @@ static void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
=20
 static void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
+	if (kvm_check_request(KVM_REQ_APICV_ACTIVATE, vcpu))
+		kvm_vcpu_activate_apicv(vcpu);
+	if (kvm_check_request(KVM_REQ_APICV_DEACTIVATE, vcpu))
+		kvm_vcpu_deactivate_apicv(vcpu);
 	avic_set_running(vcpu, true);
 }
=20
@@ -4460,6 +4469,15 @@ static int interrupt_window_interception(struct vcpu=
_svm *svm)
 {
 	kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 	svm_clear_vintr(svm);
+
+	/*
+	 * For AVIC, the only reason to end up here is ExtINTs.
+	 * In this case AVIC was temporarily disabled for
+	 * requesting the IRQ window and we have to re-enable it.
+	 */
+	if (svm_get_enable_apicv(&svm->vcpu))
+		svm_request_activate_avic(&svm->vcpu);
+
 	svm->vmcb->control.int_ctl &=3D ~V_IRQ_MASK;
 	mark_dirty(svm->vmcb, VMCB_INTR);
 	++svm->vcpu.stat.irq_window_exits;
@@ -5150,6 +5168,34 @@ static void svm_hwapic_isr_update(struct kvm_vcpu *v=
cpu, int max_isr)
 {
 }
=20
+static bool is_avic_active(struct vcpu_svm *svm)
+{
+	return (svm_get_enable_apicv(&svm->vcpu) &&
+		svm->vmcb->control.int_ctl & AVIC_ENABLE_MASK);
+}
+
+static void svm_request_activate_avic(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm =3D to_svm(vcpu);
+
+	if (!lapic_in_kernel(vcpu) || is_avic_active(svm))
+		return;
+
+	avic_setup_access_page(vcpu, false);
+	kvm_make_apicv_activate_request(vcpu->kvm);
+}
+
+static void svm_request_deactivate_avic(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm =3D to_svm(vcpu);
+
+	if (!lapic_in_kernel(vcpu) || !is_avic_active(svm))
+		return;
+
+	avic_destroy_access_page(vcpu);
+	kvm_make_apicv_deactivate_request(vcpu->kvm);
+}
+
 /* Note: Currently only used by Hyper-V. */
 static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
@@ -5437,9 +5483,6 @@ static void enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
-	if (kvm_vcpu_apicv_active(vcpu))
-		return;
-
 	/*
 	 * In case GIF=3D0 we can't rely on the CPU to tell us when GIF becomes
 	 * 1, because that's a separate STGI/VMRUN intercept.  The next time we
@@ -5449,6 +5492,14 @@ static void enable_irq_window(struct kvm_vcpu *vcpu)
 	 * window under the assumption that the hardware will set the GIF.
 	 */
 	if ((vgif_enabled(svm) || gif_set(svm)) && nested_svm_intr(svm)) {
+		/*
+		 * IRQ window is not needed when AVIC is enabled,
+		 * unless we have pending ExtINT since it cannot be injected
+		 * via AVIC. In such case, we need to temporarily disable AVIC,
+		 * and fallback to injecting IRQ via V_IRQ.
+		 */
+		if (kvm_vcpu_apicv_active(vcpu))
+			svm_request_deactivate_avic(&svm->vcpu);
 		svm_set_vintr(svm);
 		svm_inject_irq(svm, 0x0);
 	}
--=20
2.17.1

