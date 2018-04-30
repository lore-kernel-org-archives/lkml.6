Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeD3KEz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:04:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeD3KEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:49 -0400
Message-Id: <20180430100008.503783478@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH v2 0/7] Various tsc/clocksource fixes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are the result of the regression Diego reported against commit:

  aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")

His Core2 triggers mark_tsc_unstable() while we're running with tsc-early,
which then results in us failing to unregister the clocksource.

Furthermore, since mark_tsc_unstable() only looks at the regular tsc
clocksource, we don't even mark tsc_early UNSTABLE or de-rate it, resulting in
it actually staying a desirable clocksource.

Fixing that is a little more tricky; albeit far less critical after we
guarantee to unregister tsc-early.

Please consider these for /urgent. I've used both Fixes and stable tags
on a bunch of them because the above commit is already in v4.16 and
would need stable help.

These patches have been tested on both a Core2 and an IVB. On IVB I've both
changed intel_idle to always report the TSC unstable and mucked about with the
TSC msr from userspace to tickle the watchdog paths.

---
Changes since v1

 - fix __clocksource_change_rating() locking
 - removed work->kthread->watchdog hoops
 - fixed up comment
