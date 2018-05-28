Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeE1JY0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:24:26 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21481 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeE1JYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:13 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInL027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 04/31] kconfig: remove string expansion in file_lookup()
Date: Mon, 28 May 2018 18:21:41 +0900
Message-Id: <1527499328-13213-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two callers of file_lookup(), but there is no more reason
to expand the given path.

[1] zconf_initscan()
    This is used to open the first Kconfig.  sym_expand_string_value()
    has never been used in a useful way here; before opening the first
    Kconfig file, obviously there is no symbol to expand.  If you use
    expand_string_value() instead, environments in KBUILD_KCONFIG would
    be expanded, but I do not see practical benefits for that.

[2] zconf_nextfile()
    This is used to open the next file from 'source' statement.
    Symbols in the path like "arch/$SRCARCH/Kconfig" needed expanding,
    but it was replaced with the direct environment expansion.  The
    environment has already been expanded before the token is passed
    to the parser.

By the way, file_lookup() was already buggy; it expanded a given path,
but it used the path before expansion for look-up:
        if (!strcmp(name, file->name)) {

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
  - Simplify the patch.  Just remove text expansion.

 scripts/kconfig/util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 703ee49..a365594 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -14,18 +14,16 @@
 struct file *file_lookup(const char *name)
 {
 	struct file *file;
-	char *file_name = sym_expand_string_value(name);
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
-			free(file_name);
 			return file;
 		}
 	}
 
 	file = xmalloc(sizeof(*file));
 	memset(file, 0, sizeof(*file));
-	file->name = file_name;
+	file->name = xstrdup(name);
 	file->next = file_list;
 	file_list = file;
 	return file;
-- 
2.7.4
