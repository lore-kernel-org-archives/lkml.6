Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC1DWp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:22:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44530 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeC1DWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:22:43 -0400
X-Google-Smtp-Source: AIpwx49Q7kb9zZNJzGgFElO8zHa8xbMT/sP9mkE2Ag8fOUkOOu7OA7z+ttWCQrlzrOVU6glpPKsSfQ==
From: Eric Dumazet <edumazet@google.com>
To: x86 <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86, msr: fix rdmsrl_safe_on_cpu()
Date: Tue, 27 Mar 2018 20:22:33 -0700
Message-Id: <20180328032233.153055-1-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing rdmsr_safe_on_cpu() to schedule, I missed that
__rdmsr_safe_on_cpu() was also used by rdmsrl_safe_on_cpu()

Lets make rdmsrl_safe_on_cpu() a wrapper instead of copy/pasting
the code I added for the completion handling.

Fixes: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/lib/msr-smp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 761ba062afdaf7f7d0603ed94ed6cc3e46b37f76..fee8b9c0520c9954e3cf9093332e1a9b53009b8b 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -225,16 +225,13 @@ EXPORT_SYMBOL(wrmsrl_safe_on_cpu);
 
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
+	u32 low, high;
 	int err;
-	struct msr_info rv;
 
-	memset(&rv, 0, sizeof(rv));
+	err = rdmsr_safe_on_cpu(cpu, msr_no, &low, &high);
+	*q = (u64)high << 32 | low;
 
-	rv.msr_no = msr_no;
-	err = smp_call_function_single(cpu, __rdmsr_safe_on_cpu, &rv, 1);
-	*q = rv.reg.q;
-
-	return err ? err : rv.err;
+	return err;
 }
 EXPORT_SYMBOL(rdmsrl_safe_on_cpu);
 
-- 
2.17.0.rc1.321.gba9d0f2565-goog
