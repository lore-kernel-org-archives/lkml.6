Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E60C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D4C218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbeLTXKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:10:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36168 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbeLTXKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:10:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so3774794qtn.3;
        Thu, 20 Dec 2018 15:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nezuhEoUN3eO/o0iL1OzyaVZs5mUFWx4ax27J6rh46E=;
        b=C7vatCKGGt0FL8vfSpVZHZtnNqAc/3pGg9oznC9cCkMwsZVDernqLPgnwxrr+nQBDW
         6b5i1Mjw76z2wls1zQppKx9KivuB/6uExV32bwZEKCPFa2XS/eCYICJ1vXoM1Tl6YnHI
         2vwyyoMG6HSgEok8UliKrviSW11dCLi6gX48C2GaEaURjQJDre9gFjXxTSy+p3giJdDT
         ahf17n39bldV2XMJdxie+SW6rojhwsKpMDh7A44SbKMuBuZJZnUacQXwsyhb5VUvV+hn
         eYImfmQiOzE+k6u4K2MOVq/05//aqTPIXiuO+7b46zFzh4Zz+MzW/Xhmm4YfV8UbxhKb
         A+ZQ==
X-Gm-Message-State: AJcUuke30Scpe6bLbn1LTn7AULEM4T7MEfbn0ikWHNNV0Bs97lFAP3+W
        uyjTFe+gIcYlzDvpW3FMlxrQfL689ylILqsG99w=
X-Google-Smtp-Source: ALg8bN79peTq2WlRDzsWWqdAzOTst4X6HUSdsFFFoHcP5reAn1EtSMSNaryvtKtzDa2iwk65m2a3U37ANBwAigzchec=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr142253qvm.149.1545347400191;
 Thu, 20 Dec 2018 15:10:00 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Dec 2018 00:09:43 +0100
Message-ID: <CAK8P3a1t0RiYcHtpwk3jwma0SvsS3NE5PAvTbb2zR4n+wkh69A@mail.gmail.com>
Subject: [GIT PULL] y2038: more syscalls and cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Thomas,

I realized that the merge window is now imminent, but I had not sent a
pull request to Thomas for the current y2038 stuff. These patches have
been around for a while though, and were in linux-next through my tree.

I got one bug report on Monday and incorporated a simple fix, which
changed the commit date for the second half of the series, in case you
are wondering.

Thomas, is it ok for you to just provide an Ack for this branch and
have Linus merge it directly?

      Arnd

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-for-4.21

for you to fetch changes up to e4b92b108c6cd6b311e4b6e85d6a87a34599a6e3:

  timekeeping: remove obsolete time accessors (2018-12-18 16:13:05 +0100)

----------------------------------------------------------------
y2038: more syscalls and cleanups

This concludes the main part of the system call rework for 64-bit time_t,
which has spread over most of year 2018, the last six system calls being

 - ppoll
 - pselect6
 - io_pgetevents
 - recvmmsg
 - futex
 - rt_sigtimedwait

As before, nothing changes for 64-bit architectures, while 32-bit
architectures gain another entry point that differs only in the layout
of the timespec structure. Hopefully in the next release we can wire up
all 22 of those system calls on all 32-bit architectures, which gives
us a baseline version for glibc to start using them.

This does not include the clock_adjtime, getrusage/waitid, and
getitimer/setitimer system calls. I still plan to have new versions
of those as well, but they are not required for correct operation of
the C library since they can be emulated using the old 32-bit time_t
based system calls.

Aside from the system calls, there are also a few cleanups here,
removing old kernel internal interfaces that have become unused after
all references got removed. The arch/sh cleanups are part of this,
there were posted several times over the past year without a reaction
from the maintainers, while the corresponding changes made it into all
other architectures.

----------------------------------------------------------------
Arnd Bergmann (13):
      y2038: futex: Move compat implementation into futex.c
      y2038: futex: Add support for __kernel_timespec
      y2038: socket: Add compat_sys_recvmmsg_time64
      y2038: signal: Add sys_rt_sigtimedwait_time32
      y2038: signal: Add compat_sys_rt_sigtimedwait_time64
      sh: dreamcast: rtc: push down rtc class ops into driver
      sh: sh03: rtc: push down rtc class ops into driver
      sh: remove unused rtc_sh_get/set_time infrastructure
      sh: remove board_time_init() callback
      timekeeping: remove unused {read,update}_persistent_clock
      timekeeping: remove timespec_add/timespec_del
      vfs: replace current_kernel_time64 with ktime equivalent
      timekeeping: remove obsolete time accessors

Deepa Dinamani (5):
      signal: Add set_user_sigmask()
      signal: Add restore_user_sigmask()
      ppoll: use __kernel_timespec
      pselect6: use __kernel_timespec
      io_pgetevents: use __kernel_timespec

 Documentation/sh/new-machine.txt              |   8 --
 arch/sh/boards/mach-dreamcast/Makefile        |   4 +-
 arch/sh/boards/mach-dreamcast/rtc.c           |  45 +++++++---
 arch/sh/boards/mach-dreamcast/setup.c         |   1 -
 arch/sh/boards/mach-sh03/Makefile             |   3 +-
 arch/sh/boards/mach-sh03/rtc.c                |  51 ++++++-----
 arch/sh/boards/mach-sh03/setup.c              |   9 --
 arch/sh/boards/of-generic.c                   |   8 --
 arch/sh/configs/dreamcast_defconfig           |   2 +
 arch/sh/configs/sh03_defconfig                |   2 +
 arch/sh/include/asm/rtc.h                     |   3 -
 arch/sh/include/mach-dreamcast/mach/sysasic.h |   1 -
 arch/sh/kernel/time.c                         |  74 +---------------
 fs/aio.c                                      | 134
++++++++++++++++++++---------
 fs/eventpoll.c                                |  52 ++----------
 fs/inode.c                                    |   4 +-
 fs/select.c                                   | 360
+++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 include/linux/compat.h                        |  26 ++++++
 include/linux/futex.h                         |   8 --
 include/linux/signal.h                        |   4 +
 include/linux/socket.h                        |   9 +-
 include/linux/syscalls.h                      |  29 +++++--
 include/linux/time32.h                        |  25 ------
 include/linux/timekeeping.h                   |  14 ---
 include/linux/timekeeping32.h                 |  15 ----
 kernel/Makefile                               |   3 -
 kernel/futex.c                                | 207
+++++++++++++++++++++++++++++++++++++++++++--
 kernel/futex_compat.c                         | 202
--------------------------------------------
 kernel/signal.c                               | 143
+++++++++++++++++++++++++++++++
 kernel/sys_ni.c                               |   2 +
 kernel/time/ntp.c                             |  10 +--
 kernel/time/time.c                            |  36 --------
 kernel/time/timekeeping.c                     |  12 +--
 net/compat.c                                  |  34 +++-----
 net/socket.c                                  |  62 ++++++++++----
 35 files changed, 847 insertions(+), 755 deletions(-)
 delete mode 100644 kernel/futex_compat.c
