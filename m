Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA48C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E2826B50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2826B50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965515AbeFZN2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:28:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965480AbeFZN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:28:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXo0k-0001PT-2h; Tue, 26 Jun 2018 15:27:58 +0200
Message-ID: <20180626132130.345959379@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 26 Jun 2018 15:21:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        air icy <icytxw@gmail.com>
Subject: [patch 0/2] posix-timers: Sanitize posix timer overrun handling
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Icy reported an UBSAN splat in the posix timer code, which is caused by the
way the overrun accounting works. Depending on interval and expiry time the
overrun can be larger than INT_MAX, but the accounting is int based which
basically makes the accounting values, which are visible to user space via
timer_getoverrrun(2) and siginfo::si_overrun, random.

The following series addresses this by converting the internal accounting
to 64bit and clamping the user space visible values to INT_MAX.

Thanks,

	tglx

8<-------------------
 b/include/linux/posix-timers.h |    4 ++--
 kernel/time/alarmtimer.c       |    4 ++--
 kernel/time/posix-cpu-timers.c |    2 +-
 kernel/time/posix-timers.c     |   33 +++++++++++++++++++++------------
 kernel/time/posix-timers.h     |    2 +-
 5 files changed, 27 insertions(+), 18 deletions(-)




