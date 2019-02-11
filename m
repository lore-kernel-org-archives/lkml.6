Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E36C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C821B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfBKR7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:59:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731153AbfBKR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:59:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8DBEBD;
        Mon, 11 Feb 2019 09:59:48 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22B2D3F675;
        Mon, 11 Feb 2019 09:59:46 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 4/4] arm64: Check user stack pointer on syscall entry
Date:   Mon, 11 Feb 2019 17:59:35 +0000
Message-Id: <20190211175935.4602-5-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211175935.4602-1-will.deacon@arm.com>
References: <20190211175935.4602-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the user stack pointer value to be checked on system call entry
and deliver a SIGSEGV if the check does not pass.

Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig          | 1 +
 arch/arm64/kernel/syscall.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..e87304a06a85 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -29,6 +29,7 @@ config ARM64
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_USP_CHECK_SYSCALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5610ac01c1ec..06566010f6d1 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -11,6 +11,7 @@
 #include <asm/fpsimd.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
+#include <asm/traps.h>
 #include <asm/unistd.h>
 
 long compat_arm_syscall(struct pt_regs *regs, int scno);
@@ -71,6 +72,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
 
+	if (!usp_check_syscall())
+		force_signal_inject(SIGSEGV, SEGV_MAPERR, GET_USP(regs));
+
 	if (has_syscall_work(flags)) {
 		/* set default errno for user-issued syscall(-1) */
 		if (scno == NO_SYSCALL)
-- 
2.11.0

