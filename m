Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbeAaQdW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:33:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752811AbeAaQdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:33:21 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86/vdso: Remove retpoline flags
Date: Wed, 31 Jan 2018 17:33:12 +0100
Message-Id: <20180131163312.7144-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

So this does not fix an existing problem but a hypothetical one. The
below fires on an old Frankenstein distro kernel and I'm sending it
only because it is obviously The Right Thing(tm). And in case we change
things in the vdso in the future and thus manage to generate an indirect
call for whatever reason...

So on those older vdsos, the compiler can generate indirect calls to the
retpoline thunks, which manifests itself as:

  /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld: arch/x86/vdso/vclock_gettime.o: \
	  relocation R_X86_64_PC32 against undefined symbol `__x86_indirect_thunk_rax' can not be used when \
	  making a shared object; recompile with -fPIC
  /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld: final link failed: Bad value
  collect2: error: ld returned 1 exit status
  nm: 'arch/x86/vdso/vdso.so.dbg': No such file
  objcopy: 'arch/x86/vdso/vdso.so.dbg': No such file
  make[2]: *** [arch/x86/vdso/vdso.so] Error 1
  make[1]: *** [arch/x86/vdso] Error 2
  make[1]: *** Waiting for unfinished jobs....

However, since the vdso is not part of the kernel, it cannot reference
kernel symbols so we better not build with with retpoline CFLAGS either.

Thus, export RETPOLINE_CFLAGS to the lower level Makefiles so that they
can be filtered out in vdso's Makefile.

Suggested-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/Makefile            | 6 ++++--
 arch/x86/entry/vdso/Makefile | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fad55160dcb9..fe7adbc6a380 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,9 +232,11 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+    RETPOLINE_CFLAGS := $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
     ifneq ($(RETPOLINE_CFLAGS),)
-        KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+        RETPOLINE_CFLAGS += -DRETPOLINE
+	KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
+	export RETPOLINE_CFLAGS
     endif
 endif
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 1943aebadede..991ae9af5a00 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -30,6 +30,11 @@ vdso_img-$(VDSO32-y)		+= 32
 
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
+
+ifdef CONFIG_RETPOLINE
+	KBUILD_CFLAGS := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS))
+endif
+
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
-- 
2.13.0
