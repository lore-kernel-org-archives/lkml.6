Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8202ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C02088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="NUen7gI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4C02088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeIRICX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:02:23 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33262 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeIRICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:02:22 -0400
Received: from localhost.localdomain (unknown [24.87.206.252])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 747D65C045D;
        Tue, 18 Sep 2018 04:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537237926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Qi8Ccmt0r7+/9ZfBFG1S0C59VGKyxUMlJg4TnVziE3Q=;
        b=NUen7gI6/465+gp2OlGdeI2waN+dAYjmF1Pt5553iJfClIURjb8AHmZqsqWreyhk6SxrXV
        myejhP7X64Wq4yIR/KtKOWBAFeeQAbH5mM55we+b7wfbInKHywAe0pTKRrrn58GIyTPqaH
        Rdpp9RN37DlH+X0vSdSZR+Nwk4mFTwo=
From:   Stefan Agner <stefan@agner.ch>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     ndesaulniers@google.com, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] kbuild: allow to use GCC toolchain not in Clang search path
Date:   Mon, 17 Sep 2018 19:31:57 -0700
Message-Id: <20180918023157.23951-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a GCC cross toolchain which is not in a compiled in
Clang search path, Clang reverts to the system assembler and
linker. This leads to assembler or linker errors, depending on
which tool is first used for a given architecture.

It seems that Clang is not searching $PATH for a matching
assembler or linker.

Make sure that Clang picks up the correct assembler or linker by
passing the cross compilers bin directory as search path.

This allows to use Clang provided by distributions with GCC
toolchains not in /usr/bin.

Link: https://github.com/ClangBuiltLinux/linux/issues/78
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Nick, I removed your Reviewed-by since I had to change variable
assignment slightly...

 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4d5c883a98e5..d5de2db4b549 100644
--- a/Makefile
+++ b/Makefile
@@ -495,13 +495,15 @@ endif
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN	:= $(realpath $(dir $(shell which $(LD)))/..)
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
+GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
-- 
2.19.0

