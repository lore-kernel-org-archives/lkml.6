Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC83C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1898420693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1898420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755027AbeFQLVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:21:33 -0400
Received: from stumail.xidian.edu.cn ([202.117.112.40]:49320 "HELO
        stu.xidian.edu.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1754255AbeFQLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:21:32 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2018 07:21:32 EDT
Received: from localhost (localhost [10.170.26.222])
        by stu.xidian.edu.cn (eYou MTA v8.1.0) with ESMTP id 8b5ec090895555936b1f6023946f8033
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 19:16:12 +0800
X-Eyou-Smtpauth: ryxi@stu.xidian.edu.cn
From:   Xi Ruoyao <ryxi@stu.xidian.edu.cn>
Date:   Sun, 17 Jun 2018 18:16:07 +0800
Subject: [PATCH] Kbuild: fix mismatched if/endif pairs
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Cc:     Xi Ruoyao <ryxi@stu.xidian.edu.cn>
X-Eyou-Sender: <ryxi@stu.xidian.edu.cn>
Message-Id: <180617191612798b1a5d7a74c59e7905c31fd3f36f5d@stu.xidian.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In scripts/Makefile.build, there are two mismatched if/endif pairs.
They stop the generation of orc unwind table if CONFIG_FTRACE_MCOUNT_RECORD
is not set.  dmesg complains:

WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.

This comment moves an endif to match the if/endif pairs.

Signed-off-by: Xi Ruoyao <ryxi@stu.xidian.edu.cn>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 34d9e9ce97c2..16509a038d77 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -239,6 +239,7 @@ cmd_record_mcount =						\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
 	fi;
+endif # cc-option(-mrecord-mcount)
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
@@ -263,7 +264,6 @@ ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
 endif
-endif
 
 
 ifdef CONFIG_MODVERSIONS
-- 
2.16.2

