Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26F0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6AC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JPIO8QMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6AC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLEG2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:28:54 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:46909 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeLEG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:28:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wB56RW7u029816;
        Wed, 5 Dec 2018 15:27:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wB56RW7u029816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543991253;
        bh=5V1kQuJLlfL8jIPRipgke7K6jkRfgqj+4WAl323IuQw=;
        h=From:To:Cc:Subject:Date:From;
        b=JPIO8QMvb8YJcI0EzQV1WF6JoH4c2ywRBCHpc+F2seN5JYRRBiEN1Wt6LeC1g25zt
         m97MlQ55YKfAEfGwpMjucQsQeSTXvLp8DX/17HzmrROqelraV597g4Bvh7t9D/kXbr
         Qnu0SQ8NaSr/bj9Xj8DwcIje7gI843jOCsSV7zLMt5pXfdy8yb6JqYnve9SYIZ1QEC
         ttov7leDh8Y05vxIly/JVI9YM51pzn+/mWmcg9+mg3by43Sa5K0ZZnrWAfS81nfpu1
         umqzhGRmTqLgEsJR+y73LRf+sgIJEULTZyonhtqDoH+gsYnT9JkH4Tsoi5LfUQC4FQ
         tQlBbR0aY+EqA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Meelis Roos <mroos@linux.ee>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/build: fix compiler support check for CONFIG_RETPOLINE
Date:   Wed,  5 Dec 2018 15:27:19 +0900
Message-Id: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is troublesome to add a diagnostic like this to the Makefile
parse stage because the top-level Makefile could be parsed with
a stale include/config/auto.conf.

Once you are hit by the error about non-retpoline compiler, the
compilation still breaks even after disabling CONFIG_RETPOLINE.

The easiest fix is to move this check to the "archprepare" like commit
829fe4aa9ac1 ("x86: Allow generating user-space headers without a
compiler") did.

Link: https://lkml.org/lkml/2018/12/4/206
Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Revive ifdef CONFIG_RETPOLINE surrounding the KBUILD_CFLAGS addition
  - Rephase the commit log a bit, hoping the cause of the issue will be clearer

 arch/x86/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f41..75ef499 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -220,9 +220,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
@@ -307,6 +304,13 @@ ifndef CC_HAVE_ASM_GOTO
 	@echo Compiler lacks asm-goto support.
 	@exit 1
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
-- 
2.7.4

