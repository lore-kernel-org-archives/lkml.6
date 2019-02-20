Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AD22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R0Unt9bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfBTURc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfBTUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK9MH4082471;
        Wed, 20 Feb 2019 20:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=AsFZ89mGwV06Z97LV9y48tpzgtmNIVqvwCB8HHS2rLA=;
 b=R0Unt9bzHsc1ntgg+HuP/PIoGD0PQFUpjULiLUxRuhsqJeGyE3IakUBfvJ5/xkMTY9sB
 27ySCxjRfILQiMOVs6nYet6igQkiF5zCi0DSR2uGE6M39nQLhCHAxCdWuHiN7xV19Ev3
 476au636pSBip1Rwcbj4TbX7s2ULKgXNO19XXJChmZYwAoubvyflXE+Oj3IFbtxQdBkJ
 rPSDYcMoV77FrICZSpQI/O/eYm4+4qA2qsL510A42j0t3b7xBeMinXouh0AIYAkRpIBx
 Ga/nb96J/mYDMxJzg2XduubDoKeYuw6XPDZ8AQFmN5gue1Zni78zqtkQz6tFnKABBabp 5A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHDdm021057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:14 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKHDXH015354;
        Wed, 20 Feb 2019 20:17:13 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:12 -0800
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
Subject: [PATCH RFC 06/39] KVM: x86/xen: register vcpu info
Date:   Wed, 20 Feb 2019 20:15:36 +0000
Message-Id: <20190220201609.28290-7-joao.m.martins@oracle.com>
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


The vcpu info supersedes the per vcpu area of the shared info page and
the guest vcpus will use this instead.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/x86.c              |  1 +
 arch/x86/kvm/xen.c              | 93 ++++++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/xen.h              | 14 +++++++
 include/uapi/linux/kvm.h        |  5 +++
 5 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index befc0e37f162..96f65ba4b3c0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -537,6 +537,8 @@ struct kvm_vcpu_hv {
 /* Xen per vcpu emulation context */
 struct kvm_vcpu_xen {
 	struct kvm_xen_exit exit;
+	gpa_t vcpu_info_addr;
+	struct vcpu_info *vcpu_info;
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 31a102b22042..3ce97860e6ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9124,6 +9124,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 	int idx;
 
 	kvm_hv_vcpu_uninit(vcpu);
+	kvm_xen_vcpu_uninit(vcpu);
 	kvm_pmu_destroy(vcpu);
 	kfree(vcpu->arch.mce_banks);
 	kvm_free_lapic(vcpu);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 879bcfdd7b1d..36d6dd0ea4b8 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -15,6 +15,33 @@
 
 #include "trace.h"
 
+static void set_vcpu_attr(struct kvm_vcpu *v, u16 type, gpa_t gpa, void *addr)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
+
+	switch (type) {
+	case KVM_XEN_ATTR_TYPE_VCPU_INFO:
+		vcpu_xen->vcpu_info_addr = gpa;
+		vcpu_xen->vcpu_info = addr;
+		kvm_xen_setup_pvclock_page(v);
+		break;
+	default:
+		break;
+	}
+}
+
+static gpa_t get_vcpu_attr(struct kvm_vcpu *v, u16 type)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
+
+	switch (type) {
+	case KVM_XEN_ATTR_TYPE_VCPU_INFO:
+		return vcpu_xen->vcpu_info_addr;
+	default:
+		return 0;
+	}
+}
+
 static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 {
 	struct shared_info *shared_info;
@@ -37,26 +64,44 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 	return 0;
 }
 
+static void *xen_vcpu_info(struct kvm_vcpu *v)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(v);
+	struct kvm_xen *kvm = &v->kvm->arch.xen;
+	unsigned int offset = 0;
+	void *hva = NULL;
+
+	if (vcpu_xen->vcpu_info_addr)
+		return vcpu_xen->vcpu_info;
+
+	if (kvm->shinfo_addr && v->vcpu_id < MAX_VIRT_CPUS) {
+		hva = kvm->shinfo;
+		offset += offsetof(struct shared_info, vcpu_info);
+		offset += v->vcpu_id * sizeof(struct vcpu_info);
+	}
+
+	return hva + offset;
+}
+
 void kvm_xen_setup_pvclock_page(struct kvm_vcpu *v)
 {
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	struct pvclock_vcpu_time_info *guest_hv_clock;
+	void *hva = xen_vcpu_info(v);
 	unsigned int offset;
 
-	if (v->vcpu_id >= MAX_VIRT_CPUS)
+	if (!hva)
 		return;
 
 	offset = offsetof(struct vcpu_info, time);
-	offset += offsetof(struct shared_info, vcpu_info);
-	offset += v->vcpu_id * sizeof(struct vcpu_info);
 
 	guest_hv_clock = (struct pvclock_vcpu_time_info *)
-		(((void *)v->kvm->arch.xen.shinfo) + offset);
+		(hva + offset);
 
 	BUILD_BUG_ON(offsetof(struct pvclock_vcpu_time_info, version) != 0);
 
 	if (guest_hv_clock->version & 1)
-		++guest_hv_clock->version;  /* first time write, random junk */
+		++guest_hv_clock->version;
 
 	vcpu->hv_clock.version = guest_hv_clock->version + 1;
 	guest_hv_clock->version = vcpu->hv_clock.version;
@@ -93,6 +138,25 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		r = kvm_xen_shared_info_init(kvm, gfn);
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_VCPU_INFO: {
+		gpa_t gpa = data->u.vcpu_attr.gpa;
+		struct kvm_vcpu *v;
+		struct page *page;
+		void *addr;
+
+		v = kvm_get_vcpu(kvm, data->u.vcpu_attr.vcpu);
+		if (!v)
+			return -EINVAL;
+
+		page = gfn_to_page(v->kvm, gpa_to_gfn(gpa));
+		if (is_error_page(page))
+			return -EFAULT;
+
+		addr = page_to_virt(page) + offset_in_page(gpa);
+		set_vcpu_attr(v, data->type, gpa, addr);
+		r = 0;
+		break;
+	}
 	default:
 		break;
 	}
@@ -109,6 +173,17 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		data->u.shared_info.gfn = kvm->arch.xen.shinfo_addr;
 		break;
 	}
+	case KVM_XEN_ATTR_TYPE_VCPU_INFO: {
+		struct kvm_vcpu *v;
+
+		v = kvm_get_vcpu(kvm, data->u.vcpu_attr.vcpu);
+		if (!v)
+			return -EINVAL;
+
+		data->u.vcpu_attr.gpa = get_vcpu_attr(v, data->type);
+		r = 0;
+		break;
+	}
 	default:
 		break;
 	}
@@ -180,6 +255,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+
+	if (vcpu_xen->vcpu_info)
+		put_page(virt_to_page(vcpu_xen->vcpu_info));
+}
+
 void kvm_xen_destroy_vm(struct kvm *kvm)
 {
 	struct kvm_xen *xen = &kvm->arch.xen;
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 827c9390da34..10ebd0b7a25e 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -3,6 +3,19 @@
 #ifndef __ARCH_X86_KVM_XEN_H__
 #define __ARCH_X86_KVM_XEN_H__
 
+static inline struct kvm_vcpu_xen *vcpu_to_xen_vcpu(struct kvm_vcpu *vcpu)
+{
+	return &vcpu->arch.xen;
+}
+
+static inline struct kvm_vcpu *xen_vcpu_to_vcpu(struct kvm_vcpu_xen *xen_vcpu)
+{
+	struct kvm_vcpu_arch *arch;
+
+	arch = container_of(xen_vcpu, struct kvm_vcpu_arch, xen);
+	return container_of(arch, struct kvm_vcpu, arch);
+}
+
 void kvm_xen_setup_pvclock_page(struct kvm_vcpu *vcpu);
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
@@ -11,5 +24,6 @@ bool kvm_xen_hypercall_set(struct kvm *kvm);
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
 
 void kvm_xen_destroy_vm(struct kvm *kvm);
+void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu);
 
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index de2168d235af..782f497a0fdd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1465,10 +1465,15 @@ struct kvm_xen_hvm_attr {
 		struct {
 			__u64 gfn;
 		} shared_info;
+		struct {
+			__u32 vcpu;
+			__u64 gpa;
+		} vcpu_attr;
 	} u;
 };
 
 #define KVM_XEN_ATTR_TYPE_SHARED_INFO       0x0
+#define KVM_XEN_ATTR_TYPE_VCPU_INFO         0x1
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.11.0

