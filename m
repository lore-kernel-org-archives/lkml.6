Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A06C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB11C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Elq1hhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB11C2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeKZVr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeKZVr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA8D2089F;
        Mon, 26 Nov 2018 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229653;
        bh=oD6eMPOW2UXVZ1f8g6xKZ17KGiHmZBPdc+zPy9XgUqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Elq1hhqeFtJQvBvFBsxxyqg2D7KzRT3WvUq1FbGRd4BDf3xvLMMwo+60v6LD+XQP
         MuwdqcT9CqUcXPkNmoXnTS5o2Wb/PiHkfnjdZ7oXiWEhXatG5OnAvwEfMLm7svu9OL
         KjP/RK1gc1L0y5lJZ/TyOcjS+oI/9X6gLNgBmuAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Fries <cfries@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 21/70] kbuild: Set KBUILD_CFLAGS before incl. arch Makefile
Date:   Mon, 26 Nov 2018 11:50:36 +0100
Message-Id: <20181126105048.863895905@linuxfoundation.org>
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

From: Chris Fries <cfries@google.com>

commit ae6b289a37890909fea0e4a1666e19377fa0ed2c upstream.

Set the clang KBUILD_CFLAGS up before including arch/ Makefiles,
so that ld-options (etc.) can work correctly.

This fixes errors with clang such as ld-options trying to CC
against your host architecture, but LD trying to link against
your target architecture.

Signed-off-by: Chris Fries <cfries@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Adjust context]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |   64 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -612,6 +612,38 @@ endif # $(dot-config)
 # Defaults to vmlinux, but the arch makefile usually adds further targets
 all: vmlinux
 
+ifeq ($(cc-name),clang)
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET	:= -target $(notdir $(CROSS_COMPILE:%-=%))
+GCC_TOOLCHAIN	:= $(realpath $(dir $(shell which $(LD)))/..)
+endif
+ifneq ($(GCC_TOOLCHAIN),)
+CLANG_GCC_TC	:= -gcc-toolchain $(GCC_TOOLCHAIN)
+endif
+KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
+KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+# Quiet clang warning: comparison of unsigned expression < 0 is always false
+KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
+# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
+# source of a reference will be _MergedGlobals and not on of the whitelisted names.
+# See modpost pattern 2
+KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
+KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
+else
+
+# These warnings generated too much noise in a regular build.
+# Use make W=1 to enable them (see scripts/Makefile.build)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+endif
+
 # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
 # values of the respective KBUILD_* variables
 ARCH_CPPFLAGS :=
@@ -697,38 +729,6 @@ endif
 endif
 KBUILD_CFLAGS += $(stackp-flag)
 
-ifeq ($(cc-name),clang)
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET	:= -target $(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN	:= $(realpath $(dir $(shell which $(LD)))/..)
-endif
-ifneq ($(GCC_TOOLCHAIN),)
-CLANG_GCC_TC	:= -gcc-toolchain $(GCC_TOOLCHAIN)
-endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
-KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
-KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
-# Quiet clang warning: comparison of unsigned expression < 0 is always false
-KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
-# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-# source of a reference will be _MergedGlobals and not on of the whitelisted names.
-# See modpost pattern 2
-KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
-KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
-else
-
-# These warnings generated too much noise in a regular build.
-# Use make W=1 to enable them (see scripts/Makefile.build)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-endif
-
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else


