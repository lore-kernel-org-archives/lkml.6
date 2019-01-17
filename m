Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB18C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3C520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lQIgHz1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfAQMHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:07:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37958 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfAQMHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:07:32 -0500
Received: from zn.tnic (p200300EC2BCAA900AC94893E33AB057A.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:ac94:893e:33ab:57a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFE381EC078A;
        Thu, 17 Jan 2019 13:07:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547726850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=oqxc8XvlNadFHxCwBSOkfLS2O17JSo6TR/tFyneU3Q0=;
        b=lQIgHz1kkRE0RLH5Wpuz9HO12N5dAmQ5VxfW19jeoCBw6NgxXQUkBTr9vwVecfxQri8Cuh
        WLqfSrGm4XQMSSCz2Z9HSlPljzzVHU8Fw3JiBqEMyaKnVaWW4SW4G/ASe2UwE9J5k9m9GJ
        aiDdju3CUz049WmVunbllhlB+j498+U=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86/traps: Have read_cr0() only once in the #NM handler
Date:   Thu, 17 Jan 2019 13:07:28 +0100
Message-Id: <20190117120728.3811-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... instead of twice in the code. In any case, CR0 ends up being read
once anyway:

1. The CONFIG_MATH_EMULATION case does so and exits.
2. The normal case does it once too.

However, read it on function entry instead to make the code even simpler
to follow.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/traps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9b7c4ca8f0a7..2684a9d11e66 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -880,12 +880,12 @@ do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
 dotraplinkage void
 do_device_not_available(struct pt_regs *regs, long error_code)
 {
-	unsigned long cr0;
+	unsigned long cr0 = read_cr0();
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
 #ifdef CONFIG_MATH_EMULATION
-	if (!boot_cpu_has(X86_FEATURE_FPU) && (read_cr0() & X86_CR0_EM)) {
+	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
 
 		cond_local_irq_enable(regs);
@@ -897,7 +897,6 @@ do_device_not_available(struct pt_regs *regs, long error_code)
 #endif
 
 	/* This should not happen. */
-	cr0 = read_cr0();
 	if (WARN(cr0 & X86_CR0_TS, "CR0.TS was set")) {
 		/* Try to fix it up and carry on. */
 		write_cr0(cr0 & ~X86_CR0_TS);
-- 
2.19.1

