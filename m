Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0EAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706220811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2sk5z57m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0706220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeLKMCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:02:23 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:34039 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeLKMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:02:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBBC1w9Y007779;
        Tue, 11 Dec 2018 21:02:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBBC1w9Y007779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544529720;
        bh=JOz1NbW/eQCO86k0paK1LttJjfqJznbFcoz0vSbQd00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2sk5z57mVCjmkomfBvYnN4HY9u1Z9qK42vbmwRGKzhYsKtgJwuGmA23xdYVI6ozzq
         8jn1BL1wYYRV6qjJH4gAJzhxAJ7zhbOfJ6XfhTfEU22Bieg2wajMYd0ugstg1Mi4JH
         Seb2dPu4MdPq1EIxZ8fiDMWASLtKA9c1HnHGftyTLK10lzhCFhb4oiPVZ8dNprj9hW
         iL7uKvOV/KGlG8CRYgDXvQe6a9dPbhzPcoac55BxeN3kOVaFjiEpMDVkzHVm13CaEZ
         n4oXRnonvdHwJzjvGt86gaN0t4OgIeXoKGv5Di3NLM4HgZ/NhSAz6SFRCV5S2lODf4
         neT2gk4kQXtbQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: refactor quiet_modtag
Date:   Tue, 11 Dec 2018 21:01:54 +0900
Message-Id: <1544529716-4917-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

part-of-module and quiet_modtag are set for the same targets.
Define quiet_modtag based on part-of-module.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5a4fd82..f26ae45 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -98,18 +98,13 @@ modkern_cflags =                                          \
 	$(if $(part-of-module),                           \
 		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
-quiet_modtag := $(empty)   $(empty)
+quiet_modtag = $(if $(part-of-module),[M],   )
 
 $(real-obj-m)        : part-of-module := y
 $(real-obj-m:.o=.i)  : part-of-module := y
 $(real-obj-m:.o=.s)  : part-of-module := y
 $(real-obj-m:.o=.lst): part-of-module := y
 
-$(real-obj-m)        : quiet_modtag := [M]
-$(real-obj-m:.o=.i)  : quiet_modtag := [M]
-$(real-obj-m:.o=.s)  : quiet_modtag := [M]
-$(real-obj-m:.o=.lst): quiet_modtag := [M]
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
 
-- 
2.7.4

