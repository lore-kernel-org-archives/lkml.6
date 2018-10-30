Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6D4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCED22080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OAWy3IiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCED22080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeJ3WUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:22 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:36013 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJ3WUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:22 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w9UDQcm1022568;
        Tue, 30 Oct 2018 22:26:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w9UDQcm1022568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540906000;
        bh=LNpy0b2pnDbhrESvdThnUfN4u4lmwWr9TyRdmOYtwMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAWy3IiXdtLNCurQ6U54FR32CAYLwHQT0bLizVWRszrWlSRKs49QEAl0Ns7zGVGZ3
         BcFA20NH8AT8dPeBhdTLUlwzVFf0VgI77ekIus0nbxFabZtYHyVStn/gnL9pZtTYT9
         rlY2og1GzDfWZmas1NFG4lt6C4uQPnlwSIwLj4KGHZdpYmJfTGyDo5avlm1irqK42P
         2jQhZSeBV3+nZCKqcJrLOrEC4cEmrPpB9WZYgOUol7MVjT4IVsfYvOJPKjC9DadwP+
         lr9M5ytiuT4GDeMQ41059kEX2JAaGOJO7DJCs7aPTq9XQG0RFBByxkHY6pXijVYAg/
         MRlmmwgSJNBpA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: remove cc-name variable
Date:   Tue, 30 Oct 2018 22:26:34 +0900
Message-Id: <1540905994-6073-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
References: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one more user of $(cc-name) in the top Makefile. It is supposed
to detect Clang before invoking Kconfig, so it should still be there
in the $(shell ...) form. All the other users of $(cc-name) have been
replaced with $(CONFIG_CC_IS_CLANG). Hence, scripts/Kbuild.include does
not need to define cc-name any more.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile               | 2 +-
 scripts/Kbuild.include | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 1c0696d..25b1518 100644
--- a/Makefile
+++ b/Makefile
@@ -485,7 +485,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
 endif
 
-ifeq ($(cc-name),clang)
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ca21a35..51703ae 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -140,10 +140,6 @@ cc-option-yn = $(call try-run,\
 cc-disable-warning = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
-# cc-name
-# Expands to either gcc or clang
-cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
-
 # cc-version
 cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
-- 
2.7.4

