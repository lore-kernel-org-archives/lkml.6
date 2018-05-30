Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937201AbeE3Gwl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:52:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36973 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935905AbeE3Gwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:52:39 -0400
X-Google-Smtp-Source: ADUXVKLrCcHYI5vT0567IvnJecM+ZqFiKlqGilt6QfQbedYrJjBON6vDyvkLIbkLtVbGJ2SYOkZkFeraUERWAizFyys=
MIME-Version: 1.0
In-Reply-To: <20180530053350.GA30256@kroah.com>
References: <CGME20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974@epcas2p1.samsung.com>
 <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com>
 <5AF25CC3.1010902@samsung.com> <CALAqxLV-Y9hN97Z=oqL2=_=1Rg5bw1mz56WWgAWrwh=VONNAqw@mail.gmail.com>
 <20180530053350.GA30256@kroah.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 29 May 2018 23:52:37 -0700
Message-ID: <CALAqxLUnuFvfYqtxxjVk-Vq2UpvmSr8d+uZT1jGdjZmFvQ_DOA@mail.gmail.com>
Subject: Re: Userland breakage from "Modify the device name as devfreq(X) for sysfs"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Leo Yan <leo.yan@linaro.org>, Jean Wangtao <kevin.wangtao@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U6rC3r028051

On Tue, May 29, 2018 at 10:33 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, May 29, 2018 at 10:14:35PM -0700, John Stultz wrote:
>> On Tue, May 8, 2018 at 7:28 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> > On 2018년 05월 09일 08:17, John Stultz wrote:
>> >> Hey folks,
>> >>   I wanted to bring up an issue we've recently tripped over, which was
>> >> caused by 4585fbcb5331f ("PM / devfreq: Modify the device name as
>> >> devfreq(X) for sysfs").
>> >>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4585fbcb5331fc910b7e553ad3efd0dd7b320d14
>> >>
>> >> That patch replaced paths like:
>> >>    /sys/class/devfreq/ddr_devfreq/min_freq
>> >> and
>> >>   /sys/class/devfreq/e82c0000.mali/min_freq
>> >>
>> >> With
>> >>   /sys/class/devfreq/devfreq(0)/min_freq
>> >> and
>> >>   /sys/class/devfreq/devfreq(1)/min_freq
>> >>
>> >>
>> >> This broke userspace we have that needs to work on 4.4, 4.9 and 4.14 (and on).
>> >
>> > Firstly, I'm sorry to make some problem on userland.
>> >
>> >>
>> >> I wanted to try to ask to understand more about the rational for this
>> >> patch, as it doesn't make much sense to me, particularly as now it is
>> >> less obvious as to which path is for which device  - and more
>> >> worrisome it could change depending on initialization order.
>> >
>> > Some linux framework used the their own prefix under "/sys/class/"
>> > for device such as input/pwm/hwmon/regulator and so on.
>> > (But, some linux framework used the device name directly without any changes)
>> >
>> > I thought that devfreq better to use use the consistent name.
>> > If user wanted to access the specific device with device name,
>> > the user can access the path of '/sys/devices/platform/...'.
>> >
>> > [Example on Exynos5433-based TM2 board]
>> > root@localhost:~# ls -al /sys/class/devfreq
>> > total 0
>> > drwxr-xr-x  2 root root 0 Jul 26 04:49 .
>> > drwxr-xr-x 50 root root 0 Jan  1  1970 ..
>> > lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq0 -> ../../devices/platform/soc/soc:bus0/devfreq/devfreq0
>> > lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq1 -> ../../devices/platform/soc/soc:bus1/devfreq/devfreq1
>> > (skip)
>> >
>> > - User can access the devfreq device with specific device name.
>> > root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# pwd
>> > /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0
>> >
>> > root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# ls
>> > available_frequencies  device    min_freq          subsystem    uevent
>> > available_governors    governor  polling_interval  target_freq
>> > cur_freq               max_freq  power             trans_stat
>> >
>> > root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# cat min_freq
>> > 160000000
>> >
>>
>> Sorry to not get back to you sooner on this. Was on vacation then this
>> discussion got buried in my inbox.
>>
>> I do agree that it the consistency with other subsystems is an
>> improvement, but it still doesn't help our situation that userspace
>> applications can't consistently work between kernel versions, as even
>> if we go with the /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0
>> path rather then the /sys/class/devfreq/ path, in older kernels the
>> /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0 doesn't exist.
>
> Ick, that's not ok.  The sys/class/ path should always work for old and
> new.  If not, it's broken and should be reverted.
>
> And it seems like it still works, just that the "names" are now
> different in the class path, of the device, right?  And that should be
> fine, what is breaking when a device name changes?

Well, code that is looking for:
/sys/class/devfreq/ddr_devfreq/min_freq

won't work with newer kernels unless its changed to look for:
/sys/class/devfreq/devfreq0/min_freq

(assuming the ddr_devfreq driver loaded before the mali one :)

>> I agree we need a name attribute so folks can tell the difference
>> between devices.
>>
>> I'm also not too much of a stickler that the old ABI broke, as long as
>> we have some solution that works across kernels. So I'd request that
>> you at least make older -stable kernels (4.4 and 4.9) behavior
>> consistent with upstream.
>
> No, I don't want to backport api changes like that as then users of
> those kernels that were working just fine break :)
>
> So I think mainline needs to revert this.

The trouble is that the break happened awhile back (4.10) so if we
revert its likely to break any new users since then.

That's why I suggested we find some way to have both paths work. But I
don't know enough sysfs tricks to have a good suggestion on how to
easily do so.

thanks
-john
