Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE315C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86505208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86505208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPC35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeJPC35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:29:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46C4D308626E;
        Mon, 15 Oct 2018 18:43:29 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9544262480;
        Mon, 15 Oct 2018 18:43:22 +0000 (UTC)
Subject: Re: [PATCH v13 03/11] cpuset: Simply allocation and freeing of
 cpumasks
To:     Tom Hromatka <tom.hromatka@oracle.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
 <1539366951-8498-4-git-send-email-longman@redhat.com>
 <fe132a9a-472d-22db-43ef-42c00b68c8dd@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b5ec84fe-e9ed-7b82-7183-cb84f485dfc7@redhat.com>
Date:   Mon, 15 Oct 2018 14:43:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <fe132a9a-472d-22db-43ef-42c00b68c8dd@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 15 Oct 2018 18:43:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 02:35 PM, Tom Hromatka wrote:
>
>
> On 10/12/2018 11:55 AM, Waiman Long wrote:
>> The previous commit introduces a new subparts_cpus mask into the cpuset
>> data structure and a new tmpmasks structure.  Managing the allocation
>> and freeing of those cpumasks is becoming more complex.
>>
>> So a number of helper functions are added to simplify and streamline
>> the management of those cpumasks. To make it simple, all the cpumasks
>> are now pre-cleared on allocation.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 104
>> +++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 71 insertions(+), 33 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 29a2bdc..9ac5f94 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -456,6 +456,57 @@ static int is_cpuset_subset(const struct cpuset
>> *p, const struct cpuset *q)
>>   }
>>     /**
>> + * alloc_cpumasks - allocate three cpumasks for cpuset
>> + * @cs:  the cpuset that have cpumasks to be allocated.
>> + * @tmp: the tmpmasks structure pointer
>> + * Return: 0 if successful, -ENOMEM otherwise.
>> + *
>> + * Only one of the two input arguments should be non-NULL.
>> + */
>> +static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks
>> *tmp)
>> +{
>> +    cpumask_var_t *pmask1, *pmask2, *pmask3;
>> +
>> +    if (cs) {
>> +        pmask1 = &cs->cpus_allowed;
>> +        pmask2 = &cs->effective_cpus;
>> +        pmask3 = &cs->subparts_cpus;
>> +    } else {
>> +        pmask1 = &tmp->new_cpus;
>> +        pmask2 = &tmp->addmask;
>> +        pmask3 = &tmp->delmask;
>> +    }
>> +
>> +    if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
>> +        return -ENOMEM;
>> +
>> +    if (!zalloc_cpumask_var(pmask2, GFP_KERNEL))
>> +        goto free_one;
>> +
>> +    if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
>> +        goto free_two;
>> +
>> +    return 0;
>> +
>> +free_two:
>> +    free_cpumask_var(*pmask2);
>> +free_one:
>> +    free_cpumask_var(*pmask1);
>> +    return -ENOMEM;
>> +}
>> +
>> +/**
>> + * free_cpumasks - free cpumasks in a tmpmasks structure
>> + * @tmp: the tmpmasks structure pointer
>> + */
>> +static inline void free_cpumasks(struct tmpmasks *tmp)
>> +{
>> +    free_cpumask_var(tmp->new_cpus);
>> +    free_cpumask_var(tmp->addmask);
>> +    free_cpumask_var(tmp->delmask);
>> +}
>> +
>
> I hesitate to bring this up, but since you're respinning this
> patch for a different bug...
>
> Would it make sense to have free_cpumasks() have a similar
> API and behavior to alloc_cpumasks()?  I could see this potentially
> causing bugs/confusion in future patches.
>
> Thanks.
>
> Tom
>
>
Thanks for the comment. Yes I will make the change.

-Longman

