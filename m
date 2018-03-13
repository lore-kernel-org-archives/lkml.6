Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCMGMq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:12:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39432 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeCMGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:11:59 -0400
X-Google-Smtp-Source: AG47ELtlQKfc7aLm3tRvBGJOWznkeATMo7T8X8ReVXMWUYecxci44LaN9voyl3JwOJecKPCwXhaLmw==
From: Douglas Anderson <dianders@chromium.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: malat@debian.org, dave.hansen@intel.com, yang.s@alibaba-inc.com,
        linux@roeck-us.net, Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 2/2] kbuild: Don't mess with the .cache.mk when root
Date: Mon, 12 Mar 2018 23:11:09 -0700
Message-Id: <20180313061109.72629-3-dianders@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313061109.72629-1-dianders@chromium.org>
References: <20180313061109.72629-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Masahiro Yamada people often run "sudo make install"
or "sudo make modules_install".  In theory, that could cause a cache
file (or the directory containing it) to be created by root.  After
doing this then subsequent invocations to make would yell with a whole
bunch of warnings like:

  /bin/sh: ./.cache.mk: Permission denied

These yells would be mostly harmless (we'd just go on running without
the cache), but they're ugly.

The above situation would be fairly unlikely because it should only
happen if someone does "sudo make install" before doing a normal
"make", which is an invalid thing to do.  If you did a normal "make"
before the "sudo make install" then all the cache files and
directories should have already been created by a normal user and,
even if the superuser needed to add to the existing files, we wouldn't
end up with a permission problem.

The above situation would also not have been catastrophic because
presumably if the user was able to run "sudo make install" then they
should also be able to run "sudo make clean" to clean things up.

However, even though the problem described is relatively minor, it
probably makes sense to add a heuristic to avoid creating cache files
when we're running as root.  This heuristic doesn't add a ton of
overhead and it might save someone time tracking down strange
"Permission denied" messages.  We'll consider this heuristic good
enough because the problem really shouldn't be that serious.

Fixes: 3298b690b21c ("kbuild: Add a cache for generated variables")
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Use "uid 0" as the heuristic instead of install
- Do the checking in the main Makefile instead of Kbuild.include

Changes in v2: None

 Makefile               | 6 ++++++
 scripts/Kbuild.include | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index f1e61470640b..c4d2131831ba 100644
--- a/Makefile
+++ b/Makefile
@@ -268,6 +268,12 @@ __build_one_by_one:
 
 else
 
+# Don't create Makefile caches if running as root since they can't be deleted
+# easily; in the real world we might be root when doing "sudo make install"
+ifeq ($(shell id -u),0)
+export KBUILD_NOCACHE := 1
+endif
+
 # We need some generic definitions (do not try to remake the file).
 scripts/Kbuild.include: ;
 include scripts/Kbuild.include
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 065324a8046f..581f93f20119 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -137,12 +137,14 @@ __sanitize-opt = $(subst $$,_,$(subst $(right_paren),_,$(subst $(left_paren),_,$
 define __run-and-store
 ifeq ($(origin $(1)),undefined)
   $$(eval $(1) := $$(shell $$(2)))
+ifneq ($(KBUILD_NOCACHE),1)
 ifeq ($(create-cache-dir),1)
   $$(shell mkdir -p $(dir $(make-cache)))
   $$(eval create-cache-dir :=)
 endif
   $$(shell echo '$(1) := $$($(1))' >> $(make-cache))
 endif
+endif
 endef
 __shell-cached = $(eval $(call __run-and-store,$(1)))$($(1))
 shell-cached = $(call __shell-cached,__cached_$(call __sanitize-opt,$(1)),$(1))
-- 
2.16.2.660.g709887971b-goog
