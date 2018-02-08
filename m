Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBHHKa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:10:30 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46322 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeBHHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:10:28 -0500
X-Google-Smtp-Source: AH8x224gyJVJZmYNplqtFkZMQM0+/JQkAF0QBn0us9hCAQ2ySmEh9IG5UGk8VNMo73vxlrg44yFVHovRfaLEHDRSkyE=
MIME-Version: 1.0
In-Reply-To: <20171214102148.GO10595@n2100.armlinux.org.uk>
References: <20171212162612.GB10595@n2100.armlinux.org.uk> <1513098352501.51185@mentor.com>
 <20171212172034.GC10595@n2100.armlinux.org.uk> <CAOuPNLiTf040ZOyEroq4oy=5Bz1LScmE-vpR3xdjXBGuCKcxMA@mail.gmail.com>
 <20171213111718.GJ10595@n2100.armlinux.org.uk> <CAOuPNLgM8OxP8cV9goAUDtXgxjhcfoe27M0Q=Ty1BVAPD5aipQ@mail.gmail.com>
 <20171213171530.GM10595@n2100.armlinux.org.uk> <1513186632784.96495@mentor.com>
 <20171213173956.GN10595@n2100.armlinux.org.uk> <CAOuPNLgZL0N0OuTUEVR6vFjykBtLeR+t0pvn3FSKsA4UqG-UGQ@mail.gmail.com>
 <20171214102148.GO10595@n2100.armlinux.org.uk>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 8 Feb 2018 12:40:26 +0530
Message-ID: <CAOuPNLgj8c0a1gDESQDatoa4GU_PYu8TK1NJ0KKkVfjW7zvsdA@mail.gmail.com>
Subject: Re: [VDSO]: vdso_test failing on arm 32 bit
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        "Lynch, Nathan" <Nathan_Lynch@mentor.com>,
        open list <linux-kernel@vger.kernel.org>, david.brown@linaro.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w187AcGF017532

Dear Nathan & Russel,

I have few more question about vdso for arm-32-bit.

I am using iMX7 board to very VDSO gettimeofday timing.

To make kernel/Documentation/vDSO/vdsotest work on this board, I
commented the device tree reading property:
arm,cpu-registers-not-fw-configured , from the :
arch/arm/kernel/vdso.c
[However, I havent removed the property from device-tree itself, so it
is still being read by: drivers/clocksource/arm_arch_timer.c ⇒
arch_timer_of_init(…)]

But it seems the VDSO gettimeofday call is rather very slow.
This is the result of 10 iteration (with 10 seconds delay between
each), after fresh reboot:
bash-3.2# ./run_vdso.sh
The time is 1116.898864
===========================
The time is 1126.957507
===========================
The time is 1136.988507
===========================
The time is 1147.023134
===========================
The time is 1157.053017
===========================
The time is 1167.082912
===========================
The time is 1177.117722
===========================
The time is 1187.150945
===========================
The time is 1197.180820
===========================
The time is 1207.215339
===========================
The time is 1217.245189
===========================

Although architected timer support is not available in firmware, so it
may not give the accurate timing.

1) So, I wonder why vdso call is very slow and increasing by every second ?

This is the result of benchmark test.

bash-3.2# ./vdsotest_bench gettimeofday bench
gettimeofday: syscall: 681 nsec/call
gettimeofday: libc: 4190 nsec/call
gettimeofday: vdso: 4171 nsec/call

Also, when I call gettimeofday API from a sample program, I could not
find any system call trace.

bash-3.2# time ./test-vdso-syscall.out
real 0m3.997s
user 0m3.980s
sys 0m0.000s


2) So, how do I conclude whether VDSO gettimeofday is working correctly or not ?
3) Is it important to have that device-tree property in VDSO, if
arch-timer support is not available in firmware ?

Please let me know your opinion.


Thank You!
Pintu


On Thu, Dec 14, 2017 at 3:51 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Dec 14, 2017 at 10:50:50AM +0530, Pintu Kumar wrote:
>> Oh ok. Thanks for this information.
>> So, in conclusion, can I summarize like this: VDSO support on ARM 32-bit
>> 1) VDSO works only on Cortex A7/A15 -> where generic timer extension
>> is available.
>> 2) VDSO works only on kernel 4.1 and above => where 32-bit vdso
>> support is available
>> 3) glibc version should be 2.20 or higher
>> 4) This device-tree property should not be set:
>> arm,cpu-registers-not-fw-configured => This means there is a firmware
>> bug
>>
>> Sorry, but still I have 2 more queries:
>> 1) Which is the firmware that we are talking about here ? What is the
>> name of firmware ? Is it available in kernel ?
>
> It's not in-kernel firmware, but whatever runs on the kernel prior to
> booting the kernel.
>
>> 2) Is there any ARM 32-bit board available, where I can confirm that
>> VDSO works on ARM 32-bit?
>
> I'm know of none.  That's not to say that there aren't any, I just don't
> know of any.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
