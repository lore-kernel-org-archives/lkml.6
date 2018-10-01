Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58034C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980F206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uX5xv4rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C980F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeJAQWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:22:24 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64029 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbeJAQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:22:23 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w919iipI005108;
        Mon, 1 Oct 2018 18:44:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w919iipI005108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538387085;
        bh=WUXFT2P0NSk4Fbu7xQA1bRb++hUQ2jt1i2HYH+Xzm38=;
        h=From:To:Cc:Subject:Date:From;
        b=uX5xv4rzB3D6LP2ZHst8Qplwkga1VgVCRbPBCQMoYqigtE9d1p7Wm3AqR775E1wI9
         j09+13e/zTSrkqcWThhQZXw/7JB5V2LP8TTtnVTZsJ5bcKuxrTi/Iwl2s44QAoCpJ3
         UBtD1uVP/EdI8mi4eHxAVzBQ40EaCsU6hJWpgU3G+2C4kWpPRze9rQ78PVm4KkBIQC
         DFPE/63yzBXt7p1Ov2Tc7ot4w+Xcy6FjKW8Myha9+4dpYgsVEyT1aXzAOJBLPsGpXE
         a+lD8EnVIBvPl4xACE/9fNlOUMolg1Q2dr6VOTGxubZegSjEGLN0KY4GyxVKzaFj4R
         CLvEHpSKOkJcg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: add -Wno-pointer-sign flag unconditionally
Date:   Mon,  1 Oct 2018 18:44:36 +0900
Message-Id: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have raised the compiler requirement from time to time.
With commit cafa0010cd51 ("Raise the minimum required gcc version
to 4.6"), the minimum for GCC is 4.6 now.

The -Wno-pointer-sign has been here since the pre-git era.  It is
documented in the GCC 4.6 manual, and it is recognized by Clang
and ICC as well.

Let's rip off the cc-disable-warning switch, and see if somebody
complains about it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6d1f2f..505a324 100644
--- a/Makefile
+++ b/Makefile
@@ -800,7 +800,7 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 
 # disable pointer signed / unsigned warnings in gcc 4.0
-KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
+KBUILD_CFLAGS += -Wno-pointer-sign
 
 # disable stringop warnings in gcc 8+
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
-- 
2.7.4

