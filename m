Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeBJXkg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 18:40:36 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60670 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeBJXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 18:39:50 -0500
X-IronPort-AV: E=Sophos;i="5.46,492,1511827200";
   d="scan'208";a="719069392"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: [PATCH v2 4/6] X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
Date: Sat, 10 Feb 2018 23:39:25 +0000
Message-Id: <1518305967-31356-5-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KarimAllah Ahmed <karahmed@amazon.de>

These two variables should check whether SPEC_CTRL and PRED_CMD are
supposed to be passed through to L2 guests or not. While
msr_write_intercepted_l01 would return 'true' if it is not passed through.

So just invert the result of msr_write_intercepted_l01 to implement the
correct semantics.

Fixes: 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bee4c49..599179b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10219,8 +10219,8 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	 *    updated to reflect this when L1 (or its L2s) actually write to
 	 *    the MSR.
 	 */
-	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
-	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
+	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 	    !pred_cmd && !spec_ctrl)
-- 
2.7.4
