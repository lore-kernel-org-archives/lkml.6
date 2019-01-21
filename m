Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BEC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2D72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRNqorLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfAUPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:24:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36601 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbfAUPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:24:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so9634236pgm.3;
        Mon, 21 Jan 2019 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qp5GRiWwPKFQQ/3Q+7sQMUs2pQOup/yclfPb9ILiog=;
        b=uRNqorLOYjcJpAUxWm6vZ4CZhGVWUoa8aZ2TsQ/8950BwQRFClet29k2yFk1/EzowC
         OIUAWtcKBr+uPVN8xGCEupMpi/NQ4SoZtFnr4rrZaefFs+Flz1FYJnFUR1MbntwDKqWF
         4PNRYFi3mmk21yBdOBPYmO86B4LarP5lTWnUxA6VPHyqaLaaPuywxwdlSuqvR4bwTJFX
         1HOzQlN/EtochKQyZYhufpAmdMiw4NWXkWIHndi/5LElCnWXRoakD9ozlj9e79iSS5Rj
         ls6h2m0DHaccrcMev1cKD2Fb5Bxa+LSl9J1LBu4l2QTs1dfWNp+sifVqAGPQc7gmvaa2
         j4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qp5GRiWwPKFQQ/3Q+7sQMUs2pQOup/yclfPb9ILiog=;
        b=bE7IX+cRNrAZrpU2cCzBgfm3ElSehi7kBKbuR0oGF/ps6wteOVdNCIsDh3UpDnqV5u
         d3emDl4HBgpk9qXUTv+0IAqAPEY+nfVM7pALauq2IZZ+jrRia2vnL2EtoZWWfa20huVX
         UunINIzAKb4qHnWx//I+6HFYKFHI1BsBeCuwYUZxgazCEGUU1jFv1Nk2d4Qo5q93Sddg
         R8MVVP+o57Gz8g1xAqw2mdZkf1djIntlgyiZ7hJ8NGqoRX+vjQ5lwr0wJRBSPheN6Gql
         erKtY6JCGaeqLYn2AFdtnOfQV8V9/dMRxIldaD/kd2S0SbVqNBOJw8x7ooAQTzBa1erL
         3ulA==
X-Gm-Message-State: AJcUukd1Wmy0mo4XxvSHY/9Od7BXKNBd8aZdiKi6RcZjkTOHkLJ5LQ+/
        1xx0kEZlX/6bkMDsiz/8VHo=
X-Google-Smtp-Source: ALg8bN6c0SHmU65fT6x64btL/0nvx0Ji2EV5g2WffwB3JeGrBwTi8iOkveEk1IrqIbJrZlLHT2HP0w==
X-Received: by 2002:a63:e302:: with SMTP id f2mr28823607pgh.320.1548084263546;
        Mon, 21 Jan 2019 07:24:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3sm26553192pfi.102.2019.01.21.07.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 07:24:22 -0800 (PST)
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Intel graphics driver community testing & development 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
 <CAKfTPtD9fu06sw8=MvjwfQfJoQHb0kT3un9=kdw+WZj+rbVUZg@mail.gmail.com>
 <CAJZ5v0gFpK3Kqyf=RM+160A3RAQYPs3c3EgxmNH7ZceEaujEUw@mail.gmail.com>
 <9ff86048-fca5-11b9-174c-f0a9338dd231@roeck-us.net>
 <CAKfTPtA_xfTt9KUAR+P=XAhXXyTdQn5ASm8GRcgnYxFFZT5ADg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <43334acb-230c-c3e3-6b67-0813467c891f@roeck-us.net>
Date:   Mon, 21 Jan 2019 07:24:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA_xfTt9KUAR+P=XAhXXyTdQn5ASm8GRcgnYxFFZT5ADg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 7:17 AM, Vincent Guittot wrote:
> On Fri, 18 Jan 2019 at 13:08, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/18/19 3:05 AM, Rafael J. Wysocki wrote:
>>> On Fri, Jan 18, 2019 at 11:53 AM Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>>
>>>> On Fri, 18 Jan 2019 at 11:42, Vincent Guittot
>>>> <vincent.guittot@linaro.org> wrote:
>>>>>
>>>>> Hi Guenter,
>>>>>
>>>>> Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
>>>>>> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
>>>>>>> From: Thara Gopinath <thara.gopinath@linaro.org>
>>>>>>>
>>>>>>> This patch replaces jiffies based accounting for runtime_active_time
>>>>>>> and runtime_suspended_time with ktime base accounting. This makes the
>>>>>>> runtime debug counters inline with genpd and other pm subsytems which
>>>>>>> uses ktime based accounting.
>>>>>>>
>>>>>>> timekeeping is initialized before pm_runtime_init() so ktime_get() will
>>>>>>> be ready before first call. In fact, timekeeping_init() is called early
>>>>>>> in start_kernel() which is way before driver_init() (and that's when
>>>>>>> devices can start to be initialized) called from rest_init() via
>>>>>>> kernel_init_freeable() and do_basic_setup().
>>>>>>>
>>>>>> This is not (always) correct. My qemu "collie" boot test fails with this
>>>>>> patch applied. Reverting the patch fixes the problem. Bisect log attached.
>>>>>>
>>>>>
>>>>> Can you try the patch below ?
>>>>> ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
>>>>> it can be used at early_init.
>>>>
>>>> Another possibility would be delay the init of the gpiochip
>>>
>>> Well, right.
>>>
>>> Initializing devices before timekeeping doesn't feel particularly
>>> robust from the design perspective.
>>>
>>> How exactly does that happen?
>>>
>>
>> With an added 'initialized' flag and backtrace into the timekeeping code,
>> with the change suggested earlier applied:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping.c:453 ktime_get_mono_fast_ns+0x114/0x12c
>> Timekeeping not initialized
>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc2-next-20190117-dirty #2
>> Hardware name: Sharp-Collie
>> Backtrace:
>> [<c000dce8>] (dump_backtrace) from [<c000df78>] (show_stack+0x18/0x1c)
>>    r7:00000009 r6:00000000 r5:c065ba90 r4:c06d3e54
>> [<c000df60>] (show_stack) from [<c0588930>] (dump_stack+0x20/0x28)
>> [<c0588910>] (dump_stack) from [<c0018ae8>] (__warn+0xcc/0xf4)
>> [<c0018a1c>] (__warn) from [<c0018b5c>] (warn_slowpath_fmt+0x4c/0x6c)
>>    r8:df407b08 r7:00000000 r6:c0c01550 r5:c065bad8 r4:c06dd028
>> [<c0018b14>] (warn_slowpath_fmt) from [<c0069e2c>] (ktime_get_mono_fast_ns+0x114/0x12c)
>>    r3:00000000 r2:c065bad8
>>    r5:00000000 r4:df407b08
>> [<c0069d18>] (ktime_get_mono_fast_ns) from [<c03c7810>] (pm_runtime_init+0x38/0xb8)
>>    r9:c06c9a5c r8:df407b08 r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
>> [<c03c77d8>] (pm_runtime_init) from [<c03b6a34>] (device_initialize+0xb0/0xec)
>>    r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
>> [<c03b6984>] (device_initialize) from [<c0366d30>] (gpiochip_add_data_with_key+0x9c/0x884)
>>    r7:00000000 r6:c06fca34 r5:00000000 r4:00000000
>> [<c0366c94>] (gpiochip_add_data_with_key) from [<c06b9708>] (sa1100_init_gpio+0x40/0x98)
>>    r10:dfffcd60 r9:c06c9a5c r8:c06dd020 r7:c06dd028 r6:ffffffff r5:00000000
>>    r4:c06fca34
>> [<c06b96c8>] (sa1100_init_gpio) from [<c06ae58c>] (sa1100_init_irq+0x2c/0x3c)
>>    r7:c06dd028 r6:ffffffff r5:c0713300 r4:c06e1070
>> [<c06ae560>] (sa1100_init_irq) from [<c06aab1c>] (init_IRQ+0x20/0x28)
>>    r5:c0713300 r4:00000000
>> [<c06aaafc>] (init_IRQ) from [<c06a7cd0>] (start_kernel+0x254/0x4cc)
>> [<c06a7a7c>] (start_kernel) from [<00000000>] (  (null))
>>    r10:0000717f r9:6901b119 r8:c0000100 r7:00000092 r6:0000313d r5:00000053
>>    r4:c06a7330
>> ---[ end trace 91e1bd00dd7cce32 ]---
> 
> Does it means that only the pm_runtime_init is done before
> timekeeping_init() but no update_pm_runtime_accounting() ?
> In this case, we can keep using ktimeçget in
> update_pm_runtime_accounting() and find a solution to deal with
> early_call of pm_runtime_init()
> 

For this platform that is correct. I can't answer for the generic case.

Guenter

