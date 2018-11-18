Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B382C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B771E2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSndIbxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B771E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeKRMgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 07:36:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37010 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKRMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 07:36:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so14277015wru.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OWk0TSu9WDqyT9PG100qaYPEtln+OxuZ+U1Xy+PAkY4=;
        b=dSndIbxWp8qr4HUJNsEmoy3reGSyHHMNaBXRncwJF7ehcDlaa2z/4Kd4ppiK595DYM
         1BvsLYfWz41qZ0LA2qjOSkSfmI7o2ttxELne5Xgd+3jC+3qVyxHAUuRcuBn+A2nGhpNJ
         6fiDCO1+T6fhlzDmncR+JyiGA3GC94L5HHjYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OWk0TSu9WDqyT9PG100qaYPEtln+OxuZ+U1Xy+PAkY4=;
        b=gyjxikj8pnWIARNTyiIXNSNLEKZfGOu5tcQrrD592xcS69WB2E5T6TLe4Y/xAS2pav
         1pRPwIbhgggRaUfDx2ebpDbRq/JmluvnhoHTz7vM9M+2gpZpDNmB75FjQ7vI0fB2d+wq
         i3A0jLakrrofX1yMm+/KG5+lVqSWj9c0a6U/W7gnyFUUVY2i6t7aV91CPXNF7cn0LJBK
         iPSPk2m/EcD9yQfy8ReABDSeefunL8AwDgs7x87xdBer+smGmWTGGZ2hRXgvj141Cuk0
         LRu2SaEZifyiyL/FnNwHk4cwxEG6VZb+/cRS2IHdUWsbfsacSW5cBMV0vEdxFcR+WMCQ
         jkmA==
X-Gm-Message-State: AGRZ1gLIwe/ry5GMSyl7omsfgbzdVYfiN6g6mbtuMKZKAzqVk0WdSiSz
        omhkCmHNzPRQwhwuEV9tHfetig==
X-Google-Smtp-Source: AJdET5fO7QEIfo5nv2ja3GGSjT+FNEn2fyWvAsq7NNT31Bjog+oVUSftqgRUB37DbE96X2Ljpw6Kag==
X-Received: by 2002:adf:a20a:: with SMTP id p10-v6mr13495581wra.249.1542507439006;
        Sat, 17 Nov 2018 18:17:19 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id q7-v6sm25431475wmg.27.2018.11.17.18.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 18:17:18 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
 <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
Message-ID: <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
Date:   Sun, 18 Nov 2018 03:17:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 15:39, Daniel Lezcano wrote:
> On 24/10/2018 00:33, Vineet Gupta wrote:
>> On 10/17/2018 04:30 AM, Alexey Brodkin wrote:
>>> It turned out we used to use default implementation of sched_clock()
>>> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
>>> by default we had 10 msec granularity of time measurement.
>>>
>>> Now given ARC built-in timers are clocked with the same frequency as
>>> CPU cores we may get much higher precision of time tracking.
>>>
>>> Thus we switch to generic sched_clock which really reads ARC hardware
>>> counters.
>>>
>>> This is especially helpful for measuring short events.
>>> That's what we used to have:
>>> ------------------------------>8------------------------
>>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>>
>>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>>
>>>          10.000000      task-clock (msec)         #    2.832 CPUs utilized
>>>                  1      context-switches          #    0.100 K/sec
>>>                  1      cpu-migrations            #    0.100 K/sec
>>>                 63      page-faults               #    0.006 M/sec
>>>            3049480      cycles                    #    0.305 GHz
>>>            1091259      instructions              #    0.36  insn per cycle
>>>             256828      branches                  #   25.683 M/sec
>>>              27026      branch-misses             #   10.52% of all branches
>>>
>>>        0.003530687 seconds time elapsed
>>>
>>>        0.000000000 seconds user
>>>        0.010000000 seconds sys
>>> ------------------------------>8------------------------
>>>
>>> And now we'll see:
>>> ------------------------------>8------------------------
>>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>>
>>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>>
>>>           3.004322      task-clock (msec)         #    0.865 CPUs utilized
>>>                  1      context-switches          #    0.333 K/sec
>>>                  1      cpu-migrations            #    0.333 K/sec
>>>                 63      page-faults               #    0.021 M/sec
>>>            2986734      cycles                    #    0.994 GHz
>>>            1087466      instructions              #    0.36  insn per cycle
>>>             255209      branches                  #   84.947 M/sec
>>>              26002      branch-misses             #   10.19% of all branches
>>>
>>>        0.003474829 seconds time elapsed
>>>
>>>        0.003519000 seconds user
>>>        0.000000000 seconds sys
>>> ------------------------------>8------------------------
>>>
>>> Note how much more meaningful is the second output - time spent for
>>> execution pretty much matches number of cycles spent (we're running
>>> @ 1GHz here).
>>>
>>> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>
>> Acked-by: Vineet Gupta <vgupta@synopsys.com>
>>
>> @Daniel is this going via timer tree or you want me to pick it up.
> 
> I will take care of it.

Please resend without the arch Kconfig change


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

