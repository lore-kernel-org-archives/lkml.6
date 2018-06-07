Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lhjDDxlHGVtsOwAAmS7hNA
	; Thu, 07 Jun 2018 14:54:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 86B95607E7; Thu,  7 Jun 2018 14:54:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47549606DD;
	Thu,  7 Jun 2018 14:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47549606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935390AbeFGOyg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:54:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41002 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933205AbeFGOyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:33 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbw-0005Zl-W4; Thu, 07 Jun 2018 15:09:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002kw-GW; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, rkrcmar@redhat.com,
        dave.hansen@intel.com, arjan.van.de.ven@intel.com,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, kvm@vger.kernel.org,
        karahmed@amazon.de, "Ingo Molnar" <mingo@kernel.org>,
        pbonzini@redhat.com, jmattson@google.com,
        "Peter Zijlstra" <peterz@infradead.org>, bp@alien8.de,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.161885105@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 060/410] x86/speculation: Move firmware_restrict_branch_speculation_*()
 from C  to CPP
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

From: Ingo Molnar <mingo@kernel.org>

commit d72f4e29e6d84b7ec02ae93088aa459ac70e733b upstream.

firmware_restrict_branch_speculation_*() recently started using
preempt_enable()/disable(), but those are relatively high level
primitives and cause build failures on some 32-bit builds.

Since we want to keep <asm/nospec-branch.h> low level, convert
them to macros to avoid header hell...

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -213,20 +213,22 @@ static inline void indirect_branch_predi
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
+ *
+ * (Implemented as CPP macros due to header hell.)
  */
-static inline void firmware_restrict_branch_speculation_start(void)
-{
-	preempt_disable();
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
-			      X86_FEATURE_USE_IBRS_FW);
-}
+#define firmware_restrict_branch_speculation_start()			\
+do {									\
+	preempt_disable();						\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,	\
+			      X86_FEATURE_USE_IBRS_FW);			\
+} while (0)
 
-static inline void firmware_restrict_branch_speculation_end(void)
-{
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
-			      X86_FEATURE_USE_IBRS_FW);
-	preempt_enable();
-}
+#define firmware_restrict_branch_speculation_end()			\
+do {									\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,			\
+			      X86_FEATURE_USE_IBRS_FW);			\
+	preempt_enable();						\
+} while (0)
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
