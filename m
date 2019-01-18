Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12725C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915E72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="liVdwCsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfARD7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:59:06 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:24941 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfARD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:59:03 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0I3wVKF005804;
        Fri, 18 Jan 2019 12:58:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0I3wVKF005804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547783924;
        bh=b/h/b3rLiG2RhSWm7dfEk59KmGj9X68TwOhNEEGYgpc=;
        h=From:To:Cc:Subject:Date:From;
        b=liVdwCsXPsK5rH4uC1uOJxEJnTEiIMCgfmIEO3HM1J+R7mIPqXL0ilDOGXzGAUYLN
         ENSFH+9BcqNq4H6yzFlJSEGU+qyAWVj1UkQ0d3NGx8Kag2dSDuvmrq3QdVFO25dcX6
         6dCyfpb5wtzeYVxgvDfbY/1tIltR2Pel3ABkEIZmKkt/h6q68SW/reuHKtMkSxSXPI
         HUwgm5EkR0SmknOaStQnDTxblyPpnrfCnGWBoL2P4dNw+obaEQiRyb+31XhR35rkUU
         114j/C7+H9CiAxADyDwL3G9EpwyoJEPQIgdccBQ+dqjUJxww8z9qBprUkMWavquw3E
         H8yfrDN+fWmhw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove meaningless prepare2 target
Date:   Fri, 18 Jan 2019 12:58:30 +0900
Message-Id: <1547783910-31653-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no build order among the following:
  prepare3
  outputmakefile
  asm-generic
  $(version_h)
  $(autoksyms_h)
  include/generated/utsrelease.h

It is meaningless to insert the prepare2 target between the first
three and the last three.

The comment says, "prepare2 creates a makefile if using a separate
output directory." Let me explain it more precisely. The prepare
targets cannot be executed without the .config file. Because the
configuration targets depend on the outputmakefile target, the
generated makefile is already there before the parepare2 is run.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 9851a44..cddcdb8 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,7 +1062,7 @@ scripts: scripts_basic scripts_dtc
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-PHONY += prepare archprepare prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare1 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1077,12 +1077,8 @@ ifneq ($(KBUILD_SRC),)
 	fi;
 endif
 
-# prepare2 creates a makefile if using a separate output directory.
-# From this point forward, .config has been reprocessed, so any rules
-# that need to depend on updated CONFIG_* values can be checked here.
-prepare2: prepare3 outputmakefile asm-generic
-
-prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
+prepare1: prepare3 outputmakefile asm-generic $(version_h) $(autoksyms_h) \
+						include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
 archprepare: archheaders archscripts prepare1 scripts
-- 
2.7.4

