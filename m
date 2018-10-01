Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89572C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4803B2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gHLvUYXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4803B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeJAQWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:22:24 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64025 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbeJAQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:22:23 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w919iipJ005108;
        Mon, 1 Oct 2018 18:44:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w919iipJ005108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538387085;
        bh=SpZLur+sbJBSYyU7Lxk/b7C7/dHU+CrpWov6wcdLp/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHLvUYXM8wWsdtMDUcST736bPxk8/3DXBmeZhA2+/IbM7x7PWUZigq3BGBCMxl12c
         dLbf3ve2ZrGPqbgQ2RKApbnm64u6PidFbkvg/EzFEHZpF6oHsijjuLDyu9ZzBv6uyN
         2IhKUi/hwQJlcWXZE0nDHzxqfhFPQYlmm60riPQVkzhPh8YRlWIA9g4uGHjQzSXcAI
         p37IjL8obA08CWdP4XtMHdMOPkPGjs0NSrhNjxahC1NYz6RfajRW/osuYunZSHzKQJ
         jymK5oW/uH2I6iQUKc47lEG77RjPlF9PtH7DKlb+Srkyf7+pxQArzC1VsnCtjRLD1h
         8Yfk8PWzuobDg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: add -Wdeclaration-after-statement flag unconditionally
Date:   Mon,  1 Oct 2018 18:44:37 +0900
Message-Id: <1538387078-21892-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have raised the compiler requirement from time to time.
With commit cafa0010cd51 ("Raise the minimum required gcc version
to 4.6"), the minimum for GCC is 4.6 now.

This flag has been here since the pre-git era.  It is documented in
the GCC 4.6 manual, and it is recognized by Clang and ICC as well.

Let's rip off the cc-option switch, and see if somebody complains
about it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 505a324..8a23fee 100644
--- a/Makefile
+++ b/Makefile
@@ -797,7 +797,7 @@ endif
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
 # warn about C99 declaration after statement
-KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
+KBUILD_CFLAGS += -Wdeclaration-after-statement
 
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += -Wno-pointer-sign
-- 
2.7.4

