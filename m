Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nBTc1P3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6C620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeGTIe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:34:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28453 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeGTIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:34:58 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdiw008048;
        Fri, 20 Jul 2018 16:46:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdiw008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072803;
        bh=TqBqVF6vt5N89XqqLGehnhoV0W4cuLDMGfMaQ668pc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBTc1P3jKlwfjB9TR/2ueKdxQfxrql8DgHcQ8gafD9TBCv81UP0mWzhdFr12KCqrZ
         kKBLMSkm6HbA7q3q6SISAKCYzXmeEzRDf/E5lTVE5KNVYiEOCSx8MWm32YpogVGl+9
         tm2RNrcnjFS01zc3bN92o4ffPlY/O4VOWDjBN6IDU/zmL14LQ/xSraHxGNwSzjmFbo
         r5ILg1yIdFzyGTvSe8fBrDltbcfZN2Ipvdr7xQb/Frx3n8GgQm+2dFWyvqNHYSG4fA
         H91bkiiN6aX4S8Mw6zQWR3Jubf/+zjsYMebjjtNYL6q9ZGd8UTUBdaMYHc3sHsq5ry
         DuhWL0kK/fhWA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] kconfig: allow all config targets to write auto.conf if missing
Date:   Fri, 20 Jul 2018 16:46:31 +0900
Message-Id: <1532072796-7947-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v4: None

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
index 029ab16..620b50d 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -1008,13 +1008,17 @@ static int conf_split_config(void)
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
 
+	if (!overwrite && is_present(autoconf_name))
+		return 0;
+
 	sym_clear_all_valid();
 
 	conf_write_dep("include/config/auto.conf.cmd");
@@ -1077,14 +1081,13 @@ int conf_write_autoconf(void)
 	if (rename(".tmpconfig_tristate", name))
 		return 1;
 
-	name = conf_get_autoconfig_name();
-	if (make_parent_dir(name))
+	if (make_parent_dir(autoconf_name))
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

