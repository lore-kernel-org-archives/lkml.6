Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838A02084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1k67luOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfAVKZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:25:16 -0500
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:64896
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbfAVKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjzuR9uZjWwsJq1ZM8GejDMp+j7H/Dxpi7qgMHTuDtY=;
 b=1k67luOE9HjHEnQmT8fn95JiCNyS3+otaWPXGz9NABAcYG+KzCoerWDpOiwNS+GcbV2mLlW2FT4uRmki0XnTmpwmqdT5MIDXzUZaEyIjCSTXz/cslKxl2z3GOQ91bsxx4lKO2Gk4AHjl8FFRk6RGBHFwSLW1pK9cH0s1t7iJFlw=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3179.namprd12.prod.outlook.com (20.179.104.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 10:25:14 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 10:25:13 +0000
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
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Topic: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Index: AQHUsjzCWuJ1rNsdhEWhrsyeZxFnGA==
Date:   Tue, 22 Jan 2019 10:25:13 +0000
Message-ID: <20190122102450.125349-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.96.72.83]
x-clientproxiedby: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3179;20:Pt2Y45n5QxAxaW0tduGcodG1VVU/xH9D4BiNiPuGz3WyCshFXilWDtwsVgxziJGfBwjXgBqUbjnbxjISOH4sLz8rUQqiiSpqXdoUeFCXvszDWN3+X7S0ooIGSBBahLpsfxzS34lfoydxiL60pGDHnAoZWJl1pXZOQhs2ZvEBy5OyMSv6oCBOcrj3q23daWqJpU6iokr3RkSC4BUEGsymVP10vGoClMJpQ60tvznWe592839OGIp2JIH2FK7qdeZZ
x-ms-office365-filtering-correlation-id: ef3c2e2c-d731-4137-b18a-08d68053e538
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3179;
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-microsoft-antispam-prvs: <DM6PR12MB31791DDA3E028E64D91DEFE6F3980@DM6PR12MB3179.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(6506007)(386003)(102836004)(7736002)(2501003)(305945005)(52116002)(14454004)(6512007)(36756003)(7416002)(2906002)(478600001)(14444005)(256004)(53936002)(50226002)(105586002)(72206003)(106356001)(8936002)(1076003)(71190400001)(3846002)(6116002)(86362001)(71200400001)(2616005)(4326008)(2201001)(6486002)(476003)(186003)(66066001)(26005)(6436002)(316002)(68736007)(25786009)(97736004)(99286004)(486006)(54906003)(81166006)(81156014)(110136005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3179;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2dYR41l9t7SdcE0HS4vFmUAzAlj2Wj1YEi1XRnSHQTWss2k/ufalNc5BxEB8ssuMwn8QJTI/CnbFuT+JXj2fq31sc43QwD6REFNIJfqsWe1ZIeykZMRpcSe8BYvX/zc7uJyrD4SjGxTqP3LlMos4JUeOiR4YaPg+3hMLbFI/XwnmRWcLiA8xz75t+H8m6WK8PtuJh+KxoYSF6PxptLbqzp+OmtRLsBranNZVfS9gua+DvduOy0hKIiCz7HUQeliWtGXeqYECXTD7XDYff618//eGyOadrtDWkeqdJGprF08+NO8Or06bRVzAOvfWL5/DRpbW3bhKnDF9VoejZ8PZrWKExwANKk5PaEIzb20U6LS15qSpbSWgG48AKiN97ft7JgKPAxXP2L80tXKWNic9wiLjJwLDFYGJxIlX4XZKpis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c2e2c-d731-4137-b18a-08d68053e538
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:25:10.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In case of incomplete IPI with invalid interrupt type, the current
SVM driver does not properly emulate the IPI, and fails to boot
FreeBSD guests with multiple vcpus when enabling AVIC.

Fix this by update APIC ICR high/low registers, which also
emulate sending the IPI.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 2aff835a65ed..8a0c9a1f6ac8 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4504,25 +4504,14 @@ static int avic_incomplete_ipi_interception(struct =
vcpu_svm *svm)
 		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING: {
-		int i;
-		struct kvm_vcpu *vcpu;
-		struct kvm *kvm =3D svm->vcpu.kvm;
 		struct kvm_lapic *apic =3D svm->vcpu.arch.apic;
=20
 		/*
-		 * At this point, we expect that the AVIC HW has already
-		 * set the appropriate IRR bits on the valid target
-		 * vcpus. So, we just need to kick the appropriate vcpu.
+		 * Update ICR high and low, then emulate sending IPI,
+		 * which is handled when writing APIC_ICR.
 		 */
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			bool m =3D kvm_apic_match_dest(vcpu, apic,
-						     icrl & KVM_APIC_SHORT_MASK,
-						     GET_APIC_DEST_FIELD(icrh),
-						     icrl & KVM_APIC_DEST_MASK);
-
-			if (m && !avic_vcpu_is_running(vcpu))
-				kvm_vcpu_wake_up(vcpu);
-		}
+		kvm_lapic_reg_write(apic, APIC_ICR2, icrh);
+		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	}
 	case AVIC_IPI_FAILURE_INVALID_TARGET:
--=20
2.17.1

