Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeBHF6G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 00:58:06 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:58455 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeBHF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 00:58:04 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w185uhG2007816
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marc Herbert <marc.herbert@intel.com>
Subject: [PATCH 1/2] kconfig: remove check_stdin()
Date: Thu,  8 Feb 2018 14:56:39 +0900
Message-Id: <1518069400-7037-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except silentoldconfig, valid_stdin is 1, so check_stdin() is no-op.

oldconfig and silentoldconfig work almost in the same way except that
the latter generates additional files.  Both ask users for input for
new symbols.

I do not know why only silentoldconfig requires stdio be tty.

  $ rm -f .config; touch .config
  $ yes "" | make oldconfig > stdout
  $ rm -f .config; touch .config
  $ yes "" | make silentoldconfig > stdout
  make[1]: *** [silentoldconfig] Error 1
  make: *** [silentoldconfig] Error 2
  $ tail -n 4 stdout
  Console input/output is redirected. Run 'make oldconfig' to update configuration.

  scripts/kconfig/Makefile:40: recipe for target 'silentoldconfig' failed
  Makefile:507: recipe for target 'silentoldconfig' failed

Redirection is useful, for example, for testing where we want to give
particular key inputs from a test file, then check the result.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 307bc3f..358e2e4 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -39,7 +39,6 @@ static enum input_mode input_mode = oldaskconfig;
 
 static int indent = 1;
 static int tty_stdio;
-static int valid_stdin = 1;
 static int sync_kconfig;
 static int conf_cnt;
 static char line[PATH_MAX];
@@ -72,16 +71,6 @@ static void strip(char *str)
 		*p-- = 0;
 }
 
-static void check_stdin(void)
-{
-	if (!valid_stdin) {
-		printf(_("aborted!\n\n"));
-		printf(_("Console input/output is redirected. "));
-		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
-		exit(1);
-	}
-}
-
 /* Helper function to facilitate fgets() by Jean Sacren. */
 static void xfgets(char *str, int size, FILE *in)
 {
@@ -113,7 +102,6 @@ static int conf_askvalue(struct symbol *sym, const char *def)
 			printf("%s\n", def);
 			return 0;
 		}
-		check_stdin();
 		/* fall through */
 	case oldaskconfig:
 		fflush(stdout);
@@ -315,7 +303,6 @@ static int conf_choice(struct menu *menu)
 				printf("%d\n", cnt);
 				break;
 			}
-			check_stdin();
 			/* fall through */
 		case oldaskconfig:
 			fflush(stdout);
@@ -650,7 +637,6 @@ int main(int ac, char **av)
 				return 1;
 			}
 		}
-		valid_stdin = tty_stdio;
 	}
 
 	switch (input_mode) {
-- 
2.7.4
