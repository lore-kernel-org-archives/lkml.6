Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97202C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2B2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DtsTU5mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfBDOmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:17 -0500
Received: from mail-eopbgr770080.outbound.protection.outlook.com ([40.107.77.80]:61011
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730351AbfBDOmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRCSdhUym5lFazr32x16xa7ZFTbmH42kWrDactZ+P24=;
 b=DtsTU5mEO5/vcoOxbmsmKVSdNct9aiqQVrodPv7sRwB5grPySsZlymG2ipDlTxmxMQ98XhwSMoM6Yuf8tLagE1I6eKe0T6cXHVRtITbDpZGba/FPkrQ1bIL+acvqjFHhPN3bF8R0ARDCFC9RDKvsNjoRhEPoz01/Z1rgymlS364=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:42:13 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:13 +0000
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
Subject: [RFC PATCH 4/8] svm: Add AMD AVIC handlers for APIC ID, DFR and LDR
 update
Thread-Topic: [RFC PATCH 4/8] svm: Add AMD AVIC handlers for APIC ID, DFR and
 LDR update
Thread-Index: AQHUvJfQ5Gi9B+s2WUa4GhBQMpxrpQ==
Date:   Mon, 4 Feb 2019 14:42:13 +0000
Message-ID: <20190204144128.9489-5-suravee.suthikulpanit@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:9ctRULsFIHrER0lBJ0jptAfSG0lcyp0EjqhUMiKsA2rfGdrmHb/osqobmbVW/qS+IyBJx4idLE5uC0Vf0DZmq3GM7+wF8cJ7FduYFwZvaUuEBCKCcnRjrSybfz3OET9FfisNPHCgHPU6f+dc2SyIAPsQL/PFRGKB/LTH8sACBQLfMHIQpv8ngZ5tUTbrk5n/bGotoeDwCfYg1OddRk4aQEQMVgAi18cqGJVQbynOw3bNvO+ecSnae8CUuiClliXZ
x-ms-office365-filtering-correlation-id: 3f642437-e0c3-4d0f-d257-08d68aaef331
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB32747605AA34B23E4550B905F36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(14444005)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(15650500001)(50226002)(71190400001)(486006)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(11346002)(2906002)(446003)(7416002)(26005)(76176011)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: upDX6KtCRhe9Scv0Kb9+qW04jx6XjQWx4m638up9Z1PpoNKFdPVvzNJRzJa+zSDl97gVp3X9nUqUXL0cOTHuOvJhPGnQfxrbOuHURMEUK/zhrz52uHC3QcwOlKWwyeEwAeEBXMiU7xjENhgohxzRk9YdLtmukIw96XDPH5+MGFl5WIoF6WNjJwJ2Kv64FjQcSbjtdg6C6EJpiDLHq5hx+vBHzAlGpGz3m1Bbx/oDzTuhSFelFPjtSRp8Bw7j3e5o5lUCWnfkr1l2dxt41LazJM6xYzaG2qUGNKmCuhk3mk08O1mFcKbA/mKkN2D9LeZ/ijgG35viUmP4w7MGOi2+nuOioZ5YK4mUQfIdjvWGQAPLey+V230a/eaQXwVFPkLbp6HxjsfPQTQJ+5Qidju2R0YkGurCV+SHWRt3RXpqG44=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f642437-e0c3-4d0f-d257-08d68aaef331
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:42:08.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During AVIC temporary deactivation, guest could update APIC ID,
DFR and LDR registers, which would not be trapped by
avic_unaccelerated_ccess_interception(). In this case, we need
to update the AVIC logical APIC ID table accordingly.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 75508f665aef..c33f02b4a19e 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4649,6 +4649,24 @@ static void avic_handle_dfr_update(struct kvm_vcpu *=
vcpu)
 	svm->dfr_reg =3D dfr;
 }
=20
+static void svm_hwapic_ldr_update(struct kvm_vcpu *vcpu)
+{
+	if (svm_get_enable_apicv(vcpu) && !kvm_vcpu_apicv_active(vcpu))
+		avic_handle_ldr_update(vcpu);
+}
+
+static void svm_hwapic_apic_id_update(struct kvm_vcpu *vcpu)
+{
+	if (svm_get_enable_apicv(vcpu) && !kvm_vcpu_apicv_active(vcpu))
+		avic_handle_apic_id_update(vcpu);
+}
+
+static void svm_hwapic_dfr_update(struct kvm_vcpu *vcpu)
+{
+	if (svm_get_enable_apicv(vcpu) && !kvm_vcpu_apicv_active(vcpu))
+		avic_handle_dfr_update(vcpu);
+}
+
 static int avic_unaccel_trap_write(struct vcpu_svm *svm)
 {
 	struct kvm_lapic *apic =3D svm->vcpu.arch.apic;
@@ -7166,6 +7184,9 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init=
 =3D {
 	.load_eoi_exitmap =3D svm_load_eoi_exitmap,
 	.hwapic_irr_update =3D svm_hwapic_irr_update,
 	.hwapic_isr_update =3D svm_hwapic_isr_update,
+	.hwapic_apic_id_update =3D svm_hwapic_apic_id_update,
+	.hwapic_dfr_update =3D svm_hwapic_dfr_update,
+	.hwapic_ldr_update =3D svm_hwapic_ldr_update,
 	.sync_pir_to_irr =3D kvm_lapic_find_highest_irr,
 	.apicv_post_state_restore =3D avic_post_state_restore,
=20
--=20
2.17.1

