Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDBQLW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:11:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752877AbeDBQLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:11:13 -0400
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
Subject: [PATCH 5/5] KVM: x86: hyperv: declare KVM_CAP_HYPERV_TLBFLUSH capability
Date: Mon,  2 Apr 2018 18:10:59 +0200
Message-Id: <20180402161059.8488-6-vkuznets@redhat.com>
In-Reply-To: <20180402161059.8488-1-vkuznets@redhat.com>
References: <20180402161059.8488-1-vkuznets@redhat.com>
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
index 7d9a444f2f24..a34a068c4663 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2852,6 +2852,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
