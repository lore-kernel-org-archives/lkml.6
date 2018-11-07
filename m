Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253CEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19B12081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4uLwq8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19B12081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeKGTnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:43:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGTnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:43:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so15237253wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9fXbxF/K4BVxiGE+fJXIKE7FeF9SJqFRvs4QHVh+Cgg=;
        b=P4uLwq8d5Bp4zxpD1RkvYf37e5z8HR4kT2m6zKRyEPsJEzLJZdo+AKOfhZYRTjCEXc
         xrNDhYnVnqP+sMBR5J97+HLY1b7y5ZZ6n9h8eINGmwrAil0cdd4+VvlrgAAQCjas4FUB
         nje4zE8DQFTnYQD2jxoCI35us3QnGx5E6lLFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9fXbxF/K4BVxiGE+fJXIKE7FeF9SJqFRvs4QHVh+Cgg=;
        b=SPj8sbZq5voVL0ZXe1H0qDraHHlyzMsM8vmspyqWGq0zjTo78XqGw0ESjVptqglbK8
         3cwXHkUpivuI1Sp5RotmA8YwV/NUFmovjLVRycy/V3gtOi08HrroS2aPJh0zDSDImnen
         ftB91D8L6HvpJHIfulC41oOmGdjgidncPMiV7wMEXoHTXqT4TITCGyg3WnEwujM5tf82
         6hpsPZLdIm8igHPy0ksiJqikiCJJaHXiSyUDSemBp+vWZftXwXVkigHmqYMwT/IiPHPp
         5UzlGatPQPVJOebNNKeN+5rHRFfILYow9Tv1CT8wvv2lyKjBJLHW9L5DKhSJjFdn78o/
         7KpQ==
X-Gm-Message-State: AGRZ1gJVD6YZVfTgQ++RNFR5u/oOKw9KtkT14seBVSfTy0WukCfQWJ4m
        9O/HoLlNzk8+aaEJ3we+N3Ozig==
X-Google-Smtp-Source: AJdET5e323+NvvkRz7GTghVZ6jNtEZTgrF1vCvWKhiTuwu7YqkGnnQZJbsyiiqFOE2XfqpnS4Btcxg==
X-Received: by 2002:a1c:38c5:: with SMTP id f188-v6mr1368848wma.19.1541585616972;
        Wed, 07 Nov 2018 02:13:36 -0800 (PST)
Received: from [192.168.0.40] (161.230.136.77.rev.sfr.net. [77.136.230.161])
        by smtp.googlemail.com with ESMTPSA id j18-v6sm1047784wmf.39.2018.11.07.02.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:13:36 -0800 (PST)
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8a2240ab-92e2-e402-a086-1b39d04d5581@linaro.org>
Date:   Wed, 7 Nov 2018 11:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 00:39, Rafael J. Wysocki wrote:
> On Tue, Nov 6, 2018 at 8:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
>>> On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>>> Instead of this detector; why haven't you used the code from
>>>> kernel/irq/timings.c ?
>>>
>>> Because it doesn't help much AFAICS.
>>>
>>> Wakeups need not be interrupts in particular
>>
>> You're alluding to the MWAIT wakeup through the MONITOR address ?
> 
> Yes.
> 
>>> and interrupt patterns that show up when the CPU is busy may not be
>>> relevant for when it is idle.
>>
>> I think that is not always true; consider things like the periodic
>> interrupt from frame rendering or audio; if there is nothing more going
>> on in the system than say playing your favourite tune, it gets the
>> 'need more data soon' interrupt from the audio card, wakes up, does a little
>> mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
>> sleep. Same for video playback I assume, the vsync interrupt for buffer
>> flips is fairly predictable.
>>
>> The interrupt predictor we have in kernel/irq/timings.c should be very
>> accurate in predicting those interrupts.
> 
> In the above case the interrupts should produce a detectable pattern
> of wakeups anyway.
> 
> In general, however, I need to be convinced that interrupts that
> didn't wake up the CPU from idle are relevant for next wakeup
> prediction.  I see that this may be the case, but to what extent is
> rather unclear to me and it looks like calling
> irq_timings_next_event() would add considerable overhead.

I agree the current irq next event can add an overhead and actually it
works well if there are interrupts with regular interrupts but with
irregular timings interval we need to search a pattern.

The first version called 'anova' I shared with you (Peter and Rafael)
privately is pretty good to detect such intervals but the algorithm has
a cost in terms of computation in the self-learning phase. I dropped
this approach as it could be overkill.

I'm working on a different algorithm to detect such patterns which
should be faster.

That said, the pattern detection process shouldn't be happening every
time we enter idle but when the pattern is invalidated. Until the
pattern gives a successful prediction, we keep it and the repeating
period is used to give the next event.

So IMO, the cost to detect the pattern should be compensated by the
computation saving we do if the pattern is found successfully.

These are all assumptions, hopefully I can provide a patch series and
numbers in January ...



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

