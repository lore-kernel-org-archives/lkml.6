Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9868C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F29C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zqsQA10S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfBUEPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:15:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:25464 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBUEPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:15:08 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x1L4Diq6000406;
        Thu, 21 Feb 2019 13:13:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x1L4Diq6000406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550722425;
        bh=WB8FMXiddfh/ANaSrDuHT7qAAFTezhEwjn+zv9LMKxk=;
        h=From:To:Cc:Subject:Date:From;
        b=zqsQA10S48Vhczrf2cOmcTa4usH1M/6JX3zRn3UQTiT5cw+6Lsw8NdnqswNmXUUgU
         7Tqso2pbk2Wbap+VzMshmwKh4ZQODB4YRbSQIeYSYQHdzCI8kpZ3ffF5LSKYGTxsKK
         CeTsgo2KwgXET4EjkcNBs8in+R5y6mBj1b8xkFaxwHxFsCpP1omE1QttGuip9QgQP8
         6KCDO+cthiMROsCHvVNztEtXSRkHo732amhqKzO4OhwYBIQ9qSRYVbSaUkmFBMQJZR
         dcdMmTJfMp3kmnYOLThnooaDw6dIvLWmrt20m02gk+sZXDM6uMIcTrvScWszCPRMEd
         TOdAeJMB7bFKA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized cases in Kconfig
Date:   Thu, 21 Feb 2019 13:13:38 +0900
Message-Id: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since -Wmaybe-uninitialized was introduced by GCC 4.7, we have patched
various false positives:

 - commit e74fc973b6e5 ("Turn off -Wmaybe-uninitialized when building
   with -Os") turned off this option for -Os.

 - commit 815eb71e7149 ("Kbuild: disable 'maybe-uninitialized' warning
   for CONFIG_PROFILE_ALL_BRANCHES") turned off this option for
   CONFIG_PROFILE_ALL_BRANCHES

 - commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized warning
   for "make W=1"") turned off this option for GCC < 4.9
   Arnd provided more explanation in https://lkml.org/lkml/2017/3/14/903

I think this looks better by shifting the logic from Makefile to Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile             | 10 +++-------
 init/Kconfig         | 17 +++++++++++++++++
 kernel/trace/Kconfig |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 1bb0535..b21aa2e3 100644
--- a/Makefile
+++ b/Makefile
@@ -656,17 +656,13 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
-KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
-else
-ifdef CONFIG_PROFILE_ALL_BRANCHES
-KBUILD_CFLAGS	+= -O2 $(call cc-disable-warning,maybe-uninitialized,)
 else
 KBUILD_CFLAGS   += -O2
 endif
-endif
 
-KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
-			$(call cc-disable-warning,maybe-uninitialized,))
+ifdef CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED
+KBUILD_CFLAGS   += -Wno-maybe-uninitialized
+endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
diff --git a/init/Kconfig b/init/Kconfig
index c9386a3..1f05a88 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -26,6 +26,22 @@ config CLANG_VERSION
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
 
+config CC_HAS_WARN_MAYBE_UNINITIALIZED
+	def_bool $(cc-option,-Wmaybe-uninitialized)
+	help
+	  GCC >= 4.7 supports this option.
+
+config CC_DISABLE_WARN_MAYBE_UNINITIALIZED
+	bool
+	depends on CC_HAS_WARN_MAYBE_UNINITIALIZED
+	default CC_IS_GCC && GCC_VERSION < 40900  # unreliable for GCC < 4.9
+	help
+	  GCC's -Wmaybe-uninitialized is not reliable by definition.
+	  Lots of false positive warnings are produced in some cases.
+
+	  If this option is enabled, -Wno-maybe-uninitialzed is passed
+	  to the compiler to suppress maybe-uninitialized warnings.
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
@@ -1113,6 +1129,7 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
 
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size"
+	imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
 	help
 	  Enabling this option will pass "-Os" instead of "-O2" to
 	  your compiler resulting in a smaller kernel.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fa8b1fe..8bd1d6d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -370,6 +370,7 @@ config PROFILE_ANNOTATED_BRANCHES
 config PROFILE_ALL_BRANCHES
 	bool "Profile all if conditionals" if !FORTIFY_SOURCE
 	select TRACE_BRANCH_PROFILING
+	imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
 	help
 	  This tracer profiles all branch conditions. Every if ()
 	  taken in the kernel is recorded whether it hit or miss.
-- 
2.7.4

