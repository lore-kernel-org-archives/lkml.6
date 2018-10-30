Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689F9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB6720823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZctKWaID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB6720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeJ3NYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 09:24:44 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:56537 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3NYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 09:24:44 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w9U4WnvQ003100;
        Tue, 30 Oct 2018 13:32:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w9U4WnvQ003100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540873970;
        bh=+8ddtq0AgqiqOK40ie+JuQepMzfAFUIpNeNrg5kFe4U=;
        h=From:To:Cc:Subject:Date:From;
        b=ZctKWaIDDiJa3BrrCWXR8I2TQhVdiGm89pQmfB+t1dqka3HF5MYIX9RMHafynBGay
         EBz03ZKl63pl8brNMA04o7rjxg20+eNr5U+xuyxBn/UhDdl5qXOOhhI8OlOPs5Wc8G
         Bi3IFHTtZIETu2+Sb3qcbj/h/OAcblscxCwc/NyZ9exl9wQr5zEaVQxyh1l5wcY9Iv
         GmhMGHIMUvdmzbAoRopK5aPNIMBdumtCtZ87I3Mj5rflCfwRMiEnxsRNpKNqh+Lj+r
         cTXSPGfxmoZD56XXP5WQyTbRK+266jtdJ9qYqczHIj00zHKM4gNpK7VgSjqbilF248
         dnH3OCAHIUBFg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: consolidate single targets
Date:   Tue, 30 Oct 2018 13:32:45 +0900
Message-Id: <1540873965-31342-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of specifying target/source pairs, let's list patterns that we
want to handle as single targets. This slightly changes the behavior;
the top Makefile previously checked the presence of a source file,
now Kbuild will descend into a subdirectory anyway to find out what to
do there.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index be76e6e..7d13add 100644
--- a/Makefile
+++ b/Makefile
@@ -1713,21 +1713,7 @@ else
         target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
 endif
 
-%.s: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.i: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.lst: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.s: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.symtypes: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.ll: %.c prepare scripts FORCE
+%.i %.ll %.lst %.o %.s %.symtypes: prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
-- 
2.7.4

