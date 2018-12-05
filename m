Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EAAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA6D2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA6D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeLEHqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:46:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:46:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB57jrwo1191003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 23:45:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB57jrWf1191000;
        Tue, 4 Dec 2018 23:45:53 -0800
Date:   Tue, 4 Dec 2018 23:45:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-10b87bc9f630a38a7f0c1e7cf13ff23fea1692ec@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        zhenzhong.duan@oracle.com, torvalds@linux-foundation.org,
        yamada.masahiro@socionext.com, mroos@linux.ee,
        peterz@infradead.org, bp@alien8.de, hpa@zytor.com
Reply-To: bp@alien8.de, hpa@zytor.com, mroos@linux.ee,
          peterz@infradead.org, torvalds@linux-foundation.org,
          yamada.masahiro@socionext.com, zhenzhong.duan@oracle.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/build: Fix compiler support check for
 CONFIG_RETPOLINE
Git-Commit-ID: 10b87bc9f630a38a7f0c1e7cf13ff23fea1692ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  10b87bc9f630a38a7f0c1e7cf13ff23fea1692ec
Gitweb:     https://git.kernel.org/tip/10b87bc9f630a38a7f0c1e7cf13ff23fea1692ec
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Wed, 5 Dec 2018 15:27:19 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 08:42:09 +0100

x86/build: Fix compiler support check for CONFIG_RETPOLINE

It is troublesome to add a diagnostic like this to the Makefile
parse stage because the top-level Makefile could be parsed with
a stale include/config/auto.conf.

Once you are hit by the error about non-retpoline compiler, the
compilation still breaks even after disabling CONFIG_RETPOLINE.

The easiest fix is to move this check to the "archprepare" like
this commit did:

  829fe4aa9ac1 ("x86: Allow generating user-space headers without a compiler")

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Link: http://lkml.kernel.org/r/1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com
Link: https://lkml.org/lkml/2018/12/4/206
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f4134524..75ef499a66e2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -220,9 +220,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
@@ -307,6 +304,13 @@ ifndef CC_HAVE_ASM_GOTO
 	@echo Compiler lacks asm-goto support.
 	@exit 1
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
