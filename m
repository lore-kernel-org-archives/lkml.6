Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224d6sKKDXcW1omfQEiEh9fEs2AMrgBxISVUOvuMAp+NzebEsESypky15ZzjLQicf2H9zsDO
ARC-Seal: i=1; a=rsa-sha256; t=1517855041; cv=none;
        d=google.com; s=arc-20160816;
        b=Lbeigp6pUEV3egdOO8nHPpSuNU949j0uMZU2eUNSMUve8EEnFXkDtLA3cgh4o49Bg0
         N/L+Bn6+eF/n1mJIDUlkY/92QEqq/go1rMYk66AZxETXEflk0TxctOdH0+66p6+bf8Z8
         Pj9jkvwzvMsiTsIaeQZixUnLIvJBI2rpfrXEQIst38Dcux4zli7AbefcAlHTD8tqm9HB
         uD49qNJdLF0EYG7LruqUbHcjn0huRRmnXcfat1Qb/xToFGjRMow9SWUXACRMDozbJlrs
         5iQFvgS7djltZZWxrFIEsRUmbVl2z+2xRfRBfS3I8cY/UEuFZoyQ4v8nj9WorEyqUrZF
         RuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6Ute/cXyzOGvFlCfltv0bLuNKs+Vd4lAVeK1lLdob0s=;
        b=sJumxl5/edlXwQFd2HMNzScqyxCZDqGmFmjl2yeSx3akWT/7gZfAVKUo+cyGM8KSXd
         XUEk8CTKr+r0KP3V0gqFEv8DwLSjO0iUDV0voXzTd53S7lpO/XnPGs9qI3ne5nO1roCS
         ssBZ+nhh99UbDKaxvbrvTYRADo5836KT7dMqu14//UdaiktgRAD6D9jCMq51FTXg5nuN
         z+n2DzoHNq0noFPiPh7kJ8cD5aBAMWh2eByddL8BQxamceHlfuUSLrlxA51+QRmzrpbF
         lLZAmdxZYHb9Z/Ah/5wg1sZSk0DimReeiS6Yky0KDiIiccSwEigVLvR8SczikCOZtsBu
         M9Sg==
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
Subject: [PATCH 4.14 05/64] KVM: x86: Make indirect calls in emulator speculation safe
Date: Mon,  5 Feb 2018 10:22:24 -0800
Message-Id: <20180205182138.793954774@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586367842666106?=
X-GMAIL-MSGID: =?utf-8?q?1591586367842666106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -5350,9 +5351,9 @@ static int fastop(struct x86_emulate_ctx
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
-	asm("push %[flags]; popf; call *%[fastop]; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [fastop]"+S"(fop), ASM_CALL_CONSTRAINT
+	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
 
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
