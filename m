Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE220823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qJcl0Md1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfBVHkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:40:25 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53325 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1M7eEN1013122;
        Fri, 22 Feb 2019 16:40:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1M7eEN1013122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550821215;
        bh=ShLhb3WIzeeB+W+Duw3DHWEdsX60HCOwaHOO2R3ie0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJcl0Md10oQcoXayGlWXNY+W8O17qfDDowqRNY21BFSSaJW1JNH/kZ4PnY+mjDwMy
         6ho86dwoE6PzWBTMmChQaNCGhTuKzMOqYk0MjoOBtOTJKCkp+jsy7JzQJXSSIrZV3X
         p+RJj/+mqn7jnCdLUKsiTbCSxIajc/hggYCWsJltvw+NvBZxtO9buY5Q3U47RmLs9E
         KUtXSAm3Bmb3UVFmDn6LVtw9jtamhd0DrV/TewFR4e4jFF8TpVOCqa8zz06CpUqxSo
         oZt2vv+CirwZl50AIpUup0UWy+lAkkmsf/qOA8cTg1wJYJwsd/KIa4NrZOgAforUD7
         qHVoAmczjamNw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] kbuild: make -r/-R effective in top Makefile for old Make versions
Date:   Fri, 22 Feb 2019 16:40:07 +0900
Message-Id: <1550821211-30324-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v2:
  - Rename KBUILD_SUBMAKE to sub-make-done

 Makefile | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 82091b8..f0bc078 100644
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
 
+ifneq ($(sub-make-done),1)
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
+	$(Q)$(MAKE) sub-make-done=1 \
+	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-# Leave processing to above invocation of make
-skip-makefile := 1
-endif # ifneq ($(KBUILD_OUTPUT),)
-endif # ifeq ($(KBUILD_SRC),)
-
+else # sub-make-done
 # We process the rest of the Makefile if this is the final invocation of make
-ifeq ($(skip-makefile),)
 
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
@@ -1766,7 +1770,7 @@ $(cmd_files): ;	# Do not try to update included dependency files
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
-endif	# skip-makefile
+endif   # sub-make-done
 
 PHONY += FORCE
 FORCE:
-- 
2.7.4

