Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970349AbeEYAPG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:15:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970068AbeEYAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:15:05 -0400
Subject: Re: [PATCH v4] rcu: Speed up calling of RCU tasks callbacks
From: Randy Dunlap <rdunlap@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20180524184946.5fa82d19@gandalf.local.home>
 <20180524231918.GA98334@joelaf.mtv.corp.google.com>
 <20180524192247.759f7572@gandalf.local.home>
 <076566f7-43ff-5cc8-03ba-ebde9c19418c@infradead.org>
Message-ID: <e906cdde-855b-1fc6-8cdc-a1f969688c1a@infradead.org>
Date: Thu, 24 May 2018 17:14:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <076566f7-43ff-5cc8-03ba-ebde9c19418c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 04:26 PM, Randy Dunlap wrote:
> On 05/24/2018 04:22 PM, Steven Rostedt wrote:
>> On Thu, 24 May 2018 16:19:18 -0700
>> Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>>> On Thu, May 24, 2018 at 06:49:46PM -0400, Steven Rostedt wrote:
>>>>
>>>> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>>
>>>> Joel Fernandes found that the synchronize_rcu_tasks() was taking a
>>>> significant amount of time. He demonstrated it with the following test:
>>>>
>>>>  # cd /sys/kernel/tracing
>>>>  # while [ 1 ]; do x=1; done &
>>>>  # echo '__schedule_bug:traceon' > set_ftrace_filter
>>>>  # time echo '!__schedule_bug:traceon' > set_ftrace_filter;
>>>>
>>>> real	0m1.064s
>>>> user	0m0.000s
>>>> sys	0m0.004s
>>>>
>>>> Where it takes a little over a second to perform the synchronize,
>>>> because there's a loop that waits 1 second at a time for tasks to get
>>>> through their quiescent points when there's a task that must be waited
>>>> for.
>>>>
>>>> After discussion we came up with a simple way to wait for holdouts but
>>>> increase the time for each iteration of the loop but no more than a
>>>> full second.
>>>>
>>>> With the new patch we have:
>>>>
>>>>  # time echo '!__schedule_bug:traceon' > set_ftrace_filter;
>>>>
>>>> real	0m0.131s
>>>> user	0m0.000s
>>>> sys	0m0.004s
>>>>
>>>> Which drops it down to 13% of what the original wait time was.  
>>>
>>> Should be 90% of original?
>>
>> That would be if I said "drops it down X" but I said "drops it down to
>> X of what the original wait time was". And 0.131 is 13% of 1.064. :-)
> 
> I think that you are confusing "drops it down to" with "drops it down by".
> You said the former.  You should say the latter.
> IOW, I agree with Joel.


Please forget this.  After reading the numbers, your comments look correct.


-- 
~Randy
