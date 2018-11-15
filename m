Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D29C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1CE223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1n/fyluE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1CE223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeKOSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:35:28 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50788 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:35:27 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHoe022794;
        Thu, 15 Nov 2018 17:27:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHoe022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270444;
        bh=c8ZdXLBNCXHefDwQ/cCwID3DrPEA1GhMAWsKRg379ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1n/fyluEv1Jy+qDU2a1EdK7oFAh96OhBAlXu5p2U14kXiZfLHGT3vxhdIicbD26ot
         Qf2lDPdW1jxq13zIxIAx5GUrtj/rSWxMoLc4ZVy4w1PjUmcgCYPshEhzZHtRROkscX
         ooWK0iHP/SobPz5si+KnCUDNOLiZd0V7h40xmN2a9/Mv8a1gAaCLkjbYWwSpR10g/a
         LiYbuomoLO90zs9FLlJt2Bf8J2HFlBaVQ2Zsjiy+VjV4d2cdBa3aIshVSxKaRM4J6v
         YvKR9gyr4M+EJNkUOCY2ZrEkcLbHh9KOlLBcy0KK0RlpsOuy7GZneT2/mLLQXIkmt0
         9xum95VKXKZig==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] kbuild: refactor if_changed and if_changed_dep
Date:   Thu, 15 Nov 2018 17:27:14 +0900
Message-Id: <1542270435-11181-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'@set -e; $(echo-cmd) $(cmd_$(1)' can be replaced with '$(cmd)'.
More cleanups.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 9 +++------
 scripts/Makefile.build | 4 ++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 5e47bf6..e4b77ef7 100644
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
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
 	rm -f $(depfile);                                                    \
 	mv -f $(dot-target).tmp $(dot-target).cmd;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 78e647f..0f28df2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -264,7 +264,7 @@ endif
 
 define rule_cc_o_c
 	$(call cmd,checksrc)
-	@$(call cmd_and_fixdep,cc_o_c)
+	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
 	$(call cmd,checkdoc)
 	$(call cmd,objtool)
@@ -273,7 +273,7 @@ define rule_cc_o_c
 endef
 
 define rule_as_o_S
-	@$(call cmd_and_fixdep,as_o_S)
+	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
 	$(call cmd,objtool)
 	$(call cmd,modversions_S)
-- 
2.7.4

