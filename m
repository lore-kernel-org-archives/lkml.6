Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9DFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E14124024
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FMGkFK/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E14124024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeGECnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:43:32 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43989 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:39 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZc028145;
        Thu, 5 Jul 2018 11:40:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZc028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758401;
        bh=n4GF68ZS1ymMUwvExQBbpYOK2zqCDJxpiO4aoxZzkGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMGkFK/yGrGgHs5EhXrXeQBuuZ43h/XPosxx6CwmCkN9JBqUeGlOB+4EmGcrlHJe7
         bXjlJWFdQXBZj/15IRFRMDoyzhODEfdaEgZ2zlR2N3MNL69xD9D2oB6knP1Dln7rLX
         C0ZI0IA94oiucMt+XY8YexwHosXr8lj73P6fT8v2zJONdYwU2BvW4FGA3KIYMe/TMK
         6NVcRvTUkFmjVpqxHTTJUCXRCwTncZjrlllwEBybvCb1d2ijgdxqUgjViBlIUX7049
         y66bQj1rZ/odNH78FNhGGOP5Bhhq8AYvjmSoLWtJdkHxXL8CUMkAl+yy4kbI1igRlK
         GQ/e+piEiGb/A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/12] kconfig: allow all config targets to write auto.conf if missing
Date:   Thu,  5 Jul 2018 11:39:43 +0900
Message-Id: <1530758389-30862-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only syncconfig creates or updates include/config/auto.conf
and some other files.  Other config targets create or update only the
.config file.

When you configure and build the kernel from a pristine source tree,
any config target is followed by syncconfig in the build stage since
include/config/auto.conf is missing.

We are moving compiler tests from Makefile to Kconfig.  It means that
parsing Kconfig files will be more costly since Kconfig invokes the
compiler commands internally.  Thus, we want to avoid invoking Kconfig
twice (one for *config to create the .config, and one for syncconfig
to synchronize the auto.conf).  If auto.conf does not exist, we can
generate all configuration files in the first configuration stage,
which will save the syncconfig in the build stage.

Please note this should be done only when auto.conf is missing.  If
*config blindly did this, time stamp files under include/config/ would
be unnecessarily touched, triggering unneeded rebuild of objects.

I assume a scenario like this:

 1. You have a source tree that has already been built
    with CONFIG_FOO disabled

 2. Run "make menuconfig" to enable CONFIG_FOO

 3. CONFIG_FOO turns out to be unnecessary.
    Run "make menuconfig" again to disable CONFIG_FOO

 4. Run "make"

In this case, include/config/foo.h should not be touched since there
is no change in CONFIG_FOO.  The sync process should be delayed until
the user really attempts to build the kernel.

This commit has another motivation; I want to suppress the 'No such
file or directory' warning from the 'include' directive.

The top-level Makefile includes auto.conf with '-include' directive,
like this:

  ifeq ($(dot-config),1)
  -include include/config/auto.conf
  endif

This looks strange because auto.conf is mandatory when dot-config is 1.
I guess only the reason of using '-include' is to suppress the warning
'include/config/auto.conf: No such file or directory' when building
from a clean tree.  However, this has a side-effect; Make considers
the files included by '-include' are optional.  Hence, Make continues
to build even if it fails to generate include/config/auto.conf.  I will
change this in the next commit, but the warning message is annoying.
(At least, kbuild test robot reports it as a regression.)

With this commit, Kconfig will generate all configuration files together
with the .config and I guess it is a solution good enough to suppress
the warning.

Note:
GNU Make 4.2 or later does not display the warning from the 'include'
directive if include files are successfully generated.  See GNU Make
commit 87a5f98d248f ("[SV 102] Don't show unnecessary include file
errors.")  However, older GNU Make versions are still widely used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c      | 31 +++++++++++++++++--------------
 scripts/kconfig/confdata.c  | 11 +++++++----
 scripts/kconfig/gconf.c     |  1 +
 scripts/kconfig/lkc_proto.h |  2 +-
 scripts/kconfig/mconf.c     |  1 +
 scripts/kconfig/nconf.c     |  1 +
 scripts/kconfig/qconf.cc    |  2 ++
 7 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 5af8991..b35cc93 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -686,29 +686,32 @@ int main(int ac, char **av)
 		break;
 	}
 
-	if (sync_kconfig) {
-		/* syncconfig is used during the build so we shall update autoconf.
-		 * All other commands are only used to generate a config.
-		 */
-		if (!no_conf_write && conf_write(NULL)) {
-			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
-			exit(1);
-		}
-		if (conf_write_autoconf()) {
-			fprintf(stderr, "\n*** Error during update of the configuration.\n\n");
-			return 1;
-		}
-	} else if (input_mode == savedefconfig) {
+	if (input_mode == savedefconfig) {
 		if (conf_write_defconfig(defconfig_file)) {
 			fprintf(stderr, "n*** Error while saving defconfig to: %s\n\n",
 				defconfig_file);
 			return 1;
 		}
 	} else if (input_mode != listnewconfig) {
-		if (conf_write(NULL)) {
+		if (!no_conf_write && conf_write(NULL)) {
 			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
 			exit(1);
 		}
+
+		/*
+		 * Create auto.conf if it does not exist.
+		 * This prevents GNU Make 4.1 or older from emitting
+		 * "include/config/auto.conf: No such file or directory"
+		 * in the top-level Makefile
+		 *
+		 * syncconfig always creates or updates auto.conf because it is
+		 * used during the build.
+		 */
+		if (conf_write_autoconf(sync_kconfig) && sync_kconfig) {
+			fprintf(stderr,
+				"\n*** Error during sync of the configuration.\n\n");
+			return 1;
+		}
 	}
 	return 0;
 }
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 38b3a6c..5af25a0 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -1012,13 +1012,17 @@ static int conf_split_config(void)
 	return res;
 }
 
-int conf_write_autoconf(void)
+int conf_write_autoconf(int overwrite)
 {
 	struct symbol *sym;
 	const char *name;
+	const char *autoconf_name = conf_get_autoconfig_name();
 	FILE *out, *tristate, *out_h;
 	int i;
 
+	if (!overwrite && is_file(autoconf_name))
+		return 0;
+
 	sym_clear_all_valid();
 
 	conf_write_dep("include/config/auto.conf.cmd");
@@ -1081,14 +1085,13 @@ int conf_write_autoconf(void)
 	if (rename(".tmpconfig_tristate", name))
 		return 1;
 
-	name = conf_get_autoconfig_name();
-	if (mkdir_p(name))
+	if (mkdir_p(autoconf_name))
 		return 1;
 	/*
 	 * This must be the last step, kbuild has a dependency on auto.conf
 	 * and this marks the successful completion of the previous steps.
 	 */
-	if (rename(".tmpconfig", name))
+	if (rename(".tmpconfig", autoconf_name))
 		return 1;
 
 	return 0;
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 610c4ab..f16ed51 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -525,6 +525,7 @@ void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	if (conf_write(NULL))
 		text_insert_msg("Error", "Unable to save configuration !");
+	conf_write_autoconf(0);
 }
 
 
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index a8b7a33..b0cd52f 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -7,7 +7,7 @@ int conf_read(const char *name);
 int conf_read_simple(const char *name, int);
 int conf_write_defconfig(const char *name);
 int conf_write(const char *name);
-int conf_write_autoconf(void);
+int conf_write_autoconf(int overwrite);
 bool conf_get_changed(void);
 void conf_set_changed_callback(void (*fn)(void));
 void conf_set_message_callback(void (*fn)(const char *fmt, va_list ap));
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 5294ed1..82b27a0 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -977,6 +977,7 @@ static int handle_exit(void)
 					  "\n\n");
 			return 1;
 		}
+		conf_write_autoconf(0);
 		/* fall through */
 	case -1:
 		if (!silent)
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 97b7844..208f7be 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -674,6 +674,7 @@ static int do_exit(void)
 				  "Your configuration changes were NOT saved.",
 				  1,
 				  "<OK>");
+		conf_write_autoconf(0);
 		break;
 	default:
 		btn_dialog(
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index ad9c22d..62261b3 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1535,6 +1535,8 @@ bool ConfigMainWindow::saveConfig(void)
 		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 		return false;
 	}
+	conf_write_autoconf(0);
+
 	return true;
 }
 
-- 
2.7.4

