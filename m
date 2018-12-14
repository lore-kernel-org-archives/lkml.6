Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DABCC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38562080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JaonNPXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38562080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeLNIGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:06:13 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:28077 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeLNIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:06:13 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBE85gQS007194;
        Fri, 14 Dec 2018 17:05:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBE85gQS007194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544774743;
        bh=ArJU08QIaYQfsMfVzx2Mq0aAU+APf+PvHjRju2O0Aw4=;
        h=From:To:Cc:Subject:Date:From;
        b=JaonNPXGoWQ6jrHHHisU8+Ps5kea5c26YXJrOkQhSVm7aVaHoyEwt5vB3Ayxf9trN
         Kf3bDiPpJamoPmQ2BcvMA1eI5BifJGdhECYQL0JfPvxCs54t+myHNpvvl6Mj6DEEng
         vA6MXTB8pBPsfx2SUvz51OmpBPu4M1y3BDcn88M24lHe6EIOwTWj5S17SG8hDd7BNQ
         fstwAiOCppv9Y8EhTnZlfLLoPxZNsZ9OPssFqo/fMpNENTQKJCBlfUiOmt893h9u3k
         ckpetzNe0hi0QcxYbgYcMEZiEgduNSfqyYMweUlb+/fckLFWKa/6ElRyjzPXmXLM3b
         D4jy0CnGcaTzQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: add -fno-PIE flag unconditionally
Date:   Fri, 14 Dec 2018 17:05:37 +0900
Message-Id: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is documented in the GCC 4.6 manual, and recognized by
Clang as well. Let's rip off the cc-option switch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f2c3423..3bbc16a 100644
--- a/Makefile
+++ b/Makefile
@@ -422,9 +422,9 @@ LINUXINCLUDE    := \
 		-I$(objtree)/include \
 		$(USERINCLUDE)
 
-KBUILD_AFLAGS   := -D__ASSEMBLY__
+KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-		   -fno-strict-aliasing -fno-common -fshort-wchar \
+		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror-implicit-function-declaration \
 		   -Wno-format-security \
 		   -std=gnu89
@@ -510,9 +510,6 @@ RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
-KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
-KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
-
 # check for 'asm goto'
 ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
   CC_HAVE_ASM_GOTO := 1
-- 
2.7.4

