Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeA3TBn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:01:43 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:42130 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeA3TBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:01:42 -0500
X-Google-Smtp-Source: AH8x225HuKe286c83hkAmyXu4q3FJ7cAujLLUT9PPPeq5ITnGG4EZay23oOaXzA86RkpX0nucn4wAVMUt9EQtsAP8tfDVw==
MIME-Version: 1.0
Date: Tue, 30 Jan 2018 11:01:36 -0800
Message-Id: <20180130190136.46491-1-mjg59@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH] modpost: List all GPL-only symbols used by GPL-incompatible modules
From: Matthew Garrett <mjg59@google.com>
To: jeyu@redhat.com
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modpost currently exits after hitting the first GPL-only symbol used by
a GPL-incompatible module. Delay the failure until all symbols have been
processed in order to print all cases rather than just the first.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 scripts/mod/modpost.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f51cf977c65b..2daa66e4569c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2056,29 +2056,30 @@ void buf_write(struct buffer *buf, const char *s, int len)
 	buf->pos += len;
 }
 
-static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
+static int check_for_gpl_usage(enum export exp, const char *m, const char *s)
 {
 	const char *e = is_vmlinux(m) ?"":".ko";
 
 	switch (exp) {
 	case export_gpl:
-		fatal("modpost: GPL-incompatible module %s%s "
+		warn("modpost: GPL-incompatible module %s%s "
 		      "uses GPL-only symbol '%s'\n", m, e, s);
-		break;
+		return 1;
 	case export_unused_gpl:
-		fatal("modpost: GPL-incompatible module %s%s "
+		warn("modpost: GPL-incompatible module %s%s "
 		      "uses GPL-only symbol marked UNUSED '%s'\n", m, e, s);
-		break;
+		return 1;
 	case export_gpl_future:
 		warn("modpost: GPL-incompatible module %s%s "
 		      "uses future GPL-only symbol '%s'\n", m, e, s);
-		break;
+		return 0;
 	case export_plain:
 	case export_unused:
 	case export_unknown:
 		/* ignore */
-		break;
+		return 0;
 	}
+	return 0;
 }
 
 static void check_for_unused(enum export exp, const char *m, const char *s)
@@ -2100,6 +2101,7 @@ static void check_for_unused(enum export exp, const char *m, const char *s)
 static void check_exports(struct module *mod)
 {
 	struct symbol *s, *exp;
+	int symbol_mismatch = 0;
 
 	for (s = mod->unres; s; s = s->next) {
 		const char *basename;
@@ -2111,10 +2113,13 @@ static void check_exports(struct module *mod)
 			basename++;
 		else
 			basename = mod->name;
-		if (!mod->gpl_compatible)
-			check_for_gpl_usage(exp->export, basename, exp->name);
+		if (!mod->gpl_compatible &&
+		    check_for_gpl_usage(exp->export, basename, exp->name))
+			symbol_mismatch = 1;
 		check_for_unused(exp->export, basename, exp->name);
 	}
+	if (symbol_mismatch)
+		fatal("Module violates symbol usage policy\n");
 }
 
 static int check_modname_len(struct module *mod)
-- 
2.16.0.rc1.238.g530d649a79-goog
