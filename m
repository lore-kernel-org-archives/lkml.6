Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeC1OCI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:02:08 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:53197 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbeC1OCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:02:06 -0400
X-Google-Smtp-Source: AIpwx4/1Hgoelan0Naue85Ns/nWvhwjVThKbf/lwH/a+eDHE++gALdipTfbYOqilrIfP3OBHC1M26XQyGGJIyQ/TIok=
MIME-Version: 1.0
In-Reply-To: <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org> <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
 <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 28 Mar 2018 16:01:44 +0200
Message-ID: <CAKfTPtDigSEOmtxk7daTTBb3o6kVR8AgUVhu4X6YWutK9yWNwg@mail.gmail.com>
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SE2HYD021476

Hi,

On 28 March 2018 at 12:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> Hi,
>
> On 03/24/2018 01:47 PM, Heiner Kallweit wrote:
>>
>> Am 24.03.2018 um 07:46 schrieb Vincent Guittot:
>>>
>>> Hi Heiner,
>>>
>>> Le Friday 23 Mar 2018 à 22:28:09 (+0100), Heiner Kallweit a écrit :
>>>>
>>>> Recently I started to get the following problems with linux-next:
>>>>
>>>> - When working via Putty/SSH on the system the console frequently
>>>> freezes
>>>>    for few seconds. Sometimes only opening a second console makes the
>>>>    first one react again.
>>>>
>>>> - I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
>>>>    described in [1].
>>>>
>
> I can't catch this issue on my Juno r0 (arm64 big.Little).
>
> root@juno:~# uname -r
> 4.16.0-rc4-00198-g31e77c93e432
>
> I'm using openssh-client and openssh-server though.

I think that I have finally been able to reproduce it on my hikey
(octo cortex-A53) after unplugging 6 cores and waiting for almost 2
hours
This seems to happen only on dual core system as I haven't faced that
before on the hikey which I have used for my tests

[  191.365730] CPU2: shutdown
[  191.368482] psci: CPU2 killed.
[  195.601017] CPU3: shutdown
[  195.603767] psci: CPU3 killed.
[  199.037500] CPU4: shutdown
[  199.040251] psci: CPU4 killed.
[  201.813237] CPU5: shutdown
[  201.815996] psci: CPU5 killed.
[  204.624902] CPU6: shutdown
[  204.627646] psci: CPU6 killed.
[  207.652478] CPU7: shutdown
[  207.655204] psci: CPU7 killed.
[ 6017.160463] INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 6017.166151] 1-...!: (4 GPs behind) idle=e20/0/0 softirq=10820/10864 fqs=0
[ 6017.173113] (detected by 0, t=20705 jiffies, g=1389, c=1388, q=27)
[ 6017.179386] Task dump for CPU 1:
[ 6017.182612] swapper/1       R  running task        0     0      1 0x00000000
[ 6017.189666] Call trace:
[ 6017.192120]  __switch_to+0x8c/0xd0
[ 6017.195524]  cpuidle_enter_state+0x64/0x360
[ 6017.199706]  cpuidle_enter+0x18/0x20
[ 6017.203282]  call_cpuidle+0x18/0x30
[ 6017.206771]  do_idle+0x1a4/0x1e0
[ 6017.209999]  cpu_startup_entry+0x20/0x28
[ 6017.213923]  secondary_start_kernel+0x188/0x1c8
[ 6017.218457] rcu_preempt kthread starved for 20705 jiffies! g1389
c1388 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[ 6017.228985] rcu_preempt     I    0     8      2 0x00000000
[ 6017.234474] Call trace:
[ 6017.236918]  __switch_to+0x8c/0xd0
[ 6017.240322]  __schedule+0x1b8/0x730
[ 6017.243810]  schedule+0x38/0xa0
[ 6017.246952]  schedule_timeout+0x194/0x428
[ 6017.250964]  rcu_gp_kthread+0x4d4/0x780
[ 6017.254802]  kthread+0xfc/0x128
[ 6017.257942]  ret_from_fork+0x10/0x18
[ 6066.541736] INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 6066.547428] 1-...!: (5 GPs behind) idle=e28/0/0 softirq=10820/10864 fqs=0
[ 6066.554392] (detected by 0, t=12345 jiffies, g=1390, c=1389, q=48)
[ 6066.560666] Task dump for CPU 1:
[ 6066.563893] swapper/1       R  running task        0     0      1 0x00000000
[ 6066.570948] Call trace:
[ 6066.573404]  __switch_to+0x8c/0xd0
[ 6066.576809]  cpuidle_enter_state+0x64/0x360
[ 6066.580992]  cpuidle_enter+0x18/0x20
[ 6066.584568]  call_cpuidle+0x18/0x30
[ 6066.588056]  do_idle+0x1a4/0x1e0
[ 6066.591284]  cpu_startup_entry+0x20/0x28
[ 6066.595208]  secondary_start_kernel+0x188/0x1c8
[ 6066.599742] rcu_preempt kthread starved for 12345 jiffies! g1390
c1389 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[ 6066.610270] rcu_preempt     I    0     8      2 0x00000000
[ 6066.615758] Call trace:
[ 6066.618203]  __switch_to+0x8c/0xd0
[ 6066.621607]  __schedule+0x1b8/0x730
[ 6066.625095]  schedule+0x38/0xa0
[ 6066.628236]  schedule_timeout+0x194/0x428
[ 6066.632249]  rcu_gp_kthread+0x4d4/0x780
[ 6066.636087]  kthread+0xfc/0x128

>
>>>> Bisecting the issue resulted in:
>>>>
>>>> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
>>>> commit 31e77c93e432dec79c7d90b888bbfc3652592741
>>>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>>>> Date:   Wed Feb 14 16:26:46 2018 +0100
>>>>
>>>>      sched/fair: Update blocked load when newly idle
>>>>
>>>>      When NEWLY_IDLE load balance is not triggered, we might need to
>>>> update the
>>>>      blocked load anyway. We can kick an ilb so an idle CPU will take
>>>> care of
>>>>      updating blocked load or we can try to update them locally before
>>>> entering
>>>>      idle. In the latter case, we reuse part of the nohz_idle_balance.
>>>>
>>>> After reversing this commit at least the issue with the freezing console
>>>> is gone. The second one appeared only sporadically, I still have to see
>>>> whether it pops up again.
>
>
> [...]
>
