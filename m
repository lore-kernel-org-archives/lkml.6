Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96712C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD572098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXlRGEEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD572098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeJCLNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeJCLNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:13:30 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7682064E;
        Wed,  3 Oct 2018 04:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538540811;
        bh=QUW41wjaexPU1xyJ9+QQ97NZ+mHGTMF8AezoHD8T2wA=;
        h=From:To:Cc:Subject:Date:From;
        b=GXlRGEEnJGsXLu7NVzUO/Ac5bORwfzzpDgX92sG/OXCeUtp7zfxryNF85EhmvAwhT
         fPGZTzKsK4ZSYg/vwPCVldpfJBiHOKJ7fTehtMMMISViuMvL/jspGrlAbsELvAbkSi
         i07GMJ8Wn7K2+RDqSws81WkmpdW2Igpn0RKnHR5E=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>, jason.vas.dias@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, nikola.ciprich@linuxbox.cz
Subject: [PATCH] x86/vdso: Only enable vDSO retpolines when enabled and supported
Date:   Tue,  2 Oct 2018 21:26:50 -0700
Message-Id: <08a1f29f2c238dd1f493945e702a521f8a5aa3ae.1538540801.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I fixed the vDSO build to use inline retpolines, I messed up
the Makefile logic and made it unconditional.  It should have
depended on CONFIG_RETPOLINE and on the availability of compiler
support.  This broke the build on some older compilers.

Fixes: 2e549b2ee0e3 ("x86/vdso: Fix vDSO build if a retpoline is emitted")
Cc: stable@vger.kernel.org
Reported-by: nikola.ciprich@linuxbox.cz
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Borislav Petkov <bp@alien8.de>
Cc: jason.vas.dias@gmail.com
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: nikola.ciprich@linuxbox.cz
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index fa3f439f0a92..141d415a8c80 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -68,7 +68,13 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
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
 
@@ -138,7 +144,13 @@ KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
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
-- 
2.17.1

