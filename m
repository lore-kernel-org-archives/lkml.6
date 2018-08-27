Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A32C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7FC21722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WW4J4aMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7FC21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeH0H0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:26:06 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:21268 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0H0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:26:06 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7R3dqBW000620;
        Mon, 27 Aug 2018 12:39:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7R3dqBW000620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535341193;
        bh=Vgyw17x1dF7D+kIxyRMyUdC5TrpszQQHtPWiOKqXq6I=;
        h=From:To:Cc:Subject:Date:From;
        b=WW4J4aMS+Y32QS3azBnt70bdY7uQTCFkZiXEisYm/mdWudSiv8U/HiHQH9pwiNOLv
         4r1uiS5DaOfcrilQwwlCpy2zknozqogyMb4gpckQa6kREsso/PpsHc6r/n/hjwHK3r
         r1CC8yEtfFwCIs+LGnDCijQ1MMextowUYzTdxZWUOw19AfifQVdfw1lSmtYFuWJKyk
         XJQLdEJUGeJcZm2UrgU5IkjHcrUYaOXnSMt+YIZcVpovoDft2Olgew8tIsESVE58Tk
         mWUH6GdLhZqkoyyay1lJg8l8+7mnmm8G/5ItysHISOivHuZbLpPTAuAo5X7ko5ZqcQ
         fJBz+kubXD4+A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] objtool: remove workaround for unreachable warnings from old GCC
Date:   Mon, 27 Aug 2018 12:39:43 +0900
Message-Id: <1535341183-19994-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

This effectively reverts commit da541b20021c ("objtool: Skip
unreachable warnings for GCC 4.4 and older"), which was a workaround
for GCC 4.4 or older.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1c48572..5a2d1c9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -246,8 +246,6 @@ objtool_args += --no-fp
 endif
 ifdef CONFIG_GCOV_KERNEL
 objtool_args += --no-unreachable
-else
-objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
 ifneq ($(RETPOLINE_CFLAGS),)
-- 
2.7.4

