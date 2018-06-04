Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeFDAak (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:30:40 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:49442 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751465AbeFDAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:30:39 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] rcu: Check the range of jiffies_till_{first,next}_fqs
 when setting them
To: Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>
Cc: jiangshanlai@gmail.com, Paul McKenney <paulmck@linux.vnet.ibm.com>,
        josh@joshtriplett.org, rostedt@goodmis.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        kernel-team@android.com
References: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
 <20180603035848.GA76941@joelaf.mtv.corp.google.com>
 <CANrsvRNeMc8JppnP53ordMkzw+HDdPn0VsiF0j3YdWbQe1+sUg@mail.gmail.com>
 <20180603062330.GA153988@joelaf.mtv.corp.google.com>
 <CANrsvRM+b+Ei_GAtLERFtN7QJN3Au3grc_asfT=pOY0g4rTFWQ@mail.gmail.com>
 <20180603184705.GA85962@joelaf.mtv.corp.google.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <a8dc8ef7-9b3a-4a06-1599-a87317db3462@lge.com>
Date: Mon, 4 Jun 2018 09:30:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180603184705.GA85962@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-04 03:47, Joel Fernandes wrote:
> On Sun, Jun 03, 2018 at 04:51:06PM +0900, Byungchul Park wrote:
>> On Sun, Jun 3, 2018 at 3:23 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>> On Sun, Jun 03, 2018 at 02:38:04PM +0900, Byungchul Park wrote:
>>>> On Sun, Jun 3, 2018 at 12:58 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>> On Fri, Jun 01, 2018 at 11:03:09AM +0900, Byungchul Park wrote:
>>>>>> Currently, the range of jiffies_till_{first,next}_fqs are checked and
>>>>>> adjusted on and on in the loop of rcu_gp_kthread on runtime.
>>>>>>
>>>>>> However, it's enough to check them only when setting them, not every
>>>>>> time in the loop. So make them handled on a setting time via sysfs.
>>>>>>
>>>>>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>>>>>> ---
>>>>>>   kernel/rcu/tree.c | 45 ++++++++++++++++++++++++++++++++-------------
>>>>>>   1 file changed, 32 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>> index 4e96761..eb54d7d 100644
>>>>>> --- a/kernel/rcu/tree.c
>>>>>> +++ b/kernel/rcu/tree.c
>>>>>> @@ -518,8 +518,38 @@ void rcu_all_qs(void)
>>>>>>   static ulong jiffies_till_next_fqs = ULONG_MAX;
>>>>>>   static bool rcu_kick_kthreads;
>>>>>>
>>>>>> -module_param(jiffies_till_first_fqs, ulong, 0644);
>>>>>> -module_param(jiffies_till_next_fqs, ulong, 0644);
>>>>>> +static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
>>>>>> +{
>>>>>> +     ulong j;
>>>>>> +     int ret = kstrtoul(val, 0, &j);
>>>>>> +
>>>>>> +     if (!ret)
>>>>>> +             WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
>>>>>> +     return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
>>>>>> +{
>>>>>> +     ulong j;
>>>>>> +     int ret = kstrtoul(val, 0, &j);
>>>>>> +
>>>>>> +     if (!ret)
>>>>>> +             WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
>>>>>> +     return ret;
>>>>>> +}
>>>>>
>>>>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>
>>>>> Also, can we not combine the 2 param_set_ handlers as well?
>>>>>
>>>>> Only thing we would be giving up is that jiffies_till_first_fqs = 0 wouldn't
>>>>> be allowed (if we go with the param_set_next handler to be the common one)
>>>>> but don't think that's a useful/valid usecase since jiffies_till_first_fqs is
>>>>> set to a sane non-0 value anyway at boot up because of rcu_init_geometry
>>>>> anyway.. Thoughts?
>>>>
>>>> Excuse me. Which code in rcu_init_geometry() makes jiffies_till_first_fqs
>>>> be a non-zero in case called with jiffies_till_first_fqs == 0?
>>>
>>> What do you mean? I think you misunderstood. I didn't say value of 0 is being
>>> handled at boot up. What I said is its initialized to something sane that's
>>> non-zero:
>>>
>>> If you see, jiffies_till_first_fqs is assigned to ULONG_MAX at compile time:
>>> static ulong jiffies_till_first_fqs = ULONG_MAX;
>>>
>>> Then in rcu_init_geometry, we have:
>>>          d = RCU_JIFFIES_TILL_FORCE_QS + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
>>>          if (jiffies_till_first_fqs == ULONG_MAX)
>>>                          jiffies_till_first_fqs = d;
>>>
>>> On my system, jiffies_till_first_fqs is assigned to 3 because of this at
>>> boot.
>>>
>>>> Furthermore, what if we want to change the value through sysfs to zero
>>>> on runtime?
>>>
>>> My patch was just a suggestion. I didn't know if anyone would want to force
>>> it to 0 or not and was wondering what the value in doing so was at the cost
>>> of adding one more function to handle it. It basically says if you set to 0,
>>> that you never want to wait for a timeout before forcing a qs for the first
>>> time? Then why are we calling swait_event_idle_timeout anyway? Wouldn't a
>>> saner timeout be something not zero?
>>
>> I'm sorry I tried but don't understand your point :(
>> Did you happen to read the following?
>>
>> https://lkml.org/lkml/2018/5/29/99
> 
> No I did not happen to read that and I am very sorry about that. I see Paul
> said jiffies_till_first_fqs = 0 is a useful case in that thread, to record
> the idle CPUs quickly, which makes sense.
> 
>> If yes, it would be appreciated if you let me know what I'm missing.
> 
> You are right and not missing anything. I'll be more careful to go through
> old threads next time..
> 
> Glad to learn something from the discussions. thanks,
> 
> BTW one more dumb question - if jiffies_till_first_fqs == 0 is so useful,
> then why not default initialize it to 0? I'd think most systems expect
> atleast some of the CPUs to idle.

and some others to be busy tho :)

IMHO, although the case of jiffies_till_first_fqs == 0 is sometimes
useful, the other case is much more useful since we normally don't
want to add overhead by the forcing. The reason we don't force
quiescent states immediately but wait several jiffies by default is
because the overhead such as burning barrier, atomic ops and so on
is needed to force it.

> 
> - Joel
> 
> 

-- 
Thanks,
Byungchul
