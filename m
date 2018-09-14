Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF7ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4128220881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4128220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeINSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:06:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeINSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:06:20 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nZk-0005vn-BM; Fri, 14 Sep 2018 14:51:56 +0200
Message-Id: <20180914125006.349747096@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 14:50:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: [patch 00/11] x86/vdso: Cleanups,
 simmplifications and CLOCK_TAI support
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
implementation, which extended the clockid switch case and added yet
another slightly different copy of the same code.

Especially the extended switch case is problematic as the compiler tends to
generate a jump table which then requires to use retpolines. If jump tables
are disabled it adds yet another conditional to the existing maze.

This series takes a different approach by consolidating the almost
identical functions into one implementation for high resolution clocks and
one for the coarse grained clock ids by storing the base data for each
clock id in an array which is indexed by the clock id.

This completely eliminates the switch case and allows further
simplifications of the code base, which at the end all together gain a few
cycles performance or at least stay on par with todays code. The resulting
performance depends heavily on the micro architecture and the compiler.

Thanks,

	tglx

8<-------------------
 arch/x86/Kconfig                        |    1 
 arch/x86/entry/vdso/vclock_gettime.c    |  199 ++++++++------------------------
 arch/x86/entry/vsyscall/vsyscall_gtod.c |   55 ++++----
 arch/x86/include/asm/vgtod.h            |   46 ++++---
 arch/x86/kernel/time.c                  |   22 +++
 include/linux/clocksource.h             |    5 
 kernel/time/Kconfig                     |    4 
 kernel/time/clocksource.c               |    2 
 8 files changed, 144 insertions(+), 190 deletions(-)

