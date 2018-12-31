Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCB72081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0qFvvBSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeLaBFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 20:05:19 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:34394 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLaBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 20:05:19 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBV1542H014742;
        Mon, 31 Dec 2018 10:05:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBV1542H014742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546218305;
        bh=JNKG7XI/C4qWG5gyaNc+nBEMuLAncqc7eeLxRgYKcYg=;
        h=From:To:Cc:Subject:Date:From;
        b=0qFvvBShGEFDdpYMg1hoWUm1/4fooLhWIBCgU5b+XDA4lkRzLoeUo9cDeB2nJL3DH
         4d6/qXpBgaVtlwNqsx72UTDSkqd11RNtJmI8pG3WGcPBrlrhn4md3lvRKFHPuBKMwD
         iDl1v12ID9ijI4Sm4Wg59QeRw5UpBHLIhgOXi/MYcckEvXb97U8ZXiaPh1uceAKMIQ
         +ybJyh+bubq6Ro5IdLurvhvWbOOE0DhD4UQkc8vc94fcp6p6OHDabo6B58MnwCwLDt
         fJ/a7wx3gjWLwwBs7x0XQsQaHWe73Ymy8iQcoh1ovrmjsOI6LCZLr2bCe8utSXJFGp
         KpI7hc8/4O6vA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove UIMAGE_IN and UIMAGE_OUT
Date:   Mon, 31 Dec 2018 10:05:01 +0900
Message-Id: <1546218301-14163-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only/last user of UIMAGE_IN/OUT was removed by commit 4722a3e6b716
("microblaze: fix multiple bugs in arch/microblaze/boot/Makefile").

The input and output should always be $< and $@.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3ceaa2e..05a3e40 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -371,15 +371,13 @@ UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
 UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
-UIMAGE_IN ?= $<
-UIMAGE_OUT ?= $@
 
-quiet_cmd_uimage = UIMAGE  $(UIMAGE_OUT)
+quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $(UIMAGE_IN) $(UIMAGE_OUT)
+			-n $(UIMAGE_NAME) -d $< $@
 
 # XZ
 # ---------------------------------------------------------------------------
-- 
2.7.4

