Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeDPLIZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:08:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754555AbeDPLIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:08:22 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] KVM: x86: hyperv: declare KVM_CAP_HYPERV_TLBFLUSH capability
Date: Mon, 16 Apr 2018 13:08:06 +0200
Message-Id: <20180416110806.4896-7-vkuznets@redhat.com>
In-Reply-To: <20180416110806.4896-1-vkuznets@redhat.com>
References: <20180416110806.4896-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need a new capability to indicate support for the newly added
HvFlushVirtualAddress{List,Space}{,Ex} hypercalls. Upon seeing this
capability, userspace is supposed to announce PV TLB flush features
by setting the appropriate CPUID bits (if needed).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 Documentation/virtual/kvm/api.txt | 9 +++++++++
 arch/x86/kvm/x86.c                | 1 +
 include/uapi/linux/kvm.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1c7958b57fe9..74e22e36b3c8 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4596,3 +4596,12 @@ Architectures: s390
 This capability indicates that kvm will implement the interfaces to handle
 reset, migration and nested KVM for branch prediction blocking. The stfle
 facility 82 should not be provided to the guest without this capability.
+
+8.14 KVM_CAP_HYPERV_TLBFLUSH
+
+Architectures: x86
+
+This capability indicates that KVM supports paravirtualized Hyper-V TLB Flush
+hypercalls:
+HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
+HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51ecd381793b..c6784ea69dc6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2864,6 +2864,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_SYNIC2:
 	case KVM_CAP_HYPERV_VP_INDEX:
 	case KVM_CAP_HYPERV_EVENTFD:
+	case KVM_CAP_HYPERV_TLBFLUSH:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1065006c9bf5..30c193b43d89 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -941,6 +941,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_HYPERV_TLBFLUSH 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.3
