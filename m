Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225LSSwbI8AenS6OTU1yviFUogtRdL9ZxvCCtwWT3V7vMkX1TLJ5gRE8cjZnmFgWl4tAhopt
ARC-Seal: i=1; a=rsa-sha256; t=1519411229; cv=none;
        d=google.com; s=arc-20160816;
        b=oG6XVR3KQPDMp1X8s1Ay4x0KUpDz3a4TAjqkHfe0KkxpNmBOA3MPcyTFG6k0+UGQZY
         HswDSFxc7maBsR19Pz3YcmV2ZMtLOJ7QYDBxte6g6LV6P+dl1VXrt1T0WTrexy7aBouT
         OsPk+Zd8b/0960O65Nw4sD0nFf8TMpA/p8NDuGgWi/qwrVSAWplek9pQPoCjVVAjjtHD
         aGjfNRpoGP77rLdTCRMjaPHmnqXdS1YvrZGiWxecvjaXz5F1EHDqG/SHW4ebkaMEkNMO
         x+oR2MhO/kBX9kLMuzg/0ctgRPBsb1Ls9TP6ALXucEwkLxYhFDJfndhD+tJseMsSGEpC
         UdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DjFF6T9ZSIRRywSafnfS7uKy/3jJXE1S23PO5Z7oBsg=;
        b=heg0pLCYUmK7ly0n/34/StJxXy81D5YSx5gxmxCruyYxTMFRjTMAOxHJan2gbSIy+3
         3fNc4YssOg5RzgyvqN2oZqm9oE2ZfrBvIxULk/UChDWzlhw965GMt1fLdl3Ft4gHbOBX
         ruaAo412/xWW6RK46fv+4ZEZ/0zOe0HmNa3PuJvXfptV4MHwrwTimU7oxByDocr8BAsa
         p/Z6IswhABYmkboHfXOAL8Po2qdW6PPdzFSKnn/dk2fCS5rypb9mAM4BeyB/Hh/BGNLY
         i5LiBgmX+nAlvhKVmMGEdPjgOQJg25kL4Ht5E2qcpU7cM7wnYU9ggfNofaXIFqzg2fRF
         6UPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	Tim Chen <tim.c.chen@linux.intel.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 166/193] KVM: x86: Make indirect calls in emulator speculation safe
Date: Fri, 23 Feb 2018 19:26:39 +0100
Message-Id: <20180223170351.993016228@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218149195818842?=
X-GMAIL-MSGID: =?utf-8?q?1593218149195818842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

(cherry picked from commit 1a29b5b7f347a1a9230c1e0af5b37e3e571588ab)

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
[dwmw2: Use ASM_CALL_CONSTRAINT like upstream, now we have it]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[backport to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/emulate.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -26,6 +26,7 @@
 #include <asm/kvm_emulate.h>
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
+#include <asm/nospec-branch.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -1000,8 +1001,8 @@ static u8 test_cc(unsigned int condition
 	void (*fop)(void) = (void *)em_setcc + 4 * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; call *%[fastop]"
-	    : "=a"(rc) : [fastop]"r"(fop), [flags]"r"(flags));
+	asm("push %[flags]; popf; " CALL_NOSPEC
+	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
 
@@ -5297,9 +5298,9 @@ static int fastop(struct x86_emulate_ctx
 	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
-	asm("push %[flags]; popf; call *%[fastop]; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf; " CALL_NOSPEC "; pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [fastop]"+S"(fop)
+	      [thunk_target]"+S"(fop)
 	    : "c"(ctxt->src2.val));
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
 	if (!fop) /* exception is returned in fop variable */
