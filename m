Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B926222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395261AbfBNJmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:42:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:32197 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395222AbfBNJmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:42:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 01:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="124411713"
Received: from devel-ww.sh.intel.com ([10.239.48.128])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2019 01:42:51 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com, jmattson@google.com
Subject: [PATCH v5 03/12] KVM/x86: KVM_CAP_X86_GUEST_LBR
Date:   Thu, 14 Feb 2019 17:06:05 +0800
Message-Id: <1550135174-5423-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce KVM_CAP_X86_GUEST_LBR to allow per-VM enabling of the guest
lbr feature.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              | 15 +++++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4660ce9..e6f6760 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -869,6 +869,7 @@ struct kvm_arch {
 	atomic_t vapics_in_nmi_mode;
 	struct mutex apic_map_lock;
 	struct kvm_apic_map *apic_map;
+	struct x86_perf_lbr_stack lbr_stack;
 
 	bool apic_access_page_done;
 
@@ -877,6 +878,7 @@ struct kvm_arch {
 	bool mwait_in_guest;
 	bool hlt_in_guest;
 	bool pause_in_guest;
+	bool lbr_in_guest;
 
 	unsigned long irq_sources_bitmap;
 	s64 kvmclock_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d27206..2cdebe7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3028,6 +3028,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_GET_MSR_FEATURES:
 	case KVM_CAP_MSR_PLATFORM_INFO:
 	case KVM_CAP_EXCEPTION_PAYLOAD:
+	case KVM_CAP_X86_GUEST_LBR:
 		r = 1;
 		break;
 	case KVM_CAP_SYNC_REGS:
@@ -4562,6 +4563,20 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.exception_payload_enabled = cap->args[0];
 		r = 0;
 		break;
+	case KVM_CAP_X86_GUEST_LBR:
+		r = -EINVAL;
+		if (cap->args[0] &&
+		    x86_perf_get_lbr_stack(&kvm->arch.lbr_stack)) {
+			pr_err("Failed to enable the guest lbr feature\n");
+			break;
+		}
+		if (copy_to_user((void __user *)cap->args[1],
+				 &kvm->arch.lbr_stack,
+				 sizeof(struct x86_perf_lbr_stack)))
+			break;
+		kvm->arch.lbr_in_guest = cap->args[0];
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6d4ea4b..a7cac96 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_X86_GUEST_LBR 168
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

