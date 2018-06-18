Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BBF20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BBF20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeFRE4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:56:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60337 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754672AbeFRE4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:56:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92C6BAB32;
        Mon, 18 Jun 2018 04:56:07 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Date:   Mon, 18 Jun 2018 14:55:20 +1000
Subject: [PATCH 2/5] kbuild: treat a directory listed in a composite object
 as foo/mod.a
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <152929772044.17463.14049121557186779554.stgit@noble>
In-Reply-To: <152929708853.17463.17302660556961083137.stgit@noble>
References: <152929708853.17463.17302660556961083137.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a directory is not permitted in a composite
object.
This patch changes kbuild so that a directory it assumed
to mean the file "mod.a" in that directory.
The file cannot, yet, be created, so this does not yet
affect behaviour.

There are several parts to this.

1/ strip out all the directories from obj-m so that
  the directories that appear in real-obj-m must be
  parts of composite objects
2/ translate those directories from foo/ to foo/mod.a
  at the same time that obj-y directories becomes foo/built-in.a
3/ hold list of directories needed for modules in subdir-obj-m
  so that we can descend into them as required.
4/ We need a little "dance" in "Rule to link composite objects"
  where we strip the mod.a back off - so we can filter against
  the foo-{objs,y,m} macros, then add it back on for
  declaring dependencies.
  As part of this, multi_depend gains an extra argument
  being the name to append to any directory.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 scripts/Makefile.build |   15 ++++++++-------
 scripts/Makefile.lib   |   19 +++++++++++++++----
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 34d9e9ce97c2..928cd073a657 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -416,8 +416,9 @@ endif
 $(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
 
-targets += $(filter-out $(subdir-obj-y), $(real-obj-y)) $(real-obj-m) $(lib-y)
-targets += $(extra-y) $(MAKECMDGOALS) $(always)
+targets += $(filter-out $(subdir-obj-y), $(real-obj-y))
+targets += $(filter-out $(subdir-obj-m), $(real-obj-m))
+targets += $(lib-y) $(extra-y) $(MAKECMDGOALS) $(always)
 
 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
@@ -441,7 +442,7 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 # ---------------------------------------------------------------------------
 
 # To build objects in subdirs, we need to descend into the directories
-$(sort $(subdir-obj-y)): $(subdir-ym) ;
+$(sort $(subdir-obj-y) $(subdir-obj-m)): $(subdir-ym) ;
 
 #
 # Rule to compile a set of .o files into one .o file
@@ -521,16 +522,16 @@ link_multi_deps =                     \
 $(filter $(addprefix $(obj)/,         \
 $($(subst $(obj)/,,$(@:.o=-objs)))    \
 $($(subst $(obj)/,,$(@:.o=-y)))       \
-$($(subst $(obj)/,,$(@:.o=-m)))), $^)
+$($(subst $(obj)/,,$(@:.o=-m)))), $(patsubst %/mod.a,%/,$^))
 
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(patsubst %/, --whole-archive %/mod.a --no-whole-archive ,$(link_multi_deps)) $(cmd_secanalysis)
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(link_multi_deps); \
+	@{ echo $(@:.o=.ko); echo $(patsubst %/,%/mod.a,$(link_multi_deps)); \
 	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
-$(call multi_depend, $(multi-used-m), .o, -objs -y -m)
+$(call multi_depend, $(multi-used-m), .o, -objs -y -m,mod.a)
 
 targets += $(multi-used-m)
 targets := $(filter-out $(PHONY), $(targets))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ddfdd5cf47cd..6e7aa08324f0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -12,6 +12,13 @@ KBUILD_CFLAGS += $(subdir-ccflags-y)
 # Figure out what we need to build from the various variables
 # ===========================================================================
 
+# Directories in obj-m only cause that directory to be descended, which
+# is exactly what happens for directories in obj-y. So move all
+# directories from obj-m to obj-y.  Then we will know that any directory
+# in real-obj-m is a component of some other object.
+obj-y := $(obj-y) $(filter %/, $(obj-m))
+obj-m := $(filter-out %/, $(obj-m))
+
 # When an object is listed to be built compiled-in and modular,
 # only build the compiled-in version
 obj-m := $(filter-out $(obj-y),$(obj-m))
@@ -40,14 +47,14 @@ real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))
 # ---------------------------------------------------------------------------
 # o if we encounter foo/ in $(real-obj-y), replace it by foo/built-in.a
 #   and add the directory to the list of dirs to descend into: $(subdir-y)
-# o if we encounter foo/ in $(real-obj-m), remove it from $(real-obj-m)
+# o if we encounter foo/ in $(real-obj-m), replace it by foo/mod.a
 #   and add the directory to the list of dirs to descend into: $(subdir-m)
 __subdir-y	:= $(patsubst %/,%,$(filter %/, $(real-obj-y)))
 subdir-y	+= $(__subdir-y)
 __subdir-m	:= $(patsubst %/,%,$(filter %/, $(real-obj-m)))
 subdir-m	+= $(__subdir-m)
 real-obj-y	:= $(patsubst %/, %/built-in.a, $(real-obj-y))
-real-obj-m	:= $(filter-out %/, $(real-obj-m))
+real-obj-m	:= $(patsubst %/, %/mod.a, $(real-obj-m))
 
 # Subdirectories we need to descend into
 subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
@@ -55,6 +62,9 @@ subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
 # $(subdir-obj-y) is the list of objects in $(real-obj-y) which uses dir/ to
 # tell kbuild to descend
 subdir-obj-y := $(filter %/built-in.a, $(real-obj-y))
+# $(subdir-obj-m) is the list of objects in $(real-obj-m) which uses dir/ to
+# tell kbuild to descend
+subdir-obj-m := $(filter %/mod.a, $(real-obj-m))
 
 # DTB
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
@@ -70,6 +80,7 @@ modorder	:= $(addprefix $(obj)/,$(modorder))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
 subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
+subdir-obj-m	:= $(addprefix $(obj)/,$(subdir-obj-m))
 real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
 single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
@@ -172,11 +183,11 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 
 # Useful for describing the dependency of composite objects
 # Usage:
-#   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
+#   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add, object_in_directories)
 define multi_depend
 $(foreach m, $(notdir $1), \
 	$(eval $(obj)/$m: \
-	$(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
+	$(addprefix $(obj)/, $(patsubst %/,%/$4,$(foreach s, $3, $($(m:%$(strip $2)=%$(s))))))))
 endef
 
 # LEX


