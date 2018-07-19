Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8417AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450CF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450CF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeGSOkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:40:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730470AbeGSOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:40:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E752472622;
        Thu, 19 Jul 2018 13:56:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6D5A2026D6B;
        Thu, 19 Jul 2018 13:56:47 +0000 (UTC)
Subject: Re: [PATCH v11 9/9] cpuset: Allow reporting of sched domain
 generation info
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-10-git-send-email-longman@redhat.com>
 <20180719135429.GF2494@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f1761707-28be-3e72-d87d-6e9a0f1653c8@redhat.com>
Date:   Thu, 19 Jul 2018 09:56:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180719135429.GF2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 13:56:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 13:56:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 09:54 AM, Peter Zijlstra wrote:
> On Sun, Jun 24, 2018 at 03:30:40PM +0800, Waiman Long wrote:
>> This patch enables us to report sched domain generation information.
>>
>> If DYNAMIC_DEBUG is enabled, issuing the following command
>>
>>   echo "file cpuset.c +p" > /sys/kernel/debug/dynamic_debug/control
>>
>> and setting loglevel to 8 will allow the kernel to show what scheduling
>> domain changes are being made.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 07a5575..62b7e61 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -836,6 +836,23 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>  	return ndoms;
>>  }
>>  
>> +#ifdef CONFIG_DEBUG_KERNEL
>> +static inline void debug_print_domains(cpumask_var_t *doms, int ndoms)
>> +{
>> +	int i;
>> +	char buf[200];
>> +	char *ptr, *end = buf + sizeof(buf) - 1;
>> +
>> +	for (i = 0, ptr = buf, *end = '\0'; i < ndoms; i++)
>> +		ptr += snprintf(ptr, end - ptr, "dom%d=%*pbl ", i,
>> +				cpumask_pr_args(doms[i]));
>> +
>> +	pr_debug("Generated %d domains: %s\n", ndoms, buf);
>> +}
>> +#else
>> +static inline void debug_print_domains(cpumask_var_t *doms, int ndoms) { }
>> +#endif
> I still hate this patch.. it prints information already available in
> sched_debug and has that rediculous on-stack buffer.

This patch is just for my own testing purpose. We can certainly drop that.

Tejun, please drop this one.

Thanks,
Longman

