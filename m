Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA07C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F002075E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F002075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964841AbeGBIV2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:21:28 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48722 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933534AbeGBIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:21 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 2C2282939E; Mon,  2 Jul 2018 04:21:17 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <cover.1530519301.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 00/11] macintosh: Resolve various PMU driver problems
Date:   Mon,  2 Jul 2018 04:21:17 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

6) Assist the out-of-tree NuBus PowerMac port to support PMU designs
   shared with the m68k Mac port (e.g. PowerBooks 190 and 5300).

This patch series has been regression tested on various PowerBooks
(190, 520, 3400, Pismo G3) and PowerMacs (Beige G3, G5). These patches
did not affect userland utilities. (Note that there is a userland-
visible change to the contents of /proc/pmu/interrupts.)

Changed since v1:
1) Added blank lines after 'break' statements in patch 10.
2) Improved patch description for patch 3.
3) Added reviewed-by tags.
4) Split patch 8 to make code review easier.

Changed since v2:
1) Added reviewed-by tag.
2) Retained PMU_68K_V1 and PMU_68K_V2 symbols.

Changed since v3:
1) Rebased on v4.18-rc2.
2) Omitted patch 10/12, since these RTC changes now conflict with mainline.
   It will be reworked once the mainline m68k/powerpc RTC code stabilizes.


Finn Thain (11):
  macintosh/via-pmu: Fix section mismatch warning
  macintosh/via-pmu: Add missing mmio accessors
  macintosh/via-pmu: Don't clear shift register interrupt flag twice
  macintosh/via-pmu: Enhance state machine with new 'uninitialized'
    state
  macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
  macintosh/via-pmu: Add support for m68k PowerBooks
  macintosh/via-pmu: Explicitly specify CONFIG_PPC_PMAC dependencies
  macintosh/via-pmu68k: Don't load driver on unsupported hardware
  macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
  macintosh/via-pmu: Clean up interrupt statistics
  macintosh/via-pmu: Disambiguate interrupt statistics

 arch/m68k/configs/mac_defconfig   |   2 +-
 arch/m68k/configs/multi_defconfig |   2 +-
 arch/m68k/mac/config.c            |   2 +-
 arch/m68k/mac/misc.c              |  54 +--
 drivers/macintosh/Kconfig         |  19 +-
 drivers/macintosh/Makefile        |   1 -
 drivers/macintosh/adb.c           |   2 +-
 drivers/macintosh/via-pmu.c       | 346 ++++++++++------
 drivers/macintosh/via-pmu68k.c    | 850 --------------------------------------
 include/uapi/linux/pmu.h          |   4 +-
 10 files changed, 235 insertions(+), 1047 deletions(-)
 delete mode 100644 drivers/macintosh/via-pmu68k.c

-- 
2.16.4

