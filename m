Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03891C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31C024845
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31C024845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeGCNNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:13:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752423AbeGCNNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:13:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9230D80D;
        Tue,  3 Jul 2018 06:13:47 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 778DD3F5A0;
        Tue,  3 Jul 2018 06:13:46 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] arm_pmu: Tidy up clear_event_idx call backs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, julien.thierry@arm.com, robin.murphy@arm.com
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
 <1530568788-26458-5-git-send-email-suzuki.poulose@arm.com>
 <20180703124905.75uttsh7xrrzh55q@lakrids.cambridge.arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <6592be36-3b16-f566-96ff-15f97964d4c4@arm.com>
Date:   Tue, 3 Jul 2018 14:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703124905.75uttsh7xrrzh55q@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/18 13:49, Mark Rutland wrote:
> On Mon, Jul 02, 2018 at 10:59:45PM +0100, Suzuki K Poulose wrote:
>> The armpmu uses get_event_idx callback to allocate an event
>> counter for a given event, which marks the selected counter
>> as "used". Now, when we delete the counter, the arm_pmu goes
>> ahead and clears the "used" bit and then invokes the "clear_event_idx"
>> call back, which kind of splits the job between the core code
>> and the backend. To keep things tidy, mandate the implementation
>> of clear_event_idx() and add it for exisiting backends.
>> This will be useful for adding the chained event support, where
>> we leave the event idx maintenance to the backend.
>>
>> Also, when an event is removed from the PMU, reset the hw.idx
>> to indicate that a counter is not allocated for this event,
>> to help the backends do better checks. This will be also used
>> for the chain counter support.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v3:
>>   - Add clear_event_idx call back for backends.
>> ---
>>   arch/arm/kernel/perf_event_v6.c | 8 ++++++++
>>   arch/arm/kernel/perf_event_v7.c | 9 +++++++++
>>   arch/arm64/kernel/perf_event.c  | 7 +++++++
>>   drivers/perf/arm_pmu.c          | 7 +++----
>>   4 files changed, 27 insertions(+), 4 deletions(-)
> 
> I beleive this is missing the xscale PMU code.

Ah! Thanks for spotting. I will fix that.
> 
> Otherwiwse, this looks good to me.

Thanks
Suzuki
