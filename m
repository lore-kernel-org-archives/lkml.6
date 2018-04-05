Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDEMsO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:48:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:48:12 -0400
Date: Thu, 5 Apr 2018 14:47:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 10/10] cpuidle: menu: Avoid selecting shallow states
 with stopped tick
Message-ID: <20180405124757.GQ4082@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <6542020.eHGLEK9V0J@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6542020.eHGLEK9V0J@aspire.rjw.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:50:36AM +0200, Rafael J. Wysocki wrote:
> +	if (tick_nohz_tick_stopped()) {
> +		/*
> +		 * If the tick is already stopped, the cost of possible short
> +		 * idle duration misprediction is much higher, because the CPU
> +		 * may be stuck in a shallow idle state for a long time as a
> +		 * result of it.  In that case say we might mispredict and try
> +		 * to force the CPU into a state for which we would have stopped
> +		 * the tick, unless the tick timer is going to expire really
> +		 * soon anyway.

Wait what; the tick was stopped, therefore it _cannot_ expire soon.

*confused*

Did you mean s/tick/a/ ?

> +		 */
> +		if (data->predicted_us < TICK_USEC)
> +			data->predicted_us = min_t(unsigned int, TICK_USEC,
> +						   ktime_to_us(delta_next));
> +	} else {
> +		/*
> +		 * Use the performance multiplier and the user-configurable
> +		 * latency_req to determine the maximum exit latency.
> +		 */
> +		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> +		if (latency_req > interactivity_req)
> +			latency_req = interactivity_req;
> +	}
>  
>  	expected_interval = data->predicted_us;
>  	/*
> 
