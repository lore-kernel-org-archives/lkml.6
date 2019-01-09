Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63402C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A30C20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfAIOzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:55:51 -0500
Received: from foss.arm.com ([217.140.101.70]:45508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbfAIOzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:55:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD80680D;
        Wed,  9 Jan 2019 06:55:49 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909F23F694;
        Wed,  9 Jan 2019 06:55:46 -0800 (PST)
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To:     mathieu.poirier@linaro.org
Cc:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        Suzuki.Poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
 <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
 <bb313a2d-b5fc-9329-5db6-4bf661d278bb@arm.com>
 <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b082bf81-2148-2b43-5b1a-0bdf4b1e62c0@arm.com>
Date:   Wed, 9 Jan 2019 14:55:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 07/01/2019 18:18, Mathieu Poirier wrote:
> On Wed, 19 Dec 2018 at 02:40, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 18/12/2018 17:34, Mathieu Poirier wrote:
>>> Good day Suzuki,
>>>
>>> On Tue, 18 Dec 2018 at 07:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

>>>> We could assign a static "id/key" exported either via the device sysfs dir or
>>>> the "pmu" dir. I prefer the latter.
>>>
>>> Not sure what you mean by "pmu" directory - would you mind expanding
>>> on that?  Using sysfs would be quite easy but I am reluctant to create
>>> a new id/key mechanism and introduce another entry when we have the
>>> component address that is unique and already available in the amba
>>> directory structure.
>>
>> We could add another directory under :
>>
>> /sys/bus/event_source/devices/<PMU>/
>>                                  \_ events/
>>                                  \_ format/
>> say :
>>                  \_ drv_config/
>>                  Or
>>                  \_ sinks/
>>
>> and list the sinks, eg:
>> # cd $sysfs_pmu_dir/sinks
>> # cat <name_of_the_sink>
>> ID_of_the_sink
> 
> There is merit to this idea.  Thinking along those lines simply using
> "sinks" is probably a better approach since we don't yet know how PMU
> configuration will unfold.  I'm also wondering if we have to
> explicitly list the ID of the sink.  The ID itself should be fetch
> from the device specific entries in sysfs like the "resource" property
> of sinks that show up on the AMBA bus.  Sinks that don't show up on
> the AMBA bus will likely have a "reg" property of something similar
> and that is where the ID should be taken from.

I would recommend this be done by the PMU driver and expose it, rather
than specifying what is expected. If we keep it simple like an integer,
which is then mapped to the sink-device, we could save some bits in the
config field for further use and a the complex set of rules for the ID.

> 
> Lastly it may be tricky to add a new directory structure to the PMU
> entry as it is generic for all PMUs in the system.  But that is up for
> investigation and I will look into doing something like that.

I don't think this is particularly problematic. The PMU driver can provide
a list of attribute_groups which should eventually appear in the device
directory under the "bus/event_source/devices/<PMU>/". And that provides
a central place for finding the SINK id for all the available sinks, rather
than scanning for a sink under all the buses (e.g, platform, amba) wherever
that might show up.

> 
>>
>> Btw, I am always inclined to using some bits off one of the "config" fields
>> ("config1" or "config2") for the sink configuration. But I understand that
>> you have explored that avenue and chose this approach as we have further
>> configurations required for complex ETM settings.
> 
> I've had a good conversation with myself over the holidays on that
> topic (hence the late-ish reply).  My original approach was to use the
> same ioctl() mechanism to do sink selection and complex PMU
> configuration.  But as Greg confirmed with his comment on the previous
> patch doing so requires to iron out how the latter will be done on ARM
> (and probably on Intel too), something that is a different deal
> altogether.
> 
> Taking a step back and forgetting about complex PMU configuration for
> a minute, the ID of a sink can easily be stuffed in one of the
> "config" fields of the perf_event_attr structure, something I alluded
> to in the patchset's cover letter.  That way we can move along with
> this feature and leave the discussion on complex PMU configuration for
> another day.

Cool ! I completely agree with this.

> 
> I'll do a respin with the above in mind.
> 
> A happy new year to you,

You too.

Cheers
Suzuki
