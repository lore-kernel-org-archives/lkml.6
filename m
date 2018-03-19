Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932880AbeCSJCi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:02:38 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:50352 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932808AbeCSJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:02:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2J91Vk8014340
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 4/5] kbuild: simplify modname calculation
Date: Mon, 19 Mar 2018 18:01:26 +0900
Message-Id: <1521450087-27291-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modname can be calculated much more simply.  If modname-multi is
empty, it is a single-used object.  So, modname = $(basetarget).
Otherwise, modname = $(modname-multi).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---

Changes in v2: None

 scripts/Makefile.build | 12 +-----------
 scripts/Makefile.lib   |  7 -------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7cd2f4a..f5858f6 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -131,17 +131,7 @@ $(real-objs-m:.o=.lst): quiet_modtag := [M]
 
 $(obj-m)              : quiet_modtag := [M]
 
-# Default for not multi-part modules
-modname = $(basetarget)
-
-$(multi-objs-m)         : modname = $(modname-multi)
-$(multi-objs-m:.o=.i)   : modname = $(modname-multi)
-$(multi-objs-m:.o=.s)   : modname = $(modname-multi)
-$(multi-objs-m:.o=.lst) : modname = $(modname-multi)
-$(multi-objs-y)         : modname = $(modname-multi)
-$(multi-objs-y:.o=.i)   : modname = $(modname-multi)
-$(multi-objs-y:.o=.s)   : modname = $(modname-multi)
-$(multi-objs-y:.o=.lst) : modname = $(modname-multi)
+modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 35c868f..537629f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -47,11 +47,6 @@ multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m
 multi-used   := $(multi-used-y) $(multi-used-m)
 single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
 
-# Build list of the parts of our composite objects, our composite
-# objects depend on those (obviously)
-multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)) $($(m:.o=-y)))
-multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)))
-
 # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
 # tell kbuild to descend
 subdir-obj-y := $(filter %/built-in.a, $(obj-y))
@@ -80,8 +75,6 @@ real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
 single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
 multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
-multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
-multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 
 # These flags are needed for modversions and compiling, so we define them here
-- 
2.7.4
