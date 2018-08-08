Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4118C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCF721771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCF721771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeHHSQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:16:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbeHHSQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05D6840216E9;
        Wed,  8 Aug 2018 15:56:21 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DABD8215670D;
        Wed,  8 Aug 2018 15:56:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 10/12] x86/kvm/nVMX: nested state migration for Enlightened VMCS
Date:   Wed,  8 Aug 2018 17:55:50 +0200
Message-Id: <20180808155552.4836-11-vkuznets@redhat.com>
In-Reply-To: <20180808155552.4836-1-vkuznets@redhat.com>
References: <20180808155552.4836-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:56:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:56:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
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
 arch/x86/kvm/vmx.c              | 54 +++++++++++++++++++++++++++++------------
 arch/x86/kvm/x86.c              |  6 +++--
 3 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 86299efa804a..0b45bd0ea13b 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -380,6 +380,7 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+#define KVM_STATE_NESTED_EVMCS		0x00000004
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6eb86991ca60..81b36eeec95b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1448,7 +1448,8 @@ static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 	 * maximum supported version. KVM supports versions from 1 to
 	 * KVM_EVMCS_VERSION.
 	 */
-	*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
+	if (vmcs_version)
+		*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
 
 	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
 	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
@@ -14036,16 +14037,16 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
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
+		if (vmx->nested.current_vmptr != -1ull ||
+		    vmx->nested.hv_evmcs) {
 			kvm_state.size += VMCS12_SIZE;
 
 			if (is_guest_mode(vcpu) &&
@@ -14074,20 +14075,34 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	if (copy_to_user(user_kvm_nested_state, &kvm_state, sizeof(kvm_state)))
 		return -EFAULT;
 
-	if (vmx->nested.current_vmptr == -1ull)
+	if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs)
 		goto out;
 
 	/*
 	 * When running L2, the authoritative vmcs12 state is in the
 	 * vmcs02. When running L1, the authoritative vmcs12 state is
-	 * in the shadow vmcs linked to vmcs01, unless
-	 * sync_shadow_vmcs is set, in which case, the authoritative
-	 * vmcs12 state is in the vmcs12 already.
+	 * in the shadow or enlightened vmcs linked to vmcs01. In case
+	 * need_vmcs12_sync is set the authoritative vmcs12 state is in
+	 * the vmcs12 already.
 	 */
-	if (is_guest_mode(vcpu))
+	if (is_guest_mode(vcpu)) {
 		sync_vmcs12(vcpu, vmcs12);
-	else if (enable_shadow_vmcs && !vmx->nested.need_vmcs12_sync)
-		copy_shadow_to_vmcs12(vmx);
+		/*
+		 * Save Enlightened VMCS is to guest's memory here while we
+		 * still have it mapped and avoid doing enlightened vmptrld
+		 * on restore (this will require reading VP assist page so
+		 * we must be sure MSRs are already restored). Unlike with
+		 * shadow VMCS the format is know and can't change across
+		 * migration.
+		 */
+		if (vmx->nested.hv_evmcs)
+			copy_vmcs12_to_enlightened(vmx);
+	} else if (!vmx->nested.need_vmcs12_sync) {
+		if (vmx->nested.hv_evmcs)
+			copy_enlightened_to_vmcs12(vmx);
+		else if (enable_shadow_vmcs)
+			copy_shadow_to_vmcs12(vmx);
+	}
 
 	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
 		return -EFAULT;
@@ -14115,6 +14130,9 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (kvm_state->format != 0)
 		return -EINVAL;
 
+	if (kvm_state->flags & KVM_STATE_NESTED_EVMCS)
+		nested_enable_evmcs(vcpu, NULL);
+
 	if (!nested_vmx_allowed(vcpu))
 		return kvm_state->vmx.vmxon_pa == -1ull ? 0 : -EINVAL;
 
@@ -14157,11 +14175,15 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
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
+	} else if (!(kvm_state->flags & KVM_STATE_NESTED_EVMCS)) {
+		return -EINVAL;
+	}
 
 	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
 		vmx->nested.smm.vmxon = true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 22ca77e727f5..cabd03d1b8cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4026,11 +4026,13 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			return -EINVAL;
 
 		if (kvm_state.flags &
-		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE))
+		    ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE
+		      | KVM_STATE_NESTED_EVMCS))
 			return -EINVAL;
 
 		/* nested_run_pending implies guest_mode.  */
-		if (kvm_state.flags == KVM_STATE_NESTED_RUN_PENDING)
+		if ((kvm_state.flags & KVM_STATE_NESTED_RUN_PENDING)
+		    && !(kvm_state.flags & KVM_STATE_NESTED_GUEST_MODE))
 			return -EINVAL;
 
 		r = kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &kvm_state);
-- 
2.14.4

