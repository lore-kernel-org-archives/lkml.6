Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028DAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3503217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfB0QFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:05:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:6599 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0QFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011612"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:40 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [RFC PATCH v2 00/14] Implement an HPET-based hardlockup detector
Date:   Wed, 27 Feb 2019 08:05:04 -0800
Message-Id: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second attempt to demonstrate the implementation of a
hardlockup detector driven by the High-Precision Event Timer. The
initial implementation can be found here [1]. 

== Introduction ==

In CPU architectures that do not have an NMI watchdog, one can be
constructed using a counter of the Performance Monitoring Unit (PMU).
Counters in the PMU have high granularity and high visibility of the CPU.
These capabilities and their limited number make these counters precious
resources. Unfortunately, the perf-based hardlockup detector permanently
consumes one of these counters per CPU.

These counters could be freed for profiling purposes if the hardlockup
detector were driven by another timer.

The hardlockup detector runs relatively infrequently and does not require
visibility of the CPU activity (in addition to detect locked-up CPUs). A
timer that is external to the CPU (e.g., in the chipset) can be used to
drive the detector.

A key requirement is that the timer needs to be capable of issuing a
non-maskable interrupt to the CPU. In most cases, this can be achieved
by tweaking the delivery mode of the interrupt in the interrupt controller
chip (the exception is the IO APIC).

== Details of this implementation

This implementation aims to be simpler than the first attempt. Thus, it
only uses an HPET timer that is capable of issuing interrupts via the
Front Side Bus. Also, the series does not cover the case of interrupt
remapping (to be sent in a subsequent series). The generic interrupt code
is not used and, instead, the detector directly programs all the HPET
registers.

In order to not have to read HPET registers in every NMI, the time-stamp
counter is used to determine whether the HPET caused the interrupt.

Furthermore, only one write to HPET registers is done every
watchdog_thresh seconds. This write can be eliminated if the HPET timer
is periodic.

Lastly, the HPET timer always targets the same CPU. Hence, it is not
necessary to update the interrupt CPU affinity while the hardlockup
detector is running. The rest of the CPUs in the system are monitored
issuing a interprocessor interrupt. CPUs check a cpumask to determine
whether they need to look for hardlockups.

== Parts of this series ==

   1) Add a definition for NMI delivery mode in MSI interrupts. No other
      changes are done to generic irq code.

   2) Rework the x86 HPET platform code to reserve, configure a timer and
      expose the needed interfaces and definitions. Patches 2-6

   3) Rework the hardlockup detector to decouple its generic parts from
      the perf implementation. Patches 7-10

   4) Add an HPET-based hardlockup detector. This includes probing the
      hardware resources, configure the interrupt and rotate the
      destination of the interrupts among all monitored CPUs. Also, it
      includes an x86-specific shim hardlockup detector that selects
      between HPET and perf implementations. Patches 11-14


Thanks and BR,
Ricardo

Changes since v1:

 * Removed reads to HPET registers at every NMI. Instead use the time-stamp
   counter to infer the interrupt source (Thomas Gleixner, Andi Kleen).
 * Do not target CPUs in a round-robin manner. Instead, the HPET timer
   always targets the same CPU; other CPUs are monitored via an
   interprocessor interrupt.
 * Removed use of generic irq code to set interrupt affinity and NMI
   delivery. Instead, configure the interrupt directly in HPET registers
   (Thomas Gleixner).
 * Removed the proposed ops structure for NMI watchdogs. Instead, split
   the existing implementation into a generic library and perf-specific
   infrastructure (Thomas Gleixner, Nicholas Piggin).
 * Added an x86-specific shim hardlockup detector that selects between
   HPET and perf infrastructures as needed (Nicholas Piggin).
 * Removed locks taken in NMI and !NMI context. This was wrong and is no
   longer needed (Thomas Gleixner).
 * Fixed unconditonal return NMI_HANDLED when the HPET timer is programmed
   for FSB/MSI delivery (Peter Zijlstra).

References:

[1]. https://lkml.org/lkml/2018/6/12/1027

Ricardo Neri (14):
  kernel/watchdog: Add a function to obtain the watchdog_allowed_mask
  watchdog/hardlockup: Make arch_touch_nmi_watchdog() to hpet-based
    implementation
  x86/msi: Add definition for NMI delivery mode
  x86/hpet: Expose more functions to read and write registers
  x86/hpet: Calculate ticks-per-second in a separate function
  x86/hpet: Reserve timer for the HPET hardlockup detector
  x86/hpet: Relocate flag definitions to a header file
  x86/hpet: Configure the timer used by the hardlockup detector
  watchdog/hardlockup: Define a generic function to detect hardlockups
  watchdog/hardlockup: Decouple the hardlockup detector from perf
  x86/watchdog/hardlockup: Add an HPET-based hardlockup detector
  x86/watchdog/hardlockup/hpet: Determine if HPET timer caused NMI
  watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot
    parameter
  x86/watchdog: Add a shim hardlockup detector

 .../admin-guide/kernel-parameters.txt         |   6 +-
 arch/x86/Kconfig.debug                        |  14 +
 arch/x86/include/asm/hpet.h                   |  46 ++
 arch/x86/include/asm/msidef.h                 |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/hpet.c                        |  64 ++-
 arch/x86/kernel/watchdog_hld.c                |  78 +++
 arch/x86/kernel/watchdog_hld_hpet.c           | 447 ++++++++++++++++++
 drivers/char/hpet.c                           |  31 +-
 include/linux/hpet.h                          |   1 +
 include/linux/nmi.h                           |  12 +-
 kernel/Makefile                               |   3 +-
 kernel/watchdog.c                             |   9 +-
 kernel/watchdog_hld.c                         | 151 +-----
 kernel/watchdog_hld_perf.c                    | 175 +++++++
 15 files changed, 869 insertions(+), 171 deletions(-)
 create mode 100644 arch/x86/kernel/watchdog_hld.c
 create mode 100644 arch/x86/kernel/watchdog_hld_hpet.c
 create mode 100644 kernel/watchdog_hld_perf.c

-- 
2.17.1

