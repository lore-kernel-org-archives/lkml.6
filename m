Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeE2GxZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:53:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36525 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeE2GxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:53:22 -0400
X-Google-Smtp-Source: AB8JxZoO57UqsXWzMIj5kwWGOfRysnjkQFVZwUpqPwx/yCFIAApMiqC/cC82Sdkxjr8Ci2m84sSNTw==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: VMX: Optimize tscdeadline timer latency
Date: Tue, 29 May 2018 14:53:17 +0800
Message-Id: <1527576797-5738-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

'Commit d0659d946be0 ("KVM: x86: add option to advance tscdeadline 
hrtimer expiration")' advances the tscdeadline (the timer is emulated 
by hrtimer) expiration in order that the latency which is incurred 
by hypervisor (apic_timer_fn -> vmentry) can be avoided. This patch 
adds the advance tscdeadline expiration support to which the tscdeadline 
timer is emulated by VMX preemption timer to reduce the hypervisor 
lantency (handle_preemption_timer -> vmentry). clockevents infrastruture 
can program minimum delay if hrtimer feeds a expiration in the past, 
we set delta_tsc to 1(which will be converted to 0 before vmentry) 
which can lead to an immediately vmexit when delta_tsc is not bigger 
than advance ns. 

This patch can reduce ~63% latency (~4450 cycles to ~1660 cycles on 
a haswell desktop) for kvm-unit-tests/tscdeadline_latency when testing
busy waits.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx.c | 8 +++++++-
 arch/x86/kvm/x86.c | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e50beb7..d8b5110 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12435,7 +12435,7 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
 {
 	struct vcpu_vmx *vmx;
-	u64 tscl, guest_tscl, delta_tsc;
+	u64 tscl, guest_tscl, delta_tsc, lapic_timer_advance_cycles;
 
 	if (kvm_mwait_in_guest(vcpu->kvm))
 		return -EOPNOTSUPP;
@@ -12444,6 +12444,12 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
 	tscl = rdtsc();
 	guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
 	delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
+	lapic_timer_advance_cycles = nsec_to_cycles(vcpu, lapic_timer_advance_ns);
+
+	if (delta_tsc > lapic_timer_advance_cycles)
+		delta_tsc -= lapic_timer_advance_cycles;
+	else
+		delta_tsc = 1;
 
 	/* Convert to host delta tsc if tsc scaling is enabled */
 	if (vcpu->arch.tsc_scaling_ratio != kvm_default_tsc_scaling_ratio &&
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 22bd20f..d8abd96 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -138,6 +138,7 @@ module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);
 /* lapic timer advance (tscdeadline mode only) in nanoseconds */
 unsigned int __read_mostly lapic_timer_advance_ns = 0;
 module_param(lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL_GPL(lapic_timer_advance_ns);
 
 static bool __read_mostly vector_hashing = true;
 module_param(vector_hashing, bool, S_IRUGO);
-- 
2.7.4
