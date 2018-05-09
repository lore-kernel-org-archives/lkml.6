Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756572AbeEIOMU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:12:20 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45343 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756403AbeEIOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:12:19 -0400
X-Google-Smtp-Source: AB8JxZoRpXUESsTe95hoIFrc88rR9VddmqCTTgVFuK5byWGmDKgxkTm0ELuCsxgEXF/XOVRaZUAvyTGA8/bhCG4DJ3o=
MIME-Version: 1.0
In-Reply-To: <5AF25CC3.1010902@samsung.com>
References: <CGME20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974@epcas2p1.samsung.com>
 <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com> <5AF25CC3.1010902@samsung.com>
From: Kevin Wangtao <kevin.wangtao@linaro.org>
Date: Wed, 9 May 2018 22:12:17 +0800
Message-ID: <CAMBp1jMMqKDtLK=0_AvL6g7aUOADkgS88FQL_S+dg41CyRdQUw@mail.gmail.com>
Subject: Re: Userland breakage from "Modify the device name as devfreq(X) for sysfs"
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: John Stultz <john.stultz@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Leo Yan <leo.yan@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w49ECPt4012022

Hi Chanwoo Choi,

>From my point of view, if it is a new framework, you can use either
the consistent name or device name,
but as a framework has been used for several kernel version, you
should not change the device name
easily if there is no special reason, It will bring no benefits except
for confusion and compatibility issues.
Hope you reconsider.

Regards,
Kevin

On 9 May 2018 at 10:28, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi John,
>
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
>
> But, there is one of my mistake. The /sys/class/devfreq/devfreq(X)
> doesn't have the 'name' attribute. So, the user cannot find the required
> device. It is my mistake. I'll add the 'name' attribute as following:
> - /sys/class/devfreq/devfreqX/name
>
>>
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
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
