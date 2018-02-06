Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeBFGmi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 01:42:38 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:36891 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeBFGmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 01:42:31 -0500
X-Google-Smtp-Source: AH8x227VI1OiUZ6HQwnhXCoTn853aMD31PDo8x9acdZ0knH1gTl0KHC3poxTzENKP+PFNQiP6YDpdFkbi2ixL43UioY=
MIME-Version: 1.0
In-Reply-To: <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com> <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 5 Feb 2018 22:42:29 -0800
Message-ID: <CAJWu+orKkgYMjTxRiaHbjGAxeWT1YZQvpDR7ofpWcJreCi9Zgw@mail.gmail.com>
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in select_idle_sibling
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Cc: EAS Dev" <eas-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:47 AM, Rohit Jain <rohit.k.jain@oracle.com> wrote:
[...]
>>> @@ -6102,7 +6107,8 @@ static int select_idle_core(struct task_struct *p,
>>> struct sched_domain *sd, int
>>>    */
>>>   static int select_idle_smt(struct task_struct *p, struct sched_domain
>>> *sd, int target)
>>>   {
>>> -       int cpu;
>>> +       int cpu, rcpu = -1;
>>> +       unsigned long max_cap = 0;
>>>
>>>          if (!static_branch_likely(&sched_smt_present))
>>>                  return -1;
>>> @@ -6110,11 +6116,13 @@ static int select_idle_smt(struct task_struct *p,
>>> struct sched_domain *sd, int t
>>>          for_each_cpu(cpu, cpu_smt_mask(target)) {
>>>                  if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>>>                          continue;
>>> -               if (idle_cpu(cpu))
>>> -                       return cpu;
>>> +               if (idle_cpu(cpu) && (capacity_of(cpu) > max_cap)) {
>>> +                       max_cap = capacity_of(cpu);
>>> +                       rcpu = cpu;
>>
>> At the SMT level, do you need to bother with choosing best capacity
>> among threads? If RT is eating into one of the SMT thread's underlying
>> capacity, it would eat into the other's. Wondering what's the benefit
>> of doing this here.
>
>
> Yes, you are right because of SD_SHARE_CPUCAPACITY, however the benefit
> is that if don't do this check, we might end up picking a SMT thread
> which has "high" RT/IRQ activity and be on the run queue for a while,
> till the pull side can bail us out.

Do your tests show a difference in results though with such change
(for select_idle_smt)?

thanks,

- Joel
