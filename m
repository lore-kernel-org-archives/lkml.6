Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378B721722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZSUyoZnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378B721722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeH0Jbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:31:47 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:25631 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeH0Jbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:31:47 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w7R5jOeR006032;
        Mon, 27 Aug 2018 14:45:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w7R5jOeR006032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535348725;
        bh=bBFKI8kTgDIYQggsG1Fazeu+zZ+2+IMU5IqP43MfnKY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSUyoZnuBi9Atx3O4LQOjoWezxXh0VQKKhFyRMsjJMOWMsj3ZdXwQS6qUux+PBOGQ
         zYy/kQeNImLIgpKZ9KPFM61ctw8Q+lY9B6peEY/eF6WdHl/npLvwCo3/SO0xThtay7
         cpJEGcwXwLaG8SWxJ1Ls2LkxsVpPMtfH9wORBfuAaRXjWvMDxBKQ/EKcYxffo1Wdvv
         LX5MHDr7/+fxYDUgE2i7SdRC63izZtVQYSaCvyKGe26b3639XreBM5MDMAIEEOWniL
         69Qx0RiEFecTHVVA9J2Vo5aV2xuQXWzLVyrLR5CRw0FkTc2Pn/5j4DRswnWtNtexI0
         9mDpA3ygKBjeQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] x86/build: remove jump label quirk for GCC older than 4.5.2
Date:   Mon, 27 Aug 2018 14:45:14 +0900
Message-Id: <1535348714-25457-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

Remove the workaround code.

It was the only user of cc-if-fullversion.  Remove the macro as well.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile      | 12 ------------
 scripts/Kbuild.include |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index d6c10f3..a51d5dc 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -175,18 +175,6 @@ ifndef CC_HAVE_ASM_GOTO
   $(error Compiler lacks asm-goto support.)
 endif
 
-#
-# Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent a
-# GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46226).  There's no way
-# to test for this bug at compile-time because the test case needs to execute,
-# which is a no-go for cross compilers.  So check the GCC version instead.
-#
-ifdef CONFIG_JUMP_LABEL
-  ifneq ($(ACCUMULATE_OUTGOING_ARGS), 1)
-	ACCUMULATE_OUTGOING_ARGS = $(call cc-if-fullversion, -lt, 040502, 1)
-  endif
-endif
-
 ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	# This compiler flag is not supported by Clang:
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c75413d..ce53639 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -153,10 +153,6 @@ cc-fullversion = $(shell $(CONFIG_SHELL) \
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
 cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
 
-# cc-if-fullversion
-# Usage:  EXTRA_CFLAGS += $(call cc-if-fullversion, -lt, 040502, -O1)
-cc-if-fullversion = $(shell [ $(cc-fullversion) $(1) $(2) ] && echo $(3) || echo $(4))
-
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
 cc-ldoption = $(call try-run,\
-- 
2.7.4

