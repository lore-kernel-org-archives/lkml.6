Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88753C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6C241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ap7ps1nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD6C241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeGECll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:41 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43927 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGEClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:37 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZb028145;
        Thu, 5 Jul 2018 11:40:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZb028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758401;
        bh=rpE7EtXmU6ta5MKoKdW8f6wc78ugB7bmilV4nG5tgRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ap7ps1nHuOViuCiVVljp0PLiumgdvXoAEx96D99eqrAmWUd75Iakg9L/BCJqmq8CR
         /EQakYo/E7LIvqiwcYc47nt+2b6fdhOOkb2p4KVtKxy0dW0TuC2vbQqUnygChPUzpj
         iRmyZadKSu0FViOk64oZLgkUObK2QUr5FgyR++9x37V2MjhXWGTZjoV2tbYFamHOOh
         rxS7+ZlPcewxXpZVQyvabjWVRl8CdhelbEi75MUwJ1XxPMU1uSyxH8qto2Dp0ieejj
         wgG7kJGm2jl6K5XG+CoRx19ASn53Wzi2dqZgzGz4CJvKx7+hZdlcMy6kD4hML/rrsD
         p5jwATH5Xp0mw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/12] kconfig: make syncconfig update .config regardless of sym_change_count
Date:   Thu,  5 Jul 2018 11:39:42 +0900
Message-Id: <1530758389-30862-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
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

