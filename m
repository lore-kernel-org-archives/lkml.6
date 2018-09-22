Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DCCC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35322156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35322156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391880AbeIVGKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44071 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391841AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BM-9h; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000pn-4h; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, x86@kernel.org,
        "Andy Lutomirski" <luto@kernel.org>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.328124575@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 02/63] x86/fpu: Default eagerfpu if FPU and FXSR are
 enabled
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

This is a limited version of commit 58122bf1d856 "x86/fpu: Default
eagerfpu=on on all CPUs".  That commit revealed bugs in the use of
eagerfpu together with math emulation or without the FXSR feature.
Although those bugs have been fixed upstream, the fixes do not seem to
be practical to backport to 3.16.

The security issue that motivates using eagerfpu (CVE-2018-3665) is an
information leak through speculative execution, and most CPUs lacking
the FXSR feature also don't implement speculative execution.  The
exceptions I am aware of are the Intel Pentium Pro and AMD K6 family,
which will remain vulnerable to this issue.

Move the eagerfpu variable and associated initialisation into
fpu_init(), since xstate_enable_boot_cpu() won't be called at all if
XSAVE is disabled.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
---
--- a/arch/x86/kernel/xsave.c
+++ b/arch/x86/kernel/xsave.c
@@ -509,19 +509,6 @@ static void __init setup_init_fpu_buf(vo
 	xsave_state(init_xstate_buf, -1);
 }
 
-static enum { AUTO, ENABLE, DISABLE } eagerfpu = AUTO;
-static int __init eager_fpu_setup(char *s)
-{
-	if (!strcmp(s, "on"))
-		eagerfpu = ENABLE;
-	else if (!strcmp(s, "off"))
-		eagerfpu = DISABLE;
-	else if (!strcmp(s, "auto"))
-		eagerfpu = AUTO;
-	return 1;
-}
-__setup("eagerfpu=", eager_fpu_setup);
-
 /*
  * Enable and initialize the xsave feature.
  */
@@ -560,17 +547,11 @@ static void __init xstate_enable_boot_cp
 	prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 
-	/* Auto enable eagerfpu for xsaveopt */
-	if (cpu_has_xsaveopt && eagerfpu != DISABLE)
-		eagerfpu = ENABLE;
-
 	if (pcntxt_mask & XSTATE_EAGER) {
-		if (eagerfpu == DISABLE) {
+		if (!boot_cpu_has(X86_FEATURE_EAGER_FPU)) {
 			pr_err("eagerfpu not present, disabling some xstate features: 0x%llx\n",
 					pcntxt_mask & XSTATE_EAGER);
 			pcntxt_mask &= ~XSTATE_EAGER;
-		} else {
-			eagerfpu = ENABLE;
 		}
 	}
 
@@ -613,9 +594,6 @@ void eager_fpu_init(void)
 	clear_used_math();
 	current_thread_info()->status = 0;
 
-	if (eagerfpu == ENABLE)
-		setup_force_cpu_cap(X86_FEATURE_EAGER_FPU);
-
 	if (!cpu_has_eager_fpu) {
 		stts();
 		return;
--- a/arch/x86/kernel/i387.c
+++ b/arch/x86/kernel/i387.c
@@ -159,6 +159,19 @@ static void init_thread_xstate(void)
 		xstate_size = sizeof(struct i387_fsave_struct);
 }
 
+static enum { AUTO, ENABLE, DISABLE } eagerfpu = AUTO;
+static int __init eager_fpu_setup(char *s)
+{
+	if (!strcmp(s, "on"))
+		eagerfpu = ENABLE;
+	else if (!strcmp(s, "off"))
+		eagerfpu = DISABLE;
+	else if (!strcmp(s, "auto"))
+		eagerfpu = AUTO;
+	return 1;
+}
+__setup("eagerfpu=", eager_fpu_setup);
+
 /*
  * Called at bootup to set up the initial FPU state that is later cloned
  * into all processes.
@@ -197,6 +210,17 @@ void fpu_init(void)
 	if (xstate_size == 0)
 		init_thread_xstate();
 
+	/*
+	 * We should always enable eagerfpu, but it doesn't work properly
+	 * here without fpu and fxsr.
+	 */
+	if (eagerfpu == AUTO)
+		eagerfpu = (boot_cpu_has(X86_FEATURE_FPU) &&
+			    boot_cpu_has(X86_FEATURE_FXSR)) ?
+			ENABLE : DISABLE;
+	if (eagerfpu == ENABLE)
+		setup_force_cpu_cap(X86_FEATURE_EAGER_FPU);
+
 	mxcsr_feature_mask_init();
 	xsave_init();
 	eager_fpu_init();

