Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeC1Iit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:38:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeC1Iir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:38:47 -0400
Date: Wed, 28 Mar 2018 01:38:06 -0700
From: tip-bot for Eric Dumazet <tipbot@zytor.com>
Message-ID: <tip-9b9a51354cae933f5640b5bb73bbcd32f989122f@git.kernel.org>
Cc: mingo@kernel.org, fengguang.wu@intel.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, edumazet@google.com,
        eric.dumazet@gmail.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, edumazet@google.com, tglx@linutronix.de,
        eric.dumazet@gmail.com, fengguang.wu@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de
In-Reply-To: <20180328032233.153055-1-edumazet@google.com>
References: <20180328032233.153055-1-edumazet@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/msr: Make rdmsrl_safe_on_cpu() scheduling
 safe as well
Git-Commit-ID: 9b9a51354cae933f5640b5bb73bbcd32f989122f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9b9a51354cae933f5640b5bb73bbcd32f989122f
Gitweb:     https://git.kernel.org/tip/9b9a51354cae933f5640b5bb73bbcd32f989122f
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Tue, 27 Mar 2018 20:22:33 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 10:34:13 +0200

x86/msr: Make rdmsrl_safe_on_cpu() scheduling safe as well

When changing rdmsr_safe_on_cpu() to schedule, it was missed that
__rdmsr_safe_on_cpu() was also used by rdmsrl_safe_on_cpu()

Make rdmsrl_safe_on_cpu() a wrapper instead of copy/pasting the code which
was added for the completion handling.

Fixes: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180328032233.153055-1-edumazet@google.com

---
 arch/x86/lib/msr-smp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 761ba062afda..fee8b9c0520c 100644
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
 
