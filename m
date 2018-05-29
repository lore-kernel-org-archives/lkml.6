Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeE2K4L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:56:11 -0400
Received: from foss.arm.com ([217.140.101.70]:37352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932763AbeE2K4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:56:10 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 0/5] arm64: perf: Support for chained counters
Date: Tue, 29 May 2018 11:55:51 +0100
Message-Id: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for counting PMU events using 64bit counters
for arm64 PMU.

The Arm v8 PMUv3 supports combining two adjacent 32bit counters
(low even and hig odd counters) to count a given "event" in 64bit mode.
This series adds the support for 64bit events in the core arm_pmu driver
infrastructure and adds the support for armv8 64bit kernel PMU to use
chained counters to count in 64bit mode. For CPU cycles, we use the cycle
counter in 64bit mode, when requested. If the cycle counter is not available,
we fall back to chaining the counters.

Tested on Juno, Fast models. Applies on 4.17-rc4

Change since v1:
 - Remove unnecessary isb()s in chain counter reads/writes
 - Fix event programming order for counters
 - Tighten chain counter event read sequence
 - Set chain event to count in all ELs
 - Cleanup helpers to be consistent
 - Fix build break on xcale PMU (reported by kbuild-robot)
 - Remove the explicit counter width field from pmu backends and default
   to 32bit.
 - Rename flag ARMPMU_EVT_LONG => ARMPMU_EVT_64BIT and
   the format string "chain" => "bits64". (Unfortunately we can't use "64bit"
   and I am open for suggestion on a better name)
 - Rename armpmu_get_event_max_period() => armpmu_event_max_period()
 - For 64bit CPU cycles events, allow chaining if cycle counter is
   not available.

Suzuki K Poulose (5):
  arm_pmu: Clean up maximum period handling
  arm_pmu: Change API to support 64bit counter values
  arm_pmu: Add support for 64bit event counters
  arm_pmu: Tidy up clear_event_idx call backs
  arm64: perf: Add support for chaining event counters

 arch/arm/kernel/perf_event_v6.c     |   6 +-
 arch/arm/kernel/perf_event_v7.c     |   7 +-
 arch/arm/kernel/perf_event_xscale.c |  10 +-
 arch/arm64/kernel/perf_event.c      | 234 +++++++++++++++++++++++++++++++-----
 drivers/perf/arm_pmu.c              |  41 +++++--
 include/linux/perf/arm_pmu.h        |  11 +-
 6 files changed, 254 insertions(+), 55 deletions(-)

-- 
2.7.4
