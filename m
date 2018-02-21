Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225lK0hw3bdAwI0B3hQnjiRxHtujCDUiltX1qkoh9ZY+ZsFCxqm5nY+yukf2BE/MF/Q0n21z
ARC-Seal: i=1; a=rsa-sha256; t=1519218739; cv=none;
        d=google.com; s=arc-20160816;
        b=sLEdIOWwOZWnlFcQfeS2GyqAn47Cez8sFPOVv7NH+4ohO2Q5WNsuj1n2ET9P0Co7Jf
         zfQ3iiVIhtjIHdH3k91ikH+KX0dFlT4clVlmXPsqJfY6WcGc2hLDwQoUSM6VrKGrGIwV
         G5dzuCuEvpM3XKWXKOtMincUUNfuFHGz0RMJmYXiCwXJzaAP3/KDAk6kA+HO7aBLTTNh
         /YqmlBNarmir922r8Tthh4KLyD2/iu2R/9R9fV8P9dBG5CN3+O5EAKg7q2CyDJB//Frw
         lMJhxi3xyQaiXt6tf4w+e8OlFt9qizr8edOjIiOjmkLqFMRtk97SscxRbIQdeIg3l9hl
         9WqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=wUw5A7btHaQKnqwAEb2oqZf+BRaeU1H8PLfRuDkEAnc=;
        b=AGBas4NPy9bDZG/hG/o7sfgETI8l0zHs0+c8UYqvsh7CcNULLqGBE9G9SXi0iYn7bY
         8NEsD5s8NyS/CqlVv5oXX/gF3vJVKIw3d4TPUp+RMVWbcswX8L2Uzvj8uXvUE1c6zA9c
         OS0Jty93yIa6lG1ngtYWydF5yfAQQ/gtVS9kIYrKPDEQRY4LKWaPcwVfg8V1PUIWuQ6/
         C33hu2N7pK3rC3mgWAYGKH9Bgq6Uc/zqjFpDZRrgDzyCcP1gfak0EUYVW3ATuRcIM8y0
         m5RFzRVIAsVOAEreCKuRorM5Gmkt4USj5mSCCWY6f4jAwNgnqYIOpNGJn55QrKsHTUCJ
         I5aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ufgaqHxZ;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ufgaqHxZ;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 21 Feb 2018 14:12:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: hpa@zytor.com, luto@kernel.org, arjan@linux.intel.com,
	tglx@linutronix.de, dan.j.williams@intel.com,
	torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
	mingo@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] objtool, retpolines: Integrate objtool with
 retpoline support more closely
Message-ID: <20180221131207.GS25235@hirez.programming.kicks-ass.net>
References: <tip-b4879c9b99a43e6c580d563f292a569a016af2a4@git.kernel.org>
 <1519210754.6482.43.camel@infradead.org>
 <20180221125357.GJ25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221125357.GJ25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007031866628709?=
X-GMAIL-MSGID: =?utf-8?q?1593016309673732024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:53:57PM +0100, Peter Zijlstra wrote:
> That's because this crossed with the llvm cruft, right? I'll have a
> look.

Best I could come up with that seems to work is something like the
below. Ingo, can you backmerge or stuff on top as appropriate?

---
 Makefile               |  8 ++++----
 arch/x86/Makefile      | 10 +++-------
 scripts/Makefile.build |  2 +-
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index e1a155a50fdc..3aa0a115eafb 100644
--- a/Makefile
+++ b/Makefile
@@ -489,10 +489,10 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 endif
 
-ifneq ($(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register),)
-  CC_HAS_RETPOLINE := 1
-endif
-export CC_HAS_RETPOLINE
+RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+export RETPOLINE_CFLAGS
 
 ifeq ($(config-targets),1)
 # ===========================================================================
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index dbc7d0ed2eaa..498c1b812300 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,13 +232,9 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
-    RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
-
-    RETPOLINE_CFLAGS += $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
-    ifneq ($(RETPOLINE_CFLAGS),)
-        KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
-    endif
+ifneq ($(RETPOLINE_CFLAGS),)
+  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+endif
 endif
 
 archscripts: scripts_basic
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 07e5802e324b..4f2b25d43ec9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -267,7 +267,7 @@ else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
-ifdef CC_HAS_RETPOLINE
+ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
 endif
