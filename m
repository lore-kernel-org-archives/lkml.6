Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeDFH7N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:59:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeDFH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:59:11 -0400
Date: Fri, 6 Apr 2018 09:58:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 05/10] cpuidle: Return nohz hint from cpuidle_select()
Message-ID: <20180406075837.GH4082@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <5818594.T4StF86Hkt@aspire.rjw.lan>
 <20180406024413.GB4400@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406024413.GB4400@lerouge>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:44:14AM +0200, Frederic Weisbecker wrote:
> You can move that to tick_sched_do_timer() to avoid code duplication.

I expect the reason I didn't was that it didn't have @ts, but that's
easily fixable.

> Also these constants are very opaque. And even with proper symbols it wouldn't look
> right to extend ts->inidle that way.
> 
> Perhaps you should add a field such as ts->got_idle_tick under the boolean fields
> after the below patch:

> @@ -45,14 +45,17 @@ struct tick_sched {
>  	struct hrtimer			sched_timer;
>  	unsigned long			check_clocks;
>  	enum tick_nohz_mode		nohz_mode;
> +
> +	unsigned int			inidle		: 1;
> +	unsigned int			tick_stopped	: 1;
> +	unsigned int			idle_active	: 1;
> +	unsigned int			do_timer_last	: 1;

That would generate worse code, but yes, the C might be prettier.
