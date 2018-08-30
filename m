Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30022082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30022082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeH3Nlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:41:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeH3Nll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:41:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7U9e3Kj1703493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 02:40:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7U9e2f01703490;
        Thu, 30 Aug 2018 02:40:02 -0700
Date:   Thu, 30 Aug 2018 02:40:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-36bf9da2913054c218337d8cd7cb11bddc1fafb0@git.kernel.org>
Cc:     tglx@linutronix.de, michal.lkml@markovi.net,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, michal.lkml@markovi.net,
          yamada.masahiro@socionext.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1535348714-25457-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535348714-25457-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/build: Remove jump label quirk for GCC older
 than 4.5.2
Git-Commit-ID: 36bf9da2913054c218337d8cd7cb11bddc1fafb0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  36bf9da2913054c218337d8cd7cb11bddc1fafb0
Gitweb:     https://git.kernel.org/tip/36bf9da2913054c218337d8cd7cb11bddc1fafb0
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Mon, 27 Aug 2018 14:45:14 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 11:37:08 +0200

x86/build: Remove jump label quirk for GCC older than 4.5.2

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

Remove the workaround code.

It was the only user of cc-if-fullversion.  Remove the macro as well.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Link: https://lkml.kernel.org/r/1535348714-25457-1-git-send-email-yamada.masahiro@socionext.com

---
 arch/x86/Makefile      | 12 ------------
 scripts/Kbuild.include |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 94859241bc3e..8fc8f94ef5f5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -179,18 +179,6 @@ ifndef CC_HAVE_ASM_GOTO
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
index c75413d05a63..ce53639a864a 100644
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
