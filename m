Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B86FBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326D20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rx+Yi/hP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326D20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeFMJDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:03:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43596 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeFMJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:03:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so1858078wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uNDhrysaWONUJsIifi6kbTeclrqvDoCln4Nqj8RkUGo=;
        b=Rx+Yi/hPCkGE8CNWb/EAXOFlWbwWhewd5znfELefg0kbyf4/rcXSKUeW55zirT5TU/
         LTEhQ9uKW+SRWyUTKL44HNgPDXjfXy1l5CieeThfjvaytRGkeeUKEBjecv1h25na20O3
         ecTrWb3i9OUf2awGhM95GvO55x92cX4IVjI34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uNDhrysaWONUJsIifi6kbTeclrqvDoCln4Nqj8RkUGo=;
        b=rezjjEhoLOA4bgICj2JqG8dAsAlAyNZKvI1aB1MzqwoxQBvALvS9z1K99kX5T/SYWV
         Fhl2ixn8Y6VwRSClToJ8y2hkKWnsm4F+jH4gzOUAmgg8AZj2I8eCiuBzHCiKAsGyZomp
         Bo59rN2+yDdzi6VFN7TXHkd1maUMykm32MOJsiYSuYrfuZdFdRuJuA5xbV/VM6D5QaCj
         dhBZkC5/OY1vR79sRpBLKusi9+jBeUp8LpwhfWtmJuTMFo3/QSKH/+ikUMxNL+Q/RRLD
         OATVe8mTP/jtfQLauZK3/nVdVUo1ttXeKgnKwe7t7plMgtmOkF2im2+cxQ77OiQNZt1S
         mkiQ==
X-Gm-Message-State: APt69E2TA2QRcIXm1yamwSK/Z3qFrmstGpOkCK9ZPdEk79Bw+eNdiqdQ
        RT9AfOF5c9D/0QV/B4ZVUXnUrw==
X-Google-Smtp-Source: ADUXVKIEJdxn0rnneDClF40Gz2i1KJRqgtdHFHYIKs2SrC5DmfmizAc/OcJPk9HhQiHkX9rrOvKtSw==
X-Received: by 2002:adf:f344:: with SMTP id e4-v6mr3358424wrp.161.1528880591515;
        Wed, 13 Jun 2018 02:03:11 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:b0fb:9cfa:79ac:305e? ([2001:41d0:fe90:b800:b0fb:9cfa:79ac:305e])
        by smtp.googlemail.com with ESMTPSA id n17-v6sm3490234wmd.14.2018.06.13.02.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 02:03:10 -0700 (PDT)
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
 <20180612173514.GV12217@hirez.programming.kicks-ass.net>
 <20180613085509.s7ktdespfyjpozuu@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b9dba62b-35df-46a9-a66c-3ec0952109b6@linaro.org>
Date:   Wed, 13 Jun 2018 11:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613085509.s7ktdespfyjpozuu@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2018 10:55, Viresh Kumar wrote:
> On 12-06-18, 19:35, Peter Zijlstra wrote:
>> On Tue, Jun 12, 2018 at 07:02:57PM +0200, Daniel Lezcano wrote:
>>> Mmh, it is unclear for me if the park() vs wakeup() can happen at the
>>> same time.
>>>
>>> If the park() function is called, that means the hotplug is allowed.
>>
>> No, it means we're inside hot-un-plug, but that doesn't stop the hrtimer
>> from firing.
>>
>>> If the hotplug is allowed, we can modify the online mask.
>>>
>>> What happens with the online mask when we are processing it in an
>>> interrupt context ?
>>
>> RCU-like, if you observe a CPU in the online mask, it will stay
>> available, but the bit might get cleared.
>>
>>>> Maybe avoid the issue entire by having a
>>>> {period,idle} tuple, where your old run := period - idle.
>>>
>>> Can you elaborate ? I don't get it.
>>
>> Have a period parameter that specifies the interval in which you have
>> one injected idle, and specify for how long you want to inject idle;
>> then obviously idle < period.
>>
>>>>>> Furthermore, should you not be using hrtimer_forward(&timer,
>>>>>> idle_duration + run_duration) instead? AFAICT the current scheme is
>>>>>> prone to drifting.
>>>>>
>>>>> (I assume you meant setting the timer in the wakeup task function).
>>>>>
>>>>> Yes, drifting is not an issue if that happens. This scheme is simpler
>>>>> and safer than setting the timer ahead before waking up the tasks with
>>>>> the risk it expires before all the tasks ended their idle cycles.
>>>>
>>>> sloppy though..
>>>
>>> Ok, do you prefer to see the timer set in the wakeup function and thus
>>> having a periodic tick for the idle injection ?
>>
>> I think having a HRTIMER_RESTART handler that does hrtimer_forward() is
>> the most sensible. You will end up having to deal with threads not being
>> ready, but I think that's not a real problem.
> 
> Honestly speaking I am not sure if we can fix all the races we have identified
> until now, with the current design and the fear of using resources after getting
> freed will always be there. Too many corner cases really.
> 
> The requirement we have is to make sure no kthread or hrtimer is still in use
> when the ii_dev is freed from idle_injection_unregister().
> 
> May be the only sane way to make it work is to call
> smpboot_register_percpu_thread() from idle_injection_register() and then
> unregister those threads from idle_injection_unregister().

nr_threads(smpboot) <> nr_threads(idleinject)

If we are facing races issues, it is because we are trying to avoid
using locks in the code path. With lock and proper refcounting that
should be solved, AFAICT there are similar races with inodes.

Furthermore, hrtimer_forward approach is probably cleaner.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

