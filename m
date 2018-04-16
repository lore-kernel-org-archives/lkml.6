Return-Path: <youquan.song@intel.com>
X-Google-Smtp-Source: AIpwx4/DpudqQIYaCmRhsQr0NsHdAIUYl6ShGUqU8ddzb02XzOJBC5gmYtGBUqYAURkZXDhS+UvO
ARC-Seal: i=1; a=rsa-sha256; t=1523862270; cv=none;
        d=google.com; s=arc-20160816;
        b=vm/k+ceMYH8J8uQkHN0xoaGeoRWQDSjj6w5eHvs50f6lo/czB63WejyXuqchW/AVnp
         Jw6+xWFRrm3sJZ8Dvk0quFicsO4tJ4Ddoogd7LL0C6tZD8XTzl9gmHOPEDeocmHOYL2w
         DnkTOqocAFWXI38zGoG4XMVy5AVQg6lB9m7EYxyXmDR5hJKMB29EYE6bG3yq9OyuwBo3
         kKfKnh5oz0N+SnnJyu3DvB+4N3RV7xdSI5QATMJJwPFYv+/lj57JVmkYFjBzrsCvVoC5
         ozPgYWtL9couolxJFuwGMRD0uM4/ekF1B7xFIKoWubDowDkRhJkrEgw5M3VHh+1d6w3H
         2FVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fDyNrLiGjcsefOvZRqOVVdwdFMsINsJxD4ShgQ86FE4=;
        b=t7rRdeplpe0TDVkX92To8S/YhWtKVpsuh4mz24SmlyJYm0ZNdiOtjCwtv/lS6czuk9
         0G9k7XD+1425Td2sPBpKOryCxQXSBDJJWdWd1q5RCKWl21uX/djPto4avr5inU3dUA9h
         0ExP1VMm1PGhbdfy73sZRgjD+o5Hx46RWrYA/f+/q79CvtXAkk7D7CqLwG2S39SG22Zz
         EMhYrivVrB6AHz3TBYohnMh6Ufkyx2VASaxrNWKulwrwryEpYCX0E4zEcM8xuwkAYl14
         WwvDuSbjl/IkvofY9rM5Z89CxLpDifwC58Q4ENxg6FtgbeS7eZYks13X+KDUeCBoNgh+
         G+dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of youquan.song@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=youquan.song@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of youquan.song@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=youquan.song@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,458,1517904000";
   d="scan'208";a="43609605"
From: Youquan Song <youquan.song@intel.com>
To: youquan.song@intel.com
Cc: youquan.song@linux.intel.com,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	arjan.van.de.ven@intel.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 14/23] x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP
Date: Mon, 16 Apr 2018 14:32:53 -0400
Message-Id: <1523903583-14881-14-git-send-email-youquan.song@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523903583-14881-1-git-send-email-youquan.song@intel.com>
References: <1523903583-14881-1-git-send-email-youquan.song@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597885404142370936?=
X-GMAIL-MSGID: =?utf-8?q?1597885404142370936?=
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Youquan Song: port to 4.4]
Signed-off-by: Youquan Song <youquan.song@linux.intel.com>
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
1.9.1
