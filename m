Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFBD1x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:27:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37972 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeFBD1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:27:52 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <cover.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 00/11] macintosh: Resolve various PMU driver problems
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches has the following aims.

1) Eliminate duplicated code. Linux presently has two drivers for
   the 68HC05-based PMU devices found in Macs: via-pmu and via-pmu68k.
   There's no value in having separate PMU drivers for each architecture.

2) Avoid further work on via-pmu68k that's not needed for via-pmu.

3) Fix some bugs in the via-pmu driver.

4) Enable the /dev/pmu and /proc/pmu/* userspace APIs on m68k Macs
   by adopting via-pmu.

5) Improve stability on early 100-series PowerBooks by loading no PMU
   driver at all. Neither via-pmu nor via-pmu68k supports the early
   M50753-based PMU device found in these models.

6) Eliminate duplicated RTC accessors for PMU and Cuda. Presently these
   can be found under both arch/m68k and arch/powerpc.

7) Assist the out-of-tree NuBus PowerMac port to support PMU designs
   shared with the m68k Mac port (e.g. PowerBooks 190 and 5300).

This patch series has been regression tested on various PowerBooks
(190, 520, 3400, Pismo G3) and PowerMacs (Beige G3, G5). These patches
did not affect userland utilities. (Note that there is a userland-
visible change to the contents of /proc/pmu/interrupts.)


Finn Thain (11):
  macintosh/via-pmu: Fix section mismatch warning
  macintosh/via-pmu: Add missing mmio accessors
  macintosh/via-pmu: Don't clear shift register interrupt flag twice
  macintosh/via-pmu: Enhance state machine with new 'uninitialized'
    state
  macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
  macintosh/via-pmu: Add support for m68k PowerBooks
  macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps explicit
  macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
  macintosh: Use common code to access RTC
  macintosh/via-pmu: Clean up interrupt statistics
  macintosh/via-pmu: Disambiguate interrupt statistics

 arch/m68k/configs/mac_defconfig        |   2 +-
 arch/m68k/configs/multi_defconfig      |   2 +-
 arch/m68k/mac/config.c                 |   2 +-
 arch/m68k/mac/misc.c                   | 118 +----
 arch/powerpc/platforms/powermac/time.c |  74 +--
 drivers/macintosh/Kconfig              |  19 +-
 drivers/macintosh/Makefile             |   1 -
 drivers/macintosh/adb.c                |   2 +-
 drivers/macintosh/via-cuda.c           |  34 ++
 drivers/macintosh/via-pmu.c            | 374 ++++++++++-----
 drivers/macintosh/via-pmu68k.c         | 850 ---------------------------------
 include/linux/cuda.h                   |   3 +
 include/linux/pmu.h                    |   3 +
 include/uapi/linux/pmu.h               |   2 -
 14 files changed, 307 insertions(+), 1179 deletions(-)
 delete mode 100644 drivers/macintosh/via-pmu68k.c

-- 
2.16.1
