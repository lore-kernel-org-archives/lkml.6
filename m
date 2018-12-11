Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B30C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A980720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AbzUkXpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A980720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeLKMCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:02:14 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:34041 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeLKMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:02:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBBC1w9Z007779;
        Tue, 11 Dec 2018 21:02:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBBC1w9Z007779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544529721;
        bh=VY6PS7A6EyULkYhFUtP89rFGqR6EiqSvhhdTmpWHtDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbzUkXpt5AmZw+OJoOEqKY4bbw5I5vvZmwyI0EwanhUct+XIGOlAwH1Ixw+KZkJeE
         WGp8b5A+Tdo6WipryQjXY3qXwVCotwppQVYv3Et5Rgff5bhoQtN3qlC9g8AC75c34h
         u+ampOWy/WFByNkDAD9db7dzKzVtI++ZOwdBCUpS9DaugJmHygnAc2z5pPaMpsM85P
         dV54uPQ3Q9SpGxwnDJDf/c1qSPjltZ3+hO8IwgK9Y3s394a8bBnIqVGAu3f49ZPc7T
         a2NVy2f9dfATSwSUtRbSSvib01P+mjC4bTmROvHz/N2ZZl+nhPVLaquIMUOa+jdWlp
         LoSf22sah5qWA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kbuild: refactor part-of-module
Date:   Tue, 11 Dec 2018 21:01:55 +0900
Message-Id: <1544529716-4917-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use $(foreach ...) to make it shorter.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f26ae45..321b5b7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -94,17 +94,15 @@ endif
 # ---------------------------------------------------------------------------
 
 # Default is built-in, unless we know otherwise
+$(foreach x, i lst o s, $(patsubst %.o,%.$(x),$(real-obj-m))): \
+	part-of-module := y
+
 modkern_cflags =                                          \
 	$(if $(part-of-module),                           \
 		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
 quiet_modtag = $(if $(part-of-module),[M],   )
 
-$(real-obj-m)        : part-of-module := y
-$(real-obj-m:.o=.i)  : part-of-module := y
-$(real-obj-m:.o=.s)  : part-of-module := y
-$(real-obj-m:.o=.lst): part-of-module := y
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
 
-- 
2.7.4

