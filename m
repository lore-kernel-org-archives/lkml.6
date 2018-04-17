Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDQFre (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:47:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45511 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeDQFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:46:58 -0400
X-Google-Smtp-Source: AIpwx49p/IOUGlkrJL8g/mtrInBEnWLqvKu2pVCT7nONuQqubIms9mTkUv0VKjr+sJh82JTaBtDnHg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 2/3] KVM: X86: Allow userspace to disable ioport intercept
Date: Mon, 16 Apr 2018 22:46:01 -0700
Message-Id: <1523943962-25415-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Allow to disable ioport intercept by userspace.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Tim Shearer <tshearer@advaoptical.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/api.txt | 11 +++++++++++
 arch/x86/include/asm/kvm_host.h   |  2 ++
 arch/x86/kvm/x86.c                |  5 +++++
 include/uapi/linux/kvm.h          |  1 +
 4 files changed, 19 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1c7958b..3d0488e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4378,6 +4378,17 @@ all such vmexits.
 
 Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
 
+7.14 KVM_CAP_IOPORT_DISABLE_INTERCEPT
+
+Architectures: x86
+Parameters: args[0] defines whether ioport intercept
+
+When disable intercept (args[0] == 1), some ioports which frequently
+access will not be intercepted.
+
+When enable intercept (args[0] == 0), behavior is as if this facility
+is unsupported.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c25775f..2f29f64 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -808,6 +808,8 @@ struct kvm_arch {
 	bool hlt_in_guest;
 	bool pause_in_guest;
 
+	bool ioport_disable_intercept;
+
 	unsigned long irq_sources_bitmap;
 	s64 kvmclock_offset;
 	raw_spinlock_t tsc_write_lock;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51ecd38..044e314 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2881,6 +2881,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_GET_MSR_FEATURES:
+	case KVM_CAP_IOPORT_DISABLE_INTERCEPT:
 		r = 1;
 		break;
 	case KVM_CAP_SYNC_REGS:
@@ -4250,6 +4251,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.pause_in_guest = true;
 		r = 0;
 		break;
+	case KVM_CAP_IOPORT_DISABLE_INTERCEPT:
+		kvm->arch.ioport_disable_intercept = cap->args[0];
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1065006..92730d8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -941,6 +941,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_IOPORT_DISABLE_INTERCEPT 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
