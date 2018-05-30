Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeE3LY1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:24:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33287 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753088AbeE3LYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:22 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, keescook@chromium.org,
        "John Stultz" <john.stultz@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Christoph Hellwig" <hch@lst.de>,
        "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.793763804@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 050/153] hrtimer: Ensure POSIX compliance (relative
 CLOCK_REALTIME hrtimers)
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

commit 48d0c9becc7f3c66874c100c126459a9da0fdced upstream.

The POSIX specification defines that relative CLOCK_REALTIME timers are not
affected by clock modifications. Those timers have to use CLOCK_MONOTONIC
to ensure POSIX compliance.

The introduction of the additional HRTIMER_MODE_PINNED mode broke this
requirement for pinned timers.

There is no user space visible impact because user space timers are not
using pinned mode, but for consistency reasons this needs to be fixed.

Check whether the mode has the HRTIMER_MODE_REL bit set instead of
comparing with HRTIMER_MODE_ABS.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Fixes: 597d0275736d ("timers: Framework for identifying pinned timers")
Link: http://lkml.kernel.org/r/20171221104205.7269-7-anna-maria@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/hrtimer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1200,7 +1200,12 @@ static void __hrtimer_init(struct hrtime
 
 	cpu_base = &__raw_get_cpu_var(hrtimer_bases);
 
-	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_MODE_ABS)
+	/*
+	 * POSIX magic: Relative CLOCK_REALTIME timers are not affected by
+	 * clock modifications, so they needs to become CLOCK_MONOTONIC to
+	 * ensure POSIX compliance.
+	 */
+	if (clock_id == CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id = CLOCK_MONOTONIC;
 
 	base = hrtimer_clockid_to_base(clock_id);
