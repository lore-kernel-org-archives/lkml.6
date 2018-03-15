Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeCOQGH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:06:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53789 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeCOQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:00:59 -0400
X-Google-Smtp-Source: AG47ELsqphkPc2E6Jya/AdZdm4hZWtBJVyt4R1P+BNsuHfTZuVt9Fo1Re6Hj3JzVJ/n1lVXO3eOZZQ==
From: jason.vas.dias@gmail.com
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: [PATCH v4.16-rc5 (3)] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
Date: Thu, 15 Mar 2018 16:00:45 +0000
Message-Id: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com>
X-Mailer: git-send-email 2.8.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Resent to address reviewer comments.
   
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

  Now the new do_monotonic_raw() function in the vDSO has a latency of @ 24ns
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
   arch/x86/entry/vdso/vdso.lds.S
   arch/x86/entry/vdso/vdsox32.lds.S
   arch/x86/entry/vdso/vdso32/vdso32.lds.S
   arch/x86/entry/vsyscall/vsyscall_gtod.c

  There are 3 patches in the series :

   Patch #1 makes the VDSO handle clock_gettime(CLOCK_MONOTONIC_RAW) with rdtsc_ordered()

  Patches #2 & #3 should be considered "optional" :

   Patch #2 makes the VDSO handle clock_gettime(CLOCK_MONOTONIC_RAW) with a new rdtscp() function in msr.h

   Patch #3 makes the VDSO export TSC calibration data via a new function in the vDSO:
               unsigned int __vdso_linux_tsc_calibration ( struct linux_tsc_calibration *tsc_cal )
            that user code can optionally call.


   Patch #2 makes clock_gettime(CLOCK_MONOTONIC_RAW) calls somewhat faster
   than clock_gettime(CLOCK_MONOTONIC) calls.

   I think something like Patch #3 is necessary to export TSC calibration data to user-space TSC readers.

   It is entirely up to the kernel developers whether they want to include patches
   #2 and #3, but I think something like Patch #1 really needs to get into a future
   Linux release, as an unecessary latency of 200-1000ns for a timer that can tick
   3 times per nanosecond is unacceptable.

   Patches for kernels 3.10.0-21 and 4.9.65-rt23 (ARM) are attached to bug #198161. 


Thanks & Best Regards,
Jason Vas Dias
