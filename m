Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x2259p8fubKryszMoVffHVL2WHFtYrNnPXi7N1EqRlQLxnPeoFaXVatg3utWUL3FDaE4lnBHz
ARC-Seal: i=1; a=rsa-sha256; t=1518439977; cv=none;
        d=google.com; s=arc-20160816;
        b=TPnzETW2rWkKhEYMZKooXBMkflBnAvdgKn3HGMvfldHlrEzLjdw63gMiMExy2IePwU
         SY0mLjclRUldp/+7Hmv1rvW1hmzvJBD5l7FnOms8axzMdgLRnJF4xlKPbAtXotKCIA7d
         qQKCbWAgTNkqxlWmbcx5hMtDutWaMhQAyvpw/QcNVL5mXpX1Y+AwGSND8jY71TLxN4bT
         mF/tMqBQR84hTJgZKIUcL4FPnUwNblxL5LQpZwUnMZ89Bf6SDixv4kYs65IHBX9uNfSF
         nVu8nObjYX+DQ3Zu3/i6DWpZs5wqYm4Zi5bF2IhIjSukRIAOhcvCxuHfEbJmScCB0mdK
         DpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=zzxSwkzluqaKzunLGs5H+dWgp3ngoABjZy7yjsXwVnk=;
        b=V1ZL46NGFs+aOaZSwo14UaFZOkx515WAemKfTF5qxNVs2CMsS39Nt0Vt0W4QtdH0Xn
         d+vM4odJ3U0Jl0+NcL2MTq0KSSf0NdfaAKdK6ptKij96zCcV4QPKEaTuqDnHb3qWNJpK
         Dxj4wLhzV020dAQYSlNiQo+C+JvBAQ5Ztv3wrxxcLmvbQ1SXCPgHW83nFu6iuahKn0SO
         Z8zQB/sfUIZlbQCLrKT83n4FikQw6pfz9hYYO+G9bh6vdEwmXTJxnzkBnaSIhjEyvNIU
         lnq/l3vw3I5RBooAQgIVhqT5A53rpJaQJ/9wlurSQb92Jhvmg/z39C/+YbSQbLKcEnfK
         NpRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=wV7WDXXs;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=wV7WDXXs;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.500513960@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:49:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 5/8] x86,nospec: Annotate indirect calls/jumps
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-retpoline-annotate-nospec.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199718005457841?=
X-GMAIL-MSGID: =?utf-8?q?1592199718005457841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Annotate the indirect calls/jumps in the CALL_NOSPEC/JUMP_NOSPEC
alternatives.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -67,6 +67,18 @@
 .endm
 
 /*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+.macro ANNOTATE_RETPOLINE_SAFE
+	.Lannotate_\@:
+	.pushsection .discard.retpoline_safe
+	_ASM_PTR .Lannotate_\@
+	.popsection
+.endm
+
+/*
  * These are the bare retpoline primitives for indirect jmp and call.
  * Do not use these directly; they only exist to make the ALTERNATIVE
  * invocation below less ugly.
@@ -102,9 +114,9 @@
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(jmp *\reg),				\
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
 		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*\reg
 #endif
@@ -113,9 +125,9 @@
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(call *\reg),				\
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
 		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; call *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*\reg
 #endif
@@ -143,6 +155,12 @@
 	".long 999b - .\n\t"					\
 	".popsection\n\t"
 
+#define ANNOTATE_RETPOLINE_SAFE					\
+	"999:\n\t"						\
+	".pushsection .discard.retpoline_safe\n\t"		\
+	_ASM_PTR " 999b\n\t"					\
+	".popsection\n\t"
+
 #if defined(CONFIG_X86_64) && defined(RETPOLINE)
 
 /*
@@ -152,6 +170,7 @@
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
 	X86_FEATURE_RETPOLINE)
