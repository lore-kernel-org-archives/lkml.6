Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeDJIvB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:51:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:4274 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbeDJIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:50:56 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="715358097"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] X86/VMX: Disable VMX preempition timer if MWAIT is not intercepted
Date: Tue, 10 Apr 2018 10:50:11 +0200
Message-Id: <1523350211-5747-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VMX-preemption timer is used by KVM as a way to set deadlines for the
guest (i.e. timer emulation). That was safe till very recently when
capability KVM_X86_DISABLE_EXITS_MWAIT to disable intercepting MWAIT was
introduced. According to Intel SDM 25.5.1:

"""
The VMX-preemption timer operates in the C-states C0, C1, and C2; it also
operates in the shutdown and wait-for-SIPI states. If the timer counts down
to zero in any state other than the wait-for SIPI state, the logical
processor transitions to the C0 C-state and causes a VM exit; the timer
does not cause a VM exit if it counts down to zero in the wait-for-SIPI
state. The timer is not decremented in C-states deeper than C2.
"""

Now once the guest issues the MWAIT with a c-state deeper than
C2 the preemption timer will never wake it up again since it stopped
ticking! Usually this is compensated by other activities in the system that
would wake the core from the deep C-state (and cause a VMExit). For
example, if the host itself is ticking or it received interrupts, etc!

So disable the VMX-preemption timer is MWAIT is exposed to the guest!

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/lapic.c            |  3 ++-
 arch/x86/kvm/vmx.c              | 11 +++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 97448f1..5d9da9c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1090,6 +1090,7 @@ struct kvm_x86_ops {
 			      uint32_t guest_irq, bool set);
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
 
+	bool (*has_hv_timer)(struct kvm_vcpu *vcpu);
 	int (*set_hv_timer)(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc);
 	void (*cancel_hv_timer)(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a071dc1..9fb50e6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1561,7 +1561,8 @@ static bool start_hv_timer(struct kvm_lapic *apic)
 	int r;
 
 	WARN_ON(preemptible());
-	if (!kvm_x86_ops->set_hv_timer)
+	if (!kvm_x86_ops->has_hv_timer ||
+	    !kvm_x86_ops->has_hv_timer(apic->vcpu))
 		return false;
 
 	if (!apic_lvtt_period(apic) && atomic_read(&ktimer->pending))
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d2e54e7..d99a823 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7112,7 +7112,7 @@ static __init int hardware_setup(void)
 		cpu_preemption_timer_multi =
 			 vmx_msr & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
 	} else {
-		kvm_x86_ops->set_hv_timer = NULL;
+		kvm_x86_ops->has_hv_timer = NULL;
 		kvm_x86_ops->cancel_hv_timer = NULL;
 	}
 
@@ -11901,6 +11901,11 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
 }
 
+static bool vmx_has_hv_timer(struct kvm_vcpu *vcpu)
+{
+	return !kvm_pause_in_guest(vcpu->kvm);
+}
+
 static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -12136,7 +12141,8 @@ static void pi_post_block(struct kvm_vcpu *vcpu)
 
 static void vmx_post_block(struct kvm_vcpu *vcpu)
 {
-	if (kvm_x86_ops->set_hv_timer)
+	if (kvm_x86_ops->has_hv_timer &&
+	    kvm_x86_ops->has_hv_timer(vcpu))
 		kvm_lapic_switch_to_hv_timer(vcpu);
 
 	pi_post_block(vcpu);
@@ -12592,6 +12598,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.update_pi_irte = vmx_update_pi_irte,
 
 #ifdef CONFIG_X86_64
+	.has_hv_timer = vmx_has_hv_timer,
 	.set_hv_timer = vmx_set_hv_timer,
 	.cancel_hv_timer = vmx_cancel_hv_timer,
 #endif
-- 
2.7.4
