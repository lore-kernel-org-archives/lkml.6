Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeAaHFV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:05:21 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47508 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeAaHFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:05:19 -0500
Date: Wed, 31 Jan 2018 08:03:00 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: mingo@kernel.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc: jpoimboe@redhat.com
Subject: Re: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
Message-ID: <20180131070300.GA28206@light.dominikbrodowski.net>
References: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
 <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:39:45PM -0800, tip-bot for Tim Chen wrote:
> Commit-ID:  18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
> Gitweb:     https://git.kernel.org/tip/18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
> Author:     Tim Chen <tim.c.chen@linux.intel.com>
> AuthorDate: Mon, 29 Jan 2018 22:04:47 +0000
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Tue, 30 Jan 2018 23:09:21 +0100
> 
> x86/speculation: Use Indirect Branch Prediction Barrier in context switch
> 
> Flush indirect branches when switching into a process that marked itself
> non dumpable. This protects high value processes like gpg better,
> without having too high performance overhead.

For the record, I am still opposed to limit this to non-dumpable processes.
Whether a process needs protection by IBPB on context switches is a
different question to whether a process should be allowed to be dumped,
though the former may be a superset of the latter. In my opinion, IBPB
should be enabled on all context switches to userspace processes, until we
have a clear mitigation strategy for userspace against Spectre-v2 designed
and implemented.

Thanks,
	Dominik

--------------------------
From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Wed, 31 Jan 2018 07:43:12 +0100
Subject: [PATCH] x86/speculation: Do not limit Indirect Branch Prediction Barrier to non-dumpable processes

Whether a process needs protection by IBPB on context switches is a
different question to whether a process should be allowed to be dumped,
though the former may be a superset of the latter. Enable IBPB on all
context switches to a different userspace process, until we have a clear
mitigation strategy for userspace against Spectre-v2 designed and
implemented.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 012d02624848..f54897b68b16 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -255,19 +255,13 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * predictor when switching between processes. This stops
 		 * one process from doing Spectre-v2 attacks on another.
 		 *
-		 * As an optimization, flush indirect branches only when
-		 * switching into processes that disable dumping. This
-		 * protects high value processes like gpg, without having
-		 * too high performance overhead. IBPB is *expensive*!
-		 *
 		 * This will not flush branches when switching into kernel
 		 * threads. It will also not flush if we switch to idle
 		 * thread and back to the same process. It will flush if we
-		 * switch to a different non-dumpable process.
+		 * switch to a different user process.
 		 */
 		if (tsk && tsk->mm &&
-		    tsk->mm->context.ctx_id != last_ctx_id &&
-		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+		    tsk->mm->context.ctx_id != last_ctx_id)
 			indirect_branch_prediction_barrier();
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
