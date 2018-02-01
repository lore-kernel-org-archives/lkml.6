Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225NaZ9zEot8lqsHIKtZAs2ZMhIi+y59oQkFfe5Opxhj7ZO2sOuMWPRSutXTl0lk1RUTXqFQ
ARC-Seal: i=1; a=rsa-sha256; t=1517496546; cv=none;
        d=google.com; s=arc-20160816;
        b=Ee/zInFbuf54FDihAVxvISTH5G1GIa7r/76le3Ni9Y2bekGZO6GwEC1TIzqRAZx8mg
         jO105IFGrODiIdFP8eiSwJh9iDWoUCHfQtRgpO4O89unSi/7wYq8sg070klguhzSt1Z7
         3nAcXTeAUFC+rgD4NkfGIPXeE2o94VRGI03PRdljRQHqbsJzTTyjwLNcAo98ooSTfH32
         c18eGjBEzY2/BOcaU4kFdZ/zW65VIZp5dnU61/Py3GX8tRPxVZMagcgrhUDzhoz/sAfA
         smxL7YuHti1v+RwqEO5lcNGEBw1q39RzOJuWCOGuC/jPVmSrfmYIvmFifQPD/UrGnHkR
         lPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=fWagvat8uohPHyp4twsVMpNAhEYYRvGM6x82qNneUoo=;
        b=tY6yBAFh+kVdggh6RESLj5WQFXq9WsydNpJA01VlaXfdgPm8rp4vfoKrZzIw3zZcXJ
         Ib9qZG63CZ0Ws/eWuodVT2D5s62wMyIaPkcWIHwhryvDzVPfPRGNo4keJ6pLWPCZeYJZ
         rpWiHltXsgvmdkojk+DmN/C5kkh9+xwjyEfWUa8RTIwdd/btfHEPxm2fGU9or4ljaHYj
         CIj2Fi+pjs9loESBNEjYwBWIvyguEaSzjjwb8u0Zm2+KEpZjbjvKvjjd68Vm3m8w4XKW
         4Bz6VbKlfYg/WaCcSrPon10RUIWhzpcWJpPfqJlI3dIcyz5NZI48GN76tKlwtnf4ns+i
         jn5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=awWUpLZo;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=awWUpLZo;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143821.959147604@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:25 +0100
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
Subject: [PATCH 4/7] x86,nospec: Annotate indirect calls/jumps
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-retpoline-annotate-nospec.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210458303680239?=
X-GMAIL-MSGID: =?utf-8?q?1591210458303680239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Annotate the indirect calls/jumps in the CALL_NOSPEC/JUMP_NOSPEC
alternatives.

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
