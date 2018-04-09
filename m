Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeDICl7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932446AbeDICl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:41:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2403420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Mon, 9 Apr 2018 04:41:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 08/10] sched: idle: Select idle state before stopping
 the tick
Message-ID: <20180409024150.GB21904@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <13248276.RivpnYp3Yv@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13248276.RivpnYp3Yv@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:47:06AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to address the issue with short idle duration predictions
> by the idle governor after the scheduler tick has been stopped,
> reorder the code in cpuidle_idle_call() so that the governor idle
> state selection runs before tick_nohz_idle_go_idle() and use the
> "nohz" hint returned by cpuidle_select() to decide whether or not
> to stop the tick.
> 
> This isn't straightforward, because menu_select() invokes
> tick_nohz_get_sleep_length() to get the time to the next timer
> event and the number returned by the latter comes from
> __tick_nohz_idle_stop_tick().  Fortunately, however, it is possible
> to compute that number without actually stopping the tick and with
> the help of the existing code.
> 
> Namely, tick_nohz_get_sleep_length() can be made call
> tick_nohz_next_event(), introduced earlier, to get the time to the
> next non-highres timer event.  If that happens, tick_nohz_next_event()
> need not be called by __tick_nohz_idle_stop_tick() again.
> 
> If it turns out that the scheduler tick cannot be stopped going
> forward or the next timer event is too close for the tick to be
> stopped, tick_nohz_get_sleep_length() can simply return the time to
> the next event currently programmed into the corresponding clock
> event device.
> 
> In addition to knowing the return value of tick_nohz_next_event(),
> however, tick_nohz_get_sleep_length() needs to know the time to the
> next highres timer event, but with the scheduler tick timer excluded,
> which can be computed with the help of hrtimer_get_next_event().
> 
> That minimum of that number and the tick_nohz_next_event() return
> value is the total time to the next timer event with the assumption
> that the tick will be stopped.  It can be returned to the idle
> governor which can use it for predicting idle duration (under the
> assumption that the tick will be stopped) and deciding whether or
> not it makes sense to stop the tick before putting the CPU into the
> selected idle state.
> 
> With the above, the sleep_length field in struct tick_sched is not
> necessary any more, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
