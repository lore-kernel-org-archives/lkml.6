Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBrfZjdtslohuKr/NxMu0cfI7ZXAwOxgvkLNz+EzlYnyh1vnQhq9ga+oZFBxyYFfB2K7jc
ARC-Seal: i=1; a=rsa-sha256; t=1521214348; cv=none;
        d=google.com; s=arc-20160816;
        b=WC0Bvddo0DKcdw/HiLgPsp5EOymszzhNT/7qGJXRx8u0SeHyip83V7cVuJ5a2fU2cI
         /PmR9qykiRcntPGOJc7fXEwstrk767xxjwG4EMGxjbvrHdo40lLODfPNf3oh73CXuO57
         YwxghNLCqOGWFMTk6hjuYGdzsKU9dVvc9S0he2n4ZZt8WUH1A07KhdSRSF81mLZGzHgf
         /29bJGmZwqM0NDjEkZkAWHmrLcP7teqSI1MvzMno79OUYJYYoEB2yW3TMCG9MDOdNQXh
         eFHO1OGci3vda6RQpAegl69zf8C4tMxGopWiVcjJ3B5OvzsdKJ/ReuGvB6ZxofHvtagj
         EsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X7ApD6Lph2yKUs3bFhby+teuTrG1pRTP58dAsXJXNbE=;
        b=Kw8tV9Tt41oxhYmbgL6Tu8+UFV1VwAxpUGe03L3lUwO8Jfox8Vg8Z+v2G4kXGXgR1l
         Zj6agz0BDbTvJ1mKEynZ+A8z6SyxQ5a/Myc0Z78mJvyPhQ0ldk67hw+CFPdHK6q5jklB
         1wS+EaV0B8DWjQ+aXT/jSfyt58cjLk0frnK1z21+WJ7kgEfVYaGFgVm0t/Xphl76iV57
         iFVG4Vl3EqG8KSx1FKwnZZsHPBH/Pi+YIjbc9C0LhI+S8ZPbDv8RvyQ5RRSBROAk/sgk
         FOfaEMGjQgPci0Ca0O+rV+UTkEIAULnGY9AkERtO16qo+fWXLoRHQOg4fGfW4jL4u2MZ
         uYTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 45/86] x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP
Date: Fri, 16 Mar 2018 16:23:08 +0100
Message-Id: <20180316152320.495213037@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108857207652737?=
X-GMAIL-MSGID: =?utf-8?q?1595108857207652737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -257,20 +257,22 @@ static inline void indirect_branch_predi
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
 
