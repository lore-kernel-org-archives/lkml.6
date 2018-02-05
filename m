Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227vnPI7xvuan0AzF8IiDRJMdrKz9a36/gAGRKeW951lmNCLtl0Pjt8r5+2O7KXH+ts5OHZU
ARC-Seal: i=1; a=rsa-sha256; t=1517855089; cv=none;
        d=google.com; s=arc-20160816;
        b=oHuY1TyoCJJ5RJlLyXyksBYZIhbFIwMud5rBL62rhgaz3HUqpXGCTabNXzNp4q5Ng4
         ko9yNozM+JaYp08tm6Dr1mN8YsyXpXYH9yj58xWleQQBtFG0AsgWsxO6mdcl2IM5g0lg
         3uNseE9s7hizZy3OpJ7YRMb0QZOBC5qfjW7/w/QaCDuSFxDPqMN4zzbHwZQOq61vle5v
         Lf3T/WUNN4L5Gj35HKPmCY7ckGSzAuTYC5K+bUxtV7qxI/Qpk73XTtNEe0DdVABdgkeR
         fCA3hkBvE4VYmcR/t5TjXPeAB4CRdsAmEuKFSd+X+HF/pvPZV27ZiAEN6gsctlQBU0QH
         Q+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9GnOGtwGjy7EW9kobu6Rlaqo63zThck4DNaeraiYp6s=;
        b=wNYt58iQHDhXjUqtBA+lBddm+GrfBfRKd0ttueQLonsgPmcnhfXEYWtzl0eCKy7e5N
         U+H32F8hRXbQ0xHLmXBo051V6dBXT/2tGhoCXJs6Pq5qLRztskMCKPWZGhZZSWKoM8xM
         O7FJUKNy2jsU2kHV95Jqc/TXYKQYnfJwmgWf18r+cAXreWbw6Rw6aJkFJY3Im86RyMd0
         bMvL9MpJZWSffW2s0SZarkrYjci925p29X1yI9JJS6BRONTavF42svMULPWkfkG0OEIP
         risNgau8jBAj4Pt8+SSEeal4hvDiMpxvqmaQ82Zxf4RIK3dmH+VY09VS6sAZbWjjE1h9
         90zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	rga@amazon.de,
	Dave Hansen <dave.hansen@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 4.15 01/60] KVM: x86: Make indirect calls in emulator speculation safe
Date: Mon,  5 Feb 2018 10:22:34 -0800
Message-Id: <20180205182213.964489652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586367842666106?=
X-GMAIL-MSGID: =?utf-8?q?1591586418038007798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra peterz@infradead.org

commit 1a29b5b7f347a1a9230c1e0af5b37e3e571588ab

Replace the indirect calls with CALL_NOSPEC.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rga@amazon.de
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lkml.kernel.org/r/20180125095843.595615683@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kvm/emulate.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -25,6 +25,7 @@
 #include <asm/kvm_emulate.h>
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
+#include <asm/nospec-branch.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -1021,8 +1022,8 @@ static __always_inline u8 test_cc(unsign
 	void (*fop)(void) = (void *)em_setcc + 4 * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; call *%[fastop]"
-	    : "=a"(rc) : [fastop]"r"(fop), [flags]"r"(flags));
+	asm("push %[flags]; popf; " CALL_NOSPEC
+	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
 
@@ -5335,9 +5336,9 @@ static int fastop(struct x86_emulate_ctx
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
-	asm("push %[flags]; popf; call *%[fastop]; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [fastop]"+S"(fop), ASM_CALL_CONSTRAINT
+	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
 
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
