Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeBSOtS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:49:18 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:50986 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeBSOtR (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Mon, 19 Feb 2018 09:49:17 -0500
Message-Id: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 19 Feb 2018 07:49:12 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <keescook@chromium.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/asm: improve how GEN_*_SUFFIXED_RMWcc() specify
 clobbers
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit df3405245a ("x86/asm: Add suffix macro for GEN_*_RMWcc()")
introduced "suffix" RMWcc operations, adding bogus clobber specifiers:
For one, on x86 there's no point explicitly clobbering "cc". In fact,
with gcc properly fixed, this results in an overlap being detected by
the compiler between outputs and clobbers. Further more it seems bad
practice to me to have clobber specification and use of the clobbered
register(s) disconnected - it should rather be at the invocation place
of that GEN_{UN,BIN}ARY_SUFFIXED_RMWcc() macros that the clobber is
specified which this particular invocation needs.

Drop the "cc" clobber altogether and move the "cx" one to refcount.h.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/refcount.h |    4 ++--
 arch/x86/include/asm/rmwcc.h    |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- 4.16-rc2/arch/x86/include/asm/refcount.h
+++ 4.16-rc2-x86-rmwcc-clobbers/arch/x86/include/asm/refcount.h
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
--- 4.16-rc2/arch/x86/include/asm/rmwcc.h
+++ 4.16-rc2-x86-rmwcc-clobbers/arch/x86/include/asm/rmwcc.h
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
