Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D32C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F1E223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U3nnIbei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F1E223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeKOSfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:35:30 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50851 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeKOSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:35:29 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHoa022794;
        Thu, 15 Nov 2018 17:27:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHoa022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270441;
        bh=PBijk1TstCcY2Qd0zD8K3u/nFfD9XogJ71hEHg31xVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3nnIbeiYG0AijrOiIzW3RG2IUid2ktDJz7b2m/0TIl0gyjg4s6rPleaOfI+IGRDZ
         w33zfwMon9Klr9VXt0UdZgkpBSqirwLpTk850/SMJ9c9mObvcG2L/LOIN5566n/x0C
         WbjrGMWNETRqoQF73OnD2hAom2csJMxAJ0svpSxAigGvPjVmH5ipCVUTo9loSim3Hp
         NHZm7XVKOOsPwAIOsNK+mtoKb/+/ejPeJ0U9i8gpGVmvmSDZ91wrO3HdzT64A08yLh
         VAUKQRvZJAZ1p3g/0SJw79o6Mj5U55rIyGLaavcn3bXlwMGQ5e5lgl64LZocZ/SSIP
         /idLQlyj41y3g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] kbuild: refactor modversions build rules
Date:   Thu, 15 Nov 2018 17:27:10 +0900
Message-Id: <1542270435-11181-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let $(CC) compile objects into normal files *.o instead of .tmp_*.o
whether CONFIG_MODVERSIONS is enabled or not. This will help simplify
build rules a lot.

I guess the reason of using .tmp_*.o for intermediate objects was
to avoid leaving incomplete *.o file (, whose timestamp says it is
up-to-date) when the genksyms tool failed for some reasons.

It no longer matters because any targets are deleted on errors since
commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special target").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 54 ++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7af21a8..7f3ca6e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -154,35 +154,30 @@ $(obj)/%.ll: $(src)/%.c FORCE
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
+      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
-ifndef CONFIG_MODVERSIONS
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
-
-else
+ifdef CONFIG_MODVERSIONS
 # When module versioning is enabled the following steps are executed:
-# o compile a .tmp_<file>.o from <file>.c
-# o if .tmp_<file>.o doesn't contain a __ksymtab version, i.e. does
-#   not export symbols, we just rename .tmp_<file>.o to <file>.o and
-#   are done.
+# o compile a <file>.o from <file>.c
+# o if <file>.o doesn't contain a __ksymtab version, i.e. does
+#   not export symbols, it's done.
 # o otherwise, we calculate symbol versions using the good old
 #   genksyms on the preprocessed source and postprocess them in a way
 #   that they are usable as a linker script
-# o generate <file>.o from .tmp_<file>.o using the linker to
+# o generate .tmp_<file>.o from <file>.o using the linker to
 #   replace the unresolved symbols __crc_exported_symbol with
 #   the actual value of the checksum generated by genksyms
-
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
+# o remove .tmp_<file>.o to <file>.o
 
 cmd_modversions_c =								\
-	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
+	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
 		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
-	else									\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
+		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
 	fi;
 endif
 
@@ -241,19 +236,12 @@ ifneq ($(RETPOLINE_CFLAGS),)
 endif
 endif
 
-
-ifdef CONFIG_MODVERSIONS
-objtool_o = $(@D)/.tmp_$(@F)
-else
-objtool_o = $(@)
-endif
-
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
 cmd_objtool = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
-	$(__objtool_obj) $(objtool_args) "$(objtool_o)";)
+	$(__objtool_obj) $(objtool_args) $@;)
 objtool_obj = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
 	$(__objtool_obj))
@@ -357,34 +345,26 @@ $(obj)/%.s: $(src)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
+      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
 
-ifndef CONFIG_MODVERSIONS
-cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
-
-else
+ifdef CONFIG_MODVERSIONS
 
 ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
 
-ifeq ($(ASM_PROTOTYPES),)
-cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
-
-else
+ifneq ($(ASM_PROTOTYPES),)
 
 # versioning matches the C process described above, with difference that
 # we parse asm-prototypes.h C header to get function definitions.
 
-cmd_as_o_S = $(CC) $(a_flags) -c -o $(@D)/.tmp_$(@F) $<
-
 cmd_modversions_S =								\
-	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
+	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
 		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
-	else									\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
+		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
 	fi;
 endif
 endif
-- 
2.7.4

