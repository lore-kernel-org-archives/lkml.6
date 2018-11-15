Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097E9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C380A223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N8hNiaRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C380A223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeKOSf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:35:27 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50789 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbeKOSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:35:27 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHoc022794;
        Thu, 15 Nov 2018 17:27:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHoc022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270443;
        bh=8FrQ1l+FIpNp9mhpnOeiNDDcSQOuKAHj3p0L9t8+oVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8hNiaRRiFBgErdtghyjjslsGX9+bFsMWLq9hawPuWHpGsV4v6kpjLi8eMOyLYBgv
         iPndDBblwjYqfkJfwREciKByA2i6KKLug405m9j2Gz/iyYPVK/H+BAxzpXDit2TxpS
         5efKazUxOgFyN5XztbGe/9sRU1pnRyCm4A5Qq2ePz3JH2E3/oYZtn1dLnIeCADWT0D
         HwFfNmEjUU13VtyVtXestrIsZoJFeENbMSt8XuETzxvzm4JL/NoZSGdPPUnV2bCBDT
         TyHuT7lQ4+usgBIgsAr3Ddt4/1JLgItL+9bn1jOHuKtwD5zuiocqBT9K8qLjRsHB0c
         i/b9I83zIcL8w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] kbuild: change if_changed_rule to accept multi-line recipe
Date:   Thu, 15 Nov 2018 17:27:12 +0900
Message-Id: <1542270435-11181-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU Make supports 'define' ... 'endef' directive, which can describe
a recipe that consists of multiple lines.

For example,

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
macro, keeping readability.

However, if_changed_rule cannot accept multi-line recipe. As you see
rule_cc_o_c and rule_as_o_S in scripts/Makefile.build, it must be
written like this:

  define rule_cc_o_c
          @[action1] ; \
          [action2] ; \
          [action3]
  endef

This does not actually exploit the benefits of 'define' ... 'endef'
form. All shell commands must be concatenated with '; \' so that it
looks like a single command from the Makefile point of view. '@' can
only appear before the first action.

The root cause of this misfortune is the '@set -e;' in if_changed_rule.
It is easily solvable by moving '@set -e' to the 'cmd' macro.

The combo of $(call echo-cmd,*) $(cmd_*) in rule_cc_o_c and rule_as_o_S
were replaced with $(call cmd,*). The tailing back-slashes went away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include |  6 ++----
 scripts/Makefile.build | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 1eafc85..5e47bf6 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -215,7 +215,7 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)
 
 # printing commands
-cmd = @$(echo-cmd) $(cmd_$(1))
+cmd = @set -e; $(echo-cmd) $(cmd_$(1))
 
 # Add $(obj)/ for paths that are not absolute
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
@@ -269,9 +269,7 @@ cmd_and_fixdep =                                                             \
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
index e5ba9b1..5528a6a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,20 +263,20 @@ cmd_gen_ksymdeps = \
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

