Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933363AbeCSL22 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:28:28 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30215 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755400AbeCSL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:27:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2JBQHQp023258
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/7] kbuild: rename real-objs-y/m to real-obj-y/m
Date: Mon, 19 Mar 2018 20:26:07 +0900
Message-Id: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was refactoring Makefiles, I stupidly mistook 'real-obj-y' for
'real-objs-y' over and over again.  Finally, I decide to rename it to
'real-obj-y'.  This is consistent with 'obj-y', 'subdir-obj-y'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 24 ++++++++++++------------
 scripts/Makefile.lib   |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 93d05e3..8c1287f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -119,17 +119,17 @@ modkern_cflags =                                          \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
 quiet_modtag := $(empty)   $(empty)
 
-$(real-objs-m)        : part-of-module := y
-$(real-objs-m:.o=.i)  : part-of-module := y
-$(real-objs-m:.o=.s)  : part-of-module := y
-$(real-objs-m:.o=.lst): part-of-module := y
+$(real-obj-m)        : part-of-module := y
+$(real-obj-m:.o=.i)  : part-of-module := y
+$(real-obj-m:.o=.s)  : part-of-module := y
+$(real-obj-m:.o=.lst): part-of-module := y
 
-$(real-objs-m)        : quiet_modtag := [M]
-$(real-objs-m:.o=.i)  : quiet_modtag := [M]
-$(real-objs-m:.o=.s)  : quiet_modtag := [M]
-$(real-objs-m:.o=.lst): quiet_modtag := [M]
+$(real-obj-m)        : quiet_modtag := [M]
+$(real-obj-m:.o=.i)  : quiet_modtag := [M]
+$(real-obj-m:.o=.s)  : quiet_modtag := [M]
+$(real-obj-m:.o=.lst): quiet_modtag := [M]
 
-$(obj-m)              : quiet_modtag := [M]
+$(obj-m)             : quiet_modtag := [M]
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
@@ -333,8 +333,8 @@ $(obj)/%.lst: $(src)/%.c FORCE
 
 modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
 
-$(real-objs-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
-$(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
+$(real-obj-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
+$(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 
 # .S file exports must have their C prototypes defined in asm/asm-prototypes.h
 # or a file that it includes, in order to get versioned symbols. We build a
@@ -412,7 +412,7 @@ endif
 $(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
 
-targets += $(real-objs-y) $(real-objs-m) $(lib-y)
+targets += $(real-obj-y) $(real-obj-m) $(lib-y)
 targets += $(extra-y) $(MAKECMDGOALS) $(always)
 
 # Linker scripts preprocessor (.lds.S -> .lds)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 33af8d4..6dd68cb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -52,8 +52,8 @@ single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
 subdir-obj-y := $(filter %/built-in.a, $(obj-y))
 
 # Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
-real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
+real-obj-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
+real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
 
 # DTB
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
@@ -70,8 +70,8 @@ obj-y		:= $(addprefix $(obj)/,$(obj-y))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
 subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
-real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
-real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
+real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
+real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
 single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
 multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
-- 
2.7.4
