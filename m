Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C9DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9397F20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQC96sZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9397F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeKZVsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbeKZVsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3384221104;
        Mon, 26 Nov 2018 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229671;
        bh=OuV3ndr8AfkbRV1w+ypQLTRDJtSvsDUVd8aGhZhKYrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQC96sZxJjmv8MYSosHqYkLqUr8MIthypLHiC3yDlStrZlQbNq5xUWKqIhFWB/BE6
         6IFjTsDgUDv8ROJrf4EQh3mjbv04/w/U+5WMoTCPYtpgRLkNCysy1xlplzv9NIR2Ce
         tAwGynh65oRCv6ZR+vmYNSbVMhAmOH8/zLWw0ugE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 27/70] kbuild: allow to use GCC toolchain not in Clang search path
Date:   Mon, 26 Nov 2018 11:50:42 +0100
Message-Id: <20181126105049.428730158@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit ef8c4ed9db80261f397f0c0bf723684601ae3b52 upstream.

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
Reviewed-and-tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Adjust context]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -610,13 +610,15 @@ all: vmlinux
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


