Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE2C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F4220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F4220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeILSkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:40:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILSkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:40:31 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g05JB-0001Ap-JC; Wed, 12 Sep 2018 15:35:53 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 02/10] kvm: x86: make kvm_{load|put}_guest_fpu() static
Date:   Wed, 12 Sep 2018 15:33:45 +0200
Message-Id: <20180912133353.20595-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912133353.20595-1-bigeasy@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions
	kvm_load_guest_fpu()
	kvm_put_guest_fpu()

are only used locally, make them static. This requires also that both
functions are moved because they are used before their implementation.
Those functions were exported (via EXPORT_SYMBOL) before commit
e5bb40251a920 ("KVM: Drop kvm_{load,put}_guest_fpu() exports").

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kvm/x86.c       | 46 ++++++++++++++++++++--------------------
 include/linux/kvm_host.h |  2 --
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 542f6315444d7..2d8b3c257e769 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7829,6 +7829,29 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+/* Swap (qemu) user FPU context for the guest FPU context. */
+static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	preempt_disable();
+	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
+	/* PKRU is separately restored in kvm_x86_ops->run.  */
+	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu.state,
+				~XFEATURE_MASK_PKRU);
+	preempt_enable();
+	trace_kvm_fpu(1);
+}
+
+/* When vcpu_run ends, restore user space FPU context. */
+static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	preempt_disable();
+	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
+	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
+	preempt_enable();
+	++vcpu->stat.fpu_reload;
+	trace_kvm_fpu(0);
+}
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	int r;
@@ -8406,29 +8429,6 @@ static void fx_init(struct kvm_vcpu *vcpu)
 	vcpu->arch.cr0 |= X86_CR0_ET;
 }
 
-/* Swap (qemu) user FPU context for the guest FPU context. */
-void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	preempt_disable();
-	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
-	/* PKRU is separately restored in kvm_x86_ops->run.  */
-	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu.state,
-				~XFEATURE_MASK_PKRU);
-	preempt_enable();
-	trace_kvm_fpu(1);
-}
-
-/* When vcpu_run ends, restore user space FPU context. */
-void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	preempt_disable();
-	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
-	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
-	preempt_enable();
-	++vcpu->stat.fpu_reload;
-	trace_kvm_fpu(0);
-}
-
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	void *wbinvd_dirty_mask = vcpu->arch.wbinvd_dirty_mask;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0205aee44dedd..c926698040e0d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -733,8 +733,6 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
 int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool usermode_vcpu_not_eligible);
-void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
-void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 void kvm_flush_remote_tlbs(struct kvm *kvm);
 void kvm_reload_remote_mmus(struct kvm *kvm);
-- 
2.19.0

