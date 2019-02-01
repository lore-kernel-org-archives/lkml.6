Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA18C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB9920863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gkb6lCu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfBAEvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:51:25 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53269 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfBAEvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:51:25 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x114onXv008188;
        Fri, 1 Feb 2019 13:50:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x114onXv008188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548996650;
        bh=zJxi2dBrPs9Bw9L9tlVtOplaKEBlf4+s06/35cIfvfU=;
        h=From:To:Cc:Subject:Date:From;
        b=gkb6lCu4NJEuF5OpqUcNET28mMWe5bEAfwX0TBS9k+jEwgy0TJNLlQHxqpDMqBVDZ
         IvML56GYsXzcGwib+ZGbrsxpZ7QpXczYPDGci+MVdoxVcL8Xy4y4akKL9gucRHfkGT
         2RkT2c9QZmVlYiEYy+q1sA8laFckscCVq0MjHa8nEmR1DVRP1JrojVa5MTZykDfZtp
         dEdpxA61r9GrJ9ECD4EXBFUkWqYuG7Q3DojQpfOtYM05+5e7dEF35shDmHhWwwVC6o
         iK/7OVrHQ3ncVRC8kU+81hFzJx3BEklkdxaWjc3V3HA5DEi62dbFd2eMBYIPvzedTz
         hC7fg/Cv/KICQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: always show verbose warning for section mismatch
Date:   Fri,  1 Feb 2019 13:50:45 +0900
Message-Id: <1548996645-16962-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unless CONFIG_DEBUG_SECTION_MISMATCH is enabled, modpost only shows
the number of section mismatches.

If you want to know the symbols causing the issue, you need to rebuild
with CONFIG_DEBUG_SECTION_MISMATCH. It is tedious.

I think it is fine to show annoying warning when a new section mismatch
comes in.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.modpost |  1 -
 scripts/mod/modpost.c    | 27 +++++----------------------
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index c0b7f52..6b7f354 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -77,7 +77,6 @@ modpost = scripts/mod/modpost                    \
  $(if $(KBUILD_EXTMOD),-I $(modulesymfile))      \
  $(if $(KBUILD_EXTRA_SYMBOLS), $(patsubst %, -e %,$(KBUILD_EXTRA_SYMBOLS))) \
  $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
- $(if $(CONFIG_DEBUG_SECTION_MISMATCH),,-S)      \
  $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
  $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 26bf886..0b0d108 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -35,7 +35,6 @@ static int vmlinux_section_warnings = 1;
 static int warn_unresolved = 0;
 /* How a symbol is exported */
 static int sec_mismatch_count = 0;
-static int sec_mismatch_verbose = 1;
 static int sec_mismatch_fatal = 0;
 /* ignore missing files */
 static int ignore_missing_files;
@@ -1406,8 +1405,6 @@ static void report_sec_mismatch(const char *modname,
 	char *prl_to;
 
 	sec_mismatch_count++;
-	if (!sec_mismatch_verbose)
-		return;
 
 	get_pretty_name(from_is_func, &from, &from_p);
 	get_pretty_name(to_is_func, &to, &to_p);
@@ -1655,9 +1652,7 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	if (sec_mismatch_verbose)
-		report_extable_warnings(modname, elf, mismatch, r, sym,
-					fromsec, tosec);
+	report_extable_warnings(modname, elf, mismatch, r, sym, fromsec, tosec);
 
 	if (match(tosec, mismatch->bad_tosec))
 		fatal("The relocation at %s+0x%lx references\n"
@@ -2433,7 +2428,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awE")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:e:mnsT:o:awE")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2465,9 +2460,6 @@ int main(int argc, char **argv)
 		case 's':
 			vmlinux_section_warnings = 0;
 			break;
-		case 'S':
-			sec_mismatch_verbose = 0;
-			break;
 		case 'T':
 			files_source = optarg;
 			break;
@@ -2525,18 +2517,9 @@ int main(int argc, char **argv)
 	}
 	if (dump_write)
 		write_dump(dump_write);
-	if (sec_mismatch_count) {
-		if (!sec_mismatch_verbose) {
-			warn("modpost: Found %d section mismatch(es).\n"
-			     "To see full details build your kernel with:\n"
-			     "'make CONFIG_DEBUG_SECTION_MISMATCH=y'\n",
-			     sec_mismatch_count);
-		}
-		if (sec_mismatch_fatal) {
-			fatal("modpost: Section mismatches detected.\n"
-			      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
-		}
-	}
+	if (sec_mismatch_count && sec_mismatch_fatal)
+		fatal("modpost: Section mismatches detected.\n"
+		      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
 	free(buf.p);
 
 	return err;
-- 
2.7.4

