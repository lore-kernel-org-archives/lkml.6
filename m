Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A8F2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bazDBYFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A8F2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeKFM3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:29:41 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:54210 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeKFM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:29:40 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wA635Mp2025438;
        Tue, 6 Nov 2018 12:05:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wA635Mp2025438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541473524;
        bh=1+BFxkaRJrjARU/GhxBmY3HEDiOtKleHWhuKBQ9VCEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bazDBYFf/fLxanBbDMmWZm0TVTNGgnIONdWRlQA2PS2kGPaamgVRgGYmeEfyqRYEb
         6R1nNrYuVHJ6bVdGEBxyIp32WdqB5RyaT19n7QkMYpUCh0A2THp5iMvf6kjIA24sPm
         hUN7TSvYaoC0mFCIdXGGPgwoHIft96zYMa4KXQNgeDox2rXdwE8jDu/t8pzoS38P7p
         Mv1I9AGb17xpnMwI9jeZur+USMq9L1fxVOOWniR5SkE7WwY7oFHOzyTPGvg0dwRYfE
         yaZWT+SyH7nuaFSBLi0sqxSlJT4f75ZKAAlM9R+wwSDVjLAMmuPwCLmeBS/sNrx4bp
         wcWnVDLoaB2EQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>,
        Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
Date:   Tue,  6 Nov 2018 12:04:55 +0900
Message-Id: <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
-no-integrated-as into a single variable CLANG_FLAGS so that it can be
easily reused in other parts of Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway

 Makefile | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index da11700..e173a73 100644
--- a/Makefile
+++ b/Makefile
@@ -487,18 +487,17 @@ endif
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
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
-- 
2.7.4

