Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeCNQpp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:45 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38068 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdU001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] kbuild: hide CONFIG_TRIM_UNUSED_KSYMS code from external module building
Date: Thu, 15 Mar 2018 01:44:19 +0900
Message-Id: <1521045861-22418-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_TRIM_UNUSED_KYMS is enabled, KBUILD_MODULES is set.  This
code is unneeded for external module building because KBUILD_MODULES
is always set.  Move this code inside "ifeq ($(KBUILD_EXTMOD),)"
conditional.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index decc870..e60b16f 100644
--- a/Makefile
+++ b/Makefile
@@ -603,13 +603,6 @@ else
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
@@ -1010,6 +1003,13 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
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
