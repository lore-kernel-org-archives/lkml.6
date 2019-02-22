Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC50DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A27720823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mLdftSA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBVHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:40:23 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53327 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfBVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1M7eEN2013122;
        Fri, 22 Feb 2019 16:40:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1M7eEN2013122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550821215;
        bh=gzAGp20lwx555N74OLIUjuRuDhy6lpNK2qNzq0MFvi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLdftSA6BczwG736OYyqiMv635Fnywbaz4TPoqU8CLsCGYGv+ghTJqnGKkXjkJU7L
         FCVVeWFuqSNWcnb5JKx0q//jwGesIQql1OnQuoHTovEh1hQow2WqaQOpxojidwpb2R
         mPWjpkidmDRZNVLEtlcnEQHoLl2YdnclkAdRh6/eJkbU/D/GRuRoGagmHyDAH4p8Xg
         v8G58xYD1jhvdQyqjP+6FaWzmxEwk9ro+FkMT+PDQcRfrlTiMOB08Jiktk7M42H12+
         bJnOOCERgCzAW3P9C7Yy/Y5bHMjqgkd/VR1UD+mwQaQmEO/DLEvUFguyirnferBg4e
         mk7eyvEWrVUeg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] kbuild: remove empty rules for makefiles
Date:   Fri, 22 Feb 2019 16:40:08 +0900
Message-Id: <1550821211-30324-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit made 'MAKEFLAGS += -rR' effective in the top
Makefile regardless of O= option, GNU Make versions.

The top Makefile does not need to cancel implicit rules for makefiles.

There is still one place where an empty rule is useful. Since -rR is
effective only after sub-make, GNU Make would try implicit rules to
update the top Makefile. Although it is not a big overhead, cancel it
just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Revive  empty rule for
    $(KCONFIG_CONFIG) include/config/auto.conf.cmd

 Makefile | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index f0bc078..538a4f1 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,10 @@ ifneq ($(sub-make-done),1)
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
@@ -1764,9 +1763,7 @@ cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
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

