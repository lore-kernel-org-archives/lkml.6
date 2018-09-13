Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F8C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4836F20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j0MC+NzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4836F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIMPcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:32:10 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:27327 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:32:10 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8DAMuJx018403;
        Thu, 13 Sep 2018 19:22:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8DAMuJx018403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536834176;
        bh=QI2N3IFuRCZED84BU1g8XaN0yVydGAH6pDRgc4iDc+8=;
        h=From:To:Cc:Subject:Date:From;
        b=j0MC+NzAgYR4ZL4sG3k5W1HvecFez9B8p+Dj4/OxusKQYbrbRT1K2dvJ3DUMP7Ei2
         Q1hVZHnZRPql7RaUl2uXi40edG3Hg5cUrms65LCiKh69aXonU69Gm05igW68LQdDD/
         LBttBvkFDuitWxC1w9OrbvzP3ZYa432+oMAu6fQqj80s8NdtXN5gM2+ZKtpNIP4W0n
         hyj8QrKzHNBB2XXzTtCNKyePS5fYQjRC4227yExjn0DzUl+yaAN9mvgKY6iEzkXfrB
         QIpkdOPmcjlfsMICt4QDQFt3jab778qGeBEhKfUHbFC3Pth4TX9WShBzop17/HLImy
         Ky7EMXt4UEIPg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add --include-dir flag only for out-of-tree build
Date:   Thu, 13 Sep 2018 19:22:54 +0900
Message-Id: <1536834174-31857-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --include-dir flag is used to include check-in Makefiles from
$(objtree) without prefixing $(srctree)/ the paths.  Obviously, this
is unnecessary for in-tree build.  Add the flag just before changing
the working directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index f8c8e12..8f563a6 100644
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
+# (this increases performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -rR
 
 # Avoid funny character set dependencies
 unexport LC_ALL
@@ -136,6 +135,9 @@ KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))
 
+# Look for make include files relative to root of kernel src
+MAKEFLAGS += --include-dir=$(CURDIR)
+
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
-- 
2.7.4

