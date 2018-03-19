Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeCSJCm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:02:42 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:50351 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932805AbeCSJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:02:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2J91Vk6014340
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 2/5] kbuild: define KBUILD_MODNAME even if multiple modules share objects
Date: Mon, 19 Mar 2018 18:01:24 +0900
Message-Id: <1521450087-27291-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, KBUILD_MODNAME is defined only when $(modname) contains
just one word.  If an object is shared among multiple modules,
undefined KBUILD_MODNAME could cause a build error.  For example,
if CONFIG_DYNAMIC_DEBUG is enabled, any call of printk() populates
.modname, then fails to build due to undefined KBUILD_MODNAME.

Take the following code as an example:

  obj-m += foo.o
  obj-m += bar.o
  foo-objs := foo-bar-common.o foo-main.o
  bar-objs := foo-bar-common.o bar-main.o

In this case, there is room for argument what to define for
KBUILD_MODNAME when foo-bar-common.o is being compiled.
"foo", "bar", or what else?

One idea is to define colon-separated modules that share the object,
in this case, "bar:foo" (modules are sorted alphabetically by
$(sort ...).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---

Changes in v2:
  - Remove comments that will be no longer true

 scripts/Makefile.lib | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4eedd6e..7feb960 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -87,13 +87,9 @@ subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 # These flags are needed for modversions and compiling, so we define them here
 # $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
-# Note: Files that end up in two or more modules are compiled without the
-#       KBUILD_MODNAME definition. The reason is that any made-up name would
-#       differ in different configs.
 name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
-modname_flags  = $(if $(filter 1,$(words $(modname))),\
-                 -DKBUILD_MODNAME=$(call name-fix,$(modname)))
+modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
 
 orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
                  $(ccflags-y) $(CFLAGS_$(basetarget).o)
@@ -174,8 +170,10 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -undef -D__DTS__
 
 # Finds the multi-part object the current object will be linked into
-modname-multi = $(sort $(foreach m,$(multi-used),\
-		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
+# If the object belongs to two or more multi-part objects, all of them are
+# concatenated with a colon separator.
+modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
+		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=)))))
 
 # Useful for describing the dependency of composite objects
 # Usage:
-- 
2.7.4
