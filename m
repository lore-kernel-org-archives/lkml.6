Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1421734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129371;
	bh=0EF8H51hN+6JbSpX72AshdXYdybVJGb527vm9KtDpsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPlw5eHOaU0b9DMleEyf47nDXHma9Dod2BZSgKWQNpRh9qTXrwg6Fnn7YoWM1bsmo
	 xlJ4V2PX+lskT8T07k7CiLlCyBB5rNn1lvx7sTiRnQ3Ah1Ch0KkTHfDz6GHhZctCLQ
	 MrCQL2tDRz3YrUDly0xutSJGCpIxfruTrrpvLQoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfBYVQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:16:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbfBYVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571002147C;
        Mon, 25 Feb 2019 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129364;
        bh=0EF8H51hN+6JbSpX72AshdXYdybVJGb527vm9KtDpsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HztIMB3gYdKca3D5Q35Z6aSmgIUeBgBT1DfAyNUOP9+BYaZx6IFdUQn9PXzGu4pEI
         Cw2KkQUXMWEAQu7lqSw/ERmTAOWVXRunHc3jv/KLyBRf8IBjZtxHCwxVuGs6hmAsBC
         U661V6mpoyAn8MMW77ihyeIZBRLUCKCeAKaZgBos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lin <dtwlin@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 50/63] kbuild: clang: fix build failures with sparse check
Date:   Mon, 25 Feb 2019 22:11:50 +0100
Message-Id: <20190225195039.660927513@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

From: David Lin <dtwlin@google.com>

commit bb3f38c3c5b759163e09b9152629cc789731de47 upstream.

We should avoid using the space character when passing arguments to
clang, because static code analysis check tool such as sparse may
misinterpret the arguments followed by spaces as build targets hence
cause the build to fail.

Signed-off-by: David Lin <dtwlin@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Backport to 4.9; adjust context]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -511,13 +511,13 @@ endif
 
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET	:= -target $(notdir $(CROSS_COMPILE:%-=%))
+CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
 CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
-CLANG_GCC_TC	:= -gcc-toolchain $(GCC_TOOLCHAIN)
+CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)


