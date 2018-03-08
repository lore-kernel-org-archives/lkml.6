Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755121AbeCHBGB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:06:01 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:60401 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755041AbeCHBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:05:56 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w28156G8018694
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
Subject: [PATCH 3/5] kbuild: fix modname for composite modules
Date: Thu,  8 Mar 2018 10:05:01 +0900
Message-Id: <1520471103-10089-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cao jin <caoj.fnst@cn.fujitsu.com>

Commit cf4f21938e13 ("kbuild: Allow to specify composite modules
with modname-m") added modname-m support, but missed to update the
corresponding multi-objs-m & modname-multi definition.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I rebased the previous version:
https://patchwork.kernel.org/patch/10055583/


 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a1fbd6a..9217d40 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -50,7 +50,7 @@ single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
 # Build list of the parts of our composite objects, our composite
 # objects depend on those (obviously)
 multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)) $($(m:.o=-y)))
-multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)))
+multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)))
 
 # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
 # tell kbuild to descend
@@ -176,7 +176,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 # If the object belongs to two or more multi-part objects, all of them are
 # concatenated with a colon separator.
 modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
-		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=)))))
+		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$(m:.o=)))))
 
 # Useful for describing the dependency of composite objects
 # Usage:
-- 
2.7.4
