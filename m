Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeCMGMA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:12:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44588 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeCMGL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:11:57 -0400
X-Google-Smtp-Source: AG47ELvD3CCz8HwKhyN/GpT6L1SRtsjNkfqsYmEhYMR8dS+LMXLZlP/5pZEYa2yMZurb220MuUoEFg==
From: Douglas Anderson <dianders@chromium.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: malat@debian.org, dave.hansen@intel.com, yang.s@alibaba-inc.com,
        linux@roeck-us.net, Douglas Anderson <dianders@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v3 1/2] kbuild: Require a 'make clean' if we detect gcc changed underneath us
Date: Mon, 12 Mar 2018 23:11:08 -0700
Message-Id: <20180313061109.72629-2-dianders@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313061109.72629-1-dianders@chromium.org>
References: <20180313061109.72629-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several people reported that the commit 3298b690b21c ("kbuild: Add a
cache for generated variables") caused them problems when they updated
gcc versions.  Specifically the reports all looked something similar
to this:

> In file included from ./include/uapi/linux/uuid.h:21:0,
>                  from ./include/linux/uuid.h:19,
>                  from ./include/linux/mod_devicetable.h:12,
>                  from scripts/mod/devicetable-offsets.c:2:
> ./include/linux/string.h:8:20: fatal error: stdarg.h: No such file or
>                  directory
>  #include <stdarg.h>

Masahiro Yamada determined that the problem was with:

  NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC)
  -print-file-name=include)

Specifically that the stale result of -print-file-name is stored in
the cache file.  It was determined that a "make clean" fixed the
problems in all cases.

In this particular case we could certainly try to clean just the cache
when we detect a gcc update, but it seems like overall it's a bad idea
to do an incremental build when gcc changes.  We should warn the user
and tell them that they need a 'make clean'.

Fixes: 3298b690b21c ("kbuild: Add a cache for generated variables")
Reported-by: Yang Shi <yang.s@alibaba-inc.com>
Reported-by: Dave Hansen <dave.hansen@intel.com>
Reported-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Fix as per Masahiro Yamada (move change to main Makefile)

Changes in v2:
- Don't error if MAKECMDGOALS is blank.

 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index c4322dea3ca2..f1e61470640b 100644
--- a/Makefile
+++ b/Makefile
@@ -573,6 +573,15 @@ virt-y		:= virt/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
+# Require a 'make clean' if the compiler changed; not only does the .cache.mk
+# need to be thrown out but we should also start with fresh object files.
+cc-fullversion-uncached := \
+	$(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh -p $(CC))
+
+ifneq ($(cc-fullversion-uncached),$(cc-fullversion))
+   $(error Detected new CC version ($(cc-fullversion-uncached) vs $(cc-fullversion)).  Please 'make clean')
+endif
+
 # Read in config
 -include include/config/auto.conf
 
-- 
2.16.2.660.g709887971b-goog
