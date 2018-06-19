Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21236C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE97720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE97720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757057AbeFSKQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:16:08 -0400
Received: from foss.arm.com ([217.140.101.70]:46608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756535AbeFSKQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:16:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6124A1435;
        Tue, 19 Jun 2018 03:16:06 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A4F73F25D;
        Tue, 19 Jun 2018 03:16:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 0/7] arm64: perf: Support for chained counters
Date:   Tue, 19 Jun 2018 11:15:35 +0100
Message-Id: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for counting PMU events using 64bit counters
for arm64 PMU.

The Arm v8 PMUv3 supports combining two adjacent 32bit counters
(low even and hig odd counters) to count a given "event" in 64bit mode.
This series adds the support for 64bit events in the core arm_pmu driver
infrastructure and adds the support for armv8 64bit kernel PMU to use
chained counters to count in 64bit mode. For CPU cycles, we use the cycle
counter in 64bit mode, only when requested. If the cycle counter is not
available, we fall back to chaining the counters.

Tested on Juno, Fast models. Applies on 4.18-rc1

Changes since v2:
 - Clean up select counter routine. (Mark Rutland)
 - Stop PMU while processing overflows (Mark Rutland)
 - Drop special allocation algorithm for chain indices
 - Since we access the counters when the PMU is stopped,
   get rid of the unncessary barriers.
 - Ensure a counter is allocated when checking for chained event

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

Suzuki K Poulose (7):
  arm_pmu: Clean up maximum period handling
  arm_pmu: Change API to support 64bit counter values
  arm_pmu: Add support for 64bit event counters
  arm_pmu: Tidy up clear_event_idx call backs
  arm64: perf: Clean up armv8pmu_select_counter
  arm64: perf: Disable PMU while processing counter overflows
  arm64: perf: Add support for chaining event counters

 arch/arm/kernel/perf_event_v6.c     |   6 +-
 arch/arm/kernel/perf_event_v7.c     |   7 +-
 arch/arm/kernel/perf_event_xscale.c |  10 +-
 arch/arm64/kernel/perf_event.c      | 249 +++++++++++++++++++++++++++++-------
 drivers/perf/arm_pmu.c              |  51 +++++---
 include/linux/perf/arm_pmu.h        |  11 +-
 6 files changed, 255 insertions(+), 79 deletions(-)

-- 
2.7.4

