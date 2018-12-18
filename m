Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62B4214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t4H5J+WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeLRF0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:26:32 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:59785 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeLRF0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:26:31 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wBI5PoZA030731;
        Tue, 18 Dec 2018 14:25:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wBI5PoZA030731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545110751;
        bh=WhkTIvnxrA5Lys7ML7oerDPj21OzgOyOFM6M3SRkHao=;
        h=From:To:Cc:Subject:Date:From;
        b=t4H5J+WPWqoXvf2Ha5nwqAQEXDYAg3OkpZt/GhwZbxJQemC5UYsnWJgflCUX+R5+E
         V2Bq7uM4708naZmMbT3qKW9alVE3304bOnucYT6vW7NG88YyhsUO14aWrl0hp6U1aK
         SQKHpaFvzKTlt/8ntrQ+LOLUNSwE/8bdXBq13S5q15hPVa7baLb0F3luZZt5s4hNLV
         oTCmy/ElNiGGB62LIPaR1b9Q1p5DqS9Y1kysLDc1dlmneyt9Dfk8XhIFw4IB2B/I/8
         1PnKYJqU3y9nH6e7ZTvjvhTRpCY5nRdJuiunhRDKrBLuBMpvfuTGPe2FJUTFk8RQ9u
         mCHEglNA+rmcw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Qian Cai <cai@lca.pw>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix false positive warning/error about missing libelf
Date:   Tue, 18 Dec 2018 14:25:41 +0900
Message-Id: <1545110741-10761-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the same reason as commit 25896d073d8a ("x86/build: Fix compiler
support check for CONFIG_RETPOLINE"), you cannot put this $(error ...)
into the parse stage of the top Makefile.

Perhaps I'd propose a more sophisticated solution later, but this is
the best I can do for now.

Link: https://lkml.org/lkml/2017/12/25/211
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Reported-by: Qian Cai <cai@lca.pw>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 56d5270..d45856f 100644
--- a/Makefile
+++ b/Makefile
@@ -962,11 +962,6 @@ ifdef CONFIG_STACK_VALIDATION
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
-    ifdef CONFIG_UNWINDER_ORC
-      $(error "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    else
-      $(warning "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    endif
     SKIP_STACK_VALIDATION := 1
     export SKIP_STACK_VALIDATION
   endif
@@ -1125,6 +1120,14 @@ uapi-asm-generic:
 
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
+ifeq ($(SKIP_STACK_VALIDATION),1)
+ifdef CONFIG_UNWINDER_ORC
+	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@false
+else
+	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+endif
+endif
 
 # Generate some files
 # ---------------------------------------------------------------------------
-- 
2.7.4

