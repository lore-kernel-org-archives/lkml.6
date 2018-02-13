Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933708AbeBMH6j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:58:39 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:40780 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933617AbeBMH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:58:36 -0500
X-Google-Smtp-Source: AH8x225waYmCemrVf8b2votC4Wci7RUEKcfEklk17SEfYgjnbx7qjm5oeJ26fgA8EWP7SiEbeNb4BQ==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2] Makefile: Fix lying comment re. silentoldconfig
Date: Tue, 13 Feb 2018 08:58:20 +0100
Message-Id: <20180213075821.24499-1-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above the silentoldconfig invocation is outdated.
'make oldconfig' updates just .config and doesn't touch the
include/config/ tree.

This came up in https://lkml.org/lkml/2018/2/12/415.

While fixing the comment, make it more informative by explaining the
purpose of the unfortunately named silentoldconfig.

I can't make sense of the comment re. auto.conf.cmd and a cleaned tree.
include/config/auto.conf and include/config/auto.conf.cmd are both
created simultaneously by silentoldconfig (in
scripts/kconfig/confdata.c, by conf_write_autoconf()), and nothing seems
to remove auto.conf.cmd that wouldn't remove auto.conf. Remove that part
of the comment rather than blindly copying it. It might be a leftover
from an older way of doing things.

The include/config/auto.conf.cmd prerequisite might be there to ensure
that silentoldconfig gets rerun if conf_write_autoconf() fails between
writing out auto.conf.cmd and auto.conf (a comment in the function
indicates that auto.conf is deliberately written out last to mark
completion of the operation). It seems the Makefile dependency between
include/config/auto.conf and .config would already take care of that
though, since include/config/auto.conf would still be out of date re.
.config if the operation fails.

Cop out and leave the prerequisite in for now.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
Changes in v2:
include/config/auto.conf depends on .config, not the other way around, so swap
them in some places in the commit message to make it less confusing.

 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 79ad2bfa24b6..61ed99ad4b1b 100644
--- a/Makefile
+++ b/Makefile
@@ -579,10 +579,13 @@ ifeq ($(KBUILD_EXTMOD),)
 # To avoid any implicit rule to kick in, define an empty command
 $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 
-# If .config is newer than include/config/auto.conf, someone tinkered
-# with it and forgot to run make oldconfig.
-# if auto.conf.cmd is missing then we are probably in a cleaned tree so
-# we execute the config step to be sure to catch updated Kconfig files
+# The actual configuration files used during the build are stored in
+# include/generated/ and include/config/. Update them if .config is newer than
+# include/config/auto.conf (which mirrors .config).
+#
+# The include/config/ tree manages dependencies between source files and
+# Kconfig symbols and lets us avoid doing a full rebuild whenever the
+# configuration is changed. See scripts/basic/fixdep.c
 include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
-- 
2.14.1
