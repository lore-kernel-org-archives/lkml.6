Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232DB2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKn/w1TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232DB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJCRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:13:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33154 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeJCRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:13:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so6836242wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k1X/7IMWOomyMNI1ftBqsHxL7tiHmRqv0dj5czFxSSU=;
        b=eKn/w1TEmuGgZolSVpfjydmGMuM+iGrwnJDz7szxJgIueDAYcCWIeQi+R4emUBPmct
         JedM/L97YN9OIVNWjgrlMO11BqX7F2cA5gn4/q4q459KR95842TiWvVEl74iHBhEGK9U
         RL4hxlt2ZhhAs9lgg4Ynv7o+Jbge4tOl4IQyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k1X/7IMWOomyMNI1ftBqsHxL7tiHmRqv0dj5czFxSSU=;
        b=BhgovdkJ4WKSseWvvf5PCvuNWmFNaF8pwdDaCU9uXCSWpxxjzxj7Z6aFgVNxI+ENHL
         df9OQ5QWn6dfGZ9e027LqcjAORsKDmk4AwGZSK0KxkPCZ6ag7zyH0NUw7PoprtoSYQqZ
         0jeHXEZzMpBQt4f/+E5GFRvXXGGikYWRPjkycNU7N1y6fSSu267cqiUVzFMp9BAJoJtz
         cUvgNkPJAABsR+CMZvyXmLyPr6qsQ5uzTWqPXOr1I0nfPaSWkwaAZuB93bAaAwWfkDGd
         9zAN6gZhxY6WgdRxL9IahdaYzRLGn/DIJnnuZmlB3V2xRnPF7JEgJupaHYPK1Wx0pYSm
         K59Q==
X-Gm-Message-State: ABuFfoiLH2Pi2dbVdVsa/JNyX6KA/9Gwryc7bKrJvoEV11r/3KPqeDNE
        9qlxNTvFl1x05LON5h/QhekvhBwGPFs=
X-Google-Smtp-Source: ACcGV60Bi9ooyGKFkS5TeQq3MwpEfHjxqevkQ7zlDQQTHo9btg6wD/trytzjyye/+7fRB5waH6lMHQ==
X-Received: by 2002:a1c:448a:: with SMTP id r132-v6mr1013583wma.132.1538562323100;
        Wed, 03 Oct 2018 03:25:23 -0700 (PDT)
Received: from [192.168.0.41] (84.152.136.77.rev.sfr.net. [77.136.152.84])
        by smtp.googlemail.com with ESMTPSA id t4-v6sm1019456wrb.45.2018.10.03.03.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 03:25:22 -0700 (PDT)
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
 <4200780.ZjVhNjpZ67@aspire.rjw.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ab561a7d-9425-7b04-8d11-ed3e85afe971@linaro.org>
Date:   Wed, 3 Oct 2018 12:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4200780.ZjVhNjpZ67@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 10:58, Rafael J. Wysocki wrote:
> On Tuesday, September 25, 2018 11:38:44 AM CEST Daniel Lezcano wrote:
>> The function get_loadavg() returns almost always zero. To be more
>> precise, statistically speaking for a total of 1023379 times passing
>> to the function, the load is equal to zero 1020728 times, greater than
>> 100, 610 times, the remaining is between 0 and 5.
>>
>> I'm putting in question this metric. Is it worth to keep it?
> 
> The honest answer is that I'm not sure.
> 
> Using the CPU load for driving idle state selection is questionable in general
> (there need not be any connection between the two in principle) and this
> particular function is questionable either.  If it really makes no difference
> in addition to that, then yes it would be good to get rid of it.
> 
> That said it looks like that may be quite workload-dependent, so maybe there
> are workloads where it does make a difference?  Like networking or similar?

Perhaps initially the load was not the same:


commit 69d25870f20c4b2563304f2b79c5300dd60a067e
Author: Arjan van de Ven <arjan@infradead.org>
Date:   Mon Sep 21 17:04:08 2009 -0700

    cpuidle: fix the menu governor to boost IO performance


The function get_loadavg() was:

static int get_loadavg(void)
{
       unsigned long this = this_cpu_load();

       return LOAD_INT(this) * 10 + LOAD_FRAC(this) / 10;
}

With:

unsigned long this_cpu_load(void)
{
        struct rq *this = this_rq();
        return this->cpu_load[0];
}


Now we pass the load we got from get_iowait_load() which is:

void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
{
        struct rq *rq = this_rq();
        *nr_waiters = atomic_read(&rq->nr_iowait);
        *load = rq->load.weight;
}

Colin Cross did some measurements a few years ago and concluded it is
zero most of the time, otherwise the number is so high it has no
meaning. The get_loadavg() call is removed from Android since 2011 [1].

I can hack my server (bi Xeon - 6 cores), add statistics regarding this
metric and let it run during several days, sure a lot of different
workloads will happen on it (compilation, network, throughput computing,
...) in a real use case manner. That is what I did with an ARM64
evaluation board.

However I won't be able to do that right now and that will take a bit of
time. If you think it is really useful, I can plan to do that in the
next weeks.

 -- Daniel

[1]
https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

