Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E182089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="en0JJ2gU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E182089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJBOlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:41:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJBOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:41:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so1173395wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wPEy56sqK2min1cnCLontj65qM8RHriTQGXbyNBn+WE=;
        b=en0JJ2gULIp8pE9XAN0wW34ZsL6tLAiTicz4zILXfQ0DnKvQBrPJiU/rkYf9nD5xKO
         NMKdQL7RB6skrSXVgtkIyNR0EH6IYWd09t3hA+3ZbQjOk0d/b25dQWMGooCfu9vuVMPE
         hh4RjkHV5Xy+8W6wD+a3SPLPKfRxfMegQVBfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wPEy56sqK2min1cnCLontj65qM8RHriTQGXbyNBn+WE=;
        b=bTwIO+8GI+MKRvv+JPBNLSJ2/mM8DdKDCnDhhAWuotqu0eyg7fPbdufpottflzis1e
         dq489vB8Oxb8pEF2fLu1XNIoNzPQqN97SwEiZYDdVMsetUyqytNMkVyy0aKo/0mRkEmw
         hZuP/gsQC76M/jzF7AtGCHZNoV1OODWs7rjqaE9stkWrnt6rP1LVNzRJdc90QRHC7m0x
         QpLimFW5tadfzCaALpLK/jXT7q1ObTzU4e4cyQfRKh0Y1k5W/8iP7+qv9YXF8YDzoOh+
         KMfUCLcnaoTV/MoHlDYscoM2KsGfkiPn9R6qUJc+BSZRV7UaV1g9d8LVRZ0sS6QN3CXM
         NWbA==
X-Gm-Message-State: ABuFfojFTfi37Sz7ttZdV3tyEeFP1ZxK0FeObT6RBAcbZHq9M3ckyErE
        Ugb1icen4bMxAUE4pWi78ieG2Q==
X-Google-Smtp-Source: ACcGV618Qfex8XDeGtEDFZBFMUVmIkoHA5pbhRhqT/ibD1cfnnNkc7mrhn19gtJoCrZ8bCAMsi4F2g==
X-Received: by 2002:a1c:5d54:: with SMTP id r81-v6mr944683wmb.88.1538467184640;
        Tue, 02 Oct 2018 00:59:44 -0700 (PDT)
Received: from [192.168.0.41] (114.141.88.92.rev.sfr.net. [92.88.141.114])
        by smtp.googlemail.com with ESMTPSA id 74-v6sm10000385wmi.23.2018.10.02.00.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:59:43 -0700 (PDT)
Subject: Re: [PATCH V9 3/8] clocksource: add C-SKY SMP timer
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1538355281.git.ren_guo@c-sky.com>
 <eee964dd57d12bc630280ab84235b5356799b1fb.1538355281.git.ren_guo@c-sky.com>
 <88e320f2-8cf0-fdb9-c9b0-ee25d7a4d00f@linaro.org>
 <20181002054024.GA12645@guoren>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49238cda-d12c-7d3f-9333-296527d94f12@linaro.org>
Date:   Tue, 2 Oct 2018 09:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002054024.GA12645@guoren>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 07:40, Guo Ren wrote:
[ ... ]

>>
>> 	irq = irq_of_parse_and_map(np, 0);
>> 	if (irq <= 0)
>> 		return -EINVAL;
> 		panic();
> I want a panic here. Return will make debug confused and directly tell
> the people where is wrong. It's root-timer for us and it must bootup.
> 
> If it's a co-timer, I also think return is good.

We don't need a panic in case of failure. If the board as an alternate
timer it should be able to boot, that is the general rule of thumb for
these drivers in this directory.

The init timer functions will be called via the timer_probe() which
browse the timer_of_table (the one with all entries for the
TIMER_OF_DECLARE macros).

You can see in the code below (from timer_probe.c), there is an error
message emitted if the driver fails to initialize and another one much
stronger if no timer was initialize.

This is enough trace IMO.

void __init timer_probe(void)
{
        struct device_node *np;
        const struct of_device_id *match;
        of_init_fn_1_ret init_func_ret;
        unsigned timers = 0;
        int ret;

        for_each_matching_node_and_match(np, __timer_of_table, &match) {
                if (!of_device_is_available(np))
                        continue;

                init_func_ret = match->data;

                ret = init_func_ret(np);
                if (ret) {
                        pr_err("Failed to initialize '%pOF': %d\n", np,
ret);
                        continue;
                }

                timers++;
        }

        timers += acpi_probe_device_table(timer);

        if (!timers)
                pr_crit("%s: no matching timers found\n", __func__);
}




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

