Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F36C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855CC2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QdrDij41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855CC2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeKFM3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:29:39 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:54209 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeKFM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:29:39 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wA635Mp1025438;
        Tue, 6 Nov 2018 12:05:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wA635Mp1025438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541473523;
        bh=xfZW3fJh1acenYkJWuEJ06iyiSzfKWNTaLxqo0qkZZA=;
        h=From:To:Cc:Subject:Date:From;
        b=QdrDij41X6HF14h2xn51gHLqkxucMzmu7z6kQOrmVUdeft3zgXFbshmAhRJKIwDhw
         YQjuaJM3EdbPvTHVK7YpqGLF79F/qek1ThvCV09Hd3ZWVq56ET/8Xq7Giz27jzYOr3
         gL4N4uAZCPnv4K5lDgxGxPfDP8uRAr1i3ry4qur5xioF4SFoNjHa1Vmvdhjo+nd2yo
         rEUWrYCeJt5ZE8tFrB0ZjASK+zOpQiN53sUdF295o8VAGUkShQU7Nz5Z1PmutHKyNn
         HuEJ/OyAhiy8izNKsQ2wJOCp94X+96OhDsKRRG3FOauA2ENxhhBy9f7fNFBMaobxRc
         OMZo6fETXkX4Q==
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
Subject: [PATCH v2 1/2] kbuild: add -no-integrated-as Clang option unconditionally
Date:   Tue,  6 Nov 2018 12:04:54 +0900
Message-Id: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are still a way off the Clang's integrated assembler support for
the kernel. Hence, -no-integrated-as is mandatory to build the kernel
with Clang. If you had an ancient version of Clang that does not
recognize this option, you would not be able to compile the kernel
anyway.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 93315eb..da11700 100644
--- a/Makefile
+++ b/Makefile
@@ -497,8 +497,8 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_CFLAGS += -no-integrated-as
+KBUILD_AFLAGS += -no-integrated-as
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
-- 
2.7.4

