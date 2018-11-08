Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566BC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993B22086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4WzW+WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993B22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeKHRot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:44:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKHRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:44:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so20190430wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 00:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aczT1AI8ofSXeg8XIZJpSK1FfsNvEbjAoYiBYGwb8gY=;
        b=K4WzW+WP8kkw319lIXo8aLnc/x17nP7W60kRoQxBEUHvUdniOYZzFbcCv2UgnxO2sU
         ttYJ/kwoseu5eqyMzARYXRe/BU6WsEl8ubjPcFH+HL4H/OefU35BBxbkhCXT8FYViPpL
         k1M1RAU1uFYBLSoEgA0rNe1Ap43aQm0Xc2XQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aczT1AI8ofSXeg8XIZJpSK1FfsNvEbjAoYiBYGwb8gY=;
        b=IvecbO/HRTERCadMS83lsgElztVORcRbBLuIEhVCtFx6Uhsln0KB0U3rujfzUUIdju
         DaGNmt1q6Qa8WqJWCAvQJcv0t9N1D+zawOoExobwqs4PEKvE4vsoh8I+P5QRMfSSDYwm
         0OfoTDGDiaIaAPeWgarjmJBHoRQTMhO4HigWmptuiKlta6c7qhw/ieX5py94hsS92GM6
         mpitiJ5T9NwoXlEKTi8rvkyfpR1IGrbukt8D5K3LxzMvl5sNpVSs2IOTSbfk3iOsFdKf
         TKNZckN11pRQXyY2H1hUbzCsY9XLMwCkIbz2K3A1EThVe9UqK8EeYl9QQwec2/nEPGgr
         m2wA==
X-Gm-Message-State: AGRZ1gKttc0eWQejsfwDDyknzudkISRVgdh55rqteu4Lku0/TpnxbWfq
        8rWCC1duVY9BNEg8T2Fd2O4mHA==
X-Google-Smtp-Source: AJdET5f8JNaYfmTXWA6V6VZlThP99ox3sT+uC19uD9zyqt2eYJT3LQ2KqOAh+W3b6jdFjzj7/Pv9Ng==
X-Received: by 2002:a5d:66d0:: with SMTP id k16-v6mr3399438wrw.154.1541664629295;
        Thu, 08 Nov 2018 00:10:29 -0800 (PST)
Received: from [192.168.0.40] (48.243.136.77.rev.sfr.net. [77.136.243.48])
        by smtp.googlemail.com with ESMTPSA id x6-v6sm3242763wrq.52.2018.11.08.00.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 00:10:28 -0800 (PST)
Subject: Re: [PATCH] irq/timings: Fix model validity
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
 <20181107094624.GB9828@hirez.programming.kicks-ass.net>
 <ab9e60d7-e2d3-7d0c-dbf1-c0bed7bdb516@linaro.org>
 <20181107130507.GD9761@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c9d8152a-566e-7ae6-e41c-5817c884c277@linaro.org>
Date:   Thu, 8 Nov 2018 09:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107130507.GD9761@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 14:05, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 11:52:31AM +0100, Daniel Lezcano wrote:
>>> @@ -146,11 +152,38 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>>>  	 */
>>>  	diff = interval - irqs->avg;
>>>  
>>> +	/*
>>> +	 * Online average algorithm:
>>> +	 *
>>> +	 *  new_average = average + ((value - average) / count)
>>> +	 *
>>> +	 * The variance computation depends on the new average
>>> +	 * to be computed here first.
>>> +	 *
>>> +	 */
>>> +	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
>>> +
>>> +	/*
>>> +	 * Online variance algorithm:
>>> +	 *
>>> +	 *  new_variance = variance + (value - average) x (value - new_average)
>>> +	 *
>>> +	 * Warning: irqs->avg is updated with the line above, hence
>>> +	 * 'interval - irqs->avg' is no longer equal to 'diff'
>>> +	 */
>>> +	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
>>> +
>>>  	/*
>>>  	 * Increment the number of samples.
>>>  	 */
>>>  	irqs->nr_samples++;
> 
> FWIW, I'm confused on this. The normal (Welford's) online algorithm
> does:
> 
> 	count++;
> 	delta = value - mean;
> 	mean += delta / count;
> 	M2 += delta * (value - mean);
> 
> But the above uses:
> 
> 	mean += delta / 32;
> 
> Which, for count >> 32, over-estimates the mean adjustment. But worse,
> it significantly under-estimates the mean during training.
> 
> How is the computed variance still correct with this? I can not find any
> comments that clarifies this. I'm thinking that since the mean will
> slowly wander towards it's actual location (assuming an actual standard
> distribution input) the resulting variance will be far too large, since
> the (value - mean) term will be much larger than 'expected'.

You are right, initially it was divided by min(count, 32) but for
optimization reason, we decided to change that by a power of two
constant assuming the number of samples will reach quickly 32 and the
compiler will replace that by a shift.

https://lkml.org/lkml/2017/3/23/696

>>> @@ -158,16 +191,12 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
>>>  	 * more than 32 and dividing by 32 instead of 31 is enough
>>>  	 * precise.
>>>  	 */
>>> +	variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
> 
> Worse; variance is actually (as the comment states):
> 
> 	s^2 = M2 / (count -1)
> 
> But instead you compute:
> 
> 	s^2 = M2 / 32;
> 
> Which is again much larger than the actual result; assuming count >> 32.
> 
> So you compute a variance that is inflated in two different ways.
> 
> 
> I'm not seeing how this thing works reliably.

I have to revisit this part of code soon, I will double check that.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

