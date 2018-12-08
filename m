Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD20C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDD02081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDD02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLHSj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:39:28 -0500
Received: from foss.arm.com ([217.140.101.70]:34248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeLHSj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:39:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65FA9EBD;
        Sat,  8 Dec 2018 10:39:27 -0800 (PST)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB5D53F575;
        Sat,  8 Dec 2018 10:39:24 -0800 (PST)
Subject: Re: [PATCH v4 08/10] sched/fair: Steal work from an overloaded CPU
 when CPU goes idle
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-9-git-send-email-steven.sistare@oracle.com>
 <e4d5f90a-8780-dc43-412b-0ac97fb3d39f@arm.com>
 <9f798c5d-f58a-e1fc-5b03-6598e04916bb@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3d017a5d-50a4-3e99-c3c8-9b3ee240d076@arm.com>
Date:   Sat, 8 Dec 2018 18:39:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9f798c5d-f58a-e1fc-5b03-6598e04916bb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 22:36, Steven Sistare wrote:
> On 12/7/2018 3:21 PM, Valentin Schneider wrote:
>> Hi Steve,
>>
>> On 06/12/2018 21:28, Steve Sistare wrote:
>> [...]
>>> @@ -6778,20 +6791,22 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>>>  	update_misfit_status(NULL, rq);
>>>  
>>>  	/*
>>> -	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>>> -	 * measure the duration of idle_balance() as idle time.
>>> +	 * We must set idle_stamp _before_ calling try_steal() or
>>> +	 * idle_balance(), such that we measure the duration as idle time.
>>>  	 */
>>>  	rq_idle_stamp_update(rq); 
>>
>> idle_balance() has a
>>
>> 	/*
>> 	 * Do not pull tasks towards !active CPUs...
>> 	 */
>> 	if (!cpu_active(this_cpu))
>> 		return 0;
>>
>> check which we probably want for stealing too, so we could hoist it up here
>> to cover both idle_balance() and try_steal().
> 
> try_steal() already checks cpu_active.  I could hoist it.
> 

Ah yeah I missed that one, I had only seen cpu_active(src_cpu) in steal_from().
It's all good then.

[...]
