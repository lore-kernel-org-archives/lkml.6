Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeDKJYK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:24:10 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:33378 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeDKJYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:24:08 -0400
X-IronPort-AV: E=Sophos;i="5.48,435,1517875200";
   d="scan'208";a="339348924"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] X86/KVM: Do not allow DISABLE_EXITS_MWAIT when LAPIC ARAT is not available
Date: Wed, 11 Apr 2018 11:16:03 +0200
Message-Id: <1523438163-768-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the processor does not have an "Always Running APIC Timer" (aka ARAT),
we should not give guests direct access to MWAIT. The LAPIC timer would
stop ticking in deep C-states, so any host deadlines would not wakeup the
host kernel.

The host kernel intel_idle driver handles this by switching to broadcast
mode when ARAT is not available and MWAIT is issued with a deep C-state
that would stop the LAPIC timer. When MWAIT is passed through, we can not
tell when MWAIT is issued.

So just disable this capability when LAPIC ARAT is not available. I am not
even sure if there are any CPUs with VMX support but no LAPIC ARAT or not.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Wanpeng Li <kernellwp@gmail.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b2ff74b..0334b25 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2819,7 +2819,8 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
 static inline bool kvm_can_mwait_in_guest(void)
 {
 	return boot_cpu_has(X86_FEATURE_MWAIT) &&
-		!boot_cpu_has_bug(X86_BUG_MONITOR);
+		!boot_cpu_has_bug(X86_BUG_MONITOR) &&
+		boot_cpu_has(X86_FEATURE_ARAT);
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
-- 
2.7.4
