Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeBWI1a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:27:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWI13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:27:29 -0500
Date: Fri, 23 Feb 2018 00:26:59 -0800
From: tip-bot for Paolo Bonzini <tipbot@zytor.com>
Message-ID: <tip-946fbbc13dce68902f64515b610eeb2a6c3d7a64@git.kernel.org>
Cc: rkrcmar@redhat.com, peterz@infradead.org, jmattson@google.com,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, karahmed@amazon.de, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: jmattson@google.com, peterz@infradead.org, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, pbonzini@redhat.com,
        karahmed@amazon.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dwmw@amazon.co.uk
In-Reply-To: <20180222154318.20361-3-pbonzini@redhat.com>
References: <20180222154318.20361-3-pbonzini@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run()
 by marking the RDMSR path as unlikely()
Git-Commit-ID: 946fbbc13dce68902f64515b610eeb2a6c3d7a64
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  946fbbc13dce68902f64515b610eeb2a6c3d7a64
Gitweb:     https://git.kernel.org/tip/946fbbc13dce68902f64515b610eeb2a6c3d7a64
Author:     Paolo Bonzini <pbonzini@redhat.com>
AuthorDate: Thu, 22 Feb 2018 16:43:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:24:36 +0100

KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()

vmx_vcpu_run() and svm_vcpu_run() are large functions, and giving
branch hints to the compiler can actually make a substantial cycle
difference by keeping the fast path contiguous in memory.

With this optimization, the retpoline-guest/retpoline-host case is
about 50 cycles faster.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222154318.20361-3-pbonzini@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kvm/svm.c | 2 +-
 arch/x86/kvm/vmx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1598beeda11c..24c9521ebc24 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5465,7 +5465,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0927be315965..7f8401d05939 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9588,7 +9588,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
