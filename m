Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEBEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92F220658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92F220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeICV6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:58:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbeICV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:58:24 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6CEAEBAE;
        Mon,  3 Sep 2018 17:37:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helmut Grohne <helmutg@debian.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 086/123] x86: Allow generating user-space headers without a compiler
Date:   Mon,  3 Sep 2018 18:57:10 +0200
Message-Id: <20180903165723.167642010@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit 829fe4aa9ac16417a904ad1de1307de906854bcf upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Makefile |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -180,10 +180,6 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
 
-ifndef CC_HAVE_ASM_GOTO
-  $(error Compiler lacks asm-goto support.)
-endif
-
 #
 # Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent a
 # GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46226).  There's no way
@@ -317,6 +313,13 @@ PHONY += vdso_install
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


