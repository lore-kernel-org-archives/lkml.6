Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755262AbeE3FOj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:14:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32905 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeE3FOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:14:37 -0400
X-Google-Smtp-Source: ADUXVKKVTh5q+xyJf+FZkS9KQ4GC3B5NNNKB53tx6FywJtZ1doj/+nxJq5Wzw+nq5x0c+sPR2rwvRzO7XiAzLITCptM=
MIME-Version: 1.0
In-Reply-To: <5AF25CC3.1010902@samsung.com>
References: <CGME20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974@epcas2p1.samsung.com>
 <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com> <5AF25CC3.1010902@samsung.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 29 May 2018 22:14:35 -0700
Message-ID: <CALAqxLV-Y9hN97Z=oqL2=_=1Rg5bw1mz56WWgAWrwh=VONNAqw@mail.gmail.com>
Subject: Re: Userland breakage from "Modify the device name as devfreq(X) for sysfs"
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Leo Yan <leo.yan@linaro.org>, Jean Wangtao <kevin.wangtao@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U5EjSW020978

On Tue, May 8, 2018 at 7:28 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 2018년 05월 09일 08:17, John Stultz wrote:
>> Hey folks,
>>   I wanted to bring up an issue we've recently tripped over, which was
>> caused by 4585fbcb5331f ("PM / devfreq: Modify the device name as
>> devfreq(X) for sysfs").
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4585fbcb5331fc910b7e553ad3efd0dd7b320d14
>>
>> That patch replaced paths like:
>>    /sys/class/devfreq/ddr_devfreq/min_freq
>> and
>>   /sys/class/devfreq/e82c0000.mali/min_freq
>>
>> With
>>   /sys/class/devfreq/devfreq(0)/min_freq
>> and
>>   /sys/class/devfreq/devfreq(1)/min_freq
>>
>>
>> This broke userspace we have that needs to work on 4.4, 4.9 and 4.14 (and on).
>
> Firstly, I'm sorry to make some problem on userland.
>
>>
>> I wanted to try to ask to understand more about the rational for this
>> patch, as it doesn't make much sense to me, particularly as now it is
>> less obvious as to which path is for which device  - and more
>> worrisome it could change depending on initialization order.
>
> Some linux framework used the their own prefix under "/sys/class/"
> for device such as input/pwm/hwmon/regulator and so on.
> (But, some linux framework used the device name directly without any changes)
>
> I thought that devfreq better to use use the consistent name.
> If user wanted to access the specific device with device name,
> the user can access the path of '/sys/devices/platform/...'.
>
> [Example on Exynos5433-based TM2 board]
> root@localhost:~# ls -al /sys/class/devfreq
> total 0
> drwxr-xr-x  2 root root 0 Jul 26 04:49 .
> drwxr-xr-x 50 root root 0 Jan  1  1970 ..
> lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq0 -> ../../devices/platform/soc/soc:bus0/devfreq/devfreq0
> lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq1 -> ../../devices/platform/soc/soc:bus1/devfreq/devfreq1
> (skip)
>
> - User can access the devfreq device with specific device name.
> root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# pwd
> /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0
>
> root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# ls
> available_frequencies  device    min_freq          subsystem    uevent
> available_governors    governor  polling_interval  target_freq
> cur_freq               max_freq  power             trans_stat
>
> root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# cat min_freq
> 160000000
>

Sorry to not get back to you sooner on this. Was on vacation then this
discussion got buried in my inbox.

I do agree that it the consistency with other subsystems is an
improvement, but it still doesn't help our situation that userspace
applications can't consistently work between kernel versions, as even
if we go with the /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0
path rather then the /sys/class/devfreq/ path, in older kernels the
/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0 doesn't exist.

> But, there is one of my mistake. The /sys/class/devfreq/devfreq(X)
> doesn't have the 'name' attribute. So, the user cannot find the required
> device. It is my mistake. I'll add the 'name' attribute as following:
> - /sys/class/devfreq/devfreqX/name

I agree that would be an improvement.

>> Unfortunately, this wasn't noticed very quickly, as the patch has been
>> upstream now for some time.  But I wanted to better understand why
>> this change was made, and see if we might consider reverting it, or
>> alternatively consider provide multiple sysfs links (both dev_name and
>> devfreq(N)) so that we can preserve compatibility?
>
> Unfortunately, there are no frameworks which provide the both dev_name and
> [defined prefix](N) link under /sys/class/. I'm not sure this way.
>
> As you comment, devfreq(number) is not fixed as the initialization order.
> After adding the 'name' attribute, the user can find the specific device.
>
> How about using the 'name' attribute to find the device
> after adding new 'name' attribute when access device through /sys/class?

I agree we need a name attribute so folks can tell the difference
between devices.

I'm also not too much of a stickler that the old ABI broke, as long as
we have some solution that works across kernels. So I'd request that
you at least make older -stable kernels (4.4 and 4.9) behavior
consistent with upstream.

thanks
-john
