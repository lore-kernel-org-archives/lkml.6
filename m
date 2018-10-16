Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A55FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AE52098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AE52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeJQESJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:18:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58849 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeJQESJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:18:09 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCVuY-0006PK-DI; Tue, 16 Oct 2018 22:25:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable@vger.kernel.org
Subject: [PATCH 3/3] x86/fpu: Save FPU registers on context switch if there is a FPU
Date:   Tue, 16 Oct 2018 22:25:25 +0200
Message-Id: <20181016202525.29437-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016202525.29437-1-bigeasy@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a 486 with "no387 nofxsr" ends with
| math_emulate: 0060:c101987d
| Kernel panic - not syncing: Math emulation needed in kernel

on the first context switch in user land. The reason is that
copy_fpregs_to_fpstate() tries `fnsave' which does not work. This
happens since commit f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active
users to fpu->fpstate_active").

Add a check for X86_FEATURE_FPU before trying to save FPU registers (we
have such a check switch_fpu_finish() already).

Fixes: f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active users to fpu->fpstate_active")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37ad..69dcdf195b611 100644
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
-- 
2.19.1

