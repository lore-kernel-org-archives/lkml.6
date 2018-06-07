Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IWh6Bn1LGVsZXAAAmS7hNA
	; Thu, 07 Jun 2018 15:13:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6920A6063F; Thu,  7 Jun 2018 15:13:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BA339601C3;
	Thu,  7 Jun 2018 15:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA339601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeFGPN0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:13:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41436 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964886AbeFGPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:16 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvby-0005hL-44; Thu, 07 Jun 2018 15:09:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jt-UQ; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        peterz@infradead.org, ashok.raj@intel.com,
        "David Woodhouse" <dwmw@amazon.co.uk>, bp@alien8.de,
        ak@linux.intel.com, gregkh@linux-foundation.org,
        dave.hansen@intel.com, "KarimAllah Ahmed" <karahmed@amazon.de>,
        torvalds@linux-foundation.org, arjan@linux.intel.com,
        gnomes@lxorguk.ukuu.org.uk
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.974775658@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 047/410] x86/speculation: Add basic IBPB (Indirect
 Branch Prediction Barrier)  support
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

From: David Woodhouse <dwmw@amazon.co.uk>

commit 20ffa1caecca4db8f79fe665acdeaa5af815a24d upstream.

Expose indirect_branch_prediction_barrier() for use in subsequent patches.

[ tglx: Add IBPB status to spectre_v2 sysfs file ]

Co-developed-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-8-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Renumber the feature bit
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h    |  2 ++
 arch/x86/include/asm/nospec-branch.h | 13 +++++++++++++
 arch/x86/kernel/cpu/bugs.c           | 10 +++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -189,6 +189,8 @@
 #define X86_FEATURE_INVPCID_SINGLE (7*32+10) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_RSB_CTXSW	(7*32+11) /* "" Fill RSB on context switches */
 
+#define X86_FEATURE_IBPB	(7*32+12) /* Indirect Branch Prediction Barrier enabled*/
+
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -194,5 +194,18 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
+static inline void indirect_branch_prediction_barrier(void)
+{
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -358,6 +358,13 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		pr_info("Filling RSB on context switch\n");
 	}
+
+	/* Initialize Indirect Branch Prediction Barrier if supported */
+	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) ||
+	    boot_cpu_has(X86_FEATURE_AMD_PRED_CMD)) {
+		setup_force_cpu_cap(X86_FEATURE_IBPB);
+		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+	}
 }
 
 #undef pr_fmt
@@ -387,7 +394,8 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IPBP" : "",
 		       spectre_v2_module_string());
 }
 #endif
