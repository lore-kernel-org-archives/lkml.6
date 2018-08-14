Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FAEC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C810D2150F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C810D2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbeHNUcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:32:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:32:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 075F5AF3;
        Tue, 14 Aug 2018 17:44:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 087/107] x86/KVM/VMX: Introduce per-host-cpu analogue of l1tf_flush_l1d
Date:   Tue, 14 Aug 2018 19:17:50 +0200
Message-Id: <20180814171526.119684380@linuxfoundation.org>
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

From: Nicolai Stange <nstange@suse.de>

commit 45b575c00d8e72d69d75dd8c112f044b7b01b069 upstream

Part of the L1TF mitigation for vmx includes flushing the L1D cache upon
VMENTRY.

L1D flushes are costly and two modes of operations are provided to users:
"always" and the more selective "conditional" mode.

If operating in the latter, the cache would get flushed only if a host side
code path considered unconfined had been traversed. "Unconfined" in this
context means that it might have pulled in sensitive data like user data
or kernel crypto keys.

The need for L1D flushes is tracked by means of the per-vcpu flag
l1tf_flush_l1d. KVM exit handlers considered unconfined set it. A
vmx_l1d_flush() subsequently invoked before the next VMENTER will conduct a
L1d flush based on its value and reset that flag again.

Currently, interrupts delivered "normally" while in root operation between
VMEXIT and VMENTER are not taken into account. Part of the reason is that
these don't leave any traces and thus, the vmx code is unable to tell if
any such has happened.

As proposed by Paolo Bonzini, prepare for tracking all interrupts by
introducing a new per-cpu flag, "kvm_cpu_l1tf_flush_l1d". It will be in
strong analogy to the per-vcpu ->l1tf_flush_l1d.

A later patch will make interrupt handlers set it.

For the sake of cache locality, group kvm_cpu_l1tf_flush_l1d into x86'
per-cpu irq_cpustat_t as suggested by Peter Zijlstra.

Provide the helpers kvm_set_cpu_l1tf_flush_l1d(),
kvm_clear_cpu_l1tf_flush_l1d() and kvm_get_cpu_l1tf_flush_l1d(). Make them
trivial resp. non-existent for !CONFIG_KVM_INTEL as appropriate.

Let vmx_l1d_flush() handle kvm_cpu_l1tf_flush_l1d in the same way as
l1tf_flush_l1d.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/hardirq.h |   23 +++++++++++++++++++++++
 arch/x86/kvm/vmx.c             |   17 +++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -6,6 +6,9 @@
 
 typedef struct {
 	u16	     __softirq_pending;
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+	u8	     kvm_cpu_l1tf_flush_l1d;
+#endif
 	unsigned int __nmi_count;	/* arch dependent */
 #ifdef CONFIG_X86_LOCAL_APIC
 	unsigned int apic_timer_irqs;	/* arch dependent */
@@ -60,4 +63,24 @@ extern u64 arch_irq_stat_cpu(unsigned in
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+static inline void kvm_set_cpu_l1tf_flush_l1d(void)
+{
+	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
+}
+
+static inline void kvm_clear_cpu_l1tf_flush_l1d(void)
+{
+	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 0);
+}
+
+static inline bool kvm_get_cpu_l1tf_flush_l1d(void)
+{
+	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
+}
+#else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
+static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
+#endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
+
 #endif /* _ASM_X86_HARDIRQ_H */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8667,14 +8667,23 @@ static void vmx_l1d_flush(struct kvm_vcp
 	 * 'always'
 	 */
 	if (static_branch_likely(&vmx_l1d_flush_cond)) {
-		bool flush_l1d = vcpu->arch.l1tf_flush_l1d;
+		bool flush_l1d;
 
 		/*
-		 * Clear the flush bit, it gets set again either from
-		 * vcpu_run() or from one of the unsafe VMEXIT
-		 * handlers.
+		 * Clear the per-vcpu flush bit, it gets set again
+		 * either from vcpu_run() or from one of the unsafe
+		 * VMEXIT handlers.
 		 */
+		flush_l1d = vcpu->arch.l1tf_flush_l1d;
 		vcpu->arch.l1tf_flush_l1d = false;
+
+		/*
+		 * Clear the per-cpu flush bit, it gets set again from
+		 * the interrupt handlers.
+		 */
+		flush_l1d |= kvm_get_cpu_l1tf_flush_l1d();
+		kvm_clear_cpu_l1tf_flush_l1d();
+
 		if (!flush_l1d)
 			return;
 	}


