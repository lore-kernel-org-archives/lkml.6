Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCSMse (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:48:34 -0400
Received: from mailout6.zih.tu-dresden.de ([141.30.67.75]:48162 "EHLO
        mailout6.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932300AbeCSMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:48:29 -0400
Subject: Re: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states
 with stopped tick
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, "Rik van Riel" <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Mike Galbraith" <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
 <2148754.TY7qXgFyZy@aspire.rjw.lan>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Message-ID: <abc9a820-3d67-3269-f1c2-bb205c97763b@tu-dresden.de>
Date: Mon, 19 Mar 2018 13:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2148754.TY7qXgFyZy@aspire.rjw.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-TUD-Virus-Scanned: mailout6.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-15 23:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the scheduler tick has been stopped already and the governor
> selects a shallow idle state, the CPU can spend a long time in that
> state if the selection is based on an inaccurate prediction of idle
> time.  That effect turns out to be noticeable, so it needs to be
> mitigated.

What are some common causes for that situation?
How could I trigger this for testing?

> To that end, modify the menu governor to discard the result of the
> idle time prediction if the tick is stopped and the predicted idle
> time is less than the tick period length, unless the tick timer is
> going to expire soon.

This seems dangerous. Using a C-state that is too deep could be
problematic for soft latency, caches and overall energy.

Would it be viable to re-enable the sched tick to act as a fallback?
Generally, would it be feasible to modify the upcoming sched tick
timer to be a better time for a fallback wakeup in certain situations?

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v4 -> v5:
>    * Rebase on top of the new [1-6/7].
>    * Never use the interactivity factor when the tick is stopped.
> 
> ---
>   drivers/cpuidle/governors/menu.c |   29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -353,13 +353,28 @@ static int menu_select(struct cpuidle_dr
>   	 */
>   	data->predicted_us = min(data->predicted_us, expected_interval);
>   
> -	/*
> -	 * Use the performance multiplier and the user-configurable
> -	 * latency_req to determine the maximum exit latency.
> -	 */
> -	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> -	if (latency_req > interactivity_req)
> -		latency_req = interactivity_req;
> +	if (tick_nohz_tick_stopped()) {
> +		/*
> +		 * If the tick is already stopped, the cost of possible short
> +		 * idle duration misprediction is much higher, because the CPU
> +		 * may be stuck in a shallow idle state for a long time as a
> +		 * result of it.  In that case say we might mispredict and try
> +		 * to force the CPU into a state for which we would have stopped
> +		 * the tick, unless the tick timer is going to expire really
> +		 * soon anyway.
> +		 */
> +		if (data->predicted_us < TICK_USEC_HZ)
> +			data->predicted_us = min_t(unsigned int, TICK_USEC_HZ,
> +						   ktime_to_us(tick_time));

This applies to the heuristic (expected_interval) and the (heuristically
corrected) next timer. Should this modification be applied only to the
expected_interval under the assumption that the next_timer_us * correction
is never totally wrong.

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
>   	expected_interval = data->predicted_us;
>   	/*
> 
