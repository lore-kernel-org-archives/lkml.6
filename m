Return-Path: <youquan.song@intel.com>
X-Google-Smtp-Source: AIpwx4+PWDfHjOM82ZdVS9B/GU1rG4GDrsXp+ruNRiDPR1/NI7qBH5PFJ0oMqAfgCZIl9XO0zSN0
ARC-Seal: i=1; a=rsa-sha256; t=1524021586; cv=none;
        d=google.com; s=arc-20160816;
        b=OjVl6CuQxFeE8Xypukx6AqZ26BwwrQsWcq7oI8fSQPvWreykf0Ux6viJ+o49UEvGkJ
         nzsG1pBgI3Y7vJc3Cs0IPSePh9sJbSyry7TRSPZ7Ir/CrSXEAyPQJ54gp03gtdJiarEz
         rCMxlpUzsXtwNmESyXfTieWKTSLXlfHVIWCjGw/8bjDDCG5BrBmUlEosqzNVqsaDr2QE
         YuydDQLNHi1oeZZUmS8p5nltIr6XuCNIrbajypq/sEpCJT2P2h5+nXXQrwlU/5emsa4Y
         bcHF0+un0U1XDj9wkFUzwa1lzLKGxNUEwWSjZ4L5tisVLNQoNcCc4ufaDQrUiRGLsKdq
         7aVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=L3Fa1hLE7gRLvHJGIVKv0bvTkfUhBLi156LLb2KS9/o=;
        b=WTvGxT12rrXYnKQTeqUdfv3yLo7vvrudU4CtrURhyCboJh8UbPypd80MtAfOa/3Ud8
         Ar1DSKj/UQ0wbec4I9zlz0CzB/5CL7AyRnn+dQTJJPIN9gdBrqsAkQKVwaWEO3Q+ioTt
         WbW0+6qLHbCK/SSBKlk06EwLb4L4rxvKVX3x3V1xTBehacRVDPs3UY3Sr/owSj77Jgps
         G6ECedTnCODxhAqufkkUcgyPDMKGp39r/NJS1CvVE6jwxro2nlTdzEoakr6lrDR1bIR8
         fC+HakW+I+8S2+1UsuXioZxPpofPrdQ1TNvbwyFKICSGqvsp0Ckgpp60KVVW3ngIoBHb
         Cqkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of youquan.song@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=youquan.song@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of youquan.song@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=youquan.song@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="35084908"
From: Youquan Song <youquan.song@intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tim.c.chen@linux.intel.com,
	ashok.raj@intel.com,
	dave.hansen@intel.com,
	yi.y.sun@linux.intel.com,
	youquan.song@intel.com,
	youquan.song@linux.intel.com,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	arjan.van.de.ven@intel.com,
	bp@alien8.de,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP
Date: Wed, 18 Apr 2018 11:18:22 +0800
Message-Id: <1524021512-24022-15-git-send-email-youquan.song@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1524021512-24022-1-git-send-email-youquan.song@intel.com>
References: <1524021512-24022-1-git-send-email-youquan.song@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598052459247189744?=
X-GMAIL-MSGID: =?utf-8?q?1598052459247189744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ingo Molnar <mingo@kernel.org>

(cherry picked from commit d72f4e29e6d84b7ec02ae93088aa459ac70e733b)

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
Signed-off-by: Youquan Song <youquan.song@linux.intel.com> [v4.4 backport]
---
 arch/x86/include/asm/nospec-branch.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 27582aa..4675f65 100644
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
 
-- 
1.8.3.1
