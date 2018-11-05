Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A84C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E70A20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXvh9pZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbeKEX7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:59:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37642 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeKEX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:59:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so6154806wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OdZ9fs+d7tEqzFDZ0TAbybm6/57Ydw72pGt9RB1AQ6U=;
        b=dXvh9pZ2VvY+aCjmWmPW+SkGfbaIvogl6toHw416oGH9h1zhOgUAJtVmFUJG3G+2Z5
         JiJokbBmrSgGdWfVM8C6INp7f5dhgFAfwWcwbpFBRLflWGhUEiy4ztdEu7Tq/uAG6lLn
         8wI9OESF8mOrMKn9BpbdWan+t9kvhErJm6qb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdZ9fs+d7tEqzFDZ0TAbybm6/57Ydw72pGt9RB1AQ6U=;
        b=cVQd5NQBh1my/k32UxtEyhZS2rLD5Br35O9JfWUaFM2Re0eh6cXYWcKNfz8CvOVeJE
         DL2UUcHLYKsiH4PDUMKk6/k2QROiO3ei6yDgQYSY8pMxO+EdFRtwWydqYnOgkzdZgqzB
         BK/lSixQzSiDurOAHH6TtrbV3TA9GTQBd+Z+X9YMKzP0J/QcGaLI8AXXddZu8vriTtNh
         Xc+4MPkiWkkMBJRFjZhYmjzF3jY5ZWgEndbq8EKAhd2F0GwBLazqpCgxrSfINzU6w5tn
         ZB4yAqLIdOika+KdJfmZ+i80pax7ovzWj2COgTkXmFENM6x3ZiTZzwNVhGVUZdoPFKvi
         m9kQ==
X-Gm-Message-State: AGRZ1gJj7TFnxtwmV0CW/juaMAn+rodyB1pAtEZH672532/nprBIkYfL
        loXTOh9rCHpSvQXrSwOYFhdhpg==
X-Google-Smtp-Source: AJdET5cwj8TPWArvTRIAzLJkHbZPB+Q4ZO/UYmp8yrTppF3yjppTvXfB6AzckeCSSRymIwg+mqYmrw==
X-Received: by 2002:adf:dbc3:: with SMTP id e3-v6mr20857938wrj.165.1541428787080;
        Mon, 05 Nov 2018 06:39:47 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id a7sm7229230wrx.26.2018.11.05.06.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 06:39:46 -0800 (PST)
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
Message-ID: <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
Date:   Mon, 5 Nov 2018 15:39:44 +0100
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

I will take care of it.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

