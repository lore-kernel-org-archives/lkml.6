Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE0C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0842020861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0Pa78A/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0842020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeINLqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:46:35 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:31994 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeINLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:46:35 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8E6XR4X027457;
        Fri, 14 Sep 2018 15:33:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8E6XR4X027457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536906808;
        bh=sNYJNwxQn2ji5PU7VgX3O1LuSS4Scj+ZO1y5I/Ok0o0=;
        h=From:To:Cc:Subject:Date:From;
        b=0Pa78A/qUQi6HlgL9ldUIuiPNloO71YFuMw4D5f+4AH6Vj2F1wSYdeXOhdJjNR01X
         eEMfVgpH4UUig8lQgLYav5LNDBAFuayWuc6U+2qfpFxNcvdOCshT2SqDhq7ygqnuMy
         YeD7jmfqPfWn5giktd4U+GuMoYwJvYu8Qn7sdueJut2fjW3U5m7ktG+RvjSpTxNPG0
         pMIRQq0gh3khFh69r7M4BYOguqe0gqfVe+pUlT2zdNjUnrYXd3+T5HA8z9TDCXOLK0
         kDy8ZdH+AH2sSzQHRcFlrD2cgM07xyl6eblJyH2Awctv+KrnlK2VH/rlOODMryudkN
         fKRGSTzMGwjnA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: add --include-dir flag only for out-of-tree build
Date:   Fri, 14 Sep 2018 15:33:23 +0900
Message-Id: <1536906803-29741-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --include-dir flag is used to include check-in Makefiles from
$(objtree) without $(srctree)/ prefix.  Obviously, this is unneeded
for in-tree build.  Add the flag just before changing the working
directory.

This becomes effective after invoking sub-make.  Add a little bit
comments about it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add some more comments

 Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index f8c8e12..233b57d 100644
--- a/Makefile
+++ b/Makefile
@@ -15,10 +15,9 @@ NAME = Merciless Moray
 PHONY := _all
 _all:
 
-# o Do not use make's built-in rules and variables
-#   (this increases performance and avoids hard-to-debug behaviour);
-# o Look for make include files relative to root of kernel src
-MAKEFLAGS += -rR --include-dir=$(CURDIR)
+# Do not use make's built-in rules and variables
+# (this increases performance and avoids hard-to-debug behaviour)
+MAKEFLAGS += -rR
 
 # Avoid funny character set dependencies
 unexport LC_ALL
@@ -136,6 +135,13 @@ KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))
 
+# Look for make include files relative to root of kernel src
+#
+# This does not become effective immediately because MAKEFLAGS is re-parsed
+# once after the Makefile is read.  It is OK since we are going to invoke
+# 'sub-make' below.
+MAKEFLAGS += --include-dir=$(CURDIR)
+
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
-- 
2.7.4

