Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402B5218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfAYKm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:42:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45018 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYKm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:42:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80CEBEBD;
        Fri, 25 Jan 2019 02:42:28 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 692A83F5AF;
        Fri, 25 Jan 2019 02:42:26 -0800 (PST)
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To:     mike.leach@linaro.org, saiprakash.ranjan@codeaurora.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, rnayak@codeaurora.org,
        vivek.gautam@codeaurora.org, sibis@codeaurora.org
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-2-mike.leach@linaro.org>
 <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
 <CAJ9a7Vh6McpjtyRuBDPSYMWec0TuWkXeOLBOpKvv8tWUU0sV2A@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f4d78f6f-1b85-22ca-bfa6-abaf0d67a898@arm.com>
Date:   Fri, 25 Jan 2019 10:42:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vh6McpjtyRuBDPSYMWec0TuWkXeOLBOpKvv8tWUU0sV2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

On 25/01/2019 10:37, Mike Leach wrote:
> Hello Sai
> On Fri, 25 Jan 2019 at 07:20, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> Hi Mike,
>>
>> Thanks for the patch.
>>
>> BTW somehow I can't find the latest series in my inbox, so commenting
>> on this here.
>>
>> Mathieu pointed me to this patch series.This solves CPU debug module
>> sharing same PID as ETM on MSM8996. I will be posting patch for CPU
>> debug UCI table soon.
>>
>> But please find my one comment inline.
>>
>> On 12/19/2018 3:29 AM, Mike Leach wrote:
>>> The CoreSight specification (ARM IHI 0029E), updates the ID register
>>> requirements for components on an AMBA bus, to cover both traditional
>>> ARM Primecell type devices, and newer CoreSight and other components.
>>>
>>> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
>>> cases to uniquely identify components. CoreSight components related to
>>> a single function can share Peripheral ID values, and must be further
>>> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
>>> PMU and Debug hardware of the A35 all share the same PID.
>>>
>>
>> [..]
>>
>>> +static const struct amba_id *
>>> +amba_lookup(const struct amba_id *table, struct amba_device *dev)
>>> +{
>>>        while (table->mask) {
>>> -             ret = (dev->periphid & table->mask) == table->id;
>>> -             if (ret)
>>> -                     break;
>>> +             if (((dev->periphid & table->mask) == table->id) &&
>>> +                     ((dev->cid != CORESIGHT_CID) ||
>>> +                      (amba_cs_uci_id_match(table, dev))))
>>
>> Shouldn't the check be (dev->cid == CORESIGHT_CID) ?
>> Without this STM fails to probe on both SDM845 and MSM8996.
>>
> I believe the test is correct
> 
> To expand the logic here:
> 
> if  (dev->periphid & table->mask) == table->id) {
>        //** match on peripheral ID at this point
>       if (CID != CORESIGHT_ID)
>                 return table; //** not coresight - match on peripheral ID only
>       //** or
>       if (amba_cs_uci_id_match() )
>                  return table;  //** is coresight - match on UCI if
> available - otherwise peripheral ID only;
> 
> However - looking at the coresight STM driver - this is using the
> private .data field in the amba_id for a name - which I had not
> spotted before.

Good point. We also use this field for Coresight SOC-600 ETR for
advertising the caps not detected from hardware.

> I will have to revisit this patchset to fix either the amba id struct
> or the method for getting the uci data into the amba_id.data which
> allows for multiple uses.

Thanks Mike !

Cheers
Suzuki
