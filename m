Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeEKNjD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:39:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753079AbeEKNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:37:59 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: [PATCH RFC v2 2/5] KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
Date: Fri, 11 May 2018 15:37:48 +0200
Message-Id: <20180511133751.13414-3-vkuznets@redhat.com>
In-Reply-To: <20180511133751.13414-1-vkuznets@redhat.com>
References: <20180511133751.13414-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
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
---
 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/svm.c              |   9 +++
 arch/x86/kvm/vmx.c              | 138 ++++++++++++++++++++++------------------
 arch/x86/kvm/x86.c              |  15 +++++
 include/uapi/linux/kvm.h        |   1 +
 5 files changed, 105 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c25775fad4ed..13cc21aa9917 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1093,6 +1093,9 @@ struct kvm_x86_ops {
 	int (*mem_enc_unreg_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 
 	int (*get_msr_feature)(struct kvm_msr_entry *entry);
+
+	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
+				   uint16_t *vmcs_version);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 80ea26274a54..7d77d7f2171c 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7004,6 +7004,13 @@ static int svm_unregister_enc_region(struct kvm *kvm,
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
@@ -7130,6 +7137,8 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.mem_enc_op = svm_mem_enc_op,
 	.mem_enc_reg_region = svm_register_enc_region,
 	.mem_enc_unreg_region = svm_unregister_enc_region,
+
+	.nested_enable_evmcs = nested_enable_evmcs,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5b49ad448ad6..9c6d1b4c31f4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -482,6 +482,13 @@ struct nested_vmx {
 	bool sync_shadow_vmcs;
 	bool dirty_vmcs12;
 
+	/*
+	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
+	 * use it. However, VMX features available to L1 will be limited based
+	 * on what the enlightened VMCS supports.
+	 */
+	bool enlightened_vmcs_enabled;
+
 	bool change_vmcs01_virtual_x2apic_mode;
 	/* L2 must run next, and mustn't decide to exit to L1. */
 	bool nested_run_pending;
@@ -1019,6 +1026,49 @@ DEFINE_STATIC_KEY_FALSE(enable_evmcs);
 
 #define KVM_EVMCS_VERSION 1
 
+/*
+ * Enlightened VMCSv1 doesn't support these:
+ *
+ *	POSTED_INTR_NV                  = 0x00000002,
+ *	GUEST_INTR_STATUS               = 0x00000810,
+ *	APIC_ACCESS_ADDR		= 0x00002014,
+ *	POSTED_INTR_DESC_ADDR           = 0x00002016,
+ *	EOI_EXIT_BITMAP0                = 0x0000201c,
+ *	EOI_EXIT_BITMAP1                = 0x0000201e,
+ *	EOI_EXIT_BITMAP2                = 0x00002020,
+ *	EOI_EXIT_BITMAP3                = 0x00002022,
+ *	GUEST_PML_INDEX			= 0x00000812,
+ *	PML_ADDRESS			= 0x0000200e,
+ *	VM_FUNCTION_CONTROL             = 0x00002018,
+ *	EPTP_LIST_ADDRESS               = 0x00002024,
+ *	VMREAD_BITMAP                   = 0x00002026,
+ *	VMWRITE_BITMAP                  = 0x00002028,
+ *
+ *	TSC_MULTIPLIER                  = 0x00002032,
+ *	PLE_GAP                         = 0x00004020,
+ *	PLE_WINDOW                      = 0x00004022,
+ *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
+ *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
+ *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
+ *
+ * Currently unsupported in KVM:
+ *	GUEST_IA32_RTIT_CTL		= 0x00002814,
+ */
+#define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
+				    PIN_BASED_VMX_PREEMPTION_TIMER)
+#define EVMCS1_UNSUPPORTED_2NDEXEC					\
+	(SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |				\
+	 SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |			\
+	 SECONDARY_EXEC_APIC_REGISTER_VIRT |				\
+	 SECONDARY_EXEC_ENABLE_PML |					\
+	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
+	 SECONDARY_EXEC_SHADOW_VMCS |					\
+	 SECONDARY_EXEC_TSC_SCALING |					\
+	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
+#define EVMCS1_UNSUPPORTED_VMEXIT_CTRL (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
+#define EVMCS1_UNSUPPORTED_VMENTRY_CTRL (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
+#define EVMCS1_UNSUPPORTED_VMFUNC (VMX_VMFUNC_EPTP_SWITCHING)
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static bool __read_mostly enlightened_vmcs = true;
 module_param(enlightened_vmcs, bool, 0444);
@@ -1101,69 +1151,12 @@ static void evmcs_load(u64 phys_addr)
 
 static void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
 {
-	/*
-	 * Enlightened VMCSv1 doesn't support these:
-	 *
-	 *	POSTED_INTR_NV                  = 0x00000002,
-	 *	GUEST_INTR_STATUS               = 0x00000810,
-	 *	APIC_ACCESS_ADDR		= 0x00002014,
-	 *	POSTED_INTR_DESC_ADDR           = 0x00002016,
-	 *	EOI_EXIT_BITMAP0                = 0x0000201c,
-	 *	EOI_EXIT_BITMAP1                = 0x0000201e,
-	 *	EOI_EXIT_BITMAP2                = 0x00002020,
-	 *	EOI_EXIT_BITMAP3                = 0x00002022,
-	 */
-	vmcs_conf->pin_based_exec_ctrl &= ~PIN_BASED_POSTED_INTR;
-	vmcs_conf->cpu_based_2nd_exec_ctrl &=
-		~SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
-	vmcs_conf->cpu_based_2nd_exec_ctrl &=
-		~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
-	vmcs_conf->cpu_based_2nd_exec_ctrl &=
-		~SECONDARY_EXEC_APIC_REGISTER_VIRT;
-
-	/*
-	 *	GUEST_PML_INDEX			= 0x00000812,
-	 *	PML_ADDRESS			= 0x0000200e,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_PML;
+	vmcs_conf->pin_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_PINCTRL;
+	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
 
-	/*	VM_FUNCTION_CONTROL             = 0x00002018, */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
+	vmcs_conf->vmexit_ctrl &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
+	vmcs_conf->vmentry_ctrl &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
 
-	/*
-	 *	EPTP_LIST_ADDRESS               = 0x00002024,
-	 *	VMREAD_BITMAP                   = 0x00002026,
-	 *	VMWRITE_BITMAP                  = 0x00002028,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_SHADOW_VMCS;
-
-	/*
-	 *	TSC_MULTIPLIER                  = 0x00002032,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_TSC_SCALING;
-
-	/*
-	 *	PLE_GAP                         = 0x00004020,
-	 *	PLE_WINDOW                      = 0x00004022,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
-
-	/*
-	 *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
-	 */
-	vmcs_conf->pin_based_exec_ctrl &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
-
-	/*
-	 *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
-	 *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
-	 */
-	vmcs_conf->vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-	vmcs_conf->vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-
-	/*
-	 * Currently unsupported in KVM:
-	 *	GUEST_IA32_RTIT_CTL		= 0x00002814,
-	 */
 }
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static inline void evmcs_write64(unsigned long field, u64 value) {}
@@ -1176,6 +1169,27 @@ static inline void evmcs_load(u64 phys_addr) {}
 static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
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
@@ -12759,6 +12773,8 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.pre_enter_smm = vmx_pre_enter_smm,
 	.pre_leave_smm = vmx_pre_leave_smm,
 	.enable_smi_window = enable_smi_window,
+
+	.nested_enable_evmcs = nested_enable_evmcs,
 };
 
 static int __init vmx_init(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fcc05e4e0916..0ce227e13d80 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2864,6 +2864,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_SYNIC2:
 	case KVM_CAP_HYPERV_VP_INDEX:
 	case KVM_CAP_HYPERV_EVENTFD:
+	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -3641,6 +3642,10 @@ static int kvm_set_guest_paused(struct kvm_vcpu *vcpu)
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 				     struct kvm_enable_cap *cap)
 {
+	int r;
+	uint16_t vmcs_version;
+	void __user *user_ptr;
+
 	if (cap->flags)
 		return -EINVAL;
 
@@ -3653,6 +3658,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
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
index 1065006c9bf5..bfda0150c856 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -941,6 +941,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.3
