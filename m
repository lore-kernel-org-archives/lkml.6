Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKpwA7QMSm9+sGtE7uXFLZce8lxHaEUkPT6KaDwWIg7bao0p8FkuZIVRPKJ5J/BxXxrOdp
ARC-Seal: i=1; a=rsa-sha256; t=1520955108; cv=none;
        d=google.com; s=arc-20160816;
        b=HHXOLm/FN0M4drr3gpO2i6yjrasMMp4lnS2RvxvvWxS4zgK+Qk2yGyKDsYk6kl+JC5
         hmBCvZvNYgVmqBWSQsD4dFrLLZrW19B1r2zIvYbGcPy/ajozVT6k9bZWy8fd4eIA0QXs
         4D6fRpLbGadBSgflgR/tfotg56lJ+3kAY8oxvpD1zCoQFuxZacCcsdMsZBnkgaZTICMO
         79C4igc3nSCSq0zJOCEWiYOIs5EEXct25C5/dhGxwMHIQHrAqYkgesEZIdNy4COgqAyV
         5p5ZCMC9GTjgi+Fp9sxTx6DpLI3iUx6WIfGwmjYXGXLZ4vQG6t2VUI3sQeBcJSkfFJye
         0u/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jCA/zebqQAE58sMLIAFHP525SFBFZZpsfzuQTtIZ+AQ=;
        b=hUOE9QVRRyRSecEZfEhdBvb03qow/5BHDrz6Z/SkplXeyhHqTfiq4ZBPaEnGoTlAKu
         +7R1ARHLvMoBv1hAcOJbdsGk0OuY7uawedwNWPl6E6wb23il4L5ki8HhIJ3XhODjriX8
         6BsYBZUYYeKX/B4Tb1/WiQFb97EWlW4BjP7zAcXz1+OgsaK4Nas0nGoZFe60hPBSsnn9
         4KbKaVzxsnEQTxuZ11Xq74QOkBdIyOhHF+CEJAcFy45gSzrndwyImEkSAodaMiRDkWwA
         jIco0mEJAtB+WK12rVE67K/1fnhiEFOKOXzhnwRcDX6GCifTFBLFAt15GvWVKIwcDbhz
         R+dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	arjan.van.de.ven@intel.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 091/146] x86/retpoline: Support retpoline builds with Clang
Date: Tue, 13 Mar 2018 16:24:18 +0100
Message-Id: <20180313152327.711568974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837024182823103?=
X-GMAIL-MSGID: =?utf-8?q?1594837024182823103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 87358710c1fb4f1bf96bbe2349975ff9953fc9b2 upstream.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/1519037457-7643-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Makefile              |    5 ++++-
 include/linux/compiler-clang.h |    5 +++++
 include/linux/compiler-gcc.h   |    4 ++++
 include/linux/init.h           |    8 ++++----
 4 files changed, 17 insertions(+), 5 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,7 +232,10 @@ KBUILD_CFLAGS += -fno-asynchronous-unwin
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+    RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+    RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+
+    RETPOLINE_CFLAGS += $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
     ifneq ($(RETPOLINE_CFLAGS),)
         KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
     endif
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -19,3 +19,8 @@
 
 #define randomized_struct_fields_start	struct {
 #define randomized_struct_fields_end	};
+
+/* Clang doesn't have a way to turn it off per-function, yet. */
+#ifdef __noretpoline
+#undef __noretpoline
+#endif
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -93,6 +93,10 @@
 #define __weak		__attribute__((weak))
 #define __alias(symbol)	__attribute__((alias(#symbol)))
 
+#ifdef RETPOLINE
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#endif
+
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -6,10 +6,10 @@
 #include <linux/types.h>
 
 /* Built-in __init functions needn't be compiled with retpoline */
-#if defined(RETPOLINE) && !defined(MODULE)
-#define __noretpoline __attribute__((indirect_branch("keep")))
+#if defined(__noretpoline) && !defined(MODULE)
+#define __noinitretpoline __noretpoline
 #else
-#define __noretpoline
+#define __noinitretpoline
 #endif
 
 /* These macros are used to mark some functions or 
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold  __latent_entropy __noretpoline
+#define __init		__section(.init.text) __cold  __latent_entropy __noinitretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
