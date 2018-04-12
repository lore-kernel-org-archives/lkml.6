Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeDLUTc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:19:32 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:43546 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeDLUT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:19:28 -0400
X-IronPort-AV: E=Sophos;i="5.48,443,1517875200";
   d="scan'208";a="715754166"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
Date: Thu, 12 Apr 2018 22:19:07 +0200
Message-Id: <1523564347-8896-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523564347-8896-1-git-send-email-karahmed@amazon.de>
References: <1523564347-8896-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

For nested virtualization L0 KVM is managing a bit of state for L2 guests,
this state can not be captured through the currently available IOCTLs. In
fact the state captured through all of these IOCTLs is usually a mix of L1
and L2 state. It is also dependent on whether the L2 guest was running at
the moment when the process was interrupted to save its state.

With this capability, there are two new vcpu ioctls: KVM_GET_VMX_STATE and
KVM_SET_VMX_STATE. These can be used for saving and restoring a VM that is
in VMX operation.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
[karahmed@ - rename structs and functions and make them ready for AMD and
             address previous comments.
           - rebase & a bit of refactoring.
           - Merge 7/8 and 8/8 into one patch.
           - Force a VMExit from L2 after reading the kvm_state to avoid
             mixed state between L1 and L2 on resurrecting the instance. ]
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v3 -> v4:
- Rename function to have _nested

v2 -> v3:
- Remove the forced VMExit from L2 after reading the kvm_state. The actual
  problem is solved.
- Rebase again!
- Set nested_run_pending during restore (not sure if it makes sense yet or
  not).
- Reduce KVM_REQUEST_ARCH_BASE to 7 instead of 8 (the other alternative is
  to switch everything to u64)

v1 -> v2:
- Rename structs and functions and make them ready for AMD and address
  previous comments.
- Rebase & a bit of refactoring.
- Merge 7/8 and 8/8 into one patch.
- Force a VMExit from L2 after reading the kvm_state to avoid mixed state
  between L1 and L2 on resurrecting the instance.
---
 Documentation/virtual/kvm/api.txt |  46 ++++++++++
 arch/x86/include/asm/kvm_host.h   |   7 ++
 arch/x86/include/uapi/asm/kvm.h   |  38 ++++++++
 arch/x86/kvm/vmx.c                | 180 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                |  21 +++++
 include/linux/kvm_host.h          |   2 +-
 include/uapi/linux/kvm.h          |   4 +
 7 files changed, 293 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1c7958b..435e6cb 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3548,6 +3548,52 @@ Returns: 0 on success,
 	-ENOENT on deassign if the conn_id isn't registered
 	-EEXIST on assign if the conn_id is already registered
 
+4.114 KVM_GET_NESTED_STATE
+
+Capability: KVM_CAP_NESTED_STATE
+Architectures: x86
+Type: vcpu ioctl
+Parameters: struct kvm_nested_state (in/out)
+Returns: 0 on success, -1 on error
+Errors:
+  E2BIG:     the data size exceeds the value of 'size' specified by
+             the user (the size required will be written into size).
+
+struct kvm_nested_state {
+	__u16 flags;
+	__u16 format;
+	__u32 size;
+	union {
+		struct kvm_vmx_nested_state vmx;
+		struct kvm_svm_nested_state svm;
+		__u8 pad[120];
+	};
+	__u8 data[0];
+};
+
+This ioctl copies the vcpu's kvm_nested_state struct from the kernel to userspace.
+
+4.115 KVM_SET_NESTED_STATE
+
+Capability: KVM_CAP_NESTED_STATE
+Architectures: x86
+Type: vcpu ioctl
+Parameters: struct kvm_nested_state (in)
+Returns: 0 on success, -1 on error
+
+struct kvm_nested_state {
+	__u16 flags;
+	__u16 format;
+	__u32 size;
+	union {
+		struct kvm_vmx_nested_state vmx;
+		struct kvm_svm_nested_state svm;
+		__u8 pad[120];
+	};
+	__u8 data[0];
+};
+
+This copies the vcpu's kvm_nested_state struct from userspace to the kernel.
 
 5. The kvm_run structure
 ------------------------
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3bedfef..a40a32e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -75,6 +75,7 @@
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
+#define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -1085,6 +1086,12 @@ struct kvm_x86_ops {
 
 	void (*setup_mce)(struct kvm_vcpu *vcpu);
 
+	int (*get_nested_state)(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state);
+	int (*set_nested_state)(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state);
+	void (*get_vmcs12_pages)(struct kvm_vcpu *vcpu);
+
 	int (*smi_allowed)(struct kvm_vcpu *vcpu);
 	int (*pre_enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
 	int (*pre_leave_smm)(struct kvm_vcpu *vcpu, u64 smbase);
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index c535c2f..5c69299 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -378,4 +378,42 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define KVM_STATE_GUEST_MODE	0x00000001
+#define KVM_STATE_RUN_PENDING	0x00000002
+#define KVM_STATE_GIF		0x00000004
+
+struct kvm_vmx_nested_state {
+	__u64 vmxon_pa;
+	__u64 vmcs_pa;
+};
+
+struct kvm_svm_nested_state {
+	__u64 hsave_pa;
+	__u64 vmcb_pa;
+};
+
+/* for KVM_CAP_STATE */
+struct kvm_nested_state {
+	/* KVM_STATE_* flags */
+	__u16 flags;
+
+	/* 0 for VMX, 1 for SVM.  */
+	__u16 format;
+
+	/* 128 for SVM, 128 + VMCS size for VMX.  */
+	__u32 size;
+
+	union {
+		/* VMXON, VMCS */
+		struct kvm_vmx_nested_state vmx;
+		/* HSAVE_PA, VMCB */
+		struct kvm_svm_nested_state svm;
+
+		/* Pad the union to 120 bytes.  */
+		__u8 pad[120];
+	};
+
+	__u8 data[0];
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9e7dd39..bfbc9ab 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10364,10 +10364,10 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
 static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12);
 
-static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
-					struct vmcs12 *vmcs12)
+static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
 		if (vmcs12->apic_access_addr != vmx->nested.apic_access_mapping.gfn << PAGE_SHIFT) {
@@ -11432,8 +11432,6 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
 		return 1;
 	}
 
-	nested_get_vmcs12_pages(vcpu, vmcs12);
-
 	msr_entry_idx = nested_vmx_load_msr(vcpu,
 					    vmcs12->vm_entry_msr_load_addr,
 					    vmcs12->vm_entry_msr_load_count);
@@ -11534,6 +11532,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (ret)
 		return ret;
 
+	nested_get_vmcs12_pages(vcpu);
+
 	/*
 	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
 	 * by event injection, halt vcpu.
@@ -12603,6 +12603,174 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int get_vmcs_cache(struct kvm_vcpu *vcpu,
+			  struct kvm_nested_state __user *user_kvm_nested_state)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	/*
+	 * When running L2, the authoritative vmcs12 state is in the
+	 * vmcs02. When running L1, the authoritative vmcs12 state is
+	 * in the shadow vmcs linked to vmcs01, unless
+	 * sync_shadow_vmcs is set, in which case, the authoritative
+	 * vmcs12 state is in the vmcs12 already.
+	 */
+	if (is_guest_mode(vcpu))
+		sync_vmcs12(vcpu, vmcs12);
+	else if (enable_shadow_vmcs && !vmx->nested.sync_shadow_vmcs)
+		copy_shadow_to_vmcs12(vmx);
+
+	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state)
+{
+	u32 user_data_size;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_nested_state kvm_state = {
+		.flags = 0,
+		.format = 0,
+		.size = sizeof(kvm_state),
+		.vmx.vmxon_pa = -1ull,
+		.vmx.vmcs_pa = -1ull,
+	};
+
+	if (copy_from_user(&user_data_size, &user_kvm_nested_state->size,
+			   sizeof(user_data_size)))
+		return -EFAULT;
+
+	if (nested_vmx_allowed(vcpu) && vmx->nested.vmxon) {
+		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
+		kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
+
+		if (vmx->nested.current_vmptr != -1ull)
+			kvm_state.size += VMCS12_SIZE;
+
+		if (is_guest_mode(vcpu)) {
+			kvm_state.flags |= KVM_STATE_GUEST_MODE;
+
+			if (vmx->nested.nested_run_pending)
+				kvm_state.flags |= KVM_STATE_RUN_PENDING;
+		}
+	}
+
+	if (user_data_size < kvm_state.size) {
+		if (copy_to_user(&user_kvm_nested_state->size, &kvm_state.size,
+				 sizeof(kvm_state.size)))
+			return -EFAULT;
+		return -E2BIG;
+	}
+
+	if (copy_to_user(user_kvm_nested_state, &kvm_state, sizeof(kvm_state)))
+		return -EFAULT;
+
+	if (vmx->nested.current_vmptr == -1ull)
+		return 0;
+
+	return get_vmcs_cache(vcpu, user_kvm_nested_state);
+}
+
+static int set_vmcs_cache(struct kvm_vcpu *vcpu,
+			  struct kvm_nested_state __user *user_kvm_nested_state,
+			  struct kvm_nested_state *kvm_state)
+
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	u32 exit_qual;
+	int ret;
+
+	if ((kvm_state->size < (sizeof(*vmcs12) + sizeof(*kvm_state))) ||
+	    kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
+	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
+		return -EINVAL;
+
+	if (copy_from_user(vmcs12, user_kvm_nested_state->data, sizeof(*vmcs12)))
+		return -EFAULT;
+
+	if (vmcs12->revision_id != VMCS12_REVISION)
+		return -EINVAL;
+
+	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
+
+	if (!(kvm_state->flags & KVM_STATE_GUEST_MODE))
+		return 0;
+
+	if (kvm_state->flags & KVM_STATE_RUN_PENDING)
+		vmx->nested.nested_run_pending = 1;
+
+	if (check_vmentry_prereqs(vcpu, vmcs12) ||
+	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
+		return -EINVAL;
+
+	ret = enter_vmx_non_root_mode(vcpu, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * The MMU is not initialized to point at the right entities yet and
+	 * "get pages" would need to read data from the guest (i.e. we will
+	 * need to perform gpa to hpa translation). So, This request will
+	 * result in a call to nested_get_vmcs12_pages before the next
+	 * VM-entry.
+	 */
+	kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
+
+	vmx->nested.nested_run_pending = 1;
+
+	return 0;
+}
+
+static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_nested_state kvm_state;
+	int ret;
+
+	if (copy_from_user(&kvm_state, user_kvm_nested_state, sizeof(kvm_state)))
+		return -EFAULT;
+
+	if (kvm_state.size < sizeof(kvm_state))
+		return -EINVAL;
+
+	if (kvm_state.format != 0)
+		return -EINVAL;
+
+	if (kvm_state.flags &
+	    ~(KVM_STATE_RUN_PENDING | KVM_STATE_GUEST_MODE))
+		return -EINVAL;
+
+	if (!nested_vmx_allowed(vcpu))
+		return kvm_state.vmx.vmxon_pa == -1ull ? 0 : -EINVAL;
+
+	vmx_leave_nested(vcpu);
+
+	vmx->nested.nested_run_pending =
+		!!(kvm_state.flags & KVM_STATE_RUN_PENDING);
+
+	if (kvm_state.vmx.vmxon_pa == -1ull)
+		return 0;
+
+	if (!page_address_valid(vcpu, kvm_state.vmx.vmxon_pa))
+		return -EINVAL;
+
+	vmx->nested.vmxon_ptr = kvm_state.vmx.vmxon_pa;
+	ret = enter_vmx_operation(vcpu);
+	if (ret)
+		return ret;
+
+	if (kvm_state.vmx.vmcs_pa == -1ull)
+		return 0;
+
+	return set_vmcs_cache(vcpu, user_kvm_nested_state, &kvm_state);
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -12737,6 +12905,10 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 
 	.setup_mce = vmx_setup_mce,
 
+	.get_nested_state = vmx_get_nested_state,
+	.set_nested_state = vmx_set_nested_state,
+	.get_vmcs12_pages = nested_get_vmcs12_pages,
+
 	.smi_allowed = vmx_smi_allowed,
 	.pre_enter_smm = vmx_pre_enter_smm,
 	.pre_leave_smm = vmx_pre_leave_smm,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3fb1353..7a7c3fa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2931,6 +2931,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_X2APIC_API:
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
+	case KVM_CAP_STATE:
+		r = !!kvm_x86_ops->get_nested_state;
+		break;
 	default:
 		break;
 	}
@@ -3949,6 +3952,22 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
+	case KVM_GET_NESTED_STATE: {
+		struct kvm_nested_state __user *user_kvm_nested_state = argp;
+
+		r = -EINVAL;
+		if (kvm_x86_ops->get_nested_state)
+			r = kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state);
+		break;
+	}
+	case KVM_SET_NESTED_STATE: {
+		struct kvm_nested_state __user *user_kvm_nested_state = argp;
+
+		r = -EINVAL;
+		if (kvm_x86_ops->set_nested_state)
+			r = kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state);
+		break;
+	}
 	default:
 		r = -EINVAL;
 	}
@@ -7222,6 +7241,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
+		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
+			kvm_x86_ops->get_vmcs12_pages(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
 			kvm_mmu_unload(vcpu);
 		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7a2889a..001b122 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -126,7 +126,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_MMU_RELOAD        (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_PENDING_TIMER     2
 #define KVM_REQ_UNHALT            3
-#define KVM_REQUEST_ARCH_BASE     8
+#define KVM_REQUEST_ARCH_BASE     7
 
 #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
 	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 077d16f..98fdedc 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -961,6 +961,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_STATE 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1403,6 +1404,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
 
+/* Available with KVM_CAP_STATE */
+#define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
+#define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.7.4
