Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C65AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE9821778
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE9821778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbeHNUTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:19:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbeHNUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:19:07 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8EBED06;
        Tue, 14 Aug 2018 17:30:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 57/97] x86/KVM/VMX: Split the VMX MSR LOAD structures to have an host/guest numbers
Date:   Tue, 14 Aug 2018 19:17:09 +0200
Message-Id: <20180814171435.326677089@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 33966dd6b2d2c352fae55412db2ea8cfff5df13a upstream

There is no semantic change but this change allows an unbalanced amount of
MSRs to be loaded on VMEXIT and VMENTER, i.e. the number of MSRs to save or
restore on VMEXIT or VMENTER may be different.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   65 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -642,6 +642,11 @@ static inline int pi_test_sn(struct pi_d
 			(unsigned long *)&pi_desc->control);
 }
 
+struct vmx_msrs {
+	unsigned int		nr;
+	struct vmx_msr_entry	val[NR_AUTOLOAD_MSRS];
+};
+
 struct vcpu_vmx {
 	struct kvm_vcpu       vcpu;
 	unsigned long         host_rsp;
@@ -675,9 +680,8 @@ struct vcpu_vmx {
 	struct loaded_vmcs   *loaded_vmcs;
 	bool                  __launched; /* temporary, used in vmx_vcpu_run */
 	struct msr_autoload {
-		unsigned nr;
-		struct vmx_msr_entry guest[NR_AUTOLOAD_MSRS];
-		struct vmx_msr_entry host[NR_AUTOLOAD_MSRS];
+		struct vmx_msrs guest;
+		struct vmx_msrs host;
 	} msr_autoload;
 	struct {
 		int           loaded;
@@ -2256,18 +2260,18 @@ static void clear_atomic_switch_msr(stru
 		}
 		break;
 	}
-
-	for (i = 0; i < m->nr; ++i)
-		if (m->guest[i].index == msr)
+	for (i = 0; i < m->guest.nr; ++i)
+		if (m->guest.val[i].index == msr)
 			break;
 
-	if (i == m->nr)
+	if (i == m->guest.nr)
 		return;
-	--m->nr;
-	m->guest[i] = m->guest[m->nr];
-	m->host[i] = m->host[m->nr];
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->nr);
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->nr);
+	--m->guest.nr;
+	--m->host.nr;
+	m->guest.val[i] = m->guest.val[m->guest.nr];
+	m->host.val[i] = m->host.val[m->host.nr];
+	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
+	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 }
 
 static void add_atomic_switch_msr_special(struct vcpu_vmx *vmx,
@@ -2319,24 +2323,25 @@ static void add_atomic_switch_msr(struct
 		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
 	}
 
-	for (i = 0; i < m->nr; ++i)
-		if (m->guest[i].index == msr)
+	for (i = 0; i < m->guest.nr; ++i)
+		if (m->guest.val[i].index == msr)
 			break;
 
 	if (i == NR_AUTOLOAD_MSRS) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;
-	} else if (i == m->nr) {
-		++m->nr;
-		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->nr);
-		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->nr);
+	} else if (i == m->guest.nr) {
+		++m->guest.nr;
+		++m->host.nr;
+		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
+		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 	}
 
-	m->guest[i].index = msr;
-	m->guest[i].value = guest_val;
-	m->host[i].index = msr;
-	m->host[i].value = host_val;
+	m->guest.val[i].index = msr;
+	m->guest.val[i].value = guest_val;
+	m->host.val[i].index = msr;
+	m->host.val[i].value = host_val;
 }
 
 static bool update_transition_efer(struct vcpu_vmx *vmx, int efer_offset)
@@ -6092,9 +6097,9 @@ static void vmx_vcpu_setup(struct vcpu_v
 
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, 0);
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, 0);
-	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host));
+	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host.val));
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, 0);
-	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest));
+	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest.val));
 
 	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
 		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
@@ -11128,10 +11133,10 @@ static void prepare_vmcs02_full(struct k
 	 * Set the MSR load/store lists to match L0's settings.
 	 */
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, 0);
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.nr);
-	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host));
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.nr);
-	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest));
+	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
+	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host.val));
+	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
+	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest.val));
 
 	set_cr4_guest_host_mask(vmx);
 
@@ -12281,8 +12286,8 @@ static void nested_vmx_vmexit(struct kvm
 	vmx_segment_cache_clear(vmx);
 
 	/* Update any VMCS fields that might have changed while L2 ran */
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.nr);
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.nr);
+	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
+	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
 	vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
 	if (vmx->hv_deadline_tsc == -1)
 		vmcs_clear_bits(PIN_BASED_VM_EXEC_CONTROL,


