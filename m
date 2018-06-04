Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeFDPHa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:07:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40592 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeFDPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:07:29 -0400
X-Google-Smtp-Source: ADUXVKIRHX5hWfcSFPuVKbgk9JjAVHY2FkXWOSSGx15mAyRRRqGZ678M0j56JERrvnABFrqo/3/uDA==
Date: Mon, 4 Jun 2018 17:07:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build changes for v4.18
Message-ID: <20180604150724.GA4588@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: 1742ed2088ccc4ade3abd8fe888742dd0f1343f8 x86/build/vdso: Put generated linker scripts to $(obj)/

A handful of build system (Makefile, linker script) cleanups by Masahiro Yamada.

 Thanks,

	Ingo

------------------>
Masahiro Yamada (4):
      x86/build: Remove no-op macro VMLINUX_SYMBOL()
      x86/build/vdso: Remove unused $(vobjs-nox32) in Makefile
      x86/build/vdso: Remove unnecessary export in Makefile
      x86/build/vdso: Put generated linker scripts to $(obj)/


 arch/x86/entry/vdso/Makefile  | 11 ++++-------
 arch/x86/kernel/vmlinux.lds.S |  4 ++--
 arch/x86/um/vdso/Makefile     |  4 ++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index d998a487c9b1..261802b1cc50 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -44,14 +44,14 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 			-Wl,--no-undefined \
 			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
 			$(DISABLE_LTO)
 
-$(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
@@ -100,11 +100,8 @@ VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
 			   -Wl,-z,max-page-size=4096 \
 			   -Wl,-z,common-page-size=4096
 
-# 64-bit objects to re-brand as x32
-vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
-
 # x32-rebranded versions
-vobjx32s-y := $(vobjs64-for-x32:.o=-x32.o)
+vobjx32s-y := $(vobjs-y:.o=-x32.o)
 
 # same thing, but in the output directory
 vobjx32s := $(foreach F,$(vobjx32s-y),$(obj)/$F)
@@ -122,7 +119,7 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg
 	$(call if_changed,objcopy)
 
-$(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
+$(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 795f3a80e576..5e1458f609a1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -117,11 +117,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
+		__entry_trampoline_start = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
+		__entry_trampoline_end = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 10003359e633..b2d6967262b2 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -23,14 +23,14 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
        -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
 
 $(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
 
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
