Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BFC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9472098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9472098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJQERz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:17:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeJQERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:17:54 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCVuT-0006PK-G5; Tue, 16 Oct 2018 22:25:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] x86/fpu: Remove second definition of fpu in __fpu__restore_sig()
Date:   Tue, 16 Oct 2018 22:25:24 +0200
Message-Id: <20181016202525.29437-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016202525.29437-1-bigeasy@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert
it to fpu->fpstate_active") introduced the `fpu' variable at top of
__restore_xstate_sig() which now shadows the other definition:

|arch/x86/kernel/fpu/signal.c:318:28: warning: symbol 'fpu' shadows an earlier one
|arch/x86/kernel/fpu/signal.c:271:20: originally declared here

Remove the shadowed definition of `fpu'.

Fixes: c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 23f1691670b66..61a949d84dfa5 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -314,7 +314,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * thread's fpu state, reconstruct fxstate from the fsave
 		 * header. Validate and sanitize the copied state.
 		 */
-		struct fpu *fpu = &tsk->thread.fpu;
 		struct user_i387_ia32_struct env;
 		int err = 0;
 
-- 
2.19.1

