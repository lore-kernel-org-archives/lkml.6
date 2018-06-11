Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mcV4MhJ/HlvxZAAAmS7hNA
	; Mon, 11 Jun 2018 13:54:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD22560792; Mon, 11 Jun 2018 13:54:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5545060385;
	Mon, 11 Jun 2018 13:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5545060385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeFKNyU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:54:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51842 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932822AbeFKNyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:54:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB781529;
        Mon, 11 Jun 2018 06:54:19 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9033F318;
        Mon, 11 Jun 2018 06:54:17 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
 <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
 <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <847dfe5c-665c-6398-f87f-3ca56e73f5aa@arm.com>
Date: Mon, 11 Jun 2018 14:54:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 15:46, Suzuki K Poulose wrote:
> Hi Mark,
> 
> On 06/06/2018 07:01 PM, Mark Rutland wrote:
>> On Tue, May 29, 2018 at 11:55:56AM +0100, Suzuki K Poulose wrote:

> 
>>> -        value |= 0xffffffff00000000ULL;
>>> +        if (!armv8pmu_event_is_64bit(event))
>>> +            value |= 0xffffffff00000000ULL;
>>>           write_sysreg(value, pmccntr_el0);
>>> -    } else if (armv8pmu_select_counter(idx) == idx)
>>> -        write_sysreg(value, pmxevcntr_el0);
>>> +    } else
>>> +        armv8pmu_write_hw_counter(event, value);
>>>   }
>>
>>> +static inline void armv8pmu_write_event_type(struct perf_event *event)
>>> +{
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    int idx = hwc->idx;
>>> +
>>> +    /*
>>> +     * For chained events, write the the low counter event type
>>> +     * followed by the high counter. The high counter is programmed
>>> +     * with CHAIN event code with filters set to count at all ELs.
>>> +     */
>>> +    if (armv8pmu_event_is_chained(event)) {
>>> +        u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
>>> +                ARMV8_PMU_INCLUDE_EL2;
>>> +
>>> +        armv8pmu_write_evtype(idx - 1, hwc->config_base);
>>> +        isb();
>>> +        armv8pmu_write_evtype(idx, chain_evt);
>>
>> The ISB isn't necessary here, AFAICT. We only do this while the PMU is
>> disabled; no?
> 
> You're right. I was just following the ARM ARM.

Taking another look, it is not clear about the semantics of "pmu->enable()"
and pmu->disable() callbacks. I don't see any reference to them in the perf core
driver anymore. The perf core uses add() / del () instead, with the PMU
turned off. Do you have any idea about the enable()/disable() callbacks ?
Am I missing something ?

Suzuki
