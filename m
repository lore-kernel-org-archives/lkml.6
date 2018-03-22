Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCVRBe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:01:34 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47943 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCVRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:01:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2MH0Mr3012430
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kconfig: detect recursive inclusion earlier
Date: Fri, 23 Mar 2018 02:00:13 +0900
Message-Id: <1521738014-18895-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the recursive inclusion is not detected when the offending
file is about to be included; it is detected the offending file is
about to include the *next* file.  This is because the detection loop
does not involve the file being included.

Do this check against the file that is about to be included so that
the recursive inclusion is detected before unneeded parsing happens.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 6f139d2..29b5d33 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -325,23 +325,25 @@ void zconf_nextfile(const char *name)
 	buf->parent = current_buf;
 	current_buf = buf;
 
-	for (iter = current_file->parent; iter; iter = iter->parent ) {
-		if (!strcmp(current_file->name,iter->name) ) {
+	file->parent = current_file;
+
+	for (iter = current_file; iter; iter = iter->parent) {
+		if (!strcmp(iter->name, file->name)) {
 			fprintf(stderr,
 				"Recursive inclusion detected.\n"
 				"Inclusion path:\n"
-				"  current file : %s\n", zconf_curname());
-			iter = current_file;
+				"  current file : %s\n", file->name);
+			iter = file;
 			do {
 				iter = iter->parent;
 				fprintf(stderr, "  included from: %s:%d\n",
 					iter->name, iter->lineno - 1);
-			} while (strcmp(iter->name, current_file->name));
+			} while (strcmp(iter->name, file->name));
 			exit(1);
 		}
 	}
+
 	file->lineno = 1;
-	file->parent = current_file;
 	current_file = file;
 }
 
-- 
2.7.4
