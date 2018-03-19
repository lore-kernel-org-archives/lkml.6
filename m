Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971461AbeCSUnf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:43:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S971364AbeCSUn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:43:29 -0400
Subject: Re: [PATCH 1/2] sched/debug: fix per-task line continuation for
 console
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
 <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
 <20180319201723.GK4043@hirez.programming.kicks-ass.net>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <6b826ab1-c6a4-244e-ace6-d735b415a268@redhat.com>
Date: Mon, 19 Mar 2018 16:43:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180319201723.GK4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 04:17 PM, Peter Zijlstra wrote:
> On Mon, Mar 19, 2018 at 02:35:54PM -0400, Joe Lawrence wrote:
>> When the SEQ_printf() macro prints to the console, it runs a simple
>> printk() without KERN_CONT "continued" line printing.  The result of
>> this is oddly wrapped task info, for example:
>>
>>   % echo t > /proc/sysrq-trigger
>>   % dmesg
>>   ...
>>   runnable tasks:
>>   ...
>>   [   29.608611]  I
>>   [   29.608613]       rcu_sched     8      3252.013846      4087   120
>>   [   29.608614]         0.000000        29.090111         0.000000
>>   [   29.608615]  0 0
>>   [   29.608616]  /
>>
>> Modify SEQ_printf to use pr_cont() for expected one-line results:
>>
>>   % echo t > /proc/sysrq-trigger
>>   % dmesg
>>   ...
>>   runnable tasks:
>>   ...
>>   [  106.716329]  S        cpuhp/5    37      2006.315026        14   120         0.000000         0.496893         0.000000 0 0 /
>>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> ---
>>  kernel/sched/debug.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 1ca0130ed4f9..50026aa2d81e 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -32,7 +32,7 @@
>>  	if (m)					\
>>  		seq_printf(m, x);		\
>>  	else					\
>> -		printk(x);			\
>> +		pr_cont(x);			\
> 
> That used to work I think.. I think someone changed how printk() behaves
> somewhere along the lines.
> 

Hi Peter,

This code:

        printk("printk one");
        printk("printk two\n");

        pr_cont("\n");
        pr_cont("pr_cont one");
        pr_cont("pr_cont two\n");

        pr_cont("pr_cont first line\n");
        pr_cont("\n");
        pr_cont("\n");
        pr_cont("pr_cont next line");

Creates this output:

	%  uname -r
	4.16.0-rc5+

	% dmesg
	[  575.221280] printk one
	[  575.221281] printk two
	[  575.221282] pr_cont onepr_cont two
	[  575.221283] pr_cont first line

I don't have the commit offhand that changed the printk behavior, but
from observation:

  1 - printk implies a trailing newline:
      https://lwn.net/Articles/732420/

  2 - pr_cont seems to eat redundant newlines

> Does pr_cont("\n") DTRT? it seems like something weird.
> 

Yeah, pr_cont() is kind of a hack.  It will terminate a line if that's
the first newline, but as demonstrated above, I don't think it likes
extra newline chars.

A better fix would be to marshal the text into temp buffer then dump it
out.  Dunno if you prefer that kind of churn for these stats.

-- Joe
