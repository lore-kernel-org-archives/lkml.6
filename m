Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDJMQT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:16:19 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:52096 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeDJMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:16:18 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="339309309"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v3] X86/VMX: Disable VMX preemption timer if MWAIT is not intercepted
Date: Tue, 10 Apr 2018 14:15:46 +0200
Message-Id: <1523362546-20909-1-git-send-email-karahmed@amazon.de>
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

So disable the VMX-preemption timer if MWAIT is exposed to the guest!

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
v2 -> v3:
- return -EOPNOTSUPP before any other operation in vmx_set_hv_timer

v1 -> v2:
- Drop everything .. just return -EOPNOTSUPP (pbonzini@) :D
---
 arch/x86/kvm/vmx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d2e54e7..31a4204 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11903,10 +11903,16 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 
 static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 tscl = rdtsc();
-	u64 guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
-	u64 delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
+	struct vcpu_vmx *vmx;
+	u64 tscl, guest_tscl, delta_tsc;
+
+	if (kvm_pause_in_guest(vcpu->kvm))
+		return -EOPNOTSUPP;
+
+	vmx = to_vmx(vcpu);
+	tscl = rdtsc();
+	guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
+	delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
 
 	/* Convert to host delta tsc if tsc scaling is enabled */
 	if (vcpu->arch.tsc_scaling_ratio != kvm_default_tsc_scaling_ratio &&
-- 
2.7.4
