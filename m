Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033253AbeCAQwH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:52:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033015AbeCAQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:03 -0500
Message-Id: <20180301163331.987775783@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:31 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working through the melted spectrum induced backlog I found that last
years discussion about unifying clock MONOTONIC and clock BOOTTIME has died
out and obviously nobody had time to do testing on that half baken RFC patch:

  https://lkml.kernel.org/r/alpine.DEB.2.20.1711180123360.2186@nanos

So I sat down and revisited it a bit more carefully than last time. The
following series is the result of this work. The main differences are:

 1) Provide CLOCK_MONOTONIC_ACTIVE which has the current CLOCK_MONOTONIC
    behaviour, i.e. it's monotonic time since boot minus the time spent in
    suspend.

    The reason why I introduced it is that currently it's possible for user
    space to determine the time spent in suspend by subtracting clock
    monotonic and clock boot time time stamps. When CLOCK_MONOTONIC behaves
    like CLOCK_BOOTTIME then this is not longer possible.

    As a side effect when CLOCK_MONOTONIC_ACTIVE is supported by a kernel
    then this is also an indicator that CLOCK_MONOTONIC and CLOCK_BOOTTIME
    are identical. So it's possible to determine this w/o playing games
    with kernel versions etc. Older kernels simply return -EiNVAL if
    CLOCK_MONOTONIC_ACTIVE is requested in clock_gettime().

 2) Fixed a few places which I missed last time, which means also that my
    warning in the original changelog was justified.

 3) Consolidated the core users to get rid of the seperate implementations
    for the two clocks

Note, there are user space visible side effects. The difference between
CLOCK_MONOTONIC and CLOCK_BOOTTIME is well documented and it's unclear
whether applications rely on it or not.

This really needs lot of testing, documentation updates and more input from
userspace folks to make a final decision.

Thanks,

	tglx

---

 Documentation/trace/ftrace.txt      |   14 +-----
 drivers/input/evdev.c               |    7 ---
 include/linux/hrtimer.h             |    2 
 include/linux/timekeeper_internal.h |    2 
 include/linux/timekeeping.h         |   37 +++++------------
 include/uapi/linux/time.h           |    1 
 kernel/time/hrtimer.c               |   16 -------
 kernel/time/posix-stubs.c           |    2 
 kernel/time/posix-timers.c          |   26 ++++--------
 kernel/time/tick-common.c           |   15 ++++++
 kernel/time/tick-internal.h         |    6 ++
 kernel/time/tick-sched.c            |    9 ++++
 kernel/time/timekeeping.c           |   78 ++++++++++++++++++------------------
 kernel/time/timekeeping.h           |    1 
 kernel/trace/trace.c                |    2 
 15 files changed, 104 insertions(+), 114 deletions(-)
