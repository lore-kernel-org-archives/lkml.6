Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeB1TSS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:18:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51917 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933185AbeB1TSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:18:15 -0500
X-Google-Smtp-Source: AH8x227hijezH83ayN5JUahyV+SJM/xUomOkSHNDv3jCzCdOL9H8dYBFGmWDbj5mnhko7htnQ65NKQ==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fixdep: remove stale references to uml-config.h
Date: Wed, 28 Feb 2018 20:17:35 +0100
Message-Id: <20180228191805.20094-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <CA+55aFz_ww8ohU68Jz34pg_x7gpGpJ+FC-dmS_Rm_VvY01GGpg@mail.gmail.com>
References: <CA+55aFz_ww8ohU68Jz34pg_x7gpGpJ+FC-dmS_Rm_VvY01GGpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uml-config.h hasn't existed in this decade (87e299e5c750 - x86, um: get
rid of uml-config.h). The few remaining UML_CONFIG instances are defined
directly in terms of their real CONFIG symbol in common-offsets.h, so
unlike when the symbols got defined via a sed script, anything that uses
UML_CONFIG_FOO now should also automatically pick up a dependency on
CONFIG_FOO via the normal fixdep mechanism (since common-offsets.h
should at least recursively be a dependency). Hence I believe we should
actually be able to ignore the HELLO_CONFIG_BOOM cases.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/basic/fixdep.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index fa3d39b6f23b..d7fbe545dd5d 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -93,14 +93,6 @@
  * (Note: it'd be easy to port over the complete mkdep state machine,
  *  but I don't think the added complexity is worth it)
  */
-/*
- * Note 2: if somebody writes HELLO_CONFIG_BOOM in a file, it will depend onto
- * CONFIG_BOOM. This could seem a bug (not too hard to fix), but please do not
- * fix it! Some UserModeLinux files (look at arch/um/) call CONFIG_BOOM as
- * UML_CONFIG_BOOM, to avoid conflicts with /usr/include/linux/autoconf.h,
- * through arch/um/include/uml-config.h; this fixdep "bug" makes sure that
- * those files will have correct dependencies.
- */
 
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -286,7 +278,6 @@ static int is_ignored_file(const char *s, int len)
 {
 	return str_ends_with(s, len, "include/generated/autoconf.h") ||
 	       str_ends_with(s, len, "include/generated/autoksyms.h") ||
-	       str_ends_with(s, len, "arch/um/include/uml-config.h") ||
 	       str_ends_with(s, len, "include/linux/kconfig.h") ||
 	       str_ends_with(s, len, ".ver");
 }
-- 
2.15.1
