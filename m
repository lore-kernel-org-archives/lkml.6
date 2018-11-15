Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A214A21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VDKyVGxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A214A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeKOSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:35:26 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50702 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeKOSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:35:24 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHod022794;
        Thu, 15 Nov 2018 17:27:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHod022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270443;
        bh=o1GWGIaipR/X6q6oCdm15fafbmJ3OCU4vDv1Nw3MR5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDKyVGxdLyw9eym5gQaPCvZTugbjMOXG4XeNgDYiFQjR4lrROBUvlhfwUHAymFKwu
         qI/uYoxSKnceoGrLsbi2raUr3pSwQzfjtWbFOVC620ytnZNTvDReuewJsZlVS7BXni
         WJari73F6Mr3xOEcHfSC7XDwmibmnJwSlmW4qp5TWiOkoKyWNNpJ/IIXp3tlRWv4Ab
         SqhjjiqS7aP51Gkbwb6ZeM4xpEaYY9/2y7zzlp7EdC2TFq3VrGKainvvuyoKyP27qR
         KCUIlNaxCB8IdYG9YcRbmFAcrDUTOsU9tlH2cTJ0Iq93Sv4odw5PgLoPvh4mAsNlGI
         K+HYGu3opazHA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
Date:   Thu, 15 Nov 2018 17:27:13 +0900
Message-Id: <1542270435-11181-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All commands passed into rule_cc_o_c / rule_as_o_S needed to end with
a semicolon because the old if_changed_rule implementation only
accepted a single shell command. To pass in multiple shell commands,
they must be concatenated with '; \'.

With the if_changed_rule change in the last commit, this restriction
does not exist any more. Rip off unneeded semicolons.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5528a6a..78e647f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -75,14 +75,14 @@ __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 # Linus' kernel sanity checking tool
 ifeq ($(KBUILD_CHECKSRC),1)
   quiet_cmd_checksrc       = CHECK   $<
-        cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+        cmd_checksrc       = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 else ifeq ($(KBUILD_CHECKSRC),2)
   quiet_cmd_force_checksrc = CHECK   $<
-        cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+        cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif
 
 ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $< ;
+  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
 endif
 
 # Do section mismatch analysis for each module/built-in.a
@@ -178,7 +178,7 @@ cmd_modversions_c =								\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
 		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
-	fi;
+	fi
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
@@ -211,7 +211,7 @@ cmd_record_mcount =						\
 	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
-	fi;
+	fi
 endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
@@ -241,7 +241,7 @@ endif
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
 cmd_objtool = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
-	$(__objtool_obj) $(objtool_args) $@;)
+	$(__objtool_obj) $(objtool_args) $@)
 objtool_obj = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
 	$(__objtool_obj))
@@ -258,7 +258,7 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
 	cat $(dot-target).tmp >> $(dot-target).cmd; \
-	rm -f $(dot-target).tmp;
+	rm -f $(dot-target).tmp
 
 endif
 
@@ -375,7 +375,7 @@ cmd_modversions_S =								\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
 		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
-	fi;
+	fi
 endif
 endif
 
-- 
2.7.4

