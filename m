Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9952F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9952F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJROXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:23:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeJROXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:23:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6MsXC708453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:22:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6Msa4708450;
        Wed, 17 Oct 2018 23:22:54 -0700
Date:   Wed, 17 Oct 2018 23:22:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-2224d616528194b02424c91c2ee254b3d29942c3@git.kernel.org>
Cc:     bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@kernel.org, bigeasy@linutronix.de
Reply-To: bigeasy@linutronix.de, luto@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
          bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20181016202525.29437-4-bigeasy@linutronix.de>
References: <20181016202525.29437-4-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu: Fix i486 + no387 boot crash by only
 saving FPU registers on context switch if there is an FPU
Git-Commit-ID: 2224d616528194b02424c91c2ee254b3d29942c3
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

Commit-ID:  2224d616528194b02424c91c2ee254b3d29942c3
Gitweb:     https://git.kernel.org/tip/2224d616528194b02424c91c2ee254b3d29942c3
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 16 Oct 2018 22:25:25 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 17 Oct 2018 12:30:38 +0200

x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on context switch if there is an FPU

Booting an i486 with "no387 nofxsr" ends with with the following crash:

   math_emulate: 0060:c101987d
   Kernel panic - not syncing: Math emulation needed in kernel

on the first context switch in user land.

The reason is that copy_fpregs_to_fpstate() tries FNSAVE which does not work
as the FPU is turned off.

This bug was introduced in:

  f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active users to fpu->fpstate_active")

Add a check for X86_FEATURE_FPU before trying to save FPU registers (we
have such a check in switch_fpu_finish() already).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active users to fpu->fpstate_active")
Link: http://lkml.kernel.org/r/20181016202525.29437-4-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37a..69dcdf195b61 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -528,7 +528,7 @@ static inline void fpregs_activate(struct fpu *fpu)
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (old_fpu->initialized) {
+	if (static_cpu_has(X86_FEATURE_FPU) && old_fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
