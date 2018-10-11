Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EFC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518AE213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyLDtxJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518AE213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeJKXPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E8921480;
        Thu, 11 Oct 2018 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272863;
        bh=IptiRGNZMjwFQpUCafl0ziIk3SzyeeMT+jMoQdC3qZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyLDtxJwEqMztDL6gQv4hEU6JFJ1kMSVosVPMluq8iS5OS5XAyEBXOysnjgUIZwyO
         /LGK7IV6unJevoyvGgEEFzf79/W8tRq4Fb+yQ/czcUQ0vAPDscpHrpEx3bPEaHmAyf
         C9BcIy7eRR5fl2Gh2dJmp2bjeG0w83R5zpcxIxuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, nikola.ciprich@linuxbox.cz,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Rickard <matt@softrans.com.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, jason.vas.dias@gmail.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.18 20/44] x86/vdso: Only enable vDSO retpolines when enabled and supported
Date:   Thu, 11 Oct 2018 17:39:58 +0200
Message-Id: <20181011152453.354457669@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 4f166564014aba65ad6f15b612f6711fd0f117ee upstream.

When I fixed the vDSO build to use inline retpolines, I messed up
the Makefile logic and made it unconditional.  It should have
depended on CONFIG_RETPOLINE and on the availability of compiler
support.  This broke the build on some older compilers.

Reported-by: nikola.ciprich@linuxbox.cz
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jason.vas.dias@gmail.com
Cc: stable@vger.kernel.org
Fixes: 2e549b2ee0e3 ("x86/vdso: Fix vDSO build if a retpoline is emitted")
Link: http://lkml.kernel.org/r/08a1f29f2c238dd1f493945e702a521f8a5aa3ae.1538540801.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vdso/Makefile |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -72,7 +72,13 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.d
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
-       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO $(RETPOLINE_VDSO_CFLAGS)
+       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
+
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_VDSO_CFLAGS),)
+  CFL += $(RETPOLINE_VDSO_CFLAGS)
+endif
+endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
@@ -144,7 +150,13 @@ KBUILD_CFLAGS_32 += $(call cc-option, -f
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_VDSO_CFLAGS),)
+  KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+endif
+endif
+
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
 $(obj)/vdso32.so.dbg: FORCE \


