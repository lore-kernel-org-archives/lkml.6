Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B15C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CED72173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129340;
	bh=OCx9Jm8c075w0xZHlZFPWxI7GkJNr5AB0aA9fTX1Xyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dcsvawcogcfv9LJHKHNcBXXtt1vdfEfneQPE7ejWwQomX1z3QF6Kx0pbEH7bcSpd+
	 M2TunFcPFDWhqb2PjAJNTsjRcZ6sLgeNEW2YEapGJwbD0IclEHab6t2Jrilp4qf/MR
	 STRE3u4/sR38eGR6tPmX0SShrPTF9RGYMlkAWdnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfBYVPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbfBYVPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA7B2173C;
        Mon, 25 Feb 2019 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129336;
        bh=OCx9Jm8c075w0xZHlZFPWxI7GkJNr5AB0aA9fTX1Xyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqH2b8/Q19n4xGjdKdv+biBjnI3bCQAE+b66RtBAxookUp/mhjpTN/rtKEBqlGEN/
         3fh+E37EDnezsadwPRcd1/E3toS/MSv00n6KtGv7ynd0ve3GRC2YRSNoVJKR7Jbvhg
         BiGxdfAdZs+wkkvXEyG0Xp72by+S4Jlp9fsNwS6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 63/63] kbuild: consolidate Clang compiler flags
Date:   Mon, 25 Feb 2019 22:12:03 +0100
Message-Id: <20190225195040.627440954@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 238bcbc4e07fad2fff99c5b157d0c37ccd4d093c upstream.

Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
-no-integrated-as into a single variable CLANG_FLAGS so that it can be
easily reused in other parts of Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -506,18 +506,17 @@ endif
 
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
+CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
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
-KBUILD_CFLAGS += -no-integrated-as
-KBUILD_AFLAGS += -no-integrated-as
+CLANG_FLAGS	+= -no-integrated-as
+KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 endif
 
 


