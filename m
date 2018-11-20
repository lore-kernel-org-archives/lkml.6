Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B48C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F9F2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UEo/OL5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F9F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeKTLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:33:21 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:34065 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbeKTLdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:33:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAK15ZEd029284;
        Tue, 20 Nov 2018 10:05:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAK15ZEd029284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542675941;
        bh=NMzBvf7Uf/mcroQkxmHDTE9wi2Zk1t9cWFR9t5jzbfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEo/OL5T0IkD8dM6AYpu2WlSsebYq5WBxvpsz74pZwcfpSxJAyOR+s8U5ueThtKbq
         qbxfRCRqBXN/a38zfvxt1sA8qeEwQj5f76bk2HW0QEITeG43IcGmah9h7E/AMWpluP
         Hcd9vVpItWq8cZtbeoi5ZT/ylClPSbpb5tizeIZJw6rzhGU8/3EVp/WqQGFiygry89
         HJY3EfgTYfgLJUa4tdqpZukBCvBFjRPauVJyKoX3rE40BqArs9/nIJ65lXmznDF6hc
         X9cbQOk1jOB4VLXcqciWuKkT3L6bZF3QvVFTKaVB0OROW2mFN0G0Y1CZiEEmUfx4qJ
         GZ9VFRpkFmOCg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] kbuild: change if_changed_rule for multi-line recipe
Date:   Tue, 20 Nov 2018 10:05:27 +0900
Message-Id: <1542675930-21114-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'define' ... 'endef' directive can describe a recipe that consists
of multiple lines. For example,

    all:
            @echo hello
            @echo world

... can be written as:

    define greeting
            @echo hello
            @echo world
    endif

    all:
            $(greeting)

This is useful to confine a series of shell commands into a single
macro without losing readability.

However, rule_cc_o_c and rule_as_o_S in scripts/Makefile.build are
written like this (with a trailing semicolon in each cmd_*):

  define rule_cc_o_c
          [action1] ; \
          [action2] ; \
          [action3] ;
  endef

All shell commands are concatenated with '; \' so that it looks like
a single command from the Makefile point of view. This does not
exploit the benefits of 'define' ... 'endef' form because a single
shell command can be simply written, like this:

  rule_cc_o_c = \
          [action1] ; \
          [action2] ; \
          [action3] ;

I guess the intention for the command concatenation was to let the
'@set -e' in if_changed_rule cover all the commands.

We can improve the readability by moving '@set -e' to the 'cmd' macro.
The combo of $(call echo-cmd,*) $(cmd_*) in rule_cc_o_c and rule_as_o_S
have been replaced with $(call cmd,*). The trailing back-slashes have
been removed.

Here is a note about the performance: the commands in rule_cc_o_c and
rule_as_o_S were previously executed all together in a single subshell,
but now each line in a separate subshell. This means Make will spawn
extra subshells [1]. I measured the build performance for
  x86_64_defconfig + CONFIG_MODVERSIONS + CONFIG_TRIM_UNUSED_KSYMS
and I saw slight performance regression, but I believe code readability
and maintainability wins.

[1] Precisely, GNU Make may optimize this by executing the command
    directly instead of forking a subshell, if no shell special
    characters are found in the command line and omitting the subshell
    will not change the behavior.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rewrite commit message more precisely, and mention about the
    build performance

 scripts/Kbuild.include |  6 ++----
 scripts/Makefile.build | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 4b943f4..978d72b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -215,7 +215,7 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)
 
 # printing commands
-cmd = @$(echo-cmd) $(cmd_$(1))
+cmd = @set -e; $(echo-cmd) $(cmd_$(1))
 
 # Add $(obj)/ for paths that are not absolute
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
@@ -268,9 +268,7 @@ cmd_and_fixdep =                                                             \
 # Usage: $(call if_changed_rule,foo)
 # Will check if $(cmd_foo) or any of the prerequisites changed,
 # and if so will execute $(rule_foo).
-if_changed_rule = $(if $(strip $(any-prereq) $(arg-check) ),                 \
-	@set -e;                                                             \
-	$(rule_$(1)), @:)
+if_changed_rule = $(if $(strip $(any-prereq) $(arg-check)), $(rule_$(1)), @:)
 
 ###
 # why - tell why a target got built
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c23ee45..e445b3e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -260,20 +260,20 @@ cmd_gen_ksymdeps = \
 endif
 
 define rule_cc_o_c
-	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
-	$(call cmd_and_fixdep,cc_o_c)					  \
-	$(cmd_gen_ksymdeps)						  \
-	$(cmd_checkdoc)							  \
-	$(call echo-cmd,objtool) $(cmd_objtool)				  \
-	$(cmd_modversions_c)						  \
-	$(call echo-cmd,record_mcount) $(cmd_record_mcount)
+	$(call cmd,checksrc)
+	@$(call cmd_and_fixdep,cc_o_c)
+	$(call cmd,gen_ksymdeps)
+	$(call cmd,checkdoc)
+	$(call cmd,objtool)
+	$(call cmd,modversions_c)
+	$(call cmd,record_mcount)
 endef
 
 define rule_as_o_S
-	$(call cmd_and_fixdep,as_o_S)					  \
-	$(cmd_gen_ksymdeps)						  \
-	$(call echo-cmd,objtool) $(cmd_objtool)				  \
-	$(cmd_modversions_S)
+	@$(call cmd_and_fixdep,as_o_S)
+	$(call cmd,gen_ksymdeps)
+	$(call cmd,objtool)
+	$(call cmd,modversions_S)
 endef
 
 # List module undefined symbols (or empty line if not enabled)
-- 
2.7.4

