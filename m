Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E752AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969AB20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UX7rh1rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969AB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeGSJYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:24:13 -0400
Received: from mail-hk2apc01on0090.outbound.protection.outlook.com ([104.47.124.90]:42614
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731205AbeGSJYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxzbEeN3bLBEdr2bo5FpQxuGNVOtTPKgRRinZDEhl3s=;
 b=UX7rh1rqmZCyZvsgGUreb/+P89ZTbTyoPOI1S2iJ6fWklGs0b+fnE0kDLDTeUDkMd2i9qVJrNHUf5cos4+DYdzQpShxQk9sDQHcJQR1DStLy/Y23HJ+FwcEEKy17e6DOY6lLHv/NzRtJB3bUSNjGe3RHij+ce6ZD1BzQOZZfB/U=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM (10.170.136.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 08:40:18 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 08:40:18 +0000
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
Subject: [PATCH V3 3/4] KVM: Add tlb remote flush callback in kvm_x86_ops.
Thread-Topic: [PATCH V3 3/4] KVM: Add tlb remote flush callback in
 kvm_x86_ops.
Thread-Index: AQHUHzweNhV1zWmYFkekQSCjAFm5jQ==
Date:   Thu, 19 Jul 2018 08:40:17 +0000
Message-ID: <20180719083946.121493-4-Tianyu.Lan@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0062;6:t1nNJuEkHOss0ExHb+MNXvHY1S85VxFiTWGwLsRMpFnQtcXSvemKw5BlftbzZoEUmmXMKlF8AUq8gPXr/mmfRqD1F6aIMknMW7h8oTwvrDe2e9qOSmI5LCXmGtYb0rNNkWSNGtbFEXeJ/oXSohUQh1G+EFLnR7ug4PAVKGjUUf9R1JvGC1VXmTynwsuoOLaPwQ/lZt/7ZfX7vHpwnwgBQOQzJxgTF/YLHDjnqZDYd9gMXsIvb5XHwEe4WzDAMphaSzm6oxGudvdLpHEN7DsK3CvCTt0RcPWfcVHB/BedIu7hmI3Og6DG5fi1aljdQMpfvJ7gqh55Z8/gz1QL3oVHK5xYI7dOfcPmeUIT9KyaCkjAB1xwh1lCxC8d/Bfn83P3nTCpyCO0+SBQExZzefBEjM1Rf5uMm6hi8tsLYpziTjMJ+OnBsLadw66NOgasphklEk936h8nu1SZ5W/xcKsz2Q==;5:8/IgQV2oge19Zdsm0tcRdLws2ePIh3JX1MUWyv/JTRd6t+xt0ge93AV5hLYuzzSKkys4SLoKVnXvMOUL1tj8CoYiDBYRrgN09YMQD7IG5yqQPw5GqdEgOyWZbLQyaNRoX7f3agiGSXbWB+D7LollblrNH22bxb8f/8frtQWS0Vk=;7:ZvcqzkjDBJCHW7bnJerhKBFtrdi6VrXncYm/zcSMVJQfoAoYZEEuwgZoUsTVZT9aGixtDx76TJTEgtbIVABj5hDtHIOILnD4Ip4dV3wG1BaL+LC8TY4SyZ8ezBGKisn17dqT3kjrLCNDkdl5POeTB/+sk0mVIpRuJzzlK70TMcX2mAHOwEFobdN7YhAkGMe0Xm/hXx+5E/h6CfE7SSJ4L6L+a/deOnuVnq8ivwMKZk14pcmHsRNZMttLUcq7eh6x
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 78246f8d-b5ce-4ef7-014c-08d5ed5341b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0062;
x-ms-traffictypediagnostic: SG2P15301MB0062:
x-microsoft-antispam-prvs: <SG2P15301MB00620E1E4914D6356B92DB8592520@SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0062;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0062;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(10290500003)(72206003)(316002)(53936002)(478600001)(81166006)(54906003)(1671002)(8936002)(6506007)(8676002)(81156014)(106356001)(36756003)(25786009)(4326008)(109986005)(105586002)(76176011)(7736002)(305945005)(2900100001)(14444005)(256004)(5660300001)(99286004)(59246006)(6436002)(1076002)(6116002)(3846002)(6512007)(14454004)(5250100002)(486006)(66066001)(86362001)(446003)(11346002)(26005)(86612001)(476003)(102836004)(2906002)(10090500001)(2616005)(22452003)(97736004)(68736007)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0062;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iYFtgotSkW8aVklUJU5lnysEkGeL9g1qO0NYrNFJQv3OdbuETaPM8m8NJcg8Iz7YshC3F55cRoq98O85SFGRC5tYCkhstrXExHFcqQvApGIt0wGALMZl47Lh9CYYQ0U1y5QO2isWfG/MqnE3CBxDqGICF/d7pvS+NBB9mV6V10SsN7oEDcLLYJ3CQs+j0Oz8MScgw+mxIZQ7IygOHps96pmGcAZkl3lPoG7flqz/FePFzDjCGS5oHVz3ssBfWgIOmD3C22ZpF8yDSzvyQ38CVMqpL2TalSKkpf1UpDKGWAJBJkTwoV9YZrMrAojkPEXMxlBummHiADpqBx2osUAHJ7QN5QT41p0AT6KinCARq2s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78246f8d-b5ce-4ef7-014c-08d5ed5341b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 08:40:17.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0062
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
Change since v2:
       Rename kvm_arch_hv_flush_remote_tlb with kvm_arch_flush_remote_tlb
       Rename kvm_x86_ops->hv_tlb_remote_flush with kvm_x86_ops->tlb_remote=
_flush
       Fix issue that ignore updating tlbs_dirty during calling kvm_arch_fl=
ush_remote_tlbs()
Change since v1:
       Add kvm_arch_hv_flush_remote_tlb() to avoid compilation issue
for non-x86 platform.
---
 arch/x86/include/asm/kvm_host.h | 11 +++++++++++
 include/linux/kvm_host.h        |  7 +++++++
 virt/kvm/kvm_main.c             |  3 ++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index c13cd28d9d1b..76e806bc4ef8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -973,6 +973,7 @@ struct kvm_x86_ops {
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
=20
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
+	int  (*tlb_remote_flush)(struct kvm *kvm);
=20
 	void (*run)(struct kvm_vcpu *vcpu);
 	int (*handle_exit)(struct kvm_vcpu *vcpu);
@@ -1117,6 +1118,16 @@ static inline void kvm_arch_free_vm(struct kvm *kvm)
 	return kvm_x86_ops->vm_free(kvm);
 }
=20
+#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB
+static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
+{
+	if (kvm_x86_ops->tlb_remote_flush &&
+	    !kvm_x86_ops->tlb_remote_flush(kvm))
+		return 0;
+	else
+		return -EFAULT;
+}
+
 int kvm_mmu_module_init(void);
 void kvm_mmu_module_exit(void);
=20
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4ee7bc548a83..0781d94200df 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -827,6 +827,13 @@ static inline void kvm_arch_free_vm(struct kvm *kvm)
 }
 #endif
=20
+#ifndef __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB
+static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
+{
+	return -EFAULT;
+}
+#endif
+
 #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
 void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507faab5..1a13cdb2822b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -273,7 +273,8 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 	 * kvm_make_all_cpus_request() reads vcpu->mode. We reuse that
 	 * barrier here.
 	 */
-	if (kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
+	if (!kvm_arch_flush_remote_tlb(kvm)
+	    || kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
 		++kvm->stat.remote_tlb_flush;
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
--=20
2.14.3
