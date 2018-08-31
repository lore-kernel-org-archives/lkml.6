Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE8EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D0120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D0120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeHaTVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:21:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbeHaTVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:21:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7VFDPLF2195679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Aug 2018 08:13:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7VFDOY02195676;
        Fri, 31 Aug 2018 08:13:24 -0700
Date:   Fri, 31 Aug 2018 08:13:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ben Hutchings <tipbot@zytor.com>
Message-ID: <tip-829fe4aa9ac16417a904ad1de1307de906854bcf@git.kernel.org>
Cc:     mingo@kernel.org, helmutg@debian.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ben@decadent.org.uk
Reply-To: mingo@kernel.org, helmutg@debian.org, tglx@linutronix.de,
          hpa@zytor.com, ben@decadent.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20180829194317.GA4765@decadent.org.uk>
References: <20180829194317.GA4765@decadent.org.uk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Allow generating user-space headers without a
 compiler
Git-Commit-ID: 829fe4aa9ac16417a904ad1de1307de906854bcf
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

Commit-ID:  829fe4aa9ac16417a904ad1de1307de906854bcf
Gitweb:     https://git.kernel.org/tip/829fe4aa9ac16417a904ad1de1307de906854bcf
Author:     Ben Hutchings <ben@decadent.org.uk>
AuthorDate: Wed, 29 Aug 2018 20:43:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 31 Aug 2018 17:08:22 +0200

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
