Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeBKIlk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 03:41:40 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:47569 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBKIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 03:41:38 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w1B8eaDK014695
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, Thomas Meyer <thomas@m3y3r.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: process mixture of clean/build targets one by one
Date: Sun, 11 Feb 2018 17:40:29 +0900
Message-Id: <1518338429-5587-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sometimes receive a question why "make -j<N> clean all" does not
work.  It is actually possible to make it work by handling targets
one by one.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cd9145c..31d138e 100644
--- a/Makefile
+++ b/Makefile
@@ -220,7 +220,8 @@ export srctree objtree VPATH
 version_h := include/generated/uapi/linux/version.h
 old_version_h := include/linux/version.h
 
-no-dot-config-targets := clean mrproper distclean \
+clean-targets := %clean mrproper cleandocs
+no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
@@ -243,6 +244,14 @@ ifeq ($(KBUILD_EXTMOD),)
                 endif
         endif
 endif
+
+# For "make -j clean all", "make -j mrproper defconfig all", etc.
+ifneq ($(filter $(clean-targets),$(MAKECMDGOALS)),)
+        ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
+                mixed-targets := 1
+        endif
+endif
+
 # install and modules_install need also be processed one by one
 ifneq ($(filter install,$(MAKECMDGOALS)),)
         ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
-- 
2.7.4
