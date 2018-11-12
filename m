Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ED7214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ED7214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeKLOiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:38:22 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48552 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeKLOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:38:22 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 69CB5297D9; Sun, 11 Nov 2018 23:46:55 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1541995959.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC PATCH 00/13] m68k: Drop arch_gettimeoffset and adopt clocksource API
Date:   Mon, 12 Nov 2018 15:12:39 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes "select ARCH_USES_GETTIMEOFFSET" from arch/m68k
and converts users of arch_gettimeoffset to the clocksource API.
Various bugs are fixed along the way.

Those platforms which do not actually implement arch_gettimeoffset
(apollo, q40, sun3, sun3x) use the "jiffies" clocksource by default.

More testing and code review would be appreciated.


Finn Thain (13):
  arm: Fix mutual exclusion in arch_gettimeoffset
  m68k: Fix mutual exclusion in arch_gettimeoffset
  m68k: mac: Fix VIA timer counter accesses
  m68k: mac: Clean up unused timer definitions
  m68k: apollo, q40, sun3, sun3x: Remove arch_gettimeoffset
    implementations
  m68k: Drop ARCH_USES_GETTIMEOFFSET
  m68k: amiga: Convert to clocksource API
  m68k: atari: Convert to clocksource API
  m68k: bvme6000: Convert to clocksource API
  m68k: hp300: Convert to clocksource API
  m68k: mac: Convert to clocksource API
  m68k: mvme147: Convert to clocksource API
  m68k: mvme16x: Convert to clocksource API

 arch/arm/mach-ebsa110/core.c      |   5 ++
 arch/arm/mach-rpc/time.c          |   5 ++
 arch/m68k/Kconfig                 |   1 -
 arch/m68k/amiga/config.c          |  47 +++++++---
 arch/m68k/apollo/config.c         |   7 --
 arch/m68k/atari/config.c          |   2 -
 arch/m68k/atari/time.c            |  45 ++++++++--
 arch/m68k/bvme6000/config.c       |  66 +++++++++-----
 arch/m68k/hp300/config.c          |   1 -
 arch/m68k/hp300/time.c            |  41 +++++++--
 arch/m68k/hp300/time.h            |   1 -
 arch/m68k/include/asm/macints.h   |   3 -
 arch/m68k/include/asm/mvme147hw.h |   1 -
 arch/m68k/mac/config.c            |  10 +--
 arch/m68k/mac/via.c               | 145 ++++++++++++++++++++----------
 arch/m68k/mvme147/config.c        |  51 ++++++++---
 arch/m68k/mvme16x/config.c        |  48 ++++++----
 arch/m68k/q40/config.c            |   9 --
 arch/m68k/sun3/config.c           |   2 -
 arch/m68k/sun3/intersil.c         |   7 --
 arch/m68k/sun3x/config.c          |   1 -
 arch/m68k/sun3x/time.c            |   5 --
 arch/m68k/sun3x/time.h            |   1 -
 23 files changed, 326 insertions(+), 178 deletions(-)

-- 
2.18.1

