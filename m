Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D60C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086D820823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvjvDWYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086D820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeKSUGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:06:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeKSUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:06:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so17023557wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XPJOVs7SqmH570d8/Mm+8YNXax9ykmPSR22e6HoTJnI=;
        b=YvjvDWYLDGJeXCA4xcmkpXTEQjzWs4jpQQAmxqdjvAxZeFoAMqS/SB6Z7a2Fs8btNs
         LR4Hm2IgpIAJJ5zA5lBgO6wcl/jCINLbj4A3b09ZBbj+Txa5UlqJq8A/zAYju5dAfJoX
         Cs1/T+rVaaOWEA9UDCNSEOBBOKTMu1IZdfCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XPJOVs7SqmH570d8/Mm+8YNXax9ykmPSR22e6HoTJnI=;
        b=a0rTjFW3sdtAbhhJc1l/tRZGZQ5S6e42E3nv/gkeC5YLde+NUfyyXkV7bZD3KR0VMo
         zkqtrqYhMIUpAZbduOe+n0VA/Y3uSK6oBwX3LQAmiQiG+qhHZhsUKZxrwLddCWdAm4jm
         fn2RFAxhXqSe4dMfsvKTiYuwttogYg/D09Idog1by2dox1UbmB41PlpSJ5F82BKznLiN
         6ZfrSQKVgXJ/b3ejloh0qeA8AwNfG+yxgRwW1wE7072+gPYEr9gpM4+i4xI2V704+rDC
         hfUqFG9NJkx+4Au7fuYTOS4IAcRWF0gK/kX+8VKLiZbO3u/qwNbY+wHx0rY9mwagGwhB
         CMHg==
X-Gm-Message-State: AA+aEWZhHv2et7PMD86XBdGXyna6+SWG0CmeGOeawfj/x3Y2vDlTofAD
        62T/i0w+TZDwrTt9nTQmcQx+Rg==
X-Google-Smtp-Source: AFSGD/WAYDSjSV09LUAm/RJHXOeAQuO8l+kTMOgWG7hu0aqPXhCSDp2UksZh6+C0lbhAkVIILAcDhQ==
X-Received: by 2002:adf:f605:: with SMTP id t5mr5933280wrp.229.1542620582544;
        Mon, 19 Nov 2018 01:43:02 -0800 (PST)
Received: from [192.168.0.40] (51.223.136.77.rev.sfr.net. [77.136.223.51])
        by smtp.googlemail.com with ESMTPSA id a204sm5324121wmh.23.2018.11.19.01.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 01:43:01 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
 <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
 <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
 <dab866a50e66e73f6010de1487b06019887930c8.camel@synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <40ada5b3-5824-51fd-501f-ef363f162047@linaro.org>
Date:   Mon, 19 Nov 2018 10:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dab866a50e66e73f6010de1487b06019887930c8.camel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 10:31, Alexey Brodkin wrote:
> Hi Daniel,
> 
> On Sun, 2018-11-18 at 03:17 +0100, Daniel Lezcano wrote:
>> On 05/11/2018 15:39, Daniel Lezcano wrote:
>>> On 24/10/2018 00:33, Vineet Gupta wrote:
>>>> On 10/17/2018 04:30 AM, Alexey Brodkin wrote:
>>>>> It turned out we used to use default implementation of sched_clock()
>>>>> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
>>>>> by default we had 10 msec granularity of time measurement.
>>>>>
>>>>> Now given ARC built-in timers are clocked with the same frequency as
>>>>> CPU cores we may get much higher precision of time tracking.
>>>>>
>>>>> Thus we switch to generic sched_clock which really reads ARC hardware
>>>>> counters.
>>>>>
>>>>> This is especially helpful for measuring short events.
>>>>> That's what we used to have:
>>>>> ------------------------------>8------------------------
>>>>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>>>>
>>>>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>>>>
>>>>>          10.000000      task-clock (msec)         #    2.832 CPUs utilized
>>>>>                  1      context-switches          #    0.100 K/sec
>>>>>                  1      cpu-migrations            #    0.100 K/sec
>>>>>                 63      page-faults               #    0.006 M/sec
>>>>>            3049480      cycles                    #    0.305 GHz
>>>>>            1091259      instructions              #    0.36  insn per cycle
>>>>>             256828      branches                  #   25.683 M/sec
>>>>>              27026      branch-misses             #   10.52% of all branches
>>>>>
>>>>>        0.003530687 seconds time elapsed
>>>>>
>>>>>        0.000000000 seconds user
>>>>>        0.010000000 seconds sys
>>>>> ------------------------------>8------------------------
>>>>>
>>>>> And now we'll see:
>>>>> ------------------------------>8------------------------
>>>>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>>>>
>>>>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>>>>
>>>>>           3.004322      task-clock (msec)         #    0.865 CPUs utilized
>>>>>                  1      context-switches          #    0.333 K/sec
>>>>>                  1      cpu-migrations            #    0.333 K/sec
>>>>>                 63      page-faults               #    0.021 M/sec
>>>>>            2986734      cycles                    #    0.994 GHz
>>>>>            1087466      instructions              #    0.36  insn per cycle
>>>>>             255209      branches                  #   84.947 M/sec
>>>>>              26002      branch-misses             #   10.19% of all branches
>>>>>
>>>>>        0.003474829 seconds time elapsed
>>>>>
>>>>>        0.003519000 seconds user
>>>>>        0.000000000 seconds sys
>>>>> ------------------------------>8------------------------
>>>>>
>>>>> Note how much more meaningful is the second output - time spent for
>>>>> execution pretty much matches number of cycles spent (we're running
>>>>> @ 1GHz here).
>>>>>
>>>>> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> ---
>>>>
>>>> Acked-by: Vineet Gupta <vgupta@synopsys.com>
>>>>
>>>> @Daniel is this going via timer tree or you want me to pick it up.
>>>
>>> I will take care of it.
>>
>> Please resend without the arch Kconfig change
> 
> I'm wondering if there's a problem with arc/arc/Kconfig change going
> through your tree? This way it will be really atomic change and it will be
> much easier to back-port (and that's what we'd really like to happen).
> 
> If Vineet is OK with that IMHO it's safe to keep it in the one and only commit.
> 
> Otherwise should I just split this patch in 2 and still submit them as series or
> have 2 completely not-related patches one for you and one for Vineet?
> 
> In that case do I understand correctly that we may enable GENERIC_SCHED_CLOCK
> for ARC even before proposed change for arc_timer.c gets merged - i.e. with no
> special GENERIC_SCHED_CLOCK driver we'll safely fall-back to jiffie-based
> sched clock which we anyways use now when GENERIC_SCHED_CLOCK is disabled, right?

The ARC's Kconfig part does not apply on tip/timers/core.

As you described, sending a separate arc timer change is fine IMO.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

