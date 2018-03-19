Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeCSJC0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:02:26 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:50217 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbeCSJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:02:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2J91Vk5014340
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 1/5] kbuild: remove unnecessary $(subst $(obj)/, , ...) in modname-multi
Date: Mon, 19 Mar 2018 18:01:23 +0900
Message-Id: <1521450087-27291-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the context ...

    $(obj)/%.s: $(src)/%.c FORCE
            $(call if_changed_dep,cc_s_c)

    $(obj)/%.i: $(src)/%.c FORCE
            $(call if_changed_dep,cpp_i_c)

    $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
            $(call cmd,force_checksrc)
            $(call if_changed_rule,cc_o_c)

    $(obj)/%.lst: $(src)/%.c FORCE
            $(call if_changed_dep,cc_lst_c)

'$*' returns the stem of the target (the part of '%'), so $(obj)/ has
already been ripped off.

$(subst $(obj)/,,$*.o) is the same as $*.o

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---

Changes in v2: None

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5fd60af..4eedd6e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -175,7 +175,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(sort $(foreach m,$(multi-used),\
-		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
+		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
 
 # Useful for describing the dependency of composite objects
 # Usage:
-- 
2.7.4
