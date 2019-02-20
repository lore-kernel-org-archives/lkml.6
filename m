Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3068C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9133C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELSXDtZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfBTUUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:20:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbfBTUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VMH081701;
        Wed, 20 Feb 2019 20:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gQUPRbLoYWg0zdbNGHXgdQYJld3Oxus6PO4cvvWfLpw=;
 b=ELSXDtZNmmpI2AO7jtWQjgd+ax/0DCR4WA4LOFBi/appqSDAzNqe3A48BpjIoobJGdoq
 9RlCnewbM46W+kT+NBFO2QpJy/AfIovF83BzDld/hZD1JS6b7BK9ZzI8jxkyFlXKB1Ih
 fwR9/Rju4gVmFw1zxBB+oC9Pr3RAQznuKOP6HoEXgdMX2edOXZtFUwtUWRI4gJKbolaF
 1etmvRKW6uDliB8//ABYA0XJ6fo1PoymKZj0n7/NcZ9TZVEqQCrMGROndEtC5uyPY2Do
 6n1sxAaVUjLM3aPuVWK97D8mSE2oFU4rXWXnY8W3/o7kSexDlR5FFlsLLOhCBpUlqPcI 1g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIAN8006676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:10 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIABW009924;
        Wed, 20 Feb 2019 20:18:10 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:09 -0800
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
Subject: [PATCH RFC 24/39] KVM: x86/xen: backend hypercall support
Date:   Wed, 20 Feb 2019 20:15:54 +0000
Message-Id: <20190220201609.28290-25-joao.m.martins@oracle.com>
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

From: Ankur Arora <ankur.a.arora@oracle.com>

Ordinarily a Xen backend domain would do hypercalls via int 0x81 (or
vmcall) to enter a lower ring of execution. This is done via a
hypercall_page which contains call stubs corresponding to each
hypercall.

For Xen backend driver support, however, we would like to do Xen
hypercalls in the same ring. To that end we point the hypercall_page to
a kvm owned text page which just does a local call (to
kvm_xen_host_hcall().)

Note, that this is different from hypercalls handled in
kvm_xen_hypercall(), because the latter refers to domU hypercalls (so
there is an actual drop in execution ring) while there isn't in
kvm_xen_host_hcall().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++
 arch/x86/kvm/Makefile           |  2 +-
 arch/x86/kvm/xen-asm.S          | 66 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.c              | 68 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |  4 +++
 5 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kvm/xen-asm.S

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 70bb7339ddd4..55609e919e14 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1669,4 +1669,7 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
 #define put_smstate(type, buf, offset, val)                      \
 	*(type *)((buf) + (offset) - 0x7e00) = val
 
+void kvm_xen_register_lcall(struct kvm_xen *shim);
+void kvm_xen_unregister_lcall(void);
+
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 2b46c93c9380..c1eaabbd0a54 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -10,7 +10,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
-			   hyperv.o xen.o page_track.o debugfs.o
+			   hyperv.o xen-asm.o xen.o page_track.o debugfs.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
 kvm-amd-y		+= svm.o pmu_amd.o
diff --git a/arch/x86/kvm/xen-asm.S b/arch/x86/kvm/xen-asm.S
new file mode 100644
index 000000000000..10559fcfbe38
--- /dev/null
+++ b/arch/x86/kvm/xen-asm.S
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved. */
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/frame.h>
+#include <asm/page_types.h>
+#include <asm/unwind_hints.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/xen-mca.h>
+#include <asm/xen/interface.h>
+
+	.balign PAGE_SIZE
+ENTRY(kvm_xen_hypercall_page)
+	hcall=0
+	.rept (PAGE_SIZE / 32)
+		FRAME_BEGIN
+		push %rcx	/* Push call clobbered registers */
+		push %r9
+		push %r11
+		mov $hcall, %rax
+
+		call kvm_xen_host_hcall
+		pop %r11
+		pop %r9
+		pop %rcx
+
+		FRAME_END
+		ret
+		.balign 32
+		hcall = hcall + 1
+	.endr
+/*
+ * Hypercall symbols are used for unwinding the stack, so we give them names
+ * prefixed with kvm_xen_ (Xen hypercalls have symbols prefixed with xen_.)
+ */
+#define HYPERCALL(n) \
+  .equ kvm_xen_hypercall_##n, kvm_xen_hypercall_page + __HYPERVISOR_##n * 32; \
+  .type kvm_xen_hypercall_##n, @function;				      \
+  .size kvm_xen_hypercall_##n, 32
+#include <asm/xen-hypercalls.h>
+#undef HYPERCALL
+END(kvm_xen_hypercall_page)
+
+/*
+ * Some call stubs generated above do not have associated symbols. Generate
+ * bogus symbols for those hypercall blocks to stop objtool from complaining
+ * about unreachable code.
+ */
+.altmacro
+.macro hypercall_missing N
+       .equ kvm_xen_hypercall_missing_\N, kvm_xen_hypercall_page + \N * 32;
+       .type kvm_xen_hypercall_missing_\N, @function;
+       .size kvm_xen_hypercall_missing_\N, 32;
+.endm
+
+.macro hypercalls_missing N count=1
+       .set n,\N
+       .rept \count
+               hypercall_missing %n
+               .set n,n+1
+       .endr
+.endm
+
+hypercalls_missing 11 1
+hypercalls_missing 42 6
+hypercalls_missing 56 72
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 7266d27db210..645cd22ab4e7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -12,6 +12,7 @@
 #include <linux/kvm_host.h>
 #include <linux/eventfd.h>
 #include <linux/sched/stat.h>
+#include <linux/linkage.h>
 
 #include <trace/events/kvm.h>
 #include <xen/interface/xen.h>
@@ -19,6 +20,10 @@
 #include <xen/interface/event_channel.h>
 #include <xen/interface/grant_table.h>
 #include <xen/interface/sched.h>
+#include <xen/interface/version.h>
+#include <xen/xen.h>
+#include <xen/features.h>
+#include <asm/xen/hypercall.h>
 
 #include "trace.h"
 
@@ -43,6 +48,7 @@ struct evtchnfd {
 static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port);
 static void *xen_vcpu_info(struct kvm_vcpu *v);
 static void kvm_xen_gnttab_free(struct kvm_xen *xen);
+static int shim_hypercall(u64 code, u64 a0, u64 a1, u64 a2, u64 a3, u64 a4);
 
 #define XEN_DOMID_MIN	1
 #define XEN_DOMID_MAX	(DOMID_FIRST_RESERVED - 1)
@@ -50,6 +56,9 @@ static void kvm_xen_gnttab_free(struct kvm_xen *xen);
 static rwlock_t domid_lock;
 static struct idr domid_to_kvm;
 
+static struct hypercall_entry *hypercall_page_save;
+static struct kvm_xen *xen_shim __read_mostly;
+
 static int kvm_xen_domid_init(struct kvm *kvm, bool any, domid_t domid)
 {
 	u16 min = XEN_DOMID_MIN, max = XEN_DOMID_MAX;
@@ -1271,3 +1280,62 @@ int kvm_vm_ioctl_xen_gnttab(struct kvm *kvm, struct kvm_xen_gnttab *op)
 
 	return r;
 }
+
+asmlinkage int kvm_xen_host_hcall(void)
+{
+	register unsigned long a0 asm(__HYPERCALL_RETREG);
+	register unsigned long a1 asm(__HYPERCALL_ARG1REG);
+	register unsigned long a2 asm(__HYPERCALL_ARG2REG);
+	register unsigned long a3 asm(__HYPERCALL_ARG3REG);
+	register unsigned long a4 asm(__HYPERCALL_ARG4REG);
+	register unsigned long a5 asm(__HYPERCALL_ARG5REG);
+	int ret;
+
+	preempt_disable();
+	ret = shim_hypercall(a0, a1, a2, a3, a4, a5);
+	preempt_enable();
+
+	return ret;
+}
+
+void kvm_xen_register_lcall(struct kvm_xen *shim)
+{
+	hypercall_page_save = hypercall_page;
+	hypercall_page = kvm_xen_hypercall_page;
+	xen_shim = shim;
+}
+EXPORT_SYMBOL_GPL(kvm_xen_register_lcall);
+
+void kvm_xen_unregister_lcall(void)
+{
+	hypercall_page = hypercall_page_save;
+	hypercall_page_save = NULL;
+}
+EXPORT_SYMBOL_GPL(kvm_xen_unregister_lcall);
+
+static int shim_hcall_version(int op, struct xen_feature_info *fi)
+{
+	if (op != XENVER_get_features || !fi || fi->submap_idx != 0)
+		return -EINVAL;
+
+	/*
+	 * We need a limited set of features for a pseudo dom0.
+	 */
+	fi->submap = (1U << XENFEAT_auto_translated_physmap);
+	return 0;
+}
+
+static int shim_hypercall(u64 code, u64 a0, u64 a1, u64 a2, u64 a3, u64 a4)
+{
+	int ret = -ENOSYS;
+
+	switch (code) {
+	case __HYPERVISOR_xen_version:
+		ret = shim_hcall_version((int)a0, (void *)a1);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 08ad4e1259df..9fa7c3dd111a 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -3,6 +3,8 @@
 #ifndef __ARCH_X86_KVM_XEN_H__
 #define __ARCH_X86_KVM_XEN_H__
 
+#include <asm/xen/hypercall.h>
+
 static inline struct kvm_vcpu_xen *vcpu_to_xen_vcpu(struct kvm_vcpu *vcpu)
 {
 	return &vcpu->arch.xen;
@@ -48,4 +50,6 @@ int kvm_xen_has_pending_timer(struct kvm_vcpu *vcpu);
 void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu);
 bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu);
 
+extern struct hypercall_entry kvm_xen_hypercall_page[128];
+
 #endif
-- 
2.11.0

