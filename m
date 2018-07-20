Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C4D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ds3jhj07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C4D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeGTIfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:31 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28745 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeGTIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:35:09 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdiv008048;
        Fri, 20 Jul 2018 16:46:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdiv008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072802;
        bh=DL6rqdJcJnUdm3wir3gubx0P8b9ZdYaiRz2bsCRy3j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ds3jhj07Vn1lHnauCVIt933fA5pnX9m6TvL4G/HaJ2liB+WID3NKc0j4Z/JsdXpBt
         Xk1NnReFUqFYFTzFQtf3aFGvHZbHrWUQfYmjxOXkhChGdw6k2ByIGPi7JuKCCKeXWn
         WnM0ozUOvgfAkJZTU4hxQ5svMFQMkh43Yq9Ullnnj2knjsWgmpmY0NTT8ZgN71dalI
         mzvJuTBoAYLOf6updg3rOyrWArx3coWT3zvVQ0Bf1IVZQBk1dQgaODStcyc9rlpDPN
         KMoY5pEqXWMAJs6uptcFxWT1ta1IEyN+lmQsVGXhj9YyS6ztXH2zMEsPubpAUwk3xp
         6FX4hZNsNgGsQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] kconfig: make syncconfig update .config regardless of sym_change_count
Date:   Fri, 20 Jul 2018 16:46:30 +0900
Message-Id: <1532072796-7947-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syncconfig updates the .config only when sym_change_count > 0, i.e.
any change in config symbols has been detected.

Not only symbols but also comments are contained in the .config file.
If only comments are updated, they are not fed back to the .config,
then the stale comments are left-over.  Of course, this is just a
matter of comments, but why not fix it.

I see some scenarios where this happens.

Scenario A:

 1. You have a source tree that has already been configured.

 2. Linus increments the version number in the top-level Makefile
    (i.e. he commits a new release)

 3. You pull it, and run 'make'

 4. syncconfig is invoked because the environment variable,
    KERNELVERSION is updated, but the .config is not updated since
    no config symbol is changed.

 5. The .config file contains a kernel version in the top line:

    # Automatically generated file; DO NOT EDIT.
    # Linux/arm64 4.18.0-rc2 Kernel Configuration

    ... which points to a previous version.

Scenario B:

 1. You have a source tree that has already been configured.

 2. You upgrade the compiler, but it still has the same version number.
    This may happen if you regularly build the latest compiler from
    the source code.

 3. You run 'make'

 4. syncconfig is invoked because the environment variable,
    CC_VERSION_TEXT is updated, but the .config is not updated since
    no config symbol is changed.

 5. The .config file contains the version string of the compiler:

    #
    # Compiler: aarch64-linux-gcc (GCC) 9.0.0 20180628 (experimental)
    #

    ... which carries the information of the old compiler.

If KCONFIG_NOSILENTUPDATE is set, syncconfig is not allowed to update
the .config file.  Otherwise, it is fine to update it regardless of
sym_change_count.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None

 scripts/kconfig/conf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 671ff53..5af8991 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -496,6 +496,7 @@ int main(int ac, char **av)
 	int opt;
 	const char *name, *defconfig_file = NULL /* gcc uninit */;
 	struct stat tmpstat;
+	int no_conf_write = 0;
 
 	tty_stdio = isatty(0) && isatty(1);
 
@@ -633,13 +634,14 @@ int main(int ac, char **av)
 	}
 
 	if (sync_kconfig) {
-		if (conf_get_changed()) {
-			name = getenv("KCONFIG_NOSILENTUPDATE");
-			if (name && *name) {
+		name = getenv("KCONFIG_NOSILENTUPDATE");
+		if (name && *name) {
+			if (conf_get_changed()) {
 				fprintf(stderr,
 					"\n*** The configuration requires explicit update.\n\n");
 				return 1;
 			}
+			no_conf_write = 1;
 		}
 	}
 
@@ -688,7 +690,7 @@ int main(int ac, char **av)
 		/* syncconfig is used during the build so we shall update autoconf.
 		 * All other commands are only used to generate a config.
 		 */
-		if (conf_get_changed() && conf_write(NULL)) {
+		if (!no_conf_write && conf_write(NULL)) {
 			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
 			exit(1);
 		}
-- 
2.7.4

