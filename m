Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeCPCUA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:20:00 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44537 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeCPCTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:19:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2G2IoBQ003525
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] kbuild: move CONFIG_TRIM_UNUSED_KSYMS code unneeded for external module
Date: Fri, 16 Mar 2018 11:18:42 +0900
Message-Id: <1521166725-24157-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external module building does not need to parse this code because
KBUILD_MODULES is always set anyway.

Move this code inside the "ifeq ($(KBUILD_EXTMOD),) ... endif" block.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---

Changes in v2: None

 Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 0a3895c..ef42adb 100644
--- a/Makefile
+++ b/Makefile
@@ -614,13 +614,6 @@ else
 include/config/auto.conf: ;
 endif # $(dot-config)
 
-# For the kernel to actually contain only the needed exported symbols,
-# we have to build modules as well to determine what those symbols are.
-# (this can be evaluated only once include/config/auto.conf has been included)
-ifdef CONFIG_TRIM_UNUSED_KSYMS
-  KBUILD_MODULES := 1
-endif
-
 # The all: target is the default when no target is given on the
 # command line.
 # This allow a user to issue only 'make' to build a kernel including modules
@@ -1021,6 +1014,13 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
 	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
 endif
 
+# For the kernel to actually contain only the needed exported symbols,
+# we have to build modules as well to determine what those symbols are.
+# (this can be evaluated only once include/config/auto.conf has been included)
+ifdef CONFIG_TRIM_UNUSED_KSYMS
+  KBUILD_MODULES := 1
+endif
+
 autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
 
 $(autoksyms_h):
-- 
2.7.4
