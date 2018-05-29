Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965327AbeE2Pv7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:51:59 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44619 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935733AbeE2Put (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:50:49 -0400
X-Google-Smtp-Source: ADUXVKJOh6LbIhCZzPTVo0gZFZalx9Nf0OsnoxHNqjpZ8Ea5OsVh4DZdEJW4Wcp8ZxvOZYYzvGBPAik8YuuGK9quQh0=
MIME-Version: 1.0
In-Reply-To: <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com> <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 May 2018 17:50:47 +0200
X-Google-Sender-Auth: 0FaKKiVFxoblbvnvmxQgWaeNVUs
Message-ID: <CAMuHMdWgsRTqrgwi5Z_xyNXmzS1h4gxLaawdFAL_DGF+Yt8s-A@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <Will.Deacon@arm.com>, linux-riscv@lists.infradead.org,
        Morten.Rasmussen@arm.com, vkilari@codeaurora.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, jhugo@codeaurora.org,
        Al Stone <ahs3@redhat.com>, Len Brown <lenb@kernel.org>,
        John Garry <john.garry@huawei.com>, wangxiongfeng2@huawei.com,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, May 29, 2018 at 3:18 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>> On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>>>> On Thu, May 17, 2018 at 7:05 PM, Catalin Marinas
>>>> <catalin.marinas@arm.com> wrote:
>>>>> On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
>>>>>> Jeremy Linton (12):
>>>>>>   arm64: topology: divorce MC scheduling domain from core_siblings
>>>>>
>>>>> Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
>>>>> patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
>>>>> can add it separately).
>>>>
>>>> This is now commit 37c3ec2d810f87ea ("arm64: topology: divorce MC
>>>> scheduling domain from core_siblings") in arm64/for-next/core, causing
>>>> system suspend on big.LITTLE systems to hang after shutting down the first
>>>> CPU:
>>>>
>>>>     $ echo mem > /sys/power/state
>>>>     PM: suspend entry (deep)
>>>>     PM: Syncing filesystems ... done.
>>>>     Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>>     OOM killer disabled.
>>>>     Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>>>     Disabling non-boot CPUs ...
>>>>     CPU1: shutdown
>>>>     psci: CPU1 killed.
>>>
>>> Is it OK to assume the suspend failed just after shutting down one CPU
>>> or it's failing during resume ? It depends on whether you had console
>>> disabled or not.
>>
>> I have no-console-suspend enabled.
>> It's failing during suspend, the next lines should be:
>>
>>     CPU2: shutdown
>>     psci: CPU2 killed.
>>     ...
>
> OK, I was hoping to be something during resume as this patch has nothing
> executed during suspend. Do you see any change in topology before and
> after this patch applied. I am interested in the output of:
>
> $ grep "" /sys/devices/system/cpu/cpu*/topology/*

/sys/devices/system/cpu/cpu0/topology/core_id:0
/sys/devices/system/cpu/cpu0/topology/core_siblings:0f
/sys/devices/system/cpu/cpu0/topology/core_siblings_list:0-3
/sys/devices/system/cpu/cpu0/topology/physical_package_id:0
/sys/devices/system/cpu/cpu0/topology/thread_siblings:01
/sys/devices/system/cpu/cpu0/topology/thread_siblings_list:0
/sys/devices/system/cpu/cpu1/topology/core_id:1
/sys/devices/system/cpu/cpu1/topology/core_siblings:0f
/sys/devices/system/cpu/cpu1/topology/core_siblings_list:0-3
/sys/devices/system/cpu/cpu1/topology/physical_package_id:0
/sys/devices/system/cpu/cpu1/topology/thread_siblings:02
/sys/devices/system/cpu/cpu1/topology/thread_siblings_list:1
/sys/devices/system/cpu/cpu2/topology/core_id:2
/sys/devices/system/cpu/cpu2/topology/core_siblings:0f
/sys/devices/system/cpu/cpu2/topology/core_siblings_list:0-3
/sys/devices/system/cpu/cpu2/topology/physical_package_id:0
/sys/devices/system/cpu/cpu2/topology/thread_siblings:04
/sys/devices/system/cpu/cpu2/topology/thread_siblings_list:2
/sys/devices/system/cpu/cpu3/topology/core_id:3
/sys/devices/system/cpu/cpu3/topology/core_siblings:0f
/sys/devices/system/cpu/cpu3/topology/core_siblings_list:0-3
/sys/devices/system/cpu/cpu3/topology/physical_package_id:0
/sys/devices/system/cpu/cpu3/topology/thread_siblings:08
/sys/devices/system/cpu/cpu3/topology/thread_siblings_list:3
/sys/devices/system/cpu/cpu4/topology/core_id:0
/sys/devices/system/cpu/cpu4/topology/core_siblings:f0
/sys/devices/system/cpu/cpu4/topology/core_siblings_list:4-7
/sys/devices/system/cpu/cpu4/topology/physical_package_id:1
/sys/devices/system/cpu/cpu4/topology/thread_siblings:10
/sys/devices/system/cpu/cpu4/topology/thread_siblings_list:4
/sys/devices/system/cpu/cpu5/topology/core_id:1
/sys/devices/system/cpu/cpu5/topology/core_siblings:f0
/sys/devices/system/cpu/cpu5/topology/core_siblings_list:4-7
/sys/devices/system/cpu/cpu5/topology/physical_package_id:1
/sys/devices/system/cpu/cpu5/topology/thread_siblings:20
/sys/devices/system/cpu/cpu5/topology/thread_siblings_list:5
/sys/devices/system/cpu/cpu6/topology/core_id:2
/sys/devices/system/cpu/cpu6/topology/core_siblings:f0
/sys/devices/system/cpu/cpu6/topology/core_siblings_list:4-7
/sys/devices/system/cpu/cpu6/topology/physical_package_id:1
/sys/devices/system/cpu/cpu6/topology/thread_siblings:40
/sys/devices/system/cpu/cpu6/topology/thread_siblings_list:6
/sys/devices/system/cpu/cpu7/topology/core_id:3
/sys/devices/system/cpu/cpu7/topology/core_siblings:f0
/sys/devices/system/cpu/cpu7/topology/core_siblings_list:4-7
/sys/devices/system/cpu/cpu7/topology/physical_package_id:1
/sys/devices/system/cpu/cpu7/topology/thread_siblings:80
/sys/devices/system/cpu/cpu7/topology/thread_siblings_list:7

No change before/after (both match my view of the hardware).

>
>>>> For me, it fails on the following big.LITTLE systems:
>>>>
>>>>     R-Car H3 ES2.0 (4xCA57 + 4xCA53)
>>>>     R-Car M3-W (2xCA57 + 4xCA53)
>>>>
>>>
>>> Interesting, is it PSCI based system suspend ?
>>
>> Yes it is.
>
> From DT, I guess this platform doesn't have any idle states.
> Does this use genpd power domains ? I see power-domains in the DT, so
> asking to get more info. Do you have any out of tree patches especially
> if they are depending on some topology cpumasks ?

No out-of-tree patches.
I'm testing plain 37c3ec2d810f87ea vs. 37c3ec2d810f87ea^.
There are power-domains in DT, but they're not managed by the new
fancy CPU power domain code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
