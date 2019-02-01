Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA40C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B17214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfBAWdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:33:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfBAWdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:33:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 548118DA2D;
        Fri,  1 Feb 2019 22:33:21 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 996DC60123;
        Fri,  1 Feb 2019 22:33:20 +0000 (UTC)
Subject: Re: [PATCH] sched/debug: initialize sd_sysctl_cpus if
 !CONFIG_CPUMASK_OFFSTACK
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
References: <20190129151245.5073-1-msys.mizuma@gmail.com>
 <20190130201400.GH2278@hirez.programming.kicks-ass.net>
 <20190131134457.caj7vaestug4q2l3@gabell>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <26907f7f-7da8-b476-02b5-3d25dca05d6a@redhat.com>
Date:   Fri, 1 Feb 2019 17:33:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131134457.caj7vaestug4q2l3@gabell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 01 Feb 2019 22:33:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 8:44 AM, Masayoshi Mizuma wrote:
> On Wed, Jan 30, 2019 at 09:14:00PM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 29, 2019 at 10:12:45AM -0500, Masayoshi Mizuma wrote:
>>> From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
>>>
>>> register_sched_domain_sysctl() copies the cpu_possible_mask into
>>> sd_sysctl_cpus, but only if sd_sysctl_cpus hasn't already been
>>> allocated (ie, CONFIG_CPUMASK_OFFSTACK is set).  However, when
>>> CONFIG_CPUMASK_OFFSTACK is not set, sd_sysctl_cpus is left uninitialized
>>> (all zeroes) and the kernel may fail to initialize sched_domain sysctl
>>> entries for all possible cpus.
>>>
>>> This is visible to the user if the kernel is booted with maxcpus=n, or
>>> if ACPI tables have been modified to leave cpus offline, and then
>>> checking for missing /proc/sys/kernel/sched_domain/cpu* entries.
>>>
>>> Fix this by separating the allocataion and initialization, and adding
>>> a flag to initialize the possible cpu entries while system booting only.
>>>
>>> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
>>> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>> Tested-by: Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>
>>> Tested-by: Tarumizu, Kohei <tarumizu.kohei@jp.fujitsu.com>
>>> ---
>>>   kernel/sched/debug.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>>> index de3de997e245..9c6637f3e21d 100644
>>> --- a/kernel/sched/debug.c
>>> +++ b/kernel/sched/debug.c
>>> @@ -310,6 +310,7 @@ static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
>>>   
>>>   static cpumask_var_t		sd_sysctl_cpus;
>>>   static struct ctl_table_header	*sd_sysctl_header;
>>> +static int register_sched_domain_sysctl_on_boot = 1;
>>>   
>>>   void register_sched_domain_sysctl(void)
>>>   {
>>> @@ -344,9 +345,12 @@ void register_sched_domain_sysctl(void)
>>>   	if (!cpumask_available(sd_sysctl_cpus)) {
>>>   		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>>>   			return;
>>> +	}
>>>   
>>> +	if (register_sched_domain_sysctl_on_boot) {
>>>   		/* init to possible to not have holes in @cpu_entries */
>>>   		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
>>> +		register_sched_domain_sysctl_on_boot = 0;
>>>   	}
>>>   
>>>   	for_each_cpu(i, sd_sysctl_cpus) {
>>
>> I change it like the below. By keeping the initial value 0 it can go
>> into .bss instead of .data.
> 
> Great, thanks!
> Should I re-post the patch as v2?
> 
> - Masa
> 

Peter's revision tests fine on my aarch64 box and would get my ACK, 
however it ends up getting re-posted :)

Thanks,

-- Joe

>>
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -315,6 +315,7 @@ void register_sched_domain_sysctl(void)
>>   {
>>   	static struct ctl_table *cpu_entries;
>>   	static struct ctl_table **cpu_idx;
>> +	static bool init_done = false;
>>   	char buf[32];
>>   	int i;
>>   
>> @@ -344,7 +345,10 @@ void register_sched_domain_sysctl(void)
>>   	if (!cpumask_available(sd_sysctl_cpus)) {
>>   		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>>   			return;
>> +	}
>>   
>> +	if (!init_done) {
>> +		init_done = true;
>>   		/* init to possible to not have holes in @cpu_entries */
>>   		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
>>   	}


-- Joe
