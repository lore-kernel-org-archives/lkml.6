Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu7B34GSudAEpmAOizHU0aXjfd9UDmjk/ebgamWqnFGbBET38ZUnCTzE3nogmdCeQksKUoa
ARC-Seal: i=1; a=rsa-sha256; t=1520955683; cv=none;
        d=google.com; s=arc-20160816;
        b=zbSJaBrwUN/d3HL+C6+fYnwH30sjZCr9LWvfF/+2T1+Hcbv8A0e8Njv1qTUbKCINzq
         HSF6Gtm+NB9SYwQvwvylTFCRutBPDnymW8jfB6crer801ZE0P2ZYL/rzPBBKx7qzkkn6
         BtPaHPPcP08j47xqyLzsYQRzCAMRwoxgabzI0feaW67+HorioE8BA09fvfSwa9E8bJQ0
         BgEKkUCiiFDWh7e1mCf2YFW6u9H+1mSiZRLTe9QTjtDIRqiw0SU+e8sFSYRIX0+TIaNS
         Qime1gtKbiV6657P/Efl2/kuQ1dLTN1DGfRykQN1rdp/K6KLELul7Su5nEHA9IM4YrbA
         f1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jqf0UZ2rjG7tIDo1sszvcXpQS/cRo9IkXEQDkXfZNPs=;
        b=U9MUUklC7ahiKDj5UcutJHxvoYFjOPiTu+iFJT/GTKM5JZFbLAF7FPv4Cn72tz9FuW
         6GVtWNtPntVQsDIRXJibG0sEuKr9E0em5BhZnOTCymLUutit0Gl+5pCRhs0ATnPdDad2
         lgt4CCgnGuxfTYY1cTXvHHzfRPZROWf1abIF4pLm4GOdSo4WsTPP+Whx1KpRRueq1ygr
         Phz0+9g+vmieqBCLHzK5erIK16OmRGuAjLy0jHZJQ4/QKxwNBCj3XW+9gDQ/12DCF+nl
         9HJC6kxs6L+ZI7CnUqTIdF5Wq6ViDO8T3w+PyUDcJwPDbfj/pL9kPVoLHTSstMt+/oEO
         oBfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 120/140] x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
Date: Tue, 13 Mar 2018 16:25:23 +0100
Message-Id: <20180313152506.254661547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837002793614983?=
X-GMAIL-MSGID: =?utf-8?q?1594837626172424908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 700b7c5409c3e9da279fbea78cf28a78fbc176cd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/refcount.h |    4 ++--
 arch/x86/include/asm/rmwcc.h    |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

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
