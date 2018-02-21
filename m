Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2247S3+keF+BKKLe4WiftAj/KiIOWbr5BNMdsaJD+ZRJeKHJRYWeQnlL7ZAQ2gUTQYHOpxt1
ARC-Seal: i=1; a=rsa-sha256; t=1519218472; cv=none;
        d=google.com; s=arc-20160816;
        b=SNoNCDHFvqDWXpZ9d0a4j/3+UMEr2aliOk5B3Phd1+GVY60sNr/Qm1SkeYqZuP0F61
         XQ8oHHq6qPC2vdSuXhrVPTsjIx2xefnM0wQz+W/vFdBFVI2XdKTwMpFMQubalT2K8DnD
         mOOp5aGTgkCz8HPAbh1MQNNwGU455gK8LbrCymeXMafmUIoS6p47H4ItVeU9TeXuXYJZ
         OxhkrmvztaBNfGzTPckYZ4jujtHn9X+WReGtnkUnEJIs35T5SXEynoauRhS1BjknFr4Z
         ixLxpRmvsx7rTS1sC+vqWK/h+3qBn5OnuZHiOj14FlehJTR+NZLwyq6eRrYE/g+9G5DB
         NWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Inin2PbMTQ0UfH7+5UDOrkOgAab3di9rryWkev2IMyk=;
        b=c4Ya2rZ+yG6QN3b1JmFB71y6lH/2/wLeQe1UdvUg5KoAdbuocsxBQwH5QS3wx2ejDT
         A2Wm/TXueICZIjpwE0ZZGZXGGsz2TRU16kaQ1TwheTAXIUEV6YD5MkmROQeqCaLOJdOj
         CgtihwU6XGFKQztRSLBnTO4NUiO0QQpHi75Av6alBm17BbS+xXuexA8G8htuaT0s+zUV
         OoC6GEycG1dhw4TZzgSLvc3COYCdi9dvfPsMtK/8F/Xlr9X4uZ4LTZOBr4NsAVvogXa9
         dd91YEjDt4zimWzBdqhpBmQwwoYaKePq0OErK1i1GLm17t2yAaD28E0Bm9LH64crCoJO
         dG1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan.van.de.ven@intel.com,
	dave.hansen@intel.com,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	sironi@amazon.de,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 050/163] Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"
Date: Wed, 21 Feb 2018 13:47:59 +0100
Message-Id: <20180221124533.207352393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015522884375203?=
X-GMAIL-MSGID: =?utf-8?q?1593016029355445278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit f208820a321f9b23d77d7eed89945d862d62a3ed upstream.

This reverts commit 64e16720ea0879f8ab4547e3b9758936d483909b.

We cannot call C functions like that, without marking all the
call-clobbered registers as, well, clobbered. We might have got away
with it for now because the __ibp_barrier() function was *fairly*
unlikely to actually use any other registers. But no. Just no.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |   13 +++++++++----
 arch/x86/include/asm/processor.h     |    3 ---
 arch/x86/kernel/cpu/bugs.c           |    6 ------
 3 files changed, 9 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -164,10 +164,15 @@ static inline void vmexit_fill_RSB(void)
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_input("",
-			  "call __ibp_barrier",
-			  X86_FEATURE_USE_IBPB,
-			  ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_USE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
 }
 
 #endif /* __ASSEMBLY__ */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -969,7 +969,4 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
-
-void __ibp_barrier(void);
-
 #endif /* _ASM_X86_PROCESSOR_H */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -337,9 +337,3 @@ ssize_t cpu_show_spectre_v2(struct devic
 		       spectre_v2_module_string());
 }
 #endif
-
-void __ibp_barrier(void)
-{
-	__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
-}
-EXPORT_SYMBOL_GPL(__ibp_barrier);
