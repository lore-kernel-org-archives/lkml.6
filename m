Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0QQuAok8GVvANAAAmS7hNA
	; Thu, 07 Jun 2018 14:09:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DBEB8608BF; Thu,  7 Jun 2018 14:09:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA0C76063F;
	Thu,  7 Jun 2018 14:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA0C76063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933044AbeFGOJG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39108 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932878AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zz-KV; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002hO-Jf; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.921181256@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 017/410] kvm/x86: fix icebp instruction handling
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 32d43cd391bacb5f0814c2624399a5dad3501d09 upstream.

The undocumented 'icebp' instruction (aka 'int1') works pretty much like
'int3' in the absense of in-circuit probing equipment (except,
obviously, that it raises #DB instead of raising #BP), and is used by
some validation test-suites as such.

But Andy Lutomirski noticed that his test suite acted differently in kvm
than on bare hardware.

The reason is that kvm used an inexact test for the icebp instruction:
it just assumed that an all-zero VM exit qualification value meant that
the VM exit was due to icebp.

That is not unlike the guess that do_debug() does for the actual
exception handling case, but it's purely a heuristic, not an absolute
rule.  do_debug() does it because it wants to ascribe _some_ reasons to
the #DB that happened, and an empty %dr6 value means that 'icebp' is the
most likely casue and we have no better information.

But kvm can just do it right, because unlike the do_debug() case, kvm
actually sees the real reason for the #DB in the VM-exit interruption
information field.

So instead of relying on an inexact heuristic, just use the actual VM
exit information that says "it was 'icebp'".

Right now the 'icebp' instruction isn't technically documented by Intel,
but that will hopefully change.  The special "privileged software
exception" information _is_ actually mentioned in the Intel SDM, even
though the cause of it isn't enumerated.

Reported-by: Andy Lutomirski <luto@kernel.org>
Tested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[carnil: Backport to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/vmx.h | 1 +
 arch/x86/kvm/vmx.c         | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -296,6 +296,7 @@ enum vmcs_field {
 #define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
 #define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
 #define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
 #define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
 
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -868,6 +868,13 @@ static inline bool is_machine_check(u32
 		(INTR_TYPE_HARD_EXCEPTION | MC_VECTOR | INTR_INFO_VALID_MASK);
 }
 
+/* Undocumented: icebp/int1 */
+static inline bool is_icebp(u32 intr_info)
+{
+	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
+		== (INTR_TYPE_PRIV_SW_EXCEPTION | INTR_INFO_VALID_MASK);
+}
+
 static inline bool cpu_has_vmx_msr_bitmap(void)
 {
 	return vmcs_config.cpu_based_exec_ctrl & CPU_BASED_USE_MSR_BITMAPS;
@@ -4915,7 +4922,7 @@ static int handle_exception(struct kvm_v
 		      (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))) {
 			vcpu->arch.dr6 &= ~15;
 			vcpu->arch.dr6 |= dr6;
-			if (!(dr6 & ~DR6_RESERVED)) /* icebp */
+			if (is_icebp(intr_info))
 				skip_emulated_instruction(vcpu);
 
 			kvm_queue_exception(vcpu, DB_VECTOR);
