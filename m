Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeCQO3v (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 10:29:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37063 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbeCQO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 10:29:50 -0400
X-Google-Smtp-Source: AG47ELug7LNzcTZKysXLVqdk7DEWG0Eu0xyVGAvZW+BRcVcyKrV/Xq18RRQVpJ7KRy9+FvjjJNdyLg==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc5 (2)] x86/vdso: VDSO should handle clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
Date: Sat, 17 Mar 2018 14:29:32 +0000
Message-Id: <1521296974-12142-1-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



  Resent to address reviewer comments, and allow builds with compilers
  that support -DRETPOLINE to succeed.

  Currently, the VDSO does not handle
     clock_gettime( CLOCK_MONOTONIC_RAW, &ts )
  on Intel / AMD - it calls
     vdso_fallback_gettime()
  for this clock, which issues a syscall, having an unacceptably high
  latency (minimum measurable time or time between measurements)
  of 300-700ns on 2 2.8-3.9ghz Haswell x86_64 Family'_'Model : 06_3C
  machines under various versions of Linux.

  Sometimes, particularly when correlating elapsed time to performance
  counter values, user-space  code needs to know elapsed time from the
  perspective of the CPU no matter how "hot" / fast or "cold" / slow it
  might be running wrt NTP / PTP "real" time; when code needs this,
  the latencies associated with a syscall are often unacceptably high.

  I reported this as Bug #198161 :
    'https://bugzilla.kernel.org/show_bug.cgi?id=198961'
  and in previous posts with subjects matching 'CLOCK_MONOTONIC_RAW' .

  This patch handles CLOCK_MONOTONIC_RAW clock_gettime() in the VDSO ,
  by exporting the raw clock calibration, last cycles, last xtime_nsec,
  and last raw_sec value in the vsyscall_gtod_data during vsyscall_update() .

  Now the new do_monotonic_raw() function in the vDSO has a latency of @ 20ns
  on average, and the test program:
   tools/testing/selftest/timers/inconsistency-check.c
  succeeds with arguments: '-c 4 -t 120' or any arbitrary -t value.

  The patch is against Linus' latest 4.16-rc5 tree,
  current HEAD of :
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  .

  This patch affects only files:

   arch/x86/include/asm/vgtod.h
   arch/x86/entry/vdso/vclock_gettime.c
   arch/x86/entry/vsyscall/vsyscall_gtod.c
   arch/x86/entry/vdso/Makefile   

  Patches for kernels 3.10.0-21 and 4.9.65-rt23 (ARM) are attached to bug #198161,
  as is the test program, timer_latency.c, to demonstrate the problem.

  Before the patch a latency of 200-1000ns was measured for
    clock_gettime(CLOCK_MONOTONIC_RAW,&ts)
  calls - after the patch, the same call on the same machine
  has a latency of @ 20ns.


Thanks & Best Regards,
Jason Vas Dias
