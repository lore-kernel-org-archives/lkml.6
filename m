Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1D020685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4zH+YUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1D020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeKFAI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:08:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:08:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id o15-v6so6187217wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uxeZi1Yhll4H9BRPzXJvyePrMFVAVXamDRBXYsqcxeU=;
        b=T4zH+YUSxTE3jiJ1BQYwfxvY2N7TX8gva5HqPGIbYzxuejQb4i4DKm15pnISuxn/7M
         CWQo1qypPrmUI19I6vKkMRVk2WOnWIVb3V7YfZtAcK/hOuYmskjsx5FUH/P6KgIbg9at
         u687nMlEfnvp8qJ1JohzlQfqJTnJVuHchOXyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxeZi1Yhll4H9BRPzXJvyePrMFVAVXamDRBXYsqcxeU=;
        b=k+3e6LmXPvipuheVDmopcKIBgmrqYm/DU+g1wFJ6pFBXtsDxc7guaL0SswfI67EbXf
         f60PIMTTJFAhpOhMDl5kdJRfX5440RhbfNi+uBGmSjwPqq0LtiHgzn5d9qGau6mp+EIH
         JS6XaUWSR43LjCK/0iCabPaG/IV0b5Ga1Rn6fq1/r/rPs9gtgTd+m9TNJ7ha0FtsUyKw
         JNTg4fAVQDnXHcwV2CNiQ4dmIxA15o5CDf4QZuUVjkA/RkqxtvgzPhLSFnoTaCQXs4ap
         WpyyGHXFolk+dplY32vkDDqRsunchLGgB9oLJgaOTMN09q66EiZVHmj81vEDH64VGkaU
         DZFQ==
X-Gm-Message-State: AGRZ1gLIjssakGixTfOM7Hz5J1Mv2u9pXyNNeuRtiSNeK9J+TLa4N5Ug
        OvyQVdfAfpsB5G8F49f5fqXbIf5eP60=
X-Google-Smtp-Source: AJdET5eeNjCsdQOrU5ztSG1SXtsR+AhNg46gLjD8nFc2Jv04m/OWUU+U/3nHwaQNyHATevA7/cG4yw==
X-Received: by 2002:a5d:62c1:: with SMTP id o1-v6mr15004920wrv.83.1541429300298;
        Mon, 05 Nov 2018 06:48:20 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id j203-v6sm37483611wmd.46.2018.11.05.06.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 06:48:19 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <03125734-8c46-8c85-2bb5-64f787ca1f4d@linaro.org>
Date:   Mon, 5 Nov 2018 15:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2018 00:33, Vineet Gupta wrote:
> On 10/17/2018 04:30 AM, Alexey Brodkin wrote:
>> It turned out we used to use default implementation of sched_clock()
>> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
>> by default we had 10 msec granularity of time measurement.
>>
>> Now given ARC built-in timers are clocked with the same frequency as
>> CPU cores we may get much higher precision of time tracking.
>>
>> Thus we switch to generic sched_clock which really reads ARC hardware
>> counters.
>>
>> This is especially helpful for measuring short events.
>> That's what we used to have:
>> ------------------------------>8------------------------
>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>
>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>
>>          10.000000      task-clock (msec)         #    2.832 CPUs utilized
>>                  1      context-switches          #    0.100 K/sec
>>                  1      cpu-migrations            #    0.100 K/sec
>>                 63      page-faults               #    0.006 M/sec
>>            3049480      cycles                    #    0.305 GHz
>>            1091259      instructions              #    0.36  insn per cycle
>>             256828      branches                  #   25.683 M/sec
>>              27026      branch-misses             #   10.52% of all branches
>>
>>        0.003530687 seconds time elapsed
>>
>>        0.000000000 seconds user
>>        0.010000000 seconds sys
>> ------------------------------>8------------------------
>>
>> And now we'll see:
>> ------------------------------>8------------------------
>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>
>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>
>>           3.004322      task-clock (msec)         #    0.865 CPUs utilized
>>                  1      context-switches          #    0.333 K/sec
>>                  1      cpu-migrations            #    0.333 K/sec
>>                 63      page-faults               #    0.021 M/sec
>>            2986734      cycles                    #    0.994 GHz
>>            1087466      instructions              #    0.36  insn per cycle
>>             255209      branches                  #   84.947 M/sec
>>              26002      branch-misses             #   10.19% of all branches
>>
>>        0.003474829 seconds time elapsed
>>
>>        0.003519000 seconds user
>>        0.000000000 seconds sys
>> ------------------------------>8------------------------
>>
>> Note how much more meaningful is the second output - time spent for
>> execution pretty much matches number of cycles spent (we're running
>> @ 1GHz here).
>>
>> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> 
> @Daniel is this going via timer tree or you want me to pick it up.

Applied, thanks

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

