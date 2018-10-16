Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E543AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DC321470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DC321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeJQAmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeJQAmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCDDF7F08A;
        Tue, 16 Oct 2018 16:50:48 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE1D6BF7B;
        Tue, 16 Oct 2018 16:50:46 +0000 (UTC)
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
Subject: [PATCH v6 11/13] x86/kvm/nVMX: nested state migration for Enlightened VMCS
Date:   Tue, 16 Oct 2018 18:50:09 +0200
Message-Id: <20181016165011.6607-12-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Oct 2018 16:50:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for get/set of nested state when Enlightened VMCS is in use.
A new KVM_STATE_NESTED_EVMCS flag to indicate eVMCS on the vCPU was enabled
is added.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/vmx.c              | 78 +++++++++++++++++++++++++--------
 arch/x86/kvm/x86.c              |  6 ++-
 3 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index fd23d5778ea1..ab76aa1d3a4d 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -381,6 +381,7 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+#define KVM_STATE_NESTED_EVMCS		0x00000004
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5df47291ad4d..8d7c60faaacd 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1618,7 +1618,8 @@ static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 	 * maximum supported version. KVM supports versions from 1 to
 	 * KVM_EVMCS_VERSION.
 	 */
-	*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
+	if (vmcs_version)
+		*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
 
 	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
 	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
@@ -9338,7 +9339,8 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
  * This is an equivalent of the nested hypervisor executing the vmptrld
  * instruction.
  */
-static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu)
+static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
+						 bool from_launch)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct hv_vp_assist_page assist_page;
@@ -9389,8 +9391,9 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu)
 		 * present in struct hv_enlightened_vmcs, ...). Make sure there
 		 * are no leftovers.
 		 */
-		memset(vmx->nested.cached_vmcs12, 0,
-		       sizeof(*vmx->nested.cached_vmcs12));
+		if (from_launch)
+			memset(vmx->nested.cached_vmcs12, 0,
+			       sizeof(*vmx->nested.cached_vmcs12));
 
 	}
 	return 1;
@@ -11147,6 +11150,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	if (vmx->nested.need_vmcs12_sync) {
+		/*
+		 * hv_evmcs may end up being not mapped after migration (when
+		 * L2 was running), map it here to make sure vmcs12 changes are
+		 * properly reflected.
+		 */
+		if (vmx->nested.enlightened_vmcs_enabled &&
+		    !vmx->nested.hv_evmcs)
+			nested_vmx_handle_enlightened_vmptrld(vcpu, false);
+
 		if (vmx->nested.hv_evmcs) {
 			copy_vmcs12_to_enlightened(vmx);
 			/* All fields are clean */
@@ -13424,7 +13436,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (!nested_vmx_handle_enlightened_vmptrld(vcpu))
+	if (!nested_vmx_handle_enlightened_vmptrld(vcpu, true))
 		return 1;
 
 	if (!vmx->nested.hv_evmcs && vmx->nested.current_vmptr == -1ull)
@@ -14711,6 +14723,20 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static inline int vmx_has_valid_vmcs12(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	/*
+	 * In case we do two consecutive get/set_nested_state()s while L2 was
+	 * running hv_evmcs may end up not being mapped (we map it from
+	 * nested_vmx_run()/vmx_vcpu_run()). Check is_guest_mode() as we always
+	 * have vmcs12 if it is true.
+	 */
+	return is_guest_mode(vcpu) || vmx->nested.current_vmptr != -1ull ||
+		vmx->nested.hv_evmcs;
+}
+
 static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				u32 user_data_size)
@@ -14731,16 +14757,15 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	vmx = to_vmx(vcpu);
 	vmcs12 = get_vmcs12(vcpu);
 
-	/* FIXME: Enlightened VMCS is currently unsupported */
-	if (vmx->nested.hv_evmcs)
-		return -ENOTSUPP;
+	if (nested_vmx_allowed(vcpu) && vmx->nested.enlightened_vmcs_enabled)
+		kvm_state.flags |= KVM_STATE_NESTED_EVMCS;
 
 	if (nested_vmx_allowed(vcpu) &&
 	    (vmx->nested.vmxon || vmx->nested.smm.vmxon)) {
 		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
 		kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
 
-		if (vmx->nested.current_vmptr != -1ull) {
+		if (vmx_has_valid_vmcs12(vcpu)) {
 			kvm_state.size += VMCS12_SIZE;
 
 			if (is_guest_mode(vcpu) &&
@@ -14769,20 +14794,24 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	if (copy_to_user(user_kvm_nested_state, &kvm_state, sizeof(kvm_state)))
 		return -EFAULT;
 
-	if (vmx->nested.current_vmptr == -1ull)
+	if (!vmx_has_valid_vmcs12(vcpu))
 		goto out;
 
 	/*
 	 * When running L2, the authoritative vmcs12 state is in the
 	 * vmcs02. When running L1, the authoritative vmcs12 state is
-	 * in the shadow vmcs linked to vmcs01, unless
+	 * in the shadow or enlightened vmcs linked to vmcs01, unless
 	 * need_vmcs12_sync is set, in which case, the authoritative
 	 * vmcs12 state is in the vmcs12 already.
 	 */
-	if (is_guest_mode(vcpu))
+	if (is_guest_mode(vcpu)) {
 		sync_vmcs12(vcpu, vmcs12);
-	else if (enable_shadow_vmcs && !vmx->nested.need_vmcs12_sync)
-		copy_shadow_to_vmcs12(vmx);
+	} else if (!vmx->nested.need_vmcs12_sync) {
+		if (vmx->nested.hv_evmcs)
+			copy_enlightened_to_vmcs12(vmx);
+		else if (enable_shadow_vmcs)
+			copy_shadow_to_vmcs12(vmx);
+	}
 
 	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
 		return -EFAULT;
@@ -14810,6 +14839,9 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (kvm_state->format != 0)
 		return -EINVAL;
 
+	if (kvm_state->flags & KVM_STATE_NESTED_EVMCS)
+		nested_enable_evmcs(vcpu, NULL);
+
 	if (!nested_vmx_allowed(vcpu))
 		return kvm_state->vmx.vmxon_pa == -1ull ? 0 : -EINVAL;
 
@@ -14860,11 +14892,21 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
 		return 0;
 
-	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
-	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
-		return -EINVAL;
+	if (kvm_state->vmx.vmcs_pa != -1ull) {
+		if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
+		    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
+			return -EINVAL;
 
-	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
+		set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
+	} else if (kvm_state->flags & KVM_STATE_NESTED_EVMCS) {
+		/*
+		 * Sync eVMCS upon entry as we may not have
+		 * HV_X64_MSR_VP_ASSIST_PAGE set up yet.
+		 */
+		vmx->nested.need_vmcs12_sync = true;
+	} else {
+		return -EINVAL;
+	}
 
 	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
 		vmx->nested.smm.vmxon = true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 50f308499ce5..0fe1e3762e82 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4068,11 +4068,13 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 
 		if (kvm_state.flags &
-		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE))
+		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE
+		      | KVM_STATE_NESTED_EVMCS))
 			break;
 
 		/* nested_run_pending implies guest_mode.  */
-		if (kvm_state.flags == KVM_STATE_NESTED_RUN_PENDING)
+		if ((kvm_state.flags & KVM_STATE_NESTED_RUN_PENDING)
+		    && !(kvm_state.flags & KVM_STATE_NESTED_GUEST_MODE))
 			break;
 
 		r = kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &kvm_state);
-- 
2.17.1

