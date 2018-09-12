Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7486CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1458D20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wAqPKTil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1458D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeILLVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:21:22 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:53906 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeILLVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:21:22 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8C6IJNR012332;
        Wed, 12 Sep 2018 15:18:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8C6IJNR012332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536733099;
        bh=1Ofd2D5xflJouYcUk4EXEPfoy1UW1xAmnF6wO1wg+is=;
        h=From:To:Cc:Subject:Date:From;
        b=wAqPKTilA2WSi0Nt0YZze+nNpY2qcbR4GlihPHAyF+e0+TbCoQuiSQijdFddQVn1J
         +Dq72dHQ0uOjmSfSUgEEg1woWzY3CjGf+AVVMMrHAEGdyl9Eyr27plwPpAbqcBUgr/
         gz6MGQoI1BVXUPFUDczHYYI1YdOMSXTN9Xv3OTm+Bta2qghvwQ+T8S+gYhZP0Y8vk6
         oZEKjqhyNE8VNQ8XsAfF2nSoJ4L3+HQrDNjdOaAl/6Ma6b2gEEyr3UJzvIS6Vlu84p
         oiSGVQN7nuTcOQUyAL+NJem/Sz6kVyH2NYQ2nUp54nIx6Euy6PwJHbzdAnHg1deDV6
         C7n5DfGxAXfCA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove old check for CFLAGS use
Date:   Wed, 12 Sep 2018 15:18:02 +0900
Message-Id: <1536733082-19110-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check has been here more than a decade since commit 0c53c8e6eb45
("kbuild: check for wrong use of CFLAGS").

Enough time for migration has passed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5a2d1c9..cb03774 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -36,21 +36,11 @@ subdir-ccflags-y :=
 
 include scripts/Kbuild.include
 
-# For backward compatibility check that these variables do not change
-save-cflags := $(CFLAGS)
-
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
 kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
 include $(kbuild-file)
 
-# If the save-* variables changed error out
-ifeq ($(KBUILD_NOPEDANTIC),)
-        ifneq ("$(save-cflags)","$(CFLAGS)")
-                $(error CFLAGS was changed in "$(kbuild-file)". Fix it to use ccflags-y)
-        endif
-endif
-
 include scripts/Makefile.lib
 
 # Do not include host rules unless needed
-- 
2.7.4

