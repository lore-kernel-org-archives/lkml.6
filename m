Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB80C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE922089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE922089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeJQAlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D504C308FE8F;
        Tue, 16 Oct 2018 16:50:22 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 824002CFD2;
        Tue, 16 Oct 2018 16:50:20 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 03/13] KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
Date:   Tue, 16 Oct 2018 18:50:01 +0200
Message-Id: <20181016165011.6607-4-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Oct 2018 16:50:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enlightened VMCS is opt-in. The current version does not contain all
fields supported by nested VMX so we must not advertise the
corresponding VMX features if enlightened VMCS is enabled.

Userspace is given the enlightened VMCS version supported by KVM as
part of enabling KVM_CAP_HYPERV_ENLIGHTENED_VMCS. The version is to
be advertised to the nested hypervisor, currently done via a cpuid
leaf for Hyper-V.

Suggested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/svm.c              |  9 ++++++++
 arch/x86/kvm/vmx.c              | 37 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              | 15 +++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4b09d4aa9bf4..258fc2c85301 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1179,6 +1179,9 @@ struct kvm_x86_ops {
 	int (*mem_enc_unreg_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 
 	int (*get_msr_feature)(struct kvm_msr_entry *entry);
+
+	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
+				   uint16_t *vmcs_version);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 2936c63bcc2f..47b07211c5b1 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7036,6 +7036,13 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	return ret;
 }
 
+static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
+				   uint16_t *vmcs_version)
+{
+	/* Intel-only feature */
+	return -ENODEV;
+}
+
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = has_svm,
 	.disabled_by_bios = is_disabled,
@@ -7165,6 +7172,8 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.mem_enc_op = svm_mem_enc_op,
 	.mem_enc_reg_region = svm_register_enc_region,
 	.mem_enc_unreg_region = svm_unregister_enc_region,
+
+	.nested_enable_evmcs = nested_enable_evmcs,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 509d4e34dd62..459cdaa0d1cd 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -846,6 +846,13 @@ struct nested_vmx {
 
 	bool change_vmcs01_virtual_apic_mode;
 
+	/*
+	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
+	 * use it. However, VMX features available to L1 will be limited based
+	 * on what the enlightened VMCS supports.
+	 */
+	bool enlightened_vmcs_enabled;
+
 	/* L2 must run next, and mustn't decide to exit to L1. */
 	bool nested_run_pending;
 
@@ -1589,6 +1596,34 @@ static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
 static inline void evmcs_touch_msr_bitmap(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
 
+static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
+			       uint16_t *vmcs_version)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	/* We don't support disabling the feature for simplicity. */
+	if (vmx->nested.enlightened_vmcs_enabled)
+		return 0;
+
+	vmx->nested.enlightened_vmcs_enabled = true;
+
+	/*
+	 * vmcs_version represents the range of supported Enlightened VMCS
+	 * versions: lower 8 bits is the minimal version, higher 8 bits is the
+	 * maximum supported version. KVM supports versions from 1 to
+	 * KVM_EVMCS_VERSION.
+	 */
+	*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
+
+	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
+	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
+	vmx->nested.msrs.exit_ctls_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
+	vmx->nested.msrs.secondary_ctls_high &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
+	vmx->nested.msrs.vmfunc_controls &= ~EVMCS1_UNSUPPORTED_VMFUNC;
+
+	return 0;
+}
+
 static inline bool is_exception_n(u32 intr_info, u8 vector)
 {
 	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
@@ -14505,6 +14540,8 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.pre_enter_smm = vmx_pre_enter_smm,
 	.pre_leave_smm = vmx_pre_leave_smm,
 	.enable_smi_window = enable_smi_window,
+
+	.nested_enable_evmcs = nested_enable_evmcs,
 };
 
 static void vmx_cleanup_l1d_flush(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eee871ad4ade..50f308499ce5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2913,6 +2913,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_EVENTFD:
 	case KVM_CAP_HYPERV_TLBFLUSH:
 	case KVM_CAP_HYPERV_SEND_IPI:
+	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -3700,6 +3701,10 @@ static int kvm_set_guest_paused(struct kvm_vcpu *vcpu)
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 				     struct kvm_enable_cap *cap)
 {
+	int r;
+	uint16_t vmcs_version;
+	void __user *user_ptr;
+
 	if (cap->flags)
 		return -EINVAL;
 
@@ -3712,6 +3717,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 		return kvm_hv_activate_synic(vcpu, cap->cap ==
 					     KVM_CAP_HYPERV_SYNIC2);
+	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
+		r = kvm_x86_ops->nested_enable_evmcs(vcpu, &vmcs_version);
+		if (!r) {
+			user_ptr = (void __user *)(uintptr_t)cap->args[0];
+			if (copy_to_user(user_ptr, &vmcs_version,
+					 sizeof(vmcs_version)))
+				r = -EFAULT;
+		}
+		return r;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7785678caedb..a67ea86edb0b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -956,6 +956,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_MSR_PLATFORM_INFO 159
 #define KVM_CAP_PPC_NESTED_HV 160
 #define KVM_CAP_HYPERV_SEND_IPI 161
+#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 162
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.1

