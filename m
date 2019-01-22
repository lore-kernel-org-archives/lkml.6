Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C12DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686B420870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAVNby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:31:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfAVNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:31:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MDUvwu2962282
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 05:30:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MDUu592962279;
        Tue, 22 Jan 2019 05:30:56 -0800
Date:   Tue, 22 Jan 2019 05:30:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-ee35b9b9f6d52ba134b4e75442531935f295be7a@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de, bp@suse.de,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, bp@suse.de, mingo@kernel.org,
          luto@kernel.org, hpa@zytor.com, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190117120728.3811-1-bp@alien8.de>
References: <20190117120728.3811-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/traps: Have read_cr0() only once in the #NM
 handler
Git-Commit-ID: ee35b9b9f6d52ba134b4e75442531935f295be7a
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

Commit-ID:  ee35b9b9f6d52ba134b4e75442531935f295be7a
Gitweb:     https://git.kernel.org/tip/ee35b9b9f6d52ba134b4e75442531935f295be7a
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 17 Jan 2019 13:02:05 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 22 Jan 2019 14:13:35 +0100

x86/traps: Have read_cr0() only once in the #NM handler

... instead of twice in the code. In any case, CR0 ends up being read
once anyway:

1. The CONFIG_MATH_EMULATION case does so and exits.
2. The normal case does it once too.

However, read it on function entry instead to make the code even simpler
to follow.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190117120728.3811-1-bp@alien8.de
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
