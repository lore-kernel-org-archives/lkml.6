Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 09:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73E2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D73E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeGNJvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:51:16 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:33171 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbeGNJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:51:16 -0400
Received: from c-71-231-194-96.hsd1.wa.comcast.net ([71.231.194.96] helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1feGv0-000ZaH-Rz; Sat, 14 Jul 2018 05:32:47 -0400
Subject: [PATCH 4.4.y 046/101] x86/speculation: Move
 firmware_restrict_branch_speculation_*() from C to CPP
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        arjan.van.de.ven@intel.com, bp@alien8.de, dave.hansen@intel.com,
        jmattson@google.com, karahmed@amazon.de, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "Matt Helsley \(VMware\)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>, matt.helsley@gmail.com,
        rostedt@goodmis.org, amakhalov@vmware.com, ganb@vmware.com,
        srivatsa@csail.mit.edu, srivatsab@vmware.com
Date:   Sat, 14 Jul 2018 02:32:43 -0700
Message-ID: <153156076310.10043.16178311649528282443.stgit@srivatsa-ubuntu>
In-Reply-To: <153156030832.10043.13438231886571087086.stgit@srivatsa-ubuntu>
References: <153156030832.10043.13438231886571087086.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
---

 arch/x86/include/asm/nospec-branch.h |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 36ded24..b9dd1d9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -214,20 +214,22 @@ static inline void indirect_branch_prediction_barrier(void)
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
 

