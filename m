Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A2D2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bqDo8M+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfBDOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:11 -0500
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:31456
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730271AbfBDOmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu9mkI+DpjWiy2xh+Kczf18gkhGE6QaRAeywIeTE1ig=;
 b=bqDo8M+WSTmT54QxFZy4BjSeuAdtYb3HU364g+tDtnBbhJoQMmIUwBsA3aQUj6+a7uZujVM1h0FggHUESFGsXxLqdKx0v8Q71F+mkm4e+WQ5OO6zZzOOEHXRdCbPq7qYs19QlmMo5FxJUiFiEWD6TVHQA8u+V+VNsKtWTfSW9tY=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:42:08 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:08 +0000
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
Subject: [RFC PATCH 3/8] KVM: x86: Add callback functions for handling APIC
 ID, DFR and LDR update
Thread-Topic: [RFC PATCH 3/8] KVM: x86: Add callback functions for handling
 APIC ID, DFR and LDR update
Thread-Index: AQHUvJfOFjZbj+MTl0eQlZQ3XzE5rw==
Date:   Mon, 4 Feb 2019 14:42:08 +0000
Message-ID: <20190204144128.9489-4-suravee.suthikulpanit@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:DglDKdhLFpSs+YpFOO7IPCHMm92A2c55BWGGcy+RWL6NjR8mKx7zAL7hoL5MDA9prqAOLyc7XS++1oxTTdnxAZB+kSeKDCuNkBa+3XMbPeWd63UV2WinO3ValhBjM/L9hIml4wuyf2qlp1aGIdXCMtY9/p4rjrbwt/jW5fd9Go31fQzWyVFOOPdczWNq+pGqI5U+sevfYAqGfHgM1IJwBS/HHpfLgQpjqooGT+WgfQPqX4RsNadG1ZvFYY80Szo5
x-ms-office365-filtering-correlation-id: 0556c55e-2972-419e-9ec9-08d68aaef043
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB327410484E679651159CD51FF36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(14444005)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(15650500001)(50226002)(71190400001)(486006)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(11346002)(2906002)(446003)(7416002)(26005)(76176011)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mlmpo3H4GrCdZCYgIztJR3MjME5+XgjbIgApcRvx8Ysp6wm/tVdOcYM5eneSC5wejIowWV3w0FxK6oSzq01uqQRl59qQKsIU9oJA8MjrfYBiiqCXEedd+JPhqPE6afykGhpjomqccaNFEsZddIMlKG0IL292HVjX7R0PxpxD6aYWRQ4zxyNZz3VLtdwqVIaPqboU63OAKLmr/mf9vTAzkV0upaVlXQiCiVqv7PRU0EyXf2ZsiKx0pR0O79DIeKKj+BeN/Oca+h8TTxj7rA9elDW8yzPTav0QZUfTPoC9okwEXAYzMscHm18qyqEuiyakTxjkrfcIul1gHMz+duT1ITfdLYVvXUrShXh1I4tsRrXWg+T/1SQHJi8+O4zJ/4QYHZpoXwFMf6/+/eo35i2kV8uiH8dYTeEewP8jEKMrHu0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0556c55e-2972-419e-9ec9-08d68aaef043
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:42:03.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for handling the case when guest VM update APIC ID, DFR and LDR.
This is needed during when AMD AVIC is temporary deactivated.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/lapic.c            | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 05b5778c769e..cad47b4955e2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1083,6 +1083,9 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
+	void (*hwapic_apic_id_update)(struct kvm_vcpu *vcpu);
+	void (*hwapic_dfr_update)(struct kvm_vcpu *vcpu);
+	void (*hwapic_ldr_update)(struct kvm_vcpu *vcpu);
 	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9f089e2e09d0..a067a7292a5f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -267,6 +267,8 @@ static inline void kvm_apic_set_xapic_id(struct kvm_lap=
ic *apic, u8 id)
 static inline void kvm_apic_set_ldr(struct kvm_lapic *apic, u32 id)
 {
 	kvm_lapic_set_reg(apic, APIC_LDR, id);
+	if (kvm_x86_ops->hwapic_ldr_update)
+		kvm_x86_ops->hwapic_ldr_update(apic->vcpu);
 	recalculate_apic_map(apic->vcpu->kvm);
 }
=20
@@ -1809,10 +1811,13 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32=
 reg, u32 val)
=20
 	switch (reg) {
 	case APIC_ID:		/* Local APIC ID */
-		if (!apic_x2apic_mode(apic))
+		if (!apic_x2apic_mode(apic)) {
 			kvm_apic_set_xapic_id(apic, val >> 24);
-		else
+			if (kvm_x86_ops->hwapic_apic_id_update)
+				kvm_x86_ops->hwapic_apic_id_update(apic->vcpu);
+		} else {
 			ret =3D 1;
+		}
 		break;
=20
 	case APIC_TASKPRI:
@@ -1834,6 +1839,8 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 r=
eg, u32 val)
 	case APIC_DFR:
 		if (!apic_x2apic_mode(apic)) {
 			kvm_lapic_set_reg(apic, APIC_DFR, val | 0x0FFFFFFF);
+			if (kvm_x86_ops->hwapic_dfr_update)
+				kvm_x86_ops->hwapic_dfr_update(apic->vcpu);
 			recalculate_apic_map(apic->vcpu->kvm);
 		} else
 			ret =3D 1;
--=20
2.17.1

