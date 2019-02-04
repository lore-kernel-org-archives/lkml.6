Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11958C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E592082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PI6oLodK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfBDOmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:32 -0500
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:26208
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730510AbfBDOm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMrI5bFIy2lgNLrxKbEOg1im2PlRNpcBdbXyhi/a520=;
 b=PI6oLodKss01lVRkFG4bsyTTiOsrrrOUjyuaffvf2FtQ+YEw/ZMhwDvTxNE28mNejEepmWgq/V/F4X1yQFY3kc5yKiH3l4Ng9Q0FO7AsMfpCY+eOUbQaGO8mV6G5g0KS94YsCsI4gp3igiWR/WU0DDicnJDEe880hvMMhxzQIQk=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:42:27 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:27 +0000
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
Subject: [RFC PATCH 7/8] KVM: i8254: Remove need for irq ack notifier
Thread-Topic: [RFC PATCH 7/8] KVM: i8254: Remove need for irq ack notifier
Thread-Index: AQHUvJfZKTHK5rEqvE2EoQvolN4BQA==
Date:   Mon, 4 Feb 2019 14:42:27 +0000
Message-ID: <20190204144128.9489-8-suravee.suthikulpanit@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:HyfQzbTh3+bRyKH7l/FQfM+3liK7MmtnGpCCCYGcu+nvqzJTMGpwDKEzDssg8R+dskHF2y9A8WNWSdcsFi2BBWm7b6y693JZKk0tSUHpUWo5+EV1OZNc273isdS63J69ZgaciVtxfrsk2vP5O4sljF24eRsQvrN0/hxuVLS6OY8scTozbi9T2PZL0mIS3VT63WiRc7bNf4WrSGuS7rGVsGRJfxrJ3UqDraGyEWEuVyrJyzJssyMqJekA/hbJL0xh
x-ms-office365-filtering-correlation-id: 9d2d8274-1e42-4342-f9bb-08d68aaefbd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB3274E575549D27EBC9FCB2B9F36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(14444005)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(50226002)(71190400001)(486006)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(11346002)(2906002)(446003)(7416002)(26005)(76176011)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bT/qHhmnSJYIs82UpvPOOFbWWRcXE4DaSxQPVbkJPJanJhR8p9rIqJZaqCOLzIyMRe7jHESCOpPH7/uKso09ep/2iwEWyHnRC37CBlhn2qBMnIftS+OCxnE5f+KCymWTREKLUkxfpy7Xv92swxsEWa0+H8CuxNXDE6rlqqsMT1CpHtV0+LtAu/o7jsbApb0emRu7iF140IfT8WWtNhKlUpSkZhFAS2xjkiojBhT1YQ/dSWMXwcfZPjG1kT2EKg4ttoBTFOofauXYePcBfW8NhaU1MXNRQNfVssXOPY10aOmm0NSqom2eOfkZPLy5fu0vqErJwUEgVMKetoNB3hPbwjNaIOdW/+6b+5oS4Ztzh3OFKR/bUBWRy1jZGfv4Xj8Bq6MVVu8VKJ2oNV1fFmjt2Stj6Y59NdFqSHADcVnDz6s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2d8274-1e42-4342-f9bb-08d68aaefbd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:42:23.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Stecklina <jsteckli@amazon.de>

ACK notifiers don't work with AMD AVIC when the PIT interrupt is
delivered as edge-triggered fixed interrupt via the IOAPIC. AMD
processors cannot exit on EOI for these interrupts. The ACK notifiers do
work when the interrupt is delivered via PIC as ExtINT, because the ACK
comes as PIO write that KVM sees.

Change the PIT code to not rely on the ACK notifiers. The IRQ ACK
notifier in the PIT emulation re-schedules pit->expired to reinject any
pending PIT interrupt. This seems useless, because we can pulse the PIT
interrupt even when the interrupt is not ACKed yet. This means any timer
expiry when the interrupt was being handled by the guest, will cause an
interrupt to be injected automatically when the interrupt is ACKed.

Reviewed-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/i8254.c | 22 +---------------------
 arch/x86/kvm/i8254.h |  2 --
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index af192895b1fc..a8f6eb0ac1a0 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -200,21 +200,6 @@ static inline struct kvm_pit *pit_state_to_pit(struct =
kvm_kpit_state *ps)
 	return container_of(ps, struct kvm_pit, pit_state);
 }
=20
-static void kvm_pit_ack_irq(struct kvm_irq_ack_notifier *kian)
-{
-	struct kvm_kpit_state *ps =3D container_of(kian, struct kvm_kpit_state,
-						 irq_ack_notifier);
-	struct kvm_pit *pit =3D pit_state_to_pit(ps);
-
-	atomic_set(&ps->irq_ack, 1);
-	/* irq_ack should be set before pending is read.  Order accesses with
-	 * inc(pending) in pit_timer_fn and xchg(irq_ack, 0) in pit_do_work.
-	 */
-	smp_mb();
-	if (atomic_dec_if_positive(&ps->pending) > 0)
-		kthread_queue_work(pit->worker, &pit->expired);
-}
-
 void __kvm_migrate_pit_timer(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pit *pit =3D vcpu->kvm->arch.vpit;
@@ -244,7 +229,7 @@ static void pit_do_work(struct kthread_work *work)
 	int i;
 	struct kvm_kpit_state *ps =3D &pit->pit_state;
=20
-	if (atomic_read(&ps->reinject) && !atomic_xchg(&ps->irq_ack, 0))
+	if (atomic_read(&ps->reinject) && !atomic_xchg(&ps->pending, 0))
 		return;
=20
 	kvm_set_irq(kvm, pit->irq_source_id, 0, 1, false);
@@ -284,7 +269,6 @@ static enum hrtimer_restart pit_timer_fn(struct hrtimer=
 *data)
 static inline void kvm_pit_reset_reinject(struct kvm_pit *pit)
 {
 	atomic_set(&pit->pit_state.pending, 0);
-	atomic_set(&pit->pit_state.irq_ack, 1);
 }
=20
 void kvm_pit_set_reinject(struct kvm_pit *pit, bool reinject)
@@ -298,10 +282,8 @@ void kvm_pit_set_reinject(struct kvm_pit *pit, bool re=
inject)
 	if (reinject) {
 		/* The initial state is preserved while ps->reinject =3D=3D 0. */
 		kvm_pit_reset_reinject(pit);
-		kvm_register_irq_ack_notifier(kvm, &ps->irq_ack_notifier);
 		kvm_register_irq_mask_notifier(kvm, 0, &pit->mask_notifier);
 	} else {
-		kvm_unregister_irq_ack_notifier(kvm, &ps->irq_ack_notifier);
 		kvm_unregister_irq_mask_notifier(kvm, 0, &pit->mask_notifier);
 	}
=20
@@ -679,8 +661,6 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 fla=
gs)
 	hrtimer_init(&pit_state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	pit_state->timer.function =3D pit_timer_fn;
=20
-	pit_state->irq_ack_notifier.gsi =3D 0;
-	pit_state->irq_ack_notifier.irq_acked =3D kvm_pit_ack_irq;
 	pit->mask_notifier.func =3D pit_mask_notifer;
=20
 	kvm_pit_reset(pit);
diff --git a/arch/x86/kvm/i8254.h b/arch/x86/kvm/i8254.h
index 394d9527da7e..4a9cfe00306f 100644
--- a/arch/x86/kvm/i8254.h
+++ b/arch/x86/kvm/i8254.h
@@ -34,8 +34,6 @@ struct kvm_kpit_state {
 	struct mutex lock;
 	atomic_t reinject;
 	atomic_t pending; /* accumulated triggered timers */
-	atomic_t irq_ack;
-	struct kvm_irq_ack_notifier irq_ack_notifier;
 };
=20
 struct kvm_pit {
--=20
2.17.1

