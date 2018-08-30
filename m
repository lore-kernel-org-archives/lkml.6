Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DC620834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DC620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeH3QdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:33:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbeH3QdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:33:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UCV9wu1753320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 05:31:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UCV8xv1753316;
        Thu, 30 Aug 2018 05:31:08 -0700
Date:   Thu, 30 Aug 2018 05:31:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ben Hutchings <tipbot@zytor.com>
Message-ID: <tip-3c76014d27e97bd641202007744fb37c18743adf@git.kernel.org>
Cc:     tglx@linutronix.de, ben@decadent.org.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, helmutg@debian.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, helmutg@debian.org,
          mingo@kernel.org, tglx@linutronix.de, ben@decadent.org.uk,
          hpa@zytor.com
In-Reply-To: <20180829194317.GA4765@decadent.org.uk>
References: <20180829194317.GA4765@decadent.org.uk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Allow generating user-space headers without a
 compiler
Git-Commit-ID: 3c76014d27e97bd641202007744fb37c18743adf
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

Commit-ID:  3c76014d27e97bd641202007744fb37c18743adf
Gitweb:     https://git.kernel.org/tip/3c76014d27e97bd641202007744fb37c18743adf
Author:     Ben Hutchings <ben@decadent.org.uk>
AuthorDate: Wed, 29 Aug 2018 20:43:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 14:28:19 +0200

x86: Allow generating user-space headers without a compiler

When bootstrapping an architecture, it's usual to generate the kernel's
user-space headers (make headers_install) before building a compiler.  Move
the compiler check (for asm goto support) to the archprepare target so that
it is only done when building code for the target.

Fixes: e501ce957a78 ("x86: Force asm-goto")
Reported-by: Helmut Grohne <helmutg@debian.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180829194317.GA4765@decadent.org.uk

---
 arch/x86/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8fc8f94ef5f5..8f6e7eb8ae9f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -175,10 +175,6 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
 
-ifndef CC_HAVE_ASM_GOTO
-  $(error Compiler lacks asm-goto support.)
-endif
-
 ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	# This compiler flag is not supported by Clang:
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
@@ -300,6 +296,13 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/vdso $@
 
+archprepare: checkbin
+checkbin:
+ifndef CC_HAVE_ASM_GOTO
+	@echo Compiler lacks asm-goto support.
+	@exit 1
+endif
+
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
