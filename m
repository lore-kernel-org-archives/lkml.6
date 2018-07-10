Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA28C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9279208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="N04AeWp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9279208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbeGJJ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:28:10 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31932 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeGJJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1531214888; x=1562750888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//ZbgxAnVCf+PDaIWkvJifa7JerNqcYEFp7xDQ/eGZ4=;
  b=N04AeWp8pFxHqDyt7I0FAL8epl99LJrhOBPC50MU0vVUN97XUz9XdpzA
   XIdxAhF4aQ35PTAwrpZv875+Q4oJ0NzH4oncZeEU88KFWJBSaHm+kYavI
   bENJlbME+1YR7NfC3++KKZW8FCYN/eOf4NAg+dvdxCSMTFdVJT+VgN9zb
   4=;
X-IronPort-AV: E=Sophos;i="5.51,333,1526342400"; 
   d="scan'208";a="749072693"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jul 2018 09:27:40 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w6A9RT9n078113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 Jul 2018 09:27:32 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w6A9RSrO024917;
        Tue, 10 Jul 2018 11:27:29 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w6A9RSra024916;
        Tue, 10 Jul 2018 11:27:28 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v5 2/2] kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
Date:   Tue, 10 Jul 2018 11:27:20 +0200
Message-Id: <1531214840-24686-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
References: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

For nested virtualization L0 KVM is managing a bit of state for L2 guests,
this state can not be captured through the currently available IOCTLs. In
fact the state captured through all of these IOCTLs is usually a mix of L1
and L2 state. It is also dependent on whether the L2 guest was running at
the moment when the process was interrupted to save its state.

With this capability, there are two new vcpu ioctls: KVM_GET_NESTED_STATE
and KVM_SET_NESTED_STATE. These can be used for saving and restoring a VM
that is in VMX operation.

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
           - handle nested.smm state.
           - rebase & a bit of refactoring.
           - Merge 7/8 and 8/8 into one patch. ]
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v4 -> v5:
- Drop the update to KVM_REQUEST_ARCH_BASE in favor of a patch to switch to
  u64 instead.
- Fix commit message.
- Handle nested.smm state as well.
- rebase

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
 Documentation/virtual/kvm/api.txt |  46 +++++++++
 arch/x86/include/asm/kvm_host.h   |   7 ++
 arch/x86/include/uapi/asm/kvm.h   |  45 +++++++++
 arch/x86/kvm/vmx.c                | 202 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                |  21 ++++
 include/uapi/linux/kvm.h          |   4 +
 6 files changed, 322 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d10944e..925c509 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3561,6 +3561,52 @@ Returns: 0 on success,
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
index 0dab702..2e8eb08 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -75,6 +75,7 @@
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
+#define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -1087,6 +1088,12 @@ struct kvm_x86_ops {
 
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
index c535c2f..f653d3c 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -378,4 +378,49 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define KVM_STATE_NESTED_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+#define KVM_STATE_NESTED_GIF		0x00000004
+
+#define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_SMM_VMXON	0x00000002
+
+struct kvm_vmx_nested_state {
+	__u64 vmxon_pa;
+	__u64 vmcs_pa;
+
+	struct {
+		__u16 flags;
+	} smm;
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
index 1689f43..892ad04 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10635,9 +10635,9 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
 static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12);
 
-static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
-					struct vmcs12 *vmcs12)
+static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct page *page;
 	u64 hpa;
@@ -11772,7 +11772,6 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
 	if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
 		goto fail;
 
-	nested_get_vmcs12_pages(vcpu, vmcs12);
 
 	r = EXIT_REASON_MSR_LOAD_FAIL;
 	msr_entry_idx = nested_vmx_load_msr(vcpu,
@@ -11878,6 +11877,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		return ret;
 	}
 
+	nested_get_vmcs12_pages(vcpu);
+
 	/*
 	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
 	 * by event injection, halt vcpu.
@@ -12976,6 +12977,197 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
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
+	if (nested_vmx_allowed(vcpu) &&
+	    (vmx->nested.vmxon || vmx->nested.smm.vmxon)) {
+		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
+		kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
+
+		if (vmx->nested.current_vmptr != -1ull)
+			kvm_state.size += VMCS12_SIZE;
+
+		if (vmx->nested.smm.vmxon)
+			kvm_state.vmx.smm.flags |= KVM_STATE_NESTED_SMM_VMXON;
+
+		if (vmx->nested.smm.guest_mode)
+			kvm_state.vmx.smm.flags |= KVM_STATE_NESTED_SMM_GUEST_MODE;
+
+		if (is_guest_mode(vcpu)) {
+			kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
+
+			if (vmx->nested.nested_run_pending)
+				kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
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
+	if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
+	    (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
+		return -EINVAL;
+
+	if (vmx->nested.vmxon &&
+	    (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON))
+		return -EINVAL;
+
+	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE)
+		vmx->nested.smm.guest_mode = true;
+
+	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
+		vmx->nested.smm.vmxon = true;
+		vmx->nested.vmxon = false;
+	}
+
+	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
+		return 0;
+
+	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
+		vmx->nested.nested_run_pending = 1;
+
+	if (check_vmentry_prereqs(vcpu, vmcs12) ||
+	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
+		return -EINVAL;
+
+	ret = enter_vmx_non_root_mode(vcpu);
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
+	    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE))
+		return -EINVAL;
+
+	if (!nested_vmx_allowed(vcpu))
+		return kvm_state.vmx.vmxon_pa == -1ull ? 0 : -EINVAL;
+
+	vmx_leave_nested(vcpu);
+
+	vmx->nested.nested_run_pending =
+		!!(kvm_state.flags & KVM_STATE_NESTED_RUN_PENDING);
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
@@ -13110,6 +13302,10 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 
 	.setup_mce = vmx_setup_mce,
 
+	.get_nested_state = vmx_get_nested_state,
+	.set_nested_state = vmx_set_nested_state,
+	.get_vmcs12_pages = nested_get_vmcs12_pages,
+
 	.smi_allowed = vmx_smi_allowed,
 	.pre_enter_smm = vmx_pre_enter_smm,
 	.pre_leave_smm = vmx_pre_leave_smm,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1b37f2f..2ec6cb9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2943,6 +2943,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_X2APIC_API:
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
+	case KVM_CAP_STATE:
+		r = !!kvm_x86_ops->get_nested_state;
+		break;
 	default:
 		break;
 	}
@@ -3961,6 +3964,22 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -7309,6 +7328,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
+		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
+			kvm_x86_ops->get_vmcs12_pages(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
 			kvm_mmu_unload(vcpu);
 		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 277cd86..a717e10 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -963,6 +963,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_STATE 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1405,6 +1406,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
 
+/* Available with KVM_CAP_STATE */
+#define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
+#define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.7.4

