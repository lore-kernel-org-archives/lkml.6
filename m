Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A7B21471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A7B21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbeHNUdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:33:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388101AbeHNUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:33:46 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45ADBD06;
        Tue, 14 Aug 2018 17:45:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 099/107] KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry
Date:   Tue, 14 Aug 2018 19:18:02 +0200
Message-Id: <20180814171526.801399668@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 5b76a3cff011df2dcb6186c965a2e4d809a05ad4 upstream

When nested virtualization is in use, VMENTER operations from the nested
hypervisor into the nested guest will always be processed by the bare metal
hypervisor, and KVM's "conditional cache flushes" mode in particular does a
flush on nested vmentry.  Therefore, include the "skip L1D flush on
vmentry" bit in KVM's suggested ARCH_CAPABILITIES setting.

Add the relevant Documentation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/l1tf.rst          |   21 +++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/vmx.c              |    3 +--
 arch/x86/kvm/x86.c              |   26 +++++++++++++++++++++++++-
 4 files changed, 48 insertions(+), 3 deletions(-)

--- a/Documentation/l1tf.rst
+++ b/Documentation/l1tf.rst
@@ -546,6 +546,27 @@ available:
     EPT can be disabled in the hypervisor via the 'kvm-intel.ept'
     parameter.
 
+3.4. Nested virtual machines
+""""""""""""""""""""""""""""
+
+When nested virtualization is in use, three operating systems are involved:
+the bare metal hypervisor, the nested hypervisor and the nested virtual
+machine.  VMENTER operations from the nested hypervisor into the nested
+guest will always be processed by the bare metal hypervisor. If KVM is the
+bare metal hypervisor it wiil:
+
+ - Flush the L1D cache on every switch from the nested hypervisor to the
+   nested virtual machine, so that the nested hypervisor's secrets are not
+   exposed to the nested virtual machine;
+
+ - Flush the L1D cache on every switch from the nested virtual machine to
+   the nested hypervisor; this is a complex operation, and flushing the L1D
+   cache avoids that the bare metal hypervisor's secrets are exposed to the
+   nested virtual machine;
+
+ - Instruct the nested hypervisor to not perform any L1D cache flush. This
+   is an optimization to avoid double L1D flushing.
+
 
 .. _default_mitigations:
 
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1346,6 +1346,7 @@ void kvm_vcpu_reload_apic_access_page(st
 void kvm_arch_mmu_notifier_invalidate_page(struct kvm *kvm,
 					   unsigned long address);
 
+u64 kvm_get_arch_capabilities(void);
 void kvm_define_shared_msr(unsigned index, u32 msr);
 int kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5461,8 +5461,7 @@ static int vmx_vcpu_setup(struct vcpu_vm
 		++vmx->nmsrs;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
+	vmx->arch_capabilities = kvm_get_arch_capabilities();
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1020,11 +1020,35 @@ static u32 msr_based_features[] = {
 
 static unsigned int num_msr_based_features;
 
+u64 kvm_get_arch_capabilities(void)
+{
+	u64 data;
+
+	rdmsrl_safe(MSR_IA32_ARCH_CAPABILITIES, &data);
+
+	/*
+	 * If we're doing cache flushes (either "always" or "cond")
+	 * we will do one whenever the guest does a vmlaunch/vmresume.
+	 * If an outer hypervisor is doing the cache flush for us
+	 * (VMENTER_L1D_FLUSH_NESTED_VM), we can safely pass that
+	 * capability to the guest too, and if EPT is disabled we're not
+	 * vulnerable.  Overall, only VMENTER_L1D_FLUSH_NEVER will
+	 * require a nested hypervisor to do a flush of its own.
+	 */
+	if (l1tf_vmx_mitigation != VMENTER_L1D_FLUSH_NEVER)
+		data |= ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
+
 static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
-	case MSR_IA32_UCODE_REV:
 	case MSR_IA32_ARCH_CAPABILITIES:
+		msr->data = kvm_get_arch_capabilities();
+		break;
+	case MSR_IA32_UCODE_REV:
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:


