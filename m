Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BF620672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0NWXWfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BF620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633074AbeKXDj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:39:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41221 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbeKXDj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:39:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so12966589wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rA3rJeHl4bVAMRFBo2W5dMaaPO3u8C6pWLlXoXAvryQ=;
        b=J0NWXWfIaSKgtPQw5mgEDgAsvUWQPfaIRyy90aaADQFBmW5fmiqNh5R0ZUhqZLUO9e
         NykPBfJTUvZanlLqseE+Hu+dRuzOsMMQK22b8nNvivqAq5uPSSXb8llD2y4NQUrtoCS4
         53bbNYb40P4Fpx5eMjYBriTcq+YNZvcrviwvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rA3rJeHl4bVAMRFBo2W5dMaaPO3u8C6pWLlXoXAvryQ=;
        b=H8xWErUwFpVPC+5StuGTD2CJ5V46hVRl3cgjLZQPd658Xvvi5ZYw0NpaigRU+t5bzV
         Va84h2wKhCGAcWRH0ncY4bndDSaxl0K84qlobCET8pE6A817+P+CQxXdjmzMwUC4GRt/
         dmeID+ArfzTGoXphfHbWfVNOod6QdcOfEr/iFl5MqwYoH9PeHojVId6tbf+gj56CF4d7
         8qCk2QmsquzVSItreqJDuzXYDP1pvnQ1CagfMtBJCrOVdBHRXDsmZM7YxIRoYCaLWXBL
         2S3AWhGQUz/LAqANb5oVenyQziMRrwf0X6L8WDsRThpAPkGGbIY7U1OYFcVM6HxQ6OhQ
         Hlfg==
X-Gm-Message-State: AA+aEWaDk3YGPUUU3zdvMpeLSCv7LmRLpkR4M9AviNVPAOg9zBE0MGj/
        58sbkiCPBqcMQZMmIx7hCbUjXDVyIcg=
X-Google-Smtp-Source: AFSGD/Wuk2S4wLjew2N/0O+rjPyLDK4apwbjFMXKvn1862VONLY7Sd2p0cIAwZ1PIdWxxxpklp9uWQ==
X-Received: by 2002:a5d:4e4a:: with SMTP id r10mr5179249wrt.54.1542992064628;
        Fri, 23 Nov 2018 08:54:24 -0800 (PST)
Received: from [192.168.0.40] (33.181.88.92.rev.sfr.net. [92.88.181.33])
        by smtp.googlemail.com with ESMTPSA id 82-v6sm6367610wms.17.2018.11.23.08.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 08:54:24 -0800 (PST)
Subject: Re: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123135807.GA14964@e107155-lin>
 <9cea4556-15f8-9377-305a-b629ba7e811f@linaro.org>
 <20181123162040.GB27793@e107155-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1e013fee-e218-c489-9cd6-a384950d304f@linaro.org>
Date:   Fri, 23 Nov 2018 17:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123162040.GB27793@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2018 17:20, Sudeep Holla wrote:
> On Fri, Nov 23, 2018 at 05:04:18PM +0100, Daniel Lezcano wrote:
>> On 23/11/2018 14:58, Sudeep Holla wrote:
>>> On Mon, Oct 29, 2018 at 05:23:18PM +0100, Daniel Lezcano wrote:
>>>> The mutex protects a per_cpu variable access. The potential race can
>>>> happen only when the cpufreq governor module is loaded and at the same
>>>> time the cpu capacity is changed in the sysfs.
>>>>
>>>
>>> I wonder if we really need that sysfs entry to be writable. For some
>>> reason, I had assumed it's read only, obviously it's not. I prefer to
>>> make it RO if there's no strong reason other than debug purposes.
>>
>> Are you suggesting to remove the READ_ONCE/WRITE_ONCE patch and set the
>> sysfs file read-only ?
>>
> 
> Just to be sure, if we retain RW capability we still need to fix the
> race you are pointing out.
> 
> However I just don't see the need for RW cpu_capacity sysfs and hence
> asking the reason here. IIRC I had pointed this out long back(not sure
> internally or externally) but seemed to have missed the version that got
> merged. So I am just asking if we really need write capability given that
> it has known issues.
> 
> If user-space starts writing the value to influence the scheduler, then
> it makes it difficult for kernel to change the way it uses the
> cpu_capacity in future.
> 
> Sorry if there's valid usecase and I am just making noise here.

It's ok [added Juri Lelli]

I've been through the history:

commit be8f185d8af4dbd450023a42a48c6faa8cbcdfe6
Author: Juri Lelli <juri.lelli@arm.com>
Date:   Thu Nov 3 05:40:18 2016 +0000

    arm64: add sysfs cpu_capacity attribute

    Add a sysfs cpu_capacity attribute with which it is possible to read and
    write (thus over-writing default values) CPUs capacity. This might be
    useful in situations where values needs changing after boot.

    The new attribute shows up as:

     /sys/devices/system/cpu/cpu*/cpu_capacity

    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Mark Brown <broonie@kernel.org>
    Cc: Sudeep Holla <sudeep.holla@arm.com>
    Signed-off-by: Juri Lelli <juri.lelli@arm.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Juri do you have a use case where we want to override the capacity?

Shall we switch the sysfs attribute to read-only?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

