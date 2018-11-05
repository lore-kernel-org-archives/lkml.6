Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3281DC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794AC2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QGH7Kwim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794AC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeKEMGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:06:54 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:41736 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKEMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:06:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wA52mU1V012868;
        Mon, 5 Nov 2018 11:48:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wA52mU1V012868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541386111;
        bh=ZNPtY1nokON8YRdoIZP15e0YeCWOC3ApGvYS4fHPVfc=;
        h=From:To:Cc:Subject:Date:From;
        b=QGH7KwimQO1PS9YhHzH7SndjlRYV7Iy10BdUWfP3FFNI8QioXzZHgB/TxDzisx98+
         lJQO5g72bsEKj7w4X51Qgd2Py2B+Y39pF0L7Zb/3QO6T6pzERz1fVI8JW1yYVq20FK
         UP5zuMyqLKrhZjDhkbcAjWlkCUVIPktVLGOpYsH+2+SgJU0n3IUkxcFbSTRdr3juQI
         3b0F6/OMqtTHj7o2XD9dZh0vkGbzY1PAIIqyW1nTdjGHr8zmWcb6VhQIYLXXqaXftS
         oqlKmHjuS0SQ7u/ueSsiPUtXDGcH6qjT1kEf/cnApt+FI5puyPZ5vhAPu5IKrE6ByW
         TCnN9/yIxQwUQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chris Fries <cfries@google.com>, Joel Stanley <joel@jms.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: consolidate Clang compiler flags
Date:   Mon,  5 Nov 2018 11:48:19 +0900
Message-Id: <1541386099-13118-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic options for Clang such as --target, --prefix, --gcc-toolchain,
-no-integrated-as to a single variable CLANG_FLAGS.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 93315eb..58c838a 100644
--- a/Makefile
+++ b/Makefile
@@ -487,18 +487,17 @@ endif
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
+CLANG_FLAGS	= --target=$(notdir $(CROSS_COMPILE:%-=%))
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
-CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
-CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
+CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
+CLANG_FLAGS	+= $(call cc-option, -no-integrated-as)
+KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
-- 
2.7.4

