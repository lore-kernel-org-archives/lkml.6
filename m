Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeDJKJH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:09:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:48742 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeDJKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:09:05 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="606137449"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2] X86/VMX: Disable VMX preemption timer if MWAIT is not intercepted
Date: Tue, 10 Apr 2018 12:08:42 +0200
Message-Id: <1523354922-17955-1-git-send-email-karahmed@amazon.de>
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
v1 -> v2:
- Drop everything .. just return -EOPNOTSUPP (pbonzini@) :D
---
 arch/x86/kvm/vmx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d2e54e7..d99008b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11908,6 +11908,9 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
 	u64 guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
 	u64 delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
 
+	if (kvm_pause_in_guest(vcpu->kvm))
+		return -EOPNOTSUPP;
+
 	/* Convert to host delta tsc if tsc scaling is enabled */
 	if (vcpu->arch.tsc_scaling_ratio != kvm_default_tsc_scaling_ratio &&
 			u64_shl_div_u64(delta_tsc,
-- 
2.7.4
