Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeDMFIU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:20 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54459 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lft029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/30] gcc-plugins: fix build condition of SANCOV plugin
Date: Fri, 13 Apr 2018 14:06:10 +0900
Message-Id: <1523595999-27433-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d677a4d60193 ("Makefile: support flag
-fsanitizer-coverage=trace-cmp"), you miss to build the SANCOV
plugin under some circumstances.

  CONFIG_KCOV=y
  CONFIG_KCOV_ENABLE_COMPARISONS=y
  Your compiler does not support -fsanitize-coverage=trace-pc
  Your compiler does not support -fsanitize-coverage=trace-cmp

Under this condition, $(CFLAGS_KCOV) is not empty but contains a
space, so the following ifeq-conditional is false.

    ifeq ($(CFLAGS_KCOV),)

Then, scripts/Makefile.gcc-plugins misses to add sancov_plugin.so to
gcc-plugin-y while the SANCOV plugin is necessary as an alternative
means.

Fixes: d677a4d60193 ("Makefile: support flag -fsanitizer-coverage=trace-cmp")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 scripts/Makefile.gcc-plugins | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b2a95af..7f5c862 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -14,7 +14,7 @@ ifdef CONFIG_GCC_PLUGINS
   endif
 
   ifdef CONFIG_GCC_PLUGIN_SANCOV
-    ifeq ($(CFLAGS_KCOV),)
+    ifeq ($(strip $(CFLAGS_KCOV)),)
       # It is needed because of the gcc-plugin.sh and gcc version checks.
       gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
 
-- 
2.7.4
