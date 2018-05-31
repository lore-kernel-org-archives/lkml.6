Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeEaB1u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:27:50 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:50929 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932575AbeEaB1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:27:49 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting
 them
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
References: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
 <20180529120155.GC3803@linux.vnet.ibm.com>
 <ec3f99af-902d-4a12-f533-07de97dab310@lge.com>
 <20180530134952.GF7063@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <158f3434-cb8b-13d9-02d7-f00db177eeaf@lge.com>
Date: Thu, 31 May 2018 10:27:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530134952.GF7063@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-30 22:49, Paul E. McKenney wrote:
> On Wed, May 30, 2018 at 10:06:52PM +0900, Byungchul Park wrote:
>>
>>
>> On 2018-05-29 21:01, Paul E. McKenney wrote:
>>> On Tue, May 29, 2018 at 04:23:36PM +0900, Byungchul Park wrote:
>>>> Hello Paul and folks,
>>>>
>>>> I've thought the code should've been like the below since the range
>>>> checking of jiffies_till_first_fqs and jiffies_till_next_fqs everytime
>>>> in the loop of rcu_gp_kthread are unnecessary at all. However, it's ok
>>>> even if you don't think it's worth doing it.
>>>
>>> Nice!
>>>
>>>> Secondly, I also think jiffies_till_first_fqs = 0 is meaningless so
>>>> added checking and adjusting it as what's done on jiffies_till_next_fqs.
>>>> Thought?
>>>
>>> Actually, jiffies_till_first_fqs == 0 is very useful for cases where
>>> at least one CPU is expected to be idle and grace-period latency is
>>> important.  In this case, doing the first scan immediately gets the
>>> dyntick-idle state recorded immediately, getting the idle CPUs out of
>>> the way of the grace period immediately.
>>
>> Hi Paul~
>>
>> You might want to handle it through sysfs. Otherwise, we can do it with
>> force_quiescent_state() IMHO.
> 
> I agree that sysfs would be better than debugfs because these parameters
> are about tuning, not debugging, so good point!
> 
>>> So why not do this scan as part of grace-period initialization?  Because
>>> doing so consumes extra CPU and results in extra cache misses, which is
>>> the opposite of what you want on a completely busy system, especially
>>> one where the CPUs are context switching quickly.  Thus no scan during
>>> grace-period initialization.
>>
>> I am sorry I don't understand this paragraph. :(
> 
> Let me try again.  ;-)
> 
> I could change RCU to avoid the need for jiffies_till_first_fqs == 0,
> but doing that would increase CPU consumption for workloads that are
> already bottlenecked on the CPU.  So I won't be making that change,
> so we still need jiffies_till_first_fqs == 0.

Thanks. I see. We need it then.

-- 
Thanks,
Byungchul
