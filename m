Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu4Q3u5PWGhvAnnddgmtIlJXNvQJfPCY+WjkoasyixbSLrfOpShfCyOGF+gU0tF4zvk65YJ
ARC-Seal: i=1; a=rsa-sha256; t=1520955114; cv=none;
        d=google.com; s=arc-20160816;
        b=cemIo+5JqB9b0ImLgnfkVX+fOoAvq6xZWax55/DeTrlMpBVumvelfc68dNUyDX/Lu6
         A1/LhUVYegl6BQGopAFwNFVv6e4gu9DAdzBLqzoIL1E8/VelovfumPL9zswv2Fn66M2p
         7Rho9VUVOQjFCIQKjFjwfw92EPjGXsvMuUAcFRtw03b/WAoZLJU18bPPglT/QLGmd96s
         kQB0xNMaF/aisc75WsYtbWxNo1ISNfGnXW89vEu/eEJPwO1CFQ7bnDVAotODlJWKua05
         b0kaL0H0kLsU3n49cErNHNB2+8ODYdToDURoJu65MD/a47rk1Lr39PqOC5gpew/eath+
         jgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yGQ8WUZgSO9/0/bXeECF03v4eemCPMpgFaYZu4CsicQ=;
        b=JgsGbDZShTq+fF6+BZzelf3mX/bOt3xrjKYtPXEv88LUmZi09ob30uKqXsu5hAd9ek
         lGcKhzuzdEJDEh3jVwkatUOwVs9KsPk4d4+eDmdFn2N/Nk4DBsh6589+6Y7Ekk9oZjnd
         ZswoSLHEGgb8UHSJ5OsqMciIMPJq3siWliotJkDGgJPT/c0tpnzntwDDck1dIfd3v2Iy
         Q6u6c3mOITqUxbFQ1L4xqWmOYPeb5ggBgW0H+f7u84gieddAmPsdKPDBydp4TWx4uEOm
         qalX2dbQ9AuPBolha9iM/9KBi8t8LE7dxZUzP3YyA+LEi2UABjJiKHjyi3LBv02o5yP9
         qJHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.15 093/146] x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP
Date: Tue, 13 Mar 2018 16:24:20 +0100
Message-Id: <20180313152327.844201107@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837030265260567?=
X-GMAIL-MSGID: =?utf-8?q?1594837030265260567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
