Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E083A2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sWlsxj0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBTURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBTURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Ves081690;
        Wed, 20 Feb 2019 20:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=fXX8HPeYvgLyAsNwOKMQrzfQAx3bkpNv8PCYQeoxzNk=;
 b=sWlsxj0vtZn/NVJSZt01UcBLann83WVuDzngwTYG+BzZsyzq/zAKQNFxJSROxQl0HI8q
 XAdaYcFH/Lz7HPusG6LV3/wEPnULjR+zon1K5ox/HVAL8+yENIeIAnAKgnftLM6RY9uZ
 jF22FjM59HRXp5heoeSkNA+5CbGA6GREcwiTusqhej9fhr1JTk1BaeLi+WoeJVJBo29w
 IcuCy44HzgviEj2ImAdEQTP7olRXN0A4eUXZzwOc+l9CEO8Iq5UutnboFwqMtB7/dk83
 OBPAwAXGeU0HUq/WRTF+ZcNM0vl2xlJa7g+3W2XeMQ/pL5GcTlEbGckZ01XVbDDk0ajm Iw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKH0dr024494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:00 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKGx7U015198;
        Wed, 20 Feb 2019 20:16:59 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:16:58 -0800
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
Subject: [PATCH RFC 02/39] KVM: x86/xen: intercept xen hypercalls if enabled
Date:   Wed, 20 Feb 2019 20:15:32 +0000
Message-Id: <20190220201609.28290-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=940 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new exit reason for emulator to handle Xen hypercalls.
Albeit these are injected only if guest has initialized the Xen
hypercall page - the hypercall is just a convenience but one
that is done by pretty much all guests. Hence if the guest
sets the hypercall page, we assume a Xen guest is going to
be set up.

Emulator will then panic with:

KVM: unknown exit reason 28
RAX=0000000000000011 RBX=ffffffff81e03e94 RCX=0000000040000000
RDX=0000000000000000
RSI=ffffffff81e03e70 RDI=0000000000000006 RBP=ffffffff81e03e90
RSP=ffffffff81e03e68
R8 =73726576206e6558 R9 =ffffffff81e03e90 R10=ffffffff81e03e94
R11=2e362e34206e6f69
R12=0000000040000004 R13=ffffffff81e03e8c R14=ffffffff81e03e88
R15=0000000000000000
RIP=ffffffff81001228 RFL=00000082 [--S----] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 ffffffff 00c00000
CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
SS =0000 0000000000000000 ffffffff 00c00000
DS =0000 0000000000000000 ffffffff 00c00000
FS =0000 0000000000000000 ffffffff 00c00000
GS =0000 ffffffff81f34000 ffffffff 00c00000
LDT=0000 0000000000000000 ffffffff 00c00000
TR =0020 0000000000000000 00000fff 00808b00 DPL=0 TSS64-busy
GDT=     ffffffff81f3c000 0000007f
IDT=     ffffffff83265000 00000fff
CR0=80050033 CR2=ffff880001fa6ff8 CR3=0000000001fa6000 CR4=000406a0
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000d01
Code=cc cc cc cc cc cc cc cc cc cc cc cc b8 11 00 00 00 0f 01 c1 <c3> cc
cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8 12
00 00 00 0f

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h | 13 +++++++
 arch/x86/kvm/Makefile           |  2 +-
 arch/x86/kvm/trace.h            | 33 +++++++++++++++++
 arch/x86/kvm/x86.c              | 12 +++++++
 arch/x86/kvm/xen.c              | 79 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              | 10 ++++++
 include/uapi/linux/kvm.h        | 17 ++++++++-
 7 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kvm/xen.c
 create mode 100644 arch/x86/kvm/xen.h

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9417febf8490..0f469ce439c0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -79,6 +79,7 @@
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
 #define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
+#define KVM_REQ_XEN_EXIT		KVM_ARCH_REQ(25)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -533,6 +534,11 @@ struct kvm_vcpu_hv {
 	cpumask_t tlb_flush;
 };
 
+/* Xen per vcpu emulation context */
+struct kvm_vcpu_xen {
+	struct kvm_xen_exit exit;
+};
+
 struct kvm_vcpu_arch {
 	/*
 	 * rip and regs accesses must go through
@@ -720,6 +726,7 @@ struct kvm_vcpu_arch {
 	unsigned long singlestep_rip;
 
 	struct kvm_vcpu_hv hyperv;
+	struct kvm_vcpu_xen xen;
 
 	cpumask_var_t wbinvd_dirty_mask;
 
@@ -833,6 +840,11 @@ struct kvm_hv {
 	atomic_t num_mismatched_vp_indexes;
 };
 
+/* Xen emulation context */
+struct kvm_xen {
+	u64 xen_hypercall;
+};
+
 enum kvm_irqchip_mode {
 	KVM_IRQCHIP_NONE,
 	KVM_IRQCHIP_KERNEL,       /* created with KVM_CREATE_IRQCHIP */
@@ -899,6 +911,7 @@ struct kvm_arch {
 	struct hlist_head mask_notifier_list;
 
 	struct kvm_hv hyperv;
+	struct kvm_xen xen;
 
 	#ifdef CONFIG_KVM_MMU_AUDIT
 	int audit_point;
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 31ecf7a76d5a..2b46c93c9380 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -10,7 +10,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
-			   hyperv.o page_track.o debugfs.o
+			   hyperv.o xen.o page_track.o debugfs.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
 kvm-amd-y		+= svm.o pmu_amd.o
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 6432d08c7de7..4fe9fd86292f 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -91,6 +91,39 @@ TRACE_EVENT(kvm_hv_hypercall,
 );
 
 /*
+ * Tracepoint for Xen hypercall.
+ */
+TRACE_EVENT(kvm_xen_hypercall,
+	TP_PROTO(unsigned long nr, unsigned long a0, unsigned long a1,
+		 unsigned long a2, unsigned long a3, unsigned long a4),
+	TP_ARGS(nr, a0, a1, a2, a3, a4),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, nr)
+		__field(unsigned long, a0)
+		__field(unsigned long, a1)
+		__field(unsigned long, a2)
+		__field(unsigned long, a3)
+		__field(unsigned long, a4)
+	),
+
+	TP_fast_assign(
+		__entry->nr = nr;
+		__entry->a0 = a0;
+		__entry->a1 = a1;
+		__entry->a2 = a2;
+		__entry->a3 = a3;
+		__entry->a4 = a4;
+	),
+
+	TP_printk("nr 0x%lx a0 0x%lx a1 0x%lx a2 0x%lx a3 0x%lx a4 0x%lx",
+		 __entry->nr, __entry->a0, __entry->a1,  __entry->a2,
+		 __entry->a3, __entry->a4)
+);
+
+
+
+/*
  * Tracepoint for PIO.
  */
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47360a4b0d42..be8def385e3f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -29,6 +29,7 @@
 #include "cpuid.h"
 #include "pmu.h"
 #include "hyperv.h"
+#include "xen.h"
 
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -2338,6 +2339,8 @@ static int xen_hvm_config(struct kvm_vcpu *vcpu, u64 data)
 	}
 	if (kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE))
 		goto out_free;
+
+	kvm_xen_hypercall_set(kvm);
 	r = 0;
 out_free:
 	kfree(page);
@@ -7076,6 +7079,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	if (kvm_hv_hypercall_enabled(vcpu->kvm))
 		return kvm_hv_hypercall(vcpu);
 
+	if (kvm_xen_hypercall_enabled(vcpu->kvm))
+		return kvm_xen_hypercall(vcpu);
+
 	nr = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	a0 = kvm_register_read(vcpu, VCPU_REGS_RBX);
 	a1 = kvm_register_read(vcpu, VCPU_REGS_RCX);
@@ -7736,6 +7742,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 0;
 			goto out;
 		}
+		if (kvm_check_request(KVM_REQ_XEN_EXIT, vcpu)) {
+			vcpu->run->exit_reason = KVM_EXIT_XEN;
+			vcpu->run->xen = vcpu->arch.xen.exit;
+			r = 0;
+			goto out;
+		}
 
 		/*
 		 * KVM_REQ_HV_STIMER has to be processed after
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
new file mode 100644
index 000000000000..76f0e4b812d2
--- /dev/null
+++ b/arch/x86/kvm/xen.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
+ *
+ * KVM Xen emulation
+ */
+
+#include "x86.h"
+#include "xen.h"
+
+#include <linux/kvm_host.h>
+
+#include <trace/events/kvm.h>
+
+#include "trace.h"
+
+bool kvm_xen_hypercall_enabled(struct kvm *kvm)
+{
+	return READ_ONCE(kvm->arch.xen.xen_hypercall);
+}
+
+bool kvm_xen_hypercall_set(struct kvm *kvm)
+{
+	return WRITE_ONCE(kvm->arch.xen.xen_hypercall, 1);
+}
+
+static void kvm_xen_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
+{
+	kvm_register_write(vcpu, VCPU_REGS_RAX, result);
+}
+
+static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	kvm_xen_hypercall_set_result(vcpu, run->xen.u.hcall.result);
+	return kvm_skip_emulated_instruction(vcpu);
+}
+
+int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
+{
+	bool longmode;
+	u64 input, params[5];
+
+	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
+
+	longmode = is_64_bit_mode(vcpu);
+	if (!longmode) {
+		params[0] = (u64)kvm_register_read(vcpu, VCPU_REGS_RBX);
+		params[1] = (u64)kvm_register_read(vcpu, VCPU_REGS_RCX);
+		params[2] = (u64)kvm_register_read(vcpu, VCPU_REGS_RDX);
+		params[3] = (u64)kvm_register_read(vcpu, VCPU_REGS_RSI);
+		params[4] = (u64)kvm_register_read(vcpu, VCPU_REGS_RDI);
+	}
+#ifdef CONFIG_X86_64
+	else {
+		params[0] = (u64)kvm_register_read(vcpu, VCPU_REGS_RDI);
+		params[1] = (u64)kvm_register_read(vcpu, VCPU_REGS_RSI);
+		params[2] = (u64)kvm_register_read(vcpu, VCPU_REGS_RDX);
+		params[3] = (u64)kvm_register_read(vcpu, VCPU_REGS_R10);
+		params[4] = (u64)kvm_register_read(vcpu, VCPU_REGS_R8);
+	}
+#endif
+	trace_kvm_xen_hypercall(input, params[0], params[1], params[2],
+				params[3], params[4]);
+
+	vcpu->run->exit_reason = KVM_EXIT_XEN;
+	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
+	vcpu->run->xen.u.hcall.input = input;
+	vcpu->run->xen.u.hcall.params[0] = params[0];
+	vcpu->run->xen.u.hcall.params[1] = params[1];
+	vcpu->run->xen.u.hcall.params[2] = params[2];
+	vcpu->run->xen.u.hcall.params[3] = params[3];
+	vcpu->run->xen.u.hcall.params[4] = params[4];
+	vcpu->arch.complete_userspace_io =
+		kvm_xen_hypercall_complete_userspace;
+
+	return 0;
+}
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
new file mode 100644
index 000000000000..a2ae079c3ef3
--- /dev/null
+++ b/arch/x86/kvm/xen.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved. */
+#ifndef __ARCH_X86_KVM_XEN_H__
+#define __ARCH_X86_KVM_XEN_H__
+
+bool kvm_xen_hypercall_enabled(struct kvm *kvm);
+bool kvm_xen_hypercall_set(struct kvm *kvm);
+int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
+
+#endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6d4ea4b6c922..d07520c216a1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -204,6 +204,18 @@ struct kvm_hyperv_exit {
 	} u;
 };
 
+struct kvm_xen_exit {
+#define KVM_EXIT_XEN_HCALL          1
+	__u32 type;
+	union {
+		struct {
+			__u64 input;
+			__u64 result;
+			__u64 params[5];
+		} hcall;
+	} u;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -235,6 +247,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_XEN              28
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -392,8 +405,10 @@ struct kvm_run {
 		} eoi;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
+		/* KVM_EXIT_XEN */
+		struct kvm_xen_exit xen;
 		/* Fix the size of the union. */
-		char padding[256];
+		char padding[196];
 	};
 
 	/* 2048 is the size of the char array used to bound/pad the size
-- 
2.11.0

