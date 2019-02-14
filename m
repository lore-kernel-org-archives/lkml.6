Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D892E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YHX966Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395308AbfBNDGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:08 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64384 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394268AbfBNDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg8020814;
        Thu, 14 Feb 2019 12:05:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg8020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113529;
        bh=9rCnJrZhrNGJF/7A8mlLM75Z8BqThK/fBdPkgtUyRPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHX966QjGfaHOVTquVmuzHmIIdhYCCM6T/lIo243Ly6iBmhF/LJ76ItK3CsAh+GZh
         A9ionEc55vwALlYZXihilnIQi/q6yBLM4lxAJfWHTQambXxNMch63348VWxCAHj4pJ
         LC/kCJ4MNa6WgfVj6ROeXAsL8Y9BgGHP6SJ9nCKY7Epspf9kV1jYKN8fUp3zYpv+fS
         NA5kuV/JTaHvOJd5wFTR522ny/WsOIGwi/ab7QXpJpo8HHtrc0HCnwkrACzdkwa0Zo
         w8PP+6lp50lVKeUjl5FRxIRhbVM+7cDVxWgRXsCHp8kb5eB1eCdwgHqD9fvajxQQzR
         sm1dYtn9UQE+A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] kbuild: remove empty rules for makefiles
Date:   Thu, 14 Feb 2019 12:05:20 +0900
Message-Id: <1550113521-23577-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit made 'MAKEFLAGS += -rR' effective in the top
Makefile regardless of O= option, GNU Make versions.

The top Makefile does not need to cancel implicit rules for makefiles.

There is still one place where an empty rule is useful. Since -rR is
effective only after sub-make, GNU Make would try implicit rules to
update the top Makefile. Although it is not a big overhead, cancel
it just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 25d7d46..f7f1aa1 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,10 @@ ifndef KBUILD_SUBMAKE
 # (this increases performance and avoids hard-to-debug behaviour)
 MAKEFLAGS += -rR
 
+# 'MAKEFLAGS += -rR' does not become immediately effective for old
+# GNU Make versions. Cancel implicit rules for this Makefile.
+$(lastword $(MAKEFILE_LIST)): ;
+
 # Avoid funny character set dependencies
 unexport LC_ALL
 LC_COLLATE=C
@@ -120,9 +124,6 @@ ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif
 
-# Cancel implicit rules on top Makefile
-$(CURDIR)/Makefile Makefile: ;
-
 ifneq ($(words $(subst :, ,$(CURDIR))), 1)
   $(error main directory cannot contain spaces nor colons)
 endif
@@ -303,8 +304,6 @@ __build_one_by_one:
 
 else
 
-# We need some generic definitions (do not try to remake the file).
-scripts/Kbuild.include: ;
 include scripts/Kbuild.include
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
@@ -627,9 +626,6 @@ ifeq ($(may-sync-config),1)
 # because some architectures define CROSS_COMPILE there.
 -include include/config/auto.conf.cmd
 
-# To avoid any implicit rule to kick in, define an empty command
-$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
-
 # The actual configuration files used during the build are stored in
 # include/generated/ and include/config/. Update them if .config is newer than
 # include/config/auto.conf (which mirrors .config).
@@ -1750,9 +1746,7 @@ cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
 # read saved command lines for existing targets
 existing-targets := $(wildcard $(sort $(targets)))
 
-cmd_files := $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
-$(cmd_files): ;	# Do not try to update included dependency files
--include $(cmd_files)
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
-- 
2.7.4

