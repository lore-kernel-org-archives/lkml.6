Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeFAHLB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:11:01 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:39290 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750729AbeFAHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:11:00 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RESEND, v3, 2/2] sched/deadline: Initialize cp->elements[].cpu
 to an invalid value
To: Joel Fernandes <joel@joelfernandes.org>
Cc: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com
References: <1515392081-32320-2-git-send-email-byungchul.park@lge.com>
 <20180601061255.GA189147@joelaf.mtv.corp.google.com>
 <20180601061841.GA191514@joelaf.mtv.corp.google.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <b61c30fe-bc16-0f12-7a20-46a89f7cea55@lge.com>
Date: Fri, 1 Jun 2018 16:10:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601061841.GA191514@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-01 15:18, Joel Fernandes wrote:
> On Thu, May 31, 2018 at 11:12:55PM -0700, Joel Fernandes wrote:
>> On Mon, Jan 08, 2018 at 03:14:41PM +0900, byungchul park wrote:
>>> Currently, migrating tasks to cpu0 unconditionally happens when the
>>> heap is empty, since cp->elements[].cpu was initialized to 0(=cpu0).
>>> We have to distinguish between the empty case and cpu0 to avoid the
>>> unnecessary migrations. Therefore, it has to return an invalid value
>>> e.i. -1 in that case.
>>>
>>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>>> ---
>>>   kernel/sched/cpudeadline.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
>>> index 9f02035..bcf903f 100644
>>> --- a/kernel/sched/cpudeadline.c
>>> +++ b/kernel/sched/cpudeadline.c
>>> @@ -138,6 +138,12 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>>>   		int best_cpu = cpudl_maximum_cpu(cp);
>>>   		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
>>>   
>>> +		/*
>>> +		 * The heap tree is empty for now, just return.
>>> +		 */
>>> +		if (best_cpu == -1)
>>> +			return 0;
>>> +
>>>   		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
>>>   		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
>>>   			if (later_mask)
>>> @@ -265,8 +271,10 @@ int cpudl_init(struct cpudl *cp)
>>>   		return -ENOMEM;
>>>   	}
>>>   
>>> -	for_each_possible_cpu(i)
>>> +	for_each_possible_cpu(i) {
>>> +		cp->elements[i].cpu = -1;
>>>   		cp->elements[i].idx = IDX_INVALID;
>>
>> Shouldn't you also set cp->elements[cpu].cpu to -1 in cpudl_clear (when you
>> set cp->elements[cpu].cpu to IDX_INVALID there)?
> 
> I messed up my words, I meant : "when setting cp->elements[cpu].idx to
> IDX_INVALID there". Which means I need to call it a day :-)

Ah.. I agree with you. It might be a problem when removing the last
element.. Then I think the following change should also be applied
additionally. Right?

---
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8d9562d..44d4c88 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -172,12 +172,14 @@ void cpudl_clear(struct cpudl *cp, int cpu)
         } else {
                 new_cpu = cp->elements[cp->size - 1].cpu;
                 cp->elements[old_idx].dl = cp->elements[cp->size - 1].dl;
-               cp->elements[old_idx].cpu = new_cpu;
+               cp->elements[old_idx].cpu = (new_cpu == cpu) ? -1 : new_cpu;
                 cp->size--;
-               cp->elements[new_cpu].idx = old_idx;
                 cp->elements[cpu].idx = IDX_INVALID;
-               cpudl_heapify(cp, old_idx);

+               if (new_cpu != cpu) {
+                       cp->elements[new_cpu].idx = old_idx;
+                       cpudl_heapify(cp, old_idx);
+               }
                 cpumask_set_cpu(cpu, cp->free_cpus);
         }
         raw_spin_unlock_irqrestore(&cp->lock, flags);

-- 
Thanks,
Byungchul
