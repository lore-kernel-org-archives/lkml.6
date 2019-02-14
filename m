Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AB220818
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DD8gCOZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405272AbfBNDGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:30 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64382 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394145AbfBNDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg7020814;
        Thu, 14 Feb 2019 12:05:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg7020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113529;
        bh=UInuA6sjxvO1VVgZ8XgryVYJnyZUkO/SzulavMh+Za8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DD8gCOZ6YNKXjbMHKfAvzQAluld269OrZC1Z5CbLmpaYr68I6ycnzA2MYNPcmvx4c
         VnhWyuscYXmVr+LFbUWbBTd/pSe3RNUtVouLxokARc9aGEuNKiPb8Y+Vu4qPKtaLEn
         BNWrIbI/tQFwRe7m1n348IQcq/nzOMmIKucDsbJO6IfpRQVDuRh4NRyGCJEyviADWY
         JIr0DwsQR/JjpGDrYh8hIpdNr2iWECuIJyi2k5qvfwzZEoRIpwNfGitEU/d29WWC/a
         /CZxyc0ICvZiYNPrRMzSqBN7jlu9feDwCzVKYCr6ov+ZBpJG0I4PkNmzXW5ZbQFnvC
         xWN6j01qMFMDw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] kbuild: make -r/-R effective in top Makefile for old Make versions
Date:   Thu, 14 Feb 2019 12:05:19 +0900
Message-Id: <1550113521-23577-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding -rR to MAKEFLAGS is important because we do not want to
be bothered by built-in implicit rules or variables.

One problem that used to exist in older GNU Make versions is

  MAKEFLAGS += -rR

... does not become effective in the current Makefile. When you are
building with O= option, it becomes effective in the top Makefile
since it recurses via 'sub-make' target. Otherwise, the top Makefile
tries implicit rules. That is why we explicitly add empty rules for
Makefiles, but we often miss to do that.

In fact, adding -d option to older GNU Make versions shows it is
trying a bunch of implicit pattern rules.

 Considering target file `scripts/Makefile.kcov'.
  Looking for an implicit rule for `scripts/Makefile.kcov'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.o'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.c'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.cc'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.C'.
  ...

This issue was fixed by GNU Make commit 58dae243526b ("[Savannah #20501]
Handle adding -r/-R to MAKEFLAGS in the makefile"). So, it is no longer
a problem if you use GNU Make 4.0 or later. However, older versions are
still widely used.

So, I decided to patch the kernel Makefile to invoke sub-make regardless
of O= option. This will allow further cleanups.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 0180b23..25d7d46 100644
--- a/Makefile
+++ b/Makefile
@@ -15,19 +15,6 @@ NAME = Shy Crocodile
 PHONY := _all
 _all:
 
-# Do not use make's built-in rules and variables
-# (this increases performance and avoids hard-to-debug behaviour)
-MAKEFLAGS += -rR
-
-# Avoid funny character set dependencies
-unexport LC_ALL
-LC_COLLATE=C
-LC_NUMERIC=C
-export LC_COLLATE LC_NUMERIC
-
-# Avoid interference with shell env settings
-unexport GREP_OPTIONS
-
 # We are using a recursive build, so we need to do a little thinking
 # to get the ordering right.
 #
@@ -44,6 +31,21 @@ unexport GREP_OPTIONS
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+ifndef KBUILD_SUBMAKE
+
+# Do not use make's built-in rules and variables
+# (this increases performance and avoids hard-to-debug behaviour)
+MAKEFLAGS += -rR
+
+# Avoid funny character set dependencies
+unexport LC_ALL
+LC_COLLATE=C
+LC_NUMERIC=C
+export LC_COLLATE LC_NUMERIC
+
+# Avoid interference with shell env settings
+unexport GREP_OPTIONS
+
 # Beautify output
 # ---------------------------------------------------------------------------
 #
@@ -111,7 +113,6 @@ export quiet Q KBUILD_VERBOSE
 
 # KBUILD_SRC is not intended to be used by the regular user (for now),
 # it is set on invocation of make with KBUILD_OUTPUT or O= specified.
-ifeq ($(KBUILD_SRC),)
 
 # OK, Make called in directory where kernel src resides
 # Do we want to locate output files in a separate directory?
@@ -141,6 +142,13 @@ $(if $(KBUILD_OUTPUT),, \
 # 'sub-make' below.
 MAKEFLAGS += --include-dir=$(CURDIR)
 
+else
+
+# Do not print "Entering directory ..." at all for in-tree build.
+MAKEFLAGS += --no-print-directory
+
+endif # ifneq ($(KBUILD_OUTPUT),)
+
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
@@ -148,16 +156,12 @@ $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 sub-make:
-	$(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
+	$(Q)$(MAKE) KBUILD_SUBMAKE=1 \
+	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-# Leave processing to above invocation of make
-skip-makefile := 1
-endif # ifneq ($(KBUILD_OUTPUT),)
-endif # ifeq ($(KBUILD_SRC),)
-
+else # KBUILD_SUBMAKE
 # We process the rest of the Makefile if this is the final invocation of make
-ifeq ($(skip-makefile),)
 
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
@@ -1752,7 +1756,7 @@ $(cmd_files): ;	# Do not try to update included dependency files
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
-endif	# skip-makefile
+endif	# ifndef KBUILD_SUBMAKE
 
 PHONY += FORCE
 FORCE:
-- 
2.7.4

