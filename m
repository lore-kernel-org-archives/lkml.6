Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58F32147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQ58Zx6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfBTURY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51706 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8jqE081895;
        Wed, 20 Feb 2019 20:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=eN8fngoVKN0x/zeZw68QC5D2VC0C4AAVlV6ydxu23m8=;
 b=OQ58Zx6cJjilb2OJveOO0gSbbGMIhsRp06cWHLJMujdfmQPw0Il6ZXE1dZjoW08/UH4z
 npH0YlJUy9hLPAmJWjcNpCnst3s9Hs2oqcJ4my5yqS4b5qhImLQmMMf2IE/EfRWhhxIp
 FrttRAkiUYTIw/ns/dV1mmeEwSN0Wvc8Ucw0VNueVlHojHK/WielVfLJEFS8k8TwD0dV
 QkBpSy223mhOk8kL6m435lMvCeSV2SqmwO+1pzvbnmfROaVh2S9Clj5AEL5i7wVFLdSp
 8zfcmL+JFn5IJ38WJ93feTENjYs+Ohjo3Mbczb6P1eiGxmxZBPbsUjHTjVDnyw5rGymN tA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKH35K020565
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:03 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKH3vo018072;
        Wed, 20 Feb 2019 20:17:03 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:02 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH RFC 03/39] KVM: x86/xen: register shared_info page
Date:   Wed, 20 Feb 2019 20:15:33 +0000
Message-Id: <20190220201609.28290-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We add a new ioctl, XEN_HVM_SHARED_INFO, to allow hypervisor
to know where the guest's shared info page is.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/x86.c              | 21 +++++++++++++++
 arch/x86/kvm/xen.c              | 60 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |  4 +++
 include/uapi/linux/kvm.h        | 15 +++++++++++
 5 files changed, 103 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0f469ce439c0..befc0e37f162 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -843,6 +843,9 @@ struct kvm_hv {
 /* Xen emulation context */
 struct kvm_xen {
 	u64 xen_hypercall;
+
+	gfn_t shinfo_addr;
+	struct shared_info *shinfo;
 };
 
 enum kvm_irqchip_mode {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be8def385e3f..1eda96304180 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4793,6 +4793,26 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_XEN_HVM_GET_ATTR: {
+		struct kvm_xen_hvm_attr xha;
+
+		r = -EFAULT;
+		if (copy_from_user(&xha, argp, sizeof(xha)))
+			goto out;
+		r = kvm_xen_hvm_get_attr(kvm, &xha);
+		if (copy_to_user(argp, &xha, sizeof(xha)))
+			goto out;
+		break;
+	}
+	case KVM_XEN_HVM_SET_ATTR: {
+		struct kvm_xen_hvm_attr xha;
+
+		r = -EFAULT;
+		if (copy_from_user(&xha, argp, sizeof(xha)))
+			goto out;
+		r = kvm_xen_hvm_set_attr(kvm, &xha);
+		break;
+	}
 	case KVM_SET_CLOCK: {
 		struct kvm_clock_data user_ns;
 		u64 now_ns;
@@ -9279,6 +9299,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_mmu_uninit_vm(kvm);
 	kvm_page_track_cleanup(kvm);
 	kvm_hv_destroy_vm(kvm);
+	kvm_xen_destroy_vm(kvm);
 }
 
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 76f0e4b812d2..4df223bd3cd7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -11,9 +11,61 @@
 #include <linux/kvm_host.h>
 
 #include <trace/events/kvm.h>
+#include <xen/interface/xen.h>
 
 #include "trace.h"
 
+static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
+{
+	struct shared_info *shared_info;
+	struct page *page;
+
+	page = gfn_to_page(kvm, gfn);
+	if (is_error_page(page))
+		return -EINVAL;
+
+	kvm->arch.xen.shinfo_addr = gfn;
+
+	shared_info = page_to_virt(page);
+	memset(shared_info, 0, sizeof(struct shared_info));
+	kvm->arch.xen.shinfo = shared_info;
+	return 0;
+}
+
+int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
+{
+	int r = -ENOENT;
+
+	switch (data->type) {
+	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
+		gfn_t gfn = data->u.shared_info.gfn;
+
+		r = kvm_xen_shared_info_init(kvm, gfn);
+		break;
+	}
+	default:
+		break;
+	}
+
+	return r;
+}
+
+int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
+{
+	int r = -ENOENT;
+
+	switch (data->type) {
+	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
+		data->u.shared_info.gfn = kvm->arch.xen.shinfo_addr;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return r;
+}
+
 bool kvm_xen_hypercall_enabled(struct kvm *kvm)
 {
 	return READ_ONCE(kvm->arch.xen.xen_hypercall);
@@ -77,3 +129,11 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 
 	return 0;
 }
+
+void kvm_xen_destroy_vm(struct kvm *kvm)
+{
+	struct kvm_xen *xen = &kvm->arch.xen;
+
+	if (xen->shinfo)
+		put_page(virt_to_page(xen->shinfo));
+}
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index a2ae079c3ef3..bb38edf383fe 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -3,8 +3,12 @@
 #ifndef __ARCH_X86_KVM_XEN_H__
 #define __ARCH_X86_KVM_XEN_H__
 
+int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
+int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 bool kvm_xen_hypercall_enabled(struct kvm *kvm);
 bool kvm_xen_hypercall_set(struct kvm *kvm);
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
 
+void kvm_xen_destroy_vm(struct kvm *kvm);
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d07520c216a1..de2168d235af 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1455,6 +1455,21 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_CPUID */
 #define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
 
+#define KVM_XEN_HVM_GET_ATTR        _IOWR(KVMIO,  0xc2, struct kvm_xen_hvm_attr)
+#define KVM_XEN_HVM_SET_ATTR        _IOW(KVMIO,  0xc3, struct kvm_xen_hvm_attr)
+
+struct kvm_xen_hvm_attr {
+	__u16 type;
+
+	union {
+		struct {
+			__u64 gfn;
+		} shared_info;
+	} u;
+};
+
+#define KVM_XEN_ATTR_TYPE_SHARED_INFO       0x0
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.11.0

