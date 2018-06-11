Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id h0IkJabwHVueZQAAmS7hNA
	; Mon, 11 Jun 2018 03:46:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57D976070A; Mon, 11 Jun 2018 03:46:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jJxStz3h"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6F7E460385;
	Mon, 11 Jun 2018 03:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F7E460385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeFKDqm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:46:42 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:38120 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753793AbeFKDqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:46:40 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5B3jXZH020626;
        Mon, 11 Jun 2018 12:45:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5B3jXZH020626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528688734;
        bh=m97PBOSOnWxXAULMiYWVvcCnl8Mo0pxtAYU/Z6qnyG4=;
        h=From:To:Cc:Subject:Date:From;
        b=jJxStz3hXzwshgz4/9y/zIbAsJEOn5iEjamHDp2+b0knLOJaFR9U38k+/v08Oolvh
         jAryA3wXQQX5e4S3VbTUcQOUxzsZBslF98Y0wTe9DO4Tb6SNzTKwQ2RIWwNdPWspLX
         9unFjQMWya39j+lo5mZS3hiH6TKR4Xhc/AGgkR449KHCP6hm+eKBQcox2V3Vx0B7HJ
         Gz6KZJs31BpPEleZr7Kpw8zUriejL9W/+CuOrRSXtfIkBe6G/covWEj5ku64eRsh02
         iv5V4n6Fho/Nxr2zI/2wIy5NP2Gj21df0tOZ06OVv2PcDya57pp1FiQjbE8q3JPomX
         ZK8QNcdVKtMzw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kbuild: clean-up passing KCOV compiler flags
Date: Mon, 11 Jun 2018 12:45:17 +0900
Message-Id: <1528688717-8500-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the compiler support for KCOV is computed in the Kconfig
phase, expensive $(call cc-option,...) calls no longer exist in
scripts/Makefile.kcov .

It shouldn't hurt to include scripts/Makefile.kcov everytime Kbuild
descends into a sub-directory.  Also, move ugly stuff from Makefile.lib
to Makefile.kcov .

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

My hope is to do likewise for gcov, kasan, ubsan.

gcov, kcov, kasan, ubsan need per-file (or per-directory)
flag addition or removal.

Currently, scripts/Makefile.lib is cluttered to handle this.

If this clean-up is achieved, scripts/Makefile.lib will
look like this:

 ---------------------->8------------------------------
include-$(CONFIG_GCOV_KERNEL) += scripts/Makefile.gcov
include-$(CONFIG_KCOV)        += scripts/Makefile.kcov
include-$(CONFIG_KASAN)       += scripts/Makefile.kasan
include-$(CONFIG_UBSAN)       += scripts/Makefile.ubsan

include $(include-y)
 ---------------------->8------------------------------

I will not apply this until some more cleanups are done (hence, RFC).
At least, scripts/Makefile.kasan is so complicated for now.


 Makefile              | 1 -
 scripts/Makefile.kcov | 8 +++-----
 scripts/Makefile.lib  | 8 +++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 73f0bb2..c99ca82 100644
--- a/Makefile
+++ b/Makefile
@@ -669,7 +669,6 @@ KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 
-include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
 
 ifdef CONFIG_READABLE_ASM
diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
index 3d61c4b..408b776 100644
--- a/scripts/Makefile.kcov
+++ b/scripts/Makefile.kcov
@@ -1,9 +1,7 @@
-ifdef CONFIG_KCOV
-
 kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)	+= -fsanitize-coverage=trace-pc
 kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)	+= -fsanitize-coverage=trace-cmp
 kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)		+= -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
 
-export CFLAGS_KCOV := $(kcov-flags-y)
-
-endif
+_c_flags += $(if $(patsubst n%,, \
+	$(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
+	$(kcov-flags-y))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5af34a2b..f5bd1d3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -126,11 +126,9 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_UBSAN))
 endif
 
-ifeq ($(CONFIG_KCOV),y)
-_c_flags += $(if $(patsubst n%,, \
-	$(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
-	$(CFLAGS_KCOV))
-endif
+include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
+
+include $(include-y)
 
 # If building the kernel in a separate objtree expand all occurrences
 # of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
-- 
2.7.4
