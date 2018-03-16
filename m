Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELslJUdElqznTe3sncPDjBqbTjC00EC9WXamMAeeypf1BR3XDrQ+p2E4zpycHJldMuN2uNyw
ARC-Seal: i=1; a=rsa-sha256; t=1521214294; cv=none;
        d=google.com; s=arc-20160816;
        b=URZ4Lz71Yo6wP6AiJVbWb10xMVBm+zAYcIECoIzGHDnZNz5p+sg3EQkChh1STvBil9
         lbt3Bx4Xam1UGf9S8HkOgG/uU8QDHImse5T7pSvILFkVjWq3Rxt7T9OrLOIbpV9Le0os
         7/k6rdAG55+N7yUh6UI20FrxIDCZv9PzpYTK9C6g/Y0JWe1wuF/WwMO085kJQa+6rNpN
         x3hrz1+INg4g0a6peoEQlFl7H5dOHMIa3EcSWVGdgs43DJ+h1bEQmaB7U9EU4k4g+sc4
         meIhwfL/co0Vvui8w8Lw6VOVuHpa6nhIJufO8aj+mUtVxodjghqt6MiFFDugGzZlgY4R
         YiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1GFXUn+yaZ/Ttlk2banZJy8O8hV+f6wU5zJBhbl6kIc=;
        b=RaJAC8Le+kNWIin0KLa5VGelPvEycr9UFME3yN7nDpi+KcJFXDKMaVsfy1XLFrCBck
         EvLMQqS5SlZG5S0IFhlh0aRqABTCd4/8ff5dFhPifTMgxyNZaWwj8+YgH+BloFG2bvN8
         vqHmeG0qNXJcecHgNVvbH+gV6x3B3IR+WRcfr12gxT1zuLJAPeUfw49ISZNX6zd7hKv2
         QEBSJRdaEeabNwAvGCkBY/bs/SZrE6FSY45E9l8r023fMeC6/FaApTO2/59UCDaf0dHs
         6Cch1YX2y6CHVTHijC9dv0iDzpk/nRKqE6ylj2S9l7awRKoTyfz79rcOm5l1yTc6JDpn
         5qQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.9 42/86] x86/retpoline: Support retpoline builds with Clang
Date: Fri, 16 Mar 2018 16:23:05 +0100
Message-Id: <20180316152320.293252344@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108799998637439?=
X-GMAIL-MSGID: =?utf-8?q?1595108799998637439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -184,7 +184,10 @@ KBUILD_AFLAGS += $(mflags-y)
 
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
@@ -15,3 +15,8 @@
  * with any version that can compile the kernel
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
+
+/* Clang doesn't have a way to turn it off per-function, yet. */
+#ifdef __noretpoline
+#undef __noretpoline
+#endif
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -88,6 +88,10 @@
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
@@ -5,10 +5,10 @@
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
@@ -46,7 +46,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold notrace __latent_entropy __noretpoline
+#define __init		__section(.init.text) __cold notrace __latent_entropy __noinitretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
