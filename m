Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936131AbeCBHGl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:06:41 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:55173 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932927AbeCBHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:06:40 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2275GSq020139
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: fix line number in recursive inclusion error message
Date: Fri,  2 Mar 2018 16:05:12 +0900
Message-Id: <1519974312-20477-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When recursive inclusion is detected, the line number of the last
'included from:' is wrong.

[Test Case]

Kconfig:
  -------->8--------
  source "Kconfig2"
  -------->8--------

Kconfig2:
  -------->8--------
  source "Kconfig3"
  -------->8--------

Kconfig3:
  -------->8--------
  source "Kconfig"
  -------->8--------

[Result]

  $ make allyesconfig
  scripts/kconfig/conf  --allyesconfig Kconfig
  Kconfig:1: recursive inclusion detected. Inclusion path:
    current file : 'Kconfig'
    included from: 'Kconfig3:1'
    included from: 'Kconfig2:1'
    included from: 'Kconfig:3'
  scripts/kconfig/Makefile:89: recipe for target 'allyesconfig' failed
  make[1]: *** [allyesconfig] Error 1
  Makefile:512: recipe for target 'allyesconfig' failed
  make: *** [allyesconfig] Error 2

where we expect

    current file : 'Kconfig'
    included from: 'Kconfig3:1'
    included from: 'Kconfig2:1'
    included from: 'Kconfig:1'

The 'iter->lineno+1' in the second fpinrtf() should be 'iter->lineno-1'.
I refactored the code to merge two fprintf().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.l | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 02de6fe..88b650e 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -332,16 +332,12 @@ void zconf_nextfile(const char *name)
 				"Inclusion path:\n  current file : '%s'\n",
 				zconf_curname(), zconf_lineno(),
 				zconf_curname());
-			iter = current_file->parent;
-			while (iter && \
-			       strcmp(iter->name,current_file->name)) {
-				fprintf(stderr, "  included from: '%s:%d'\n",
-					iter->name, iter->lineno-1);
+			iter = current_file;
+			do {
 				iter = iter->parent;
-			}
-			if (iter)
 				fprintf(stderr, "  included from: '%s:%d'\n",
-					iter->name, iter->lineno+1);
+					iter->name, iter->lineno - 1);
+			} while (strcmp(iter->name, current_file->name));
 			exit(1);
 		}
 	}
-- 
2.7.4
