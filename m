Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbeCHBGi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:06:38 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:60400 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeCHBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:05:56 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w28156G7018694
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kbuild: define KBUILD_MODNAME even if multiple modules share objects
Date: Thu,  8 Mar 2018 10:05:00 +0900
Message-Id: <1520471103-10089-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
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
---

 scripts/Makefile.lib | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a7e315f..a1fbd6a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -92,8 +92,7 @@ subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 #       differ in different configs.
 name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
-modname_flags  = $(if $(filter 1,$(words $(modname))),\
-                 -DKBUILD_MODNAME=$(call name-fix,$(modname)))
+modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
 
 orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
                  $(ccflags-y) $(CFLAGS_$(basetarget).o)
@@ -174,8 +173,10 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
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
