Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCNM7t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:59:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36882 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:59:47 -0400
Date: Wed, 14 Mar 2018 13:59:29 +0100
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v4 4/7] cpuidle: Return nohz hint from
 cpuidle_select()
Message-ID: <20180314125929.GU4043@hirez.programming.kicks-ass.net>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <15847301.VVmNzm1RNz@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15847301.VVmNzm1RNz@aspire.rjw.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:54:18AM +0100, Rafael J. Wysocki wrote:
> @@ -378,6 +384,26 @@ static int menu_select(struct cpuidle_dr
>  	if (idx == -1)
>  		idx = 0; /* No states enabled. Must use 0. */
>  
> +	if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
> +		*nohz_ret = false;
> +	} else if (drv->states[idx].target_residency < TICK_USEC_HZ) {
> +		first_idx = idx;
> +		for (i = idx + 1; i < drv->state_count; i++) {
> +			if (!drv->states[i].disabled &&
> +			    !dev->states_usage[i].disable) {
> +				first_idx = i;
> +				break;
> +			}
		}
> +
> +		/*
> +		 * Do not stop the tick if there is at least one more state
> +		 * within the tick period range that could be used if longer
> +		 * idle duration was predicted.
> +		 */
> +		*nohz_ret = !(first_idx > idx &&
> +			      drv->states[first_idx].target_residency < TICK_USEC_HZ);


Why though? That comment only states what it does, but gives no clue as
to why we're doing this. What was wrong with disabling NOHZ if the
selected state (@idx) has shorter target residency.


> +	}
> +
>  	data->last_state_idx = idx;
>  
>  	return data->last_state_idx;
> 
