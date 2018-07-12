Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471A0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DBA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZZTYVEI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DBA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeGLIL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:11:57 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56367 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeGLILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:46 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQl012716;
        Thu, 12 Jul 2018 17:01:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQl012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382507;
        bh=473LzbsZMJ8t99qQtYBmyWMkY2Oh8AIrVtmsosDlUbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZTYVEI2832026xvPI1+p4r5eC8s1d+Ljru38EddRgsEttfNJ7ar20BRdEXmA/obR
         P/+IS+gmGl9SrsQ9OUbHbF09H1X3C5KztkeWx6txRWQ58I1z3Kdo6LVsLy/MIGZuqn
         28bdqbVSJA4aqqAchyBus3Nf0SbXGE36IHz/UOwQHDEIMqZi91f2/8txvpNnIJjwF+
         oPMCbH1p5beSIfYxWvYIjBB+P/DCNsYOy/QFzT74Q9Mphgam8u2RYwRqz7iIXn5/0i
         nC1ZKfC87JCE6GrHUUdJyP1BnMOhZM9svkLeG5nFIaT7z0K7XWWWJpg1yQNxezqNKU
         dfZqYvfpSZRvA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 6/6] kbuild: rename LDFLAGS to KBUILD_LDFLAGS
Date:   Thu, 12 Jul 2018 17:01:36 +0900
Message-Id: <1531382496-3719-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0f97e06a43c ("kbuild: enable 'make CFLAGS=...' to add
additional options to CC") renamed CFLAGS to KBUILD_CFLAGS.

Commit 222d394d30e7 ("kbuild: enable 'make AFLAGS=...' to add
additional options to AS") renamed AFLAGS to KBUILD_AFLAGS.

Commit 06c5040cdb13 ("kbuild: enable 'make CPPFLAGS=...' to add
additional options to CPP") renamed CPPFLAGS to KBUILD_CPPFLAGS.

For some reason, LDFLAGS was not renamed.

Using a well-known variable like LDFLAGS may result in accidental
override of the variable.

Kbuild generally uses KBUILD_ prefixed variables for the internally
appended options, so here is one more conversion to sanitize the
naming convention.

I did not touch Makefiles under tools/ since the tools build system
is a different world.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                           | 6 +++---
 arch/arc/Makefile                  | 2 +-
 arch/arm/Makefile                  | 4 ++--
 arch/arm64/Makefile                | 4 ++--
 arch/c6x/Makefile                  | 3 +--
 arch/h8300/Makefile                | 2 +-
 arch/hexagon/Makefile              | 4 +---
 arch/m68k/Makefile                 | 2 +-
 arch/microblaze/Makefile           | 4 ++--
 arch/mips/Makefile                 | 2 +-
 arch/mips/boot/compressed/Makefile | 2 +-
 arch/mips/lasat/image/Makefile     | 2 +-
 arch/nds32/Makefile                | 4 ++--
 arch/powerpc/Makefile              | 6 +++---
 arch/riscv/Makefile                | 4 ++--
 arch/s390/Makefile                 | 2 +-
 arch/sh/Makefile                   | 4 ++--
 arch/sparc/Makefile                | 4 ++--
 arch/um/Makefile                   | 2 +-
 arch/x86/Makefile                  | 4 ++--
 arch/x86/Makefile.um               | 2 +-
 arch/x86/boot/compressed/Makefile  | 6 +++---
 arch/xtensa/Makefile               | 2 +-
 arch/xtensa/boot/boot-elf/Makefile | 2 +-
 scripts/Kbuild.include             | 4 ++--
 scripts/Makefile.build             | 4 ++--
 scripts/Makefile.lib               | 2 +-
 scripts/Makefile.modpost           | 2 +-
 28 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/Makefile b/Makefile
index 925c55f..9eaa9b7 100644
--- a/Makefile
+++ b/Makefile
@@ -426,7 +426,7 @@ KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
-LDFLAGS :=
+KBUILD_LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
@@ -434,7 +434,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
-export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
+export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
 export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
@@ -997,7 +997,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
 cmd_link-vmlinux =                                                 \
-	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
+	$(CONFIG_SHELL) $< $(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_vmlinux) ;    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index d37f49d..5aecb8b 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -95,7 +95,7 @@ KBUILD_CFLAGS_MODULE	+= -mlong-calls -mno-millicode
 # Finally dump eveything into kernel build system
 KBUILD_CFLAGS	+= $(cflags-y)
 KBUILD_AFLAGS	+= $(KBUILD_CFLAGS)
-LDFLAGS		+= $(ldflags-y)
+KBUILD_LDFLAGS	+= $(ldflags-y)
 
 head-y		:= arch/arc/kernel/head.o
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e7d703d..360f80a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -43,12 +43,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
-LDFLAGS		+= -EB
+KBUILD_LDFLAGS	+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
-LDFLAGS		+= -EL
+KBUILD_LDFLAGS	+= -EL
 endif
 
 #
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7976d2d..ae064d1 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-LDFLAGS		+= -EB -maarch64elfb
+KBUILD_LDFLAGS	+= -EB -maarch64elfb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64elf
+KBUILD_LDFLAGS	+= -EL -maarch64elf
 UTS_MACHINE	:= aarch64
 endif
 
diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
index 6ab942e..3fe8a94 100644
--- a/arch/c6x/Makefile
+++ b/arch/c6x/Makefile
@@ -23,8 +23,7 @@ ifdef CONFIG_CPU_BIG_ENDIAN
 KBUILD_CFLAGS   += -mbig-endian
 KBUILD_AFLAGS   += -mbig-endian
 LINKFLAGS       += -mbig-endian
-KBUILD_LDFLAGS  += -mbig-endian
-LDFLAGS += -EB
+KBUILD_LDFLAGS  += -mbig-endian -EB
 CHECKFLAGS	+= -D_BIG_ENDIAN
 endif
 
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index e1c02ca..f9cbbb1 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -20,7 +20,7 @@ KBUILD_CFLAGS += -mint32 -fno-builtin
 KBUILD_CFLAGS += -D__linux__
 KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 KBUILD_AFLAGS += $(aflags-y)
-LDFLAGS += $(ldflags-y)
+KBUILD_LDFLAGS += $(ldflags-y)
 
 ifeq ($(CROSS_COMPILE),)
 CROSS_COMPILE := h8300-unknown-linux-
diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 2efaa18..4c5858b 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -22,9 +22,7 @@ ldflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
 
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_AFLAGS += $(aflags-y)
-
-#  no KBUILD_LDFLAGS?
-LDFLAGS += $(ldflags-y)
+KBUILD_LDFLAGS += $(ldflags-y)
 
 # Thread-info register will be r19.  This value is not configureable;
 # it is hard-coded in several files.
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index f0dd9fc..997c9f2 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -69,7 +69,7 @@ KBUILD_CFLAGS += -D__uClinux__
 KBUILD_AFLAGS += -D__uClinux__
 endif
 
-LDFLAGS := -m m68kelf
+KBUILD_LDFLAGS := -m m68kelf
 KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/m68k/kernel/module.lds
 
 ifdef CONFIG_SUN3
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 7333036..4f3ab57 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
 ifdef CONFIG_CPU_BIG_ENDIAN
 KBUILD_CFLAGS += -mbig-endian
 KBUILD_AFLAGS += -mbig-endian
-LDFLAGS += -EB
+KBUILD_LDFLAGS += -EB
 else
 KBUILD_CFLAGS += -mlittle-endian
 KBUILD_AFLAGS += -mlittle-endian
-LDFLAGS += -EL
+KBUILD_LDFLAGS += -EL
 endif
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e2122cc..0d1b5e6 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -303,7 +303,7 @@ endif
 # instead of .eh_frame so we don't discard them.
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
-LDFLAGS			+= -m $(ld-emul)
+KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index abe77ad..3c453a1 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -92,7 +92,7 @@ UIMAGE_LOADADDR = $(VMLINUZ_LOAD_ADDRESS)
 vmlinuzobjs-y += $(obj)/piggy.o
 
 quiet_cmd_zld = LD      $@
-      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@
+      cmd_zld = $(LD) $(KBUILD_LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@
 quiet_cmd_strip = STRIP	  $@
       cmd_strip = $(STRIP) -s $@
 vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index 9ab1326..78ce4cf 100644
--- a/arch/mips/lasat/image/Makefile
+++ b/arch/mips/lasat/image/Makefile
@@ -38,7 +38,7 @@ $(obj)/rom.bin: $(obj)/rom
 
 # Rule to make the bootloader
 $(obj)/rom: $(addprefix $(obj)/,$(OBJECTS))
-	$(LD) $(LDFLAGS) $(LDSCRIPT) -o $@ $^
+	$(LD) $(KBUILD_LDFLAGS) $(LDSCRIPT) -o $@ $^
 
 $(obj)/%.o: $(obj)/%.gz
 	$(LD) -r -o $@ -b binary $<
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 513bb2e..b1321c4 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -33,11 +33,11 @@ endif
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS   += $(call cc-option, -EL)
 KBUILD_AFLAGS   += $(call cc-option, -EL)
-LDFLAGS         += $(call cc-option, -EL)
+KBUILD_LDFLAGS  += $(call cc-option, -EL)
 else
 KBUILD_CFLAGS   += $(call cc-option, -EB)
 KBUILD_AFLAGS   += $(call cc-option, -EB)
-LDFLAGS         += $(call cc-option, -EB)
+KBUILD_LDFLAGS  += $(call cc-option, -EB)
 endif
 
 boot := arch/nds32/boot
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2ea575c..3d157fc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -76,14 +76,14 @@ endif
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 KBUILD_CFLAGS	+= -mlittle-endian
-LDFLAGS		+= -EL
+KBUILD_LDFLAGS	+= -EL
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
 else
 KBUILD_CFLAGS += $(call cc-option,-mbig-endian)
-LDFLAGS		+= -EB
+KBUILD_LDFLAGS	+= -EB
 LDEMULATION	:= ppc
 GNUTARGET	:= powerpc
 MULTIPLEWORD	:= -mmultiple
@@ -108,7 +108,7 @@ aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
 ifeq ($(HAS_BIARCH),y)
 KBUILD_CFLAGS	+= -m$(BITS)
 KBUILD_AFLAGS	+= -m$(BITS) -Wl,-a$(BITS)
-LDFLAGS		+= -m elf$(BITS)$(LDEMULATION)
+KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 2627e48..71b5741 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -26,7 +26,7 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 	KBUILD_CFLAGS += -mabi=lp64
 	KBUILD_AFLAGS += -mabi=lp64
 	KBUILD_MARCH = rv64im
-	LDFLAGS += -melf64lriscv
+	KBUILD_LDFLAGS += -melf64lriscv
 else
 	BITS := 32
 	UTS_MACHINE := riscv32
@@ -34,7 +34,7 @@ else
 	KBUILD_CFLAGS += -mabi=ilp32
 	KBUILD_AFLAGS += -mabi=ilp32
 	KBUILD_MARCH = rv32im
-	LDFLAGS += -melf32lriscv
+	KBUILD_LDFLAGS += -melf32lriscv
 endif
 
 KBUILD_CFLAGS += -Wall
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 68a6904..60120b6 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -11,7 +11,7 @@
 #
 
 LD_BFD		:= elf64-s390
-LDFLAGS		:= -m elf64_s390
+KBUILD_LDFLAGS	:= -m elf64_s390
 KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS	+= -m64
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 65300193..c521ade 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -122,11 +122,11 @@ endif
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 ld-bfd			:= elf32-$(UTS_MACHINE)-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64 --oformat $(ld-bfd)
-LDFLAGS			+= -EL
+KBUILD_LDFLAGS		+= -EL
 else
 ld-bfd			:= elf32-$(UTS_MACHINE)big-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64+4 --oformat $(ld-bfd)
-LDFLAGS			+= -EB
+KBUILD_LDFLAGS		+= -EB
 endif
 
 export ld-bfd BITS
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 966a13d..8ece494 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -21,7 +21,7 @@ ifeq ($(CONFIG_SPARC32),y)
 #
 
 CHECKFLAGS     += -D__sparc__
-LDFLAGS        := -m elf32_sparc
+KBUILD_LDFLAGS := -m elf32_sparc
 export BITS    := 32
 UTS_MACHINE    := sparc
 
@@ -40,7 +40,7 @@ else
 #
 
 CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__
-LDFLAGS       := -m elf64_sparc
+KBUILD_LDFLAGS := -m elf64_sparc
 export BITS   := 64
 UTS_MACHINE   := sparc64
 
diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8..6c4aed1 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -142,7 +142,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
+LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a08e828..9129a96 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -224,7 +224,7 @@ sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA2
 KBUILD_AFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr)
 KBUILD_CFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr)
 
-LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 
 #
 # The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
@@ -232,7 +232,7 @@ LDFLAGS := -m elf_$(UTS_MACHINE)
 # by the linker.
 #
 ifdef CONFIG_X86_64
-LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
+KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
 # Speed up the build
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 5296f8c..0d347ee 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -4,7 +4,7 @@ core-y += arch/x86/crypto/
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
-LDFLAGS			+= -m elf_i386
+KBUILD_LDFLAGS		+= -m elf_i386
 ELF_ARCH		:= i386
 ELF_FORMAT 		:= elf32-i386
 CHECKFLAGS	+= -D__i386__
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f89..e1dc356 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -42,16 +42,16 @@ KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
-LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
-LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
+KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
 else
 # To build 64-bit compressed kernel as PIE, we disable relocation
 # overflow check to avoid relocation overflow error with a new linker
 # command-line option, -z noreloc-overflow.
-LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
+KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
 LDFLAGS_vmlinux := -T
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 3a934b7..295c120 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -49,7 +49,7 @@ KBUILD_CFLAGS += $(call cc-option,-mno-serialize-volatile,)
 KBUILD_AFLAGS += -mlongcalls -mtext-section-literals
 
 ifneq ($(CONFIG_LD_NO_RELAX),)
-LDFLAGS := --no-relax
+KBUILD_LDFLAGS := --no-relax
 endif
 
 ifeq ($(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#"),1)
diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
index 5214719..12ae1e9 100644
--- a/arch/xtensa/boot/boot-elf/Makefile
+++ b/arch/xtensa/boot/boot-elf/Makefile
@@ -25,7 +25,7 @@ $(obj)/Image.o: vmlinux.bin $(OBJS)
 		$(OBJS) $@
 
 $(obj)/../Image.elf: $(obj)/Image.o $(obj)/boot.lds
-	$(Q)$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
+	$(Q)$(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_vmlinux) \
 		-T $(obj)/boot.lds \
 		--build-id=none \
 		-o $@ $(obj)/Image.o
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d6..feb918f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
-# Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
+# Usage: KBUILD_LDFLAGS += $(call ld-option, -X)
+ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e7889f4..42d61c1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -197,7 +197,7 @@ cmd_modversions_c =								\
 		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
 	else									\
@@ -404,7 +404,7 @@ cmd_modversions_S =								\
 		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
 	else									\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f56bb4b..193c551 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -162,7 +162,7 @@ a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__cpp_flags)
 
-ld_flags       = $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
+ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index df41744..fa00c61 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -120,7 +120,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 # Step 6), final link of the modules with optional arch pass after final link
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =                                                     \
-	$(LD) -r $(LDFLAGS)                                             \
+	$(LD) -r $(KBUILD_LDFLAGS)                                      \
                  $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
                  -o $@ $(filter-out FORCE,$^) ;                         \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
-- 
2.7.4

