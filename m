Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeEROj1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:39:27 -0400
Received: from foss.arm.com ([217.140.101.70]:54094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbeEROjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:39:24 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3 0/5]
Date: Fri, 18 May 2018 15:39:08 +0100
Message-Id: <20180518143913.26306-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMUv3 has been introduced with ARMv8 and, while it has only been used
on 64bit systems so far, it would definitely be useful for 32bit
guests running under KVM/arm64, for example.

There is also the case of people natively running 32bit kernels on
64bit HW and trying to upstream unspeakable hacks, hoping that the
stars will align and that they'll win the lottery (see [1]).

So let's try again, and make the PMUv3 driver usable for everyone.

This is done in three steps:
(1) Move the driver from arch/arm64 to drivers/perf
(2) Add a handful of system register accessors so that we can reuse
    the driver on 32bit
(3) Provide the same accessors on 32bit, enable compilation, and
    make it the default selection for mach-virt.

Tested on a Seattle box with 32bit guests.

* From v1:
  - Fixed encodings for some CP15 accessors
  - Added a terse note saying that CPU_V7 also covers ARMv8
  - Rebased on v4.12-rc5

* From v2:
  - SPDX tags on new and moved files. Yeah!
  - Annual rebase on 4.17-rc5

[1] https://patchwork.kernel.org/patch/10406793/

Marc Zyngier (5):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

 arch/arm/Kconfig                                   |   1 +
 arch/arm/include/asm/arm_pmuv3.h                   | 125 +++++++++++++++++++++
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h                 | 111 ++++++++++++++++++
 arch/arm64/include/asm/perf_event.h                |  55 ---------
 arch/arm64/kernel/Makefile                         |   1 -
 drivers/perf/Kconfig                               |   8 ++
 drivers/perf/Makefile                              |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c       |  42 ++++---
 include/kvm/arm_pmu.h                              |   2 +-
 include/linux/perf/arm_pmuv3.h                     |  78 +++++++++++++
 11 files changed, 346 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (97%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.14.2
