Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbeCSJDC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:03:02 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:51364 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeCSJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:02:58 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2J91Vk9014340
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 5/5] kbuild: move modname and modname-multi close to modname_flags
Date: Mon, 19 Mar 2018 18:01:27 +0900
Message-Id: <1521450087-27291-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a cosmetic change to put related code close together.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---

Changes in v2: None

 scripts/Makefile.build |  2 --
 scripts/Makefile.lib   | 14 ++++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f5858f6..93d05e3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -131,8 +131,6 @@ $(real-objs-m:.o=.lst): quiet_modtag := [M]
 
 $(obj-m)              : quiet_modtag := [M]
 
-modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 537629f..33af8d4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -77,6 +77,14 @@ multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 
+# Finds the multi-part object the current object will be linked into.
+# If the object belongs to two or more multi-part objects, all of them are
+# concatenated with a colon separator.
+modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
+		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$(m:.o=)))))
+
+modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
+
 # These flags are needed for modversions and compiling, so we define them here
 # $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
@@ -162,12 +170,6 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
-# Finds the multi-part object the current object will be linked into
-# If the object belongs to two or more multi-part objects, all of them are
-# concatenated with a colon separator.
-modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
-		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$(m:.o=)))))
-
 # Useful for describing the dependency of composite objects
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
-- 
2.7.4
