Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC0BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0540218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0540218F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHQQCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:02:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeHQQCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:02:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4930C7A9;
        Fri, 17 Aug 2018 05:58:56 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44AA13F5BD;
        Fri, 17 Aug 2018 05:58:55 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Avoid divide by zero when rebalancing domains
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
References: <20180704142455.16035-1-matt@codeblueprint.co.uk>
 <55afee27-4143-e08c-b254-0d68a05d5ee6@arm.com>
 <20180705132726.GB3864@codeblueprint.co.uk>
 <94149109-a54c-fc5d-7b56-e786c8de5b94@arm.com>
 <20180817102734.GA4253@codeblueprint.co.uk>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <adfca8d9-2fc1-744d-ec03-49788c5b3aa2@arm.com>
Date:   Fri, 17 Aug 2018 13:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817102734.GA4253@codeblueprint.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/08/18 11:27, Matt Fleming wrote:
> On Thu, 05 Jul, at 05:54:02PM, Valentin Schneider wrote:
>> On 05/07/18 14:27, Matt Fleming wrote:
>>> On Thu, 05 Jul, at 11:10:42AM, Valentin Schneider wrote:
>>>> Hi,
>>>>
>>>> On 04/07/18 15:24, Matt Fleming wrote:
>>>>> It's possible that the CPU doing nohz idle balance hasn't had its own
>>>>> load updated for many seconds. This can lead to huge deltas between
>>>>> rq->avg_stamp and rq->clock when rebalancing, and has been seen to
>>>>> cause the following crash:
>>>>>
>>>>>  divide error: 0000 [#1] SMP
>>>>>  Call Trace:
>>>>>   [<ffffffff810bcba8>] update_sd_lb_stats+0xe8/0x560
>>
>> My confusion comes from not seeing where that crash happens. Would you mind
>> sharing the associated line number? I can feel the "how did I not see this"
>> from there but it can't be helped :(
> 
> The divide by zero comes from scale_rt_capacity() where 'total' is a
> u64 but gets truncated when passed to div_u64() since the divisor
> parameter is u32.
> 

Ah, nasty one. Interestingly enough that bit has been changed quite recently,
so I don't think you can get a div by 0 in there anymore - see
523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()") and subsequent
cleanups.

> Sure, you could use div64_u64() instead, but the real issue is that
> the load hasn't been updated for a very long time and that we're
> trying to balance the domains with stale data.
> 

Yeah I agree with that. However, the problem is with cpu_load - blocked load
on nohz CPUs will be periodically updated until entirely decayed. And if we
end up getting rid of cpu_load (depends on how [1] goes), then there's
nothing left to do. But we're not there yet...

[1]: https://lore.kernel.org/lkml/20180809135753.21077-1-dietmar.eggemann@arm.com/
