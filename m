Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeEWNTh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:19:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbeEWNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:19:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48D57602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vinmenon@codeaurora.org
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
 <87060553-2e09-2e2a-13a2-a91345d6df30@codeaurora.org>
 <20180523131747.GA4086@cmpxchg.org>
From: Vinayak Menon <vinmenon@codeaurora.org>
Message-ID: <47beeaa6-74aa-35d0-2808-e5c54be854a6@codeaurora.org>
Date: Wed, 23 May 2018 18:49:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523131747.GA4086@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2018 6:47 PM, Johannes Weiner wrote:
> On Wed, May 09, 2018 at 04:33:24PM +0530, Vinayak Menon wrote:
>> On 5/8/2018 2:31 AM, Johannes Weiner wrote:
>>> +	/* Kick the stats aggregation worker if it's gone to sleep */
>>> +	if (!delayed_work_pending(&group->clock_work))
>> This causes a crash when the work is scheduled before system_wq is up. In my case when the first
>> schedule was called from kthreadd. And I had to do this to make it work.
>> if (keventd_up() && !delayed_work_pending(&group->clock_work))
>>
>>> +		schedule_delayed_work(&group->clock_work, MY_LOAD_FREQ);
> I was trying to figure out how this is possible, and it didn't make
> sense because we do initialize the system_wq way before kthreadd.
>
> Did you by any chance backport this to a pre-4.10 kernel which does
> not have 3347fa092821 ("workqueue: make workqueue available early
> during boot") yet?

Sorry I did not mention that. I was trying on 4.9 kernel. It's clear now. Thanks.

>>> +void psi_task_change(struct task_struct *task, u64 now, int clear, int set)
>>> +{
>>> +	struct cgroup *cgroup, *parent;
>> unused variables
> They're used in the next patch, I'll fix that up.
>
> Thanks
