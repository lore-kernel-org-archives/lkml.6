Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A5DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7B620854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MQx93Fmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7B620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeGIJDB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:03:01 -0400
Received: from mail-sg2apc01on0093.outbound.protection.outlook.com ([104.47.125.93]:45036
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932727AbeGIJCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkNIor9RnQG0yuiGWndq/+tFCnYuZrpuIRFZTdeauf4=;
 b=MQx93Fmq8eAe36iFc/5mi06wvFnsn7c3eNwuyKS4ETpKMZb/NLGAEb5AuO+hKAQAIb0DYM1OnicS75SCpG7nHm49sGGJHAnbcp6dUVVj3X/1deZvJ7maAqkc/rEAAPq7HkvHblAEpcMPPLvRU/1evjXihJ8ehUDK++KekQEOMKE=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.15; Mon, 9 Jul 2018 09:02:41 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 09:02:41 +0000
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
Subject: [PATCH V2 2/5] KVM: Add tlb remote flush callback in kvm_x86_ops.
Thread-Topic: [PATCH V2 2/5] KVM: Add tlb remote flush callback in
 kvm_x86_ops.
Thread-Index: AQHUF2OX1I0JhtR1E0WteDVCqvbbqw==
Date:   Mon, 9 Jul 2018 09:02:41 +0000
Message-ID: <20180709090218.15342-3-Tianyu.Lan@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;7:D/bF08Q4fCWI9tKP+fjSFy/r0vCZgPfk0JdIvESEjGUhElAGhhPomLpn7oGCJOz01KNnXyYCSeXiXZGlk5743ZXDuingz8emBOSxPJ2LVdYR2wd3MDv4oYlmWSxJB4beHAwuhxUNkiSx/EQOsg4awSIRKoH5tRRKrvrFhUpBgRDGRKH9V2bk7smdM6EuiH9ssMYgxFQwcvqEQ6VL4+c1MFAPsxHznbIAFy1CLWQFDoXsOcZE2MsUxHvPwNKzMphr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: af446aa9-5ef3-48ef-d172-08d5e57aba6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB0063A2E449E9BDCB67BCC2A092440@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(256004)(14444005)(105586002)(76176011)(86362001)(6486002)(72206003)(66066001)(59246006)(86612001)(6512007)(97736004)(6436002)(2616005)(476003)(8936002)(486006)(14454004)(446003)(11346002)(7416002)(81156014)(81166006)(8676002)(4326008)(109986005)(68736007)(25786009)(2900100001)(106356001)(6116002)(3846002)(1076002)(36756003)(5660300001)(53936002)(305945005)(7736002)(1671002)(5250100002)(54906003)(99286004)(26005)(102836004)(22452003)(10090500001)(10290500003)(2906002)(478600001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ufbP7rbmvyytjIK7Dd7UcvoXc7jQMgC+zcAr16Lj113pJwQlCd3UfrKJPkozB2y86k1WnFRgItHr64u+4609x5x3rkc/YCT5DdpymD9cGIvq+R83OyhTHUVboLlP+eKD6Z2rndumZ4Za92UCKT9lZvrwu6HqiQSMXx/ZdsEJsi/tU/XvDnjaLMgBVeII/0C/NpXFq8b1CBM64Fj8Ie3Gq0qaV1xi6s8rsoEmdeM2mQ9KJDL8DjtsOi11TJK3mE1ETrdxs5VKicNgMGQL1P3FMPd1WeDtxveQS4ttEBaxz2/N0EsdyxXT+i1ej28DqyN2d1bbyPnilqVcHt1nX1JfK9tEZBBLTEVG2SmzvKyzAkA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af446aa9-5ef3-48ef-d172-08d5e57aba6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 09:02:41.4294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to provide a way for platforms to register hv tlb remote
flush callback and this helps to optimize operation of tlb flush
among vcpus for nested virtualization case.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Add kvm_arch_hv_flush_remote_tlb() to avoid compilation issue
for non-x86 platform.
---
 arch/x86/include/asm/kvm_host.h | 11 +++++++++++
 include/linux/kvm_host.h        |  7 +++++++
 virt/kvm/kvm_main.c             | 11 ++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index c13cd28d9d1b..d89e4204816c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -973,6 +973,7 @@ struct kvm_x86_ops {
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
=20
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
+	int  (*hv_tlb_remote_flush)(struct kvm *kvm);
=20
 	void (*run)(struct kvm_vcpu *vcpu);
 	int (*handle_exit)(struct kvm_vcpu *vcpu);
@@ -1117,6 +1118,16 @@ static inline void kvm_arch_free_vm(struct kvm *kvm)
 	return kvm_x86_ops->vm_free(kvm);
 }
=20
+#define __KVM_HAVE_HV_FLUSH_REMOTE_TLB
+static inline int kvm_arch_hv_flush_remote_tlb(struct kvm *kvm)
+{
+	if (kvm_x86_ops->hv_tlb_remote_flush &&
+	    !kvm_x86_ops->hv_tlb_remote_flush(kvm))
+		return 0;
+	else
+		return -EFAULT;
+}
+
 int kvm_mmu_module_init(void);
 void kvm_mmu_module_exit(void);
=20
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4ee7bc548a83..0c2c36cb041b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -827,6 +827,13 @@ static inline void kvm_arch_free_vm(struct kvm *kvm)
 }
 #endif
=20
+#ifndef __KVM_HAVE_HV_FLUSH_REMOTE_TLB
+static inline int kvm_arch_hv_flush_remote_tlb(struct kvm *kvm)
+{
+	return -EFAULT;
+}
+#endif
+
 #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
 void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507faab5..c2b5e3273848 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -256,11 +256,20 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsig=
ned int req)
 #ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
+	long dirty_count;
+
+	/*
+	 * Call kvm_arch_hv_tlb_remote first and go back old way when
+	 * return failure.
+	 */
+	if (!kvm_arch_hv_flush_remote_tlb(kvm))
+		return;
+
 	/*
 	 * Read tlbs_dirty before setting KVM_REQ_TLB_FLUSH in
 	 * kvm_make_all_cpus_request.
 	 */
-	long dirty_count =3D smp_load_acquire(&kvm->tlbs_dirty);
+	dirty_count =3D smp_load_acquire(&kvm->tlbs_dirty);
=20
 	/*
 	 * We want to publish modifications to the page tables before reading
--=20
2.14.3
