Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeDWQnb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:43:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeDWQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:43:30 -0400
Date: Mon, 23 Apr 2018 18:43:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rjw@rjwysocki.net, rui.zhang@intel.com
Subject: Re: [PATCH 2/5] clocksource: Allow clocksource_mark_unstable() on
 unregisered clocksources
Message-ID: <20180423164325.GR4129@hirez.programming.kicks-ass.net>
References: <20180423161648.622657048@infradead.org>
 <20180423162642.059848458@infradead.org>
 <20180423164113.GN4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423164113.GN4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 06:41:13PM +0200, Peter Zijlstra wrote:
> I've no idea why it says it cannot do that with the lock held. But
> there's more stale comments in there.

Like that one, the x86 tsc code is the only caller of this. I could not
find anything hotplug.

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -173,10 +173,8 @@ static void __clocksource_unstable(struc
  * clocksource_mark_unstable - mark clocksource unstable via watchdog
  * @cs:		clocksource to be marked unstable
  *
- * This function is called instead of clocksource_change_rating from
- * cpu hotplug code to avoid a deadlock between the clocksource mutex
- * and the cpu hotplug mutex. It defers the update of the clocksource
- * to the watchdog thread.
+ * This function is called by the x86 TSC code to mark clocksources as unstable;
+ * it defers demotion and re-selection to a kthread.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
