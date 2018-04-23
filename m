Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755609AbeDWQlV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:41:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54038 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755177AbeDWQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:41:19 -0400
Date: Mon, 23 Apr 2018 18:41:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rjw@rjwysocki.net, rui.zhang@intel.com
Subject: Re: [PATCH 2/5] clocksource: Allow clocksource_mark_unstable() on
 unregisered clocksources
Message-ID: <20180423164113.GN4082@hirez.programming.kicks-ass.net>
References: <20180423161648.622657048@infradead.org>
 <20180423162642.059848458@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423162642.059848458@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 06:16:50PM +0200, Peter Zijlstra wrote:
> Because of how we flip between tsc-early and tsc clocksources we might
> need to mark one or both unstable. The current code in
> mark_tsc_unstable() only worked because we registered the tsc
> clocksource once and then never touched it.
> 
> Since we now unregister the tsc-early clocksource, we need to know if
> a clocksource got unregistered and the current cs->mult test doesn't
> work for that. Instead use list_empty(&cs->list) to test for
> registration.
> 
> Furthermore, since clocksource_mark_unstable() needs to place the cs
> on the wd_list, it links the cs->list and cs->wd_list serialization.
> We must not see a clocsource registered (!empty cs->list) but already
> past dequeue_watchdog(). So place {en,de}queue{,_watchdog}() under the
> same lock.
> 
> This then allows us to unconditionally use
> clocksource_mark_unstable(), regardless of the registration state.
> 

I think we also want the below patch, either merged in or on top.
Because __clocksource_change_rating() actually requires holding that
lock now.

I've no idea why it says it cannot do that with the lock held. But
there's more stale comments in there.

I'll actually test it later, need to head out to the Dojo soon.


--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -405,14 +405,13 @@ static int __clocksource_watchdog_kthrea
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
-	LIST_HEAD(unstable);
 	int select = 0;
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
-			list_add(&cs->wd_list, &unstable);
+			__clocksource_change_rating(cs, 0);
 			select = 1;
 		}
 		if (cs->flags & CLOCK_SOURCE_RESELECT) {
@@ -424,11 +423,6 @@ static int __clocksource_watchdog_kthrea
 	clocksource_stop_watchdog();
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 
-	/* Needs to be done outside of watchdog lock */
-	list_for_each_entry_safe(cs, tmp, &unstable, wd_list) {
-		list_del_init(&cs->wd_list);
-		__clocksource_change_rating(cs, 0);
-	}
 	return select;
 }
 
