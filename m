Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE0C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4481B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4481B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeKTXVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:21:21 -0500
Received: from foss.arm.com ([217.140.101.70]:48402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKTXVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:21:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D3D215AB;
        Tue, 20 Nov 2018 04:52:22 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F82A3F5B7;
        Tue, 20 Nov 2018 04:52:19 -0800 (PST)
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
 <b103563e-fdf3-62a1-473e-cde1cd7e2d5d@arm.com>
 <2efadddc-ebc0-1cdb-5580-4a9ab5610e61@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7111ee5a-b408-1fa1-e9fa-42aad4d6ff4d@arm.com>
Date:   Tue, 20 Nov 2018 12:52:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2efadddc-ebc0-1cdb-5580-4a9ab5610e61@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2018 17:32, Steven Sistare wrote:
> On 11/9/2018 12:38 PM, Valentin Schneider wrote:
>> Hi Steve,
>>
>> On 09/11/2018 12:50, Steve Sistare wrote:
>> [...]
>>> @@ -482,6 +484,10 @@ static void update_top_cache_domain(int cpu)
>>>  	dirty_sched_domain_sysctl(cpu);
>>>  	destroy_sched_domains(tmp);
>>>  
>>> +	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>>> +	cfs_overload_cpus = (sd ? sd->shared->cfs_overload_cpus : NULL);
>>> +	rcu_assign_pointer(rq->cfs_overload_cpus, cfs_overload_cpus);
>>> +
>>
>> Why not do this in update_top_cache_domain() where we also look for the
>> highest SD_SHARE_PKG_RESOURCES and setup shortcut pointers?
> 
> My snippet needs rq which is currently referenced in cpu_attach_domain() but
> not in update_top_cache_domain().  I could just as easily do it in 
> update_top_cache_domain().  Either way is fine with me.
> 

I think having this in update_top_cache_domain() makes more sense - it's
where all the domain shortcuts are set, and we already play with LLC there.

[...]
