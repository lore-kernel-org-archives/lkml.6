Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88EBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BD72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BD72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757164AbeFSK0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:26:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755596AbeFSK0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:26:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9301B1435;
        Tue, 19 Jun 2018 03:26:42 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12F43F25D;
        Tue, 19 Jun 2018 03:26:37 -0700 (PDT)
Subject: Re: [RFC PATCH v3 06/10] sched: Add over-utilization/tipping point
 indicator
To:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-7-quentin.perret@arm.com>
 <20180619070103.GB9208@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bdfd313d-1b31-0672-0a23-285087206b06@arm.com>
Date:   Tue, 19 Jun 2018 12:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619070103.GB9208@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 09:01 AM, Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:01PM +0100, Quentin Perret wrote:

[...]

>> @@ -8152,6 +8176,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		if (nr_running > 1)
>>   			*overload = true;
>>   
>> +		if (cpu_overutilized(i))
>> +			*overutilized = 1;
>> +
> 
> There is no need to check if every CPU is overutilized or not once
> *overutilized is marked as true, right?

True, so you want to check *overutilized before calling 
cpu_overutilized() to save a little bit on compute?

[...]

>> @@ -8586,6 +8621,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>   	 * this level.
>>   	 */
>>   	update_sd_lb_stats(env, &sds);
>> +
>> +	if (sched_energy_enabled() && !READ_ONCE(env->dst_rq->rd->overutilized))
>> +		goto out_balanced;
>> +
> 
> Is there any reason for sending no-hz idle kicks but bailing out here when
> system is not overutilized?

Even if a system is not-overutilized, we want to update stale cpu 
blocked load and utilization so NOHZ_STATS_KICK have to get through.

So calling find_busiest_group() -> update_sd_lb_stats() -> 
update_sg_lb_stats() to possibly execute update_nohz_stats() is IMHO the 
right thing to do.
