Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225bTstRYDicbq9lGS7Vs/v6GnsBQDLCEZNbMJO97e3CEYs8rNRJS8vWt2oGRA7XhjSWC0G8
ARC-Seal: i=1; a=rsa-sha256; t=1518440011; cv=none;
        d=google.com; s=arc-20160816;
        b=MgMy8Ff+HOjflX6PccX/s5nWJ93lVYXDGDvCwUIaLPNCS0Z3++x7aYadDTlzStdyJ1
         lgmjbAH9LG1U7SY7tfDYDYlUGn0Z29riUHgJL4IhoeOv4Ex5itlmQqBXp3kfUX1hJGbS
         yl+nq8P6ICitJU/vncSTuoQHjHusPZpw08Dfa8Pto7sXiUyYXKgfBdeFjI6TKLVJq+4L
         QL1+X2spkk2oC/Wos6jG6Cj62URd5OLWr5fprFCMULsyAv5ykTb0eU84nL6vDiwMyYIX
         KPyqlWe9qr1eBlT25tDH4eHeq8W8W2/PNu7Rtaf0rXGHuC0l9XK9Nx8DB9PX2nyG6JY9
         gr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=VncAG6Yue6/EToDLngxBumz3zZ90TmCpaWVpWYIM8Dk=;
        b=k6KJgPpGvbkkcwFwbht8X/c2RkTs0lk+nmOlgn7xKSmZk6cjLeJaPfNVuZ0WV3LeLs
         FAjcx25Gou2mOOqQ8kdci70FFGkSLHKRQiDLe5C0K43IInsGTEBJGcoqqdi6LU5LNpNh
         AVEgC8WPeB6Js2/sEm7GihgmWrK1EToGUmqWGdcjwHK4rT3bcaxhZxzX/GBOWisnlcm2
         YTXyb/rq85lDSWsxzrlbmVvtrbIXj7QFxLPsBdCX+QIsANP5R/z5/JbuhPaIm4TAREQ8
         J46g92GPXVYaWa1y5fD3tKkjY4B9vIUVdAkQiPKjF3Mq6N2xriejpQhn2zqe1i3HLN3x
         6wEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=DxZQozft;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=en67LlDn;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=DxZQozft;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=en67LlDn;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 85.118.1.10 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.612750222@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:49:02 +0100
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
Subject: [PATCH v2 7/8] x86: Annotate indirect jump in head_64.S
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-retpoline-annotate.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199753507720428?=
X-GMAIL-MSGID: =?utf-8?q?1592199753507720428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The objtool retpoline validation found this indirect jump. Seeing how
it's on CPU bringup before we run userspace it should be safe, annotate
it.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/head_64.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,6 +23,7 @@
 #include <asm/nops.h>
 #include "../entry/calling.h"
 #include <asm/export.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -134,6 +135,7 @@ ENTRY(secondary_startup_64)
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
