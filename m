Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63177C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22577208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22577208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeGIPMu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933412AbeGIPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:12:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AB5FED1;
        Mon,  9 Jul 2018 08:12:33 -0700 (PDT)
Received: from [10.1.211.34] (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020C63F589;
        Mon,  9 Jul 2018 08:12:31 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com, arnd@arndb.de
Subject: Re: [PATCH] tick: prefer a lower rating device only if it's CPU local
 device
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        tglx@linutronix.de
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
 <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com>
 <20180703105357.GC1715@e107155-lin>
 <CAOi56cW-QsL9gmyF-R9iscZ1M-zM-gJPxcvG=dvB=zrDioZJgA@mail.gmail.com>
 <20180703154459.GA15335@e107155-lin>
 <alpine.DEB.2.21.1807031805560.1601@nanos.tec.linutronix.de>
 <20180703164823.GB15335@e107155-lin>
 <CAFBinCBhBBK1TZnhH1bGrQP5SokaMNrk7C8OcMXaaTcR6_WOTg@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <299fd143-fc79-60de-40c7-fced7e9b3fb0@arm.com>
Date:   Mon, 9 Jul 2018 16:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBhBBK1TZnhH1bGrQP5SokaMNrk7C8OcMXaaTcR6_WOTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/18 21:59, Martin Blumenstingl wrote:
> Hi Thomas,
> 
> On Tue, Jul 3, 2018 at 6:48 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> Hi Thomas,
>>
>> On Tue, Jul 03, 2018 at 06:08:19PM +0200, Thomas Gleixner wrote:
>>
>> [...]
>>
>>>>> / # cat /sys/devices/system/clockevents/broadcast/current_device
>>>>> meson6_tick
>>>>
>>>> OK, it can support broadcast
>>>>
>>>>> / # cat /sys/devices/system/clockevents/clockevent0/current_device
>>>>> dummy_timer
>>>>> / # cat /sys/devices/system/clockevents/clockevent1/current_device
>>>>> dummy_timer
>>>>> / # cat /sys/devices/system/clockevents/clockevent2/current_device
>>>>> dummy_timer
>>>>
>>>> But I can't understand why is dummy_timer the active event source and
>>>> not meson6_tick. And you say this is working case ? Looks suspicious.
>>>
>>> Because if it switches to broadcast mode then the meson timer cannot longer
>>> be used as per cpu timer. It's broadcasting to all CPUs via the dummy timer.
>>
>> Thanks for the explanation. I completely misread the sysfs entry and
>> assume clockevent_register failed for meson6 and hence regarded as
>> suspicious which is complete non-sense, my bad. Sorry for that.
>> I think I now understand the issue.
>>
>> 1. Juno usecase for which $subject was added as fix:
>>
>> Two system wide timers(cpumask=possible cpus) with rating 300 and 400.
>> When second one with 400 is added, timer with rating 300 is added to
>> released list and again added back to main one. In this case both were
>> chosen as preferred and that resulted in deadlock.
>>
>> 2. Meson6 usecase:
>>
>> When meson6_tick is added, it's set as preferred and dummy_timer is released.
>> When it's being added back from the released list, it will be chosen as
>> preferred as it's per_cpu resulting in deadlock.
>>
>> I am not sure how to fix this. Should the fix to my original problem have
>> checks for both old and new for per-cpu  to prevent the issue reported on
>> Meson6
> could you please answer Sudeep's question?
> 

OK, I think I have misunderstood my original problem because of the
cpumask_equal for nr_bits <= BITS_PER_LONG. It uses nr_cpumask_bits
which is NR_CPUS when CPUMASK_OFFSTACK is not enabled.

Enabling it fixes my original problem(reverting $subject patch). So it
should be reverted. And also pointed out the issue with ARM mem timer.

I am sorry for the mess, I will post the revert and along with the fix
to my issue. Once again sorry for not understanding the root cause
correctly.
-- 
Regards,
Sudeep
