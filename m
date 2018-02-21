Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519228534; cv=none;
        d=google.com; s=arc-20160816;
        b=Q617cZN70gsEM8YQ36NnLUTTyMr2xMfxSJdjD/n6/t114EtM/oWpyJMwSHeeNtsQII
         3yROxuLmFCWNMH048G5HEG8qNo004OgP3DU8FoKjaNPQTiTekgKk5zV7ZGJaXjqD55DQ
         1cHGLuB25vx3M2ojGDQlAwDlg0Fps+QaU2m/1KnWWMROts9Loe3q11UeJYeYHT49KnKB
         UoGjtMmxklGRHVvD96BPkZRlQpkb0PjRDXJxhyqvcce4eL/ctg5ZZVErfqOH63+fU7z0
         5lrQy9NaKal2aaCExcBRwDH5tqFYJlF6Y+Jd3Nnh+/+cO68oQdSOJ0RJjsmZuK7yucIz
         HvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=nEe2aQT23KUNNRa6ClPHxhjtUOOqrVx2wnMBtNfKgrs=;
        b=z08aLT22DT3YsnqURsLXZGIAJLI+m08tD+rSySvFu3irMfValqI3C0cLKst7jJmMKr
         l+MdWoG1fgYvYBWxBIcC4UDZublv69hSGmdwH2Rk35eFZaRi53uu90nMPNqNW5XIi7l4
         +ybjhF92yCUgp4sUp7FMdmDeCgqKXw6v5ZVVR58vS2quxtwMEK7JNvk5PlFB55BLHxTF
         SBJGmGclexw8U2EuDp5Lou3I3Q150EHRX8qmfKWD82irE5wJstQLRl731m/AVLl0EGBK
         cbQVhETvsuT5+L4pYwoLCal7f9e0DCFnSRmUMI2u/2DZ5an8WWTvpHHjXiTdEiadag8R
         lUgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AhSAHVmS;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AhSAHVmS;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x225zuNA8g/qDD1C01qbMNgCCaB4rc/epOwiYsuE98qxjD9tz9M12voMogcfpYlpsdc2J8gmZlA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 21 Feb 2018 16:55:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, hpa@zytor.com, luto@kernel.org,
	arjan@linux.intel.com, tglx@linutronix.de, dan.j.williams@intel.com,
	torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
	bp@alien8.de, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org
Subject: [PATCH v2] objtool, retpolines: Integrate objtool with retpoline
 support more closely
Message-ID: <20180221155530.ddiojpjbx7ujpxvm@gmail.com>
References: <tip-b4879c9b99a43e6c580d563f292a569a016af2a4@git.kernel.org>
 <1519210754.6482.43.camel@infradead.org>
 <20180221125357.GJ25201@hirez.programming.kicks-ass.net>
 <20180221131207.GS25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221131207.GS25235@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007031866628709?=
X-GMAIL-MSGID: =?utf-8?q?1593026580160509468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 21, 2018 at 01:53:57PM +0100, Peter Zijlstra wrote:
> > That's because this crossed with the llvm cruft, right? I'll have a
> > look.
> 
> Best I could come up with that seems to work is something like the
> below. Ingo, can you backmerge or stuff on top as appropriate?

I backmerged/reordered and made the v2 patch below out of it.

Does this look good to everyone?

Thanks,

	Ingo

=======================>
>From d5028ba8ee5a18c9d0bb926d883c28b370f89009 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 6 Feb 2018 09:46:13 +0100
Subject: [PATCH] objtool, retpolines: Integrate objtool with retpoline support more closely

Disable retpoline validation in objtool if your compiler sucks, and otherwise
select the validation stuff for CONFIG_RETPOLINE=y (most builds would already
have it set due to ORC).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Makefile               |  5 +++++
 arch/x86/Kconfig       |  1 +
 arch/x86/Makefile      | 10 +++-------
 scripts/Makefile.build |  2 ++
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 79ad2bfa24b6..3dfce4d2f25d 100644
--- a/Makefile
+++ b/Makefile
@@ -489,6 +489,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 endif
 
+RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+export RETPOLINE_CFLAGS
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 63bf349b2b24..c1aed6c0e413 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -436,6 +436,7 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
+	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
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
index ce0fc4dd68c6..4f2b25d43ec9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -267,8 +267,10 @@ else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
+endif
 
 
 ifdef CONFIG_MODVERSIONS
