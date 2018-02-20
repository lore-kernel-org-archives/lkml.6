Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeBTK1Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:27:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBTK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:27:14 -0500
Date: Tue, 20 Feb 2018 02:26:35 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-700b7c5409c3e9da279fbea78cf28a78fbc176cd@git.kernel.org>
Cc: dvlasenk@redhat.com, keescook@chromium.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@alien8.de,
        jpoimboe@redhat.com, brgerst@gmail.com, luto@kernel.org,
        jbeulich@suse.com, hpa@zytor.com, mingo@kernel.org, JBeulich@suse.com
Reply-To: mingo@kernel.org, jbeulich@suse.com, hpa@zytor.com,
        JBeulich@suse.com, luto@kernel.org, brgerst@gmail.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, dvlasenk@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org
In-Reply-To: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com>
References: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify
 clobbers
Git-Commit-ID: 700b7c5409c3e9da279fbea78cf28a78fbc176cd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  700b7c5409c3e9da279fbea78cf28a78fbc176cd
Gitweb:     https://git.kernel.org/tip/700b7c5409c3e9da279fbea78cf28a78fbc176cd
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 19 Feb 2018 07:49:12 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:33:39 +0100

x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers

Commit:

  df3405245a ("x86/asm: Add suffix macro for GEN_*_RMWcc()")

... introduced "suffix" RMWcc operations, adding bogus clobber specifiers:
For one, on x86 there's no point explicitly clobbering "cc".

In fact, with GCC properly fixed, this results in an overlap being detected by
the compiler between outputs and clobbers.

Furthermore it seems bad practice to me to have clobber specification
and use of the clobbered register(s) disconnected - it should rather be
at the invocation place of that GEN_{UN,BIN}ARY_SUFFIXED_RMWcc() macros
that the clobber is specified which this particular invocation needs.

Drop the "cc" clobber altogether and move the "cx" one to refcount.h.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF1F802000078001A91E1@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/refcount.h |  4 ++--
 arch/x86/include/asm/rmwcc.h    | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 4e44250..d651711 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -67,13 +67,13 @@ static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
 	GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
-				  r->refs.counter, "er", i, "%0", e);
+				  r->refs.counter, "er", i, "%0", e, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
-				 r->refs.counter, "%0", e);
+				 r->refs.counter, "%0", e, "cx");
 }
 
 static __always_inline __must_check
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index f91c365..4914a3e 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -2,8 +2,7 @@
 #ifndef _ASM_X86_RMWcc
 #define _ASM_X86_RMWcc
 
-#define __CLOBBERS_MEM		"memory"
-#define __CLOBBERS_MEM_CC_CX	"memory", "cc", "cx"
+#define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
 #if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
 
@@ -40,18 +39,19 @@ do {									\
 #endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
 
 #define GEN_UNARY_RMWcc(op, var, arg0, cc)				\
-	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM)
+	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
 
-#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc)		\
+#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc, clobbers...)\
 	__GEN_RMWcc(op " " arg0 "\n\t" suffix, var, cc,			\
-		    __CLOBBERS_MEM_CC_CX)
+		    __CLOBBERS_MEM(clobbers))
 
 #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
 	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0, var, cc,		\
-		    __CLOBBERS_MEM, vcon (val))
+		    __CLOBBERS_MEM(), vcon (val))
 
-#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc)	\
+#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc,	\
+				  clobbers...)				\
 	__GEN_RMWcc(op __BINARY_RMWcc_ARG arg0 "\n\t" suffix, var, cc,	\
-		    __CLOBBERS_MEM_CC_CX, vcon (val))
+		    __CLOBBERS_MEM(clobbers), vcon (val))
 
 #endif /* _ASM_X86_RMWcc */
