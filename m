Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeEOWol (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:44:41 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39848 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeEOWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:44:39 -0400
X-Google-Smtp-Source: AB8JxZr/kgByOQApTwHgfETf1btGv069WRdbN4+FXJlp+Tu2JqfWzwbN1fct9oGC3EGkI0sOHdT7Cjx3MJtIMIDrf+E=
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdO0EtzDHp3RF4ym3umWM_KfhvpWHV2+Y3270ygKz9iGw@mail.gmail.com>
References: <20180509172606.29387-1-david@lechnology.com> <CAHCN7xJ6+vmyrTQGYH=pKz5GRf7rLT4otreNgu6TJi_3UAEX5w@mail.gmail.com>
 <CAMRc=MdO0EtzDHp3RF4ym3umWM_KfhvpWHV2+Y3270ygKz9iGw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 15 May 2018 17:44:37 -0500
Message-ID: <CAHCN7xJt=tsc2zHWu+6y_2z=+kHdaovh3TD_MJ1+UeUbTdyj8w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v10_00=2F27=5D_ARM=3A_davinci=3A_convert_to_commo?=
        =?UTF-8?Q?n_clock_framework=E2=80=8B?=
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <david@lechnology.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 4:25 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-05-14 2:40 GMT+02:00 Adam Ford <aford173@gmail.com>:
>> On Wed, May 9, 2018 at 12:25 PM, David Lechner <david@lechnology.com> wrote:
>>> This series converts mach-davinci to use the common clock framework.
>>>
>>> The series works like this, the first 3 patches fix some issues with the clock
>>> drivers that have already been accepted into the mainline kernel.
>>>
>>> Then, starting with "ARM: davinci: pass clock as parameter to
>>> davinci_timer_init()", we get the mach code ready for the switch by adding the
>>> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
>>> around the legacy clocks so that we can switch easily between the old and the
>>> new.
>>>
>>> "ARM: davinci: switch to common clock framework" actually flips the switch
>>> to start using the new clock drivers. Then the next 8 patches remove all
>>> of the old clock code.
>>>
>>> The final four patches add device tree clock support to the one SoC that
>>> supports it.
>>>
>>> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
>>> board file).
>>>
>>
>> I am not sure if I did something wrong, but I attempted to build and I
>> wasn't able to boot the da850-evm.dtb your repo common-clk-v11,
>> however the legacy board file boot was OK.
>>
>> make davinci_all_defconfig ARCH=arm
>> make zImage modules da850-evm.dtb ARCH=arm CROSS_COMPILE=arm-linux- -j8
>>
>> 3140416 bytes read in 1464 ms (2 MiB/s)
>> 20353 bytes read in 15 ms (1.3 MiB/s)
>> ## Flattened Device Tree blob at c0600000
>>    Booting using the fdt blob at 0xc0600000
>>    Loading Device Tree to c7e57000, end c7e5ef80 ... OK
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>>
>> (and hang)
>>
>> If you have some suggestions, I am try them as I get time.
>>
>> adam
>>
>
> Runs fine on da850-lcdk and dm365-evm. I'll test the da850-evm
> tomorrow when I'll have access to it.

I set the bootargs to: bootargs=console=ttyS2,115200n8
clk_ignore_unused root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait

I enabled DEBUG_LL and EARLY_PRINTK, yet when it loads, I only get:

## Flattened Device Tree blob at c0600000
   Booting using the fdt blob at 0xc0600000
   Loading Device Tree to c7e57000, end c7e5ef35 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.


I am doing this at my home, so I don't have a debugger for the
DA850-EVM.  I am using a SOM that is an AM1808, but I vaguely remember
something about enabling a DSP clock somewhere, but I cannot seem to
find the e-mail.  I know its counter intuitive that we'd need to
enable a clock that runs the DSP since it doesn't exist on the AM1808,
but I would have thought the clk_ignore_unused would have worked
around that issue.

If someone else has a DA850-EVM or suggestions, I'm willing to try
them as I have time.

adam
>
> Bart
