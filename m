Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935121AbeE3FeN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932557AbeE3FeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:34:11 -0400
Date: Wed, 30 May 2018 07:33:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Stultz <john.stultz@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Leo Yan <leo.yan@linaro.org>, Jean Wangtao <kevin.wangtao@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Userland breakage from "Modify the device name as devfreq(X) for
 sysfs"
Message-ID: <20180530053350.GA30256@kroah.com>
References: <CGME20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974@epcas2p1.samsung.com>
 <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com>
 <5AF25CC3.1010902@samsung.com>
 <CALAqxLV-Y9hN97Z=oqL2=_=1Rg5bw1mz56WWgAWrwh=VONNAqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALAqxLV-Y9hN97Z=oqL2=_=1Rg5bw1mz56WWgAWrwh=VONNAqw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:14:35PM -0700, John Stultz wrote:
> On Tue, May 8, 2018 at 7:28 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > On 2018년 05월 09일 08:17, John Stultz wrote:
> >> Hey folks,
> >>   I wanted to bring up an issue we've recently tripped over, which was
> >> caused by 4585fbcb5331f ("PM / devfreq: Modify the device name as
> >> devfreq(X) for sysfs").
> >>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4585fbcb5331fc910b7e553ad3efd0dd7b320d14
> >>
> >> That patch replaced paths like:
> >>    /sys/class/devfreq/ddr_devfreq/min_freq
> >> and
> >>   /sys/class/devfreq/e82c0000.mali/min_freq
> >>
> >> With
> >>   /sys/class/devfreq/devfreq(0)/min_freq
> >> and
> >>   /sys/class/devfreq/devfreq(1)/min_freq
> >>
> >>
> >> This broke userspace we have that needs to work on 4.4, 4.9 and 4.14 (and on).
> >
> > Firstly, I'm sorry to make some problem on userland.
> >
> >>
> >> I wanted to try to ask to understand more about the rational for this
> >> patch, as it doesn't make much sense to me, particularly as now it is
> >> less obvious as to which path is for which device  - and more
> >> worrisome it could change depending on initialization order.
> >
> > Some linux framework used the their own prefix under "/sys/class/"
> > for device such as input/pwm/hwmon/regulator and so on.
> > (But, some linux framework used the device name directly without any changes)
> >
> > I thought that devfreq better to use use the consistent name.
> > If user wanted to access the specific device with device name,
> > the user can access the path of '/sys/devices/platform/...'.
> >
> > [Example on Exynos5433-based TM2 board]
> > root@localhost:~# ls -al /sys/class/devfreq
> > total 0
> > drwxr-xr-x  2 root root 0 Jul 26 04:49 .
> > drwxr-xr-x 50 root root 0 Jan  1  1970 ..
> > lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq0 -> ../../devices/platform/soc/soc:bus0/devfreq/devfreq0
> > lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq1 -> ../../devices/platform/soc/soc:bus1/devfreq/devfreq1
> > (skip)
> >
> > - User can access the devfreq device with specific device name.
> > root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# pwd
> > /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0
> >
> > root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# ls
> > available_frequencies  device    min_freq          subsystem    uevent
> > available_governors    governor  polling_interval  target_freq
> > cur_freq               max_freq  power             trans_stat
> >
> > root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# cat min_freq
> > 160000000
> >
> 
> Sorry to not get back to you sooner on this. Was on vacation then this
> discussion got buried in my inbox.
> 
> I do agree that it the consistency with other subsystems is an
> improvement, but it still doesn't help our situation that userspace
> applications can't consistently work between kernel versions, as even
> if we go with the /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0
> path rather then the /sys/class/devfreq/ path, in older kernels the
> /sys/devices/platform/soc/soc:bus0/devfreq/devfreq0 doesn't exist.

Ick, that's not ok.  The sys/class/ path should always work for old and
new.  If not, it's broken and should be reverted.

And it seems like it still works, just that the "names" are now
different in the class path, of the device, right?  And that should be
fine, what is breaking when a device name changes?

> > But, there is one of my mistake. The /sys/class/devfreq/devfreq(X)
> > doesn't have the 'name' attribute. So, the user cannot find the required
> > device. It is my mistake. I'll add the 'name' attribute as following:
> > - /sys/class/devfreq/devfreqX/name
> 
> I agree that would be an improvement.
> 
> >> Unfortunately, this wasn't noticed very quickly, as the patch has been
> >> upstream now for some time.  But I wanted to better understand why
> >> this change was made, and see if we might consider reverting it, or
> >> alternatively consider provide multiple sysfs links (both dev_name and
> >> devfreq(N)) so that we can preserve compatibility?
> >
> > Unfortunately, there are no frameworks which provide the both dev_name and
> > [defined prefix](N) link under /sys/class/. I'm not sure this way.
> >
> > As you comment, devfreq(number) is not fixed as the initialization order.
> > After adding the 'name' attribute, the user can find the specific device.
> >
> > How about using the 'name' attribute to find the device
> > after adding new 'name' attribute when access device through /sys/class?
> 
> I agree we need a name attribute so folks can tell the difference
> between devices.
> 
> I'm also not too much of a stickler that the old ABI broke, as long as
> we have some solution that works across kernels. So I'd request that
> you at least make older -stable kernels (4.4 and 4.9) behavior
> consistent with upstream.

No, I don't want to backport api changes like that as then users of
those kernels that were working just fine break :)

So I think mainline needs to revert this.

thanks,

greg k-h
