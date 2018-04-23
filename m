Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeDWQoe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:44:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbeDWQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:44:29 -0400
Date: Mon, 23 Apr 2018 18:44:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Diego Viola <diego.viola@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
Message-ID: <20180423164425.GS4129@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net>
 <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
 <20180423114850.GK4082@hirez.programming.kicks-ass.net>
 <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com>
 <20180423123847.GL4082@hirez.programming.kicks-ass.net>
 <20180423155801.GQ4129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423155801.GQ4129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:58:01PM +0200, Peter Zijlstra wrote:
> Thomas, we could not find the de-rate stuff, but the above can be
> simplified; what happens is:
> 
> 	cs->flags |= UNSTABLE;
> 	schedule_work(&watchdog_work)
> 	  kthread_run(clocksource_watchdog_kthread)

Also, Thomas, do you remember why we spawn a short running kthread from
a work ? Can't we simply run the whole thing from the worker thread?

> 	    __clocksource_watchdog_kthread()
> 	      if (cs->flags & UNSTABLE)
> 	        __clocksource_change_rating()
> 	   clocksource_select()
> 
