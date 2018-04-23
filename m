Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeDWPK7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:10:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755685AbeDWPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:10:41 -0400
Date: Mon, 23 Apr 2018 17:10:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Diego Viola <diego.viola@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
Message-ID: <20180423151035.GP4129@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net>
 <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
 <20180423114850.GK4082@hirez.programming.kicks-ass.net>
 <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com>
 <20180423123847.GL4082@hirez.programming.kicks-ass.net>
 <20180423140052.GO4129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423140052.GO4129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 04:00:52PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 02:38:47PM +0200, Peter Zijlstra wrote:
> > @@ -834,8 +857,12 @@ static int clocksource_unbind(struct clocksource *cs)
> >  		if (curr_clocksource == cs)
> >  			return -EBUSY;
> >  	}
> > +
> > +	clocksource_watchdog_lock(&flags);
> >  	clocksource_dequeue_watchdog(cs);
> >  	list_del_init(&cs->list);
> > +	clocksource_watchdog_lock(&flags);
> 
> It works a lot better when this is _unlock();
> 
> > +
> >  	return 0;
> >  }
> >  
> 
> With that, and intel_idle.c modified to always issue the "halts in
> idle" thing, my IVB comes up in hpet mode. Let me dig up a Core2 era
> machine and see if that works too.

OK, that was fairly painful, but the box managed to boot a modified
kernel and seems to function correctly, lemme try suspend/resume.
