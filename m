Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AC32175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ngkncW9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfA1QKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:10:06 -0500
Received: from mail.efficios.com ([167.114.142.138]:42678 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbfA1QKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:03 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7E38AA8100;
        Mon, 28 Jan 2019 11:10:01 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id MbrNQQloizD8; Mon, 28 Jan 2019 11:10:01 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F17F1A80EF;
        Mon, 28 Jan 2019 11:10:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F17F1A80EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548691801;
        bh=KYShf19TXR9m2jTwCnCZmqdMNvUKpI/3n5He2PO31Y0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ngkncW9ITgkASz3Ul0oJtABxJR8ma5XrqvEexFhfsgIdQWGiS0RuEHbY8m+MRQx1N
         fFO8N2Rl4i/0KFnTrePDH9vBTlfGXnFtIduq/XR1ZuGgqp8HS0QIyl+e5rGvO64J9i
         3xsmt9IzS7kngQpBRyzzFvnt2FuPjOIshJiXtTzVfP/s6ApVoG8ncNOTOzfC/UQ21p
         AGMbK2xscdw9BpT6faqlw2rfu16OmSymZxmiH5gKIHRWplZWA2a8T9x414VG37/YgW
         6cSgyroIofCGrSDZXgkHptq3FLjjHvB1jMTWJGA3F/afoKW/QFPp1muGKp+Nu0oP57
         f/r7WbRpC94zQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id mY_RVykFr1LS; Mon, 28 Jan 2019 11:10:00 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id DD84DA80E9;
        Mon, 28 Jan 2019 11:10:00 -0500 (EST)
Date:   Mon, 28 Jan 2019 11:10:00 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1963434274.2063.1548691800642.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190128141553.GM4240@linux.ibm.com>
References: <CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com> <20190128141553.GM4240@linux.ibm.com>
Subject: Re: [BUG] racy access to p->mm in membarrier_global_expedited()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: racy access to p->mm in membarrier_global_expedited()
Thread-Index: ooDVAiF29mSOQHRq6LS7KW27uYGqGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 28, 2019, at 9:15 AM, paulmck paulmck@linux.ibm.com wrote:

> On Fri, Jan 25, 2019 at 06:26:47PM +0100, Jann Horn wrote:
>> membarrier_global_expedited() runs the following code (introduced in
>> commit c5f58bd58f43), protected only by an RCU read-side critical
>> section and the cpu_hotplug_lock:
>> 
>>         p = task_rcu_dereference(&cpu_rq(cpu)->curr);
>>         if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
>>                            MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
>>                 if (!fallback)
>>                         __cpumask_set_cpu(cpu, tmpmask);
>>                 else
>>                         smp_call_function_single(cpu, ipi_mb, NULL, 1);
>>         }
>> 
>> p->mm is not protected by either lock. This means that in theory, the
>> following races could occur:
>> 
>> 1. If the compiler emitted two separate reads of ->mm, the second read
>> of p->mm could return a NULL pointer and crash.
>> 2. If the mm is deallocated directly before the atomic_read() occurs,
>> the atomic_read() could access a freed pointer (I think?).
>> 
>> Neither of these are particularly likely - looking at the assembly of
>> a normal build, the first race doesn't exist because the compiler
>> optimizes the second read away, and the second race isn't going to
>> cause anything particularly interesting. Still, this should probably
>> be fixed...
>> 
>> As far as I can tell, you'll have to either take the task_lock()
>> around the "p->mm && (atomic_read(&p->mm->membarrier_state)" or add
>> RCU to the lifetime of mm_struct. I'm not entirely sure what the
>> better fix is... probably task_lock() makes more sense?
> 
> Ouch!!!
> 
> Acquiring task_lock() would work, but would be a global lock.
> This could be addressed to some extent by batching concurrent
> membarrier_global_expedited() invocations, so that one call to
> membarrier_global_expedited() does the job for the set of concurrent
> calls.  The usual approach would use a counter, a pair of wait queues,
> and a kthread.

We could start by grabbing the task_lock() as an initial fix, and
then address any performance-related complains with your approach
if need be.

> 
> I must defer to the mm guys on adding RCU to the lifetime of mm_struct.

Likewise.

> Another approach would be to put the MEMBARRIER_STATE_GLOBAL_EXPEDITED
> in the task structure.

Then the tricky part becomes how to make sure the per-task-struct
state is consistent across all tasks pointing to the same mm_struct
(including processes created with clone CLONE_VM flag).

> Yet another approach would be to acquire the
> runqueue lock, thus preventing the task from switching away -- except
> that it might be in the middle of exit(), so never mind.

And I suspect that grabbing the runqueue lock may cause more contention
that grabbing the task_lock().

I'll send a patch implementing the task_lock() approach as RFC.

Thanks,

Mathieu

> 
> Other approaches?
> 
>							Thanx, Paul
> 
>> To test the bug, I patched an extra delay into the code:
>> 
>> ====================
>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>> index 3cd8a3a795d2..69cc52039576 100644
>> --- a/kernel/sched/membarrier.c
>> +++ b/kernel/sched/membarrier.c
>> @@ -14,6 +14,7 @@
>>   * GNU General Public License for more details.
>>   */
>>  #include "sched.h"
>> +#include <linux/delay.h>
>> 
>>  /*
>>   * Bitmask made from a "or" of all commands within enum membarrier_cmd,
>> @@ -81,7 +82,7 @@ static int membarrier_global_expedited(void)
>> 
>>                 rcu_read_lock();
>>                 p = task_rcu_dereference(&cpu_rq(cpu)->curr);
>> -               if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
>> +               if (p && p->mm && (mdelay(100), 1) &&
>> (atomic_read(&p->mm->membarrier_state) &
>>                                    MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
>>                         if (!fallback)
>>                                 __cpumask_set_cpu(cpu, tmpmask);
>> ====================
>> 
>> On a kernel with that patch applied, I ran this test code:
>> 
>> ====================
>> #define _GNU_SOURCE
>> #include <unistd.h>
>> #include <sys/syscall.h>
>> #include <stdio.h>
>> #include <linux/membarrier.h>
>> #include <err.h>
>> 
>> int main(void) {
>>   while (1) {
>>     printf("executing global expedited barrier...\n");
>>     int res = syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL_EXPEDITED, 0);
>>     if (res) err(1, "barrier");
>>   }
>> }
>> ====================
>> 
>> That resulted in this splat:
>> 
>> [  212.697681]
>> ==================================================================
>> [  212.700582] BUG: KASAN: null-ptr-deref in
>> membarrier_global_expedited+0x15f/0x220
>> [  212.703346] Read of size 4 at addr 0000000000000378 by task barrier/1177
>> 
>> [  212.706384] CPU: 1 PID: 1177 Comm: barrier Not tainted 5.0.0-rc3+ #246
>> [  212.708925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.10.2-1 04/01/2014
>> [  212.712263] Call Trace:
>> [  212.713177]  dump_stack+0x71/0xab
>> [  212.714375]  ? membarrier_global_expedited+0x15f/0x220
>> [  212.716236]  ? membarrier_global_expedited+0x15f/0x220
>> [  212.718099]  kasan_report+0x176/0x192
>> [  212.719445]  ? finish_task_switch+0x340/0x3d0
>> [  212.721057]  ? membarrier_global_expedited+0x15f/0x220
>> [  212.722921]  membarrier_global_expedited+0x15f/0x220
>> [  212.724696]  ? ipi_mb+0x10/0x10
>> [  212.725816]  ? vfs_write+0x120/0x230
>> [  212.727113]  ? __ia32_sys_read+0x50/0x50
>> [  212.728596]  __x64_sys_membarrier+0x85/0xf0
>> [  212.730056]  do_syscall_64+0x73/0x160
>> [  212.731428]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  212.733236] RIP: 0033:0x7fbe8747e229
>> [  212.734540] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
>> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
>> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c 2b 00 f7 d8 64 89
>> 01 48
>> [  212.741109] RSP: 002b:00007fffcb62a7c8 EFLAGS: 00000202 ORIG_RAX:
>> 0000000000000144
>> [  212.743831] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbe8747e229
>> [  212.746335] RDX: 00007fbe87475730 RSI: 0000000000000000 RDI: 0000000000000002
>> [  212.748855] RBP: 00007fffcb62a7e0 R08: 00007fffcb62a8c0 R09: 00007fffcb62a8c0
>> [  212.751374] R10: 00007fbe8793c700 R11: 0000000000000202 R12: 0000563ee2ac9610
>> [  212.753842] R13: 00007fffcb62a8c0 R14: 0000000000000000 R15: 0000000000000000
>> [  212.756305]
>> ==================================================================

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
