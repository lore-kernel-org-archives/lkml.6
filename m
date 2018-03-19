Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeCSL1g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:27:36 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30317 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbeCSL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:27:21 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2JBQHQu023258
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 6/7] kbuild: clean up built-in.a archive rule
Date: Mon, 19 Mar 2018 20:26:12 +0900
Message-Id: <1521458773-14224-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the incremental linking entirely dropped, we can simplify
the Makefile.

While I am here, I renamed cmd_link_o_target to cmd_ar_builtin.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 66461e9..e5c1aa3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -450,17 +450,12 @@ ifdef builtin-target
 # makes them small and fast, but unable to be used by the linker.
 # scripts/link-vmlinux.sh builds an aggregate built-in.a with a symbol
 # table and index.
-cmd_make_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
-cmd_make_empty_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
-quiet_cmd_link_o_target = AR      $@
-
-# If the list of objects to link is empty, just create an empty built-in.a
-cmd_link_o_target = $(if $(strip $(real-obj-y)),\
-		      $(cmd_make_builtin) $@ $(filter $(real-obj-y), $^), \
-		      $(cmd_make_empty_builtin) $@)
+quiet_cmd_ar_builtin = AR      $@
+      cmd_ar_builtin = rm -f $@; \
+                     $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(filter $(real-obj-y), $^)
 
 $(builtin-target): $(real-obj-y) FORCE
-	$(call if_changed,link_o_target)
+	$(call if_changed,ar_builtin)
 
 targets += $(builtin-target)
 endif # builtin-target
-- 
2.7.4
