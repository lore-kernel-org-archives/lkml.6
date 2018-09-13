Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BBCC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010F920C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IUewTcuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010F920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIMN3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:29:17 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:24653 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIMN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:29:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w8D8Kjt5029037;
        Thu, 13 Sep 2018 17:20:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w8D8Kjt5029037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536826846;
        bh=DAH2jnP4F1CxRsadjmBKr7a+pDjBBesmYMZ3s8NkMmU=;
        h=From:To:Cc:Subject:Date:From;
        b=IUewTcuoxzHJHDrt+3QcPlnmKsoRDaDzGj3EMCXTFkoPTEoB7u5gvkhdFwaPE4LqF
         tC0MzBP7eYNG74+DM3VjRxmhZYBRLcktSCNCKg+2U9UmS87K0b+CyZN96r1S280fvS
         DS/igTuYvn/W4FfSWLIxxpiK3DEfnWWrdk3NkPbx6u/UeFldg7pfXToDs62lNYrla/
         QfYiM4SOXIX3vWwQAKwBjZjOeZA7FrC8vVaYsGahZfaTu7pQzvHJm8rdVfb7EwrkdT
         GhUzS/pZpoW8utMCYAOhBRwHIM/J4u/B3B/6JJ7BAWsPA46GFPWXGc3N7ks3hMt6Xt
         SWlERh7YzXFFA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unneeded link_multi_deps
Date:   Thu, 13 Sep 2018 17:20:41 +0900
Message-Id: <1536826841-4458-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c8589d1e9e01 ("kbuild: handle multi-objs dependency
appropriately"), $^ really represents all the prerequisite of the
composite object being built.

Hence, $(filter-out FORCE,$^) contains all the objects to link
together, which is much simpler than link_multi_deps calculation.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cb03774..d7fa203 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -485,28 +485,12 @@ targets += $(obj)/lib-ksyms.o
 
 endif
 
-#
-# Rule to link composite objects
-#
-#  Composite objects are specified in kbuild makefile as follows:
-#    <composite-object>-objs := <list of .o files>
-#  or
-#    <composite-object>-y    := <list of .o files>
-#  or
-#    <composite-object>-m    := <list of .o files>
-#  The -m syntax only works if <composite object> is a module
-link_multi_deps =                     \
-$(filter $(addprefix $(obj)/,         \
-$($(subst $(obj)/,,$(@:.o=-objs)))    \
-$($(subst $(obj)/,,$(@:.o=-y)))       \
-$($(subst $(obj)/,,$(@:.o=-m)))), $^)
-
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter-out FORCE,$^) $(cmd_secanalysis)
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(link_multi_deps); \
+	@{ echo $(@:.o=.ko); echo $(filter-out FORCE,$^); \
 	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
-- 
2.7.4

