Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeB1ARM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:17:12 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24522 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeB1AQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:55 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1S0Fahq000353
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 6/6] kconfig: rename silentoldconfig to syncconfig
Date: Wed, 28 Feb 2018 09:15:26 +0900
Message-Id: <1519776926-30459-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit cedd55d49dee ("kconfig: Remove silentoldconfig from help
and docs; fix kconfig/conf's help") mentioned, 'silentoldconfig' is a
historical misnomer.  That commit removed it from help and docs since
it is an internal interface.  If so, it should be allowed to rename
it to something more intuitive.  'syncconfig' is the one I came up
with because it updates the .config if necessary, then synchronize
other files with it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - newly added

 Documentation/kbuild/kconfig.txt |  2 +-
 Makefile                         |  2 +-
 scripts/kconfig/Makefile         |  4 ++--
 scripts/kconfig/conf.c           | 20 ++++++++++----------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/kbuild/kconfig.txt b/Documentation/kbuild/kconfig.txt
index bbc99c0..7233118 100644
--- a/Documentation/kbuild/kconfig.txt
+++ b/Documentation/kbuild/kconfig.txt
@@ -119,7 +119,7 @@ Examples:
 		15% of tristates will be set to 'y', 15% to 'm', 70% to 'n'
 
 ______________________________________________________________________
-Environment variables for 'silentoldconfig'
+Environment variables for 'syncconfig'
 
 KCONFIG_NOSILENTUPDATE
 --------------------------------------------------
diff --git a/Makefile b/Makefile
index 8706bf2..ea23d9b 100644
--- a/Makefile
+++ b/Makefile
@@ -598,7 +598,7 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 # include/generated/ and include/config/. Update them if .config is newer than
 # include/config/auto.conf (which mirrors .config).
 include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
-	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
+	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else
 # external modules needs include/generated/autoconf.h and include/config/auto.conf
 # but do not care if they are up-to-date. Use auto.conf to trigger the test
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index bf9289a..988258a 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -3,7 +3,7 @@
 # Kernel configuration targets
 # These targets are used from top-level makefile
 
-PHONY += xconfig gconfig menuconfig config silentoldconfig update-po-config \
+PHONY += xconfig gconfig menuconfig config syncconfig update-po-config \
 	localmodconfig localyesconfig
 
 ifdef KBUILD_KCONFIG
@@ -36,7 +36,7 @@ nconfig: $(obj)/nconf
 
 # This has become an internal implementation detail and is now deprecated
 # for external use.
-silentoldconfig: $(obj)/conf
+syncconfig: $(obj)/conf
 	$(Q)mkdir -p include/config include/generated
 	$(Q)test -e include/generated/autoksyms.h || \
 	    touch   include/generated/autoksyms.h
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 11a4e45..4e08121 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -23,7 +23,7 @@ static void check_conf(struct menu *menu);
 
 enum input_mode {
 	oldaskconfig,
-	silentoldconfig,
+	syncconfig,
 	oldconfig,
 	allnoconfig,
 	allyesconfig,
@@ -100,7 +100,7 @@ static int conf_askvalue(struct symbol *sym, const char *def)
 
 	switch (input_mode) {
 	case oldconfig:
-	case silentoldconfig:
+	case syncconfig:
 		if (sym_has_value(sym)) {
 			printf("%s\n", def);
 			return 0;
@@ -293,7 +293,7 @@ static int conf_choice(struct menu *menu)
 		printf("[1-%d?]: ", cnt);
 		switch (input_mode) {
 		case oldconfig:
-		case silentoldconfig:
+		case syncconfig:
 			if (!is_new) {
 				cnt = def;
 				printf("%d\n", cnt);
@@ -441,7 +441,7 @@ static void check_conf(struct menu *menu)
 static struct option long_opts[] = {
 	{"oldaskconfig",    no_argument,       NULL, oldaskconfig},
 	{"oldconfig",       no_argument,       NULL, oldconfig},
-	{"silentoldconfig", no_argument,       NULL, silentoldconfig},
+	{"syncconfig",      no_argument,       NULL, syncconfig},
 	{"defconfig",       optional_argument, NULL, defconfig},
 	{"savedefconfig",   required_argument, NULL, savedefconfig},
 	{"allnoconfig",     no_argument,       NULL, allnoconfig},
@@ -468,8 +468,8 @@ static void conf_usage(const char *progname)
 	printf("  --listnewconfig         List new options\n");
 	printf("  --oldaskconfig          Start a new configuration using a line-oriented program\n");
 	printf("  --oldconfig             Update a configuration using a provided .config as base\n");
-	printf("  --silentoldconfig       Similar to oldconfig but generates configuration in\n"
-	       "                          include/{generated/,config/} (oldconfig used to be more verbose)\n");
+	printf("  --syncconfig            Similar to oldconfig but generates configuration in\n"
+	       "                          include/{generated/,config/}\n");
 	printf("  --olddefconfig          Same as oldconfig but sets new symbols to their default value\n");
 	printf("  --oldnoconfig           An alias of olddefconfig\n");
 	printf("  --defconfig <file>      New config with default defined in <file>\n");
@@ -501,7 +501,7 @@ int main(int ac, char **av)
 		}
 		input_mode = (enum input_mode)opt;
 		switch (opt) {
-		case silentoldconfig:
+		case syncconfig:
 			sync_kconfig = 1;
 			break;
 		case defconfig:
@@ -583,7 +583,7 @@ int main(int ac, char **av)
 		}
 		break;
 	case savedefconfig:
-	case silentoldconfig:
+	case syncconfig:
 	case oldaskconfig:
 	case oldconfig:
 	case listnewconfig:
@@ -667,7 +667,7 @@ int main(int ac, char **av)
 		/* fall through */
 	case oldconfig:
 	case listnewconfig:
-	case silentoldconfig:
+	case syncconfig:
 		/* Update until a loop caused no more changes */
 		do {
 			conf_cnt = 0;
@@ -680,7 +680,7 @@ int main(int ac, char **av)
 	}
 
 	if (sync_kconfig) {
-		/* silentoldconfig is used during the build so we shall update autoconf.
+		/* syncconfig is used during the build so we shall update autoconf.
 		 * All other commands are only used to generate a config.
 		 */
 		if (conf_get_changed() && conf_write(NULL)) {
-- 
2.7.4
