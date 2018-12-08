Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05385C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36482147C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36482147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeLHSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:47:20 -0500
Received: from foss.arm.com ([217.140.101.70]:34298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeLHSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:47:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29E63EBD;
        Sat,  8 Dec 2018 10:47:19 -0800 (PST)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88B4C3F575;
        Sat,  8 Dec 2018 10:47:16 -0800 (PST)
Subject: Re: [PATCH v4 04/10] sched/fair: Dynamically update cfs_overload_cpus
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-5-git-send-email-steven.sistare@oracle.com>
 <3ec57357-dc4e-be1b-963f-abcf760ecc5a@arm.com>
 <b72240f1-1067-025c-50ca-b231637d8657@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8e032913-a426-0f32-6c68-a183bfc7ed66@arm.com>
Date:   Sat, 8 Dec 2018 18:47:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b72240f1-1067-025c-50ca-b231637d8657@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 22:35, Steven Sistare wrote:
[...]
>>> @@ -4468,8 +4495,12 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>>  			dequeue = 0;
>>>  	}
>>>  
>>> -	if (!se)
>>> +	if (!se) {
>>>  		sub_nr_running(rq, task_delta);
>>> +		if (prev_nr >= 2 && prev_nr - task_delta < 2)
>>> +			overload_clear(rq);
>>> +
>>> +	}
>>
>> Eventually it'd be nice to squash those into {add, sub}_nr_running(), but
>> you already mentioned wanting to stick to CFS for now, so I don't think
>> it's *too* much of a big deal.
> 
> Maybe.  It depends on a design decision to be made if/when we add bitmap
> based stealing to other scheduling classes.  Do we maintain one bitmap
> for overloaded CPUs where the overload may be caused by any mix of different
> task classes?  If yes, then the bitmap search for one class such as RT
> will inspect and reject overloaded CPUs that only have CFS tasks, which 
> making the search less efficient.  I am leaning towards a separate bitmap 
> per class to avoid that.
> 

Didn't ponder too much about it, but a bitmap per class sounds sane. My
comment was mostly about saving ourselves the need to decorate every
{add, sub}_nr_running() call with overload_{set, clear}() calls.

> - Steve
>   
> 
