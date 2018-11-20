Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE20C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524D620851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nXgMWnSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524D620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbeKTLdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:33:12 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:34012 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKTLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:33:12 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAK15ZEf029284;
        Tue, 20 Nov 2018 10:05:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAK15ZEf029284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542675942;
        bh=KJmwS6MbYmJ1WbmfGLl6TuhqELJgJCDBAtGlg+95JGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXgMWnSZXCm7DOHBeK1+o4teEQZLXLHIZ6tS8ULeZzehT4aj0ZUo5eZNiISx//iBS
         RGRTsi5emiE2Z7VA34Sc+obY8UFQcL3F1Wn/Rb4UJseZCai4Fw05g/8/Ge9fJMv8Em
         xD05gxVIpc8I8ZBkzfZJ/hEfsBpQbn9PuSAOyDu2nzNohUH5vKH9sSuerjOVlROQHa
         adGokQ4XhBZ4hEzZv1fk7ewlJAQUO1MmT+Z/FKTUIWenTguVIMwh/H0veSEp6xHO0q
         tPat9sKtnH42Lyg/8vK/Usxb78mmRpp44zJPvbYWvrCr9rccgM72kPCQdgDCgHo5Ga
         slYmvTs4Wn7hw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] kbuild: refactor if_changed and if_changed_dep
Date:   Tue, 20 Nov 2018 10:05:29 +0900
Message-Id: <1542675930-21114-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'@set -e; $(echo-cmd) $(cmd_$(1)' can be replaced with '$(cmd)'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Kbuild.include | 9 +++------
 scripts/Makefile.build | 4 ++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 79c4875..33aacca 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -251,17 +251,14 @@ any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
 
 # Execute command if command has changed or prerequisite(s) are updated.
 if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
-	@set -e;                                                             \
-	$(echo-cmd) $(cmd_$(1));                                             \
+	$(cmd);                                                              \
 	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Execute the command and also postprocess generated .d dependencies file.
-if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
-	@set -e;                                                             \
-	$(cmd_and_fixdep), @:)
+if_changed_dep = $(if $(strip $(any-prereq) $(arg-check)), $(cmd_and_fixdep), @:)
 
 cmd_and_fixdep =                                                             \
-	$(echo-cmd) $(cmd_$(1));                                             \
+	$(cmd);                                                              \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
 	rm -f $(depfile)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ffd2fe4..3bad2aa 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -261,7 +261,7 @@ endif
 
 define rule_cc_o_c
 	$(call cmd,checksrc)
-	@$(call cmd_and_fixdep,cc_o_c)
+	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
 	$(call cmd,checkdoc)
 	$(call cmd,objtool)
@@ -270,7 +270,7 @@ define rule_cc_o_c
 endef
 
 define rule_as_o_S
-	@$(call cmd_and_fixdep,as_o_S)
+	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
 	$(call cmd,objtool)
 	$(call cmd,modversions_S)
-- 
2.7.4

