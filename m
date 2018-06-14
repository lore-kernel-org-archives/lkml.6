Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C711C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78A4208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A4208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbeFNI0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:26:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754855AbeFNIZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:25:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F81C4023132;
        Thu, 14 Jun 2018 08:25:25 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-228.brq.redhat.com [10.40.204.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBEE010FFE4D;
        Thu, 14 Jun 2018 08:25:21 +0000 (UTC)
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
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 4/5] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
Date:   Thu, 14 Jun 2018 10:24:59 +0200
Message-Id: <20180614082500.18548-5-vkuznets@redhat.com>
In-Reply-To: <20180614082500.18548-1-vkuznets@redhat.com>
References: <20180614082500.18548-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 14 Jun 2018 08:25:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 14 Jun 2018 08:25:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Hyper-V TLFS 5.0b:

"The L1 hypervisor may choose to use enlightened VMCSs by writing 1 to
the corresponding field in the VP assist page (see section 7.8.7).
Another field in the VP assist page controls the currently active
enlightened VMCS. Each enlightened VMCS is exactly one page (4 KB) in
size and must be initially zeroed. No VMPTRLD instruction must be
executed to make an enlightened VMCS active or current.

After the L1 hypervisor performs a VM entry with an enlightened VMCS,
the VMCS is considered active on the processor. An enlightened VMCS
can only be active on a single processor at the same time. The L1
hypervisor can execute a VMCLEAR instruction to transition an
enlightened VMCS from the active to the non-active state. Any VMREAD
or VMWRITE instructions while an enlightened VMCS is active is
unsupported and can result in unexpected behavior."

Keep Enlightened VMCS structure for the current L2 guest permanently mapped
from struct nested_vmx instead of mapping it every time.

Suggested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e7fa9f9c6e36..6802ba91468c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -20,6 +20,7 @@
 #include "mmu.h"
 #include "cpuid.h"
 #include "lapic.h"
+#include "hyperv.h"
 
 #include <linux/kvm_host.h>
 #include <linux/module.h>
@@ -690,6 +691,8 @@ struct nested_vmx {
 		bool guest_mode;
 	} smm;
 
+	gpa_t hv_evmcs_vmptr;
+	struct page *hv_evmcs_page;
 	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
@@ -7695,7 +7698,9 @@ static void nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
 static void nested_vmx_failValid(struct kvm_vcpu *vcpu,
 					u32 vm_instruction_error)
 {
-	if (to_vmx(vcpu)->nested.current_vmptr == -1ull) {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs) {
 		/*
 		 * failValid writes the error number to the current VMCS, which
 		 * can't be done there isn't a current VMCS.
@@ -8003,6 +8008,18 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
 }
 
+static inline void nested_release_evmcs(struct vcpu_vmx *vmx)
+{
+	if (!vmx->nested.hv_evmcs)
+		return;
+
+	kunmap(vmx->nested.hv_evmcs_page);
+	kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
+	vmx->nested.hv_evmcs_vmptr = -1ull;
+	vmx->nested.hv_evmcs_page = NULL;
+	vmx->nested.hv_evmcs = NULL;
+}
+
 static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 {
 	if (vmx->nested.current_vmptr == -1ull)
@@ -8062,6 +8079,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	nested_release_evmcs(vmx);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8098,12 +8117,18 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	if (vmptr == vmx->nested.current_vmptr)
-		nested_release_vmcs12(vmx);
+	if (vmx->nested.hv_evmcs_page) {
+		if (vmptr == vmx->nested.hv_evmcs_vmptr)
+			nested_release_evmcs(vmx);
+	} else {
+		if (vmptr == vmx->nested.current_vmptr)
+			nested_release_vmcs12(vmx);
 
-	kvm_vcpu_write_guest(vcpu,
-			vmptr + offsetof(struct vmcs12, launch_state),
-			&zero, sizeof(zero));
+		kvm_vcpu_write_guest(vcpu,
+				     vmptr + offsetof(struct vmcs12,
+						      launch_state),
+				     &zero, sizeof(zero));
+	}
 
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
@@ -8814,6 +8839,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
+	/* Forbid normal VMPTRLD if Enlightened version was used */
+	if (vmx->nested.hv_evmcs)
+		return 1;
+
 	if (vmx->nested.current_vmptr != vmptr) {
 		struct vmcs12 *new_vmcs12;
 		struct page *page;
@@ -8847,6 +8876,55 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
+/*
+ * This is an equivalent of the nested hypervisor executing the vmptrld
+ * instruction.
+ */
+static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct hv_vp_assist_page assist_page;
+
+	if (likely(!vmx->nested.enlightened_vmcs_enabled))
+		return 1;
+
+	if (unlikely(!kvm_hv_get_assist_page(vcpu, &assist_page)))
+		return 1;
+
+	if (unlikely(!assist_page.enlighten_vmentry))
+		return 1;
+
+	if (unlikely(assist_page.current_nested_vmcs !=
+		     vmx->nested.hv_evmcs_vmptr)) {
+
+		if (!vmx->nested.hv_evmcs)
+			vmx->nested.current_vmptr = -1ull;
+
+		nested_release_evmcs(vmx);
+
+		vmx->nested.hv_evmcs_page = kvm_vcpu_gpa_to_page(
+			vcpu, assist_page.current_nested_vmcs);
+
+		if (unlikely(is_error_page(vmx->nested.hv_evmcs_page)))
+			return 0;
+
+		vmx->nested.hv_evmcs = kmap(vmx->nested.hv_evmcs_page);
+		vmx->nested.dirty_vmcs12 = true;
+		vmx->nested.hv_evmcs_vmptr = assist_page.current_nested_vmcs;
+
+		/*
+		 * Unlike normal vmcs12, enlightened vmcs12 is not fully
+		 * reloaded from guest's memory (read only fields, fields not
+		 * present in struct hv_enlightened_vmcs, ...). Make sure there
+		 * are no leftovers.
+		 */
+		memset(vmx->nested.cached_vmcs12, 0,
+		       sizeof(*vmx->nested.cached_vmcs12));
+
+	}
+	return 1;
+}
+
 /* Emulate the VMPTRST instruction */
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
@@ -8858,6 +8936,9 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
+	if (unlikely(to_vmx(vcpu)->nested.hv_evmcs))
+		return 1;
+
 	if (get_vmx_mem_address(vcpu, exit_qualification,
 			vmx_instruction_info, true, &vmcs_gva))
 		return 1;
@@ -12148,7 +12229,10 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (!nested_vmx_check_vmcs12(vcpu))
+	if (!nested_vmx_handle_enlightened_vmptrld(vcpu))
+		return 1;
+
+	if (!vmx->nested.hv_evmcs && !nested_vmx_check_vmcs12(vcpu))
 		goto out;
 
 	vmcs12 = get_vmcs12(vcpu);
-- 
2.14.4

