Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B13C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A732086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A732086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeKSLoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:44:17 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49090 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeKSLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:44:17 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 64FEF29DF5; Sun, 18 Nov 2018 20:22:17 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1542589838.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH v2 00/14] m68k: Drop arch_gettimeoffset and adopt clocksource API
Date:   Mon, 19 Nov 2018 12:10:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes "select ARCH_USES_GETTIMEOFFSET" from arch/m68k
and converts users of arch_gettimeoffset to the clocksource API.
Various bugs are fixed along the way.

Those platforms which do not actually implement arch_gettimeoffset
(apollo, q40, sun3, sun3x) use the "jiffies" clocksource by default.

The atari and hp300 platforms have an arch_gettimeoffset() implementation
which can't readily be converted to a clocksource. Getting a workable
clocksource on these platforms will require the insight of a platform
expert.

The difficulty with these patches is the use of the timer interrupt to
update the counter for the clock source. The timer interrupt handler races
with clocksource read method, and both of those functions race with the
timer hardware.

Hence, more testing and code review would be appreciated.

Changed since v1:

 - Dropped patches 1/13 and 2/13. These were a failed attempt to fix
5cfc8ee0bb51 and 4ad4c76b7afb. By adopting the clocksource API we can fix
this issue in mainline. By backporting this series we can fix it for -stable
(for m68k at least).

 - Dropped patch "m68k: hp300: Convert to clocksource API" and added
patch "m68k: hp300: Remove hp300_gettimeoffset".

 - Added a new patch to address an old m68k bug pointed out by Thomas
Gleixner. The bug can arise when a timer interrupt handler gets interrupted.

 - Added new patches to address old mvme16x and mvme147 bugs pointed out
by Thomas Gleixner. The bug could cause the clock to jump backwards.

 - Various other changes summarized in the relevant patches.


Finn Thain (14):
  m68k: Call timer_interrupt() with interrupts disabled
  m68k: mac: Fix VIA timer counter accesses
  m68k: mac: Clean up unused timer definitions
  m68k: apollo, q40, sun3, sun3x: Remove arch_gettimeoffset
    implementations
  m68k: Drop ARCH_USES_GETTIMEOFFSET
  m68k: amiga: Convert to clocksource API
  m68k: atari: Convert to clocksource API
  m68k: bvme6000: Convert to clocksource API
  m68k: hp300: Remove hp300_gettimeoffset()
  m68k: mac: Convert to clocksource API
  m68k: mvme147: Convert to clocksource API
  m68k: mvme147: Handle timer counter overflow
  m68k: mvme16x: Convert to clocksource API
  m68k: mvme16x: Handle timer counter overflow

 arch/m68k/Kconfig                 |   1 -
 arch/m68k/amiga/cia.c             |  10 ++
 arch/m68k/amiga/config.c          |  46 ++++++---
 arch/m68k/apollo/config.c         |   7 --
 arch/m68k/atari/ataints.c         |   4 +-
 arch/m68k/atari/config.c          |   2 -
 arch/m68k/atari/time.c            |  65 +++++++++----
 arch/m68k/bvme6000/config.c       |  70 +++++++++-----
 arch/m68k/hp300/config.c          |   1 -
 arch/m68k/hp300/time.c            |  29 ++----
 arch/m68k/hp300/time.h            |   1 -
 arch/m68k/include/asm/macints.h   |   3 -
 arch/m68k/include/asm/mvme147hw.h |   2 +-
 arch/m68k/mac/config.c            |   3 -
 arch/m68k/mac/via.c               | 150 ++++++++++++++++++++----------
 arch/m68k/mvme147/config.c        |  73 ++++++++++-----
 arch/m68k/mvme16x/config.c        |  97 +++++++++++++------
 arch/m68k/q40/config.c            |   9 --
 arch/m68k/q40/q40ints.c           |   7 +-
 arch/m68k/sun3/config.c           |   2 -
 arch/m68k/sun3/intersil.c         |   7 --
 arch/m68k/sun3/sun3ints.c         |   3 +
 arch/m68k/sun3x/config.c          |   1 -
 arch/m68k/sun3x/time.c            |  21 ++---
 arch/m68k/sun3x/time.h            |   1 -
 25 files changed, 387 insertions(+), 228 deletions(-)

-- 
2.18.1

