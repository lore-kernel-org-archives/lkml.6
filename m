Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D907AC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE120878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxPJRMwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADE120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeG2AjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:39:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbeG2Aig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so8703295wrw.13;
        Sat, 28 Jul 2018 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZYCMSjgNi38EV8BQj5n+Oqo/NeG5eX+n1EmttJIpkw=;
        b=kxPJRMwoy2NmfURtgNyXaDSPo8DCmmS/SY0ee1nt8JjuVQ4BnqrnVSzZjlsyZ5ZJkZ
         GgK0YHepWECB7NhcJJtH1Fg5j92XjgK75e+J1f3pd5KEotOMlwdFFSwo0h/aUrTcoRfM
         4j03vK0w74oblU0fRHH7tqckTK6snbzZbR6+ToD0E5MzIR8S0QPFmc58OcqvOeIqgC0c
         /QHzljJjwI7H0Lt9HEBX/mfrx6bSWcZ4972xTK2fIjEyRsEocqI/QPR9UYPOcb4yqY9D
         UE8Gtq1WsGc/8ENmlb9tj/McMF5Ng5PqmzuQv6Re7zK5jM11G17ZacsiFCO9oPd5Ikld
         J4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aZYCMSjgNi38EV8BQj5n+Oqo/NeG5eX+n1EmttJIpkw=;
        b=msLZ/L7MUUEOckpcxrYkHRt71JiVU022vlr3jDB3OhHKeJDZA70EFfpMZKJ3Y04mto
         oB2vy7BWdiulVy8NPiR6NHKgnmpwP49yiiKTR93CNhaey9S3LKWgfyjN3ukwsrhVASFy
         LNjIBN8YZEQLqjHBSSLMfvRquo/Q5nJlXE9/gAiFUBC7M64VAVcCk8gSbgBswuwAfAHi
         K8Wo+bU9XQRvp340qT3yqwlXrGllaoW5O24Z3r1wlv78fAFZpUwUyQ96wI5dPf2zThea
         VYewYpKNx1bNBWEcPHmfuwLToOVbTZj3kkktrqRuotQpfAE3qtKuHYw3sFsjs0HC0n7+
         LlFw==
X-Gm-Message-State: AOUpUlEzQ8uKmlcAwURFLbBSQRsJRGDuZardykv29s6IMpTinWt21tNg
        dnEGH+wuDNkH81bPUcUEn2tP7ZaV
X-Google-Smtp-Source: AAOMgpcNUBEKbOtYuiH6U7hM4pA3j/a4DCUSlJjqt1iCu8bHhTjleYVkgISjWtm5UC66rhu/7P1B2w==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr10836183wro.256.1532819425028;
        Sat, 28 Jul 2018 16:10:25 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:24 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 07/10] kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
Date:   Sun, 29 Jul 2018 01:10:09 +0200
Message-Id: <1532819412-51357-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
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

Signed-off-by: Jim Mattson <jmattson@google.com>
[karahmed@ - rename structs and functions and make them ready for AMD and
             address previous comments.
           - handle nested.smm state.
           - rebase & a bit of refactoring.
           - Merge 7/8 and 8/8 into one patch. ]
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virtual/kvm/api.txt |  52 ++++++++++++
 arch/x86/include/asm/kvm_host.h   |   6 ++
 arch/x86/include/uapi/asm/kvm.h   |  37 +++++++++
 arch/x86/kvm/vmx.c                | 167 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                |  54 ++++++++++++
 include/uapi/linux/kvm.h          |   4 +
 6 files changed, 320 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d10944e619d3..84504566c4ff 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3561,6 +3561,62 @@ Returns: 0 on success,
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
+  E2BIG:     the total state size (including the fixed-size part of struct
+             kvm_nested_state) exceeds the value of 'size' specified by
+             the user; the size required will be written into size.
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
+#define KVM_STATE_NESTED_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_RUN_PENDING	0x00000002
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
+This ioctl copies the vcpu's nested virtualization state from the kernel to
+userspace.
+
+The maximum size of the state, including the fixed-size part of struct
+kvm_nested_state, can be retrieved by passing KVM_CAP_NESTED_STATE to
+the KVM_CHECK_EXTENSION ioctl().
+
+4.115 KVM_SET_NESTED_STATE
+
+Capability: KVM_CAP_NESTED_STATE
+Architectures: x86
+Type: vcpu ioctl
+Parameters: struct kvm_nested_state (in)
+Returns: 0 on success, -1 on error
+
+This copies the vcpu's kvm_nested_state struct from userspace to the kernel.  For
+the definition of struct kvm_nested_state, see KVM_GET_NESTED_STATE.
 
 5. The kvm_run structure
 ------------------------
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index da957725992d..bd287b348751 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1086,6 +1086,12 @@ struct kvm_x86_ops {
 
 	void (*setup_mce)(struct kvm_vcpu *vcpu);
 
+	int (*get_nested_state)(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state,
+				unsigned user_data_size);
+	int (*set_nested_state)(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state,
+				struct kvm_nested_state *kvm_state);
 	void (*get_vmcs12_pages)(struct kvm_vcpu *vcpu);
 
 	int (*smi_allowed)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index c535c2fdea13..86299efa804a 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -378,4 +378,41 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define KVM_STATE_NESTED_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_RUN_PENDING	0x00000002
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
+/* for KVM_CAP_NESTED_STATE */
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
+
+		/* Pad the header to 128 bytes.  */
+		__u8 pad[120];
+	};
+
+	__u8 data[0];
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 17aede06ae0e..4168a40b9d5c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7565,6 +7565,11 @@ static __init int hardware_setup(void)
 	else
 		kvm_disable_tdp();
 
+	if (!nested) {
+		kvm_x86_ops->get_nested_state = NULL;
+		kvm_x86_ops->set_nested_state = NULL;
+	}
+
 	/*
 	 * Only enable PML when hardware supports PML feature, and both EPT
 	 * and EPT A/D bit features are enabled -- PML depends on them to work.
@@ -12992,6 +12997,170 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state,
+				u32 user_data_size)
+{
+	struct vcpu_vmx *vmx;
+	struct vmcs12 *vmcs12;
+	struct kvm_nested_state kvm_state = {
+		.flags = 0,
+		.format = 0,
+		.size = sizeof(kvm_state),
+		.vmx.vmxon_pa = -1ull,
+		.vmx.vmcs_pa = -1ull,
+	};
+
+	if (!vcpu)
+		return kvm_state.size + 2 * VMCS12_SIZE;
+
+	vmx = to_vmx(vcpu);
+	vmcs12 = get_vmcs12(vcpu);
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
+	if (user_data_size < kvm_state.size)
+		goto out;
+
+	if (copy_to_user(user_kvm_nested_state, &kvm_state, sizeof(kvm_state)))
+		return -EFAULT;
+
+	if (vmx->nested.current_vmptr == -1ull)
+		goto out;
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
+out:
+	return kvm_state.size;
+}
+
+static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
+				struct kvm_nested_state __user *user_kvm_nested_state,
+				struct kvm_nested_state *kvm_state)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs12 *vmcs12;
+	u32 exit_qual;
+	int ret;
+
+	if (kvm_state->format != 0)
+		return -EINVAL;
+
+	if (!nested_vmx_allowed(vcpu))
+		return kvm_state->vmx.vmxon_pa == -1ull ? 0 : -EINVAL;
+
+	if (kvm_state->vmx.vmxon_pa == -1ull) {
+		if (kvm_state->vmx.smm.flags)
+			return -EINVAL;
+
+		if (kvm_state->vmx.vmcs_pa != -1ull)
+			return -EINVAL;
+
+		vmx_leave_nested(vcpu);
+		return 0;
+	}
+
+	if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
+		return -EINVAL;
+
+	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
+		return -EINVAL;
+
+	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
+	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
+		return -EINVAL;
+
+	if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
+	    (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
+		return -EINVAL;
+
+	if (kvm_state->vmx.smm.flags &
+	    ~(KVM_STATE_NESTED_SMM_GUEST_MODE | KVM_STATE_NESTED_SMM_VMXON))
+		return -EINVAL;
+
+	if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
+	    !(kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON))
+		return -EINVAL;
+
+	vmx_leave_nested(vcpu);
+	if (kvm_state->vmx.vmxon_pa == -1ull)
+		return 0;
+
+	vmx->nested.vmxon_ptr = kvm_state->vmx.vmxon_pa;
+	ret = enter_vmx_operation(vcpu);
+	if (ret)
+		return ret;
+
+	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
+
+	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
+		vmx->nested.smm.vmxon = true;
+		vmx->nested.vmxon = false;
+
+		if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE)
+			vmx->nested.smm.guest_mode = true;
+	}
+
+	vmcs12 = get_vmcs12(vcpu);
+	if (copy_from_user(vmcs12, user_kvm_nested_state->data, sizeof(*vmcs12)))
+		return -EFAULT;
+
+	if (vmcs12->revision_id != VMCS12_REVISION)
+		return -EINVAL;
+
+	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
+		return 0;
+
+	vmx->nested.nested_run_pending =
+		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
+
+	if (check_vmentry_prereqs(vcpu, vmcs12) ||
+	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
+		return -EINVAL;
+
+	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
+		vmx->nested.nested_run_pending = 1;
+
+	vmx->nested.dirty_vmcs12 = true;
+	ret = enter_vmx_non_root_mode(vcpu, NULL);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -13126,6 +13291,8 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 
 	.setup_mce = vmx_setup_mce,
 
+	.get_nested_state = vmx_get_nested_state,
+	.set_nested_state = vmx_set_nested_state,
 	.get_vmcs12_pages = nested_get_vmcs12_pages,
 
 	.smi_allowed = vmx_smi_allowed,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ddf5f94876f..b1327b211452 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2944,6 +2944,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_X2APIC_API:
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
+	case KVM_CAP_NESTED_STATE:
+		r = kvm_x86_ops->get_nested_state ?
+			kvm_x86_ops->get_nested_state(NULL, 0, 0) : 0;
+		break;
 	default:
 		break;
 	}
@@ -3960,6 +3964,56 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
+	case KVM_GET_NESTED_STATE: {
+		struct kvm_nested_state __user *user_kvm_nested_state = argp;
+		u32 user_data_size;
+
+		r = -EINVAL;
+		if (!kvm_x86_ops->get_nested_state)
+			break;
+
+		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
+		if (get_user(user_data_size, &user_kvm_nested_state->size))
+			return -EFAULT;
+
+		r = kvm_x86_ops->get_nested_state(vcpu, user_kvm_nested_state,
+						  user_data_size);
+		if (r < 0)
+			return r;
+
+		if (r > user_data_size) {
+			if (put_user(r, &user_kvm_nested_state->size))
+				return -EFAULT;
+			return -E2BIG;
+		}
+		r = 0;
+		break;
+	}
+	case KVM_SET_NESTED_STATE: {
+		struct kvm_nested_state __user *user_kvm_nested_state = argp;
+		struct kvm_nested_state kvm_state;
+
+		r = -EINVAL;
+		if (!kvm_x86_ops->set_nested_state)
+			break;
+
+		if (copy_from_user(&kvm_state, user_kvm_nested_state, sizeof(kvm_state)))
+			return -EFAULT;
+
+		if (kvm_state.size < sizeof(kvm_state))
+			return -EINVAL;
+
+		if (kvm_state.flags &
+		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE))
+			return -EINVAL;
+
+		/* nested_run_pending implies guest_mode.  */
+		if (kvm_state.flags == KVM_STATE_NESTED_RUN_PENDING)
+			return -EINVAL;
+
+		r = kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &kvm_state);
+		break;
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3b38e9..c2e91c28e09d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_NESTED_STATE 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1391,6 +1392,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
 
+/* Available with KVM_CAP_NESTED_STATE */
+#define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
+#define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
1.8.3.1

