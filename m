Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B412133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217189;
	bh=GFiJ5V2GYp6OVGxvC2lDmRXd6F/KwdhzO2MBCI87OH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWuoSjoaSde9G1pDWec5kLWHOy8U6YK+FkHU+KQn4yaAlOiNElZ+ykBKW8DfoA+9m
	 ZtQQjUmeGWoWbs2+ov11tdZWJvl9Ab0q4y6cfkXutgk/RdbxfXy+MAYXF4MdZDPJZl
	 FiRFxu//HfsbZbyeTjqnfTt8TlJA+MBTlxDjTQjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbfAKOdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389582AbfAKOdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2832133F;
        Fri, 11 Jan 2019 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217184;
        bh=GFiJ5V2GYp6OVGxvC2lDmRXd6F/KwdhzO2MBCI87OH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcPykRM8bemxV/NX7h2rNf0frd0LUNtm6mgN/faTrTEkUaF80iRgaRMP/S26R/GAC
         rJzzLEJQ9WNSKaUo+FblUt3c8ejc4cIwWKnvu6JJJ5HJyWB+2S8fMsxvyjie78n9qm
         UL5Y9YY6EOeoC5xvq7TGlwLEvHBSlaEhkBF1dx8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 074/105] kbuild: consolidate Clang compiler flags
Date:   Fri, 11 Jan 2019 15:14:45 +0100
Message-Id: <20190111131109.190653378@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -479,18 +479,17 @@ endif
 
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
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register


