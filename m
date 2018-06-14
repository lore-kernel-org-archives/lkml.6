Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C387C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12569208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rn9T+m4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12569208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755030AbeFNKhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:37:32 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43055 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754860AbeFNKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:37:30 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5EAaqEf008870;
        Thu, 14 Jun 2018 19:36:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5EAaqEf008870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528972613;
        bh=D6RBD1FQAs9xM50ah7jHEdg+RGlc5qJNCxFTeU5F4Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rn9T+m4h6xURvxsypvcdfB0ATPUqvNTuIyqpVBNTYU7RTB/XaQi+YkMHYvpUpv1gE
         y/CVfcI/r+qI6EatsyBUXPycc7oTBLz2Z6hSdzac4k3WwBKTF4xwneXhn6LO94Ie4l
         wP+ZvyyulqKTf4Vr9vXJiPxJdyJ+pQQ5207DeZ7XMmilLP2g5ws5bI0Lb/QKkmfcFh
         75znwp+t56CYgdQ6mfA7qZxXMfIHXvpqNbD4S3D0qLzC5d6mJM9TYqcBGzaQrS8Kso
         ZBtnki2GH2jmATvD+w0aXNLjpMAQVU2GYa1/s6hcPbkMuiVykHGlrnzeBV28UljcuP
         UZpuCC0I8doew==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] x86: fix dependency of X86_32_LAZY_GS
Date:   Thu, 14 Jun 2018 19:36:43 +0900
Message-Id: <1528972605-24264-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2a61f4747eea ("stack-protector: test compiler capability in
Kconfig and drop AUTO mode") replaced the 'choice' with two boolean
symbols, so CC_STACKPROTECTOR_NONE no longer exists.

Prior to commit 2bc2f688fdf8 ("Makefile: move stack-protector
availability out of Kconfig"), this line was like this:

  depends on X86_32 && !CC_STACKPROTECTOR

The CC_ prefix was dropped by commit 050e9baa9dc9 ("Kbuild: rename
CC_STACKPROTECTOR[_STRONG] config variables"), so the dependency
now should be:

  depends on X86_32 && !STACKPROTECTOR

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 455a670..d6c6ee6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -327,7 +327,7 @@ config X86_64_SMP
 
 config X86_32_LAZY_GS
 	def_bool y
-	depends on X86_32 && CC_STACKPROTECTOR_NONE
+	depends on X86_32 && !STACKPROTECTOR
 
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
-- 
2.7.4

