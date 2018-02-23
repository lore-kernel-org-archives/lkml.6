Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLe9jFOHA7BNb6D5WUsMZ9Yt8W3e79CCeV6urq34A+pQJFmTq1NxM6Oh1yqfhZCJ75SfRI
ARC-Seal: i=1; a=rsa-sha256; t=1519411625; cv=none;
        d=google.com; s=arc-20160816;
        b=NLTzDNTCzZ7XsTqCtX5DDa/0btY1QUPT3plTXBGkPt0pigFGNnZudSAgP7wkfaqXDu
         bAWGMZA2ibaeN3P51kYBmGk6j+PLVpbu0tcX6x/iDhZLuveKpl4lnvDZrz5pZDP1LQrX
         YhH8qrw7lao8IfhkV0x6yS+tTd1UhCo/7iuHSnrS8l/3a8NK46zqQwoq3KzW8dmPO4Ll
         hhyD9bVbCCNkZ8O3/ZeL5t3iR6OKpuPBcyZWdCplUtPk6dM+9mZ+VLVZxHmRa6dIHBUa
         9QvGkYbC7Ond1i4tqYvlIkMQ4o+sgl7KZEY+HE1tVk0JFRtNd3GccomH/VfAPchONk3F
         0p5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QK7U/f546F2M7DkXC1vqDHh2jCCcywkmwj1rFcrlDJI=;
        b=SiBTmA7Ko2NzF0wDZ4595F6lQmDBvbAtRdrWPLsBpIm4VopfIq3US5v+k+HrZhSdo2
         o2f2Qx51+WmTbLc3DWv/bY+itT5Swg1Ds1NY3FvrUAxRdisVvboaQ4F/LgXMRpXGsBls
         o1RSuvJ946MIjhI8UcQhRno6SWUEdUROGicWx1mf9rb+cvQQlPT1diGBj373Men6ZO3j
         WVYeox52IXxFrOLI3npKknsZQrpSPFq10vUeXYdxwlZ9FN0rN6FjVQyTyXfP+NjTHIGN
         lbKf/NneYgd0VkvG6gUQ0AtDhUKhe3m3XWcftIs+l5+82f6V3m1KxythXicI8Y3e04qH
         eqJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bill Metzenthen <billm@melbpc.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 107/145] x86/fpu/math-emu: Fix possible uninitialized variable use
Date: Fri, 23 Feb 2018 19:26:53 +0100
Message-Id: <20180223170738.620538719@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217868412742928?=
X-GMAIL-MSGID: =?utf-8?q?1593218565073086658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 75e2f0a6b16141cb347f442033ec907380d4d66e upstream.

When building the kernel with "make EXTRA_CFLAGS=...", this overrides
the "PARANOID" preprocessor macro defined in arch/x86/math-emu/Makefile,
and we run into a build warning:

  arch/x86/math-emu/reg_compare.c: In function ‘compare_i_st_st’:
  arch/x86/math-emu/reg_compare.c:254:6: error: ‘f’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

This fixes the implementation to work correctly even without the PARANOID
flag, and also fixes the Makefile to not use the EXTRA_CFLAGS variable
but instead use the ccflags-y variable in the Makefile that is meant
for this purpose.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170719125310.2487451-3-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/math-emu/Makefile      |    4 ++--
 arch/x86/math-emu/reg_compare.c |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/math-emu/Makefile
+++ b/arch/x86/math-emu/Makefile
@@ -5,8 +5,8 @@
 #DEBUG	= -DDEBUGGING
 DEBUG	=
 PARANOID = -DPARANOID
-EXTRA_CFLAGS	:= $(PARANOID) $(DEBUG) -fno-builtin $(MATH_EMULATION)
-EXTRA_AFLAGS	:= $(PARANOID)
+ccflags-y += $(PARANOID) $(DEBUG) -fno-builtin $(MATH_EMULATION)
+asflags-y += $(PARANOID)
 
 # From 'C' language sources:
 C_OBJS =fpu_entry.o errors.o \
--- a/arch/x86/math-emu/reg_compare.c
+++ b/arch/x86/math-emu/reg_compare.c
@@ -168,7 +168,7 @@ static int compare(FPU_REG const *b, int
 /* This function requires that st(0) is not empty */
 int FPU_compare_st_data(FPU_REG const *loaded_data, u_char loaded_tag)
 {
-	int f = 0, c;
+	int f, c;
 
 	c = compare(loaded_data, loaded_tag);
 
@@ -189,12 +189,12 @@ int FPU_compare_st_data(FPU_REG const *l
 		case COMP_No_Comp:
 			f = SW_C3 | SW_C2 | SW_C0;
 			break;
-#ifdef PARANOID
 		default:
+#ifdef PARANOID
 			EXCEPTION(EX_INTERNAL | 0x121);
+#endif /* PARANOID */
 			f = SW_C3 | SW_C2 | SW_C0;
 			break;
-#endif /* PARANOID */
 		}
 	setcc(f);
 	if (c & COMP_Denormal) {
@@ -205,7 +205,7 @@ int FPU_compare_st_data(FPU_REG const *l
 
 static int compare_st_st(int nr)
 {
-	int f = 0, c;
+	int f, c;
 	FPU_REG *st_ptr;
 
 	if (!NOT_EMPTY(0) || !NOT_EMPTY(nr)) {
@@ -235,12 +235,12 @@ static int compare_st_st(int nr)
 		case COMP_No_Comp:
 			f = SW_C3 | SW_C2 | SW_C0;
 			break;
-#ifdef PARANOID
 		default:
+#ifdef PARANOID
 			EXCEPTION(EX_INTERNAL | 0x122);
+#endif /* PARANOID */
 			f = SW_C3 | SW_C2 | SW_C0;
 			break;
-#endif /* PARANOID */
 		}
 	setcc(f);
 	if (c & COMP_Denormal) {
@@ -283,12 +283,12 @@ static int compare_i_st_st(int nr)
 	case COMP_No_Comp:
 		f = X86_EFLAGS_ZF | X86_EFLAGS_PF | X86_EFLAGS_CF;
 		break;
-#ifdef PARANOID
 	default:
+#ifdef PARANOID
 		EXCEPTION(EX_INTERNAL | 0x122);
+#endif /* PARANOID */
 		f = 0;
 		break;
-#endif /* PARANOID */
 	}
 	FPU_EFLAGS = (FPU_EFLAGS & ~(X86_EFLAGS_ZF | X86_EFLAGS_PF | X86_EFLAGS_CF)) | f;
 	if (c & COMP_Denormal) {
