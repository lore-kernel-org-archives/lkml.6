Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3856D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEcZ4Iks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfARMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:08:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34574 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfARMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:08:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so5995762pga.1;
        Fri, 18 Jan 2019 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Upm3BBmIrcMx9tgTplaaoFy2zP31xnGYQuE4efmwbJg=;
        b=PEcZ4IkszRekRCge7q5JF3QhlDyfhhkmJBBAs+PPoLh7Twc0bOyLl0ukM3zU40aFkA
         r0oMuHjW8ziQH4h08fx49Zfgw0kgXjwTe37Tx/9OZX7VcWbcqHhQ6Yg/FWFSfOaEBdYz
         dysTi5RLhR3K0MW3M80J/Bgr304obnfDmDAZ1BtcbBMiaHS9zHPvnrqD4FBzBKHtRzud
         mj4AVg/xg8tHBnlwuvfTPZBZBlz27/mZT+Vm/GTXshkvKR30fxgqoAMGsqeUF3Jxwisq
         3QfNlZp3KrRFIZyOL01eWLRoHHZjo3+nfg1qbp9sUqDfVkaSD7Waa7FawEBIQumWQ8T0
         opNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Upm3BBmIrcMx9tgTplaaoFy2zP31xnGYQuE4efmwbJg=;
        b=rSriTR+3ER2QMfvgNUWVATSW4tQenIQ5wmXPBD5NKoYdDuxgtZ95n+XESUd3RbtvSO
         YaFTfqe5qKo83kWx+3X4Ow2pe5NSFmxWkB2rwzinjQuZKW4uWAJgm1LPO2LZE+V9im3I
         Nd2ycfuqPxj9+IVN9Kb+tsSHMoHj6DTPPSDDfawOrOmfaj71tfJBrgvEP/uwBL0x9LCp
         NiPgHlpWDXjZVCHdg+rdCBX1x1QohZ1GoVfnnvYB16R3I7rZnVaYeuqYrAT2NJJoPV0d
         9eubSHGhzSNgU9R8wK7oiMEBByFL6tHkOIsRCmmQygYOsakOFdwHpeFmKV9KmZAQKddr
         7cLA==
X-Gm-Message-State: AJcUukc9OOASc2T2l2hYP3cUUjWEG5hRa8Jk3QL2BS13bLVve1b9ZODH
        3XFin3KJXfJgyUkowvZwFGA=
X-Google-Smtp-Source: ALg8bN5elhXdbfnoLRJxNH9st1YeS9tfgSR7lkgMtSeuXuxoTr0TmHjisCb9nqS9Ufi44kNh2ZBZFg==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr17536961pgb.242.1547813322140;
        Fri, 18 Jan 2019 04:08:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e86sm6581388pfb.6.2019.01.18.04.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 04:08:41 -0800 (PST)
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9ff86048-fca5-11b9-174c-f0a9338dd231@roeck-us.net>
Date:   Fri, 18 Jan 2019 04:08:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gFpK3Kqyf=RM+160A3RAQYPs3c3EgxmNH7ZceEaujEUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 3:05 AM, Rafael J. Wysocki wrote:
> On Fri, Jan 18, 2019 at 11:53 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Fri, 18 Jan 2019 at 11:42, Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:
>>>
>>> Hi Guenter,
>>>
>>> Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
>>>> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
>>>>> From: Thara Gopinath <thara.gopinath@linaro.org>
>>>>>
>>>>> This patch replaces jiffies based accounting for runtime_active_time
>>>>> and runtime_suspended_time with ktime base accounting. This makes the
>>>>> runtime debug counters inline with genpd and other pm subsytems which
>>>>> uses ktime based accounting.
>>>>>
>>>>> timekeeping is initialized before pm_runtime_init() so ktime_get() will
>>>>> be ready before first call. In fact, timekeeping_init() is called early
>>>>> in start_kernel() which is way before driver_init() (and that's when
>>>>> devices can start to be initialized) called from rest_init() via
>>>>> kernel_init_freeable() and do_basic_setup().
>>>>>
>>>> This is not (always) correct. My qemu "collie" boot test fails with this
>>>> patch applied. Reverting the patch fixes the problem. Bisect log attached.
>>>>
>>>
>>> Can you try the patch below ?
>>> ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
>>> it can be used at early_init.
>>
>> Another possibility would be delay the init of the gpiochip
> 
> Well, right.
> 
> Initializing devices before timekeeping doesn't feel particularly
> robust from the design perspective.
> 
> How exactly does that happen?
> 

With an added 'initialized' flag and backtrace into the timekeeping code,
with the change suggested earlier applied:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping.c:453 ktime_get_mono_fast_ns+0x114/0x12c
Timekeeping not initialized
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc2-next-20190117-dirty #2
Hardware name: Sharp-Collie
Backtrace:
[<c000dce8>] (dump_backtrace) from [<c000df78>] (show_stack+0x18/0x1c)
  r7:00000009 r6:00000000 r5:c065ba90 r4:c06d3e54
[<c000df60>] (show_stack) from [<c0588930>] (dump_stack+0x20/0x28)
[<c0588910>] (dump_stack) from [<c0018ae8>] (__warn+0xcc/0xf4)
[<c0018a1c>] (__warn) from [<c0018b5c>] (warn_slowpath_fmt+0x4c/0x6c)
  r8:df407b08 r7:00000000 r6:c0c01550 r5:c065bad8 r4:c06dd028
[<c0018b14>] (warn_slowpath_fmt) from [<c0069e2c>] (ktime_get_mono_fast_ns+0x114/0x12c)
  r3:00000000 r2:c065bad8
  r5:00000000 r4:df407b08
[<c0069d18>] (ktime_get_mono_fast_ns) from [<c03c7810>] (pm_runtime_init+0x38/0xb8)
  r9:c06c9a5c r8:df407b08 r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
[<c03c77d8>] (pm_runtime_init) from [<c03b6a34>] (device_initialize+0xb0/0xec)
  r7:00000000 r6:c0c01550 r5:00000000 r4:df407b08
[<c03b6984>] (device_initialize) from [<c0366d30>] (gpiochip_add_data_with_key+0x9c/0x884)
  r7:00000000 r6:c06fca34 r5:00000000 r4:00000000
[<c0366c94>] (gpiochip_add_data_with_key) from [<c06b9708>] (sa1100_init_gpio+0x40/0x98)
  r10:dfffcd60 r9:c06c9a5c r8:c06dd020 r7:c06dd028 r6:ffffffff r5:00000000
  r4:c06fca34
[<c06b96c8>] (sa1100_init_gpio) from [<c06ae58c>] (sa1100_init_irq+0x2c/0x3c)
  r7:c06dd028 r6:ffffffff r5:c0713300 r4:c06e1070
[<c06ae560>] (sa1100_init_irq) from [<c06aab1c>] (init_IRQ+0x20/0x28)
  r5:c0713300 r4:00000000
[<c06aaafc>] (init_IRQ) from [<c06a7cd0>] (start_kernel+0x254/0x4cc)
[<c06a7a7c>] (start_kernel) from [<00000000>] (  (null))
  r10:0000717f r9:6901b119 r8:c0000100 r7:00000092 r6:0000313d r5:00000053
  r4:c06a7330
---[ end trace 91e1bd00dd7cce32 ]---

Guenter
