Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDLTnP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:43:15 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55665 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeDLTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:43:13 -0400
X-Google-Smtp-Source: AIpwx4+Gjv2x30opruBQAznWoVNsw9qln7c2hWboIAUG9m5RxqGfUvp+iXnbq2hOcBgMgPibWBzUwA==
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
To: Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        i@linaro.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
References: <20180412091822.GG12256@bigcity.dyn.berto.se>
 <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se>
 <20180412133031.GA551@linaro.org>
Message-ID: <a2b1e908-9e20-0c72-5f8e-bd14d4a7f3b0@gmail.com>
Date: Thu, 12 Apr 2018 21:43:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412133031.GA551@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.04.2018 um 15:30 schrieb Vincent Guittot:
> Heiner, Niklas,
> 
> Le Thursday 12 Apr 2018 à 13:15:19 (+0200), Niklas Söderlund a écrit :
>> Hi Vincent,
>>
>> Thanks for your feedback.
>>
>> On 2018-04-12 12:33:27 +0200, Vincent Guittot wrote:
>>> Hi Niklas,
>>>
>>> On 12 April 2018 at 11:18, Niklas Söderlund
>>> <niklas.soderlund@ragnatech.se> wrote:
>>>> Hi Vincent,
>>>>
>>>> I have observed issues running on linus/master from a few days back [1].
>>>> I'm running on a Renesas Koelsch board (arm32) and I can trigger a issue
>>>> by X forwarding the v4l2 test application qv4l2 over ssh and moving the
>>>> courser around in the GUI (best test case description award...). I'm
>>>> sorry about the really bad way I trigger this but I can't do it in any
>>>> other way, I'm happy to try other methods if you got some ideas. The
>>>> symptom of the issue is a complete hang of the system for more then 30
>>>> seconds and then this information is printed in the console:
>>>
>>> Heiner (edded cc) also reported similar problem with his platform: a
>>> dual core celeron
>>>
>>> Do you confirm that your platform is a dual cortex-A15 ? At least that
>>> what I have seen on web
>>> This would confirm that dual system is a key point.
>>
>> I can confirm that my platform is a dual core.
>>
>>>
>>> The ssh connection is also common with Heiner's setup
>>
>> Interesting, I found Heiner's mail and I can confirm that I too 
>> experience ssh sessions lockups. I ssh into the system and by repeatedly 
>> hitting the return key I can lockup the board, while locked up starting 
>> another ssh session unblocks the first. If I don't start another ssh 
>> session but keep hitting return key sporadically in the first one I can 
>> get the trace I reported in my first mail to be printed on the serial 
>> console.
>>
>> When locked up the symptoms are that both the single ssh session is dead 
>> and the serial console. But attempting another ssh connection 
>> immediately unblocks both ssh and serial console. And if I allow enough 
>> time before starting the second ssh connection I can trigger a trace to 
>> be printed on the serial console, it's similar but different from the 
>> first I reported.
>>
>> [  207.548610] 	1-...!: (0 ticks this GP) idle=79a/1/1073741824 softirq=2146/2146 fqs=0 
>> [  207.556442] 	(detected by 0, t=12645 jiffies, g=333, c=332, q=20)
>> [  207.562546] rcu_sched kthread starved for 12645 jiffies! g333 c332 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
>> [  207.572548] RCU grace-period kthread stack dump:
>>
>> [  207.577166] rcu_sched       R  running task        0     9      2 0x00000000
>> [  207.584389] Backtrace: 
>> [  207.586849] [<c0760450>] (__schedule) from [<c0760ba4>] (schedule+0x94/0xb8)
>> [  207.593901]  r10:e77813c0 r9:e77813c0 r8:ffffffff r7:e709bed4 r6:ffffaa80 r5:00000000
>> [  207.601732]  r4:ffffe000
>> [  207.604269] [<c0760b10>] (schedule) from [<c0764560>] (schedule_timeout+0x380/0x3dc)
>> [  207.612013]  r5:00000000 r4:00000000
>> [  207.615596] [<c07641e0>] (schedule_timeout) from [<c017b698>] (rcu_gp_kthread+0x668/0xe2c)
>> [  207.623863]  r10:c0b79018 r9:0000014d r8:0000014c r7:00000001 r6:00000000 r5:c0b10ad0
>> [  207.631693]  r4:c0b10980
>> [  207.634230] [<c017b030>] (rcu_gp_kthread) from [<c013ddd8>] (kthread+0x148/0x160)
>> [  207.641712]  r7:c0b10980
>> [  207.644249] [<c013dc90>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>> [  207.651472] Exception stack(0xe709bfb0 to 0xe709bff8)
>> [  207.656527] bfa0:                                     00000000 00000000 00000000 00000000
>> [  207.664709] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [  207.672890] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [  207.679508]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c013dc90
>> [  207.687340]  r4:e7026f4
>>
>> Continuing the anecdotal testing, I can't seem to be able to trigger the 
>> lockup if i have ever had two ssh sessions open to the systems. And 
>> about half the time I can't trigger it at all but after a reset of the 
>> system it triggers with just hitting the return key 2-5 times of opening 
>> a ssh session and just hitting the return key. But please take this part 
>> with a grain of salt as it's done by the monkey testing method :-)
>>
>> All tests above have been run base on c18bb396d3d261eb ("Merge 
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
>>
>>>
>>>>
> 
> [snip]
> 
>>>>
>>>> I'm a bit lost on how to progress with this issue and would appreciate
>>>> any help you can provide to help me figure this out.
>>>
>>> Can you send me your config ?
>>>
>>> I'm going to prepare a debug patch to spy what's happening when entering idle
> 
> I'd like to narrow the problem a bit more with the 2 patchies aboves. Can you try
> them separatly on top of c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net"))
> and check if one of them fixes the problem ?i
> 
> (They should apply on linux-next as well)
> 
> First patch always kick ilb instead of doing ilb on local cpu before entering idle
> 
> ---
>  kernel/sched/fair.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0951d1c..b21925b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9739,8 +9739,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
>  	 * candidate for ilb instead of waking up another idle CPU.
>  	 * Kick an normal ilb if we failed to do the update.
>  	 */
> -	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
> -		kick_ilb(NOHZ_STATS_KICK);
> +	kick_ilb(NOHZ_STATS_KICK);
>  	raw_spin_lock(&this_rq->lock);
>  }
>  
> 
I tested both patches, with both of them the issue still occurs. However,
on top of linux-next from yesterday I have the impression that it happens
less frequent with the second patch.
On top of the commit mentioned by you I don't see a change in system behavior
with either patch.

Regards, Heiner
