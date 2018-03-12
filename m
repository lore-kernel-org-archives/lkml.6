Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELu+NPyC2jqASstVPXqIscrVBKi3/9V6gX+pKO+/AsOpx2bp+8NjbTszyQXJ6ZORkz7Q2Tl+
ARC-Seal: i=1; a=rsa-sha256; t=1520824079; cv=none;
        d=google.com; s=arc-20160816;
        b=oHWuSGjouFsNMgvqxHsRLwMrEdNbsZEtM/k3xEVwq1uB/b8BBUlufvEn2G97Fl2asO
         TEvXSInCww/3IEVtFt3FYCUA3YsCMNwASXbWb6ZdpBMNIwTu7aHHqaE2s/d1aAm4dSTi
         zxLF72tKZYQCaKqzc/k/kXP+D84Pbd0U/aj/n6tneHLJnNGWksp1/EyrWgB8z4SBd1g7
         KOIsdXwgD2yqBxoDpn+0qTW8cGwXyrVKEcx89Z5vNk85rKwf7B829j9T4UAtD1BKzLPt
         E+tPv37OZZS+SCqdJ7/kVVxZxFLUh3n0dOttEH16bclFOU/jPQCAEHRKUS0QqQ+qMh0c
         k/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=U0mEoICuDxarf7rYzGXxmbWGRvWO3TA/5FRTNpccuzA=;
        b=pgf8LhtQaDsuh/Mdmq++E3/AcQpLRyVkx7HhtI+nRACZVWrf6mmxW3Dyc+hYm2pX3L
         SdXGoRzj24Aqu0TvUmSWZnqFyPVuQm7SEiMOvWPdvJJSaMt2alMGKgE90hJC8WTYj9B1
         2LaksX7UpYvaydxNjSQSbm2uKoStmh+0q9mEtoTt3JT/POzuGqR1Cd3ihGycDeCRo7r/
         z5IKhpG4SXIfzGMmsKnyV9vK+WylJ0tbyi0V61rgUWiB2pdW1hq1aOqC7K4hyo/fOaxl
         U/YGhq4yUkXW4JOrAPkI1O6KERNJpsmyQxwATJi28UieDKhK4+d7eCVvJysm/3Kl5EX+
         E57w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Asit Mallick" <asit.k.mallick@intel.com>,
 "Jason Baron" <jbaron@akamai.com>,
 rga@amazon.de,
 "Dave Hansen" <dave.hansen@intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jun Nakajima" <jun.nakajima@intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andrea Arcangeli" <aarcange@redhat.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.507953570@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 44/76] KVM: x86: Make indirect calls in emulator
 speculation safe
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699629763359942?=
X-GMAIL-MSGID: =?utf-8?q?1594699629763359942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 1a29b5b7f347a1a9230c1e0af5b37e3e571588ab upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/emulate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <asm/kvm_emulate.h>
 #include <linux/stringify.h>
+#include <asm/nospec-branch.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -906,8 +907,8 @@ static u8 test_cc(unsigned int condition
 	void (*fop)(void) = (void *)em_setcc + 4 * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; call *%[fastop]"
-	    : "=a"(rc) : [fastop]"r"(fop), [flags]"r"(flags));
+	asm("push %[flags]; popf; " CALL_NOSPEC
+	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
 
@@ -4622,9 +4623,9 @@ static int fastop(struct x86_emulate_ctx
 	ulong flags = (ctxt->eflags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	if (!(ctxt->d & ByteOp))
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
-	asm("push %[flags]; popf; call *%[fastop]; pushf; pop %[flags]\n"
+	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
 	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [fastop]"+S"(fop)
+	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
 	    : "c"(ctxt->src2.val));
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
 	if (!fop) /* exception is returned in fop variable */
