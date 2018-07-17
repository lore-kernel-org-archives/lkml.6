Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7D62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIHiwRhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7D62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeGQIji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:39:38 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42038 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:39:37 -0400
Received: by mail-wr1-f45.google.com with SMTP id e7-v6so257689wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=anNiYA8ZIhzygpsQz9FvUrH7M/ZAfuF/meDkp9aRst0=;
        b=EIHiwRhwQDfkHTeq3bMf2cI6LiWxRvWujlH2bcrf2YU1nVBRPlY1y69O3tshPZlyLV
         xjkWNsV1lF5gl6Jp/qox1JkMtY7a8ed5M9kYmxvLOV5noLxiUgyquAvHXh5Y5n7plWah
         F+6VN3389Q05EmwJEdK4+6VZ35WaTajLoiJFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anNiYA8ZIhzygpsQz9FvUrH7M/ZAfuF/meDkp9aRst0=;
        b=Y9flSLiZYdoTlkWrUcV0vkiWVfBQ/i5K5L/nFfwOpsDjPKn7R00kkXVbO6IU3gFU39
         CsrQzBbEdVUvLiyYmEnTDnjL/mqBhGjEvxpUu68gC5x04ZIC5o17fVsQWY+ZD6n/ZkVy
         b5lLj1LrW+3ts/HywoYhy5LQbIYFXnvXrxcydvjovmfeWSmjMP0mfzIvO5l6epFvr3Gl
         qZ3gFQYTZ68GkUd7hdViwA2p4JAylrGgRfb7vww9gqyFg/nzSBeEORnshSwBFThFFWCp
         rhusripGCz4xeDrsfdrb6gXOeSOIlStZ376PtTdhZevlqob/iHkPcAkMz4I8qfoik57T
         ANLQ==
X-Gm-Message-State: AOUpUlEKTM/1uA2+QU8iaJENnaZVRczP8mU31PHPVoanxwPN77RVtVHP
        b1kAUmDbhSqaj2ka7sCBooPwbAdVV0Y=
X-Google-Smtp-Source: AAOMgpfzO/QivjLCSKqI7MsNd8zZcq2+wj2KZ+wCRUEqWBJdJ2n2D/pQct8bhQNtahAUsawiBEZ8VA==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr546630wri.36.1531814894114;
        Tue, 17 Jul 2018 01:08:14 -0700 (PDT)
Received: from [192.168.8.101] ([37.168.37.237])
        by smtp.googlemail.com with ESMTPSA id i1-v6sm677275wrq.69.2018.07.17.01.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 01:08:13 -0700 (PDT)
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49b95a4b-0eef-1068-6cbd-5fc19a7d4252@linaro.org>
Date:   Tue, 17 Jul 2018 10:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 09:33, Rafael J. Wysocki wrote:
> Hi,
> 
> Thanks for your report!
> 
> On Tue, Jul 17, 2018 at 8:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> Hello,
>>
>> I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
>> idle state before stopping the tick") causes severe performance drop
>> for systems using pcc-cpufreq driver. Depending on the number of CPUs
>> the system might be almost unusable. The OS jitter for 4.17.y and
>> 4.18.-rcx kernels is off the charts, you can even spot it with top
>> command (issued when the system is supposedly idle), e.g.
>>
>>  top - 14:44:24 up 2 min,  1 user,  load average: 90.11, 38.20, 14.38
>>  Tasks: 1199 total, 109 running, 541 sleeping,   0 stopped,   0 zombie
>>  %Cpu(s):  1.2 us, 58.7 sy,  0.0 ni, 39.3 id,  0.6 wa,  0.0 hi,  0.3 si,  0.0 st
>>  KiB Mem:  13137064+total,  1192168 used, 13017848+free,     2340 buffers
>>  KiB Swap:  2104316 total,        0 used,  2104316 free.   522296 cached Mem
>>
>>    PID USER      PR  NI    VIRT    RES    SHR S    %CPU  %MEM     TIME+ COMMAND
>>   3373 root      20   0  982024  49916  36120 R  96.691 0.038   0:19.54 kubelet
>>     67 root      20   0       0      0      0 R  78.676 0.000   0:49.36 kworker/9:0
>>     25 root      20   0       0      0      0 R  78.125 0.000   0:49.67 kworker/2:0
>>    182 root      20   0       0      0      0 R  75.735 0.000   1:18.17 kworker/28:0
>>     43 root      20   0       0      0      0 R  75.000 0.000   0:11.56 kworker/5:0
>>    103 root      20   0       0      0      0 R  74.449 0.000   0:46.83 kworker/15:0
>>    334 root      20   0       0      0      0 R  72.978 0.000   1:06.88 kworker/53:0
>>    789 root      20   0       0      0      0 R  69.853 0.000   1:29.50 kworker/38:1
>>    418 root      20   0       0      0      0 R  69.301 0.000   0:41.33 kworker/67:0
>>    779 root      20   0       0      0      0 R  68.934 0.000   1:33.60 kworker/27:1
>>    773 root      20   0       0      0      0 R  68.566 0.000   1:37.91 kworker/22:1
>>    762 root      20   0       0      0      0 R  68.015 0.000   1:41.01 kworker/11:1
>>    769 root      20   0       0      0      0 R  67.647 0.000   1:37.65 kworker/18:1
>>    805 root      20   0       0      0      0 R  67.096 0.000   1:30.96 kworker/54:1
>>    840 root      20   0       0      0      0 R  66.912 0.000   1:23.82 kworker/89:1
>>    812 root      20   0       0      0      0 R  66.728 0.000   1:31.89 kworker/59:1
>>    847 root      20   0       0      0      0 R  66.360 0.000   1:28.40 kworker/96:1
>>    763 root      20   0       0      0      0 R  66.176 0.000   1:42.57 kworker/12:1
>>    772 root      20   0       0      0      0 R  66.176 0.000   1:12.58 kworker/21:1
>>    821 root      20   0       0      0      0 R  66.176 0.000   1:29.62 kworker/69:1
>>    923 root      20   0       0      0      0 R  65.809 0.000   1:44.32 kworker/3:18
>>   1284 root      20   0       0      0      0 R  65.809 0.000   1:23.50 kworker/101:2
>>     61 root      20   0       0      0      0 R  65.625 0.000   1:29.37 kworker/8:0
>>   3531 root      20   0   24384   3768   2356 R  65.625 0.003   0:08.91 top
>>    771 root      20   0       0      0      0 R  65.074 0.000   1:37.90 kworker/20:1
>>    767 root      20   0       0      0      0 R  64.706 0.000   1:38.01 kworker/16:1
>>    764 root      20   0       0      0      0 R  64.522 0.000   1:40.28 kworker/13:1
>>    765 root      20   0       0      0      0 R  64.154 0.000   1:40.13 kworker/14:1
>>
>> When I apply below patch (trying to revert essential parts of commit
>> 554c8aa8ecad) behaviour seems back to normal.
> 
> Well, that basically defeats the purpose of the change in commit
> 554c8aa8ecad, so it's not what I'd like to do to fix this problem.
> 
> Also it would be good to understand what actually happens.
> 
>> I know that pcc-cpufreq driver is not "state-of-the-art" when it comes
>> to cpufreq drivers and you better not use it.
> 
> That's exactly right.
> 
>> But I wonder whether commit 554c8aa8ecad ("sched: idle: Select idle state before
>> stopping the tick") introduced bad behaviour for other cases as well.
> 
> It has been tested quite extensively in that respect, although
> admittedly not with the pcc-cpufreq driver.
> 
> Nothing bad related to it has been has been reported so far, FWIW.

I confirm we benchmarked on ARM64 and we did not notice a big
performance drop expect a few percent due to more cluster idle states
which is logical and compensated by a big energy improvement.

>> I'll send some performance results to illustrate the issue asap. I've
>> also tried to modify pcc-cpufreq to reduce the amount of frequency
>> changes triggered by this driver but this does not help for kernels
>> where commit 554c8aa8ecad is applied.
> 
> Can you replace pcc-cpufreq with a different cpufreq driver on the
> affected systems?  If so, do performance numbers look bad after that
> too?
> 
> Thanks,
> Rafael
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

