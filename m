Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCVRBT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:01:19 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47772 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCVRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:01:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2MH0Mr2012430
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kconfig: remove duplicated file name and lineno of recursive inclusion
Date: Fri, 23 Mar 2018 02:00:12 +0900
Message-Id: <1521738014-18895-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in the unit test, the error message for the recursive inclusion
looks like this:

  Kconfig.inc1:4: recursive inclusion detected. Inclusion path:
    current file : 'Kconfig.inc1'
    included from: 'Kconfig.inc3:1'
    included from: 'Kconfig.inc2:3'
    included from: 'Kconfig.inc1:4'

The 'Kconfig.inc1:4' is duplicated in the first and last lines.
Also, the single quotes do not help readability.

Change the message like follows:

  Recursive inclusion detected.
  Inclusion path:
    current file : Kconfig.inc1
    included from: Kconfig.inc3:1
    included from: Kconfig.inc2:3
    included from: Kconfig.inc1:4

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/tests/err_recursive_inc/expected_stderr | 11 ++++++-----
 scripts/kconfig/zconf.l                                 |  9 ++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/tests/err_recursive_inc/expected_stderr b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
index a15dbed..6b582ee 100644
--- a/scripts/kconfig/tests/err_recursive_inc/expected_stderr
+++ b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
@@ -1,5 +1,6 @@
-Kconfig.inc1:4: recursive inclusion detected. Inclusion path:
-  current file : 'Kconfig.inc1'
-  included from: 'Kconfig.inc3:1'
-  included from: 'Kconfig.inc2:3'
-  included from: 'Kconfig.inc1:4'
+Recursive inclusion detected.
+Inclusion path:
+  current file : Kconfig.inc1
+  included from: Kconfig.inc3:1
+  included from: Kconfig.inc2:3
+  included from: Kconfig.inc1:4
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 88b650e..6f139d2 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -328,14 +328,13 @@ void zconf_nextfile(const char *name)
 	for (iter = current_file->parent; iter; iter = iter->parent ) {
 		if (!strcmp(current_file->name,iter->name) ) {
 			fprintf(stderr,
-				"%s:%d: recursive inclusion detected. "
-				"Inclusion path:\n  current file : '%s'\n",
-				zconf_curname(), zconf_lineno(),
-				zconf_curname());
+				"Recursive inclusion detected.\n"
+				"Inclusion path:\n"
+				"  current file : %s\n", zconf_curname());
 			iter = current_file;
 			do {
 				iter = iter->parent;
-				fprintf(stderr, "  included from: '%s:%d'\n",
+				fprintf(stderr, "  included from: %s:%d\n",
 					iter->name, iter->lineno - 1);
 			} while (strcmp(iter->name, current_file->name));
 			exit(1);
-- 
2.7.4
