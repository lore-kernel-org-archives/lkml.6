Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2DA2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2DA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeGFLti (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:49:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35238 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753294AbeGFLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:49:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45F9718A;
        Fri,  6 Jul 2018 04:49:36 -0700 (PDT)
Received: from [10.1.206.36] (e113632-lin.cambridge.arm.com [10.1.206.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F3A3F5BA;
        Fri,  6 Jul 2018 04:49:32 -0700 (PDT)
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
To:     Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
 <20180706114158.GU2458@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7559d0e2-7c5d-3bd3-6123-51fc9a4ca0d4@arm.com>
Date:   Fri, 6 Jul 2018 12:49:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706114158.GU2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 12:41, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
>> @@ -698,6 +698,9 @@ struct root_domain {
>>  	/* Indicate more than one runnable task for any CPU */
>>  	bool			overload;
> 
> While there, make that an int.

That's what I've done at [1] - I guess that's the fun part of having those
two patch sets in flight at the same time...

[1]: https://lore.kernel.org/lkml/1530699470-29808-8-git-send-email-morten.rasmussen@arm.com/

> 
>> +	/* Indicate one or more cpus over-utilized (tipping point) */
>> +	int			overutilized;
>> +
>>  	/*
>>  	 * The bit corresponding to a CPU gets set here if such CPU has more
>>  	 * than one runnable -deadline task (as it is below for RT tasks).
>> -- 
>> 2.17.1
>>
