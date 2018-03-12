Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELt/AqbRDNTPRkVugMR8qJzVjsERcOIlW0WUbQx2CfDgpVxNh0ct/OGo1fN6xsGHabZllyOu
ARC-Seal: i=1; a=rsa-sha256; t=1520824076; cv=none;
        d=google.com; s=arc-20160816;
        b=yDcVfieOVvL3QVWm53uPwHFZGGUbPpwZNBeifNxyluEBymjVbZCeW6QmJYtaXsbtjx
         7r8Y4zlEpIeaVp+l840pjGlLzWli0viCMsR+zhx8t2nvcBbOHylMPMqCv0+1upmwpI7H
         c4pDbP9U+Maiexck/ZQWXhiIlhvXdnYUcUX/n+h7lBPfCr7ZO1AqKh0WoBAZws0YJ1mL
         10DN0l1oOPmA9tlUMShmjT96iqQJFX56zZm7KwdU/TH+o/rfZcVZNq/O4R7ZfWyJFI0i
         eGchuvSJKl72rulThWS4yjW9ZW70kB0669+/K3AS0PAXvuyCEXMn7+Fv+kXr4rKXxC+k
         hJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=NvEYTpJRitVj7PytOjDV2prJq0OrBy/KxEMbWHXRMY0=;
        b=NuXcjngVM8gDzqta433zaCMeBlodEzrq3U9EwZnQNMFhEiSOHcLnXQU3jH+PC9JcHG
         r/upgOKJZf3ObCrMsY/XTzpz3SIo1E/+DCV25Nq2Vlbc29HY7Ou36eR5RRf5swrBwAK5
         nGL+WCK/Lgggov6vxuNNiAEgbz0zHUFNKM9vrV90wZ+5tuEMVtEtzPaZQg+TfW3nmW4r
         wCCzZEeO9Tlwmatj3hbX3HTPgz/arHdzNjAWBpmOB24Ay9SCDIuPlORU9TAgQjDZ5jQ9
         4TnThcXiCE0iG1QzldPI2NlLbi3BnH/pYAnqV/81If/N5ikaVaMe57Wu/3u87SOFxVfX
         nG/A==
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
 "Andy Lutomirski" <luto@kernel.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.250134091@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 34/76] x86/retpoline: Add LFENCE to the retpoline/RSB
 filling RSB macros
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699626169212684?=
X-GMAIL-MSGID: =?utf-8?q?1594699626169212684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 28d437d550e1e39f805d99f9f8ac399c778827b7 upstream.

The PAUSE instruction is currently used in the retpoline and RSB filling
macros as a speculation trap.  The use of PAUSE was originally suggested
because it showed a very, very small difference in the amount of
cycles/time used to execute the retpoline as compared to LFENCE.  On AMD,
the PAUSE instruction is not a serializing instruction, so the pause/jmp
loop will use excess power as it is speculated over waiting for return
to mispredict to the correct target.

The RSB filling macro is applicable to AMD, and, if software is unable to
verify that LFENCE is serializing on AMD (possible when running under a
hypervisor), the generic retpoline support will be used and, so, is also
applicable to AMD.  Keep the current usage of PAUSE for Intel, but add an
LFENCE instruction to the speculation trap for AMD.

The same sequence has been adopted by GCC for the GCC generated retpolines.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@alien8.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Link: https://lkml.kernel.org/r/20180113232730.31060.36287.stgit@tlendack-t1.amdoffice.net
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -11,7 +11,7 @@
  * Fill the CPU return stack buffer.
  *
  * Each entry in the RSB, if used for a speculative 'ret', contains an
- * infinite 'pause; jmp' loop to capture speculative execution.
+ * infinite 'pause; lfence; jmp' loop to capture speculative execution.
  *
  * This is required in various cases for retpoline and IBRS-based
  * mitigations for the Spectre variant 2 vulnerability. Sometimes to
@@ -38,11 +38,13 @@
 	call	772f;				\
 773:	/* speculation trap */			\
 	pause;					\
+	lfence;					\
 	jmp	773b;				\
 772:						\
 	call	774f;				\
 775:	/* speculation trap */			\
 	pause;					\
+	lfence;					\
 	jmp	775b;				\
 774:						\
 	dec	reg;				\
@@ -60,6 +62,7 @@
 	call	.Ldo_rop_\@
 .Lspec_trap_\@:
 	pause
+	lfence
 	jmp	.Lspec_trap_\@
 .Ldo_rop_\@:
 	mov	\reg, (%_ASM_SP)
@@ -142,6 +145,7 @@
 	"       .align 16\n"					\
 	"901:	call   903f;\n"					\
 	"902:	pause;\n"					\
+	"    	lfence;\n"					\
 	"       jmp    902b;\n"					\
 	"       .align 16\n"					\
 	"903:	addl   $4, %%esp;\n"				\
