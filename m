Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvzHoCcyQU4Sb6CsXkqiUtDjM9++dhTFnatmfnvaACQ/h8UFLnAv2lum8/MNBRgLmY35ryC
ARC-Seal: i=1; a=rsa-sha256; t=1520824086; cv=none;
        d=google.com; s=arc-20160816;
        b=QrLsMlAODQARNQFGKtue480XsTaOyDOzIv8iq+oVHSGLniITrgrR0cRY0qa0nxxJEG
         ZZKHjVvswjJyq8T+nYLa1PPKBin4YmXo09JtxORqDV+ffPBpcVeL6MdcKprfSQgbEPpb
         qk4KdXi52LmamCxX7t3H7BILeKDDF+p/V+0MEgTtorEEML1yupWBTrBac4yyrtq71wdH
         bYVY6uAneG7hDulJyGXZb7CrudCRlZDVXFQKjhtFiXRbtfCAxJ6JkS/kK+aYRxz3xhNN
         /xb//zDpl+0UAW9qR3s7IJxyGyh8Bn21KpVK/NEzUJBfDW0x6t80580QZUWTzey/B4up
         UZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=/718AbO/5QX/YLB/QeiwdmQdgdBS6Qt/dYkPtGdDLg0=;
        b=IJ8gWxmf4bNIbctcZVGXZJa+Mi1USogrVFQ5kl7aF06GD0/OJ64kqWQIaNk9DfjCkX
         xJeXQgUIB+Qqm6hwbAHuOB71QHq5vj8DcJwXDZUBbsqnQAT9kOOgJ/DGICR7yU4HYiPk
         qnW/0mave71VtrBg4W/bvx95w2EyP/tWfiJeifiDmkOsv+DrnrpGbpQNrbCEnr4jW8Rf
         P5NwA/R+1XUkB3Zynr0uQ51hFEh87KQVG1La8JJ+PWpBxHDICyzBG+biGFfbBLn0yEh+
         IZHx0y78wRELVnMyhqNNWIudx3o5zCtxYcbhawO4a+kAZ9ZxJSm2cDBLX6PyNwVanqyR
         m9Uw==
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
 "Peter Zijlstra" <peterz@infradead.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Kees Cook" <keescook@google.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Borislav Petkov" <bp@alien8.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.125511840@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 068/104] x86/retpoline: Add LFENCE to the
 retpoline/RSB filling RSB macros
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699626169212684?=
X-GMAIL-MSGID: =?utf-8?q?1594699637261187801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
