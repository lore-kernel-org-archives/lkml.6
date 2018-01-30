Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeA3Wib (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:38:31 -0500
Received: from terminus.zytor.com ([65.50.211.136]:37101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbeA3Wi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:38:28 -0500
Date: Tue, 30 Jan 2018 14:35:10 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-b3d7ad85b80bbc404635dca80f5b129f6242bc7a@git.kernel.org>
Cc: mingo@redhat.com, torvalds@linux-foundation.org,
        thomas.lendacky@amd.com, keescook@chromium.org,
        dan.j.williams@intel.com, mingo@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        ak@linux.intel.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, hpa@zytor.com, tglx@linutronix.de,
        ak@linux.intel.com, mingo@redhat.com, torvalds@linux-foundation.org,
        thomas.lendacky@amd.com, dan.j.williams@intel.com,
        keescook@chromium.org
In-Reply-To: <151727415361.33451.9049453007262764675.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727415361.33451.9049453007262764675.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86: Introduce barrier_nospec
Git-Commit-ID: b3d7ad85b80bbc404635dca80f5b129f6242bc7a
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

Commit-ID:  b3d7ad85b80bbc404635dca80f5b129f6242bc7a
Gitweb:     https://git.kernel.org/tip/b3d7ad85b80bbc404635dca80f5b129f6242bc7a
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:02:33 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:29 +0100

x86: Introduce barrier_nospec

Rename the open coded form of this instruction sequence from
rdtsc_ordered() into a generic barrier primitive, barrier_nospec().

One of the mitigations for Spectre variant1 vulnerabilities is to fence
speculative execution after successfully validating a bounds check. I.e.
force the result of a bounds check to resolve in the instruction pipeline
to ensure speculative execution honors that result before potentially
operating on out-of-bounds data.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727415361.33451.9049453007262764675.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/include/asm/barrier.h | 4 ++++
 arch/x86/include/asm/msr.h     | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 173b38f..30d4061 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -48,6 +48,10 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
+					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 07962f5..30df295 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -214,8 +214,7 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
 	 */
-	alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC,
-			  "lfence", X86_FEATURE_LFENCE_RDTSC);
+	barrier_nospec();
 	return rdtsc();
 }
 
