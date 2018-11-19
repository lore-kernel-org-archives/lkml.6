Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3429720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnqUEgfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3429720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeKTIPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:15:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbeKTIPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:15:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so210960wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SWZ3DB2PvtlbCeyNZMAidAookiM7916S5ZmyltaW/bY=;
        b=JnqUEgfVO/uF687Ns5FWRfi35HK/k5q8oZhum/aDowjlk3LGOOOu05ThtxV4xM7Pwe
         GIT7NNlYrWNqvj3g7CESOBDiEarGqFtXnRnVQ5+Vc61VO5g2jCQiM/UPZX9NHalUUEkB
         qHyiIY+yKtA8Z7+JxX0ZwZbSHASfXP/cdvhiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SWZ3DB2PvtlbCeyNZMAidAookiM7916S5ZmyltaW/bY=;
        b=YirFbBkH9npn/tZO4Hk5aV151ZgL6KYBQL/5NLg1WhCrdPYzlVukM7ao4ci5GaQr7I
         +M/fqAIoSX9PXx9BdrmvotehcvzGTnHRmx0FqM9SfSjifgCgpWLoN6DeNCnN2a87WgjS
         GQJ6TfhrwtmzUAZ7uFn0kKFBSGuxDP+eYbv8CZQcEubh3lssItaUWfMcJyf6sEVRjjgT
         kZ5qH5Zsfx1WJ9uujFhnmSNn/eumtIq1v1+fFl1C6iKOmZrpdLJwWsJQ/kayKQMHfad/
         x9ACQrehy5OTfoKmz4zbIe1e6oje4TC3CEuEGfvuXupZGxjJggbCHgkfb41tunZowvVP
         lpEA==
X-Gm-Message-State: AA+aEWYArqCok1EoilIXJwakDFIHExpio/lZaCuraRJ4Jq0wcH/N92mj
        YVrMh/Cd7zo9ZkrQZA4F8wdxIw==
X-Google-Smtp-Source: AJdET5d/stNxXYtE3rrQS7hm0vREOtHU7ItnfgGqnDRKO48U38vPx7V+xydYZYMJzzlSwtUBnY5WaA==
X-Received: by 2002:a1c:8d46:: with SMTP id p67mr3586365wmd.28.1542664208338;
        Mon, 19 Nov 2018 13:50:08 -0800 (PST)
Received: from [192.168.0.40] (98.242.136.77.rev.sfr.net. [77.136.242.98])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm77705771wmd.20.2018.11.19.13.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:50:07 -0800 (PST)
Subject: Re: [PATCH v3] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181119112917.4214-1-abrodkin@synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <360a492f-58b0-daa4-a450-3cdbfffbeabe@linaro.org>
Date:   Mon, 19 Nov 2018 22:50:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119112917.4214-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 12:29, Alexey Brodkin wrote:
> It turned out we used to use default implementation of sched_clock()
> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
> by default we had 10 msec granularity of time measurement.
> 
> Now given ARC built-in timers are clocked with the same frequency as
> CPU cores we may get much higher precision of time tracking.
> 
> Thus we switch to generic sched_clock which really reads ARC hardware
> counters.
> 
> This is especially helpful for measuring short events.
> That's what we used to have:
> ------------------------------>8------------------------
> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
> 
>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
> 
>          10.000000      task-clock (msec)         #    2.832 CPUs utilized
>                  1      context-switches          #    0.100 K/sec
>                  1      cpu-migrations            #    0.100 K/sec
>                 63      page-faults               #    0.006 M/sec
>            3049480      cycles                    #    0.305 GHz
>            1091259      instructions              #    0.36  insn per cycle
>             256828      branches                  #   25.683 M/sec
>              27026      branch-misses             #   10.52% of all branches
> 
>        0.003530687 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.010000000 seconds sys
> ------------------------------>8------------------------
> 
> And now we'll see:
> ------------------------------>8------------------------
> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
> 
>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
> 
>           3.004322      task-clock (msec)         #    0.865 CPUs utilized
>                  1      context-switches          #    0.333 K/sec
>                  1      cpu-migrations            #    0.333 K/sec
>                 63      page-faults               #    0.021 M/sec
>            2986734      cycles                    #    0.994 GHz
>            1087466      instructions              #    0.36  insn per cycle
>             255209      branches                  #   84.947 M/sec
>              26002      branch-misses             #   10.19% of all branches
> 
>        0.003474829 seconds time elapsed
> 
>        0.003519000 seconds user
>        0.000000000 seconds sys
> ------------------------------>8------------------------
> 
> Note how much more meaningful is the second output - time spent for
> execution pretty much matches number of cycles spent (we're runnign
> @ 1GHz here).
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied, thanks.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

