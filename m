Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbeCSL2K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:28:10 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30416 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbeCSL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:27:24 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2JBQHQq023258
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/7] kbuild: link $(real-obj-y) instead of $(obj-y) into built-in.a
Date: Mon, 19 Mar 2018 20:26:08 +0900
Message-Id: <1521458773-14224-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Kbuild, Makefiles can add the same object to obj-y multiple
times.  So,

   obj-y += foo.o
   obj-y += foo.o

is fine.

However, this is not true when the same object is added multiple
times via composite objects.  For example,

   obj-y    += foo.o bar.o
   foo-objs := foo-bar-common.o foo-only.o
   bar-objs := foo-bar-common.o bar-only.o

causes build error because two instances of foo-bar-common.o are
linked into the vmlinux.

Makefiles tend to invent ugly work-around, for example
  - lib/zstd/Makefile
  - drivers/net/ethernet/cavium/liquidio/Makefile

The technique used in Kbuild to avoid the multiple definition error
is to use $(filter $(obj-y), $^).  Here, $^ lists the names of all
the prerequisites with duplicated names removed.

By replacing it with $(filter $(real-obj-y), $^) we can do likewise
for composite objects.  For built-in objects, we do not need to keep
the composite object structure.  We can simply expand them, and link
$(real-obj-y) to built-in.a.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 21 +++++++--------------
 scripts/Makefile.lib   |  7 +++----
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8c1287f..316cb95 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -73,10 +73,10 @@ endif
 
 ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
 lib-target := $(obj)/lib.a
-obj-y += $(obj)/lib-ksyms.o
+real-obj-y += $(obj)/lib-ksyms.o
 endif
 
-ifneq ($(strip $(obj-y) $(need-builtin)),)
+ifneq ($(strip $(real-obj-y) $(need-builtin)),)
 builtin-target := $(obj)/built-in.a
 endif
 
@@ -412,7 +412,7 @@ endif
 $(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
 
-targets += $(real-obj-y) $(real-obj-m) $(lib-y)
+targets += $(filter-out $(subdir-obj-y), $(real-obj-y)) $(real-obj-m) $(lib-y)
 targets += $(extra-y) $(MAKECMDGOALS) $(always)
 
 # Linker scripts preprocessor (.lds.S -> .lds)
@@ -455,12 +455,12 @@ cmd_make_empty_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
 quiet_cmd_link_o_target = AR      $@
 
 # If the list of objects to link is empty, just create an empty built-in.a
-cmd_link_o_target = $(if $(strip $(obj-y)),\
-		      $(cmd_make_builtin) $@ $(filter $(obj-y), $^) \
+cmd_link_o_target = $(if $(strip $(real-obj-y)),\
+		      $(cmd_make_builtin) $@ $(filter $(real-obj-y), $^) \
 		      $(cmd_secanalysis),\
 		      $(cmd_make_empty_builtin) $@)
 
-$(builtin-target): $(obj-y) FORCE
+$(builtin-target): $(real-obj-y) FORCE
 	$(call if_changed,link_o_target)
 
 targets += $(builtin-target)
@@ -534,23 +534,16 @@ $($(subst $(obj)/,,$(@:.o=-m)))), $^)
 
 cmd_link_multi-link = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
 
-quiet_cmd_link_multi-y = AR      $@
-cmd_link_multi-y = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(link_multi_deps)
-
 quiet_cmd_link_multi-m = LD [M]  $@
 cmd_link_multi-m = $(cmd_link_multi-link)
 
-$(multi-used-y): FORCE
-	$(call if_changed,link_multi-y)
-$(call multi_depend, $(multi-used-y), .o, -objs -y)
-
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
 	@{ echo $(@:.o=.ko); echo $(link_multi_deps); \
 	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
-targets += $(multi-used-y) $(multi-used-m)
+targets += $(multi-used-m)
 targets := $(filter-out $(PHONY), $(targets))
 
 # Descending
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 6dd68cb..99cd592 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -51,8 +51,9 @@ single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
 # tell kbuild to descend
 subdir-obj-y := $(filter %/built-in.a, $(obj-y))
 
-# Replace multi-part objects by their individual parts, look at local dir only
-real-obj-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
+# Replace multi-part objects by their individual parts,
+# including built-in.a from subdirectories
+real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
 real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
 
 # DTB
@@ -66,14 +67,12 @@ extra-y		:= $(addprefix $(obj)/,$(extra-y))
 always		:= $(addprefix $(obj)/,$(always))
 targets		:= $(addprefix $(obj)/,$(targets))
 modorder	:= $(addprefix $(obj)/,$(modorder))
-obj-y		:= $(addprefix $(obj)/,$(obj-y))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
 subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
 real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
 single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
-multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 
-- 
2.7.4
