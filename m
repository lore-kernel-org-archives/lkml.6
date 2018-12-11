Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC276C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1D220879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543445;
	bh=4fhViiN05nR16OazEeURpjkM6Vr1hTSEG+salskgrNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ibx7jjLEr2YC6549SAtPaVjKJRf/pRp9QKoYUQ2kt9hK8P4rXFdf/zbUopA33jtqO
	 iLTir4Yt1/B6wqDXXPEjZJ1YAXafIToSzj9LXf04sd3+ColvXEa3nbk8RK/G9NvuQQ
	 XhPJLhthYEqs20YRcJC6iyM1VbH6BL2Pf6HapObM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1D220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeLKPuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbeLKPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97BEF20879;
        Tue, 11 Dec 2018 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543440;
        bh=4fhViiN05nR16OazEeURpjkM6Vr1hTSEG+salskgrNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yChrc2+lx7+xoZ7bcv3MzS+x7nt8yGaeUZ4J1BpirGn2ToPW7/BhgqPzno01EVJWv
         48i/mrk4zB3XC12CX/N7JZqGouxghQbz40PbFMQdLl+XPkh2IJAjh1OVq9M4AyWr+6
         uOT2ggt2jVHCaT1t+w/vmqdfQQu3Cd4YBMQRJMJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 51/51] kbuild: allow to use GCC toolchain not in Clang search path
Date:   Tue, 11 Dec 2018 16:41:59 +0100
Message-Id: <20181211151618.613973113@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

(commit ef8c4ed9db80261f397f0c0bf723684601ae3b52 upstream)

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
[ND: adjusted to context, due to adjusting the context of my previous
backport of upstream's ae6b289a3789]
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -512,13 +512,15 @@ endif
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= -target $(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN	:= $(realpath $(dir $(shell which $(LD)))/..)
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
+GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_GCC_TC	:= -gcc-toolchain $(GCC_TOOLCHAIN)
 endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)


