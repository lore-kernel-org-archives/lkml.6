Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034096AbeBOR65 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:58:57 -0500
Received: from foss.arm.com ([217.140.101.70]:58874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033969AbeBOR6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:58:55 -0500
Message-ID: <5A85C9C7.9060701@arm.com>
Date: Thu, 15 Feb 2018 17:56:23 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: Xie XiuQi <xiexiuqi@huawei.com>
CC: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org, Dave.Martin@arm.com,
        takahiro.akashi@linaro.org, tbaicar@codeaurora.org,
        stephen.boyd@linaro.org, bp@suse.de, julien.thierry@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com,
        zhengqiang10@huawei.com, gengdongjiu@huawei.com,
        huawei.libin@huawei.com, wangkefeng.wang@huawei.com,
        lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org,
        cj.chengjian@huawei.com
Subject: Re: [PATCH v5 1/3] arm64/ras: support sea error recovery
References: <1516969885-150532-1-git-send-email-xiexiuqi@huawei.com> <1516969885-150532-2-git-send-email-xiexiuqi@huawei.com> <5A70C536.7040208@arm.com> <5A7B4D87.9020207@arm.com> <7dacf375-4645-ba34-62d1-96d9f67dbcc2@huawei.com>
In-Reply-To: <7dacf375-4645-ba34-62d1-96d9f67dbcc2@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie XiuQi,

On 08/02/18 08:35, Xie XiuQi wrote:
> I am very glad that you are trying to solve the problem, which is very helpful.
> I agree with your proposal, and I'll test it on by box latter.
> 
> Indeed, we're in precess context when we are in sea handler. I was thought we
> can't call schedule() in the exception handler before.

While testing this I've come to the conclusion that the
memory_failure_queue_kick() approach I suggested makes arm64 behave slightly
differently with APEI, and would need re-inventing if we support kernel-first
too. The same race exists with memory-failure notifications signalled by SDEI,
and to a lesser extent IRQ. So by fixing this in arch-code, we actually making
our lives harder.

Instead, I have the patch below. This is smaller, and not arch specific. It also
saves the arch code secretly knowing that APEI calls memory_failure_queue().

I will post this as part of that series shortly...


Thanks,

James

---------------%<---------------
[PATCH] mm/memory-failure: increase queued recovery work's priority

arm64 can take an NMI-like error notification when user-space steps in
some corrupt memory. APEI's GHES code will call memory_failure_queue()
to schedule the recovery work. We then return to user-space, possibly
taking the fault again.

Currently the arch code unconditionally signals user-space from this
path, so we don't get stuck in this loop, but the affected process
never benefits from memory_failure()s recovery work. To fix this we
need to know the recovery work will run before we get back to user-space.

Increase the priority of the recovery work by scheduling it on the
system_highpri_wq, then try to bump the current task off this CPU
so that the recover work starts immediately.

Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
CC: Xie XiuQi <xiexiuqi@huawei.com>
CC: gengdongjiu <gengdongjiu@huawei.com>
---
 mm/memory-failure.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4b80ccee4535..14f44d841e8b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -55,6 +55,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm_inline.h>
+#include <linux/preempt.h>
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include "internal.h"
@@ -1319,6 +1320,7 @@ static DEFINE_PER_CPU(struct memory_failure_cpu,
memory_failure_cpu);
  */
 void memory_failure_queue(unsigned long pfn, int flags)
 {
+	int cpu = smp_processor_id();
 	struct memory_failure_cpu *mf_cpu;
 	unsigned long proc_flags;
 	struct memory_failure_entry entry = {
@@ -1328,11 +1330,14 @@ void memory_failure_queue(unsigned long pfn, int flags)

        mf_cpu = &get_cpu_var(memory_failure_cpu);
        spin_lock_irqsave(&mf_cpu->lock, proc_flags);
-       if (kfifo_put(&mf_cpu->fifo, entry))
-               schedule_work_on(smp_processor_id(), &mf_cpu->work);
-       else
+       if (kfifo_put(&mf_cpu->fifo, entry)) {
+               queue_work_on(cpu, system_highpri_wq, &mf_cpu->work);
+               set_tsk_need_resched(current);
+               preempt_set_need_resched();
+       } else {
                pr_err("Memory failure: buffer overflow when queuing memory
failure at %#lx\n",
                       pfn);
+       }
        spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
        put_cpu_var(memory_failure_cpu);
 }
---------------%<---------------
