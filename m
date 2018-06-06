Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKMMovdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5FC5601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeFFKeD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:34:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44651 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeFFKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:34:01 -0400
X-Google-Smtp-Source: ADUXVKLY7pu0vrcpW36m2KdWwyhtx0kyPpdXRfnJ0+HhfeVyt5D5lIYrcFeS0tZCOXnkxDrAYhMkbQ==
Date: Wed, 6 Jun 2018 19:33:56 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180606103356.GB19211@tigerII.localdomain>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606051029.GA19211@tigerII.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/06/18 14:10), Sergey Senozhatsky wrote:
> On (06/05/18 14:47), Petr Mladek wrote:
> [..]
> > Grr, the ABBA deadlock is still there. NMIs are not sent to the other
> > CPUs atomically. Even if we detect that logbuf_lock is available
> > in printk_nmi_enter() on some CPUs, it might still get locked on
> > another CPU before the other CPU gets NMI.
> 
> Can we do something about "B"? :) I mean - any chance we can rework
> locking in nmi_cpu_backtrace()?

Sorry, I don't have that much free time at the moment, so can't
fully concentrate on this issue.

Here is a quick-n-dirty thought.

The whole idea of printk_nmi() was to reduce the number of locks
we take performing printk() from NMI context - ideally down to 0.
We added logbuf spin_lock later on. One lock was fine. But then
we added another one - nmi_cpu_backtrace() lock. And two locks is
too many. So can we drop the nmi_cpu_backtrace() lock, and in
exchange extend printk-safe API with functions that will disable/enable
PRINTK_NMI_DEFERRED_CONTEXT_MASK on a particular CPU?

I refer to it as HARD and SOFT printk_nmi :) Just for fun. Hard one
has no right to use logbuf and will use only per-CPU buffer, while
soft one can use either per-CPU buffer or logbuf.

---

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 0ace3c907290..b57d5daa90b5 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -90,11 +90,10 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
-	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
-		arch_spin_lock(&lock);
+		printk_nmi_hard();
 		if (regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
@@ -105,7 +104,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
-		arch_spin_unlock(&lock);
+		printk_nmi_sort();
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
