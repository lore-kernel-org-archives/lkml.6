Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbeCHBH3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:07:29 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:60402 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbeCHBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:05:56 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w28156G6018694
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
Subject: [PATCH 1/5] kbuild: remove unnecessary $(subst $(obj)/,,...) in modname-multi
Date: Thu,  8 Mar 2018 10:04:59 +0900
Message-Id: <1520471103-10089-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
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

$(subst $(obj)/,,$*.o) is the same as $(*.o)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5589bae..a7e315f 100644
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
