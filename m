Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD40720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0N4VJii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD40720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKZTdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:33:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42941 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:33:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so17895226wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GqOPYmLUqucGDqEjGRbu28XSAbnwPdRr0t8CVjqLQGQ=;
        b=B0N4VJiiD5tyZfJMnk5fTrNWyJwhc+kNTWCeRBC33jzKJUUsatRznpH0AQKK0W5hZk
         ok8Gl62Uzhze2V/zNlFkzdv84NW+ZsUzWwUd3I+CmuTz8WsIafr4ZO3r67pnbZ30EREl
         i74a90xi/znQWTzMCNhEluw/P6YUkc8imWJnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GqOPYmLUqucGDqEjGRbu28XSAbnwPdRr0t8CVjqLQGQ=;
        b=JubknqKVkgarDSHdlyCXeCIWFjiWdpj7rkuOMwEEV2hOh+Qr8iLlRQPNXQwilZ+mqK
         dUcZJCZ0gEcE5W/brTXjcUfu9+OYN8Y3ZomPE2Ig8ng39m+E8NSqJWkdCi0AQcCa3ARv
         EbNqQys3JTgWppj4LYELJv0+49sRAJPmv0axF3JM7ELiMYFJqLzOGuMyQKJPjFfliczU
         tXBkk9+1vnO2G9kKhL9mSq3b8yH+oR8h7QiDhj3RmlcYe4tVTgR9vFG+bJ2JR1dObocQ
         eGqivhf4qPUtBX9rE1A6fuhqjursNO+kU/1ImBrajAn9D0r6LvFuV9q0or4u4tNzNSQL
         164A==
X-Gm-Message-State: AA+aEWbhPHPW3ezjye6swvOvnchGyomjqyRDpnC4ntfy7QJURQ+xVnKK
        vLCQ0tqtWfJXOR3stZ+qKx0Iqg==
X-Google-Smtp-Source: AFSGD/XH/Q7ro55a6OsOt/LW6xgZBE6i4X0AJjR6aGPA59QiwRJ6CWSWMxDgoxi6l5nt/VvwvPKf7Q==
X-Received: by 2002:adf:9287:: with SMTP id 7-v6mr22400393wrn.3.1543221582089;
        Mon, 26 Nov 2018 00:39:42 -0800 (PST)
Received: from [192.168.0.40] (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.googlemail.com with ESMTPSA id q12sm34539333wrx.31.2018.11.26.00.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:39:41 -0800 (PST)
Subject: Re: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Brown <broonie@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123135807.GA14964@e107155-lin>
 <9cea4556-15f8-9377-305a-b629ba7e811f@linaro.org>
 <20181123162040.GB27793@e107155-lin>
 <1e013fee-e218-c489-9cd6-a384950d304f@linaro.org>
 <20181126082702.GA18469@localhost.localdomain>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <700ef337-fd77-b1c1-a505-1e6ca5580e62@linaro.org>
Date:   Mon, 26 Nov 2018 09:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126082702.GA18469@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 26/11/2018 09:27, Juri Lelli wrote:
> Hi,
> 
> On 23/11/18 17:54, Daniel Lezcano wrote:
>> On 23/11/2018 17:20, Sudeep Holla wrote:
>>> On Fri, Nov 23, 2018 at 05:04:18PM +0100, Daniel Lezcano wrote:
>>>> On 23/11/2018 14:58, Sudeep Holla wrote:
>>>>> On Mon, Oct 29, 2018 at 05:23:18PM +0100, Daniel Lezcano wrote:
>>>>>> The mutex protects a per_cpu variable access. The potential race can
>>>>>> happen only when the cpufreq governor module is loaded and at the same
>>>>>> time the cpu capacity is changed in the sysfs.
>>>>>>
>>>>>
>>>>> I wonder if we really need that sysfs entry to be writable. For some
>>>>> reason, I had assumed it's read only, obviously it's not. I prefer to
>>>>> make it RO if there's no strong reason other than debug purposes.
>>>>
>>>> Are you suggesting to remove the READ_ONCE/WRITE_ONCE patch and set the
>>>> sysfs file read-only ?
>>>>
>>>
>>> Just to be sure, if we retain RW capability we still need to fix the
>>> race you are pointing out.
>>>
>>> However I just don't see the need for RW cpu_capacity sysfs and hence
>>> asking the reason here. IIRC I had pointed this out long back(not sure
>>> internally or externally) but seemed to have missed the version that got
>>> merged. So I am just asking if we really need write capability given that
>>> it has known issues.
>>>
>>> If user-space starts writing the value to influence the scheduler, then
>>> it makes it difficult for kernel to change the way it uses the
>>> cpu_capacity in future.
>>>
>>> Sorry if there's valid usecase and I am just making noise here.
>>
>> It's ok [added Juri Lelli]
>>
>> I've been through the history:
>>
>> commit be8f185d8af4dbd450023a42a48c6faa8cbcdfe6
>> Author: Juri Lelli <juri.lelli@arm.com>
>> Date:   Thu Nov 3 05:40:18 2016 +0000
>>
>>     arm64: add sysfs cpu_capacity attribute
>>
>>     Add a sysfs cpu_capacity attribute with which it is possible to read and
>>     write (thus over-writing default values) CPUs capacity. This might be
>>     useful in situations where values needs changing after boot.
>>
>>     The new attribute shows up as:
>>
>>      /sys/devices/system/cpu/cpu*/cpu_capacity
>>
>>     Cc: Will Deacon <will.deacon@arm.com>
>>     Cc: Mark Brown <broonie@kernel.org>
>>     Cc: Sudeep Holla <sudeep.holla@arm.com>
>>     Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>>     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>
>> Juri do you have a use case where we want to override the capacity?
>>
>> Shall we switch the sysfs attribute to read-only?
> 
> So, I spent a bit of time researching patchset history and IIRC the
> point of having a RW cpu_capacity was to help in situations where one
> wants to change values after boot, because she/he now has "better"
> numbers (remember we advocate to use Dhrystone to populate DTs, but that
> is highly debatable). I also seem to remember that there might also be
> cases where DT values cannot be changed at all for a (new?) platform
> that happens to be using DTs shipped with an old revision; something
> along these lines was mentioned (by Mark?) during the review process,
> but exact details escape my mind ATM, apologies.

Ok, so I guess it makes sense to keep it RW then.

Thanks for the feedback.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

